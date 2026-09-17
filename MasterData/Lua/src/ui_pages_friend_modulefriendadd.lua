local this = class("moduleFriendAdd", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {searching = false}
end

function this.bind()
  return {
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    go_none = false,
    go_search = false,
    go_noSearch = true,
    go_closeSearch = false,
    scrollList_player = {
      moduleName = "pages/Friend/cellPlayerInfo"
    },
    go_select = true,
    go_copy = true,
    go_Bg = false
  }
end

function this.methods()
  return {
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.parent.pageName)
      end,
      onClick_bg = function(self)
        L_UI:close(self.parent.pageName)
      end
    },
    onClick_closeSearch = function(self)
      local needRefresh = self.data.searching
      self.bind.go_closeSearch = false
      self.bind.go_Bg = false
      self.bind.go_noSearch = true
      self.bind.go_search = false
      self.bind.go_copy = true
      self.data.searching = false
      self.bindComponents.input_search.text = ""
      if needRefresh then
        self:initFriendList()
      end
      self.bind.go_none = table.isEmpty(L_FriendStore:getRecommandFriendList())
    end,
    onClick_refresh = function(self)
      L_FriendManager:requestRecommandFriends(function(errorCode)
        if errorCode == L_Const.errorCode.ErrCodeSucc then
          self:initFriendList()
          L_AudioUtil.playSound("Play_SFX_System_UI_Friends_Refresh")
        elseif errorCode == L_Const.errorCode.ErrCodeRecommendFriendTooFast then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_refresh_cd"))
        end
        self.bind.go_none = table.isEmpty(L_FriendStore:getRecommandFriendList())
      end)
    end,
    onClick_noSearch = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_enterplayerid"))
    end,
    onClick_search = function(self)
      local searchUid = self.bindComponents.input_search.text
      if string.isEmpty(searchUid) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_enterplayerid"))
        return
      end
      self.curSerachUID = tonumber(searchUid)
      if not self.curSerachUID then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_enterplayerid"))
        return
      end
      if self.curSerachUID == L_PlayerStore:getPlayerId() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_ui_friend_cannotaddoneself"))
        return
      end
      local playerList = L_FriendStore:getFriendList()
      for _, v in pairs(playerList) do
        if v:getPlayerUid() == self.curSerachUID then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_alreadyfriends"))
          return
        end
      end
      self.data.searching = true
      L_FriendManager:requestBaseInfoAll(self.curSerachUID, handler(self, self.endDo))
    end,
    scrollList_player = {
      onClick_apply = function(self, uid, callback)
        L_FriendManager:addFriend(uid, callback)
      end,
      onClick_head = function(self, uid, position)
        local dropdowns = {
          L_DropdownsManager.option.viewInfo,
          L_DropdownsManager.option.insertToBlackList,
          L_DropdownsManager.option.report
        }
        L_DropdownsManager:showPlayerDropdowns(position, dropdowns, uid)
      end,
      onClick_agree = function(self, uid)
        if table.count(L_FriendStore:getFriendList()) >= L_GameTpl:getGameConstTpl():getFriendLimit() then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleFriendApplication_02"))
          return
        end
        L_FriendManager:operationPlayer(L_Const.friendOpType.friend, L_Const.friendOp.add, uid, function()
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleFriendApplication_03"))
        end)
      end,
      onClick_refuse = function(self, uid)
        L_FriendManager:operationPlayer(L_Const.friendOpType.application, L_Const.friendOp.delete, uid, function()
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleFriendApplication_04"))
        end)
      end
    },
    onValueChanged_Input = function(self, value)
      if C_LuaUtility.StringLength(value) > 0 then
        self.bind.go_closeSearch = true
        self.bind.go_Bg = true
        self.bind.go_search = true
        self.bind.go_noSearch = false
        self.bind.go_select = false
        self.bind.go_copy = false
      else
        self.bind.go_closeSearch = false
        self.bind.go_Bg = false
        self.bind.go_search = false
        self.bind.go_noSearch = true
        self.bind.go_select = true
        self.bind.go_copy = true
      end
      self.limit = 10
      if string.find(value, "-") then
        value = string.gsub(value, "-", "")
        self.bindComponents.input_search.text = value
      end
      if not self.limit or 0 >= self.limit then
        return
      end
      if C_LuaUtility.StringLength(value) > self.limit then
        self.bindComponents.input_search.text = C_LuaUtility.StringSub(value, 0, self.limit)
      end
    end,
    onClick_copy = function(self)
      local clipboardText = CS.UnityEngine.GUIUtility.systemCopyBuffer
      if string.isEmpty(clipboardText) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_nocopyuid"))
        return
      end
      local len = C_LuaUtility.StringLength(clipboardText)
      if len < 8 or 10 < len or not string.match(clipboardText, "^%d+$") then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_nocopyuid"))
        return
      end
      self.bindComponents.input_search.text = clipboardText
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshTipNoPlayerInfo, self.onEvent_refresh_NoPlayerInfo, self)
  self.curSerachUID = -1
  local moduleTip = self.modules.moduleCommonTipMedium
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("ui_friend_12")
  })
end

function this:close(options)
  this.super.close(self, options)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshTipNoPlayerInfo, self.onEvent_refresh_NoPlayerInfo)
end

function this:initModule()
  self.bindComponents.ani_moduleFriendApplication:Play("anim_friend_list_in_up")
  L_FriendManager:requestRecommandFriends(function(errorCode)
    self:initFriendList()
    self.bind.go_none = table.isEmpty(L_FriendStore:getRecommandFriendList())
  end)
end

function this:RefreshSearchFriend(baseInfo)
  local tmp = {}
  local busy = false
  local online = L_FriendStore:getPlayerIsOnline(baseInfo)
  local txt_state = L_TimeUtil.getOfflineTimeDisplay(L_FriendStore:getPlayerOnLineTime(baseInfo), L_FriendStore:getPlayerOffLineTime(baseInfo))
  if online and L_FriendStore:getPlayerIsBusy(baseInfo) then
    busy = true
    online = false
    txt_state = L_GameUtil.fillColor(L_WordsTpl:getValue("ui_moduleRecentTeam"), L_Const.colorHtml.yellow0)
  end
  local offLine = not online and not busy
  table.insert(tmp, {
    uid = self.curSerachUID,
    txt_name = L_FriendStore:getPlayerName(baseInfo),
    txt_level = tostring(L_FriendStore:getPlayerLevel(baseInfo)),
    txt_sign = L_FriendStore:getPlayerSign(baseInfo),
    txt_title = L_FriendStore:ParsePlayerTitle(baseInfo),
    go_state = true,
    txt_state = txt_state,
    state_online = online,
    state_offline = offLine,
    state_busy = busy,
    operate_friend = false,
    operate_apply = false,
    operate_add = true,
    operate_black = false,
    url_defaultHero = L_FriendStore:getPlayerAvatarsHead(baseInfo),
    txt_achievement = not baseInfo.stand_plates.achievement_point and "0" or tostring(baseInfo.stand_plates.achievement_point),
    baseInfo = baseInfo,
    active_empty = false,
    active_bg = true,
    active_headImg = true,
    active_name = true,
    active_level = false,
    active_head = true,
    active_operation = true,
    is_empty = false,
    active_star = online
  })
  self:refreshPlayers(tmp)
end

function this:initFriendList()
  local tmp = {}
  local player = L_FriendStore:getRecommandFriendList()
  for id, v in pairs(player) do
    if not L_FriendStore:getIsFriend(id) and not L_FriendStore:getIsBlackList(id) then
      local baseInfo = L_FriendStore:getRecommandFriendBaseInfo(id)
      local online = L_FriendStore:getPlayerIsOnline(baseInfo)
      local busy = false
      local txt_state = L_TimeUtil.getOfflineTimeDisplay(L_FriendStore:getPlayerOnLineTime(baseInfo), L_FriendStore:getPlayerOffLineTime(baseInfo))
      if online and L_FriendStore:getPlayerIsBusy(baseInfo) then
        busy = true
        online = false
        txt_state = L_GameUtil.fillColor(L_WordsTpl:getValue("ui_moduleRecentTeam"), L_Const.colorHtml.yellow0)
      end
      local offLine = not online and not busy
      table.insert(tmp, {
        uid = id,
        txt_name = L_FriendStore:getPlayerName(baseInfo),
        txt_level = tostring(L_FriendStore:getPlayerLevel(baseInfo)),
        txt_sign = L_FriendStore:getPlayerSign(baseInfo),
        txt_title = L_FriendStore:ParsePlayerTitle(baseInfo),
        go_state = true,
        txt_state = txt_state,
        state_online = online,
        state_offline = offLine,
        state_busy = busy,
        operate_friend = false,
        operate_apply = false,
        operate_add = true,
        operate_black = false,
        url_defaultHero = L_FriendStore:getPlayerAvatarsHead(baseInfo),
        txt_achievement = not baseInfo.stand_plates.achievement_point and "0" or tostring(baseInfo.stand_plates.achievement_point),
        baseInfo = baseInfo,
        active_empty = false,
        active_bg = true,
        active_headImg = true,
        active_name = true,
        active_level = false,
        active_head = true,
        active_operation = true,
        is_empty = false,
        active_star = online
      })
    end
  end
  table.sort(tmp, function(a, b)
    local baseInfoA = L_FriendStore:getRecommandFriendBaseInfo(a.uid)
    local baseInfoB = L_FriendStore:getRecommandFriendBaseInfo(b.uid)
    local onlineA = L_FriendStore:getPlayerIsOnline(baseInfoA)
    local onlineB = L_FriendStore:getPlayerIsOnline(baseInfoB)
    local offlineTimeA = L_FriendStore:getPlayerOffLineTime(baseInfoA)
    local offlineTimeB = L_FriendStore:getPlayerOffLineTime(baseInfoB)
    local now = L_TimeUtil.getServerTime()
    local offlineTimeDifA = now - offlineTimeA
    local offlineTimeDifB = now - offlineTimeB
    local lvA, isMaxA = L_FriendStore:getPlayerLevel(baseInfoA)
    local lvB, isMaxB = L_FriendStore:getPlayerLevel(baseInfoB)
    if onlineA and not onlineB then
      return true
    elseif not onlineA and onlineB then
      return false
    elseif onlineA and onlineB then
      if lvA > lvB then
        return true
      elseif lvA < lvB then
        return false
      else
        return a.uid < b.uid
      end
    elseif offlineTimeDifA < offlineTimeDifB then
      return true
    elseif offlineTimeDifA > offlineTimeDifB then
      return false
    elseif lvA > lvB then
      return true
    elseif lvA < lvB then
      return false
    else
      return a.uid < b.uid
    end
  end)
  self:refreshPlayers(tmp)
end

function this:refreshPlayers(tmp)
  if 0 < #tmp and #tmp < 8 then
    for i = #tmp + 1, 8 do
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
  self.bind.scrollList_player:clear()
  self.bind.scrollList_player:insert_array(tmp)
end

function this:onEvent_refresh_NoPlayerInfo()
  self.bind.go_none = true
  local tmp = {}
  self.bind.scrollList_player:clear()
  self.bind.scrollList_player:insert_array(tmp)
end

function this:endDo()
  local baseInfo = L_FriendStore:getPlayerBaseInfo(self.curSerachUID, false)
  if baseInfo then
    self:RefreshSearchFriend(baseInfo)
  end
  self.bind.go_closeSearch = true
  self.bind.go_Bg = true
  self.bind.go_none = false
  self.bind.go_copy = false
end

return this
