---自动生成代码----start----
local UIDanceItemView = BaseClass( 'UIDanceItemView' , BaseView )
local M = UIDanceItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.state =   self._binder:GetValue('state')  


end

return UIDanceItemView
---自动生成代码----end----