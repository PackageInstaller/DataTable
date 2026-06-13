---自动生成代码----start----
local JourneyHeroItemView = BaseClass( 'JourneyHeroItemView' , BaseView )
local M = JourneyHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.heroAdd =   self._binder:GetValue('heroAdd')  
  self.heroIcon = self:AddBaseCom( GameUIImage ,'heroIcon')
  self.onGoing =   self._binder:GetValue('onGoing')  
  self.HeroHeadItem =   self._binder:GetValue('HeroHeadItem')  


end

return JourneyHeroItemView
---自动生成代码----end----