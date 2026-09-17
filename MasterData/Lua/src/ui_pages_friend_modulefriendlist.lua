local this = class("moduleFriendList", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    txt_friendNum = "",
    friendNumVisible = false,
    go_none = false,
    go_line = false,
    scrollList_player = {
      moduleName = "pages/Friend/cellFriendPlayer"
    }
  }
end

function this.methods()
  return {
    scrollList_player = {
      onClick_head = function(self, uid, position)
        local shield = L_ChatStore:getIsShieldChat(uid) and L_DropdownsManager.option.unmaskChat or L_DropdownsManager.option.refuseChat
        local dropdowns = {
          L_DropdownsManager.option.viewInfo,
          L_DropdownsManager.option.visitHome,
          L_DropdownsManager.option.addRemarks,
          L_DropdownsManager.option.removeFriend,
          L_DropdownsManager.option.insertToBlackList,
          L_DropdownsManager.option.report
        }
        L_DropdownsManager:showPlayerDropdowns(position, dropdowns, uid)
      end,
      onClick_join = function(self, uid)
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleFriendList_03"))
      end,
      onClick_chat = function(self, uid)
        L_ChatStore:req_createConversation(uid, function()
          L_UI:open("pageChat", {type = 3})
        end)
      end
    },
    onClick_blackList = function(self)
      L_UI:open("pageBlackList")
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshChatShield, self.onEvent_refreshIdList, self)
end

function this:close(options)
  this.super.close(self, options)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshChatShield, self.onEvent_refreshIdList)
end

function this:initModule()
  self:refreshFriendNumTxt()
  self.bind.txt_friendNum = L_WordsTpl:getValue("ui_moduleFriendList_01", {
    [0] = table.count(L_FriendStore:getFriendList()),
    [1] = L_GameTpl:getGameConstTpl():getFriendLimit()
  })
  local playerList = L_FriendStore:getFriendList()
  local players = {}
  for _, v in pairs(playerList) do
    table.insert(players, v:getPlayerUid())
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
    self:initFriendList()
    local empty = table.isEmpty(L_FriendStore:getFriendList())
    self.bind.go_none = empty
    self.bind.go_line = not empty
    self.bind.friendNumVisible = not empty
  end)
end

function this:initFriendList()
  local tmp = {}
  local player = L_FriendStore:getFriendList()
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
      txt_name = L_FriendManager:getFriendShowName(v:getPlayerUid()),
      txt_level = L_WordsTpl:getValue("ui_moduleFriendList_02", {
        [0] = L_FriendStore:getPlayerLevel(baseInfo)
      }),
      txt_sign = L_FriendStore:getPlayerSign(baseInfo),
      txt_title = L_FriendStore:ParsePlayerTitle(baseInfo),
      go_state = true,
      txt_state = txt_state,
      txt_sign = L_FriendStore:getPlayerSign(baseInfo),
      state_online = online,
      state_offline = offLine,
      state_busy = busy,
      operate_friend = true,
      operate_apply = false,
      url_defaultHero = L_FriendStore:getPlayerAvatarsHead(baseInfo)
    })
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
  self.bind.scrollList_player:clear()
  self.bind.scrollList_player:insert_array(tmp)
end

function this:onEvent_refreshIdList()
  self:refreshFriendNumTxt()
  self:initModule()
end

function this:refreshFriendNumTxt()
  self.bind.txt_friendNum = L_WordsTpl:getValue("ui_moduleFriendList_01", {
    [0] = table.count(L_FriendStore:getFriendList()),
    [1] = L_GameTpl:getGameConstTpl():getFriendLimit()
  })
end

return this
