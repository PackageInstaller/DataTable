---自动生成代码----start----
local UIVotingEight2ItemView = BaseClass( 'UIVotingEight2ItemView' , BaseView )
local M = UIVotingEight2ItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.textTicket = self:AddBaseCom( GameUIText ,'textTicket')
  self.textName = self:AddBaseCom( GameUIText ,'textName')
  self.imageIcon = self:AddBaseCom( GameUIImage ,'imageIcon')
  self.btnVote = self:AddBaseCom( UIButton ,'btnVote')


end

return UIVotingEight2ItemView
---自动生成代码----end----