---自动生成代码----start----
local RoleSkillTitleView = BaseClass( 'RoleSkillTitleView' , BaseView )
local M = RoleSkillTitleView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.chTitle = self:AddBaseCom( GameUIText ,'chTitle')
  self.enTitle = self:AddBaseCom( GameUIText ,'enTitle')


end

return RoleSkillTitleView
---自动生成代码----end----