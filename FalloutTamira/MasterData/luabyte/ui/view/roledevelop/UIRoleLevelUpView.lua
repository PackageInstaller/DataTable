---自动生成代码----start----
local UIRoleLevelUpView = BaseClass( 'UIRoleLevelUpView' , BaseView )
local M = UIRoleLevelUpView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labLv = self:AddBaseCom( GameUIText ,'labLv')
  self.labMaxLv = self:AddBaseCom( GameUIText ,'labMaxLv')
  self.UIBreakCtrl =   self:AddValue('UI.Ctrl.UITeamConfig.UIBreakCtrl','UI.View.UITeamConfig.UIBreakView','UIBreakCtrl')  
  self.slider = self:AddBaseCom( UINewSlider ,'slider')
  self.labCoin = self:AddBaseCom( GameUIText ,'labCoin')
  self.btnCoin =   self._binder:GetValue('btnCoin')  
  self.costItem =   self._binder:GetValue('costItem')  
  self.costContent =   self._binder:GetValue('costContent')  
  self.Attr1 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAttrCtrl','UI.View.RoleDevelop.UIAttrView','Attr1')  
  self.Attr2 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAttrCtrl','UI.View.RoleDevelop.UIAttrView','Attr2')  
  self.Attr3 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAttrCtrl','UI.View.RoleDevelop.UIAttrView','Attr3')  
  self.Attr4 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAttrCtrl','UI.View.RoleDevelop.UIAttrView','Attr4')  
  self.Attr5 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAttrCtrl','UI.View.RoleDevelop.UIAttrView','Attr5')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.btnlvUp = self:AddBaseCom( UIButton ,'btnlvUp')
  self.stateBtn =   self._binder:GetValue('stateBtn')  
  self.labHistory = self:AddBaseCom( GameUIText ,'labHistory')
  self.labTargetLv = self:AddBaseCom( GameUIText ,'labTargetLv')
  self.lvState =   self._binder:GetValue('lvState')  
  self.costState =   self._binder:GetValue('costState')  
  self.labMaxLv2 = self:AddBaseCom( GameUIText ,'labMaxLv2')
  self.tfUpTips =   self._binder:GetValue('tfUpTips')  
  self.labBtn = self:AddBaseCom( GameUIText ,'labBtn')
  self.tfHand =   self._binder:GetValue('tfHand')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.imgQuality = self:AddBaseCom( GameUIImage ,'imgQuality')


end

return UIRoleLevelUpView
---自动生成代码----end----