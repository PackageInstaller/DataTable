---自动生成代码----start----
local UIVotingEight1ItemView = BaseClass( 'UIVotingEight1ItemView' , BaseView )
local M = UIVotingEight1ItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.textName = self:AddBaseCom( GameUIText ,'textName')
  self.textNum = self:AddBaseCom( GameUIText ,'textNum')
  self.imageIcon = self:AddBaseCom( GameUIImage ,'imageIcon')
  self.btn =   self._binder:GetValue('btn')  


end

return UIVotingEight1ItemView
---自动生成代码----end----