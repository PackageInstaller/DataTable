---自动生成代码----start----
local AwakeTaskView = BaseClass( 'AwakeTaskView' , BaseView )
local M = AwakeTaskView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.task1 =   self:AddValue('UI.Ctrl.RoleAwakeTask.AwakeTaskItemCtrl','UI.View.RoleAwakeTask.AwakeTaskItemView','task1')  
  self.task2 =   self:AddValue('UI.Ctrl.RoleAwakeTask.AwakeTaskItemCtrl','UI.View.RoleAwakeTask.AwakeTaskItemView','task2')  
  self.task3 =   self:AddValue('UI.Ctrl.RoleAwakeTask.AwakeTaskItemCtrl','UI.View.RoleAwakeTask.AwakeTaskItemView','task3')  
  self.task4 =   self:AddValue('UI.Ctrl.RoleAwakeTask.AwakeTaskItemCtrl','UI.View.RoleAwakeTask.AwakeTaskItemView','task4')  
  self.skillIcon = self:AddBaseCom( GameUIImage ,'skillIcon')
  self.skillName = self:AddBaseCom( GameUIText ,'skillName')
  self.skillDesc = self:AddBaseCom( GameUIText ,'skillDesc')
  self.unLockFrame =   self._binder:GetValue('unLockFrame')  


end

return AwakeTaskView
---自动生成代码----end----