---自动生成代码----start----
local UIRoleSkillUpView = BaseClass( 'UIRoleSkillUpView' , BaseView )
local M = UIRoleSkillUpView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')
  self.labLv1 = self:AddBaseCom( GameUIText ,'labLv1')
  self.labLv2 = self:AddBaseCom( GameUIText ,'labLv2')
  self.btnOk =   self._binder:GetValue('btnOk')  
  self.btnCancel =   self._binder:GetValue('btnCancel')  
  self.ItemPfbView =   self:AddValue('','UI.View.Common.ItemPfbView','ItemPfbView')  
  self.btnState =   self._binder:GetValue('btnState')  
  self.labLock = self:AddBaseCom( GameUIText ,'labLock')
  self.ComItemSlipCtrl =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','ComItemSlipCtrl')  


end

return UIRoleSkillUpView
---自动生成代码----end----