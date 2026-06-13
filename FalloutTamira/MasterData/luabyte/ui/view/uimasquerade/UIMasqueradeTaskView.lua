---自动生成代码----start----
local UIMasqueradeTaskView = BaseClass( 'UIMasqueradeTaskView' , BaseView )
local M = UIMasqueradeTaskView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnBack = self:AddBaseCom( UINewButton ,'btnBack')
  self.baseTab =   self._binder:GetValue('baseTab')  
  self.tfTask =   self._binder:GetValue('tfTask')  
  self.tfAchieve =   self._binder:GetValue('tfAchieve')  
  self.UIDanceTaskItemCtrl =   self:AddValue('UI.Ctrl.UIMasquerade.UIDanceTaskItemCtrl','UI.View.UIMasquerade.UIDanceTaskItemView','UIDanceTaskItemCtrl')  
  self.UIDanceAchieveItemCtrl =   self:AddValue('UI.Ctrl.UIMasquerade.UIDanceAchieveItemCtrl','UI.View.UIMasquerade.UIDanceAchieveItemView','UIDanceAchieveItemCtrl')  
  self.barText = self:AddBaseCom( GameUIText ,'barText')
  self.bar =   self._binder:GetValue('bar')  
  self.barValue = self:AddBaseCom( GameUIText ,'barValue')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.btnGetAll = self:AddBaseCom( UIButton ,'btnGetAll')


end

return UIMasqueradeTaskView
---自动生成代码----end----