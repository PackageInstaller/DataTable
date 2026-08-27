local UINFriendshipChatPage = class("UINFriendshipChatPage", UIBaseNode)
local base = UIBaseNode
local UINFriendshipChatPageFriendList = require("Game.Friendship.pages.ChatPage.UINFriendshipChatPageFriendList")
local UINFriendshipChatPageChatDetail = require("Game.Friendship.pages.ChatPage.UINFriendshipChatPageChatDetail")

function UINFriendshipChatPage:OnInit()
  self.resloader = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFriendshipChatPage:LaterInit(resloader)
  self.resloader = resloader
  self.chatDetail = UINFriendshipChatPageChatDetail.New()
  self.chatDetail:Init(self.ui.obj_message)
  self.chatDetail:InitChatDetail(self.resloader)
  self.friendList = UINFriendshipChatPageFriendList.New()
  self.friendList:Init(self.ui.obj_iMChatList)
  self.friendList:InitFriendList(self.resloader, self.chatDetail.GetHeroData)
end

function UINFriendshipChatPage:OnDelete()
  self.chatDetail:Delete()
  self.friendList:Delete()
  base.OnDelete(self)
end

return UINFriendshipChatPage
