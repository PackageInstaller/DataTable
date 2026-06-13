---自动生成代码----start----
local UIDanceTaskItemView = BaseClass( 'UIDanceTaskItemView' , BaseView )
local M = UIDanceTaskItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnGoTo = self:AddBaseCom( UINewButton ,'btnGoTo')
  self.UIDanceItemCtrl =   self:AddValue('UI.Ctrl.UIMasquerade.UIDanceItemCtrl','UI.View.UIMasquerade.UIDanceItemView','UIDanceItemCtrl')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.scrollbar =   self._binder:GetValue('scrollbar')  
  self.state =   self._binder:GetValue('state')  
  self.btnReward = self:AddBaseCom( UINewButton ,'btnReward')


end

return UIDanceTaskItemView
---自动生成代码----end----