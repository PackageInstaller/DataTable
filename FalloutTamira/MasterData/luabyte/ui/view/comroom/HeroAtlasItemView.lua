---自动生成代码----start----
local HeroAtlasItemView = BaseClass( 'HeroAtlasItemView' , BaseView )
local M = HeroAtlasItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stateLock =   self._binder:GetValue('stateLock')  
  self.stateRare =   self._binder:GetValue('stateRare')  
  self.stateFaction =   self._binder:GetValue('stateFaction')  
  self.imgHero = self:AddBaseCom( GameUIImage ,'imgHero')
  self.txtHero = self:AddBaseCom( GameUIText ,'txtHero')
  self.imgProfession = self:AddBaseCom( GameUIImage ,'imgProfession')
  self.tfState =   self._binder:GetValue('tfState')  
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return HeroAtlasItemView
---自动生成代码----end----