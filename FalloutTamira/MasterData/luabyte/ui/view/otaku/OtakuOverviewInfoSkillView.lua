---自动生成代码----start----
local OtakuOverviewInfoSkillView = BaseClass( 'OtakuOverviewInfoSkillView' , BaseView )
local M = OtakuOverviewInfoSkillView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.headImg = self:AddBaseCom( GameUIImage ,'headImg')
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.descText = self:AddBaseCom( GameUIText ,'descText')


end

return OtakuOverviewInfoSkillView
---自动生成代码----end----