---自动生成代码----start----
local RoleGeneEffectItemView = BaseClass( 'RoleGeneEffectItemView' , BaseView )
local M = RoleGeneEffectItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.text = self:AddBaseCom( GameUIText ,'text')
  self.on = self:AddBaseCom( GameUIImage ,'on')


end

return RoleGeneEffectItemView
---自动生成代码----end----