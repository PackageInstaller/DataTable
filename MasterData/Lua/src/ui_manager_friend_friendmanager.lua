local this = class("friendManager")

function this:initialize()
  self.cacheViewPlayerTime = {}
end

function this:requestBaseInfo(types, players, callback)
  if table.isEmpty(players) then
    if callback then
      callback()
    end
    return
  end
  local data = {types = types, player_ids = players}
  L_FriendStore:req_queryPlayerBaseInfo(data, function(rspData, errCode)
    if table.isEmpty(rspData) then
      L_FriendStore:call(L_FriendStore.event.refreshTipNoPlayerInfo)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_friend_search_entercorrectid"))
    elseif errCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:requestBaseInfoAll(playerId, callback)
  local players = {playerId}
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_ALL
  }
  self:requestBaseInfo(types, players, function()
    if callback then
      callback()
    end
  end)
end

function this:requestCanInvitePlayerInfo(teamType, dungeonId, callback)
  local playerList = L_FriendStore:getFriendList()
  local players = {}
  for _, v in pairs(playerList) do
    table.insert(players, v:getPlayerUid())
  end
  if #players == 0 then
    if callback then
      callback()
    end
    return
  end
  local data = {
    types = {
      L_Const.PlayerBasicQueryType.PBQT_ALL
    },
    player_ids = players,
    dungeon_query_list = {
      {campaign_type = teamType, dungeon_system_id = dungeonId}
    }
  }
  L_FriendStore:req_queryPlayerBaseInfo(data, function(rspData, errCode)
    if table.isEmpty(rspData) then
      L_FriendStore:call(L_FriendStore.event.refreshTipNoPlayerInfo)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_friend_search_entercorrectid"))
    elseif errCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:ViewPlayerInfo(playerId, callback, Teamtype, pos, onSelectCallBack, isNotOpenPage, clickBgClose, clickCloseByUpdate, inputTeamData, isHideFriendBtn)
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_ALL
  }
  local players = {playerId}
  local request = false
  local playerBaseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  if playerBaseInfo ~= nil then
    local curTime = L_TimeUtil.getServerTime()
    self.cacheViewPlayerTime = self.cacheViewPlayerTime or {}
    local lastReqTime = self.cacheViewPlayerTime[playerId]
    if lastReqTime == nil or 3 < curTime - lastReqTime then
      request = true
      self.cacheViewPlayerTime[playerId] = curTime
    end
  else
    request = true
  end
  
  local function reqCallBackFunc()
    if not isNotOpenPage then
      L_UI:open("pagePlayerDetailInfo", {
        inputTeamData = inputTeamData,
        uid = playerId,
        isTeam = Teamtype,
        pos = pos,
        onSelectCallBack = onSelectCallBack,
        clickBgClose = clickBgClose,
        clickCloseByUpdate = clickCloseByUpdate,
        isHideFriendBtn = isHideFriendBtn
      })
    end
    if callback then
      callback()
    end
  end
  
  if request then
    L_FriendManager:requestBaseInfo(types, players, reqCallBackFunc)
  else
    reqCallBackFunc()
  end
end

function this:OpenPlayerDetailInfo(playerId, teamType, pos, onSelectCallBack, visibleButtons)
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_ALL
  }
  local players = {playerId}
  local request = false
  local playerBaseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  if playerBaseInfo ~= nil then
    local curTime = L_TimeUtil.getServerTime()
    self.cacheViewPlayerTime = self.cacheViewPlayerTime or {}
    local lastReqTime = self.cacheViewPlayerTime[playerId]
    if lastReqTime == nil or 3 < curTime - lastReqTime then
      request = true
      self.cacheViewPlayerTime[playerId] = curTime
    end
  else
    request = true
  end
  
  local function reqCallBackFunc()
    L_UI:open("pagePlayerDetailInfo", {
      uid = playerId,
      isTeam = teamType,
      pos = pos,
      onSelectCallBack = onSelectCallBack,
      clickBgClose = true,
      clickCloseByUpdate = true,
      visibleButtons = visibleButtons
    })
  end
  
  if request then
    L_FriendManager:requestBaseInfo(types, players, reqCallBackFunc)
  else
    reqCallBackFunc()
  end
end

function this:ViewPlayerInfoWithMatTeamMatchBgClose(playerId, callback, teamType, pos, inputTeamData)
  self:ViewPlayerInfo(playerId, callback, teamType, pos, nil, false, true, nil, inputTeamData)
end

function this:ViewPlayerInfoWithOutFriendBtn(playerId, callback, teamType, pos, inputTeamData)
  self:ViewPlayerInfo(playerId, callback, teamType, pos, nil, false, true, nil, inputTeamData, true)
end

function this:ViewPlayerInfoWithBgClose(playerId, callback, teamType, pos, onSelectCallBack)
  self:ViewPlayerInfo(playerId, callback, teamType, pos, onSelectCallBack, false, true)
end

function this:ViewPlayerInfoWithBgCloseNoConsume(playerId, callback, teamType, pos, onSelectCallBack)
  self:ViewPlayerInfo(playerId, callback, teamType, pos, onSelectCallBack, false, false, true)
end

function this:viewPlayerCard(playerId)
  local reqCount = 0
  
  local function getNotShowAccess()
    local selfTeamData = C_MultiTeam.GetSelfTeamData()
    return C_MultiTeam.isMultiBattleTeam() and selfTeamData ~= nil and selfTeamData.IsReady and not selfTeamData.IsLeader
  end
  
  local function endDo()
    local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
    L_PhotoManager:loadHeadTex(L_FriendStore:getPlayerAvatarsHead(baseInfo), function(tex)
      reqCount = reqCount + 1
      if reqCount == 2 then
        L_UI:open("pagePlayerCard", {
          uid = playerId,
          notShowAccess = getNotShowAccess()
        })
      end
      if tex then
        C_PhotoManager.ReleaseTexture(tex)
      end
    end, nil, nil, baseInfo)
    L_PhotoManager:loadHeadTex(L_FriendStore:getPlayerAvatars(baseInfo, L_Const.avatarTextureIndex.painting), function(tex)
      reqCount = reqCount + 1
      if reqCount == 2 then
        L_UI:open("pagePlayerCard", {
          uid = playerId,
          notShowAccess = getNotShowAccess()
        })
      end
      if tex then
        C_PhotoManager.ReleaseTexture(tex)
      end
    end, nil, nil, baseInfo)
  end
  
  if playerId == L_PlayerStore:getPlayerId() then
    endDo()
  else
    self:requestBaseInfoAll(playerId, endDo)
  end
end

function this:operationPlayer(opType, op, playerId, callback)
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  local data = {
    optype = opType,
    op = op,
    id = playerId
  }
  L_FriendStore:req_operationPlayer(data, function(errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if opType == L_Const.friendOpType.friend and op == L_Const.friendOp.delete or opType == L_Const.friendOpType.blackList and op == L_Const.friendOp.add then
        L_ChatStore:rsp_unmarkChat({del = playerId})
      end
      if callback then
        callback()
      end
    elseif errorCode == L_Const.errorCode.ErrCodeTargetGetYourApply then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_repeatapply"))
    elseif errorCode == L_Const.errorCode.ErrCodeYouBanTarget then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_blacklist"))
    elseif errorCode == L_Const.errorCode.ErrCodeTargetBanYou then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_blacklist_otherside"))
    elseif errorCode == L_Const.errorCode.ErrCodeHadFriend then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_alreadybefriends"))
    elseif errorCode == L_Const.errorCode.ErrCodeTargetFriendApplyNumMax then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_friend_applicationfull"))
    elseif errorCode == L_Const.errorCode.ErrCodeTargetFriendNumMax then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_list_limit_otherside"))
      L_FriendManager:operationPlayer(L_Const.friendOpType.application, L_Const.friendOp.delete, playerId)
    elseif errorCode == L_Const.errorCode.ErrCodeFriendNumMax then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_list_limit"))
    end
  end)
end

function this:modifyFriendMark(playerUid)
  local systemId = L_SystemConst.enum.renameFriend
  if L_SystemBreakManager:checkBanSystemAndTip(systemId) then
    return
  end
  local data = {
    txtTitle = L_WordsTpl:getValue("ui_modifyRemarks"),
    placeHolder = L_WordsTpl:getValue("ui_importRemarks"),
    limit = 5,
    textBoxType = L_Const.CommonTextBoxType.Rename,
    confirmCallback = function(txt)
      if string.gsub(txt, " ", "") ~= txt then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_hintRemark_01"))
        return
      end
      local data = {id = playerUid, remark = txt}
      L_FriendStore:req_modifyFriendMark(data, function(errCode)
        if errCode == L_Const.errorCode.ErrCodeSucc then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_modifyRemarksSucceed"))
        elseif errCode == L_Const.errorCode.ErrCodeInvalidNick then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_idcard_4"))
        end
      end)
    end
  }
  L_GameUtil.showNormalTextBox(data)
end

function this:requestRecommandFriends(callback)
  local data = {}
  L_FriendStore:req_recommandFriend(data, function(errorCode)
    if callback then
      callback(errorCode)
    end
  end)
end

function this:getFriendShowName(playerUid)
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerUid)
  local name = L_FriendStore:getPlayerName(baseInfo)
  local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), playerUid)
  if not string.isEmpty(friend:getFriendMark()) then
    name = string.format("%s(%s)", name, friend:getFriendMark())
  end
  return name
end

function this:addFriend(playerUid, callback)
  if table.count(L_FriendStore:getFriendList()) >= L_GameTpl:getGameConstTpl():getFriendLimit() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_list_limit"))
    return
  end
  self:operationPlayer(L_Const.friendOpType.application, L_Const.friendOp.add, playerUid, function()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_friend_sending_success"))
    if callback then
      callback()
    end
  end)
end

local tmp_map = {}

function this:loadHeroHeadTex(playerUid, typeName, callback, configId)
  local female_id = L_GameConstTpl:getData("AVATAR_HERO_ID_FEMALE", L_Const.GameTplType.int)
  local male_id = L_GameConstTpl:getData("AVATAR_HERO_ID_MALE", L_Const.GameTplType.int)
  local head_sex = 1
  if configId == female_id then
    head_sex = 2
  end
  if configId == male_id then
    head_sex = 1
  end
  local baseInfo = tmp_map[playerUid]
  local isforce = false
  if baseInfo ~= nil and baseInfo.sex ~= head_sex then
    isforce = true
  end
  if baseInfo ~= nil and isforce == false then
    local url = L_FriendStore:getPlayerAvatars(baseInfo, typeName)
    if string.isEmpty(url) then
      url = L_Const.avatarTextureIndex2screenShotType[typeName]
    end
    L_PhotoManager:loadHeadTex(url, callback, nil, nil, baseInfo)
  else
    local players = {playerUid}
    local types = {
      L_Const.PlayerBasicQueryType.PBQT_ALL
    }
    local data = {types = types, player_ids = players}
    L_FriendStore:req_queryPlayerBaseInfo(data, function(rspData, errCode)
      if rspData.player_infos ~= nil and #rspData.player_infos > 0 then
        local info = rspData.player_infos[1]
        tmp_map[playerUid] = info
        local urls = L_FriendStore:getPlayerAvatars(info, typeName)
        if string.isEmpty(urls) then
          urls = L_Const.avatarTextureIndex2screenShotType[typeName]
        end
        L_PhotoManager:loadHeadTex(urls, callback, nil, nil, info)
      end
    end)
  end
end

local _waitLoadHeroHeadTexArray, _waitLoadHeroHeadTexTime

function this:loadHeroHeadTexTimeLater(playerUid, typeName, callback, configId)
  local head_sex = configId and C_GameUtil.GetSexByHeroId(configId) or L_Const.sexType.male
  local baseInfo = tmp_map[playerUid]
  local isforce = false
  if baseInfo ~= nil and baseInfo.sex ~= head_sex then
    isforce = true
  end
  if baseInfo ~= nil and isforce == false then
    local url = L_FriendStore:getPlayerAvatars(baseInfo, typeName)
    if string.isEmpty(url) then
      url = L_Const.avatarTextureIndex2screenShotType[typeName]
    end
    L_PhotoManager:loadHeadTex(url, callback, nil, nil, baseInfo)
  else
    if _waitLoadHeroHeadTexArray == nil then
      _waitLoadHeroHeadTexArray = {}
      _waitLoadHeroHeadTexTime = Timer.once(0.2, function()
        self:reqQueryPlayerBaseInfoArray(_waitLoadHeroHeadTexArray)
        Timer.remove(_waitLoadHeroHeadTexTime)
        _waitLoadHeroHeadTexTime = nil
        _waitLoadHeroHeadTexArray = nil
      end, self)
    end
    table.insert(_waitLoadHeroHeadTexArray, {playerUid, callback})
  end
end

function this:reqQueryPlayerBaseInfoArray(heroHeadTexArray)
  if heroHeadTexArray == nil then
    return
  end
  local playerDic = {}
  local players = {}
  local playerId
  for _, value in ipairs(heroHeadTexArray) do
    playerId = value[1]
    if playerDic[playerId] == nil then
      table.insert(players, playerId)
      playerDic[playerId] = 1
    end
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_ALL
  }
  local data = {types = types, player_ids = players}
  L_FriendStore:req_queryPlayerBaseInfo(data, function(rspData, errCode)
    if rspData.player_infos ~= nil and #rspData.player_infos > 0 then
      local typeName = 4
      for _, info in ipairs(rspData.player_infos) do
        tmp_map[info.id] = info
        if heroHeadTexArray then
          for _, value in ipairs(heroHeadTexArray) do
            if info.id == value[1] then
              local urls = L_FriendStore:getPlayerAvatars(info, typeName)
              if string.isEmpty(urls) then
                urls = L_Const.avatarTextureIndex2screenShotType[typeName]
              end
              L_PhotoManager:loadHeadTex(urls, value[2], nil, nil, info)
            end
          end
        end
      end
    end
  end)
end

function this:getPlayerHeadTex(playerUid, callback)
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerUid)
  if baseInfo ~= nil then
    L_PlayerDisplayStore:loadHeadPic(baseInfo, callback)
  else
    local players = {playerUid}
    local types = {
      L_Const.PlayerBasicQueryType.PBQT_ALL
    }
    local data = {types = types, player_ids = players}
    L_FriendStore:req_queryPlayerBaseInfo(data, function(rspData, errCode)
      if rspData.player_infos ~= nil and #rspData.player_infos > 0 then
        local info = rspData.player_infos[1]
        L_PlayerDisplayStore:loadHeadPic(info, callback)
      end
    end)
  end
end

function this:dispose()
  self.cacheViewPlayerTime = {}
  tmp_map = {}
  _waitLoadHeroHeadTexArray = nil
  if _waitLoadHeroHeadTexTime then
    Timer.remove(_waitLoadHeroHeadTexTime)
  end
  _waitLoadHeroHeadTexTime = nil
end

return this
