local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local UserData = class("UserData", PersistentDataBase)
local FormationUtil = require("Game.Formation.FormationUtil")
local WCEnum = require("Game.WeeklyChallenge.WCEnum")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local FmtEnum = require("Game.Formation.FmtEnum")

function UserData:GetSaveDataFilePath()
  return PathConsts:GetPersistentUserDataPath(PlayerDataCenter.strPlayerId)
end

function UserData:InitBySaveData(table)
  self.lastSectorEntered = table.lastSectorEntered
  self.userSetting = table.userSetting or {}
  self.guideData = table.guideData
  self.fomationData = table.fomationData
  if self.fomationData == nil then
    self:__InitFormationData()
  end
  self.dungeonExtrData = table.dungeonExtrData
  if self.dungeonExtrData == nil then
    self:__InitDungeonExtrData()
  end
  self.specialReddotData = table.specialReddotData
  if self.specialReddotData == nil then
    self:__InitSpecialReddotData()
  end
  self.activityData = table.activityData
  if self.activityData == nil then
    self:__InitActivitySaveData()
  end
  self.gameNoticeData = table.gameNoticeData
  self.unlockNewSector = table.unlockNewSector or {}
  self.avgnoundic = table.avgnoundic
  self.avgplayspeed = table.avgplayspeed
  self.challengeStageDic = table.challengeStageDic or {}
  self.challengeDungeonDic = table.challengeDungeonDic or {}
  self.chipGiftPop = table.chipGiftPop
  if self.chipGiftPop == nil then
    self:__InitChipGiftPop()
  end
  self.guidePicIdDic = table.guidePicIdDic
  if self.guidePicIdDic == nil then
    self.guidePicIdDic = {}
  end
  self.lotteryData = table.lotteryData or self:__InitLotterydata()
  self.sectorExtraData = table.sectorExtraData or self:__InitSectorExtraData()
  self.actGeneralEp = table.actGeneralEp or self:__InitActGeneralEp()
  self.fairy = table.fairy or self:__InitFairy()
end

function UserData:InitByDefaultData()
  self.lastSectorEntered = 0
  self.unlockNewSector = {maxLastPlayVideSectorId = 0, maxLastUnlockAnimaSectorId = 0}
  self.userSetting = {}
  self:GetNoticeSwitchOff()
  self:__InitFormationData()
  self:__InitDungeonExtrData()
  self:__InitSpecialReddotData()
  self:__InitActivitySaveData()
  self.challengeStageDic = {}
  self.challengeDungeonDic = {}
  self.avgnoundic = {}
  self:__InitChipGiftPop()
  self.guidePicIdDic = {}
  self:__InitLotterydata()
  self.sectorExtraData = self:__InitSectorExtraData()
  self.actGeneralEp = self:__InitActGeneralEp()
  self.fairy = self:__InitFairy()
end

function UserData:__InitFormationData()
  self.fomationData = {
    lastFmtId = {},
    weeklyChallengeFmt = {},
    weeklyChallengeTreeId = 0,
    fixedTeamId2FmtIdDic = {},
    fixedTeamIdListSaved = {},
    lastBattleDeployFmtId = {},
    weeklySpFmt = {},
    weeklySpTreeId = 0,
    lastFromModuleFmtId = {},
    lastFromModuleSpecialGroupFmtId = {}
  }
end

function UserData:__InitDungeonExtrData()
  self.dungeonExtrData = {
    lastSelectStageDic = {},
    unitBlood = 0,
    bossUnitBlood = 0,
    lastAthDungeonId = 0,
    dropBuffOpenDic = {},
    lastDropBuffOpenResetTm = 0,
    isAthDropBuffInfoShown = false,
    challengeRead = {}
  }
end

function UserData:__InitSpecialReddotData()
  self.specialReddotData = {
    specialReddotDic = {},
    newGiftItemDic = {},
    firstOpenTask = {},
    newPayGiftItemDic = {},
    newDormHouseDic = {},
    unlockableDormHouseDic = {},
    tower_racing_reward = false,
    actLimitNewTaskDic = {},
    actLimitNewTaskActFrameId = 0,
    twinTowerReaded = {},
    normalTowerLevel = 0,
    newItemDic = {},
    lastMonthCardRenew = 0,
    specWeaponLookedDic = {},
    newSectorMapRead = {},
    notNewRechargeDic = {},
    newUpgradeSkinRead = {},
    heroFriendLevelTipDic = {},
    heroFriendLevelTimeDic = {},
    heroVowStoryTipDic = {}
  }
end

function UserData:__InitActivitySaveData()
  self.activityData = {
    entranceLastShow = {},
    activityHeros = {},
    sectorIIDataDic = {},
    sectorIIRecommendShopDic = {},
    activityCarnivalDic = {},
    adcDic = {},
    cardSetActivity = {},
    steinsGateActivity = {},
    activityHerosV3 = {}
  }
end

function UserData:__CreateDefaultActivityHero()
  return {
    shopReads = {},
    avgReviewDic = {},
    challengeStageLooked = 0,
    dailyTaskLooked = 0,
    dungeonBattle = {}
  }
end

function UserData:__CreateDefaultActivityHeroV3()
  return {
    dailyTaskLooked = 0,
    isLookedNormalNew = false,
    isLookedChallengeNew = false,
    avgReviewDic = {}
  }
end

function UserData:__InitChipGiftPop()
  self.chipGiftPop = {
    ignoreTime = {}
  }
end

function UserData:__InitActivityCarnival()
  return {
    diffEnv = 0,
    avgReviewDic = {}
  }
end

function UserData:__InitLotterydata()
  self.lotteryData = {
    groupSelectedLtrPool = {},
    newConvertSwitchRed = false,
    newConvertRuleRed = false,
    newRuleReddotRead = {}
  }
  return self.lotteryData
end

function UserData:_DealLtrOldData()
  if self.lotteryData.newConvertRuleRed then
    self:SetReadLtrNewRuleReddot(1)
  end
end

function UserData:__InitSum22ActData()
  if self.activityData.sum22Activity == nil then
    self.activityData.sum22Activity = {}
  end
end

function UserData:__InitHallowmasData()
  if self.activityData.hallowmasActivity == nil then
    self.activityData.hallowmasActivity = {}
  end
end

function UserData:__InitSpring23Data()
  if self.activityData.spring23Activity == nil then
    self.activityData.spring23Activity = {}
  end
end

function UserData:__InitWinter23Data()
  if self.activityData.winter23Activity == nil then
    self.activityData.winter23Activity = {}
  end
end

function UserData:__InitCarnival23Data()
  if self.activityData.carnival23Activity == nil then
    self.activityData.carnival23Activity = {}
  end
end

function UserData:__InitAnniversary23Data()
  if self.activityData.anniversary23Activity == nil then
    self.activityData.anniversary23Activity = {}
  end
end

function UserData:__InitCarnival24Data()
  if self.activityData.activityCarnival24 == nil then
    self.activityData.activityCarnival24 = {}
  end
end

function UserData:__InitAnni24Data()
  if self.activityData.activityAnniversary24 == nil then
    self.activityData.activityAnniversary24 = {}
  end
end

function UserData:__InitLuckyRaffleData()
  if self.activityData.luckyRaffleActivity == nil then
    self.activityData.luckyRaffleActivity = {}
  end
end

function UserData:__InitComebackData()
  if self.activityData.comebackActivity == nil then
    self.activityData.comebackActivity = {}
  end
end

function UserData:__InitInvitationData()
  if self.activityData.invitationActivity == nil then
    self.activityData.invitationActivity = {}
  end
end

function UserData:__InitWeeklyQAData()
  if self.activityData.answerActivity == nil then
    self.activityData.answerActivity = {}
  end
end

function UserData:__InitAngelaGiftData()
  if self.activityData.angelaGiftActivity == nil then
    self.activityData.angelaGiftActivity = {}
  end
end

function UserData:__InitSaveMoneyData()
  if self.activityData.saveMoneyActivity == nil then
    self.activityData.saveMoneyActivity = {}
  end
end

function UserData:__InitDivergentData()
  if self.activityData.divergentActivity == nil then
    self.activityData.divergentActivity = {}
  end
end

function UserData:__InitActCommonData()
  if self.activityData.commonActDic == nil then
    self.activityData.commonActDic = {}
  end
end

function UserData:__InitFlipCardData()
  if self.activityData.flipCardActivity == nil then
    self.activityData.flipCardActivity = {}
  end
end

function UserData:__InitSkinLimitData()
  if self.activityData.skinLimitActivity == nil then
    self.activityData.skinLimitActivity = {}
  end
end

function UserData:__InitBlackHoleData()
  if self.activityData.blackHoleActivity == nil then
    self.activityData.blackHoleActivity = {}
  end
end

function UserData:__InitLadderGiftData()
  if self.activityData.ladderGiftActivity == nil then
    self.activityData.ladderGiftActivity = {}
  end
end

function UserData:__InitSteinsGateData()
  if self.activityData.steinsGateActivity == nil then
    self.activityData.steinsGateActivity = {}
  end
end

function UserData:__InitHazeGiftData()
  if self.activityData.hazeGiftActivity == nil then
    self.activityData.hazeGiftActivity = {}
  end
end

function UserData:__InitTreasureHuntData()
  if self.activityData.treasureHuntActivity == nil then
    self.activityData.treasureHuntActivity = {}
  end
end

function UserData:__InitCollectFortuneData()
  if self.activityData.collectFortuneActivity == nil then
    self.activityData.collectFortuneActivity = {}
  end
end

function UserData:__InitSignInLiveData()
  if self.activityData.signInLiveActivity == nil then
    self.activityData.signInLiveActivity = {}
  end
end

function UserData:__InitBondActData()
  if self.activityData.bondActivity == nil then
    self.activityData.bondActivity = {}
  end
end

function UserData:__InitDSActData()
  if self.activityData.dSActivity == nil then
    self.activityData.dSActivity = {}
  end
end

function UserData:__InitSectorExtraData()
  return {lastSelectedPage = 1}
end

function UserData:__InitActGeneralEp()
  return {
    infiniteFmtIdx = {}
  }
end

function UserData:__InitFairy()
  return {}
end

function UserData:IsFairyQuickLvOn()
  return self.fairy.quickLvUpOn
end

function UserData:SetFairyQuickLvOn(isOn)
  if self.fairy.quickLvUpOn == isOn then
    return
  end
  self.fairy.quickLvUpOn = isOn
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSum22ActEnter(actId)
  self:__InitSum22ActData()
  local sum22Activity = self.activityData.sum22Activity[actId]
  return sum22Activity ~= nil and sum22Activity.enterActive
end

function UserData:SetSum22ActEnter(actId)
  self:__InitSum22ActData()
  local sum22Activity = self.activityData.sum22Activity[actId]
  if sum22Activity == nil then
    sum22Activity = {}
    self.activityData.sum22Activity[actId] = sum22Activity
  end
  if sum22Activity.enterActive then
    return
  end
  sum22Activity.enterActive = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSum22SelectTechLastEnterRefreshTs(actId)
  self:__InitSum22ActData()
  local sum22Activity = self.activityData.sum22Activity[actId]
  return sum22Activity ~= nil and sum22Activity.lastEnterTechSelectRefreshTs or 0
end

function UserData:SetSum22SelectTechLastEnterRefreshTs(actId, ts)
  self:__InitSum22ActData()
  local sum22Activity = self.activityData.sum22Activity[actId]
  if sum22Activity == nil then
    sum22Activity = {}
    self.activityData.sum22Activity[actId] = sum22Activity
  end
  if sum22Activity.lastEnterTechSelectRefreshTs == ts then
    return
  end
  sum22Activity.lastEnterTechSelectRefreshTs = ts
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryDeleteSum22Activity(ingoreActTable)
  if self.activityData == nil or self.activityData.sum22Activity == nil then
    return
  end
  for actId, sum22Activity in pairs(self.activityData.sum22Activity) do
    if ingoreActTable[actId] == nil then
      self.activityData.sum22Activity[actId] = nil
    end
  end
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetLtrGroupSelectedLtrId(groupId)
  return self.lotteryData.groupSelectedLtrPool[groupId]
end

function UserData:SetLtrGroupSelectedLtrId(groupId, ltrId)
  if self.lotteryData.groupSelectedLtrPool[groupId] == ltrId then
    return
  end
  self.lotteryData.groupSelectedLtrPool[groupId] = ltrId
  self:SetPstDataDirty()
end

function UserData:GetLtrNewConvertSwitchRed()
  return not self.lotteryData.newConvertSwitchRed
end

function UserData:SetLtrNewConvertSwitchRed()
  if self.lotteryData.newConvertSwitchRed == true then
    return
  end
  self.lotteryData.newConvertSwitchRed = true
  self:SetPstDataDirty()
end

function UserData:IsReadLtrNewRuleReddot(ltrRuleId)
  if self.lotteryData.newRuleReddotRead == nil then
    return false
  end
  return self.lotteryData.newRuleReddotRead[ltrRuleId] or false
end

function UserData:SetReadLtrNewRuleReddot(ltrRuleId)
  if self.lotteryData.newRuleReddotRead == nil then
    self.lotteryData.newRuleReddotRead = {}
  end
  if self.lotteryData.newRuleReddotRead[ltrRuleId] == true then
    return
  end
  self.lotteryData.newRuleReddotRead[ltrRuleId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:RecordLastSectorSelected(sectorMentionId)
  if self.lastSectorEntered ~= sectorMentionId then
    self.lastSectorEntered = sectorMentionId
    self:SetPstDataDirty()
  end
end

function UserData:GetLastLocalSectorMentionId()
  return self.lastSectorEntered
end

function UserData:RecordLastMaxUnlockSectorId(maxUnlockSectorId, isAnima)
  if isAnima then
    if self.unlockNewSector.maxLastUnlockAnimaSectorId ~= maxUnlockSectorId then
      self.unlockNewSector.maxLastUnlockAnimaSectorId = maxUnlockSectorId
      self:SetPstDataDirty()
      PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    end
  elseif self.unlockNewSector.maxLastPlayVideSectorId ~= maxUnlockSectorId then
    self.unlockNewSector.maxLastPlayVideSectorId = maxUnlockSectorId
    self:SetPstDataDirty()
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  end
end

function UserData:GetLastLocalMaxUnlockSectorId(isAnima)
  if isAnima then
    return self.unlockNewSector.maxLastUnlockAnimaSectorId or 0
  else
    return self.unlockNewSector.maxLastPlayVideSectorId or 0
  end
end

function UserData:SetSectorLastSelectedPage(pageId)
  if self.sectorExtraData.lastSelectedPage == pageId then
    return
  end
  self.sectorExtraData.lastSelectedPage = pageId
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSectorLastSelectedPage()
  return self.sectorExtraData.lastSelectedPage
end

function UserData:SetActGnEpInfiniteFmtIdx(envId, fmtIdx)
  if self.actGeneralEp.infiniteFmtIdx[envId] == fmtIdx then
    return
  end
  self.actGeneralEp.infiniteFmtIdx[envId] = fmtIdx
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetActGnEpInfiniteFmtIdx(envId)
  return self.actGeneralEp.infiniteFmtIdx[envId] or 1
end

function UserData:SetNoticeSwitchOff(homeside_info_id, bool)
  if self.userSetting.homeNoticeOff[homeside_info_id] ~= bool then
    self.userSetting.homeNoticeOff[homeside_info_id] = bool
    self:SetPstDataDirty()
  end
end

function UserData:GetNoticeSwitchOff()
  if self.userSetting.homeNoticeOff == nil then
    self.userSetting.homeNoticeOff = {}
    for id, _ in pairs(ConfigData.homeside_info) do
      self.userSetting.homeNoticeOff[id] = false
    end
  end
  return self.userSetting.homeNoticeOff
end

function UserData:__InitGuideData()
  self.guideData = {
    skipGuideTask = {}
  }
end

function UserData:SaveSkipGuideTask(taskId)
  if self.guideData == nil then
    self:__InitGuideData()
  end
  if self.guideData.skipGuideTask[taskId] ~= true then
    self.guideData.skipGuideTask[taskId] = true
    self:SetPstDataDirty()
  end
end

function UserData:ContainSkipGuideTask(taskId)
  if self.guideData == nil then
    return false
  end
  return self.guideData.skipGuideTask[taskId]
end

function UserData:GetLastFormationId(moduleId, stageId)
  local defaultFmtId = 1
  if self.fomationData == nil then
    return defaultFmtId
  end
  if stageId then
    local offset = FormationUtil.GetFmtIdOffsetBySpecialStage(stageId)
    if offset ~= 0 then
      return self.fomationData.guardPlayFmtId ~= 0 and self.fomationData.guardPlayFmtId or defaultFmtId + offset
    end
    local stageCfg = ConfigData.sector_stage[stageId]
    if stageCfg.team_config_offset ~= 0 then
      return stageCfg.team_config_offset + (self.fomationData.lastFmtId[moduleId] % 10 or defaultFmtId)
    end
  end
  local fmtId = self.fomationData.lastFmtId[moduleId]
  return fmtId or defaultFmtId
end

function UserData:SetLastFormationId(moduleId, fmtId, stageId)
  local lastId
  if stageId and FormationUtil.GetFmtIdOffsetBySpecialStage(stageId) ~= 0 then
    lastId = self.fomationData.guardPlayFmtId
    self.fomationData.guardPlayFmtId = fmtId
  else
    local offset = 0
    local stageCfg = ConfigData.sector_stage[stageId]
    if stageCfg and stageCfg.team_config_offset ~= 0 then
      offset = stageCfg.team_config_offset
      lastId = self.fomationData.lastFmtId[moduleId]
      self.fomationData.lastFmtId[moduleId] = fmtId - offset + FormationUtil.GetFmtIdOffsetByFmtFromModule(moduleId, nil)
    else
      lastId = self.fomationData.lastFmtId[moduleId]
      self.fomationData.lastFmtId[moduleId] = fmtId
    end
  end
  if fmtId ~= lastId then
    self:SetPstDataDirty()
  end
end

function UserData:GetLastBattleDeployFmtId(moduleId)
  local fmtId = self.fomationData.lastBattleDeployFmtId[moduleId]
  if fmtId == nil then
    fmtId = FormationUtil.GetFmtIdByDungeonType(moduleId, 1)
  end
  return fmtId
end

function UserData:SetLastBattleDeployFmtId(moduleId, fmtId)
  local lastId = self.fomationData.lastBattleDeployFmtId[moduleId]
  if fmtId == lastId then
    return
  end
  self.fomationData.lastBattleDeployFmtId[moduleId] = fmtId
  self:SetPstDataDirty()
end

function UserData:GetLastFromModuleFmtId(moduleId, stageId)
  if stageId and FormationUtil.GetFmtIdOffsetBySpecialStage(stageId) ~= 0 then
    local offset = FormationUtil.GetFmtIdOffsetBySpecialStage(stageId)
    return self.fomationData.guardPlayFmtId ~= 0 and self.fomationData.guardPlayFmtId or 1 + offset
  elseif stageId and ConfigData.special_team_stage[stageId] ~= nil then
    if self.fomationData.lastFromModuleSpecialGroupFmtId == nil then
      self.fomationData.lastFromModuleSpecialGroupFmtId = {}
    end
    if self.fomationData.lastFromModuleSpecialGroupFmtId[moduleId] == nil then
      self.fomationData.lastFromModuleSpecialGroupFmtId[moduleId] = {}
    end
    local offset = ConfigData.special_team_stage[stageId].fmt_id_offset
    return (self.fomationData.lastFromModuleSpecialGroupFmtId[moduleId][offset] or 1) + offset
  end
  local fmtId = self.fomationData.lastFromModuleFmtId[moduleId]
  if fmtId == nil or moduleId == FmtEnum.eFmtFromModule.Brotato then
    fmtId = FormationUtil.GetFmtIdOffsetByFmtFromModule(moduleId) + 1
  end
  return fmtId
end

function UserData:SetLastFromModuleFmtId(moduleId, fmtId, stageId)
  local lastId
  if stageId and FormationUtil.GetFmtIdOffsetBySpecialStage(stageId) ~= 0 then
    lastId = self.fomationData.guardPlayFmtId
    self.fomationData.guardPlayFmtId = fmtId
  elseif stageId and ConfigData.special_team_stage[stageId] ~= nil then
    if self.fomationData.lastFromModuleSpecialGroupFmtId == nil then
      self.fomationData.lastFromModuleSpecialGroupFmtId = {}
    end
    if self.fomationData.lastFromModuleSpecialGroupFmtId[moduleId] == nil then
      self.fomationData.lastFromModuleSpecialGroupFmtId[moduleId] = {}
    end
    local offset = ConfigData.special_team_stage[stageId].fmt_id_offset
    self.fomationData.lastFromModuleSpecialGroupFmtId[moduleId][offset] = fmtId
  else
    lastId = self.fomationData.lastFromModuleFmtId[moduleId]
    self.fomationData.lastFromModuleFmtId[moduleId] = fmtId
  end
  if fmtId == lastId then
    return
  end
  self:SetPstDataDirty()
end

function UserData:GetFmtFixedSaved()
  return self.fomationData.fixedTeamId2FmtIdDic, self.fomationData.fixedTeamIdListSaved
end

function UserData:SetFmtFixedSaved(fixedTeamId2FmtIdDic, fixedTeamIdListSaved)
  local changed = false
  if #self.fomationData.fixedTeamIdListSaved ~= #fixedTeamIdListSaved then
    changed = true
  else
    for k, v in ipairs(self.fomationData.fixedTeamIdListSaved) do
      if fixedTeamIdListSaved[k] ~= v then
        changed = true
        goto lbl_47
      end
    end
    if table.count(fixedTeamId2FmtIdDic) ~= table.count(self.fomationData.fixedTeamId2FmtIdDic) then
      changed = true
    else
      for k, v in pairs(self.fomationData.fixedTeamId2FmtIdDic) do
        if fixedTeamId2FmtIdDic[k] ~= v then
          changed = true
          break
        end
      end
    end
  end
  ::lbl_47::
  if changed then
    self.fomationData.fixedTeamId2FmtIdDic = fixedTeamId2FmtIdDic
    self.fomationData.fixedTeamIdListSaved = fixedTeamIdListSaved
    self:SetPstDataDirty()
  end
end

function UserData:GetLastDungeonStageId(dungeonId)
  if self.dungeonExtrData == nil then
    return nil
  end
  local stageId = self.dungeonExtrData.lastSelectStageDic[dungeonId]
  return stageId
end

function UserData:SetLastDungeonStageId(dungeonId, stageId)
  local lastId = self.dungeonExtrData.lastSelectStageDic[dungeonId]
  if stageId ~= lastId then
    self.dungeonExtrData.lastSelectStageDic[dungeonId] = stageId
    self:SetPstDataDirty()
  end
end

function UserData:SetLastAthDungeonId(dungeonId)
  if self.dungeonExtrData.lastAthDungeonId == dungeonId then
    return
  end
  self.dungeonExtrData.lastAthDungeonId = dungeonId
  self:SetPstDataDirty()
end

function UserData:GetLastAthDungeonId()
  local lastAthDungeonId = self.dungeonExtrData.lastAthDungeonId
  if lastAthDungeonId == 0 then
    return nil
  end
  return lastAthDungeonId
end

function UserData:SetDungeonDropBuffActive(dungeonType, active)
  if self.dungeonExtrData.dropBuffOpenDic[dungeonType] == active then
    return
  end
  self.dungeonExtrData.dropBuffOpenDic[dungeonType] = active
  self:SetPstDataDirty()
end

function UserData:GetDungeonDropBuffActive(dungeonType)
  return self.dungeonExtrData.dropBuffOpenDic[dungeonType] or false
end

function UserData:SetDungeonDropBuffLastResetTm(timestamp)
  self.dungeonExtrData.lastDropBuffOpenResetTm = timestamp
end

function UserData:GetDungeonDropBuffLastResetTm()
  return self.dungeonExtrData.lastDropBuffOpenResetTm
end

function UserData:GetLastWeeklyChallengeFmt(wcType)
  if self.fomationData ~= nil then
    if wcType == WCEnum.eWeeklyChallengeType.special then
      return self.fomationData.weeklySpFmt
    end
    return self.fomationData.weeklyChallengeFmt
  end
  return nil
end

function UserData:SetLastWeeklyChallengeFmt(wcType, fmtDic)
  if self.fomationData == nil then
    self:__InitFormationData()
  end
  local isChanged = false
  local modifyTable
  if wcType == WCEnum.eWeeklyChallengeType.special then
    modifyTable = self.fomationData.weeklySpFmt
  else
    modifyTable = self.fomationData.weeklyChallengeFmt
  end
  if fmtDic ~= nil and modifyTable ~= nil then
    if table.count(fmtDic) ~= table.count(modifyTable) then
      isChanged = true
    else
      for k, v in pairs(modifyTable) do
        if fmtDic[k] == nil or fmtDic[k] ~= v then
          isChanged = true
          break
        end
      end
    end
  elseif fmtDic ~= modifyTable then
    isChanged = true
  end
  if isChanged then
    if wcType == WCEnum.eWeeklyChallengeType.special then
      self.fomationData.weeklySpFmt = fmtDic
    else
      self.fomationData.weeklyChallengeFmt = fmtDic
    end
    self:SetPstDataDirty()
  end
end

function UserData:GetLastWeeklySkillList(wcType)
  if self.fomationData ~= nil then
    if wcType == WCEnum.eWeeklyChallengeType.special then
      return self.fomationData.weeklySpTreeId
    end
    return self.fomationData.weeklyChallengeTreeId
  end
  return nil, nil
end

function UserData:SetLastWeeklySkillList(wcType, treeId)
  if self.fomationData == nil then
    self:__InitFormationData()
  end
  local isChanged = false
  local lastTreeId = 0
  if wcType == WCEnum.eWeeklyChallengeType.special then
    lastTreeId = self.fomationData.weeklySpTreeId
  else
    lastTreeId = self.fomationData.weeklyChallengeTreeId
  end
  if lastTreeId ~= treeId then
    isChanged = true
  end
  if isChanged then
    if wcType == WCEnum.eWeeklyChallengeType.special then
      self.fomationData.weeklySpTreeId = treeId
    else
      self.fomationData.weeklyChallengeTreeId = treeId
    end
    self:SetPstDataDirty()
  end
end

function UserData:GetIsSReddotClose(redDotLoactionString)
  return self.specialReddotData.specialReddotDic[redDotLoactionString]
end

function UserData:SetSReddotClose(redDotLoactionString, bool)
  local last = self.specialReddotData.specialReddotDic[redDotLoactionString]
  if last ~= bool then
    self.specialReddotData.specialReddotDic[redDotLoactionString] = bool
    self:SetPstDataDirty()
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  end
end

function UserData:GetNewGiftItemReddotDic()
  return self.specialReddotData.newGiftItemDic
end

function UserData:SetNewGiftItemReddot(itemId, value)
  local last = self.specialReddotData.newGiftItemDic[itemId]
  if last == value then
    return
  end
  self.specialReddotData.newGiftItemDic[itemId] = value
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetNewPayGiftItemIsNotNew(payGiftId)
  return self.specialReddotData.newPayGiftItemDic[payGiftId]
end

function UserData:SetNewGiftItemIsNotNew(payGiftId, value)
  local last = self.specialReddotData.newPayGiftItemDic[payGiftId]
  if last == value then
    return
  end
  self.specialReddotData.newPayGiftItemDic[payGiftId] = value
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetIsRechargeShelfNotNew(shelfId)
  return self.specialReddotData.notNewRechargeDic[shelfId]
end

function UserData:SetIsRechargeShelfNotNew(shelfId, value)
  local last = self.specialReddotData.notNewRechargeDic[shelfId]
  if last == value then
    return
  end
  self.specialReddotData.notNewRechargeDic[shelfId] = value
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetNewItemReddotDic()
  return self.specialReddotData.newItemDic
end

function UserData:SetNewItemReddot(itemId, value)
  local last = self.specialReddotData.newItemDic[itemId]
  if last == value then
    return
  end
  self.specialReddotData.newItemDic[itemId] = value
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetLastMonthCardRenew()
  return self.specialReddotData.lastMonthCardRenew
end

function UserData:SetLastMonthCardRenew(time)
  local last = self.specialReddotData.lastMonthCardRenew
  if last == time then
    return
  end
  self.specialReddotData.lastMonthCardRenew = time
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetNewDormHouseReaded(houseId)
  return self.specialReddotData.newDormHouseDic[houseId] or false
end

function UserData:SetNewDormHouseReaded(houseId, value)
  local last = self.specialReddotData.newDormHouseDic[houseId]
  if last == value then
    return false
  end
  self.specialReddotData.newDormHouseDic[houseId] = value
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
  return true
end

function UserData:GetUnlockableDormHouseReaded(houseId)
  return self.specialReddotData.unlockableDormHouseDic and self.specialReddotData.unlockableDormHouseDic[houseId] or false
end

function UserData:SetUnlockableDormHouseReaded(houseId, value)
  if self.specialReddotData.unlockableDormHouseDic == nil then
    self.specialReddotData.unlockableDormHouseDic = {}
  end
  local last = self.specialReddotData.unlockableDormHouseDic[houseId]
  if last == value then
    return
  end
  self.specialReddotData.unlockableDormHouseDic[houseId] = value
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetDunTwinTowerRacingReaded()
  return self.specialReddotData.tower_racing_reward or false
end

function UserData:SetDunTwinTowerRacingReaded(value)
  local last = self.specialReddotData.tower_racing_reward
  if last == value then
    return false
  end
  self.specialReddotData.tower_racing_reward = value
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
  return true
end

function UserData:GetFirstOpenTaskReddotDic()
  if self.specialReddotData.firstOpenTask == nil then
    self.specialReddotData.firstOpenTask = {}
  end
  return self.specialReddotData.firstOpenTask
end

function UserData:SetNewFirstOpenTaskReddot(open_condition, value)
  if self.specialReddotData.firstOpenTask == nil then
    self.specialReddotData.firstOpenTask = {}
  end
  local last = self.specialReddotData.firstOpenTask[open_condition]
  if last == value then
    return
  end
  self.specialReddotData.firstOpenTask[open_condition] = value
  self:SetPstDataDirty()
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
end

function UserData:GetActLimitNewTaskReddot(actFrameId, taskId)
  if actFrameId ~= self.specialReddotData.actLimitNewTaskActFrameId then
    self.specialReddotData.actLimitNewTaskDic = {}
    self.specialReddotData.actLimitNewTaskActFrameId = actFrameId
    self:SetPstDataDirty()
  end
  return not self.specialReddotData.actLimitNewTaskDic[taskId]
end

function UserData:SetActLimitNewTaskReddot(taskId)
  if self.specialReddotData.actLimitNewTaskDic[taskId] == true then
    return
  end
  self.specialReddotData.actLimitNewTaskDic[taskId] = true
  self:SetPstDataDirty()
end

function UserData:GetIsAutoBattle()
  return self.userSetting.isAutoBattle or false
end

function UserData:SetIsAutoBattle(isAutoBattle)
  if self.userSetting.isAutoBattle ~= isAutoBattle then
    self.userSetting.isAutoBattle = isAutoBattle
    self:SetPstDataDirty()
  end
end

function UserData:GetBattleSpeed()
  return (self.userSetting.battleSpeed or 0) + 1
end

function UserData:SetBattleSpeed(battleSpeed)
  battleSpeed = battleSpeed - 1
  if self.userSetting.battleSpeed ~= battleSpeed then
    self.userSetting.battleSpeed = battleSpeed
    self:SetPstDataDirty()
  end
end

function UserData:SetUnitBlood(unitBlood, bossUnitBlood)
  if unitBlood ~= self.dungeonExtrData.unitBlood or bossUnitBlood ~= self.dungeonExtrData.bossUnitBlood then
    self.dungeonExtrData.unitBlood = unitBlood
    self.dungeonExtrData.bossUnitBlood = bossUnitBlood
    self:SetPstDataDirty()
  end
end

function UserData:GetUnitBlood()
  if self.dungeonExtrData == nil then
    return
  end
  return self.dungeonExtrData.unitBlood, self.dungeonExtrData.bossUnitBlood
end

function UserData:__InitGameNoticeData()
  if self.gameNoticeData ~= nil then
    return
  end
  self.gameNoticeData = {
    timestamp = 0,
    readNotice = {}
  }
end

function UserData:SaveIsReadGameNotice(noticeID)
  self:__InitGameNoticeData()
  if self.gameNoticeData.readNotice[noticeID] ~= true then
    self.gameNoticeData.readNotice[noticeID] = true
    self:SetPstDataDirty()
  end
end

function UserData:SaveGameNoticeTimestamp(timestamp)
  self:__InitGameNoticeData()
  self.gameNoticeData.timestamp = timestamp
  self:SetPstDataDirty()
end

function UserData:GetGameNoticeTimestamp(timestamp)
  if self.gameNoticeData == nil then
    return 0
  end
  return self.gameNoticeData.timestamp
end

function UserData:ContainGameNoticeIsRead(noticeID)
  if self.gameNoticeData == nil then
    return false
  end
  return self.gameNoticeData.readNotice[noticeID]
end

function UserData:DiffLocalGNReadData(noticeIds)
  if self.gameNoticeData == nil or noticeIds == nil then
    return
  end
  for id, bool in pairs(self.gameNoticeData.readNotice) do
    if noticeIds[id] == nil then
      self.gameNoticeData.readNotice[id] = nil
    end
  end
  self:SetPstDataDirty()
end

function UserData:ReadIsReceiveFriendApplication()
  return not self:GetNoticeSwitchOff()[100]
end

function UserData:SaveAvgNoun(nounid)
  if self.avgnoundic[nounid] then
    return
  end
  self.avgnoundic[nounid] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(3)
end

function UserData:GetAvgNounIsRead(nounid)
  if self.avgnoundic == nil then
    return false
  end
  if self.avgnoundic[nounid] == nil then
    return false
  end
  return self.avgnoundic[nounid]
end

function UserData:GetAvgplayspeed()
  return self.avgplayspeed
end

function UserData:Saveavgspeed(speed)
  self.avgplayspeed = speed
  self:SetPstDataDirty()
end

function UserData:GetActEntranceLastShow(id)
  return self.activityData.entranceLastShow[id] or 0
end

function UserData:SaveActEntranceLastShow(id, time)
  self.activityData.entranceLastShow[id] = time
  for tid, ttime in pairs(self.activityData.entranceLastShow) do
    if tid ~= id and math.abs(ttime - time) > CommonUtil.DaySeconds then
      self.activityData.entranceLastShow[tid] = 0
    end
  end
  self:SetPstDataDirty()
end

function UserData:_NewChallengeStageTab()
  self:SetPstDataDirty()
  return {
    isOpen = false,
    optionalTask = {}
  }
end

function UserData:GetChallengeStageSwitch(stageId)
  if PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskCompleteAll(stageId) then
    if self.challengeStageDic[stageId] ~= nil then
      self.challengeStageDic[stageId] = nil
      self:SetPstDataDirty()
    end
    return false
  end
  local challengeStageTab = self.challengeStageDic[stageId]
  if challengeStageTab == nil then
    return false
  else
    return challengeStageTab.isOpen
  end
end

function UserData:SetChallengeStageSwitch(stageId, isOpen)
  local challengeStageTab = self.challengeStageDic[stageId] or self:_NewChallengeStageTab()
  self.challengeStageDic[stageId] = challengeStageTab
  if challengeStageTab.isOpen == isOpen then
    return
  end
  challengeStageTab.isOpen = isOpen
  self:SetPstDataDirty()
end

function UserData:GetChallengeStageTaskOptDic(stageId)
  if PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskCompleteAll(stageId) then
    if self.challengeStageDic[stageId] ~= nil then
      self.challengeStageDic[stageId] = nil
      self:SetPstDataDirty()
    end
    return table.emptytable
  end
  local challengeStageTab = self.challengeStageDic[stageId]
  if challengeStageTab == nil then
    return table.emptytable
  else
    return challengeStageTab.optionalTask
  end
end

function UserData:SetChallengeStageTaskOptDic(stageId, taskIdDic)
  local challengeStageTab = self.challengeStageDic[stageId] or self:_NewChallengeStageTab()
  self.challengeStageDic[stageId] = challengeStageTab
  if table.IsDicValueSame(taskIdDic, challengeStageTab.optionalTask) then
    return
  end
  challengeStageTab.optionalTask = taskIdDic
  self:SetPstDataDirty()
end

function UserData:GetChallengeDgSwitch(dungeonId)
  if PlayerDataCenter.dungeonCenterData:IsDgChallengeTaskCompleteAll(dungeonId) then
    if self.challengeDungeonDic[dungeonId] ~= nil then
      self.challengeDungeonDic[dungeonId] = nil
      self:SetPstDataDirty()
    end
    return false
  end
  local challengeStageTab = self.challengeDungeonDic[dungeonId]
  if challengeStageTab == nil then
    return false
  else
    return challengeStageTab.isOpen
  end
end

function UserData:SetChallengeDgSwitch(dungeonId, isOpen)
  local challengeStageTab = self.challengeDungeonDic[dungeonId] or self:_NewChallengeStageTab()
  self.challengeDungeonDic[dungeonId] = challengeStageTab
  if challengeStageTab.isOpen == isOpen then
    return
  end
  challengeStageTab.isOpen = isOpen
  self:SetPstDataDirty()
end

function UserData:GetChallengeDgTaskOptDic(dungeonId)
  if PlayerDataCenter.dungeonCenterData:IsDgChallengeTaskCompleteAll(dungeonId) then
    if self.challengeDungeonDic[dungeonId] ~= nil then
      self.challengeDungeonDic[dungeonId] = nil
      self:SetPstDataDirty()
    end
    return table.emptytable
  end
  local challengeStageTab = self.challengeDungeonDic[dungeonId]
  if challengeStageTab == nil then
    return table.emptytable
  else
    return challengeStageTab.optionalTask
  end
end

function UserData:SetChallengeDgTaskOptDic(dungeonId, taskIdDic)
  local challengeStageTab = self.challengeDungeonDic[dungeonId] or self:_NewChallengeStageTab()
  self.challengeDungeonDic[dungeonId] = challengeStageTab
  if table.IsDicValueSame(taskIdDic, challengeStageTab.optionalTask) then
    return
  end
  challengeStageTab.optionalTask = taskIdDic
  self:SetPstDataDirty()
end

function UserData:TryClearActivityHeroData(ingoreActTable)
  if self.activityData == nil or self.activityData.activityHeros == nil then
    return
  end
  local apply = false
  for actId, v in pairs(self.activityData.activityHeros) do
    if ingoreActTable[actId] == nil then
      self.activityData.activityHeros[actId] = nil
      apply = true
    end
  end
  if apply then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:IsActivityHeroShopRead(actId, shopId)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    return false
  end
  return activityHero.shopReads[shopId] or false
end

function UserData:SetActivityHeroShopReaded(actId, shopId)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHero()
    self.activityData.activityHeros[actId] = activityHero
  elseif activityHero.shopReads[shopId] then
    return
  end
  activityHero.shopReads[shopId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetHeroGrowAvgReview(actId, stageId)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    return false
  end
  if activityHero.avgReviewDic == nil then
    return
  end
  return activityHero.avgReviewDic[stageId] or false
end

function UserData:SetHeroGrowAvgReview(actId, stageId)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHero()
    self.activityData.activityHeros[actId] = activityHero
  elseif activityHero.avgReviewDic[stageId] then
    return
  end
  activityHero.avgReviewDic[stageId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetHeroGrowChallengeStageId(actId)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    return 0
  end
  return activityHero.challengeStageLooked
end

function UserData:SetHeroGrowChallengeStageId(actId, stageId)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHero()
    self.activityData.activityHeros[actId] = activityHero
  end
  activityHero.challengeStageLooked = stageId
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetHeroGrowDailyTask(actId)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    return nil
  end
  local dayDic = {}
  local dailyTaskLooked = activityHero.dailyTaskLooked or 0
  local day = 0
  while 0 < dailyTaskLooked do
    day = day + 1
    dailyTaskLooked = dailyTaskLooked >> 1
    if dailyTaskLooked & 1 == 1 then
      dayDic[day] = true
    end
  end
  return dayDic
end

function UserData:SetHeroGrowDailyTask(actId, day)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHero()
    self.activityData.activityHeros[actId] = activityHero
  end
  local addtion = 1 << day
  if activityHero.dailyTaskLooked & addtion > 0 then
    return
  end
  activityHero.dailyTaskLooked = activityHero.dailyTaskLooked + addtion
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetHeroGrowBattleDungeon(actId, dungeonId)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHero()
    self.activityData.activityHeros[actId] = activityHero
  end
  return activityHero.dungeonBattle[dungeonId]
end

function UserData:SetHeroGrowBattleDungeon(actId, dungeonId)
  local activityHero = self.activityData.activityHeros[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHero()
    self.activityData.activityHeros[actId] = activityHero
  end
  if activityHero.dungeonBattle[dungeonId] then
    return
  end
  activityHero.dungeonBattle[dungeonId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:TryClearActivityHeroV3Data(ingoreActTable)
  if self.activityData == nil or self.activityData.activityHerosV3 == nil then
    return
  end
  local apply = false
  for actId, v in pairs(self.activityData.activityHerosV3) do
    if ingoreActTable[actId] == nil then
      self.activityData.activityHerosV3[actId] = nil
      apply = true
    end
  end
  if apply then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetHeroGrowV3DailyTask(actId)
  local activityHero = self.activityData.activityHerosV3[actId]
  if activityHero == nil then
    return nil
  end
  local dayDic = {}
  local dailyTaskLooked = activityHero.dailyTaskLooked or 0
  local day = 0
  while 0 < dailyTaskLooked do
    day = day + 1
    dailyTaskLooked = dailyTaskLooked >> 1
    if dailyTaskLooked & 1 == 1 then
      dayDic[day] = true
    end
  end
  return dayDic
end

function UserData:SetHeroGrowV3DailyTask(actId, day)
  local activityHero = self.activityData.activityHerosV3[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHeroV3()
    self.activityData.activityHerosV3[actId] = activityHero
  end
  local addtion = 1 << day
  if activityHero.dailyTaskLooked & addtion > 0 then
    return
  end
  activityHero.dailyTaskLooked = activityHero.dailyTaskLooked + addtion
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetHeroGrowV3IsLookedNormalNew(actId)
  local activityHero = self.activityData.activityHerosV3[actId]
  if activityHero == nil then
    return nil
  end
  return activityHero.isLookedNormalNew
end

function UserData:SetHeroGrowV3IsLookedNormalNew(actId)
  local activityHero = self.activityData.activityHerosV3[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHeroV3()
    self.activityData.activityHerosV3[actId] = activityHero
  end
  if activityHero.isLookedNormalNew then
    return
  end
  activityHero.isLookedNormalNew = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetHeroGrowV3IsLookedChallengeNew(actId)
  local activityHero = self.activityData.activityHerosV3[actId]
  if activityHero == nil then
    return nil
  end
  return activityHero.isLookedChallengeNew
end

function UserData:SetHeroGrowV3IsLookedChallengeNew(actId)
  local activityHero = self.activityData.activityHerosV3[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHeroV3()
    self.activityData.activityHerosV3[actId] = activityHero
  end
  if activityHero.isLookedChallengeNew then
    return
  end
  activityHero.isLookedChallengeNew = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetHeroGrowV3AvgReview(actId, stageId)
  local activityHero = self.activityData.activityHerosV3[actId]
  if activityHero == nil then
    return false
  end
  if activityHero.avgReviewDic == nil then
    return
  end
  return activityHero.avgReviewDic[stageId] or false
end

function UserData:SetHeroGrowV3AvgReview(actId, stageId)
  local activityHero = self.activityData.activityHerosV3[actId]
  if activityHero == nil then
    activityHero = self:__CreateDefaultActivityHeroV3()
    self.activityData.activityHerosV3[actId] = activityHero
  elseif activityHero.avgReviewDic[stageId] then
    return
  end
  activityHero.avgReviewDic[stageId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:SetSectorIIIsTurnOnMultEfficient(actId, bool)
  if self.activityData.sectorIIDataDic[actId] == nil then
    self.activityData.sectorIIDataDic[actId] = {}
  end
  self.activityData.sectorIIDataDic[actId].isTurnOnMultEfficient = bool
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetSectorIIIsTurnOnMultEfficient(actId)
  local activity_sectorII = self.activityData.sectorIIDataDic[actId]
  if activity_sectorII == nil then
    return false
  end
  return activity_sectorII.isTurnOnMultEfficient
end

function UserData:SetSectorIIRecommendShopIsLooked(shopId, bool)
  if self.activityData.sectorIIRecommendShopDic[shopId] == bool then
    return
  end
  self.activityData.sectorIIRecommendShopDic[shopId] = bool
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetSectorIIRecommendShopIsLooked(shopId)
  return self.activityData.sectorIIRecommendShopDic[shopId]
end

function UserData:SetChipGiftPopIgnore(giftId, time, endTime)
  if time ~= nil then
    time = math.floor(time)
  end
  if endTime ~= nil then
    endTime = math.floor(endTime)
  end
  if self.chipGiftPop.ignoreEndTime == nil then
    self.chipGiftPop.ignoreEndTime = {}
  end
  if self.chipGiftPop.ignoreTime[giftId] == time and self.chipGiftPop.ignoreEndTime[giftId] == endTime then
    return
  end
  self.chipGiftPop.ignoreTime[giftId] = time
  self.chipGiftPop.ignoreEndTime[giftId] = endTime
  self:SetPstDataDirty()
end

function UserData:GetChipGiftPopIgnore(giftId)
  local endTime
  if self.chipGiftPop.ignoreEndTime ~= nil then
    endTime = self.chipGiftPop.ignoreEndTime[giftId]
  end
  return self.chipGiftPop.ignoreTime[giftId], endTime
end

function UserData:TryClearChipGiftPopIgnore()
  local giftCfg = ConfigData.pay_gift_type
  local dataDirty = false
  for id, v in pairs(self.chipGiftPop.ignoreTime) do
    if giftCfg[id] == nil then
      self.chipGiftPop.ignoreTime[id] = nil
      dataDirty = true
    end
  end
  if self.chipGiftPop.ignoreEndTime ~= nil then
    for id, v in pairs(self.chipGiftPop.ignoreEndTime) do
      if giftCfg[id] == nil then
        self.chipGiftPop.ignoreTime[id] = nil
        dataDirty = true
      end
    end
  end
  if dataDirty then
    self:SetPstDataDirty()
    self:DelaySavePstData(2)
  end
end

function UserData:IsGuidPicLooked(tipsId)
  if self.guidePicIdDic == nil then
    return false
  end
  return self.guidePicIdDic[tipsId]
end

function UserData:RecordGuidPicLooked(tipsId)
  if self.guidePicIdDic == nil then
    self.guidePicIdDic = {}
  end
  if self.guidePicIdDic[tipsId] then
    return
  end
  self.guidePicIdDic[tipsId] = true
  self:SetPstDataDirty()
end

function UserData:RecordCarnivalDiffEnv(actId, envId, diffculty)
  local singleData = self.activityData.activityCarnivalDic[actId]
  if singleData == nil then
    singleData = self:__InitActivityCarnival()
    self.activityData.activityCarnivalDic[actId] = singleData
  end
  local recordValue = envId << 16 | diffculty
  if singleData.diffEnv == recordValue then
    return
  end
  singleData.diffEnv = recordValue
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetCarnivalDiffEnv(actId)
  local singleData = self.activityData.activityCarnivalDic[actId]
  if singleData == nil then
    return nil, nil
  end
  if singleData.diffEnv == 0 then
    return nil, nil
  end
  return singleData.diffEnv >> 16, singleData.diffEnv & 65535
end

function UserData:SetCarnivalAvg(actId, avgId)
  local singleData = self.activityData.activityCarnivalDic[actId]
  if singleData == nil then
    singleData = self:__InitActivityCarnival()
    self.activityData.activityCarnivalDic[actId] = singleData
  end
  singleData.avgReviewDic[avgId] = true
end

function UserData:GetCarnivalAvg(actId, avgId)
  local singleData = self.activityData.activityCarnivalDic[actId]
  if singleData == nil then
    return false
  end
  return singleData.avgReviewDic[avgId]
end

function UserData:TryDeleteCarnival(ingoreActTable)
  if self.activityData == nil or self.activityData.activityCarnivalDic == nil then
    return
  end
  local apply = false
  for actId, v in pairs(self.activityData.activityCarnivalDic) do
    if ingoreActTable[actId] == nil then
      self.activityData.activityCarnivalDic[actId] = nil
      apply = true
    end
  end
  if apply then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:RecordADCEnterTime(actId, time)
  time = math.floor(time)
  local apply = false
  local recordTable = self.activityData.adcDic[actId]
  if recordTable == nil then
    recordTable = {}
    recordTable.enterTime = time
    recordTable.buffSelect = {}
    recordTable.dungeonId = {}
    self.activityData.adcDic[actId] = recordTable
    apply = true
  elseif recordTable.enterTime ~= time then
    recordTable.enterTime = time
    apply = true
  end
  if apply then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:RecordADCDungeonIds(actId, dungeonIds)
  local apply = false
  local recordTable = self.activityData.adcDic[actId]
  if recordTable == nil then
    recordTable = {}
    recordTable.buffSelect = {}
    self.activityData.adcDic[actId] = recordTable
    apply = true
    recordTable.dungeonId = dungeonIds
  else
    recordTable.dungeonId = dungeonIds
    apply = true
  end
  if apply then
    self:SetPstDataDirty()
    self:AutoSaveSingletonPst(1)
  end
end

function UserData:GetADCEnterTime(actId)
  local recordTable = self.activityData.adcDic[actId]
  if recordTable == nil then
    return 0
  end
  return recordTable.enterTime or 0
end

function UserData:GetADCDungeonIdS(actId)
  local recordTable = self.activityData.adcDic[actId]
  if recordTable == nil then
    return {}
  end
  return recordTable.dungeonId
end

function UserData:RecordADCBuffSelect(actId, dungeonOrder, buffSelectDic)
  local apply = false
  local recordTable = self.activityData.adcDic[actId]
  if recordTable == nil then
    recordTable = {}
    recordTable.enterTime = 0
    recordTable.buffSelect = {}
    recordTable.dungeonId = {}
    self.activityData.adcDic[actId] = recordTable
  end
  local ingoreDic = {}
  local targetValue = 1 << dungeonOrder
  for k, v in pairs(recordTable.buffSelect) do
    if 0 < v & targetValue then
      if buffSelectDic[k] ~= nil then
        ingoreDic[k] = true
      else
        recordTable.buffSelect[k] = v ~ targetValue
        apply = true
      end
    end
  end
  for k, _ in pairs(buffSelectDic) do
    if not ingoreDic[k] then
      local recordValue = recordTable.buffSelect[k] or 0
      if recordValue & targetValue == 0 then
        recordTable.buffSelect[k] = recordValue | targetValue
        apply = true
      end
    end
  end
  if apply then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetADCBuffSelect(actId, dungeonOrder)
  local buffDic = {}
  local recordTable = self.activityData.adcDic[actId]
  if recordTable == nil then
    return buffDic
  end
  local targetValue = 1 << dungeonOrder
  for k, v in pairs(recordTable.buffSelect) do
    if 0 < v & targetValue then
      buffDic[k] = true
    end
  end
  return buffDic
end

function UserData:TryDeleteADCEnterTime(ingoreActTable)
  if self.activityData == nil or self.activityData.adcDic == nil then
    return
  end
  local apply = false
  for actId, v in pairs(self.activityData.adcDic) do
    if ingoreActTable[actId] == nil then
      self.activityData.adcDic[actId] = nil
      apply = true
    end
  end
  if apply then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetTwinTowerNewReaded(towerId)
  return self.specialReddotData.twinTowerReaded[towerId] or false
end

function UserData:SetTwinTowerNewReaded(towerId, value)
  local oldValue = self.specialReddotData.twinTowerReaded[towerId]
  if oldValue == value then
    return false
  end
  self.specialReddotData.twinTowerReaded[towerId] = value
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
  return true
end

function UserData:GetNormalTowerLevel()
  return self.specialReddotData.normalTowerLevel
end

function UserData:SetNormalTowerLevel(value)
  local oldValue = self.specialReddotData.normalTowerLevel
  if oldValue == value then
    return false
  end
  self.specialReddotData.normalTowerLevel = value
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
  return true
end

function UserData:SetHallowmasEnvTaskLooked(actId, envId)
  self:__InitHallowmasData()
  local dataTable = self.activityData.hallowmasActivity[actId]
  if dataTable == nil then
    dataTable = {
      envTaskLookedDic = {}
    }
    self.activityData.hallowmasActivity[actId] = dataTable
  end
  if dataTable.envTaskLookedDic[envId] then
    return
  end
  dataTable.envTaskLookedDic[envId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetHallowmasEnvTaskLooked(actId, envId)
  if self.activityData.hallowmasActivity == nil then
    return false
  end
  local dataTable = self.activityData.hallowmasActivity[actId]
  if dataTable == nil then
    return false
  end
  return dataTable.envTaskLookedDic[envId]
end

function UserData:TryClearHallowmas(ingoreActTable)
  if self.activityData.hallowmasActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.hallowmasActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.hallowmasActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:SetSpring23HardLevelLooked(actId)
  self:__InitSpring23Data()
  local dataTable = self.activityData.spring23Activity[actId]
  if dataTable == nil then
    dataTable = {
      enterHardLevel = false,
      notEnteredNewEnv = {}
    }
    self.activityData.spring23Activity[actId] = dataTable
  end
  if dataTable.enterHardLevel then
    return
  end
  dataTable.enterHardLevel = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSpring23HardLevelLooked(actId)
  if self.activityData.spring23Activity == nil then
    return false
  end
  local dataTable = self.activityData.spring23Activity[actId]
  if dataTable == nil then
    return false
  end
  return dataTable.enterHardLevel
end

function UserData:SetSpring23IsNotEnteredNewEnv(actId, envId, bool)
  self:__InitSpring23Data()
  local dataTable = self.activityData.spring23Activity[actId]
  if dataTable == nil then
    dataTable = {
      enterHardLevel = false,
      notEnteredNewEnv = {}
    }
    self.activityData.spring23Activity[actId] = dataTable
  end
  if dataTable.notEnteredNewEnv == nil then
    dataTable.notEnteredNewEnv = {}
  end
  local isNeedUpdate = false
  if bool then
    isNeedUpdate = dataTable.notEnteredNewEnv[envId] ~= true
    dataTable.notEnteredNewEnv[envId] = true
  else
    isNeedUpdate = dataTable.notEnteredNewEnv[envId] ~= nil
    dataTable.notEnteredNewEnv[envId] = nil
  end
  if isNeedUpdate then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetSpring23IsNotEnteredNewEnv(actId, envId)
  if self.activityData.spring23Activity == nil then
    return false
  end
  local dataTable = self.activityData.spring23Activity[actId]
  if dataTable == nil then
    return false
  end
  if dataTable.notEnteredNewEnv == nil then
    return false
  end
  return dataTable.notEnteredNewEnv[envId] == true
end

function UserData:TryClearSpring(ingoreActTable)
  if self.activityData.spring23Activity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.spring23Activity) do
    if ingoreActTable[k] == nil then
      self.activityData.spring23Activity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:SetComebackPopLooked(actId)
  self:__InitComebackData()
  local dataTable = self.activityData.comebackActivity[actId]
  if dataTable == nil then
    dataTable = {popLooked = true}
    self.activityData.comebackActivity[actId] = dataTable
  end
  dataTable.popLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetComebackPopLooked(actId)
  if self.activityData.comebackActivity == nil then
    return false
  end
  local dataTable = self.activityData.comebackActivity[actId]
  if dataTable == nil then
    return false
  end
  return dataTable.popLooked
end

function UserData:TryClearComebackPopLooked(ingoreActTable)
  if self.activityData.comebackActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.comebackActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.comebackActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetWinter23ShopLooked(actId, shopId)
  if self.activityData.winter23Activity == nil then
    return false
  end
  local dataTable = self.activityData.winter23Activity[actId]
  if dataTable == nil or dataTable.shopReads == nil then
    return false
  end
  return dataTable.shopReads[shopId]
end

function UserData:SetWinter23ShopLooked(actId, shopId)
  self:__InitWinter23Data()
  local dataTable = self.activityData.winter23Activity[actId]
  if dataTable == nil then
    dataTable = {
      shopReads = {}
    }
    self.activityData.winter23Activity[actId] = dataTable
  end
  if dataTable.shopReads[shopId] then
    return
  end
  dataTable.shopReads[shopId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetWinter23FirstEnterSectorId(actId)
  if self.activityData.winter23Activity == nil then
    return false
  end
  local dataTable = self.activityData.winter23Activity[actId]
  if dataTable == nil or dataTable.firstEnterSectorId == nil then
    return false
  end
  return dataTable.firstEnterSectorId
end

function UserData:SetWinter23FirstEnterSectorId(actId, sectorId)
  self:__InitWinter23Data()
  local dataTable = self.activityData.winter23Activity[actId]
  if dataTable == nil then
    dataTable = {
      shopReads = {}
    }
    self.activityData.winter23Activity[actId] = dataTable
  end
  dataTable.firstEnterSectorId = sectorId
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearWinter23(ingoreActTable)
  if self.activityData.winter23Activity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.winter23Activity) do
    if ingoreActTable[k] == nil then
      self.activityData.winter23Activity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetCarnival23FirstEnterSectorId(actId)
  if self.activityData.carnival23Activity == nil then
    return false
  end
  local dataTable = self.activityData.carnival23Activity[actId]
  if dataTable == nil or dataTable.firstEnterSectorId == nil then
    return false
  end
  return dataTable.firstEnterSectorId
end

function UserData:SetCarnival23FirstEnterSectorId(actId, sectorId)
  self:__InitCarnival23Data()
  local dataTable = self.activityData.carnival23Activity[actId]
  if dataTable == nil then
    dataTable = {
      shopReads = {}
    }
    self.activityData.carnival23Activity[actId] = dataTable
  end
  dataTable.firstEnterSectorId = sectorId
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCarnival23ShopLooked(actId, shopId)
  if self.activityData.carnival23Activity == nil then
    return false
  end
  local dataTable = self.activityData.carnival23Activity[actId]
  if dataTable == nil or dataTable.shopReads == nil then
    return false
  end
  return dataTable.shopReads[shopId]
end

function UserData:SetCarnival23ShopLooked(actId, shopId)
  self:__InitCarnival23Data()
  local dataTable = self.activityData.carnival23Activity[actId]
  if dataTable == nil then
    dataTable = {
      shopReads = {}
    }
    self.activityData.carnival23Activity[actId] = dataTable
  end
  if dataTable.shopReads[shopId] then
    return
  end
  dataTable.shopReads[shopId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCarnival23ExtraSectorLooked(actId)
  if self.activityData.carnival23Activity == nil then
    return false
  end
  local dataTable = self.activityData.carnival23Activity[actId]
  if dataTable == nil or dataTable.isLookedExtraSector == nil then
    return false
  end
  return dataTable.isLookedExtraSector
end

function UserData:SetCarnival23ExtraSectorLooked(actId)
  self:__InitCarnival23Data()
  local dataTable = self.activityData.carnival23Activity[actId]
  if dataTable == nil then
    dataTable = {
      shopReads = {}
    }
    self.activityData.carnival23Activity[actId] = dataTable
  end
  if dataTable.isLookedExtraSector then
    return
  end
  dataTable.isLookedExtraSector = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAnniversary23ShopLooked(actId, shopId)
  if self.activityData.anniversary23Activity == nil then
    return false
  end
  local dataTable = self.activityData.anniversary23Activity[actId]
  if dataTable == nil or dataTable.shopReads == nil then
    return false
  end
  return dataTable.shopReads[shopId]
end

function UserData:SetAnniversary23ShopLooked(actId, shopId)
  self:__InitAnniversary23Data()
  local dataTable = self.activityData.anniversary23Activity[actId]
  if dataTable == nil then
    dataTable = {
      shopReads = {}
    }
    self.activityData.anniversary23Activity[actId] = dataTable
  end
  if dataTable.shopReads[shopId] then
    return
  end
  dataTable.shopReads[shopId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCarnival24Data(actId)
  local dataTable = self.activityData.activityCarnival24[actId]
  if dataTable == nil then
    dataTable = {
      shopReads = {},
      diffSelectDic = {},
      memoryFragmentUnlockLooked = {}
    }
    self.activityData.activityCarnival24[actId] = dataTable
  end
  return dataTable
end

function UserData:GetCarnival24ShopLooked(actId, shopId)
  if self.activityData.activityCarnival24 == nil then
    return false
  end
  local dataTable = self.activityData.activityCarnival24[actId]
  if dataTable == nil or dataTable.shopReads == nil then
    return false
  end
  return dataTable.shopReads[shopId]
end

function UserData:SetCarnival24ShopLooked(actId, shopId)
  self:__InitCarnival24Data()
  local dataTable = self:GetCarnival24Data(actId)
  if dataTable.shopReads[shopId] then
    return
  end
  dataTable.shopReads[shopId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCarnival24SelectBuffIds(actId, diff)
  if self.activityData.activityCarnival24 == nil then
    return false
  end
  local dataTable = self.activityData.activityCarnival24[actId]
  if dataTable == nil or dataTable.diffSelectDic == nil or dataTable.diffSelectDic[diff] == nil then
    return false
  end
  return dataTable.diffSelectDic[diff].buffIds
end

function UserData:SetCarnival24SelectBuffIds(actId, diff, buffIds)
  self:__InitCarnival24Data()
  local dataTable = self:GetCarnival24Data(actId)
  dataTable.diffSelectDic[diff] = {buffIds = buffIds}
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCarnival24MemoryFragmentUnlockLooked(actId, stageId)
  self:__InitCarnival24Data()
  local dataTable = self:GetCarnival24Data(actId)
  return dataTable.memoryFragmentUnlockLooked[stageId]
end

function UserData:SetCarnival24MemoryFragmentUnlockLooked(actId, stageId, isLooked)
  self:__InitCarnival24Data()
  local dataTable = self:GetCarnival24Data(actId)
  dataTable.memoryFragmentUnlockLooked[stageId] = isLooked
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetIsLookedFragmentOpenAVG(actId)
  self:__InitCarnival24Data()
  local dataTable = self:GetCarnival24Data(actId)
  return dataTable.isLookedFragmentOpenAVG
end

function UserData:SetIsLookedFragmentOpenAVG(actId, isLooked)
  self:__InitCarnival24Data()
  local dataTable = self:GetCarnival24Data(actId)
  dataTable.isLookedFragmentOpenAVG = isLooked
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAnni24Data(actId)
  local dataTable = self.activityData.activityAnniversary24[actId]
  if dataTable == nil then
    dataTable = {
      shopReads = {},
      firstEnterSectorId = 0,
      rfGroupId = 0,
      lastDiffIndex = 0,
      selectedFactCardUIDDic = {},
      lastInfinityLevelIndex = 0,
      checkScenePerformId = 0
    }
    self.activityData.activityAnniversary24[actId] = dataTable
  end
  return dataTable
end

function UserData:GetAnni24ShopLooked(actId, shopId)
  if self.activityData.activityAnniversary24 == nil then
    return false
  end
  local dataTable = self.activityData.activityAnniversary24[actId]
  if dataTable == nil or dataTable.shopReads == nil then
    return false
  end
  return dataTable.shopReads[shopId]
end

function UserData:SetAnni24ShopLooked(actId, shopId)
  self:__InitAnni24Data()
  local dataTable = self:GetAnni24Data(actId)
  if dataTable.shopReads[shopId] then
    return
  end
  dataTable.shopReads[shopId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAnni24FirstEnterSectorId(actId)
  if self.activityData.activityAnniversary24 == nil then
    return false
  end
  local dataTable = self.activityData.activityAnniversary24[actId]
  if dataTable == nil or dataTable.firstEnterSectorId == nil then
    return false
  end
  return dataTable.firstEnterSectorId
end

function UserData:SetAnni24FirstEnterSectorId(actId, sectorId)
  self:__InitAnni24Data()
  local dataTable = self:GetAnni24Data(actId)
  dataTable.firstEnterSectorId = sectorId
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAnni24LastDiffIndex(actId)
  if self.activityData.activityAnniversary24 == nil then
    return 0
  end
  local dataTable = self.activityData.activityAnniversary24[actId]
  if dataTable == nil or dataTable.lastDiffIndex == nil then
    return 0
  end
  return dataTable.lastDiffIndex
end

function UserData:SetAnni24LastDiffIndex(actId, diffIndex)
  self:__InitAnni24Data()
  local dataTable = self:GetAnni24Data(actId)
  dataTable.lastDiffIndex = diffIndex
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAnni24RfGroupId(actId)
  if self.activityData.activityAnniversary24 == nil then
    return 1
  end
  local dataTable = self.activityData.activityAnniversary24[actId]
  if dataTable == nil or dataTable.rfGroupId == 0 then
    return 1
  end
  return dataTable.rfGroupId
end

function UserData:SetAnni24RfGroupId(actId, groupId)
  self:__InitAnni24Data()
  local dataTable = self:GetAnni24Data(actId)
  dataTable.rfGroupId = groupId
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAnni24LastSelectFactCardId(actId, stageId)
  if self.activityData.activityAnniversary24 == nil then
    return false
  end
  local dataTable = self.activityData.activityAnniversary24[actId]
  if dataTable == nil or dataTable.selectedFactCardUIDDic == nil then
    return nil
  end
  return dataTable.selectedFactCardUIDDic[stageId]
end

function UserData:SetAnni24LastSelectFactCardId(actId, stageId, factCardUID)
  self:__InitAnni24Data()
  local dataTable = self:GetAnni24Data(actId)
  if dataTable.selectedFactCardUIDDic == nil then
    dataTable.selectedFactCardUIDDic = {}
  end
  dataTable.selectedFactCardUIDDic[stageId] = factCardUID
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAnni24SelectLayer(actId, stageId)
  if self.activityData.activityAnniversary24 == nil then
    return false
  end
  local dataTable = self.activityData.activityAnniversary24[actId]
  if dataTable == nil or dataTable.lastLevelDic == nil then
    return nil
  end
  return dataTable.lastLevelDic[stageId]
end

function UserData:SetAnni24SelectLayer(actId, stageId, layerIndex)
  self:__InitAnni24Data()
  local dataTable = self:GetAnni24Data(actId)
  if dataTable.lastLevelDic == nil then
    dataTable.lastLevelDic = {}
  end
  dataTable.lastLevelDic[stageId] = layerIndex
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAnni24LastInfinityLevelIndex(actId)
  if self.activityData.activityAnniversary24 == nil then
    return false
  end
  local dataTable = self.activityData.activityAnniversary24[actId]
  if dataTable == nil or dataTable.lastInfinityLevelIndex == nil or dataTable.lastInfinityLevelIndex == 0 then
    return nil
  end
  return dataTable.lastInfinityLevelIndex
end

function UserData:SetAnni24LastInfinityLevelIndex(actId, levelIndex)
  self:__InitAnni24Data()
  local dataTable = self:GetAnni24Data(actId)
  dataTable.lastInfinityLevelIndex = levelIndex
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAnni24CheckScenePerformId(actId)
  if self.activityData.activityAnniversary24 == nil then
    return 0
  end
  local dataTable = self.activityData.activityAnniversary24[actId]
  if dataTable == nil or dataTable.checkScenePerformId == nil or dataTable.checkScenePerformId == 0 then
    return 0
  end
  return dataTable.checkScenePerformId
end

function UserData:SetAnni24CheckScenePerformId(actId, performId)
  self:__InitAnni24Data()
  local dataTable = self:GetAnni24Data(actId)
  dataTable.checkScenePerformId = performId
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearAnni24(ingoreActTable)
  if self.activityData.activityAnniversary24 == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.activityAnniversary24) do
    if ingoreActTable[k] == nil then
      self.activityData.activityAnniversary24[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetLuckyRaffleAddressLooked(actId)
  if self.activityData.luckyRaffleActivity == nil then
    return false
  end
  local dataTable = self.activityData.luckyRaffleActivity[actId]
  if dataTable == nil or dataTable.isLookedAddress == nil then
    return false
  end
  return dataTable.isLookedAddress
end

function UserData:SetLuckyRaffleAddressLooked(actId)
  self:__InitLuckyRaffleData()
  local dataTable = self.activityData.luckyRaffleActivity[actId]
  if dataTable == nil then
    dataTable = {isLookedAddress = false}
    self.activityData.luckyRaffleActivity[actId] = dataTable
  end
  dataTable.isLookedAddress = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearLuckyRaffle(ingoreActTable)
  if self.activityData.luckyRaffleActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.luckyRaffleActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.luckyRaffleActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:TryClearCarnival23(ingoreActTable)
  if self.activityData.carnival23Activity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.carnival23Activity) do
    if ingoreActTable[k] == nil then
      self.activityData.carnival23Activity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:TryClearAnniversary23(ingoreActTable)
  if self.activityData.anniversary23Activity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.anniversary23Activity) do
    if ingoreActTable[k] == nil then
      self.activityData.anniversary23Activity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:TryClearCarnival24(ingoreActTable)
  if self.activityData.activityCarnival24 == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.activityCarnival24) do
    if ingoreActTable[k] == nil then
      self.activityData.activityCarnival24[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetInvitationLooked(actId)
  if self.activityData.invitationActivity == nil then
    return false
  end
  local dataTable = self.activityData.invitationActivity[actId]
  return dataTable ~= nil and dataTable.isFirstEnter
end

function UserData:SetInvitationLooked(actId)
  self:__InitInvitationData()
  local dataTable = self.activityData.invitationActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.invitationActivity[actId] = dataTable
  end
  if dataTable.isFirstEnter then
    return
  end
  dataTable = dataTable or {}
  dataTable.isFirstEnter = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearInvitationLooked(ingoreActTable)
  if self.activityData.invitationActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.invitationActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.invitationActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetWeeklyQALooked(actId, order)
  if self.activityData.answerActivity == nil then
    return false
  end
  local dataTable = self.activityData.answerActivity[actId]
  return dataTable ~= nil and dataTable.lastEnteredOrder == order
end

function UserData:SetWeeklyQALooked(actId, order)
  self:__InitWeeklyQAData()
  local dataTable = self.activityData.answerActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.answerActivity[actId] = dataTable
  end
  if dataTable.lastEnteredOrder == order then
    return
  end
  dataTable = dataTable or {}
  dataTable.lastEnteredOrder = order
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearWeeklyQALooked(ingoreActTable)
  if self.activityData.answerActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.answerActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.answerActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetAngelaGiftLooked(actId)
  if self.activityData.angelaGiftActivity == nil then
    return false
  end
  local dataTable = self.activityData.angelaGiftActivity[actId]
  return dataTable ~= nil and dataTable.isLooked
end

function UserData:SetAngelaGiftLooked(actId)
  self:__InitAngelaGiftData()
  local dataTable = self.activityData.angelaGiftActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.angelaGiftActivity[actId] = dataTable
  end
  if dataTable.isLooked then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAngelaGiftCanPop(actId)
  if self.activityData.angelaGiftActivity == nil then
    return true
  end
  local dataTable = self.activityData.angelaGiftActivity[actId]
  return dataTable == nil or dataTable.cantShowTime == nil
end

function UserData:SetAngelaGiftCantShowTime(actId, nextTm)
  self:__InitAngelaGiftData()
  local dataTable = self.activityData.angelaGiftActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.angelaGiftActivity[actId] = dataTable
  end
  dataTable = dataTable or {}
  dataTable.cantShowTime = nextTm
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearAngelaGiftLooked(ingoreActTable)
  if self.activityData.angelaGiftActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.angelaGiftActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.angelaGiftActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetSaveMoneyLooked(actId)
  if self.activityData.saveMoneyActivity == nil then
    return false
  end
  local dataTable = self.activityData.saveMoneyActivity[actId]
  return dataTable ~= nil and dataTable.isLooked
end

function UserData:SetSaveMoneyLooked(actId)
  self:__InitSaveMoneyData()
  local dataTable = self.activityData.saveMoneyActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.saveMoneyActivity[actId] = dataTable
  end
  if dataTable.isLooked then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSaveMoneyCanPop(actId)
  if self.activityData.saveMoneyActivity == nil then
    return true
  end
  local dataTable = self.activityData.saveMoneyActivity[actId]
  return dataTable == nil or dataTable.cantShowTime == nil or PlayerDataCenter.timestamp >= dataTable.cantShowTime
end

function UserData:SetSaveMoneyCantShowTime(actId, nextTm)
  self:__InitSaveMoneyData()
  local dataTable = self.activityData.saveMoneyActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.saveMoneyActivity[actId] = dataTable
  end
  dataTable = dataTable or {}
  dataTable.cantShowTime = nextTm
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearSaveMoney(ingoreActTable)
  if self.activityData.saveMoneyActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.saveMoneyActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.saveMoneyActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetDormFightFormationData()
  return self.fomationData.dormFightFormationList
end

function UserData:SetDormFightFormationData(dormFightFormationData)
  self.fomationData.dormFightFormationList = dormFightFormationData:GetFormationHeroDic()
  self:SetPstDataDirty()
end

function UserData:SetSpeacWeaponLooked(weaponId)
  if self.specialReddotData.specWeaponLookedDic[weaponId] then
    return
  end
  self.specialReddotData.specWeaponLookedDic[weaponId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSpeacWeaponLooked(weaponId)
  return self.specialReddotData.specWeaponLookedDic[weaponId]
end

function UserData:SetNewSectorMapRead(sectorMapId)
  if self.specialReddotData.newSectorMapRead[sectorMapId] then
    return
  end
  self.specialReddotData.newSectorMapRead[sectorMapId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:IsNewSectorMapRead(sectorMapId)
  return self.specialReddotData.newSectorMapRead[sectorMapId]
end

function UserData:SetAthDropBuffInfoShown()
  if self.dungeonExtrData.isAthDropBuffInfoShown then
    return
  end
  self.dungeonExtrData.isAthDropBuffInfoShown = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetAthDropBuffInfoShown()
  return self.dungeonExtrData.isAthDropBuffInfoShown
end

function UserData:GetDgChallengeRead(dungeonId)
  return self.dungeonExtrData.challengeRead[dungeonId] ~= nil
end

function UserData:SetDgChallengeRead(dungeonId)
  if self.dungeonExtrData.challengeRead[dungeonId] then
    return
  end
  self.dungeonExtrData.challengeRead[dungeonId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:SetCardSetRewindSort(actId, sortType, isReverse)
  self.activityData.cardSetActivity[actId] = self.activityData.cardSetActivity[actId] or {}
  local dataTable = self.activityData.cardSetActivity[actId]
  if dataTable.rewindSortType == sortType and dataTable.rewindSortReverse == isReverse then
    return
  end
  dataTable.rewindSortType = sortType
  dataTable.rewindSortReverse = isReverse
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCardSetRewindSort(actId)
  local dataTable = self.activityData.cardSetActivity[actId]
  local sortType = dataTable and dataTable.rewindSortType or 1
  local isReverse = dataTable and dataTable.rewindSortReverse or false
  if sortType == 0 then
    sortType = 1
  end
  return sortType, isReverse
end

function UserData:SetCardSetLastDiffId(actId, playType, diffId, roundId)
  self.activityData.cardSetActivity[actId] = self.activityData.cardSetActivity[actId] or {}
  local dataTable = self.activityData.cardSetActivity[actId]
  dataTable.lastSelected = dataTable.lastSelected or {}
  local k = self:_GetCardSetLastSelectedKey(playType, roundId)
  dataTable.lastSelected[k] = dataTable.lastSelected[k] or {}
  dataTable.lastSelected[k].difficultyId = diffId
  self:SetPstDataDirty()
end

function UserData:GetCardSetLastDiffId(actId, playType, roundId)
  local dataTable = self.activityData.cardSetActivity[actId]
  local k = self:_GetCardSetLastSelectedKey(playType, roundId)
  if dataTable and dataTable.lastSelected and dataTable.lastSelected[k] then
    return dataTable.lastSelected[k].difficultyId
  end
end

function UserData:SetCardSetDifficultRead(actId, diffId)
  self.activityData.cardSetActivity[actId] = self.activityData.cardSetActivity[actId] or {}
  local dataTable = self.activityData.cardSetActivity[actId]
  dataTable.newDifficultRead = dataTable.newDifficultRead or {}
  if dataTable.newDifficultRead[diffId] == true then
    return
  end
  dataTable.newDifficultRead[diffId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCardSetDifficultRead(actId, diffId)
  local dataTable = self.activityData.cardSetActivity[actId]
  return dataTable and dataTable.newDifficultRead[diffId] or false
end

function UserData:GetCardSetLastSelectedCardInfo(actId, playType, roundId)
  local dataTable = self.activityData.cardSetActivity[actId]
  local k = self:_GetCardSetLastSelectedKey(playType, roundId)
  if dataTable and dataTable.lastSelected and dataTable.lastSelected[k] then
    return dataTable.lastSelected[k]
  end
end

function UserData:SetCardSetLastSelectedCardInfo(actId, playType, infoTab)
  self.activityData.cardSetActivity[actId] = self.activityData.cardSetActivity[actId] or {}
  local dataTable = self.activityData.cardSetActivity[actId]
  dataTable.lastSelected = dataTable.lastSelected or {}
  local k = self:_GetCardSetLastSelectedKey(playType, infoTab.roundId)
  dataTable.lastSelected[k] = infoTab
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:_GetCardSetLastSelectedKey(playType, roundId)
  if playType == CardSetEnum.eSetType.rank then
    return playType << 32 | roundId
  else
    return playType << 32 | 0
  end
end

function UserData:GetCardSetDiffBtnRead(actId)
  local dataTable = self.activityData.cardSetActivity[actId]
  return dataTable and dataTable.diffBtnRead
end

function UserData:SetCardSetDiffBtnRead(actId)
  self.activityData.cardSetActivity[actId] = self.activityData.cardSetActivity[actId] or {}
  local dataTable = self.activityData.cardSetActivity[actId]
  if dataTable.diffBtnRead then
    return
  end
  dataTable.diffBtnRead = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCardSetIsEnterRankTask(actId)
  local dataTable = self.activityData.cardSetActivity[actId]
  return dataTable and dataTable.enterRankTask
end

function UserData:SetCardSetIsEnterRankTask(actId)
  self.activityData.cardSetActivity[actId] = self.activityData.cardSetActivity[actId] or {}
  local dataTable = self.activityData.cardSetActivity[actId]
  if dataTable.enterRankTask then
    return
  end
  dataTable.enterRankTask = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCardSetLastDiffPassTimesDic(actId)
  local dataTable = self.activityData.cardSetActivity[actId]
  return dataTable and dataTable.lastDiffPassTimes or table.emptytable
end

function UserData:SetCardSetLastDiffPassTimesDic(actId, lastDiffPassTimes)
  self.activityData.cardSetActivity[actId] = self.activityData.cardSetActivity[actId] or {}
  local dataTable = self.activityData.cardSetActivity[actId]
  dataTable.lastDiffPassTimes = lastDiffPassTimes
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearCardSet(ingoreActTable)
  if self.activityData.cardSetActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.cardSetActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.cardSetActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:SetUpgradeSkinRead(skinId)
  if self.specialReddotData.newUpgradeSkinRead[skinId] then
    return
  end
  self.specialReddotData.newUpgradeSkinRead[skinId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:IsUpgradeSkinRead(skinId)
  return self.specialReddotData.newUpgradeSkinRead[skinId]
end

function UserData:SetHeroVowStoryTip(heroId)
  if self.specialReddotData.heroVowStoryTipDic[heroId] then
    return
  end
  self.specialReddotData.heroVowStoryTipDic[heroId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetHeroVowStoryTip(heroId)
  return self.specialReddotData.heroVowStoryTipDic[heroId]
end

function UserData:SetHeroFriendLevelTip(heroId, tipLevel)
  local level = self.specialReddotData.heroFriendLevelTipDic[heroId] or 0
  if tipLevel <= level then
    return
  end
  self.specialReddotData.heroFriendLevelTipDic[heroId] = tipLevel
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetHeroFriendLevelTip(heroId)
  return self.specialReddotData.heroFriendLevelTipDic[heroId] or 0
end

function UserData:SetHeroFriendLevelTipTime(heroId)
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local needTime = timePassCtrl:GetLogicTodayPassTimeStamp() - 86400
  local recordTime = self.specialReddotData.heroFriendLevelTimeDic[heroId] or 0
  if needTime <= recordTime then
    return
  end
  self.specialReddotData.heroFriendLevelTimeDic[heroId] = needTime
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetHeroFriendLevelTipTime(heroId)
  return self.specialReddotData.heroFriendLevelTimeDic[heroId] or 0
end

function UserData:GetDivergentHeroSectorLooked(actId, heroId)
  if self.activityData.divergentActivity == nil then
    return false
  end
  local dataTable = self.activityData.divergentActivity[actId]
  return dataTable ~= nil and dataTable.heroSectorLooked[heroId]
end

function UserData:SetDivergentHeroSectorLooked(actId, heroId)
  self:__InitDivergentData()
  local dataTable = self.activityData.divergentActivity[actId]
  if dataTable == nil then
    dataTable = {
      heroSectorLooked = {}
    }
    self.activityData.divergentActivity[actId] = dataTable
  end
  if dataTable.heroSectorLooked[heroId] then
    return
  end
  dataTable = dataTable or {
    heroSectorLooked = {}
  }
  dataTable.heroSectorLooked[heroId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearDivergent(ingoreActTable)
  if self.activityData.divergentActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.divergentActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.divergentActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetCommonActEnvIsLooked(actFrameId, envId)
  if self.activityData.commonActDic == nil then
    return false
  end
  local dataTable = self.activityData.commonActDic[actFrameId]
  return dataTable ~= nil and dataTable.isEnvLooked ~= nil and dataTable.isEnvLooked[envId]
end

function UserData:SetCommonActEnvIsLooked(actFrameId, envId)
  self:__InitActCommonData()
  local dataTable = self.activityData.commonActDic[actFrameId]
  if dataTable == nil then
    dataTable = {
      isEnvLooked = {}
    }
    self.activityData.commonActDic[actFrameId] = dataTable
  end
  if dataTable.isEnvLooked == nil then
    dataTable.isEnvLooked = {}
  end
  if dataTable.isEnvLooked[envId] then
    return
  end
  dataTable.isEnvLooked[envId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCommonMonsterCardIsHasBlue(actFrameId, monCardId)
  if self.activityData.commonActDic == nil then
    return false
  end
  local dataTable = self.activityData.commonActDic[actFrameId]
  return dataTable ~= nil and dataTable.isMonsterCardNewOrUpdated ~= nil and dataTable.isMonsterCardNewOrUpdated[monCardId]
end

function UserData:SetCommonMonsterCardIsHasBlue(actFrameId, monCardId, bool)
  self:__InitActCommonData()
  local dataTable = self.activityData.commonActDic[actFrameId]
  if dataTable == nil then
    dataTable = {
      isMonsterCardNewOrUpdated = {}
    }
    self.activityData.commonActDic[actFrameId] = dataTable
  end
  if dataTable.isMonsterCardNewOrUpdated == nil then
    dataTable.isMonsterCardNewOrUpdated = {}
  end
  if dataTable.isMonsterCardNewOrUpdated[monCardId] == bool then
    return
  end
  dataTable.isMonsterCardNewOrUpdated[monCardId] = bool
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetCommonHardDunLevelIsSeen(actFrameId, dunStageId)
  if self.activityData.commonActDic == nil then
    return false
  end
  local dataTable = self.activityData.commonActDic[actFrameId]
  return dataTable ~= nil and dataTable.isNewUnlockHardDun ~= nil and dataTable.isNewUnlockHardDun[dunStageId]
end

function UserData:SetCommonHardDunLevelIsSeen(actFrameId, dunStageId, bool)
  self:__InitActCommonData()
  local dataTable = self.activityData.commonActDic[actFrameId]
  if dataTable == nil then
    dataTable = {
      isNewUnlockHardDun = {}
    }
    self.activityData.commonActDic[actFrameId] = dataTable
  end
  if dataTable.isNewUnlockHardDun == nil then
    dataTable.isNewUnlockHardDun = {}
  end
  if dataTable.isNewUnlockHardDun[dunStageId] == bool then
    return
  end
  dataTable.isNewUnlockHardDun[dunStageId] = bool
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearCommonActUserData()
  if self.activityData.commonActDic == nil then
    return
  end
  local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local activityDic = activivityCtrl:GetActivityFrameDataDic()
  local isClear = false
  local needClanDic = {}
  for actFrameId, data in pairs(self.activityData.commonActDic) do
    if activityDic[actFrameId] == nil then
      needClanDic[actFrameId] = true
    end
  end
  for actFrameId, _ in pairs(needClanDic) do
    if self.activityData.commonActDic[actFrameId] ~= nil then
      self.activityData.commonActDic[actFrameId] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetFlipCardLooked(actId)
  if self.activityData.flipCardActivity == nil then
    return false
  end
  local dataTable = self.activityData.flipCardActivity[actId]
  return dataTable ~= nil and dataTable.isLooked
end

function UserData:SetFlipCardLooked(actId)
  self:__InitFlipCardData()
  local dataTable = self.activityData.flipCardActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.flipCardActivity[actId] = dataTable
  end
  if dataTable.isLooked then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearFlipCard(ingoreActTable)
  if self.activityData.flipCardActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.flipCardActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.flipCardActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetSkinLimitLooked(actId)
  if self.activityData.skinLimitActivity == nil then
    return false
  end
  local dataTable = self.activityData.skinLimitActivity[actId]
  return dataTable ~= nil and dataTable.isLooked
end

function UserData:SetSkinLimitLooked(actId)
  self:__InitSkinLimitData()
  local dataTable = self.activityData.skinLimitActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.skinLimitActivity[actId] = dataTable
  end
  if dataTable.isLooked then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearSkinLimit(ingoreActTable)
  if self.activityData.skinLimitActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.skinLimitActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.skinLimitActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetBlackHoleLooked(actId)
  if self.activityData.blackHoleActivity == nil then
    return false
  end
  local dataTable = self.activityData.blackHoleActivity[actId]
  return dataTable ~= nil and dataTable.isLooked
end

function UserData:SetBlackHoleLooked(actId)
  self:__InitBlackHoleData()
  local dataTable = self.activityData.blackHoleActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.blackHoleActivity[actId] = dataTable
  end
  if dataTable.isLooked then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearBlackHole(ingoreActTable)
  if self.activityData.blackHoleActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.blackHoleActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.blackHoleActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetLadderGiftCanPop(actId)
  if self.activityData.ladderGiftActivity == nil then
    return true
  end
  local dataTable = self.activityData.ladderGiftActivity[actId]
  return dataTable == nil or dataTable.cantShowTime == nil
end

function UserData:SetLadderGiftCantShowTime(actId, nextTm)
  self:__InitLadderGiftData()
  local dataTable = self.activityData.ladderGiftActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.ladderGiftActivity[actId] = dataTable
  end
  dataTable = dataTable or {}
  dataTable.cantShowTime = nextTm
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearLadderGift(ingoreActTable)
  if self.activityData.ladderGiftActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.ladderGiftActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.ladderGiftActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:RecordSteinsGateDiff(actId, diffculty)
  self:__InitSteinsGateData()
  local singleData = self.activityData.steinsGateActivity[actId]
  if singleData == nil then
    singleData = {}
    self.activityData.steinsGateActivity[actId] = singleData
  end
  if singleData.lastSelectDiff == diffculty then
    return
  end
  singleData.lastSelectDiff = diffculty
  self:SetPstDataDirty()
  self:DelaySavePstData(2)
end

function UserData:GetSteinsGateDiff(actId)
  local singleData = self.activityData.steinsGateActivity[actId]
  if singleData == nil then
    return nil
  end
  if singleData.lastSelectDiff == 0 then
    return nil
  end
  return singleData.lastSelectDiff
end

function UserData:SetSteinsGateLooked(actId)
  self:__InitSteinsGateData()
  local dataTable = self.activityData.steinsGateActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.steinsGateActivity[actId] = dataTable
  end
  if dataTable.isLooked then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSteinsGateLooked(actId)
  if self.activityData.steinsGateActivity == nil then
    return false
  end
  local dataTable = self.activityData.steinsGateActivity[actId]
  return dataTable ~= nil and dataTable.isLooked
end

function UserData:SetSteinsGateRepeatLooked(actId)
  self:__InitSteinsGateData()
  local dataTable = self.activityData.steinsGateActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.steinsGateActivity[actId] = dataTable
  end
  if dataTable.isLookedRepeatUnlock then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLookedRepeatUnlock = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSteinsGateRepeatLooked(actId)
  if self.activityData.steinsGateActivity == nil then
    return false
  end
  local dataTable = self.activityData.steinsGateActivity[actId]
  return dataTable ~= nil and dataTable.isLookedRepeatUnlock
end

function UserData:SetSteinsGateCardSetLooked(actId)
  self:__InitSteinsGateData()
  local dataTable = self.activityData.steinsGateActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.steinsGateActivity[actId] = dataTable
  end
  if dataTable.isLookedCardSetUnlock then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLookedCardSetUnlock = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSteinsGateH5MiniGameLooked(actId)
  if self.activityData.steinsGateActivity == nil then
    return false
  end
  local dataTable = self.activityData.steinsGateActivity[actId]
  return dataTable ~= nil and dataTable.isLookedH5MiniGame
end

function UserData:SetSteinsGateH5MiniGameLooked(actId)
  self:__InitSteinsGateData()
  local dataTable = self.activityData.steinsGateActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.steinsGateActivity[actId] = dataTable
  end
  if dataTable.isLookedH5MiniGame then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLookedH5MiniGame = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSteinsGateBrotatoLooked(actId)
  if self.activityData.steinsGateActivity == nil then
    return false
  end
  local dataTable = self.activityData.steinsGateActivity[actId]
  return dataTable ~= nil and dataTable.isLookedBrotato
end

function UserData:SetSteinsGateBrotatoLooked(actId)
  self:__InitSteinsGateData()
  local dataTable = self.activityData.steinsGateActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.steinsGateActivity[actId] = dataTable
  end
  if dataTable.isLookedBrotato then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLookedBrotato = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetSteinsGateCardSetLooked(actId)
  if self.activityData.steinsGateActivity == nil then
    return false
  end
  local dataTable = self.activityData.steinsGateActivity[actId]
  return dataTable ~= nil and dataTable.isLookedCardSetUnlock
end

function UserData:TryClearSteinsGate(ingoreActTable)
  if self.activityData.steinsGateActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.steinsGateActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.steinsGateActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetHazeGiftLooked(actId)
  if self.activityData.hazeGiftActivity == nil then
    return false
  end
  local dataTable = self.activityData.hazeGiftActivity[actId]
  return dataTable ~= nil and dataTable.isLooked
end

function UserData:SetHazeGiftLooked(actId)
  self:__InitHazeGiftData()
  local dataTable = self.activityData.hazeGiftActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.hazeGiftActivity[actId] = dataTable
  end
  if dataTable.isLooked then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetHazeGiftDayActLooked(actId, dayIndex)
  if self.activityData.hazeGiftActivity == nil then
    return false
  end
  local dataTable = self.activityData.hazeGiftActivity[actId]
  return dataTable ~= nil and dataTable.isDayLooked and dataTable.isDayLooked[dayIndex]
end

function UserData:SetHazeGiftDayActLooked(actId, dayIndex)
  self:__InitHazeGiftData()
  local dataTable = self.activityData.hazeGiftActivity[actId]
  if dataTable == nil then
    dataTable = {}
    dataTable.isDayLooked = {}
    self.activityData.hazeGiftActivity[actId] = dataTable
  end
  if dataTable.isDayLooked and dataTable.isDayLooked[dayIndex] then
    return
  end
  dataTable = dataTable or {}
  dataTable.isDayLooked = dataTable.isDayLooked or {}
  dataTable.isDayLooked[dayIndex] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetHazeGiftDayRefreshTimes(actId, dayIndex)
  if self.activityData.hazeGiftActivity == nil then
    return false
  end
  local dataTable = self.activityData.hazeGiftActivity[actId]
  return dataTable ~= nil and dataTable.nextRefreshTimes and dataTable.nextRefreshTimes[dayIndex]
end

function UserData:SetHazeGiftDayRefreshTimes(actId, dayIndex, time)
  self:__InitHazeGiftData()
  local dataTable = self.activityData.hazeGiftActivity[actId]
  if dataTable == nil then
    dataTable = {}
    dataTable.nextRefreshTimes = {}
    self.activityData.hazeGiftActivity[actId] = dataTable
  end
  if dataTable.nextRefreshTimes and dataTable.nextRefreshTimes[dayIndex] then
    return
  end
  dataTable = dataTable or {}
  dataTable.nextRefreshTimes = dataTable.nextRefreshTimes or {}
  dataTable.nextRefreshTimes[dayIndex] = time
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearHazeGift(ingoreActTable)
  if self.activityData.hazeGiftActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.hazeGiftActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.hazeGiftActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetTreasureHuntRecord(actId)
  if self.activityData.treasureHuntActivity == nil then
    return false
  end
  local dataTable = self.activityData.treasureHuntActivity[actId]
  return dataTable ~= nil and dataTable.record or 0
end

function UserData:SetTreasureHuntRecord(actId, num)
  self:__InitTreasureHuntData()
  local dataTable = self.activityData.treasureHuntActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.treasureHuntActivity[actId] = dataTable
  end
  dataTable = dataTable or {}
  dataTable.record = num
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearTreasureHunt(ingoreActTable)
  if self.activityData.treasureHuntActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.treasureHuntActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.treasureHuntActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetCollectFortuneLooked(actId)
  if self.activityData.collectFortuneActivity == nil then
    return false
  end
  local dataTable = self.activityData.collectFortuneActivity[actId]
  return dataTable ~= nil and dataTable.isLooked
end

function UserData:SetCollectFortuneLooked(actId)
  self:__InitCollectFortuneData()
  local dataTable = self.activityData.collectFortuneActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.collectFortuneActivity[actId] = dataTable
  end
  if dataTable.isLooked then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearCollectFortune(ingoreActTable)
  if self.activityData.collectFortuneActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.collectFortuneActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.collectFortuneActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetSignInLiveLooked(actId)
  if self.activityData.signInLiveActivity == nil then
    return false
  end
  local dataTable = self.activityData.signInLiveActivity[actId]
  return dataTable ~= nil and dataTable.isLooked
end

function UserData:SetSignInLiveLooked(actId)
  self:__InitSignInLiveData()
  local dataTable = self.activityData.signInLiveActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.signInLiveActivity[actId] = dataTable
  end
  if dataTable.isLooked then
    return
  end
  dataTable = dataTable or {}
  dataTable.isLooked = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearSignInLive(ingoreActTable)
  if self.activityData.signInLiveActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.signInLiveActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.signInLiveActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetBondDunGroupLooked(actId, dunGroupId)
  if self.activityData.bondActivity == nil then
    return false
  end
  local dataTable = self.activityData.bondActivity[actId]
  if dataTable == nil then
    return false
  end
  if dataTable.isDunGroupLooked == nil then
    return false
  end
  return dataTable.isDunGroupLooked[dunGroupId]
end

function UserData:SetBondDunGroupLooked(actId, dunGroupId)
  self:__InitBondActData()
  local dataTable = self.activityData.bondActivity[actId]
  if dataTable == nil then
    dataTable = {}
    self.activityData.bondActivity[actId] = dataTable
  end
  if dataTable.isDunGroupLooked == nil then
    dataTable.isDunGroupLooked = {}
  end
  if dataTable.isDunGroupLooked[dunGroupId] then
    return
  end
  dataTable.isDunGroupLooked[dunGroupId] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearBondAct(ingoreActTable)
  if self.activityData.bondActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.bondActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.bondActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

function UserData:GetDSData(actId)
  local dataTable = self.activityData.dSActivity[actId]
  if dataTable == nil then
    dataTable = {}
    dataTable.levelSelectDic = {}
    self.activityData.dSActivity[actId] = dataTable
  end
  return dataTable
end

function UserData:GetActDSLevelSelect(actId)
  if self.activityData.dSActivity == nil then
    return 1
  end
  local dataTable = self.activityData.dSActivity[actId]
  if dataTable == nil then
    return 1
  end
  return dataTable.level
end

function UserData:SetActDSLevelSelect(actId, level)
  self:__InitDSActData()
  local dataTable = self:GetDSData(actId)
  dataTable.level = level
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:GetActDSLevelSelectIsLooked(actId, level)
  if self.activityData.dSActivity == nil then
    return false
  end
  local dataTable = self.activityData.dSActivity[actId]
  if dataTable == nil then
    return false
  end
  local selectDic = dataTable.levelSelectDic
  if selectDic == nil then
    return false
  end
  return selectDic[level]
end

function UserData:SetActDSLevelSelectLook(actId, level)
  self:__InitDSActData()
  local dataTable = self:GetDSData(actId)
  dataTable.levelSelectDic[level] = true
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserData:TryClearDSAct(ingoreActTable)
  if self.activityData.dSActivity == nil then
    return
  end
  local isClear = false
  for k, v in pairs(self.activityData.dSActivity) do
    if ingoreActTable[k] == nil then
      self.activityData.dSActivity[k] = nil
      isClear = true
    end
  end
  if isClear then
    self:SetPstDataDirty()
    self:DelaySavePstData(1)
  end
end

return UserData
