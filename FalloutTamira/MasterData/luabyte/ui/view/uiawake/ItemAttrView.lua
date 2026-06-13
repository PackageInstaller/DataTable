---自动生成代码----start----
local ItemAttrView = BaseClass( 'ItemAttrView' , BaseView )
local M = ItemAttrView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labDesc = self:AddBaseCom( GameUIText ,'labDesc')
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.state =   self._binder:GetValue('state')  


end

return ItemAttrView
---自动生成代码----end----