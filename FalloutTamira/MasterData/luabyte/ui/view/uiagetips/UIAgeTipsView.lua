---自动生成代码----start----
local UIAgeTipsView = BaseClass( 'UIAgeTipsView' , BaseView )
local M = UIAgeTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labDesc = self:AddBaseCom( GameUIText ,'labDesc')
  self.btn = self:AddBaseCom( UINewButton ,'btn')
  self.labTitle = self:AddBaseCom( GameUIText ,'labTitle')


end

return UIAgeTipsView
---自动生成代码----end----