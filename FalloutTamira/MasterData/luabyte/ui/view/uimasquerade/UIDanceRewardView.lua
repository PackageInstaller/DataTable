---自动生成代码----start----
local UIDanceRewardView = BaseClass( 'UIDanceRewardView' , BaseView )
local M = UIDanceRewardView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.UIDanceItemCtrl =   self:AddValue('UI.Ctrl.UIMasquerade.UIDanceItemCtrl','UI.View.UIMasquerade.UIDanceItemView','UIDanceItemCtrl')  
  self.state =   self._binder:GetValue('state')  
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.stateReward =   self._binder:GetValue('stateReward')  
  self.btnReward = self:AddBaseCom( UINewButton ,'btnReward')


end

return UIDanceRewardView
---自动生成代码----end----