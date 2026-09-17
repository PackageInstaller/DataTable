local this = class("moduleFriendBlackList", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    selectId_taskDiff = 1,
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    txt_blackListNum = "",
    txt_blockChatListNum = "",
    txt_none_blackList = L_WordsTpl:getValue("ui_friend_noblacklist"),
    txt_none_blockChat = L_WordsTpl:getValue("ui_hideList_empty"),
    go_rootblackList = false,
    go_rootblockChat = false,
    scrollList_playerBlack = {
      moduleName = "pages/Friend/cellPlayerInfo"
    },
    scrollList_playerBlockChat = {
      moduleName = "pages/Friend/cellPlayerInfo"
    },
    list_tab = {
      moduleName = "pages/Friend/cellChatTipTab"
    },
    toggle_blackList = false,
    toggle_blockChatList = false
  }
end

function this.methods()
  return {
    onSelectTabId_trainTaskType = function(self, id)
      if id == self.selectTab then
        return
      end
      self.selectTab = id
      self:refreshModuleView()
    end,
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.parent.pageName)
      end,
      onClick_bg = function(self)
        L_UI:close(self.parent.pageName)
      end
    },
    scrollList_playerBlack = {
      onClick_removeBlack = function(self, uid)
        local baseInfo = L_FriendStore:getPlayerBaseInfo(uid)
        local playerName = L_FriendStore:getPlayerName(baseInfo)
        L_FriendManager:operationPlayer(L_Const.friendOpType.blackList, L_Const.friendOp.delete, uid, function()
          L_FlyMsgManager:showNormalMsgByKey("tips_friend_removedblacklist", {
            [0] = playerName
          })
        end)
      end
    },
    scrollList_playerBlockChat = {
      onClick_removeBlack = function(self, uid)
        local baseInfo = L_FriendStore:getPlayerBaseInfo(uid)
        local playerName = L_FriendStore:getPlayerName(baseInfo)
        L_FriendStore:req_unblockPlayerChat(uid, function()
          L_FlyMsgManager:showNormalMsgByKey("tips_friend_removedhideList", {
            [0] = playerName
          })
        end)
      end
    }
  }
end

function this:open(options)
  this.super.open(self, options)
  local moduleTip = self.modules.moduleCommonTipMedium
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("ui_hideList_title")
  })
  self.selectTab = L_Const.blackPlayerTab.blackList
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshChatShield, self.initBlockChatListData, self)
end

function this:close(options)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshChatShield, self.initBlockChatListData)
  this.super.close(self, options)
end

function this:initModule()
  self.bindComponents.ani_moduleFriendApplication:Play("anim_friend_list_in_up")
  self:initTabList()
  L_FriendStore:req_blockChatPlayerList(function()
    self:initPlayers()
  end)
end

function this:initPlayers()
  local blackPlayerList = L_FriendStore:getBlackList()
  local blockChatPlayerList = L_FriendStore:getBlockChatList()
  local players = {}
  for _, v in pairs(blackPlayerList) do
    table.insert(players, v:getPlayerUid())
  end
  for _, v in pairs(blockChatPlayerList) do
    local found = false
    for _, uid in pairs(players) do
      if uid == v:getPlayerUid() then
        found = true
        break
      end
    end
    if not found then
      table.insert(players, v:getPlayerUid())
    end
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_NAME,
    L_Const.PlayerBasicQueryType.PBQT_FACE_MINI,
    L_Const.PlayerBasicQueryType.PBQT_OFFLINE_TIME,
    L_Const.PlayerBasicQueryType.PBQT_LEVEL,
    L_Const.PlayerBasicQueryType.PBQT_SIGN,
    L_Const.PlayerBasicQueryType.PBQT_TITLE
  }
  L_FriendManager:requestBaseInfo(types, players, function()
    self:initBlackListData()
    self:initBlockChatListData()
    self:refreshModuleView()
  end)
end

function this:initTabList()
  local dataList = {}
  table.insert(dataList, {
    id = L_Const.blackPlayerTab.blackList
  })
  table.insert(dataList, {
    id = L_Const.blackPlayerTab.blockChatList
  })
  self.bind.list_tab:clear()
  self.bind.list_tab:insert_array(dataList)
end

function this:initBlackListData()
  self:initFriendList(L_Const.blackPlayerTab.blackList)
  self.bind.txt_blackListNum = L_WordsTpl:getValue("ui_friend_blacklist_numshow", {
    [0] = string.format("%s/%s", table.count(L_FriendStore:getBlackList()), L_GameTpl:getGameConstTpl():getBlackListLimit())
  })
  if table.count(L_FriendStore:getBlackList()) == 0 then
    self.bind.txt_blackListNum = ""
  end
  self.bind.toggle_blackList = not table.isEmpty(L_FriendStore:getBlackList())
end

function this:initBlockChatListData()
  self:initFriendList(L_Const.blackPlayerTab.blockChatList)
  self.bind.txt_blockChatListNum = L_WordsTpl:getValue("ui_friend_blacklist_numshow", {
    [0] = string.format("%s/%s", table.count(L_FriendStore:getBlockChatList()), L_GameTpl:getGameConstTpl():getData("CHAT_SHIELD_LIMIT"))
  })
  if table.count(L_FriendStore:getBlockChatList()) == 0 then
    self.bind.txt_blockChatListNum = ""
  end
  self.bind.toggle_blockChatList = not table.isEmpty(L_FriendStore:getBlockChatList())
end

function this:refreshModuleView()
  if not self.selectTab then
    return
  end
  if self.selectTab == L_Const.blackPlayerTab.blackList then
    self.bind.go_rootblackList = true
    self.bind.go_rootblockChat = false
  elseif self.selectTab == L_Const.blackPlayerTab.blockChatList then
    self.bind.go_rootblackList = false
    self.bind.go_rootblockChat = true
  end
end

function this:initFriendList(listType)
  local tmp = {}
  local player = {}
  if listType == L_Const.blackPlayerTab.blackList then
    player = L_FriendStore:getBlackList()
  elseif listType == L_Const.blackPlayerTab.blockChatList then
    player = L_FriendStore:getBlockChatList()
  end
  for i, v in pairs(player) do
    local baseInfo = L_FriendStore:getPlayerBaseInfo(v:getPlayerUid())
    local online = L_FriendStore:getPlayerIsOnline(baseInfo)
    local busy = false
    local txt_state = L_TimeUtil.getOfflineTimeDisplay(L_FriendStore:getPlayerOnLineTime(baseInfo), L_FriendStore:getPlayerOffLineTime(baseInfo))
    if online and L_FriendStore:getPlayerIsBusy(baseInfo) then
      busy = true
      online = false
      txt_state = L_GameUtil.fillColor(L_WordsTpl:getValue("ui_moduleRecentTeam"), L_Const.colorHtml.yellow0)
    end
    local offLine = not online or not busy
    table.insert(tmp, {
      uid = v:getPlayerUid(),
      txt_name = L_FriendStore:getPlayerName(baseInfo),
      txt_level = tostring(L_FriendStore:getPlayerLevel(baseInfo)),
      txt_sign = L_FriendStore:getPlayerSign(baseInfo),
      txt_title = L_FriendStore:ParsePlayerTitle(baseInfo),
      go_state = true,
      txt_state = txt_state,
      txt_achievement = not baseInfo.stand_plates.achievement_point and "0" or tostring(baseInfo.stand_plates.achievement_point),
      state_online = online,
      state_offline = offLine,
      state_busy = busy,
      operate_friend = false,
      operate_apply = false,
      operate_add = false,
      operate_black = true,
      url_defaultHero = L_FriendStore:getPlayerAvatarsHead(baseInfo),
      baseInfo = baseInfo,
      active_empty = false,
      active_bg = true,
      active_headImg = true,
      active_name = true,
      active_level = false,
      active_head = true,
      active_operation = true,
      is_empty = false
    })
  end
  table.sort(tmp, function(a, b)
    local friendItemA = L_FriendStore:getPlayerItem(player, a.uid)
    local friendItemB = L_FriendStore:getPlayerItem(player, b.uid)
    local timeA = friendItemA:getInsertTime()
    local timeB = friendItemB:getInsertTime()
    return timeA > timeB
  end)
  if 0 < #tmp and #tmp < 6 then
    for i = #tmp + 1, 6 do
      table.insert(tmp, {
        active_empty = true,
        active_bg = false,
        active_headImg = false,
        active_name = false,
        active_level = false,
        active_head = false,
        active_operation = false,
        go_state = false,
        active_title = false,
        active_noTitile = false,
        is_empty = true
      })
    end
  end
  if listType == L_Const.blackPlayerTab.blackList then
    self.bind.scrollList_playerBlack:clear()
    self.bind.scrollList_playerBlack:insert_array(tmp)
  elseif listType == L_Const.blackPlayerTab.blockChatList then
    self.bind.scrollList_playerBlockChat:clear()
    self.bind.scrollList_playerBlockChat:insert_array(tmp)
  end
end

return this
