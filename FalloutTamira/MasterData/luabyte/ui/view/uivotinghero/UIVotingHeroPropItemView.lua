---自动生成代码----start----
local UIVotingHeroPropItemView = BaseClass( 'UIVotingHeroPropItemView' , BaseView )
local M = UIVotingHeroPropItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.textName = self:AddBaseCom( GameUIText ,'textName')
  self.textNum = self:AddBaseCom( GameUIText ,'textNum')


end

return UIVotingHeroPropItemView
---自动生成代码----end----