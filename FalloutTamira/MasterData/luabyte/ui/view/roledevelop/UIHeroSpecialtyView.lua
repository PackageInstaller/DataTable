---自动生成代码----start----
local UIHeroSpecialtyView = BaseClass( 'UIHeroSpecialtyView' , BaseView )
local M = UIHeroSpecialtyView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcom = self:AddBaseCom( GameUIImage ,'imgIcom')
  self.labSpecialty = self:AddBaseCom( GameUIText ,'labSpecialty')


end

return UIHeroSpecialtyView
---自动生成代码----end----