local this = class("pageFriends", G_UIPageBase)
local _moduleName = {
  add = "friendAdd",
  apply = "friendApplication",
  black = "friendBlack"
}
local MenuType = {
  friendAdd = 1,
  friendApply = 2,
  friendBlackList = 3
}
local TYPE_ICON = {
  [MenuType.friendAdd] = "Page/BSFriend/tex_friend_icon_shenqing",
  [MenuType.friendApply] = "Page/BSFriend/tex_friend_icon_shenqing",
  [MenuType.friendBlackList] = "Page/BSFriend/tex_friend_icon_shenqing"
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {selectMenuType = -1}
end

function this.bind()
  return {
    moduleName_modulePlayerList = "",
    module_playerList = {
      type = "toggleModule",
      friendList = {
        assetName = "UI/Pages/Friend/moduleFriendList",
        moduleName = "pages/friend/moduleFriendList"
      },
      friendAdd = {
        assetName = "UI/Pages/Friend/moduleFriendAdd",
        moduleName = "pages/friend/moduleFriendAdd"
      },
      friendApplication = {
        assetName = "UI/Pages/Friend/moduleFriendApplication",
        moduleName = "pages/friend/moduleFriendApplication"
      },
      friendBlack = {
        assetName = "UI/Pages/Friend/moduleFriendBlackList",
        moduleName = "pages/friend/moduleFriendBlackList"
      },
      recentTeam = {
        assetName = "UI/Pages/Friend/moduleRecentTeam",
        moduleName = "pages/friend/moduleRecentTeam"
      }
    }
  }
end

function this.methods()
  return {
    onClick_back = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(param)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshChatShield, self.onEvent_refreshIdList, self)
  self:initPage(param.menuType)
end

function this:close(options)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshChatShield, self.onEvent_refreshIdList)
end

function this:initPage(menuType)
  self:updateSelectPage(menuType)
end

function this:updateSelectPage(newSelect)
  if self.data.selectMenuType == newSelect then
    return
  end
  self.data.selectMenuType = newSelect
  if newSelect == MenuType.friendAdd then
    self.bind.moduleName_modulePlayerList = _moduleName.add
    self.modules.module_playerList.friendAdd:initModule(self.data.selectMenuType)
  elseif newSelect == MenuType.friendApply then
    self.bind.moduleName_modulePlayerList = _moduleName.apply
    self.modules.module_playerList.friendApplication:initModule(self.data.selectMenuType)
  elseif newSelect == MenuType.friendBlackList then
    self.bind.moduleName_modulePlayerList = _moduleName.black
    self.modules.module_playerList.friendBlack:initModule(self.data.selectMenuType)
  end
end

function this:onEvent_refreshIdList()
  if self.bind.moduleName_modulePlayerList == _moduleName.add then
    self.modules.module_playerList.friendAdd:initModule(self.data.selectMenuType)
  elseif self.bind.moduleName_modulePlayerList == _moduleName.apply then
    self.modules.module_playerList.friendApplication:initModule(self.data.selectMenuType)
  elseif self.bind.moduleName_modulePlayerList == _moduleName.black then
    self.modules.module_playerList.friendBlack:initModule(self.data.selectMenuType)
  end
end

return this
