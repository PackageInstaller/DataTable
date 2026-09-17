local this = class("moduleFriendApplication", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    txt_AllAgree = L_WordsTpl:getValue("ui_btn_friend_approvedrequests"),
    txt_AllDefuse = L_WordsTpl:getValue("ui_btn_friend_ignoredrequests"),
    txt_applicationNum = "",
    go_none = false,
    go_line = false,
    txt_none = L_WordsTpl:getValue("ui_friend_applicationempty"),
    go_apply = false,
    scrollList_player = {
      moduleName = "pages/Friend/cellPlayerInfo"
    }
  }
end

function this.methods()
  return {
    moduleCommonTipMedium = {
      onClick_cancel = function(self)
        L_FriendManager:operationPlayer(L_Const.friendOpType.application, L_Const.friendOp.allDelete, -1, function()
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleFriendApplication_04"))
        end)
      end,
      onClick_confirm = function(self)
        L_FriendManager:operationPlayer(L_Const.friendOpType.friend, L_Const.friendOp.allAdd, -1, function()
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_approvedrequests"))
        end)
      end,
      onClick_close = function(self)
        L_UI:close(self.parent.pageName)
      end,
      onClick_bg = function(self)
        L_UI:close(self.parent.pageName)
      end
    },
    scrollList_player = {
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
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_full"))
          L_FriendManager:operationPlayer(L_Const.friendOpType.application, L_Const.friendOp.delete, uid)
          return
        end
        L_FriendManager:operationPlayer(L_Const.friendOpType.friend, L_Const.friendOp.add, uid, function()
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_applicationapproved"))
        end)
      end,
      onClick_refuse = function(self, uid)
        L_FriendManager:operationPlayer(L_Const.friendOpType.application, L_Const.friendOp.delete, uid, function()
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleFriendApplication_04"))
        end)
      end
    }
  }
end

function this:open(options)
  this.super.open(self, options)
  local moduleTip = self.modules.moduleCommonTipMedium
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("ui_friend_2")
  })
end

function this:close(options)
  this.super.close(self, options)
end

function this:initModule(sou)
  local playerList = L_FriendStore:getFriendApplicationList()
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
    L_Const.PlayerBasicQueryType.PBQT_STAND_PLATES,
    L_Const.PlayerBasicQueryType.PBQT_TITLE
  }
  L_FriendManager:requestBaseInfo(types, players, function()
    self:initFriendList()
    self.bind.txt_applicationNum = L_WordsTpl:getValue("ui_moduleFriendApplication_01", {
      [0] = table.count(L_FriendStore:getFriendApplicationList()),
      [1] = L_GameTpl:getGameConstTpl():getFriendApplicationLimit()
    })
    if table.count(L_FriendStore:getFriendApplicationList()) == 0 then
      self.bind.txt_applicationNum = ""
    end
    self.bind.go_none = table.isEmpty(L_FriendStore:getFriendApplicationList())
    self.bind.go_line = not table.isEmpty(L_FriendStore:getFriendApplicationList())
  end)
end

function this:initFriendList()
  local tmp = {}
  local player = L_FriendStore:getFriendApplicationList()
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
      operate_apply = true,
      operate_add = false,
      operate_black = false,
      url_defaultHero = L_FriendStore:getPlayerAvatarsHead(baseInfo),
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
    local friendItemA = L_FriendStore:getPlayerItem(L_FriendStore:getFriendApplicationList(), a.uid)
    local friendItemB = L_FriendStore:getPlayerItem(L_FriendStore:getFriendApplicationList(), b.uid)
    local timeA = friendItemA:getInsertTime()
    local timeB = friendItemB:getInsertTime()
    return timeA > timeB
  end)
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
  if 0 < #tmp then
    self.bind.go_apply = true
  else
    self.bind.go_apply = false
  end
  local newStr = ""
  local applyList = 0 < table.count(L_FriendStore:getFriendApplicationList()) and L_FriendStore:getFriendApplicationList() or {}
  for k, v in pairs(applyList) do
    newStr = newStr .. "," .. v:getPlayerUid()
  end
  L_CommonUtil.setLocalValue(L_ReddotManager.DotDef.FriendApplication, newStr)
  L_ReddotManager._dirtyList[L_ReddotManager.DotDef.FriendApplication] = true
end

return this
