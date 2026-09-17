local this = {}
local _playerTitleTpl = L_GameTpl:getPlayerTitleTpl()

function this:init()
  this.super.init(self)
  self.data = {
    friendList = {},
    friendApplicationList = {},
    recentTeamList = {},
    blackList = {},
    blockChatList = {},
    baseInfoList = {},
    playerDetailInfoList = {},
    recommandFriendList = {}
  }
end

function this:getFriendList()
  return self.data.friendList
end

function this:getFriendApplicationList()
  return self.data.friendApplicationList
end

function this:getRecommandFriendList()
  return self.data.recommandFriendList
end

function this:getRecentTeamList()
  return self.data.recentTeamList
end

function this:getBlackList()
  return self.data.blackList
end

function this:getBlockChatList()
  return self.data.blockChatList
end

function this:getBaseInfoList()
  return self.data.baseInfoList
end

function this:getPlayerDetailInfoList()
  return self.data.playerDetailInfoList
end

function this:getPlayerItem(playerList, playerUid, isCreate)
  local entity = playerList[playerUid]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "friend.data.playerItem").new()
    playerList[playerUid] = entity
    entity.playerUid = playerUid
  end
  return entity
end

function this:getPlayerBaseInfo(playerUid, isCreate)
  if playerUid == L_PlayerStore:getPlayerId() then
    return L_PlayerStore:getPlayerBaseInfo()
  end
  local baseInfoList = self:getBaseInfoList()
  local entity = baseInfoList[playerUid]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "player.data.playerBaseInfo").new()
    baseInfoList[playerUid] = entity
    entity.playerID = playerUid
  end
  return entity
end

function this:getRecommandFriendBaseInfo(playerUid, isCreate)
  local baseInfoList = self:getRecommandFriendList()
  local entity = baseInfoList[playerUid]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "player.data.playerBaseInfo").new()
    baseInfoList[playerUid] = entity
    entity.playerID = playerUid
  end
  return entity
end

function this:getPlayerUid(baseInfo)
  return baseInfo.id
end

function this:getPlayerZoneId(baseInfo)
  return baseInfo.zone_id
end

function this:getPlayerName(baseInfo)
  return baseInfo.name
end

function this:getPlayerSex(baseInfo)
  return baseInfo.sex
end

function this:getPlayerLevel(baseInfo)
  local playerLevelTpl = L_GameTpl:getPlayerLevelTpl()
  local minLv = playerLevelTpl:getId(playerLevelTpl.data[1])
  local maxLv = playerLevelTpl:getId(playerLevelTpl.data[#playerLevelTpl.data])
  local curLv = math.clamp(baseInfo.lv, minLv, maxLv)
  return curLv, curLv == maxLv
end

function this:getPlayerOffLineTime(baseInfo)
  if baseInfo == nil then
    return 0
  end
  return baseInfo.offlinetm
end

function this:getPlayerOnLineTime(baseInfo)
  if baseInfo == nil then
    return 0
  end
  return baseInfo.onlinetm
end

function this:getPlayerIsOnline(baseInfo)
  if baseInfo == nil then
    return false
  end
  return baseInfo.onlinetm - baseInfo.offlinetm >= 0
end

function this:getPlayerIsBusy(baseInfo)
  if baseInfo == nil then
    return false
  end
  return baseInfo.is_busy
end

function this:getPlayerIsInTeam(baseInfo)
  return baseInfo.team_id ~= 0
end

function this:getPlayerIsInWorld(baseInfo)
  return C_TDWorldCityTable.GetWorldType(baseInfo.map_id) == C_EWorldType.World
end

function this:getPlayerAvatars(baseInfo, avatarTextureIndex)
  local isDefault = false
  for i, v in pairs(baseInfo.wardrobe.avatars or {}) do
    if v.avatar_type == L_Const.avatarTextureIndex2screenShotType[avatarTextureIndex] then
      return v.avatar_url
    end
  end
  local screenShotType = L_Const.avatarTextureIndex2screenShotType[avatarTextureIndex]
  isDefault = true
  if screenShotType then
    return screenShotType, isDefault
  end
  return L_Const.screenShotType.hearHeadImg
end

function this:getPlayerAvatarsHead(baseInfo)
  return string.isEmpty(baseInfo.little_avatar) and self:getPlayerAvatars(baseInfo, L_Const.avatarTextureIndex.head) or baseInfo.little_avatar
end

function this:getPlayerAvatarsFormationHead(baseInfo)
  return self:getPlayerAvatars(baseInfo, L_Const.avatarTextureIndex.half_formation)
end

function this:getPlayerWardrobe(baseInfo)
  return baseInfo.wardrobe
end

function this:getPlayerSign(baseInfo)
  return baseInfo.sign
end

function this:getPlayerAccount(baseInfo)
  return baseInfo.account
end

function this:getPlayerRegisterTime(baseInfo)
  return baseInfo.regtm
end

function this:getPlayerDiamond(baseInfo)
  return baseInfo.diamond
end

function this:getPlayerExp(baseInfo)
  return baseInfo.exp
end

function this:getPlayerAchievement(baseInfo)
  local res = {
    0,
    0,
    0
  }
  if baseInfo == nil or baseInfo.info.achievement == nil then
    return res
  end
  for i, v in pairs(baseInfo.info.achievement) do
    res[i] = v
  end
  return res
end

function this:getPlayerDisplayHero(baseInfo)
  local data = baseInfo.info or {}
  local hero = data.hero or {}
  local res = {}
  for i, v in pairs(hero) do
    res[v.pos] = v
  end
  return res
end

function this:getPlayerDisplayPet(baseInfo)
  if baseInfo == nil or baseInfo.info.pet == nil then
    return {}
  end
  return baseInfo.info.pet
end

function this:ParsePlayerTitle(baseInfo)
  local tpl_preTitle = _playerTitleTpl:getTplById(self:getPreTitle(baseInfo))
  local tpl_laterTitle = _playerTitleTpl:getTplById(self:getLaterTitle(baseInfo))
  local special_preTitle = _playerTitleTpl:getSpecial(tpl_preTitle)
  local special_laterTitle = _playerTitleTpl:getSpecial(tpl_laterTitle)
  local preTitle, laterTitle = "", ""
  if special_preTitle == 1 and special_laterTitle == 1 then
    laterTitle = _playerTitleTpl:getName(tpl_laterTitle)
  elseif special_preTitle == 1 and special_laterTitle ~= 1 then
    laterTitle = _playerTitleTpl:getName(tpl_laterTitle)
  elseif special_preTitle ~= 1 and special_laterTitle == 1 then
    preTitle = _playerTitleTpl:getName(tpl_preTitle)
  else
    preTitle = _playerTitleTpl:getName(tpl_preTitle)
    laterTitle = _playerTitleTpl:getName(tpl_laterTitle)
  end
  return string.concat(preTitle, laterTitle)
end

function this:getPreTitle(baseInfo)
  return baseInfo.preffix_title == 0 and 171000 or baseInfo.preffix_title
end

function this:getLaterTitle(baseInfo)
  return baseInfo.suffix_title == 0 and 172000 or baseInfo.suffix_title
end

function this:getPlayerBirthday(baseInfo)
  return baseInfo.birthday
end

function this:getIsFriend(guid)
  local player = self:getPlayerItem(self.data.friendList, guid)
  return not table.isEmpty(player)
end

function this:getIsFriendApplication(guid)
  local player = self:getPlayerItem(self.data.friendApplicationList, guid)
  return not table.isEmpty(player)
end

function this:getIsRecentTeam(guid)
  local player = self:getPlayerItem(self.data.recentTeamList, guid)
  return not table.isEmpty(player)
end

function this:getIsBlackList(guid)
  local player = self:getPlayerItem(self.data.blackList, guid)
  return not table.isEmpty(player)
end

function this:getIsBlockChatList(guid)
  local player = self:getPlayerItem(self.data.blockChatList, guid)
  return not table.isEmpty(player)
end

function this:getFriendViewLst()
  local tmp = {}
  local player = self:getFriendList()
  for i, v in pairs(player) do
    local baseInfo = self:getPlayerBaseInfo(v:getPlayerUid())
    local online = self:getPlayerIsOnline(baseInfo)
    local busy = false
    local txt_state = L_TimeUtil.getOfflineTimeDisplay(self:getPlayerOnLineTime(baseInfo), self:getPlayerOffLineTime(baseInfo))
    if online and self:getPlayerIsBusy(baseInfo) then
      busy = true
      online = false
      txt_state = L_GameUtil.fillColor(L_WordsTpl:getValue("ui_moduleRecentTeam"), L_Const.colorHtml.yellow0)
    end
    local offLine = not online and not busy
    local friend = self:getPlayerItem(self:getFriendList(), v:getPlayerUid())
    local isMark = not string.isEmpty(friend:getFriendMark())
    table.insert(tmp, {
      uid = v:getPlayerUid(),
      txt_name = isMark and friend:getFriendMark() or L_FriendManager:getFriendShowName(v:getPlayerUid()),
      txt_level = tostring(self:getPlayerLevel(baseInfo)),
      go_block = self:getIsBlockChatList(v:getPlayerUid()),
      go_state = true,
      txt_state = txt_state,
      txt_title = self:ParsePlayerTitle(baseInfo),
      txt_achievement = not baseInfo.stand_plates.achievement_point and "0" or tostring(baseInfo.stand_plates.achievement_point),
      state_online = online,
      state_offline = offLine,
      state_busy = busy,
      operate_friend = true,
      operate_apply = false,
      url_defaultHero = self:getPlayerAvatarsHead(baseInfo),
      is_mark = isMark,
      active_line = true
    })
  end
  table.sort(tmp, function(a, b)
    local baseInfoA = self:getPlayerBaseInfo(a.uid)
    local baseInfoB = self:getPlayerBaseInfo(b.uid)
    local onlineA = self:getPlayerIsOnline(baseInfoA) and 0 or 1
    local onlineB = self:getPlayerIsOnline(baseInfoB) and 0 or 1
    if onlineA == 0 and onlineB == 0 then
      local friendItemA = self:getPlayerItem(self:getFriendList(), a.uid)
      local friendItemB = self:getPlayerItem(self:getFriendList(), b.uid)
      local timeA = friendItemA:getInsertTime()
      local timeB = friendItemB:getInsertTime()
      return timeA < timeB
    elseif onlineA == 1 and onlineB == 1 then
      local offlineTimeA = self:getPlayerOffLineTime(baseInfoA)
      local offlineTimeB = self:getPlayerOffLineTime(baseInfoB)
      return offlineTimeA > offlineTimeB
    else
      return onlineA < onlineB
    end
  end)
  if 0 < #tmp then
    tmp[#tmp].active_line = false
  end
  return tmp
end

function this:getFriendMarkName(id)
  local friend = self:getPlayerItem(self:getFriendList(), id)
  if friend and not string.isEmpty(friend:getFriendMark()) then
    return friend:getFriendMark()
  end
  return nil
end

return this
