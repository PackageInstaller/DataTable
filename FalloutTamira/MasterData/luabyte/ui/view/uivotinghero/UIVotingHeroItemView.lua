---自动生成代码----start----
local UIVotingHeroItemView = BaseClass( 'UIVotingHeroItemView' , BaseView )
local M = UIVotingHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.textName = self:AddBaseCom( GameUIText ,'textName')
  self.textNum = self:AddBaseCom( GameUIText ,'textNum')


end

return UIVotingHeroItemView
---自动生成代码----end----