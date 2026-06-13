---自动生成代码----start----
local FriendUIView = BaseClass( 'FriendUIView' , BaseView )
local M = FriendUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.info =   self:AddValue('UI.Ctrl.Friend.PageMyDescCtrl','UI.View.Friend.PageMyInfoView','info')  
  self.friend =   self:AddValue('UI.Ctrl.Friend.PageListCtrl','UI.View.Friend.PageListView','friend')  
  self.apply =   self:AddValue('UI.Ctrl.Friend.PageApplyCtrl','UI.View.Friend.PageApplyView','apply')  
  self.add =   self:AddValue('UI.Ctrl.Friend.PageAddCtrl','UI.View.Friend.PageAddView','add')  
  self.infoSelect =   self._binder:GetValue('infoSelect')  
  self.friendSelect =   self._binder:GetValue('friendSelect')  
  self.applySelect =   self._binder:GetValue('applySelect')  
  self.addSelect =   self._binder:GetValue('addSelect')  
  self.infoUnSelect =   self._binder:GetValue('infoUnSelect')  
  self.friendUnSelect =   self._binder:GetValue('friendUnSelect')  
  self.applyUnSelect =   self._binder:GetValue('applyUnSelect')  
  self.addUnSelect =   self._binder:GetValue('addUnSelect')  
  self.upUnSelect =   self._binder:GetValue('upUnSelect')  
  self.upSelect =   self._binder:GetValue('upSelect')  
  self.up =   self:AddValue('UI.Ctrl.Friend.PageHeroUpCtrl','UI.View.Friend.PageHeroUpView','up')  


end

return FriendUIView
---自动生成代码----end----