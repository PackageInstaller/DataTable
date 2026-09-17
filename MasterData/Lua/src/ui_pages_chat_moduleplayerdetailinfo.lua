local this = class("modulePlayerDetailInfo", G_UIModuleBase)
local commonPlayerInformationTpl = L_GameTpl:getCommonPlayerInformationTpl()
local BTN_ID_TO_FIELD = {
  [1] = "go_checkBtn",
  [2] = "go_changeNoteBtn",
  [3] = "go_blockBtn",
  [4] = "go_addBlackBtn",
  [5] = "go_deleteFriendBtn",
  [6] = "go_accuseBtn",
  [7] = "go_accessHomeBtn",
  [8] = "go_addFriendBtn",
  [9] = "go_changeLeader",
  [10] = "go_hero",
  [11] = "go_kickOut"
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {selectType = nil, isFriend = false}
end

function this.bind()
  return {
    cellHeadPic = {
      moduleName = "pages/headPic/cellHeadPic"
    },
    img_bg = true,
    img_headIcon = "",
    txt_name = "",
    active_title = false,
    active_noTitle = false,
    txt_title = "",
    txt_level = "",
    txt_achievement = "",
    go_block = false,
    txt_state = "",
    txt_stateColor = C_Color.white,
    active_image_state = false,
    txt_checkBtn = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(1)),
    txt_changeNoteBtn = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(2)),
    txt_blockBtn = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(3)),
    txt_addBlackBtn = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(4)),
    txt_deleteFriendBtn = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(5)),
    txt_accuseBtn = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(6)),
    txt_accessHomeBtn = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(7)),
    txt_addFriendBtn = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(8)),
    txt_changeLeader = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(9)),
    txt_hero = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(10)),
    txt_kickOut = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(11)),
    txt_delBlackBtn = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(12)),
    go_checkBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(1)) == 1,
    go_changeNoteBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(2)) == 1,
    go_blockBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(3)) == 1,
    go_addBlackBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(4)) == 1,
    go_deleteFriendBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(5)) == 1,
    go_accuseBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(6)) == 1,
    go_accessHomeBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(7)) == 1,
    go_addFriendBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(8)) == 1,
    go_delBlackBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(12)) == 1,
    go_changeLeader = false,
    go_hero = false,
    go_kickOut = false,
    img_block = "Atlas/Chat/tex_chat_icon_12.png",
    txt_nameColor = C_Color.white
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:emit("onClick_close")
    end,
    onClick_checkInfo = function(self)
      L_FriendManager:viewPlayerCard(self.currentPlayerId)
    end,
    onClick_changeNote = function(self)
      self:changeNote()
    end,
    onClick_blockInfo = function(self)
      self:blockFriend()
    end,
    onClick_addBlack = function(self)
      self:addBlack()
    end,
    onClick_addFriend = function(self)
      self:addFriend()
    end,
    onClick_deleteFriend = function(self)
      self:deleteFriend()
    end,
    onClick_accuse = function(self)
      self:accusePlayer()
    end,
    onClick_accessHome = function(self)
      self:accessHome()
    end,
    onClick_changeLeader = function(self)
      self:changeLeader()
    end,
    onClick_hero = function(self)
      self:emit("onClick_close")
      self:checkHero()
    end,
    onClick_kickOut = function(self)
      if self._inputTeamData then
        self._inputTeamData.kickOutCall()
      else
        self:kickOut()
      end
    end,
    onClick_delBlack = function(self)
      self:delBlack()
    end,
    onClick_bg_close = function(self)
      self:emit("onClick_close")
    end
  }
end

function this:open()
  this.super.open(self)
  L_AudioUtil.playSound("Play_SFX_System_UI_Friends_ClickAvatar")
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshChatShield, self.onEvent_refreshList, self)
end

function this:close()
  this.super.close(self)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshChatShield, self.onEvent_refreshList)
  if self.headTex then
    C_PhotoManager.ReleaseTexture(self.headTex)
    self.headTex = nil
  end
end

function this:initModule(options)
  self._inputTeamData = options.inputTeamData
  self._teamType = options.isTeam
  self.isHideFriendBtn = options.isHideFriendBtn
  self:setCurrentPlayerId(options.uid)
  self:IsInMultiTeam(options.isTeam)
  self.visibleButtons = options.visibleButtons
  self:refreshModule(options.uid)
  self:dynamicInitBtn()
  self:applyVisibleButtonsFilter()
  self:refreshReportButtonVisible()
  self:showLines()
end

function this:onEvent_refreshList()
  self:refreshModule(self.currentPlayerId)
end

function this:setCurrentPlayerId(uid)
  self.currentPlayerId = uid
end

function this:refreshPlayerInfo()
  local baseInfo = L_FriendStore:getPlayerBaseInfo(self.currentPlayerId)
  if baseInfo == nil or self._teamType == 4 then
    local types = {
      L_Const.PlayerBasicQueryType.PBQT_ALL
    }
    local players = {}
    table.insert(players, self.currentPlayerId)
    L_FriendManager:requestBaseInfo(types, players, function()
      self:_refreshPlayerInfo()
    end)
  else
    self:_refreshPlayerInfo()
  end
end

function this:refreshModule(uid)
  self:refreshPlayerInfo()
  self:applyVisibleButtonsFilter()
  self:refreshReportButtonVisible()
  self:showLines()
end

function this:dynamicInitBtn()
  self.bind.go_changeLeader = false
  self.bind.go_hero = false
  self.bind.go_kickOut = false
  if self.isTeam then
    self.bind.go_hero = true
    if self.selfTeamData.IsLeader then
      self.bind.go_changeLeader = true
      self.bind.go_kickOut = true
    end
  end
  if self.isNestCoopMain == true then
    self.bind.go_checkBtn = true
    self.bind.go_changeLeader = false
    self.bind.go_changeNoteBtn = false
    self.bind.go_accuseBtn = false
    if self.selfTeamData.IsLeader then
      self.bind.go_kickOut = true
    end
  end
end

function this:IsInMultiTeam()
  if self._teamType ~= nil and self._teamType == 2 then
    self.isNestCoop = true
  else
    self.isNestCoop = false
  end
  if self._teamType ~= nil and self._teamType == 3 then
    self.isNestCoopMain = true
  else
    self.isNestCoopMain = false
  end
  self.isTeam = false
  if self._teamType and self._teamType == 4 then
    self.selfTeamData = self._inputTeamData
    self.teamData = self._inputTeamData
    self.isNestCoopMain = true
  elseif C_MultiTeam.IsInMultiTeam() and self.currentPlayerId then
    self.teamData = C_MultiTeam.GetAllPlayersData(self.currentPlayerId)
    self.selfTeamData = C_MultiTeam.GetSelfTeamData()
    if self.teamData and self.selfTeamData and self._teamType == 1 then
      self.isTeam = true
    end
  end
end

function this:dynamicShowBtn(id)
  if id == 9 then
    self.bind.go_changeLeader = true
    self.bind.txt_changeLeader = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(9))
  elseif id == 10 then
    self.bind.go_hero = true
    self.bind.txt_hero = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(10))
  elseif id == 11 then
    self.bind.go_kickOut = true
    self.bind.txt_kickOut = commonPlayerInformationTpl:getName(commonPlayerInformationTpl:getTplById(11))
  end
end

function this:changeLeader()
  if self.teamData then
    L_GameUtil.showNetCommonTip({
      txtContent = L_WordsTpl:getValue("residual_code_moduleplayerdetailinfo_01"),
      confirmCallback = function()
        self:emit("onClick_close")
        C_MultiTeam.ReqLeaderChange(self.currentPlayerId)
      end
    })
  end
end

function this:checkHero()
  if self.teamData then
    C_MultiTeam.CheckPageMultiTeamFormation(self.currentPlayerId)
  end
end

function this:kickOut()
  if self.teamData then
    L_GameUtil.showNetCommonTip({
      txtContent = L_WordsTpl:getValue("residual_code_moduleplayerdetailinfo_02"),
      confirmCallback = function()
        self:emit("onClick_close")
        C_MultiTeam.KickOutTeam(self.currentPlayerId)
      end
    })
  end
end

function this:applyVisibleButtonsFilter()
  if not self.visibleButtons then
    return
  end
  local visibleSet = {}
  for _, id in ipairs(self.visibleButtons) do
    visibleSet[id] = true
  end
  for id, field in pairs(BTN_ID_TO_FIELD) do
    if not visibleSet[id] then
      self.bind[field] = false
    end
  end
end

function this:refreshReportButtonVisible()
  self.bind.go_accuseBtn = self.bind.go_accuseBtn and CS.Lens.Gameplay.UI.ReportStore.GetStore():IsReportTypeEnabledById(1)
end

function this:_refreshPlayerInfo()
  local baseInfo = L_FriendStore:getPlayerBaseInfo(self.currentPlayerId)
  if baseInfo == nil then
    return
  end
  local online = L_FriendStore:getPlayerIsOnline(baseInfo)
  local busy = false
  local txt_state = L_TimeUtil.getOfflineTimeDisplay(L_FriendStore:getPlayerOnLineTime(baseInfo), L_FriendStore:getPlayerOffLineTime(baseInfo))
  local _, txt_stateColor = C_ColorUtility.TryParseHtmlString("#a6a5a5")
  if online and L_FriendStore:getPlayerIsBusy(baseInfo) then
    busy = true
    online = false
    txt_state = L_WordsTpl:getValue("ui_moduleRecentTeam")
    _, txt_stateColor = C_ColorUtility.TryParseHtmlString(L_Const.colorHtml.yellow0)
  elseif online then
    _, txt_stateColor = C_ColorUtility.TryParseHtmlString("#2bb478")
  end
  local offLine = not online and not busy
  local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), self.currentPlayerId)
  if friend then
    self.data.isFriend = true
    self.bind.go_changeNoteBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(2)) == 1 and not self.isTeam
    self.bind.go_blockBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(3)) == 1
    self.bind.go_addBlackBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(5)) == 1
    self.bind.go_accessHomeBtn = false
    self.bind.go_delBlackBtn = false
    local isMark = not string.isEmpty(friend:getFriendMark())
    self.bind.txt_name = isMark and friend:getFriendMark() or L_FriendManager:getFriendShowName(self.currentPlayerId)
    if isMark then
      local _, color001 = C_ColorUtility.TryParseHtmlString("#04a5e1cc")
      self.bind.txt_nameColor = color001
    else
      local _, color001 = C_ColorUtility.TryParseHtmlString("#111a22cc")
      self.bind.txt_nameColor = color001
    end
    self.isBlock = L_FriendStore:getIsBlockChatList(self.currentPlayerId)
    if self.isBlock then
      self.bind.txt_blockBtn = L_WordsTpl:getValue("meun_friend_8")
    else
      self.bind.txt_blockBtn = L_WordsTpl:getValue("meun_friend_4")
    end
    self.bind.img_block = self.isBlock and "Atlas/Chat/tex_chat_icon_17_1.png" or "Atlas/Chat/tex_chat_icon_12.png"
    self.bind.go_block = self.isBlock
    if self.isHideFriendBtn then
      self.bind.go_deleteFriendBtn = false
      self.bind.go_addFriendBtn = false
    else
      self.bind.go_deleteFriendBtn = true
      self.bind.go_addFriendBtn = false
    end
  else
    self.data.isFriend = false
    self.bind.go_changeNoteBtn = false
    self.bind.go_blockBtn = commonPlayerInformationTpl:getShow(commonPlayerInformationTpl:getTplById(3)) == 1
    local isBlack = L_FriendStore:getIsBlackList(self.currentPlayerId)
    self.bind.go_addBlackBtn = not isBlack
    self.bind.go_delBlackBtn = isBlack
    self.bind.go_accessHomeBtn = false
    self.bind.txt_name = L_FriendStore:getPlayerName(baseInfo)
    self.isBlock = L_FriendStore:getIsBlockChatList(self.currentPlayerId)
    if self.isBlock then
      self.bind.txt_blockBtn = L_WordsTpl:getValue("meun_friend_8")
    else
      self.bind.txt_blockBtn = L_WordsTpl:getValue("meun_friend_4")
    end
    self.bind.img_block = self.isBlock and "Atlas/Chat/tex_chat_icon_17_1.png" or "Atlas/Chat/tex_chat_icon_12.png"
    self.bind.go_block = self.isBlock
    if self.isHideFriendBtn then
      self.bind.go_deleteFriendBtn = false
      self.bind.go_addFriendBtn = false
    else
      self.bind.go_deleteFriendBtn = false
      self.bind.go_addFriendBtn = true
    end
    local _, color001 = C_ColorUtility.TryParseHtmlString("#111a22cc")
    self.bind.txt_nameColor = color001
  end
  self.modules.cellHeadPic:setInfoByPlayerId(self.currentPlayerId)
  self.bind.txt_level = "Lv." .. tostring(L_FriendStore:getPlayerLevel(baseInfo))
  local _, outlineColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  self.bindComponents.txt_name.style.useOutline = true
  self.bindComponents.txt_name.style.outlineColor = outlineColor
  self.bindComponents.txt_name.style.outlineWidth = 0.4
  self.bindComponents.txt_name:RefreshStyle()
  local url_defaultHero = L_FriendStore:getPlayerAvatarsHead(baseInfo)
  self.bind.txt_title = L_FriendStore:ParsePlayerTitle(baseInfo)
  if not self.bind.txt_title or string.isEmpty(self.bind.txt_title) or self.bind.txt_title == L_WordsTpl:getValue("residual_code_cellfriendchatinfo_01") then
    self.bind.active_noTitle = true
    self.bind.active_title = false
  else
    self.bind.active_noTitle = false
    self.bind.active_title = true
  end
  self.bind.img_block = self.isBlock and "Atlas/Chat/tex_chat_icon_17_1.png" or "Atlas/Chat/tex_chat_icon_12.png"
  self.bind.txt_state = txt_state
  self.bind.txt_stateColor = txt_stateColor
  self.bind.active_image_state = online
  self.bind.txt_achievement = not baseInfo.stand_plates.achievement_point and "0" or tostring(baseInfo.stand_plates.achievement_point)
  if self.isNestCoop == true then
    self.bind.go_checkBtn = false
    self.bind.go_changeNoteBtn = false
    local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), self.currentPlayerId)
    self.bind.go_accuseBtn = not friend
  end
  if self.isNestCoopMain == true then
    self.bind.go_checkBtn = true
    self.bind.go_changeLeader = false
    self.bind.go_changeNoteBtn = false
    self.bind.go_accuseBtn = false
    if self.selfTeamData.IsLeader then
      self.bind.go_kickOut = true
    end
  end
end

function this:close()
  if self.headTex then
    C_PhotoManager.ReleaseTexture(self.headTex)
    self.headTex = nil
  end
end

function this:setHeadPic(headPath)
  if not string.isEmpty(headPath) then
    self.bind.img_headIcon = headPath
  else
  end
end

function this:setHeadSprite(tex)
  if self.bindComponents.img_headTex ~= nil and tex ~= nil then
    local rect = C_Rect(0, 0, tex.width, tex.height)
    local pivot = C_Vector2.one * 0.5
    self.bindComponents.img_headTex.sprite = Unity.Sprite.Create(tex, rect, pivot)
    self.bindComponents.img_headTex:ClearLoadSpriteData()
    return true
  end
  return false
end

function this:blockFriend()
  if self.isBlock then
    L_FriendStore:req_unblockPlayerChat(self.currentPlayerId)
  else
    L_FriendStore:req_blockPlayerChat(self.currentPlayerId)
  end
end

function this:changeNote()
  local unlock = C_IntegrateMgr.SystemUnlockModule:checkAndTip(L_SystemConst.enum.renameFriend)
  if not unlock then
    return
  end
  local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), self.currentPlayerId)
  if friend == nil then
    return
  end
  local currentRemarkName = string.isEmpty(friend:getFriendMark()) and L_FriendManager:getFriendShowName(self.currentPlayerId) or friend:getFriendMark()
  local data = {
    txtTitle = L_WordsTpl:getValue("ui_friend_modifynotes"),
    placeHolder = L_WordsTpl:getValue("ui_friend_modifynotes_default"),
    txtContent = currentRemarkName,
    limit = L_GameTpl:getGameConstTpl():getFriendMarkLimit() / 2,
    textBoxType = L_Const.CommonTextBoxType.Rename,
    keepPageOpen = true,
    notNewLine = true,
    pageCommonTextBox = 1,
    confirmCallback = function(txt)
      local baseInfo = L_FriendStore:getPlayerBaseInfo(self.currentPlayerId)
      local name = L_FriendStore:getPlayerName(baseInfo)
      if txt == name then
        txt = ""
      end
      local data = {
        id = self.currentPlayerId,
        remark = txt
      }
      L_FriendStore:req_modifyFriendMark(data, function(errCode)
        if errCode == L_Const.errorCode.ErrCodeSucc then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_modifynotes_success"))
          self:refreshPlayerInfo()
          L_UI:close("pageCommonTextBox")
        elseif errCode == L_Const.errorCode.ErrCodeInvalidNick then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_modifynotes_prohibitedwords"))
        end
      end)
    end
  }
  L_GameUtil.showNormalTextBox(data)
end

function this:addBlack()
  if table.count(L_FriendStore:getBlackList()) >= L_GameTpl:getGameConstTpl():getBlackListLimit() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_blacklistfull"))
    return
  end
  local baseInfo = L_FriendStore:getPlayerBaseInfo(self.currentPlayerId)
  local playerName = L_FriendStore:getPlayerName(baseInfo)
  local data = {
    txtContent = L_WordsTpl:getValue("notice_friend_addblacklist", {
      [0] = L_GameUtil.fillColor(playerName, "#3fc4f6")
    }),
    confirmCallback = function()
      self:emit("onClick_close")
      L_FriendManager:operationPlayer(L_Const.friendOpType.blackList, L_Const.friendOp.add, self.currentPlayerId, function()
        local function callback()
          L_FriendStore:call(L_FriendStore.event.refreshIdListByLocalPlayer)
          
          self:emit("onClick_close")
          L_FlyMsgManager:showNormalMsgByKey("tips_friend_addedblacklist", {
            [0] = playerName
          })
          L_ReddotManager._dirtyList[L_ReddotManager.DotDef.FriendPrivateChat_Player] = true
        end
        
        L_ChatStore:deletePlayerChatRecord(self.currentPlayerId, callback)
      end)
    end
  }
  L_GameUtil.showCommonTip(data)
end

function this:delBlack()
  local baseInfo = L_FriendStore:getPlayerBaseInfo(self.currentPlayerId)
  local playerName = L_FriendStore:getPlayerName(baseInfo)
  L_FriendManager:operationPlayer(L_Const.friendOpType.blackList, L_Const.friendOp.delete, self.currentPlayerId, function()
    L_FriendStore:call(L_FriendStore.event.refreshIdListByLocalPlayer)
    self:emit("onClick_close")
    L_FlyMsgManager:showNormalMsgByKey("notice_friend_blacklist_del")
  end)
end

function this:addFriend()
  if self.data.isFriend then
    return
  end
  
  local function callback()
    self:emit("onClick_close")
  end
  
  L_FriendManager:addFriend(self.currentPlayerId, callback)
end

function this:deleteFriend()
  if self.data.isFriend == false then
    return
  end
  local baseInfo = L_FriendStore:getPlayerBaseInfo(self.currentPlayerId)
  local playerName = L_FriendStore:getPlayerName(baseInfo)
  local data = {
    txtContent = L_WordsTpl:getValue("notice_friend_removefriendship", {
      [0] = playerName
    }),
    confirmCallback = function()
      self:emit("onClick_close")
      L_FriendManager:operationPlayer(L_Const.friendOpType.friend, L_Const.friendOp.delete, self.currentPlayerId, function()
        local function callback()
          L_FriendStore:call(L_FriendStore.event.refreshIdListByLocalPlayer)
          
          self:emit("onClick_close")
          local txtShow = L_WordsTpl:getValue("tips_friend_removefriendship", {
            [0] = playerName
          })
          L_FlyMsgManager:showNormalMsg(txtShow)
          L_ReddotManager._dirtyList[L_ReddotManager.DotDef.FriendPrivateChat_Player] = true
        end
        
        L_ChatStore:deletePlayerChatRecord(self.currentPlayerId, callback)
      end)
    end
  }
  L_GameUtil.showCommonTip(data)
end

function this:accusePlayer()
  local baseInfo = L_FriendStore:getPlayerBaseInfo(self.currentPlayerId)
  local playerName = L_FriendStore:getPlayerName(baseInfo)
  local data = {
    reportType = 1,
    pid = self.currentPlayerId,
    name = playerName
  }
  L_GameUtil.showReportPlayerBox(data)
end

function this:accessHome()
  if self.data.isFriend == false then
    return
  end
end

function this:onEvent_refreshFriendList()
end

function this:showLines()
  local lineRoot = self.bindComponents.lineRoot
  local btnPanel = self.bindComponents.panel_btn
  local count = 0
  local childCount = btnPanel.childCount
  for i = 0, childCount - 1 do
    local c = btnPanel:GetChild(i)
    if c.gameObject.activeSelf and c ~= lineRoot then
      count = count + 1
    end
  end
  local lineCount = math.ceil((count - 1) / 3)
  self.bindComponents.vertical.totalCount = 0 < lineCount and lineCount - 1 or 0
  self.bindComponents.horizontal.totalCount = lineCount
  self.bindComponents.vertical:ReloadData()
  self.bindComponents.horizontal:ReloadData()
end

return this
