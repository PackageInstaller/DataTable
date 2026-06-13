---自动生成代码----start----
local PassMainUIView = BaseClass( 'PassMainUIView' , BaseView )
local M = PassMainUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tabMain =   self._binder:GetValue('tabMain')  
  self.passMain =   self:AddValue('UI.Ctrl.Pass.PassRewardUICtrl','UI.View.Pass.PassRewardUIView','passMain')  
  self.passTask =   self:AddValue('UI.Ctrl.Pass.PassTaskCtrl','UI.View.Pass.PassTaskView','passTask')  
  self.passShop =   self:AddValue('UI.Ctrl.Pass.PassShopCtrl','UI.View.Pass.PassShopView','passShop')  
  self.txt_passLv = self:AddBaseCom( GameUIText ,'txt_passLv')
  self.slider_exp = self:AddBaseCom( UISlider ,'slider_exp')
  self.txt_expValue = self:AddBaseCom( GameUIText ,'txt_expValue')
  self.txt_remainTime = self:AddBaseCom( GameUIText ,'txt_remainTime')
  self.btn_buyLevel =   self._binder:GetValue('btn_buyLevel')  
  self.expState =   self._binder:GetValue('expState')  


end

return PassMainUIView
---自动生成代码----end----