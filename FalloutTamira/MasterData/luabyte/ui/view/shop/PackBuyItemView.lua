---自动生成代码----start----
local PackBuyItemView = BaseClass( 'PackBuyItemView' , BaseView )
local M = PackBuyItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.txtNum = self:AddBaseCom( GameUIText ,'txtNum')


end

return PackBuyItemView
---自动生成代码----end----