---自动生成代码----start----
local PicChatItemView = BaseClass( 'PicChatItemView' , BaseView )
local M = PicChatItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgRoleAvatar = self:AddBaseCom( GameUIImage ,'imgRoleAvatar')
  self.txtRoleName = self:AddBaseCom( GameUIText ,'txtRoleName')
  self.rimgRolePic = self:AddBaseCom( GameRawImage ,'rimgRolePic')


end

return PicChatItemView
---自动生成代码----end----