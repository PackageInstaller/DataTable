local this = class("modulePlayerTabLst", G_UIModuleBase)
local _chatChannelListTpl = L_GameTpl:getChatChannelListTpl()
local MenuType = {
  channelChat = 1,
  privateList = 2,
  friendList = 3
}
local MenuTypeDesc = {
  [1] = "WORLD",
  [2] = "CITY",
  [3] = "GROUP",
  [4] = "PARTY"
}
local MenuChannelType = {
  worldChat = 1,
  mainCityChat = 2,
  teamChat = 3,
  partyChat = 4
}
local MenuTypeList = {
  [MenuChannelType.worldChat] = {
    id = MenuChannelType.worldChat,
    reddotKey = ""
  },
  [MenuChannelType.mainCityChat] = {
    id = MenuChannelType.mainCityChat,
    reddotKey = ""
  },
  [MenuChannelType.partyChat] = {
    id = MenuChannelType.partyChat,
    reddotKey = ""
  },
  [MenuChannelType.teamChat] = {
    id = MenuChannelType.teamChat,
    reddotKey = L_ReddotManager.DotDef.FriendChannelTeamChat
  }
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    currentSelectPlayerId = 0,
    privateInited = false,
    friendInited = false
  }
end

function this.bind()
  return {
    curChannelTabId = -1,
    curPrivateFriendTabId = -1,
    curPlayerFriendTabId = -1,
    scrollList_menuChannel = {
      moduleName = "pages/chat/cellChannelInfo"
    },
    scrollList_privateFriend = {
      moduleName = "pages/chat/cellPrivateChatInfo"
    },
    scrollList_playerFriend = {
      moduleName = "pages/chat/cellFriendChatInfo"
    },
    txt_empty = L_WordsTpl:getValue("residual_code_moduleprivatechat_01"),
    txt_friendNum = "",
    go_none = false,
    go_closeListBtn = false,
    go_list = false,
    go_channelLst = false,
    go_privateLst = false,
    go_infoBg = true,
    go_setting = true,
    go_black = false,
    go_application = false,
    go_addFriend = false,
    go_friendTitle = true
  }
end

function this.methods()
  return {
    onSelect_privateChatTab = function(self, tabID)
      if self.bind.curPrivateFriendTabId == tabID then
        return
      end
      self.bind.curPrivateFriendTabId = tabID
      L_ChatStore.data.currentChatFriendId = tabID
      self:emit("onSelect_Tab", tabID)
      self:refreshSelect(tabID)
    end,
    onCloseClick_noChat = function(self)
      self:closePagePlayerDetailInfo()
      L_UI:close("pageChat")
      self:emit("onPlayCloseAnim")
    end,
    scrollList_privateFriend = {
      onClick_head = function(self, uid)
        self:emit("onClick_head", uid)
      end
    },
    onClick_closeList = function(self)
      L_TimerManager:newOrResetTimer(self, "closeTimer", function()
        L_UI:close("pageChat")
      end, 0.1)
      self:emit("onPlayCloseAnim")
    end,
    onSelect_ChatFriendTab = function(self, tabID)
      if self.bind.curPlayerFriendTabId == tabID or tabID == -1 then
        return
      end
      self:closePagePlayerDetailInfo()
      self.bind.curPlayerFriendTabId = tabID
      self:refreshSelect(tabID)
      self:emit("onSelect_Tab", tabID)
    end,
    onClick_addFriend = function(self)
      self:closePagePlayerDetailInfo()
      L_AudioUtil.playSound("Play_SFX_System_UI_Friends_Add")
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.friend, {menuType = 1})
    end,
    onClick_application = function(self)
      self:closePagePlayerDetailInfo()
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.friend, {menuType = 2})
    end,
    onClick_blackList = function(self)
      self:closePagePlayerDetailInfo()
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.friend, {menuType = 3})
    end,
    onClick_setting = function(self)
      self:closePagePlayerDetailInfo()
      L_UI:open("pageChatTip")
    end,
    scrollList_playerFriend = {
      onClick_head = function(self, uid)
        local function callback()
          self.data.currentSelectPlayerId = uid
        end
        
        self:emit("onClick_head", uid, callback)
      end,
      onClick_join = function(self, uid)
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleFriendList_03"))
        self:closePagePlayerDetailInfo()
      end,
      onClick_chat = function(self, uid)
        self:closePagePlayerDetailInfo()
        L_ChatStore:getConversation(uid, true)
        L_ChatStore.data.currentChatFriendId = uid
        print("设置的ID" .. uid)
        local page = L_UI:getPage("pageChat")
        if page then
          page.cls:SwitchPage(2)
        else
          L_UI:open("pageChat", {type = 2})
        end
      end
    },
    onSelect_ChannelChatTab = function(self, tabID)
      if tabID == -1 then
        return
      end
      self.bind.curChannelTabId = tabID
      self.data.menuType = tabID
      self:emit("onSelect_Tab", tabID)
      self:closePagePlayerDetailInfo()
    end,
    OnClickSelf = function(self)
      self:closePagePlayerDetailInfo()
    end,
    scrollList_menuChannel = {
      onClick_Channel = function(self)
        self:closePagePlayerDetailInfo()
      end
    },
    onCellUsePrivateChat = function(self, id)
      self:refreshActorCell(id)
    end,
    onCellUseChatFriend = function(self, id)
      self:refreshActorCell(id)
    end,
    onCellUseChannelChat = function(self, id)
      self:refreshActorCell(id)
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshFriendIdList, self)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshPrivateIdList, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshChatShield, self.refreshBlock, self)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdListByLocalPlayer, self.onEvent_refreshPrivateIdList, self)
  self:registerReddot(self.bindComponents.reddotSmall_application, L_ReddotManager.DotDef.FriendApplication)
  self:registerReddot(self.bindComponents.reddotNormal_setting, L_ReddotManager.DotDef.FriendChatTip)
end

function this:close(options)
  this.super.close(self, options)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshFriendIdList)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshChatShield, self.refreshBlock)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdListByLocalPlayer, self.onEvent_refreshPrivateIdList)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshPrivateIdList)
  self.bind.scrollList_menuChannel:clear()
end

function this:show()
  if self.moduleType == MenuType.channelChat then
    self.chatChannelInited = false
    self:initChannelModule(self.bind.curChannelTabId)
  elseif self.moduleType == MenuType.privateList then
  elseif self.moduleType == MenuType.friendList then
  end
end

function this:hide()
  if self.moduleType ~= nil and self.moduleType == MenuType.channelChat then
    local cacheObj = {}
    for i = 1, #self.bind.scrollList_menuChannel do
      table.insert(cacheObj, self.bind.scrollList_menuChannel:getItemCls(i).gameObject)
    end
    self.bind.scrollList_menuChannel:clear()
    for k, v in ipairs(cacheObj) do
      C_BoundGameObject.DestroyImmediate(v)
    end
  end
end

function this:initModule(option)
  self.moduleType = option.type
  self.tabId = option.tabId
  self:onReset()
  if option.type == MenuType.channelChat then
    self.bind.go_channelLst = true
    self:initChannelModule(self.tabId)
  elseif option.type == MenuType.privateList then
    self.bind.go_privateLst = true
    self.bind.go_closeListBtn = true
    self.bind.txt_empty = L_WordsTpl:getValue("residual_code_moduleprivatechat_01")
    self:initPrivateChatModule(self.tabId)
  elseif option.type == MenuType.friendList then
    self.bind.txt_empty = L_WordsTpl:getValue("ui_chat_nofriend")
    self.bind.go_list = true
    self.bind.go_black = true
    self.bind.go_application = true
    self.bind.go_addFriend = true
    self:initFriendModule(self.tabId)
  end
end

function this:onReset()
  self.bind.txt_empty = ""
  self.bind.go_infoBg = true
  self.bind.go_none = false
  self.bind.go_list = false
  self.bind.go_channelLst = false
  self.bind.go_privateLst = false
  self.bind.go_black = false
  self.bind.go_application = false
  self.bind.go_addFriend = false
end

function this:initPrivateChatModule(tabId)
  local conversationList = L_ChatStore:getConversationList()
  local players = {}
  for id, v in pairs(conversationList) do
    table.insert(players, id)
  end
  if 0 < #players and not self.data.privateInited then
    local types = {
      L_Const.PlayerBasicQueryType.PBQT_ALL
    }
    L_FriendManager:requestBaseInfo(types, players, function()
      self.data.privateInited = true
      self:initPrivateChatList(tabId)
    end)
  else
    self:initPrivateChatList(tabId)
  end
end

function this:initPrivateChatList(tabId)
  local tmp = {}
  local conversationList = L_ChatStore:getConversationList()
  local curUid = L_ChatStore:getCurrentChatFriendId()
  for id, v in pairs(conversationList) do
    if table.count(v.chats) ~= 0 or L_FriendStore:getIsFriend(id) then
      local baseInfo = L_FriendStore:getPlayerBaseInfo(id)
      local online = L_FriendStore:getPlayerIsOnline(baseInfo)
      local busy = false
      local txt_state = L_TimeUtil.getOfflineTimeDisplay(L_FriendStore:getPlayerOnLineTime(baseInfo), L_FriendStore:getPlayerOffLineTime(baseInfo))
      if online and L_FriendStore:getPlayerIsBusy(baseInfo) then
        busy = true
        online = false
        txt_state = L_WordsTpl:getValue("ui_moduleRecentTeam")
      end
      local offLine = not online and not busy
      local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), id)
      local name = ""
      local goblock = false
      local isMark = false
      if friend and not string.isEmpty(friend:getFriendMark()) then
        name = friend:getFriendMark()
        goblock = L_FriendStore:getIsBlockChatList(id)
        isMark = true
      elseif friend then
        name = L_FriendManager:getFriendShowName(id)
        goblock = L_FriendStore:getIsBlockChatList(id)
      else
        name = L_FriendStore:getPlayerName(baseInfo)
        goblock = false
      end
      table.insert(tmp, {
        uid = id,
        txt_name = name,
        txt_level = tostring(L_FriendStore:getPlayerLevel(baseInfo)),
        go_block = goblock,
        go_state = true,
        txt_state = txt_state,
        txt_title = L_FriendStore:ParsePlayerTitle(baseInfo),
        state_online = online,
        state_offline = offLine,
        state_busy = busy,
        operate_friend = true,
        operate_apply = false,
        url_defaultHero = L_FriendStore:getPlayerAvatarsHead(baseInfo),
        is_mark = isMark
      })
    end
  end
  table.sort(tmp, function(a, b)
    local baseInfoA = L_FriendStore:getPlayerBaseInfo(a.uid)
    local baseInfoB = L_FriendStore:getPlayerBaseInfo(b.uid)
    local onlineA = L_FriendStore:getPlayerIsOnline(baseInfoA) and 0 or 1
    local onlineB = L_FriendStore:getPlayerIsOnline(baseInfoB) and 0 or 1
    if not L_FriendStore:getIsFriend(a.uid) or not L_FriendStore:getIsFriend(b.uid) then
      return L_FriendStore:getIsFriend(a.uid) and not L_FriendStore:getIsFriend(b.uid)
    elseif onlineA == 0 and onlineB == 0 then
      local friendItemA = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), a.uid)
      local friendItemB = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), b.uid)
      local timeA = friendItemA:getInsertTime()
      local timeB = friendItemB:getInsertTime()
      return timeA < timeB
    elseif onlineA == 1 and onlineB == 1 then
      local offlineTimeA = L_FriendStore:getPlayerOffLineTime(baseInfoA)
      local offlineTimeB = L_FriendStore:getPlayerOffLineTime(baseInfoB)
      return offlineTimeA > offlineTimeB
    else
      return onlineA < onlineB
    end
  end)
  self.bind.scrollList_privateFriend:clear()
  self.bind.scrollList_privateFriend:insert_array(tmp)
  if table.count(tmp) > 0 then
    self.bind.go_none = false
    self.bind.go_infoBg = true
  else
    self.bind.go_none = true
    self.bind.go_infoBg = false
  end
  if tabId and 0 < tabId then
    local checkUid = false
    for i, v in ipairs(tmp) do
      if v.uid == tabId then
        checkUid = true
        break
      end
    end
    if not checkUid then
      tabId = 0
    end
  end
  if tabId == nil or tabId == 0 then
    if self.bind.curPrivateFriendTabId == -1 then
      if curUid == -1 and table.count(tmp) > 0 then
        self.bind.curPrivateFriendTabId = tmp[1].uid
      else
        self.bind.curPrivateFriendTabId = curUid
      end
    elseif self.bind.curPrivateFriendTabId ~= curUid and curUid ~= -1 then
      self.bind.curPrivateFriendTabId = curUid
    end
  elseif self.bind.curPrivateFriendTabId ~= tabId then
    self.bind.curPrivateFriendTabId = tabId
  end
  L_ChatStore.data.currentChatFriendId = self.bind.curPrivateFriendTabId
end

function this:initFriendModule(tabId)
  self.bind.txt_friendNum = string.format("%s/%s", table.count(L_FriendStore:getFriendList()), L_GameTpl:getGameConstTpl():getFriendLimit())
  if not self.data.friendInited then
    local playerList = L_FriendStore:getFriendList()
    local players = {}
    for _, v in pairs(playerList) do
      table.insert(players, v:getPlayerUid())
    end
    local types = {
      L_Const.PlayerBasicQueryType.PBQT_ALL
    }
    L_FriendManager:requestBaseInfo(types, players, function()
      self.data.friendInited = true
      self:initFriendList(tabId)
      local empty = table.isEmpty(L_FriendStore:getFriendList())
      self.bind.go_none = empty
      self.bind.go_friendTitle = not empty
      self.bind.go_closeListBtn = empty
    end)
  else
    self:initFriendList(tabId)
    local empty = table.isEmpty(L_FriendStore:getFriendList())
    self.bind.go_none = empty
    self.bind.go_friendTitle = not empty
    self.bind.go_closeListBtn = empty
  end
end

function this:initChannelModule(tabId)
  if not self.chatChannelInited then
    local tmp = {}
    for i, v in ipairs(MenuTypeList) do
      local tpl = _chatChannelListTpl:getTplById(v.id)
      local show = 0
      if tpl then
        show = _chatChannelListTpl:getShow(tpl)
      end
      local isActive = true
      if v.id == MenuChannelType.partyChat then
        local chatData = L_ChatStore:getChannelData(L_Const.chatType.map)
        isActive = chatData:getChannelActive()
      end
      if show == 1 and isActive then
        local data = {
          uid = v.id,
          txt_title = _chatChannelListTpl:getName(tpl),
          txt_titleUns = _chatChannelListTpl:getName(tpl),
          reddotKey = v.reddotKey,
          txt_word = MenuTypeDesc[v.id]
        }
        table.insert(tmp, data)
      end
    end
    self.bind.scrollList_menuChannel:clear()
    self.bind.scrollList_menuChannel:insert_array(tmp)
  end
  self.chatChannelInited = true
  if tabId == nil or tabId == 0 then
    if self.bind.curChannelTabId == -1 then
      self.bind.curChannelTabId = MenuChannelType.worldChat
    end
  elseif self.bind.curChannelTabId ~= tabId then
    self.bind.curChannelTabId = tabId
  end
end

function this:initFriendList(tabId)
  local tmp = L_FriendStore:getFriendViewLst()
  if 0 < #tmp then
    if self.bind.curPlayerFriendTabId == -1 then
      self.bind.curPlayerFriendTabId = tmp[1].uid
    end
    self.bind.go_infoBg = true
  else
    self.bind.go_infoBg = false
  end
  self.bind.scrollList_playerFriend:clear()
  self.bind.scrollList_playerFriend:insert_array(tmp)
  if tabId == nil or tabId == 0 then
  elseif self.bind.curPlayerFriendTabId ~= tabId then
    self.bind.curPlayerFriendTabId = tabId
  end
end

function this:refreshActorCell(id)
  self:closePagePlayerDetailInfo()
  local tabId = -1
  local lst
  if self.moduleType == MenuType.channelChat then
    lst = self.bind.scrollList_menuChannel
    tabId = self.bind.curChannelTabId
  elseif self.moduleType == MenuType.privateList then
    lst = self.bind.scrollList_privateFriend
    tabId = self.bind.curPrivateFriendTabId
  elseif self.moduleType == MenuType.friendList then
    lst = self.bind.scrollList_playerFriend
    tabId = self.bind.curPlayerFriendTabId
  end
  id = id + 1
  if lst ~= nil and tabId ~= -1 then
    local cell = lst:getItemCls(id)
    if cell then
      if self.moduleType == MenuType.privateList then
        cell:refreshSelect(tabId)
      else
        cell:refreshShow(tabId)
      end
    else
      error("错误的cell ID" .. id)
    end
  end
end

function this:refreshModule(option)
  self:initModule(option)
end

function this:closePagePlayerDetailInfo()
  self:emit("onClick_close")
end

function this:playSwitchAnim(isOpen)
  if not self.bindComponents.anim_cellContent then
    return
  end
end

function this:refreshSelect(curUid)
  if self.moduleType ~= nil then
    if self.moduleType == MenuType.friendList then
      for i = 1, #self.bind.scrollList_playerFriend do
        local cellFriendChatInfo = self.bind.scrollList_playerFriend:getItemCls(i)
        cellFriendChatInfo:refreshSelect(curUid)
      end
    elseif self.moduleType == MenuType.privateList then
      for i = 1, #self.bind.scrollList_privateFriend do
        local cell = self.bind.scrollList_privateFriend:getItemCls(i)
        cell:refreshSelect(curUid)
      end
    end
  end
end

function this:refreshBlock()
  if self.moduleType ~= nil then
    if self.moduleType == MenuType.friendList then
      for i = 1, #self.bind.scrollList_playerFriend do
        local cell = self.bind.scrollList_playerFriend:getItemCls(i)
        if cell then
          cell:refresh()
        end
      end
    elseif self.moduleType == MenuType.privateList then
      for i = 1, #self.bind.scrollList_privateFriend do
        local cell = self.bind.scrollList_privateFriend:getItemCls(i)
        if cell then
          cell:refresh()
        end
      end
    end
  end
end

function this:onEvent_refreshFriendIdList()
  if self.moduleType == MenuType.friendList then
    self:initFriendModule()
  end
end

function this:onEvent_refreshPrivateIdList(data)
  if self.moduleType == MenuType.privateList then
    self:initPrivateChatModule()
  end
end

function this:setActiveNone(isShow)
  self.bind.go_none = isShow
  if isShow and self.moduleType == MenuType.privateList then
    self.bind.txt_empty = L_WordsTpl:getValue("ui_chat_friend_empty")
  end
end

function this:getChannelTabId()
  return self.bind.curChannelTabId
end

function this:getPrivateTabId()
  return self.bind.curPrivateFriendTabId
end

function this:getFriendTabId()
  return self.bind.curPlayerFriendTabId
end

return this
