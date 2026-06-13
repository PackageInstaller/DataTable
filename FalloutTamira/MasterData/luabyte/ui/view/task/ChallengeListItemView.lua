---自动生成代码----start----
local ChallengeListItemView = BaseClass( 'ChallengeListItemView' , BaseView )
local M = ChallengeListItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.rectDoing =   self._binder:GetValue('rectDoing')  
  self.rectMissionComplete =   self._binder:GetValue('rectMissionComplete')  
  self.rectTaskComplete =   self._binder:GetValue('rectTaskComplete')  
  self.rectClickArea =   self._binder:GetValue('rectClickArea')  
  self.item =   self._binder:GetValue('item')  
  self.rectTask =   self._binder:GetValue('rectTask')  


end

return ChallengeListItemView
---自动生成代码----end----