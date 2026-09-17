local this = class("moduleCreateConversation", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {func = nil}
end

function this.bind()
  return {
    go_none = false,
    scrollList_playerList = {
      moduleName = "pages/Friend/cellFriendPlayer"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self.parent.bindComponents.ani_chat:Play("anim_chatpanel_createconversation_out")
      self.parent.bind.go_addConversationBtn = true
      self.parent:initChatBox()
    end,
    scrollList_playerList = {
      onClick_head = function(self, uid, position)
        L_FriendManager:viewPlayerCard(uid)
      end,
      onClick_addToChat = function(self, uid)
        L_ChatStore:req_createConversation(uid, function()
          self.data.func(uid)
        end)
      end
    }
  }
end

function this:open(options)
  this.super.open(self, options)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList, self)
end

function this:close(options)
  this.super.close(self, options)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList)
end

function this:initModule(func)
  self.data.func = func
  self:reqDataBeforeOpen()
end

function this:reqDataBeforeOpen()
  local playerList = L_FriendStore:getFriendList()
  local players = {}
  for _, v in pairs(playerList) do
    table.insert(players, v:getPlayerUid())
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_NAME,
    L_Const.PlayerBasicQueryType.PBQT_FACE_MINI,
    L_Const.PlayerBasicQueryType.PBQT_OFFLINE_TIME,
    L_Const.PlayerBasicQueryType.PBQT_LEVEL
  }
  L_FriendManager:requestBaseInfo(types, players, function()
    self:initPage()
  end)
end

function this:initPage()
  self:initPlayerList()
end

function this:initPlayerList()
  local tmp = {}
  local playerList = L_FriendStore:getFriendList()
  local conversationList = L_ChatStore:getConversationList()
  for _, v in pairs(playerList) do
    if not conversationList[v:getPlayerUid()] then
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
        txt_level = L_WordsTpl:getValue("info_chat_2", {
          [0] = L_FriendStore:getPlayerLevel(baseInfo)
        }),
        go_state = true,
        txt_state = txt_state,
        state_online = online,
        state_offline = offLine,
        state_busy = busy,
        txt_name = L_FriendManager:getFriendShowName(v:getPlayerUid()),
        operate_friend = true,
        url_defaultHero = L_FriendStore:getPlayerAvatarsHead(baseInfo),
        go_bgLine = true
      })
    end
  end
  self.bind.go_none = table.isEmpty(tmp)
  if not table.isEmpty(tmp) then
    tmp[#tmp].go_bgLine = false
  end
  table.sort(tmp, function(a, b)
    local baseInfoA = L_FriendStore:getPlayerBaseInfo(a.uid)
    local baseInfoB = L_FriendStore:getPlayerBaseInfo(b.uid)
    local onlineA = L_FriendStore:getPlayerIsOnline(baseInfoA) and 0 or 1
    local onlineB = L_FriendStore:getPlayerIsOnline(baseInfoB) and 0 or 1
    if onlineA == 0 and onlineB == 0 then
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
  self.bind.scrollList_playerList:clear()
  self.bind.scrollList_playerList:insert_array(tmp)
end

function this:onEvent_refreshIdList()
  self:reqDataBeforeOpen()
end

return this
