---自动生成代码----start----
local AttrView = BaseClass( 'AttrView' , BaseView )
local M = AttrView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labDesc = self:AddBaseCom( GameUIText ,'labDesc')
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.bg = self:AddBaseCom( GameUIImage ,'bg')


end

return AttrView
---自动生成代码----end----