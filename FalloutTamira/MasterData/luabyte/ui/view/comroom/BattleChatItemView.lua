---自动生成代码----start----
local BattleChatItemView = BaseClass( 'BattleChatItemView' , BaseView )
local M = BattleChatItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgRoleAvatar = self:AddBaseCom( GameUIImage ,'imgRoleAvatar')
  self.txtRoleName = self:AddBaseCom( GameUIText ,'txtRoleName')
  self.rectRoleBattle =   self._binder:GetValue('rectRoleBattle')  


end

return BattleChatItemView
---自动生成代码----end----