---自动生成代码----start----
local UIVotingItemView = BaseClass( 'UIVotingItemView' , BaseView )
local M = UIVotingItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.TextTime = self:AddBaseCom( GameUIText ,'TextTime')
  self.goEnd =   self._binder:GetValue('goEnd')  
  self.goLock1 =   self._binder:GetValue('goLock1')  
  self.goLock2 =   self._binder:GetValue('goLock2')  
  self.goTime = self:AddBaseCom( GameUIImage ,'goTime')
  self.imageNormal = self:AddBaseCom( GameUIImage ,'imageNormal')
  self.tfNormal =   self._binder:GetValue('tfNormal')  


end

return UIVotingItemView
---自动生成代码----end----