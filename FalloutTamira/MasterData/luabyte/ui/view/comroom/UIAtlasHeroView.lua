---自动生成代码----start----
local UIAtlasHeroView = BaseClass( 'UIAtlasHeroView' , BaseView )
local M = UIAtlasHeroView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.imgHead = self:AddBaseCom( GameUIImage ,'imgHead')
  self.uiState = self._binder:GetValue('uiState')  


end

return UIAtlasHeroView
---自动生成代码----end----