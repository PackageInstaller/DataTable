---自动生成代码----start----
local BattleRoleView = BaseClass( 'BattleRoleView' , BaseView )
local M = BattleRoleView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.image = self:AddBaseCom( GameRawImage ,'image')
  self.text = self:AddBaseCom( GameUIText ,'text')
  self.awake = self:AddBaseCom( GameRawImage ,'awake')
  self.uiState =   self._binder:GetValue('uiState')  


end

return BattleRoleView
---自动生成代码----end----