---自动生成代码----start----
local UIShopConfirmView = BaseClass( 'UIShopConfirmView' , BaseView )
local M = UIShopConfirmView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labCost = self:AddBaseCom( GameUIText ,'labCost')
  self.labBuy = self:AddBaseCom( GameUIText ,'labBuy')
  self.labMaxNum = self:AddBaseCom( GameUIText ,'labMaxNum')
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.btn_cancle =   self._binder:GetValue('btn_cancle')  
  self.btnOK = self:AddBaseCom( UINewButton ,'btnOK')
  self.btnTips = self:AddBaseCom( UIButton ,'btnTips')
  self.btnMask =   self._binder:GetValue('btnMask')  
  self.txt_minNum = self:AddBaseCom( GameUIText ,'txt_minNum')
  self.imgCost = self:AddBaseCom( GameUIImage ,'imgCost')
  self.labRemain = self:AddBaseCom( GameUIText ,'labRemain')
  self.img_huobi = self:AddBaseCom( GameUIImage ,'img_huobi')
  self.PropertyBar =   self._binder:GetValue('PropertyBar')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.txt_not = self:AddBaseCom( GameUIText ,'txt_not')
  self.labDes = self:AddBaseCom( GameUIText ,'labDes')
  self.ComNumSliderCtrl =   self:AddValue('UI.Ctrl.Common.ComNumSliderCtrl','UI.View.Common.ComNumSliderView','ComNumSliderCtrl')  


end

return UIShopConfirmView
---自动生成代码----end----