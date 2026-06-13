---自动生成代码----start----
local AttrTextView = BaseClass( 'AttrTextView' , BaseView )
local M = AttrTextView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.label = self:AddBaseCom( GameUIText ,'label')
  self.value = self:AddBaseCom( GameUIText ,'value')


end

return AttrTextView
---自动生成代码----end----