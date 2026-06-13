---自动生成代码----start----
local ItemPfbView = BaseClass( 'ItemPfbView' , BaseView )
local M = ItemPfbView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  


end

return ItemPfbView
---自动生成代码----end----