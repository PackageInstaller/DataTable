local DungeonInterfaceData = class("DungeonInterfaceData")
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function DungeonInterfaceData:ctor()
  self.__interfaceType = DungeonLevelEnum.InterfaceType.Default
  self.__ableSelectChipSuit = false
  self.__chipSuitPool = nil
  self.__chipSuitSelectMax = 0
  self.__chipSuitQuality = 0
  self.__chipSuitQualityDic = {}
  self.__limitUseSuitCount = false
  self.__chipSuitNum = nil
  self.__lastSelectSuit = {}
  self.__ableNextLevelBattle = false
  self.__nextStaminaCost = 0
  self.__staminaReplaceItemId = nil
  self.__ableReplaytLevelBattle = false
  self.__ableFailRestart = false
  self.__replayStaminaCost = 0
  self.__replayStaminaReplaceItemId = nil
  self.__notShowCouldUseTime = nil
  self.__enableDamageNum = false
  self.__enableRacingTime = false
  self.__lastRacingTime = -1
  self.__isHideRacingTimeCompare = false
  self.__hideRaceTimeShow = false
  self.__isNeedShowBuff = false
  self.__addedBuffDic = {}
  self.__deletedBuffDic = {}
  self.__restartBattleEvent = nil
  self.__nextBattleEvent = nil
  self.__dungeonStageData = nil
  self.__dungeonLevelData = nil
  self.__wait2UnlockChipPoolList = nil
  self.__wait4UnlockChipSuitUnlockInfoList = nil
  self._dungeonDyncData = nil
  self._fmtFromModule = nil
  self.__luckDropDic = nil
  self.__notShowExtrAward = false
  self.__defeatAdviseList = nil
  self.__isNeedRecordFormation = true
  self.__formationRuleCfg = ConfigData.formation_rule[0]
  self.__afterClickBattleFunc = nil
  self.__listen2OverKill = false
end

function DungeonInterfaceData.CreateDefaultBattleInterface()
  return DungeonInterfaceData.New()
end

function DungeonInterfaceData.CreateDailyDungeonInterface(dailyDgDyncData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.DailyDungeon
  interfaceData.__ableSelectChipSuit = true
  local stageId = dailyDgDyncData:GetDailyDgNextLvDungeonId()
  local dungeonCfg = ConfigData.battle_dungeon[stageId]
  local material_dungeonCfg = ConfigData.material_dungeon[dungeonCfg.module_id]
  interfaceData.__chipSuitSelectMax = material_dungeonCfg.chip_select_max
  interfaceData.__chipSuitQuality = material_dungeonCfg.chip_quality
  interfaceData.__chipSuitPool = material_dungeonCfg.chip_pool
  interfaceData.__limitUseSuitCount = true
  interfaceData.__chipSuitNum = material_dungeonCfg.chipSuitNumMaxDic
  interfaceData._fmtFromModule = FmtEnum.eFmtFromModule.DailyDungeon
  interfaceData._dungeonDyncData = dailyDgDyncData
  return interfaceData
end

function DungeonInterfaceData.CreateSctWinChallengeInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__ableSelectChipSuit = true
  interfaceData.__isNeedRecordFormation = false
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.WinterChallenge
  local selectMax = dungeonLevelData:GetSectorIIDun_ChipSuitLimitNum()
  local sectorIIData = dungeonLevelData:GetSectorIIActivityData()
  local chipPoolList, chipPoolQualityDic = sectorIIData:GetSectorII_ChipSuitPool()
  local wait2UnlockChipPoolList, wait4UnlockChipSuitUnlockInfoList = sectorIIData:GetSectorII_Wait4UnlockChipSuit()
  local chipSuitNumDic = dungeonLevelData:GetSctIIChallengeDgSuitNumDic()
  interfaceData.__chipSuitNum = chipSuitNumDic
  interfaceData.__limitUseSuitCount = true
  interfaceData.__chipSuitSelectMax = selectMax
  interfaceData.__chipSuitQuality = 1
  interfaceData.__chipSuitQualityDic = chipPoolQualityDic
  interfaceData.__chipSuitPool = chipPoolList
  interfaceData._fmtFromModule = FmtEnum.eFmtFromModule.SctIIDunChallenge
  interfaceData.__wait2UnlockChipPoolList = wait2UnlockChipPoolList
  interfaceData.__wait4UnlockChipSuitUnlockInfoList = wait4UnlockChipSuitUnlockInfoList
  interfaceData.__dungeonLevelData = dungeonLevelData
  return interfaceData
end

function DungeonInterfaceData.CreateHGV3Interface(HGV3NormalData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.HeroGrowV3Normal
  interfaceData.__ableSelectChipSuit = true
  interfaceData.__isNeedRecordFormation = false
  local selectMax = HGV3NormalData:GetHGV3ChipSuitLimitNum()
  local chipPoolList, chipPoolQuality = HGV3NormalData:GetHGV3ChipSuitPool()
  local chipPoolRecommendDic = HGV3NormalData:GetHGV3RecommendChipSuit()
  local chipSuitNumDic = HGV3NormalData:GetHGV3SuitNumDic()
  interfaceData.__chipSuitNum = chipSuitNumDic
  interfaceData.__limitUseSuitCount = true
  interfaceData.__chipSuitSelectMax = selectMax
  interfaceData.__chipSuitPool = chipPoolList
  interfaceData.__chipSuitQuality = chipPoolQuality
  interfaceData.__chipPoolRecommendDic = chipPoolRecommendDic
  interfaceData._fmtFromModule = HGV3NormalData:GetHGV3FmtFromType()
  interfaceData.__getDunDyncElemFunc = BindCallback(HGV3NormalData, HGV3NormalData.GetHGV3DyncDunData)
  interfaceData._dungeonDyncData = HGV3NormalData:GetHGV3DyncDunData()
  interfaceData.hgv3Type = HGV3NormalData:GetHGV3NormalDataType()
  return interfaceData
end

function DungeonInterfaceData.CreateDungeonTowerInterface(dungeonLevelData, fmtRuleCfg)
  local towerStageId = dungeonLevelData:GetDungeonLevelStageId()
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__isNeedRecordFormation = false
  local chipPool = dungeonLevelData:GetTowerChipSuitPool()
  if 0 < #chipPool then
    interfaceData.__ableSelectChipSuit = true
    interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.DungeonTower
    interfaceData.__chipSuitSelectMax = dungeonLevelData:GetTowerChipSelectMax()
    interfaceData.__chipSuitQuality = dungeonLevelData:GetTowerChipQuality()
    interfaceData.__chipSuitPool = chipPool
  end
  interfaceData.__ableFailRestart = true
  if fmtRuleCfg ~= nil then
    interfaceData.__formationRuleCfg = fmtRuleCfg
  end
  if dungeonLevelData:GetIsHaveRacing() then
    interfaceData.__enableRacingTime = true
    local time = PlayerDataCenter.dungeonTowerSData:GetTowerLevelRacingFrame(dungeonLevelData:GetDungeonTowerType(), dungeonLevelData:GetDunTowerLevelNum())
    interfaceData.__lastRacingTime = time
    interfaceData.__hideRaceTimeShow = dungeonLevelData:GetIsHideRacingTimeShow()
  end
  return interfaceData
end

function DungeonInterfaceData.CreateActSectorIIDungeonInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__dungeonLevelData = dungeonLevelData
  local selectMax = dungeonLevelData:GetSectorIIDun_ChipSuitLimitNum()
  if 0 < selectMax then
    interfaceData.__ableSelectChipSuit = true
    interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.SectorIIDungeon
    local sectorIIData = dungeonLevelData:GetSectorIIActivityData()
    local chipPoolList, chipPoolQualityDic = sectorIIData:GetSectorII_ChipSuitPool()
    local wait2UnlockChipPoolList, wait4UnlockChipSuitUnlockInfoList = sectorIIData:GetSectorII_Wait4UnlockChipSuit()
    interfaceData.__chipSuitSelectMax = selectMax
    interfaceData.__chipSuitQuality = 1
    interfaceData.__chipSuitQualityDic = chipPoolQualityDic
    interfaceData.__chipSuitPool = chipPoolList
    interfaceData.__wait2UnlockChipPoolList = wait2UnlockChipPoolList
    interfaceData.__wait4UnlockChipSuitUnlockInfoList = wait4UnlockChipSuitUnlockInfoList
    interfaceData.__isNeedShowBuff = true
    interfaceData.__addedBuffDic = sectorIIData:GetSectorII_UnlockedBuffList()
    interfaceData.__deletedBuffDic = sectorIIData:GetSectorII_DelectedBuffList()
    interfaceData.__notShowCouldUseTime = true
    interfaceData.__luckDropDic = {}
    local pointMultRateDic = sectorIIData:GetSectorII_PointMultRat()
    local rewardRate = dungeonLevelData:GetWADunRewardRate()
    for itemId, itemTable in pairs(dungeonLevelData:GetWADunGropShowDic()) do
      local itemNum
      itemNum = itemTable.minValue * 2
      local pointRate = pointMultRateDic[itemId]
      if pointRate ~= nil then
        pointRate = pointRate / 1000
        itemNum = math.floor(itemNum * (pointRate + 1))
      end
      interfaceData.__luckDropDic[itemId] = itemNum * rewardRate
    end
    interfaceData.__notShowExtrAward = true
    interfaceData.__defeatAdviseList = sectorIIData:GetBeDefeatJumpList()
  end
  return interfaceData
end

function DungeonInterfaceData.CreateARDDungeonInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.RefreshDun
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__listen2OverKill = true
  return interfaceData
end

function DungeonInterfaceData.CreateCarnivalDungeonInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.Carnival
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__listen2OverKill = true
  return interfaceData
end

function DungeonInterfaceData.CreateADCDungeonInterface(dungeonLevelData, scoreAddRate)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.ADC
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__listen2OverKill = true
  interfaceData.__enableRacingTime = dungeonLevelData:GetIsShowRacingTime()
  interfaceData.__enableDamageNum = dungeonLevelData:GetIsShowDamageNum()
  interfaceData.__isHideRacingTimeCompare = true
  interfaceData.__enableScoreAddRate = true
  interfaceData.__scoreAdd = scoreAddRate
  return interfaceData
end

function DungeonInterfaceData.CreateActIIIDunInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.SectorIIIDungeon
  return interfaceData
end

function DungeonInterfaceData.CreateHeroGrowInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.HeroGrow
  return interfaceData
end

function DungeonInterfaceData.CreateActSeasonDunInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.Season
  return interfaceData
end

function DungeonInterfaceData.CreateSpringDungeonInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.Spring
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__listen2OverKill = true
  return interfaceData
end

function DungeonInterfaceData.CreateCommonRepeatDungeonInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.Repeat
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__listen2OverKill = true
  return interfaceData
end

function DungeonInterfaceData.CreateBlackHoleDungeonInterface(blackHoleData, peridicSelect)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.ActBlackHole
  interfaceData.__dungeonLevelData = blackHoleData
  if peridicSelect then
    interfaceData.__enableScoreAddRate = true
    interfaceData.__scoreAdd = peridicSelect:GetFmtBuffCurAddScoreRate()
  end
  return interfaceData
end

function DungeonInterfaceData.CreateHGV3RepeatDungeonInterface(dungeonLevelData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.HeroGrowV3Repeat
  interfaceData.__dungeonLevelData = dungeonLevelData
  interfaceData.__listen2OverKill = true
  return interfaceData
end

function DungeonInterfaceData.CreateCommonHardLevelDungeonInterface(dunLevelData, peridicSelect)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.CommonHard
  interfaceData.__dungeonLevelData = dunLevelData
  interfaceData.__enableDamageNum = dunLevelData:GetIsShowDamageNum()
  if peridicSelect then
    interfaceData.__enableScoreAddRate = true
    interfaceData.__scoreAdd = peridicSelect:GetFmtBuffCurAddScoreRate()
  end
  return interfaceData
end

function DungeonInterfaceData.CreateCardSetDungeonInterface(cardSetData)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.CardSet
  interfaceData.__cardSetData = cardSetData
  return interfaceData
end

function DungeonInterfaceData:GetInterfaceType()
  return self.__interfaceType
end

function DungeonInterfaceData:BindDungeonStageData(dungeonStageData, restartBattleEvent)
  self.__dungeonStageData = dungeonStageData
  self.__restartBattleEvent = restartBattleEvent
  self.__replayStaminaReplaceItemId = ConstGlobalItem.SKey
  if dungeonStageData ~= nil then
    self:SaveBattleWinRewardInfo(dungeonStageData.dungeonData)
  end
end

function DungeonInterfaceData.CreateHeroGrowChallengeInterface(dungeonLevelData)
  local challengeCfg = dungeonLevelData.levelCfg
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.HeroGrowChallenge
  interfaceData.__ableSelectChipSuit = true
  interfaceData.__dungeonLevelData = dungeonLevelData
  local stageId = challengeCfg.dungeon_id
  interfaceData.__chipSuitSelectMax = challengeCfg.chip_select_max
  interfaceData.__chipSuitQuality = challengeCfg.chip_quality
  interfaceData.__chipSuitPool = challengeCfg.chip_pool
  interfaceData.__limitUseSuitCount = true
  interfaceData.__chipSuitNum = challengeCfg.chipSuitNumMaxDic
  interfaceData._fmtFromModule = FmtEnum.eFmtFromModule.CommonHard
  interfaceData.__enableDamageNum = dungeonLevelData:GetIsShowDamageNum()
  return interfaceData
end

function DungeonInterfaceData.CreateBondDungeonInterface(bondDunData, fmtRuleCfg)
  local interfaceData = DungeonInterfaceData.New()
  interfaceData.__interfaceType = DungeonLevelEnum.InterfaceType.Bond
  interfaceData.__bondBuff = bondDunData:GetBondBuff()
  interfaceData.__dungeonLevelData = bondDunData
  if fmtRuleCfg ~= nil then
    interfaceData.__formationRuleCfg = fmtRuleCfg
  end
  return interfaceData
end

function DungeonInterfaceData:GetIDungeonStageData()
  return self.__dungeonStageData
end

function DungeonInterfaceData:GetIDungeonLevelData()
  return self.__dungeonLevelData
end

function DungeonInterfaceData:GetIDungeonRestartEvent()
  return self.__restartBattleEvent
end

function DungeonInterfaceData:GetIDungeonNextLevelEvent()
  return self.__nextBattleEvent
end

function DungeonInterfaceData:SetDungeonNextInfo(nextBattleEvent, nextStaminaCost, keyItemId)
  self.__ableNextLevelBattle = true
  self.__nextBattleEvent = nextBattleEvent
  self.__nextStaminaCost = nextStaminaCost
  self.__staminaReplaceItemId = keyItemId
end

function DungeonInterfaceData:SetDungeonReplayInfo(restartBattleEvent, replayStaminaCost, keyItemId)
  self.__ableReplaytLevelBattle = true
  self.__restartBattleEvent = restartBattleEvent
  self.__replayStaminaCost = replayStaminaCost
  self.__replayStaminaReplaceItemId = keyItemId
end

function DungeonInterfaceData:SaveBattleWinRewardInfo(dungeonData)
  self.__multRewardInfo = {}
  self.__multRewardInfo.isMultReward = dungeonData:GetIsHaveMultReward()
  if self.__multRewardInfo.isMultReward then
    self.__multRewardInfo.multRewardRate = dungeonData:GetActivityMultRewardRate()
    local leftTime, totalTime = dungeonData:GetLeftActivityMultRewardNum()
    self.__multRewardInfo.multRewardTotalNum = totalTime
    self.__multRewardInfo.multRewardLeftNum = leftTime - 1
  end
end

function DungeonInterfaceData:GetBattleWinRewardInfo()
  return self.__multRewardInfo
end

function DungeonInterfaceData:RestartAthMaybeFull()
  if self.__dungeonStageData == nil then
    return false
  end
  local maybeFull = self.__dungeonStageData:IsHaveATHReward() and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum - ConfigData.game_config.athSpaceNotEnoughNum
  return maybeFull
end

function DungeonInterfaceData:RestartAthAlreadyFull()
  if self.__dungeonStageData == nil then
    return false
  end
  local alreadyFull = self.__dungeonStageData:IsHaveATHReward() and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum
  return alreadyFull
end

function DungeonInterfaceData:GetIStaminaCost()
  if self.__dungeonStageData == nil then
    return 0
  end
  return self.__dungeonStageData:GetStaminaCost()
end

function DungeonInterfaceData:GetINextStaminaCost()
  return self.__nextStaminaCost
end

function DungeonInterfaceData:GetINextStaminaReplaceItemId()
  return self.__staminaReplaceItemId
end

function DungeonInterfaceData:AbleContinueNextLevel()
  return self.__ableNextLevelBattle
end

function DungeonInterfaceData:GetReplayStaminaCost()
  return self.__replayStaminaCost
end

function DungeonInterfaceData:GetReplayStaminaReplaceItemId()
  return self.__replayStaminaReplaceItemId
end

function DungeonInterfaceData:AbleContinueReplayLevel()
  return self.__ableReplaytLevelBattle
end

function DungeonInterfaceData:SetDgIAbleFailRestart()
  self.__ableFailRestart = true
end

function DungeonInterfaceData:AbleFailRestart()
  return self.__ableFailRestart
end

function DungeonInterfaceData:SetDIDExtraDrop(active)
  self._extraDropActive = active
end

function DungeonInterfaceData:GetDIDExtraDrop()
  return self._extraDropActive
end

function DungeonInterfaceData:GetDunFormationRuleCfg()
  return self.__formationRuleCfg
end

function DungeonInterfaceData:SetAutoDecompose(active)
  self._autoDecomposeActive = active
end

function DungeonInterfaceData:GetAutoDecompose()
  return self._autoDecomposeActive
end

function DungeonInterfaceData:GetAbleSelectChipSuit()
  return self.__ableSelectChipSuit
end

function DungeonInterfaceData:GetChipSuitSelectMax()
  return self.__chipSuitSelectMax
end

function DungeonInterfaceData:GetChipSuitSelectQuality(chipTagId)
  if self.__chipSuitQualityDic ~= nil and self.__chipSuitQualityDic[chipTagId] ~= nil then
    return self.__chipSuitQualityDic[chipTagId]
  end
  return self.__chipSuitQuality
end

function DungeonInterfaceData:GetChipSuitIsRecommend(chipTagId)
  if self.__chipPoolRecommendDic ~= nil then
    return self.__chipPoolRecommendDic[chipTagId]
  end
  return false
end

function DungeonInterfaceData:GetChipSuitPool()
  return self.__chipSuitPool
end

function DungeonInterfaceData:GetLockedChipSuitPool()
  return self.__wait2UnlockChipPoolList
end

function DungeonInterfaceData:GetLockedChipSuitPoolUnlockInfoList()
  return self.__wait4UnlockChipSuitUnlockInfoList
end

function DungeonInterfaceData:LimitUseSuitCount()
  return self.__limitUseSuitCount
end

function DungeonInterfaceData:GetIsNotShowCouldUseTime()
  return self.__notShowCouldUseTime
end

function DungeonInterfaceData:GetChipSuitNum()
  return self.__chipSuitNum
end

function DungeonInterfaceData:GetAfterBattleLuckDropDic()
  return self.__luckDropDic
end

function DungeonInterfaceData:IsNotShowExtrAward()
  return self.__notShowExtrAward
end

function DungeonInterfaceData:IsNeedRecordFormation()
  return self.__isNeedRecordFormation
end

function DungeonInterfaceData:GetLastSelectSuit(lastChipGroup)
  if self.__interfaceType == DungeonLevelEnum.InterfaceType.DailyDungeon then
    local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
    return dungeonDyncElem.lastChipGroup
  elseif self.__interfaceType == DungeonLevelEnum.InterfaceType.WinterChallenge then
    local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetWinterChallengeDgDyncData()
    return dungeonDyncElem.lastChipGroup
  elseif self.__interfaceType == DungeonLevelEnum.InterfaceType.HeroGrowV3Normal then
    local dungeonDyncElem = self.__getDunDyncElemFunc()
    return dungeonDyncElem.lastChipGroup
  else
    return self.__lastSelectSuit
  end
end

function DungeonInterfaceData:SaveLastSelectSuit(lastChipGroup)
  if self.__interfaceType == DungeonLevelEnum.InterfaceType.DailyDungeon then
    local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
    dungeonDyncElem:SetDgDyncElemLastChipGroup(lastChipGroup)
  elseif self.__interfaceType == DungeonLevelEnum.InterfaceType.WinterChallenge then
    local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetWinterChallengeDgDyncData()
    dungeonDyncElem:SetDgDyncElemLastChipGroup(lastChipGroup)
  elseif self.__interfaceType == DungeonLevelEnum.InterfaceType.HeroGrowV3Normal then
    local dungeonDyncElem = self.__getDunDyncElemFunc()
    dungeonDyncElem:SetDgDyncElemLastChipGroup(lastChipGroup)
  else
    self.__lastSelectSuit = lastChipGroup
  end
end

function DungeonInterfaceData:GetChipSuitNumById(chipSuitId)
  if self.__limitUseSuitCount then
    return self.__chipSuitNum[chipSuitId]
  else
    return 1
  end
end

function DungeonInterfaceData:GetChipSuitSelectedCount(chipTagId)
  if self.__interfaceType == DungeonLevelEnum.InterfaceType.DailyDungeon then
    local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
    return dungeonDyncElem.selectedChipGroup[chipTagId] or 0
  elseif self.__interfaceType == DungeonLevelEnum.InterfaceType.WinterChallenge then
    local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetWinterChallengeDgDyncData()
    return dungeonDyncElem.selectedChipGroup[chipTagId] or 0
  elseif self.__interfaceType == DungeonLevelEnum.InterfaceType.HeroGrowV3Normal then
    local dungeonDyncElem = self.__getDunDyncElemFunc()
    return dungeonDyncElem.selectedChipGroup[chipTagId] or 0
  else
    return 0
  end
end

function DungeonInterfaceData:GetIsHaveBuff()
  return self.__isNeedShowBuff
end

function DungeonInterfaceData:GetAddBuffList()
  local addedBuffList = {}
  for buffId, _ in pairs(self.__addedBuffDic) do
    table.insert(addedBuffList, buffId)
  end
  return addedBuffList
end

function DungeonInterfaceData:GetRemoveBuffList()
  local deletedBuffList = {}
  for buffId, _ in pairs(self.__deletedBuffDic) do
    table.insert(deletedBuffList, buffId)
  end
  return deletedBuffList
end

function DungeonInterfaceData:GetDgItfFmtFromModule()
  return self._fmtFromModule
end

function DungeonInterfaceData:GetDgWinChallengeCurScore()
  if self.__dungeonLevelData == nil or self.__dungeonLevelData:GetDungeonLevelType() ~= DungeonLevelEnum.DunLevelType.SectorIIChallenge then
    return 0
  end
  return self.__dungeonLevelData:GetSctIIChallengeDgScore()
end

function DungeonInterfaceData:GetDgWinChallengeMaxScore()
  if self.__dungeonLevelData == nil or self.__dungeonLevelData:GetDungeonLevelType() ~= DungeonLevelEnum.DunLevelType.SectorIIChallenge then
    return 0
  end
  return self.__dungeonLevelData:GetSctIIChallengeDgMaxScore()
end

function DungeonInterfaceData:GetDefeatJumpList()
  return self.__defeatAdviseList or table.emptytable
end

function DungeonInterfaceData:TryGetDungeonTowerLvInfo()
  if self.__dungeonLevelData == nil or self.__dungeonLevelData:GetDungeonLevelType() ~= DungeonLevelEnum.DunLevelType.Tower then
    return nil, 0
  end
  return self.__dungeonLevelData:GetTowerLvName(), self.__dungeonLevelData:GetDunTowerLevelNum()
end

function DungeonInterfaceData:GetDgInterfaceDungeonDyncData()
  return self._dungeonDyncData
end

function DungeonInterfaceData:SetDgInterfaceStgChallengeData(stgChallengeData)
  self._stgChallengeData = stgChallengeData
end

function DungeonInterfaceData:GetDgInterfaceStgChallengeData()
  return self._stgChallengeData
end

function DungeonInterfaceData:SetAfterClickBattleFunc(func)
  self.__afterClickBattleFunc = func
end

function DungeonInterfaceData:GetAfterClickBattleFunc()
  return self.__afterClickBattleFunc
end

function DungeonInterfaceData:GetIsListen2OverKill()
  return self.__listen2OverKill
end

function DungeonInterfaceData:GetDunRacingData()
  return self.__enableRacingTime, self.__lastRacingTime, self.__isHideRacingTimeCompare, self.__hideRaceTimeShow
end

function DungeonInterfaceData:GetIsDunDamageNum()
  return self.__enableDamageNum
end

function DungeonInterfaceData:GetDunScoreAddRate()
  return self.__enableScoreAddRate or false, self.__scoreAdd or 0
end

function DungeonInterfaceData:DealDungeonResult(resultInfo)
  if resultInfo ~= nil and self.__dungeonLevelData ~= nil then
    self.__dungeonLevelData:DealDungeonResult(resultInfo)
  end
end

function DungeonInterfaceData:GetDunRacingServerTime()
  if self.__dungeonLevelData == nil then
    return -1
  end
  return self.__dungeonLevelData:GetDunServerRacingFrame()
end

function DungeonInterfaceData:GetCardSetData()
  return self.__cardSetData
end

return DungeonInterfaceData
