local UserInfoData = class("UserInfoData")
local tinyGameEnum = require("Game.TinyGames.TinyGameEnum")
local DormFightRecordData = require("Game.DormFight.Data.DormFightRecordData")
local MilestoneData = require("Game.MileStone.Data.MilestoneData")
local userStatisticKey = {
  None = 0,
  dormThemeNum = 1,
  skinNum = 2,
  achievementNum = 3
}

function UserInfoData:ctor()
  self.isSelfInfo = nil
  self.isFriendInfo = nil
  self.UID = nil
  self.name = nil
  self.alias = nil
  self.avatarId = nil
  self.avatarFrameId = nil
  self.level = nil
  self.exp = nil
  self.signature = nil
  self.sex = nil
  self.showGirlId = nil
  self.backgroudPlateId = nil
  self.supportHeroInfoList = {}
  self.createRelativeTm = nil
  self.title = nil
  self.hasHeroNum = nil
  self.epProgress = {}
  self.infinityLevelSum = nil
  self.buildingTotalLevel = nil
  self.defaultTowerProgress = nil
  self.furnitureCollection = nil
  self.skinCollection = nil
  self.achievementAttachRate = nil
  self.__milestoneMsg = nil
  self.msData = nil
  self.__lastOffLineTm = nil
  self.__lastOnLineTm = nil
  self.__isNewFriend = false
  self.__tinyGameDic = {}
  self.dormFight1v1RecordData = DormFightRecordData.New()
  self.__lastRefreshTs = nil
  self.isOnline = false
  self.toggleFriendFightInvitation = false
  self.actItems = {}
end

function UserInfoData.CreateDataWithAvatarMsg(avatarMsg)
  local data = UserInfoData.New()
  local biref = avatarMsg.biref
  local stc = avatarMsg.stc
  local dyc = avatarMsg.dyc
  data.UID = biref.uid
  data.name = biref.name
  data.avatarId = biref.avatar
  data.avatarFrameId = biref.avatarFrame
  data.level = biref.lv
  data.exp = biref.exp
  data.signature = biref.signature
  data.sex = biref.sex
  data.showGirlId = biref.showGirl
  data.backgroudPlateId = biref.backgroudPlate
  data.createRelativeTm = biref.bornTs
  data.__lastOffLineTm = biref.offlineTs or 0
  data.__lastOnLineTm = biref.loginTm or 0
  data.__lastRefreshTs = PlayerDataCenter.timestamp
  data.title = biref.title
  if stc ~= nil then
    data.hasHeroNum = stc.heroNum
    data:SetEpProgress(stc.maxStageId)
    data.infinityLevelSum = stc.endlessSum
    data.buildingTotalLevel = stc.oasisBuildingLevelSum
    data.furnitureCollection = stc.statistics[userStatisticKey.dormThemeNum] or 0
    data.skinCollection = stc.statistics[userStatisticKey.skinNum] or 0
    data.achievementAttachRate = stc.statistics[userStatisticKey.achievementNum] or 0
    data.actItems = stc.actItems or {}
    data.actDelivery = stc.actDelivery or table.emptytable
    local defaultTowerId = PlayerDataCenter.dungeonTowerSData:GetDefaultTowerId()
    for _, towerRecord in pairs(stc.towers) do
      if defaultTowerId == towerRecord.towerId then
        data.defaultTowerProgress = towerRecord.currentCompletedId
        break
      end
    end
    data.__milestoneMsg = stc.milestone
    if stc.extra ~= nil then
      data.__birdData = stc.extra.bird
      data.__game2048 = stc.extra.game2048
      data.__damieData = stc.extra.damie
      if stc.extra.tinyGames ~= nil then
        for _, tinyGame in ipairs(stc.extra.tinyGames) do
          if data.__tinyGameDic[tinyGame.gameCat] == nil then
            data.__tinyGameDic[tinyGame.gameCat] = {}
          end
          data.__tinyGameDic[tinyGame.gameCat][tinyGame.gameId] = tinyGame
        end
      end
      if stc.extra.fightScore ~= nil then
        data.dormFight1v1RecordData = DormFightRecordData.New(stc.extra.fightScore[1])
      end
    end
  end
  for i = 1, 3 do
    if dyc == nil or dyc.assistsBrief[i] == nil then
      data.supportHeroInfoList[i] = false
    else
      data.supportHeroInfoList[i] = {
        assistsBrief = dyc.assistsBrief[i],
        assistsRandom = dyc.assistsRandom[i]
      }
    end
  end
  if dyc ~= nil then
    data.isOnline = dyc.isOnline
    data.toggleFriendFightInvitation = dyc.toggleFriendFightInvitation
    data.assistFactor = dyc.assistFactor
  end
  return data
end

function UserInfoData.CreateSelfData(userBrief)
  local avatarMsg = userBrief.avatar
  local data = UserInfoData.CreateDataWithAvatarMsg(avatarMsg)
  data.isSelfInfo = true
  data.isFriendInfo = false
  if userBrief.userBase ~= nil then
    data:SetSupportPointData(userBrief.userBase.astPoint)
  end
  data.msData = MilestoneData.New(data)
  return data
end

function UserInfoData.CreateFriendDataWithAvatarMsg(avatarMsg)
  local data = UserInfoData.CreateDataWithAvatarMsg(avatarMsg)
  data.isSelfInfo = false
  data.isFriendInfo = true
  return data
end

function UserInfoData.CreateStrangerDataWithAvatarMsg(avatarMsg)
  local data = UserInfoData.CreateDataWithAvatarMsg(avatarMsg)
  data.isSelfInfo = false
  data.isFriendInfo = false
  return data
end

function UserInfoData:UpdateUserDoc(UserData)
  self.avatarId = UserData.avatar
  self.avatarFrameId = UserData.avatarFrame
  self.signature = UserData.signature
  self.sex = UserData.sex
  self.backgroudPlateId = UserData.backgroudPlate
end

function UserInfoData:UpdateByAvatarMsg(avatarMsg)
  local biref = avatarMsg.biref
  local stc = avatarMsg.stc
  local dyc = avatarMsg.dyc
  self.UID = biref.uid
  self.name = biref.name
  self.avatarId = biref.avatar
  self.avatarFrameId = biref.avatarFrame
  self.level = biref.lv
  self.exp = biref.exp
  self.signature = biref.signature
  self.sex = biref.sex
  self.backgroudPlateId = biref.backgroudPlate
  self.createRelativeTm = biref.bornTs
  self.__lastRefreshTs = PlayerDataCenter.timestamp
  self.__lastOffLineTm = biref.offlineTs or 0
  self.__lastOnLineTm = biref.loginTm or 0
  self.title = biref.title
  self.returnTm = biref.returnTm
  if stc ~= nil then
    self.hasHeroNum = stc.heroNum
    self:SetEpProgress(stc.maxStageId)
    self.infinityLevelSum = stc.endlessSum
    self.buildingTotalLevel = stc.oasisBuildingLevelSum
    self.__milestoneMsg = stc.milestone
    self.actDelivery = stc.actDelivery or table.emptytable
    if stc.extra ~= nil then
      self.__birdData = stc.extra.bird
      self.__game2048 = stc.extra.game2048
      self.__damieData = stc.extra.damie
      if stc.extra.tinyGames ~= nil then
        for _, tinyGame in ipairs(stc.extra.tinyGames) do
          if self.__tinyGameDic[tinyGame.gameCat] == nil then
            self.__tinyGameDic[tinyGame.gameCat] = {}
          end
          self.__tinyGameDic[tinyGame.gameCat][tinyGame.gameId] = tinyGame
        end
      end
      if stc.extra.fightScore ~= nil then
        self.dormFight1v1RecordData:UpdateRecord(stc.extra.fightScore[1])
      end
    end
  end
  for i = 1, 3 do
    if dyc == nil or dyc.assistsBrief[i] == nil then
      self.supportHeroInfoList[i] = false
    else
      self.supportHeroInfoList[i] = {
        assistsBrief = dyc.assistsBrief[i],
        assistsRandom = dyc.assistsRandom[i]
      }
    end
  end
  if dyc ~= nil then
    self.isOnline = dyc.isOnline
    self.toggleFriendFightInvitation = dyc.toggleFriendFightInvitation
  end
  if self.msData ~= nil then
    self.msData:UpdateMilestoneData(self)
  end
end

function UserInfoData:UpdateMilestone(milestoneMsg)
  self.__milestoneMsg = milestoneMsg
  self.msData:UpdateMilestoneData(self)
end

function UserInfoData:GetIsSelfUserInfo()
  return self.isSelfInfo
end

function UserInfoData:GetUserName()
  if self.isSelfInfo then
    return PlayerDataCenter.playerName
  end
  return self.name or tostring(self.UID)
end

function UserInfoData:GetUserUID()
  return self.UID
end

function UserInfoData:GetAvatarId()
  return self.avatarId
end

function UserInfoData:GetAvatarFrameId()
  return self.avatarFrameId
end

function UserInfoData:GetAvatarTitleId()
  return self.title
end

function UserInfoData:GetAvatarSignature()
  return self.signature
end

function UserInfoData:GetSex()
  return self.sex
end

function UserInfoData:SetSex(isGril)
  self.sex = isGril
end

function UserInfoData:GetBackgroudPlateId()
  return self.backgroudPlateId
end

function UserInfoData:GetShowGirlId()
  local ret = self.showGirlId
  if ret == nil or ret == 0 then
    ret = ConfigData.game_config.firtBoardHeroID
  end
  return ret
end

function UserInfoData:GetUserLevel()
  if self.isSelfInfo then
    return PlayerDataCenter.playerLevel.level
  end
  return self.level or 1
end

function UserInfoData:IsOnline()
  return self.isOnline
end

function UserInfoData:IsRejectInvitation()
  return self.toggleFriendFightInvitation
end

function UserInfoData:GetCreateTime()
  return self.createRelativeTm
end

function UserInfoData:GetHasHeroNum()
  if self.isSelfInfo then
    return PlayerDataCenter.heroCount - PlayerDataCenter.hideHeroCount
  end
  return self.hasHeroNum or 0
end

function UserInfoData:SetEpProgress(maxStageId)
  self.epProgress.sectorId = 0
  self.epProgress.stageIndex = 0
  for _, chapterId in ipairs(ConfigData.sector_sector_resident.sectorChapterIdList) do
    local chapterCfg = ConfigData.sector_sector_resident[chapterId]
    local sectorId = chapterCfg.relevancy_parameter
    local sectorStage = ConfigData.sector_stage.sectorIdList[sectorId]
    if sectorStage then
      for stageIndex, stageId in ipairs(sectorStage) do
        if stageId == maxStageId then
          self.epProgress.sectorId = ConfigData:GetSectorIdShow(sectorId)
          self.epProgress.stageIndex = stageIndex
          return
        end
      end
    end
  end
end

function UserInfoData:SetTitle(preId, postId, bgId)
  if preId == nil then
    self.title = nil
    return
  end
  self.title = self.title or {}
  self.title.titlePrefix = preId
  self.title.titlePostfix = postId
  self.title.titleBackGround = bgId
end

function UserInfoData:GetEpProgress()
  if self.isSelfInfo then
    local sectorId, stageIndex = PlayerDataCenter.sectorStage:GetEpStageCfg4UserInfo()
    local showSectorId = ConfigData:GetSectorIdShow(sectorId)
    return {sectorId = showSectorId, stageIndex = stageIndex}
  end
  return self.epProgress or {sectorId = 0, stageIndex = 0}
end

function UserInfoData:GetInfinityLevelSum()
  if self.isSelfInfo then
    return PlayerDataCenter.infinityData:GetCompletedInfinityLevelNum() * 10
  end
  return self.infinityLevelSum or 0
end

function UserInfoData:GetBuildingTotalLevel()
  if self.isSelfInfo then
    local totalLevel = 0
    for key, value in pairs(PlayerDataCenter.AllBuildingData.oasisBuilt) do
      totalLevel = totalLevel + value.level
    end
    return totalLevel
  end
  return self.buildingTotalLevel or 0
end

function UserInfoData:GetDefaultTowerProgress()
  if self.isSelfInfo then
    return PlayerDataCenter.dungeonTowerSData:GetDefaultTowerCompleteLevel()
  end
  return self.defaultTowerProgress or 0
end

function UserInfoData:GetFurnitureCollection()
  if self.isSelfInfo then
    local num = 0
    for themeId, themeCfg in pairs(ConfigData.dorm_theme) do
      for id, num in pairs(themeCfg.theme_furniture_id) do
        local furnitureNum = PlayerDataCenter:GetItemCount(id) + PlayerDataCenter.dormBriefData:GetFurnitureItemCountInDorm(id)
        if num > furnitureNum then
          goto lbl_29
        end
      end
      num = num + 1
      ::lbl_29::
    end
    return num
  end
  return self.furnitureCollection or 0
end

function UserInfoData:GetSkinCollection()
  if self.isSelfInfo then
    local themeSkinNum = 0
    for themeId, skinList in pairs(ConfigData.skin.themeDic) do
      local themeCfg = ConfigData.skinTheme[themeId]
      if not themeCfg.lock_theme then
        for _, skinId in ipairs(skinList) do
          if PlayerDataCenter.skinData:IsHaveSkin(skinId) then
            themeSkinNum = themeSkinNum + 1
          end
        end
      end
    end
    return themeSkinNum
  end
  return self.skinCollection or 0
end

function UserInfoData:GetAchievementAttachNum()
  if self.isSelfInfo then
    local cur = PlayerDataCenter.achivLevelData:GetPickedAchNum() or 0
    local total = PlayerDataCenter.achivLevelData:GetTotalAchNum() or 0
    local rate = 0
    if cur ~= 0 and total ~= 0 then
      rate = math.floor(cur / total * 100)
    end
    return rate
  end
  local cur = self.achievementAttachRate
  local total = PlayerDataCenter.achivLevelData:GetTotalAchNum()
  return math.floor(cur / total * 100)
end

function UserInfoData:GetMilestoneMsg()
  return self.__milestoneMsg
end

function UserInfoData:GetMilestoneData()
  if self.msData == nil then
    self.msData = MilestoneData.New(self)
  end
  return self.msData
end

function UserInfoData:GetIsNeedFreshData()
  if self.__lastRefreshTs == nil then
    return true
  end
  if PlayerDataCenter.timestamp - self.__lastRefreshTs > ConfigData.game_config.userInfoRefreshTime then
    return true
  end
  return false
end

function UserInfoData:GetSupportHoreInfoList()
  return self.supportHeroInfoList
end

function UserInfoData:GetSupportHoreIdDic()
  local dic = {}
  for index, value in ipairs(self.supportHeroInfoList) do
    if value ~= false then
      dic[value.assistsBrief.id] = true
    end
  end
  return dic
end

function UserInfoData:GetSupportFactCardList()
  return self.assistFactor
end

function UserInfoData:GetSupportHeroDataById(briefId)
  for key, value in pairs(self.supportHeroInfoList) do
    if value ~= false and value.assistsBrief.id == briefId then
      return value
    end
  end
end

function UserInfoData:SetSelfSupportHoreId(index, heroId)
  if heroId == nil then
    self.supportHeroInfoList[index] = false
  else
    if self.supportHeroInfoList[index] == false then
      self.supportHeroInfoList[index] = {}
    end
    if self.supportHeroInfoList[index].assistsBrief == nil then
      self.supportHeroInfoList[index].assistsBrief = {}
    end
    self.supportHeroInfoList[index].assistsBrief.id = heroId
  end
end

function UserInfoData:GetLastOffLinTem()
  return self.__lastOffLineTm
end

function UserInfoData:GetOnlineState()
  if self.__lastOnLineTm >= self.__lastOffLineTm then
    return 0
  end
  return math.max(self.__lastOnLineTm, self.__lastOffLineTm)
end

function UserInfoData:SetSupportPointData(astPoint)
  if not self.isSelfInfo then
    return
  end
  self.__supportPoint = astPoint
end

function UserInfoData:GetCurSupportPoint()
  if not self.isSelfInfo then
    return
  end
  local consts = ConfigData.game_config.supportPointConstants
  local allLevel, allStar = 0, 0
  for index, value in pairs(self.supportHeroInfoList) do
    if value ~= nil and value ~= false then
      local heroData = PlayerDataCenter.heroDic[value.assistsBrief.id]
      if heroData ~= nil then
        allLevel = allLevel + heroData.level
        allStar = allStar + heroData.star
      end
    end
  end
  local isUnSetAllHeroFlag = 1
  if allLevel == 0 or allStar == 0 then
    isUnSetAllHeroFlag = 0
  end
  if self.__supportPoint == nil then
    return 0
  end
  local num = self.__supportPoint.num + math.floor(PlayerDataCenter.timestamp - self.__supportPoint.lastCalcTm - 1) * isUnSetAllHeroFlag * (allLevel + consts[1]) * (allStar + consts[2]) * consts[3] / consts[4] + self.__supportPoint.cnt * consts[5]
  return math.floor(num)
end

function UserInfoData:SetAlias(alias)
  self.alias = alias
end

function UserInfoData:GetIsHaveAlias()
  return not string.IsNullOrEmpty(self.alias)
end

function UserInfoData:GetAlias()
  if self:GetIsHaveAlias() then
    return self.alias
  end
  return self:GetUserName()
end

function UserInfoData:GetIsFriend()
  return self.isFriendInfo
end

function UserInfoData:SetApplyTimestamp(ts)
  if self.isFriendInfo or self.isSelfInfo then
    return
  end
  self.__applyTimestamp = ts
end

function UserInfoData:GetIsApplicationTimeOut()
  if self.isFriendInfo or self.isSelfInfo then
    warn("this userInof is not about a friend application")
    return
  end
  return PlayerDataCenter.timestamp > (self.__applyTimestamp or 0)
end

function UserInfoData:GetIsNewFriend()
  if not self.isFriendInfo then
    return
  end
  return self.__isNewFriend
end

function UserInfoData:GetFriendBirdData()
  return self.__birdData
end

function UserInfoData:GetFriend2048Data()
  return self.__game2048
end

function UserInfoData:GetFriendDamieData()
  return self.__damieData
end

function UserInfoData:GetFriendPenguinsData(birdId)
  if self.__tinyGameDic[tinyGameEnum.eType.penguins] == nil then
    return nil
  end
  return self.__tinyGameDic[tinyGameEnum.eType.penguins][birdId]
end

function UserInfoData:GetTinyGameData(gameCat, gameId)
  if self.__tinyGameDic[gameCat] == nil then
    return nil
  end
  return self.__tinyGameDic[gameCat][gameId]
end

function UserInfoData:GetDormFight1v1RecordData()
  return self.dormFight1v1RecordData
end

function UserInfoData:UpdateDormFight1v1RecordData(data)
  self.dormFight1v1RecordData:UpdateRecord(data)
end

function UserInfoData:GetActShowItems()
  return self.actItems
end

return UserInfoData
