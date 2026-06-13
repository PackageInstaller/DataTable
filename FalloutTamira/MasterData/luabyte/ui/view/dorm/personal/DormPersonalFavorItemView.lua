---自动生成代码----start----
local DormPersonalFavorItemView = BaseClass( 'DormPersonalFavorItemView' , BaseView )
local M = DormPersonalFavorItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_head = self:AddBaseCom( GameUIImage ,'img_head')
  self.txt_value = self:AddBaseCom( GameUIText ,'txt_value')


end

return DormPersonalFavorItemView
---自动生成代码----end----