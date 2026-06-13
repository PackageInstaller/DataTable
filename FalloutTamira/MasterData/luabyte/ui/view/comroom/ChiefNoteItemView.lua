---自动生成代码----start----
local ChiefNoteItemView = BaseClass( 'ChiefNoteItemView' , BaseView )
local M = ChiefNoteItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectItem =   self._binder:GetValue('rectItem')  
  self.txtItem = self:AddBaseCom( GameUIText ,'txtItem')
  self.txtUnlockContent = self:AddBaseCom( GameUIText ,'txtUnlockContent')
  self.stateItem =   self._binder:GetValue('stateItem')  
  self.stateContent =   self._binder:GetValue('stateContent')  
  self.txtLockContent = self:AddBaseCom( GameUIText ,'txtLockContent')
  self.anim =   self._binder:GetValue('anim')  
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return ChiefNoteItemView
---自动生成代码----end----