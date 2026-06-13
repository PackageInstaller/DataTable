---自动生成代码----start----
local UIVotingGetMoreView = BaseClass( 'UIVotingGetMoreView' , BaseView )
local M = UIVotingGetMoreView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnClose = self:AddBaseCom( GameUIImage ,'btnClose')
  self.List = self:AddBaseCom( CircularScrollView ,'List')


end

return UIVotingGetMoreView
---自动生成代码----end----