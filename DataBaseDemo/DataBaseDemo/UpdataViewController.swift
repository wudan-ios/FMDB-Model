//
//  UpdataViewController.swift
//  DataBaseDemo
//
//  Created by wudan on 2018/10/10.
//  Copyright © 2018 wudan. All rights reserved.
//

import UIKit

class UpdataViewController: UIViewController {
    
    
    @IBOutlet weak var name_TF: UITextField!
    @IBOutlet weak var phone_TF: UITextField!
    @IBOutlet weak var addres_TF: UITextField!
    public var model:Model?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "修改数据"
        name_TF.text = model!.name
        addres_TF.text = model!.addres
        phone_TF.text = model!.phone
    }


    @IBAction func updateTouched(_ sender: Any) {
        
        if (name_TF.text?.count)! == 0 || (phone_TF.text?.count)! == 0 || (addres_TF.text?.count)! == 0 {
            showHUD(content: "完善信息", completeBlock: nil)
            return
        }
        
        let model = Model()
        model.name = name_TF.text
        model.addres = addres_TF.text
        model.phone = phone_TF.text
        view.endEditing(true)
        
        WDDataBaseManager.defaultManger.update(model: model, uid: self.model!.wd_fmdb_id!, successBlock: {
            showHUD(content: "修改成功") {
                self.navigationController?.popViewController(animated: true)
            }
        }, failBlock: {
            showHUD(content: "修改失败", completeBlock: nil)
        })
    }
    
    func showHUD(content:String, completeBlock:(() -> Void)? = nil) {
        let alterController = UIAlertController.init(title: "温馨提示", message: content, preferredStyle: .alert)
        present(alterController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                alterController.dismiss(animated: true, completion: {
                    completeBlock!()
                })
            })
        }
    }
}