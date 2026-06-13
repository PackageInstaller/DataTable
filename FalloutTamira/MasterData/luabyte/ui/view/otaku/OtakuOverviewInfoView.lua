---自动生成代码----start----
local OtakuOverviewInfoView = BaseClass( 'OtakuOverviewInfoView' , BaseView )
local M = OtakuOverviewInfoView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.numText = self:AddBaseCom( GameUIText ,'numText')
  self.maxText = self:AddBaseCom( GameUIText ,'maxText')
  self.heroItem =   self:AddValue('','UI.View.Otaku.OtakuOverviewInfoHeroView','heroItem')  
  self.skillItem =   self:AddValue('','UI.View.Otaku.OtakuOverviewInfoSkillView','skillItem')  


end

return OtakuOverviewInfoView
---自动生成代码----end----