---自动生成代码----start----
local UIHeroItemView = BaseClass( 'UIHeroItemView' , BaseView )
local M = UIHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeadIcon = self:AddBaseCom( GameUIImage ,'HeadIcon')
  self.Name = self:AddBaseCom( GameUIText ,'Name')
  self.Quality = self:AddBaseCom( GameUIImage ,'Quality')
  self.labLevel = self:AddBaseCom( GameUIText ,'labLevel')
  self.btn = self:AddBaseCom( GameUIImage ,'btn')
  self.imgProfession = self:AddBaseCom( GameUIImage ,'imgProfession')


end

return UIHeroItemView
---自动生成代码----end----