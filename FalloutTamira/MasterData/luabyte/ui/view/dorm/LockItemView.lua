---自动生成代码----start----
local LockItemView = BaseClass( 'LockItemView' , BaseView )
local M = LockItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.DesText = self:AddBaseCom( GameUIText ,'DesText')
  self.Btn = self:AddBaseCom( GameUIImage ,'Btn')
  self.uiState =   self._binder:GetValue('uiState')  


end

return LockItemView
---自动生成代码----end----