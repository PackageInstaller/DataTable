local this = class("moduleRecentTeam", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    go_none = false,
    scrollList_player = {
      moduleName = "pages/Friend/cellFriendPlayer"
    }
  }
end

function this.methods()
  return {
    scrollList_player = {
      onClick_head = function(self, uid, position)
        local dropdowns = {
          L_DropdownsManager.option.viewInfo,
          L_DropdownsManager.option.addFriend,
          L_DropdownsManager.option.insertToBlackList,
          L_DropdownsManager.option.report
        }
        L_DropdownsManager:showPlayerDropdowns(position, dropdowns, uid)
      end,
      onClick_join = function(self, uid)
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleFriendList_03"))
      end
    }
  }
end

function this:open(options)
  this.super.open(self, options)
end

function this:close(options)
  this.super.close(self, options)
end

function this:initModule()
  local playerList = L_FriendStore:getRecentTeamList()
  local players = {}
  for _, v in pairs(playerList) do
    table.insert(players, v:getPlayerUid())
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_NAME,
    L_Const.PlayerBasicQueryType.PBQT_FACE_MINI,
    L_Const.PlayerBasicQueryType.PBQT_OFFLINE_TIME,
    L_Const.PlayerBasicQueryType.PBQT_LEVEL,
    L_Const.PlayerBasicQueryType.PBQT_SIGN
  }
  L_FriendManager:requestBaseInfo(types, players, function()
    self:initFriendList()
    self.bind.go_none = table.isEmpty(L_FriendStore:getRecentTeamList())
  end)
end

function this:initFriendList()
  local tmp = {}
  local player = L_FriendStore:getRecentTeamList()
  for _, v in pairs(player) do
    local baseInfo = L_FriendStore:getPlayerBaseInfo(v:getPlayerUid())
    local online = L_FriendStore:getPlayerIsOnline(baseInfo)
    local busy = false
    local txt_state = L_TimeUtil.getOfflineTimeDisplay(L_FriendStore:getPlayerOnLineTime(baseInfo), L_FriendStore:getPlayerOffLineTime(baseInfo))
    if online and L_FriendStore:getPlayerIsBusy(baseInfo) then
      busy = true
      online = false
      txt_state = L_GameUtil.fillColor(L_WordsTpl:getValue("ui_moduleRecentTeam"), L_Const.colorHtml.yellow0)
    end
    table.insert(tmp, {
      uid = v:getPlayerUid(),
      txt_name = L_FriendStore:getPlayerName(baseInfo),
      txt_level = string.format("Lv.%s", L_FriendStore:getPlayerLevel(baseInfo)),
      color_state = color_state,
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
    local friendItemA = L_FriendStore:getPlayerItem(L_FriendStore:getRecentTeamList(), a.uid)
    local friendItemB = L_FriendStore:getPlayerItem(L_FriendStore:getRecentTeamList(), b.uid)
    local timeA = friendItemA:getInsertTime()
    local timeB = friendItemB:getInsertTime()
    return timeA > timeB
  end)
  self.bind.scrollList_player:clear()
  self.bind.scrollList_player:insert_array(tmp)
end

return this
