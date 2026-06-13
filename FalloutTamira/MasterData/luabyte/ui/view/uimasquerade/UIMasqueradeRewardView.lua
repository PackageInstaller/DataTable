---自动生成代码----start----
local UIMasqueradeRewardView = BaseClass( 'UIMasqueradeRewardView' , BaseView )
local M = UIMasqueradeRewardView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnBack = self:AddBaseCom( UINewButton ,'btnBack')
  self.itemState1 =   self._binder:GetValue('itemState1')  
  self.itemState2 =   self._binder:GetValue('itemState2')  
  self.itemState3 =   self._binder:GetValue('itemState3')  
  self.itemState4 =   self._binder:GetValue('itemState4')  
  self.itemState5 =   self._binder:GetValue('itemState5')  
  self.UIDanceRewardCtrl1 =   self:AddValue('UI.Ctrl.UIMasquerade.UIDanceRewardCtrl','UI.View.UIMasquerade.UIDanceRewardView','UIDanceRewardCtrl1')  
  self.UIDanceRewardCtrl2 =   self:AddValue('UI.Ctrl.UIMasquerade.UIDanceRewardCtrl','UI.View.UIMasquerade.UIDanceRewardView','UIDanceRewardCtrl2')  
  self.UIDanceRewardCtrl3 =   self:AddValue('UI.Ctrl.UIMasquerade.UIDanceRewardCtrl','UI.View.UIMasquerade.UIDanceRewardView','UIDanceRewardCtrl3')  
  self.labTips = self:AddBaseCom( GameUIText ,'labTips')
  self.labNum1 = self:AddBaseCom( GameUIText ,'labNum1')
  self.labNum2 = self:AddBaseCom( GameUIText ,'labNum2')
  self.labNum3 = self:AddBaseCom( GameUIText ,'labNum3')
  self.labNum4 = self:AddBaseCom( GameUIText ,'labNum4')
  self.labNum5 = self:AddBaseCom( GameUIText ,'labNum5')


end

return UIMasqueradeRewardView
---自动生成代码----end----