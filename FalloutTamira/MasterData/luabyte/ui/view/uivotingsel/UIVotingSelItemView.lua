---自动生成代码----start----
local UIVotingSelItemView = BaseClass( 'UIVotingSelItemView' , BaseView )
local M = UIVotingSelItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.textName = self:AddBaseCom( GameUIText ,'textName')
  self.textNum = self:AddBaseCom( GameUIText ,'textNum')
  self.imageIcon = self:AddBaseCom( GameUIImage ,'imageIcon')
  self.btn = self:AddBaseCom( UIButton ,'btn')
  self.imageIndex = self:AddBaseCom( GameUIImage ,'imageIndex')
  self.imageIndexBg = self:AddBaseCom( GameUIImage ,'imageIndexBg')
  self.textIndex = self:AddBaseCom( GameUIText ,'textIndex')
  self.goBg =   self._binder:GetValue('goBg')  


end

return UIVotingSelItemView
---自动生成代码----end----