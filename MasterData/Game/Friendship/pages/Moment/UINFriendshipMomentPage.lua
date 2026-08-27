local UINFriendshipMomentPage = class("UINFriendshipMomentPage", UIBaseNode)
local base = UIBaseNode

function UINFriendshipMomentPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFriendshipMomentPage:LaterInit(resloader)
  self.resloader = resloader
end

function UINFriendshipMomentPage:OnDelete()
  base.OnDelete(self)
end

return UINFriendshipMomentPage
