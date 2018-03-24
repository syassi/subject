//
//  ViewController.swift
//  Subject
//
//  Created by yasushi saitoh on 2018/03/24.
//  Copyright © 2018年 SunQ. All rights reserved.
//

import UIKit

class ViewController: SuperVC {
    
    @IBOutlet weak var editBtnView: UIView!
    @IBOutlet weak var startBtnView: UIView!
    @IBOutlet weak var newBtnView: UIView!
    
    
    // MARK: life Cycle
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        print("テスト")
    }
    
    
    // MARK: IBAction
    // TODO: テスト
    // FIXME: 最終的に直す
    // https://qiita.com/roworks/items/cd5cb05bd83585325db7
    
    @IBAction func memberRegistDisp(_ sender: AnyObject) {
        print("- memberRegistDisp -")
        createEntry(kind:.new)
    }
    
    @IBAction func startDisp(_ sender: AnyObject) {
        print("- startDisp -")
        createLogin()
    }
    
    @IBAction func editDisp(_ sender: AnyObject) {
        print("- editDisp -")
        createEntry(kind:.edit)
    }
    
    
    // MARK: private
    
    private func createEntry(kind:EntryKind) {
        
        let vc = StartVC.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        
        //デリゲート設定
        //        vc.delegate = self
        vc.kind = kind
        
        // コールバック処理
        vc.callbackReturnTapped = {(userName:String) -> Void in
            print("- callback - userName:\(userName)")
            self.setupUI()
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    private func createLogin() {
        
        let vc = LoginVC.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        
        //コールバック処理
        vc.callbackLogin = {[weak self] in
            print("- callbackLogin - ")
            
            self?.gotoSearchVC()
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    private func gotoSearchVC() {
        
        let vc = SearchTableVC.instantiate()
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /**
     画面セットアップ用
     
     */
    override func setupUI() {
        print("- setupUI -")
        
        guard let _ = Entry.getUserDefaultModel() else {
            newBtnView.isHidden = false
            editBtnView.isHidden = true
            startBtnView.isHidden = true
            return
        }
        
        newBtnView.isHidden = true
        editBtnView.isHidden = false
        startBtnView.isHidden = false
        
        
    }
}
