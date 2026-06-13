---自动生成代码----start----
local EncounterTitleView = BaseClass( 'EncounterTitleView' , BaseView )
local M = EncounterTitleView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_season = self:AddBaseCom( GameUIImage ,'img_season')
  self.img_cycleNum = self:AddBaseCom( GameUIImage ,'img_cycleNum')


end

return EncounterTitleView
---自动生成代码----end----