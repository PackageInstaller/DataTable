local EnterFmtData = class("EnterFmtData")
local FmtEnum = require("Game.Formation.FmtEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local FormationUtil = require("Game.Formation.FormationUtil")
local VirtualFormationData = require("Game.Formation.Data.VirtualFormationData")
local SpecialRuleGenerator = require("Game.PlayerData.SpecialRuleGenerator")
local StageChallengeData = require("Game.StageChallenge.Data.StageChallengeData")
local DungeonTowerUtil = require("Game.DungeonCenter.Util.DungeonTowerUtil")
local WCEnum = require("Game.WeeklyChallenge.WCEnum")
local OfficialSupportHeroData = require("Game.Formation.Data.OfficialSupportHeroData")
local FormationData = require("Game.PlayerData.FormationData")

function EnterFmtData:ctor()
  self.fromModule = nil
  self.gameType = nil
  self.stageId = nil
  self.defaultFmtId = nil
  self.isFmtCtrlFixed = nil
  self.__assistTeamCfg = nil
  self.__isFixedCouldChangeTeam = nil
  self.specificHeroDataRuler = nil
  self.__specialRuleGenerator = nil
  self.__virtualFmtData = nil
  self._fmtBuffSelectData = nil
  self.enterFunc = nil
  self.exitFunc = nil
  self.startBattleFunc = nil
  self.isFriendSupport = false
  self.isFriendSupportTimeLimitted = false
  self.isFriendSupportHaveTimeLimit = false
  self.forbidSupport = false
  self.__forceShowSupportNotAvaliable = nil
  self.isHaveChallengeMode = false
  self.stgChallengeData = nil
  self.setChallengeModeFunc = false
  self.isInBattleFmt = false
  self.fmtDungeonDyncData = nil
  self.__couldShowRecommendBtn = false
  self.isOpenedCampInfluence = false
  self.isOpenBuffSelect = false
  self.isOpenEnvBuffSelect = false
  self.isShowNotEditNormalObj = true
  self.isOpenBuffWhenEnter = false
  self.isOpenTotalPower = true
  self.isOpenChangeFmt = true
  self.couldShowQuickLevelUp = true
  self.isExpShow = true
  self.isStaminaShow = true
  self.staminaCost = 0
  self.__notStaminaTicketItemId = nil
  self.isAutoBattleState = false
  self.autoCount = 0
  self.isCloseCommandSkill = false
  self.__isHaveMult = nil
  self.isOpenFmtEvaluation = true
  self.__fmtchipDataList = nil
  self.__isEditShowPow = true
  self.__isEditShowEvaluate = true
  self.__formationRuleCfg = ConfigData.formation_rule[0]
  self.__heroPassStats = nil
  self.__heroRecommendDic = nil
  self.__startBattleCustomCheckFuncDic = nil
  self.__fixedChangeTeamFmtIdDic = nil
  self.__fixedTeamNameDic = nil
  self.__isWarChessDeploy = nil
  self.__deployOverCallback = nil
  self.__wcLevelCfg = nil
  self.__wcCurTeamIndex = nil
  self.__wcDTeamDataDic = nil
  self.__isHaveOfficialSupport = nil
  self.__officialSupportCfgId = nil
  self.__allOfficialSupportHeroDataDic = nil
  self.__isShowScoreRate = nil
  self.__scoreRateReduce = nil
  self.__isBrotatoDeploy = nil
  self.__isHaveCardSetBannedHeroDic = nil
  self.__isHaveCardSetBannedFairyDic = nil
  self.__CardSetRecBattlePow = nil
  self.__ContinueRecBattlePow = nil
  self.__brotatoNeedBanNotSelf = false
  self.__isNeedCheckFormation = false
  self.__brotatoCanUseOfficialData = false
  self.__isShowFairy = true
  self.__isHideRecommandPow = nil
  self.__epInifinityData = nil
  self.__isEpInifinity = nil
  self.__infinityFmtData = nil
  self.__isShowBtnLineupCmd = true
  self.__bondBuffId = 0
  self.__bondActId = 0
end

function EnterFmtData:SetFmtCtrlBaseInfo(fromModule, stageId, lastFmtId)
  self.fromModule = fromModule
  self.gameType = FmtEnum.GetFmtGameTypeByModuleId(fromModule)
  self.stageId = stageId
  self.defaultFmtId = lastFmtId
  return self
end

function EnterFmtData:SetFmtId(fmtId)
  self.defaultFmtId = fmtId
  return self
end

function EnterFmtData:SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc)
  self.enterFunc = enterFunc
  self.exitFunc = exitFunc
  self.startBattleFunc = startBattleFunc
  return self
end

function EnterFmtData:SetEnterBattleCostTicketNum(costNum)
  self.staminaCost = costNum
  return self
end

function EnterFmtData:SetEnterBattleTicketItemId(itemId)
  self.__notStaminaTicketItemId = itemId
  return self
end

function EnterFmtData:SetSpecificHeroDataRuler(specificHeroDataRuler)
  self.specificHeroDataRuler = specificHeroDataRuler
  if self.specificHeroDataRuler ~= nil then
    self.couldShowQuickLevelUp = false
    self.__specialRuleGenerator = SpecialRuleGenerator.New()
    self.__specialRuleGenerator:SetSpeicalRuler(self.specificHeroDataRuler)
  end
  return self
end

function EnterFmtData:SetPeridicFmtBuffSelect(peridicFmtBuffSelectData)
  self._fmtBuffSelectData = peridicFmtBuffSelectData
  return self
end

function EnterFmtData:TryGenFmtCtrlDungeonDyncData()
  self.fmtDungeonDyncData = FormationUtil.GetDyncDgDataByFmtFromModule(self.fromModule)
  return self
end

function EnterFmtData:SetIsOpenBuffSelect(bool)
  self.isOpenBuffSelect = bool
  return self
end

function EnterFmtData:SetIsOpenEnvBuffSelect(bool)
  self.isOpenEnvBuffSelect = bool
  return self
end

function EnterFmtData:SetIsShowNotEditNormalObj(bool)
  self.isShowNotEditNormalObj = bool
  return self
end

function EnterFmtData:SetIsOpenBuffWhenEnter(bool)
  self.isOpenBuffWhenEnter = bool
  return self
end

function EnterFmtData:SetFmtCtrlIsHaveMultEffi(bool)
  self.__isHaveMult = bool
  return self
end

function EnterFmtData:SetFmtCtrlChipDataList(fmtchipDataList)
  self.__fmtchipDataList = fmtchipDataList
  return self
end

function EnterFmtData:SetFmtCtrlChallengeData(isHaveChallengeMode, setChallengeModeFunc, stgChallengeData)
  if self.stageId == nil then
    error("pls check EnterFmtData data set order,can't get stageId for stgChallengeData")
    return
  end
  self.isHaveChallengeMode = isHaveChallengeMode
  self._SetChallengeModeFunc = setChallengeModeFunc
  if stgChallengeData == nil then
    self.stgChallengeData = StageChallengeData.Create(self.stageId)
  else
    self.stgChallengeData = stgChallengeData
  end
  if isHaveChallengeMode then
    self.__isEditShowPow = false
    self.__isEditShowEvaluate = false
  end
  return self
end

function EnterFmtData:SetFmtCtrlIsInBattleFmt(isInBattleFmt)
  self.isInBattleFmt = isInBattleFmt
  if isInBattleFmt then
    self.isOpenTotalPower = false
    self.__isEditShowPow = false
  end
  return self
end

function EnterFmtData:SetIsEditShowPow(bool)
  self.__isEditShowPow = bool
  return self
end

function EnterFmtData:SetFmtForbidSupport(bool)
  self.forbidSupport = bool
  return self
end

function EnterFmtData:SetIsShowSupportHolder(bool)
  self.__forceShowSupportNotAvaliable = bool
  return self
end

function EnterFmtData:SetIsOpenChangeFmt(bool)
  self.isOpenChangeFmt = bool
  return self
end

function EnterFmtData:SetFormationRuleCfg(formationRuleCfg)
  if formationRuleCfg ~= nil then
    self.__formationRuleCfg = formationRuleCfg
  end
  return self
end

function EnterFmtData:SetIsShowTotalPow(bool)
  self.isOpenTotalPower = bool
  return self
end

function EnterFmtData:SetFmtHeroPassInfo(heroPassStats)
  if heroPassStats == nil or #heroPassStats <= 0 then
    return self
  end
  self.__heroPassStats = heroPassStats
  self.__heroRecommendDic = {}
  local showRecommendNum = ConfigData.game_config.towerRecommendNum
  for i = 1, math.min(showRecommendNum, #heroPassStats) do
    local passStat = heroPassStats[i]
    self.__heroRecommendDic[passStat.heroId] = true
  end
  return self
end

function EnterFmtData:SetFmtIsWarChessDeploy(bool, deployOverCallback, wcLevelCfg, index)
  self.__isWarChessDeploy = bool
  self.__deployOverCallback = deployOverCallback
  self.__wcLevelCfg = wcLevelCfg
  self.__wcCurTeamIndex = index
  return self
end

function EnterFmtData:SetFmtIsBrotatoDeploy(bool)
  self.__isBrotatoDeploy = bool
  return self
end

function EnterFmtData:SetFmtBrotatoNeedBanNotSelf(bValue)
  self.__brotatoNeedBanNotSelf = bValue
  return self
end

function EnterFmtData:SetFmtBrotatoCanUseOfficialData(bValue)
  self.__brotatoCanUseOfficialData = bValue
  return self
end

function EnterFmtData:SetFmtRecommendCfg(recommendHeroDic, recommendTeamList, recommendSkillDataList)
  self.__heroRecommendDic = recommendHeroDic
  self.__recommendTeamList = recommendTeamList
  self.__recommendSkillDataList = recommendSkillDataList
  return self
end

function EnterFmtData:SetFmtWarChessDTeamDataDic(dTeamDataDic)
  self.__wcDTeamDataDic = dTeamDataDic
  return self
end

function EnterFmtData:SetScoreRateReduce(num)
  self.__scoreRateReduce = num
  return self
end

function EnterFmtData:SetOfficialSupportCfgId(officialSupportCfgId)
  self.__officialSupportCfgId = officialSupportCfgId
  return self
end

function EnterFmtData:SetNeedCheckFormationData(bValue)
  self.__isNeedCheckFormation = bValue
  return self
end

function EnterFmtData:SetCardSetTempBannedHeroDic(dic)
  self.__isHaveCardSetBannedHeroDic = dic
  return self
end

function EnterFmtData:SetCardSetTempBannedFairyDic(dic)
  self.__isHaveCardSetBannedFairyDic = dic
  return self
end

function EnterFmtData:SetCardSetRecBattlePow(recBattlePow)
  self.__CardSetRecBattlePow = recBattlePow
  return self
end

function EnterFmtData:SetContinueRecBattlePow(recBattlePow)
  self.__ContinueRecBattlePow = recBattlePow
  return self
end

function EnterFmtData:SetCardSetFriendSupportOpen(isOpen)
  self.__CardSetFriendSupportOpen = isOpen
  return self
end

function EnterFmtData:AddStartBattleCustomCheckFunc(nameStr, func)
  if self.__startBattleCustomCheckFuncDic == nil then
    self.__startBattleCustomCheckFuncDic = {}
  end
  self.__startBattleCustomCheckFuncDic[nameStr] = func
  return self
end

function EnterFmtData:SetIsHideRecommandPow(bool)
  self.__isHideRecommandPow = bool
  return self
end

function EnterFmtData:SetEpInifinityData(epInifinityData)
  if epInifinityData == nil then
    return self
  end
  self.__epInifinityData = epInifinityData:GetEpFormationSaveData()
  self.__isEpInifinity = epInifinityData ~= nil
  return self
end

function EnterFmtData:SetEpInifinity424ActData(factCardData)
  self.__factCardData = factCardData
  self.__isEpInifinity424Act = true
  return self
end

function EnterFmtData:SetIsShowBtnLineupCmd(bool)
  self.__isShowBtnLineupCmd = bool
  return self
end

function EnterFmtData:SetBondBuffId(buffId)
  self.__bondBuffId = buffId
  return self
end

function EnterFmtData:SetBondActId(bondActId)
  self.__bondActId = bondActId
  return self
end

function EnterFmtData:GetFmtCtrlFromModule()
  return self.fromModule
end

function EnterFmtData:GetFmtCtrlGameType()
  return self.gameType
end

function EnterFmtData:GetFmtCtrlEnterFunc()
  return self.enterFunc
end

function EnterFmtData:GetFmtCtrlExitFunc()
  return self.exitFunc
end

function EnterFmtData:GetFmtCtrlStartBattleFunc()
  return self.startBattleFunc
end

function EnterFmtData:GetFmtCtrlFmtId()
  return self.defaultFmtId
end

function EnterFmtData:GetFmtCtrlFmtIdStageId()
  return self.stageId
end

function EnterFmtData:GetFormationRuleCfg()
  return self.__formationRuleCfg
end

function EnterFmtData:GetFormationMaxStageNum()
  return self.__formationRuleCfg.stage_num
end

function EnterFmtData:GetFormationMaxBenchNum()
  return self.__formationRuleCfg.bench_num
end

function EnterFmtData:GetFormationRoleMax()
  return self.__formationRuleCfg.stage_num + self.__formationRuleCfg.bench_num
end

function EnterFmtData:IsFormationIndexEnable(fmtIndex)
  return fmtIndex <= self.__formationRuleCfg.stage_num or fmtIndex >= self.__formationRuleCfg.bench_start_idx
end

function EnterFmtData:GetFmtHeroPassInfo()
  return self.__heroPassStats
end

function EnterFmtData:IsFmtHeroRecommend(heroId)
  if self.__heroRecommendDic == nil then
    return false
  end
  return self.__heroRecommendDic[heroId]
end

function EnterFmtData:GetRecommendTeam()
  return self.__recommendTeamList
end

function EnterFmtData:GetRecommendSkillData()
  return self.__recommendSkillDataList
end

function EnterFmtData:GetPeridicFmtBuffSelect()
  return self._fmtBuffSelectData
end

function EnterFmtData:GetIsShowBtnLineupCmd()
  return self.__isShowBtnLineupCmd
end

function EnterFmtData:GetBondBuffId()
  return self.__bondBuffId
end

function EnterFmtData:GetBondActId()
  return self.__bondActId
end

function EnterFmtData:IsFmtCtrlVirtualFmtData()
  return self.specificHeroDataRuler ~= nil
end

function EnterFmtData:GetFmtCtrlSpecificHeroDataRuler()
  return self.specificHeroDataRuler
end

function EnterFmtData:GetFmtCtrlSpecialRuleGenerator()
  return self.__specialRuleGenerator
end

function EnterFmtData:GetFmtCtrlVirtualFmtData()
  return self.__virtualFmtData
end

function EnterFmtData:IsFmtCtrlFiexd()
  return self.isFmtCtrlFixed
end

function EnterFmtData:HasFmtFixedHeroIndex(fmtIndex)
  if not self:IsFmtCtrlFiexd() then
    return false
  end
  local openNum = #self.__assistTeamCfg.param1 + self.__assistTeamCfg.extra_add
  return fmtIndex <= openNum
end

function EnterFmtData:HasFmtFixedExtra()
  if self.__assistTeamCfg == nil then
    return false
  end
  return self.__assistTeamCfg.extra_add > 0
end

function EnterFmtData:HasFmtFixedShowPow()
  return self.__assistTeamCfg and self.__assistTeamCfg.show_battlepow
end

function EnterFmtData:IsFmtFixedHeroId(heroId)
  if self.__assistTeamCfg == nil then
    return false
  end
  for k, fixedHeroId in ipairs(self.__assistTeamCfg.param1) do
    if fixedHeroId == heroId then
      return true
    end
  end
  return false
end

function EnterFmtData:GetFmtFixedHeroNum()
  if not self:IsFmtCtrlFiexd() then
    return 0
  end
  local openNum = #self.__assistTeamCfg.param1 + self.__assistTeamCfg.extra_add
  return openNum
end

function EnterFmtData:IsFmtFixedHeroFull(fmtData)
  if not self:IsFmtCtrlFiexd() then
    return
  end
  local allNum = self:GetFmtFixedHeroNum()
  local curNum = table.count(fmtData:GetFormationHeroDic())
  return allNum <= curNum
end

function EnterFmtData:IsFmtFixedCouldChangeTeam()
  return self.__isFixedCouldChangeTeam
end

function EnterFmtData:GetFmtFixedChangeTeamFmtId(fmtIndex)
  return self.__fixedChangeTeamFmtIdDic[fmtIndex]
end

function EnterFmtData:GetIsEpInifinity()
  return self.__isEpInifinity
end

function EnterFmtData:GetIsEpInifinity424Act()
  return self.__isEpInifinity424Act
end

function EnterFmtData:GetEpInifinityFmtData()
  return self.__infinityFmtData
end

function EnterFmtData:GetEpInifinityHeroData(heroId)
  return self.__epInifinityData:GetFmtSvHeroDataById(heroId)
end

function EnterFmtData:GetEpInifinitySavingData()
  return self.__epInifinityData
end

function EnterFmtData:GetFactCardData424Act()
  return self.__factCardData
end

function EnterFmtData:GetIsFmtExpShow()
  return self.isExpShow
end

function EnterFmtData:GetIsFmtStaminaShow()
  return self.isStaminaShow
end

function EnterFmtData:GetIsFmtTicketId()
  return self.__notStaminaTicketItemId or ConstGlobalItem.SKey
end

function EnterFmtData:IsInTdFormation()
  return self.__mapLogic == ExplorationEnum.eMapLogic.TowerDefence
end

function EnterFmtData:IsWCFormation()
  local isWc = self.fromModule == FmtEnum.eFmtFromModule.WeeklyChallenge
  if isWc then
    local wcCfg = ConfigData.weekly_challenge[self.stageId]
    local wcType = WCEnum.eWeeklyChallengeId.normal
    if wcCfg ~= nil then
      wcType = wcCfg.weekly_challenge_type
    end
    return isWc, wcType
  end
  return false
end

function EnterFmtData:IsFmtTdSpecHero(heroId)
  if not self:IsInTdFormation() then
    return false
  end
  return ConfigData.skill_adapter.td_adapter[heroId] ~= nil
end

function EnterFmtData:GetFmtChipDataList()
  return self.__fmtchipDataList
end

function EnterFmtData:GetIsAutoBattleState()
  return self.isAutoBattleState
end

function EnterFmtData:IsFmtActivityForbidSupport()
  local stageCfg = ConfigData.sector_stage[self.stageId]
  if not stageCfg then
    return false
  end
  local sectorId = stageCfg.sector
  local supportId = ConfigData.sector[sectorId] and ConfigData.sector[sectorId].sector_support_id
  if supportId == nil or supportId == 0 then
    return false
  end
  local supportLimitCfg = ConfigData.support_limit[supportId]
  if supportLimitCfg then
    return not supportLimitCfg.is_open
  end
  return false
end

function EnterFmtData:IsFmtActivityDailyChallengeSupport()
  local adcCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDailyChallenge)
  if adcCtrl == nil then
    return false
  end
  local curAdcData = adcCtrl:GetADCOnce()
  if curAdcData == nil then
    return false
  end
  local curDungeonCfg = curAdcData:GetADCDungeonCfg()[self.stageId]
  if curDungeonCfg == nil or curDungeonCfg.is_infinite then
    return false
  end
  local supportId = curAdcData:GetADCMainCfg().support_id
  if supportId == nil or supportId == 0 then
    return false
  end
  local supportLimitCfg = ConfigData.support_limit[supportId]
  if supportLimitCfg then
    return true, supportId
  end
  return false
end

function EnterFmtData:IsFmtHaveChallengeMode()
  return self.isHaveChallengeMode
end

function EnterFmtData:IsFmtChallengeMode()
  return self.stgChallengeData and self.stgChallengeData:IsStageChallengeOpen()
end

function EnterFmtData:GetFmtChallengeModeData()
  return self.stgChallengeData
end

function EnterFmtData:GetFmtChallengeModeChangeFunc()
  return self._SetChallengeModeFunc
end

function EnterFmtData:GetFmtDungeonDyncData()
  return self.fmtDungeonDyncData
end

function EnterFmtData:IsFmtInWarChessDeploy()
  return self.__isWarChessDeploy
end

function EnterFmtData:IsFmtInBrotatoDeploy()
  return self.__isBrotatoDeploy
end

function EnterFmtData:GetFmtBrotatoNeedBanNotSelf()
  return self.__brotatoNeedBanNotSelf
end

function EnterFmtData:GetFmtBrotatoCanUseOfficialData()
  return self.__brotatoCanUseOfficialData
end

function EnterFmtData:GetFmtTeamSize()
  if self:IsFmtInWarChessDeploy() then
    return WarChessManager:GetWarChessCtrl().teamCtrl:GetWCFmtShowNum()
  end
  return ConfigData.game_config.formationCount
end

function EnterFmtData:GetDeployOverCallback()
  return self.__deployOverCallback
end

function EnterFmtData:IsFmtInBattleDeploy(mustInBattle)
  if self.fmtDungeonDyncData == nil then
    return false
  end
  if mustInBattle then
    if self.fromModule == FmtEnum.eFmtFromModule.DailyDungeonLevel then
      return false
    elseif self.fromModule == FmtEnum.eFmtFromModule.HGV3NormalFree then
      return BattleDungeonManager:InBattleDungeon()
    else
      return true
    end
  else
    return true
  end
end

function EnterFmtData:GetStaminaCost()
  if self:GetIsAutoBattleState() then
    return self.staminaCost * self.autoCount
  end
  return self.staminaCost
end

function EnterFmtData:GetIsShowTotalPow()
  return self.isOpenTotalPower
end

function EnterFmtData:GetFmtCtrlRecommendPower()
  local stageCfg
  if self.fromModule == FmtEnum.eFmtFromModule.PeriodicChallenge or self.fromModule == FmtEnum.eFmtFromModule.WeeklyChallenge then
  elseif self.fromModule == FmtEnum.eFmtFromModule.Infinity then
    local endlessLevel = ConfigData.endless.levelDic[self.stageId]
    if endlessLevel == nil then
      return
    end
    stageCfg = ConfigData.endless[endlessLevel.sectorId][endlessLevel.index]
  elseif self.fromModule == FmtEnum.eFmtFromModule.WarChess then
    return WarChessManager:GetWCRecommenPower(), 0
  elseif self.fromModule == FmtEnum.eFmtFromModule.CardSet then
    return self.__CardSetRecBattlePow, 0
  elseif self.fromModule == FmtEnum.eFmtFromModule.ContinueAct24 then
    return self.__ContinueRecBattlePow, 0
  else
    local playType = FmtEnum.GetFmtGameTypeByModuleId(self.fromModule)
    if playType == FmtEnum.eFmtGamePlayType.Exploration then
      stageCfg = ConfigData.sector_stage[self.stageId]
    elseif playType == FmtEnum.eFmtGamePlayType.Dungeon then
      stageCfg = ConfigData.battle_dungeon[self.stageId]
    end
  end
  if stageCfg == nil then
    return 0, 0
  end
  return stageCfg.combat, stageCfg.bench_combat
end

function EnterFmtData:GetIsCloseCommandSkill()
  return self.isCloseCommandSkill
end

function EnterFmtData:GetFixedCstSkills()
  if self.fromModule ~= FmtEnum.eFmtFromModule.SectorLevel then
    return false
  end
  return ConfigData:GetFixedCstSkillsExp(self.stageId)
end

function EnterFmtData:GetIsOpenFmtEvaluate()
  return self.isOpenFmtEvaluation
end

function EnterFmtData:GetIsOpenSelectDebuff()
  return self.isOpenBuffSelect
end

function EnterFmtData:GetIsOpenSelectEnvBuff()
  return self.isOpenEnvBuffSelect
end

function EnterFmtData:GetIsShowEditNormalObj()
  return self.isShowNotEditNormalObj
end

function EnterFmtData:GetIsOpenBuffWhenEnter()
  return self.isOpenBuffWhenEnter
end

function EnterFmtData:GetFmtIsFriendSupport()
  if self:IsFmtChallengeMode() then
    return false
  end
  return self.isFriendSupport
end

function EnterFmtData:GetFmtForceShowSupportNotAvaliable()
  if self:IsFmtChallengeMode() then
    return true
  end
  return self.__forceShowSupportNotAvaliable
end

function EnterFmtData:GetFmtIsFriendSupportTimeLimitted()
  return self.isFriendSupportTimeLimitted
end

function EnterFmtData:GetFmtIsFriendSupportHaveTimeLimit()
  return self.isFriendSupportHaveTimeLimit
end

function EnterFmtData:GetSupportTimeLimit()
  return ConfigData.game_config.supportTimeLimit + PlayerDataCenter.playerBonus:GetSupportCountAddtion()
end

function EnterFmtData:GetFmtEditIsShowPow()
  return self.__isEditShowPow
end

function EnterFmtData:GetFmtEditIsShowEvaluate()
  return self.__isEditShowEvaluate
end

function EnterFmtData:GetIsOpenChangeFmt()
  return self.isOpenChangeFmt
end

function EnterFmtData:GetCouldShowQuickLevelUp()
  return self.couldShowQuickLevelUp
end

function EnterFmtData:GetIsOpenedCampInfluence()
  return self.isOpenedCampInfluence
end

function EnterFmtData:GetCouldShowFmtRecommendBtn()
  return self.__couldShowRecommendBtn
end

function EnterFmtData:GetCouldShowWarChessRecommendBtn()
  local recommendTeamCheck = self:GetRecommendTeam() ~= nil and not table.IsEmptyTable(self:GetRecommendTeam())
  local recommendSkillCheck = self:GetRecommendSkillData() ~= nil and not table.IsEmptyTable(self:GetRecommendSkillData())
  return recommendTeamCheck and recommendSkillCheck
end

function EnterFmtData:GetIsShowScoreRate()
  return self.__isShowScoreRate
end

function EnterFmtData:GetScoreRateReduceNum()
  return self.__scoreRateReduce
end

function EnterFmtData:GetIsHaveOfficialSupport()
  return self.__isHaveOfficialSupport
end

function EnterFmtData:GetOfficialSupportCfgId()
  return self.__officialSupportCfgId
end

function EnterFmtData:GetIsHaveOfficialSupportHeroDic()
  return self.__allOfficialSupportHeroDataDic
end

function EnterFmtData:GetCardSetTempBannedHeroDic()
  return self.__isHaveCardSetBannedHeroDic
end

function EnterFmtData:GetCardSetTempBannedFairyDic()
  return self.__isHaveCardSetBannedFairyDic
end

function EnterFmtData:GetStartBattleCustomCheckFunc()
  return self.__startBattleCustomCheckFuncDic
end

function EnterFmtData:GetFmtIsShowFairy()
  return self.__isShowFairy
end

function EnterFmtData:GetIsHideRecommandPow()
  return self.__isHideRecommandPow
end

function EnterFmtData:IsBondModule()
  return self.fromModule == FmtEnum.eFmtFromModule.BondDun
end

function EnterFmtData:GenFmtCtrlData()
  self:__GenIsDunAutoBattle()
  self:__GenIsFmtFixed()
  self:__GenIsFmtVirtual()
  self:__GenMapLogic()
  self:__TryGenDungeonDyncData4InBattleFmt()
  self:__GenOfficialSupportId()
  self:__TryGenSupportData()
  self:__TryGenOfficialSupportData()
  self:__GenIsShowScoreRate()
  self:__TryGenFmtRecommendData()
  self:__TryGenCommandSkillData()
  self:__CheckFormationDataVaild()
  self:__GenIsShowFiary()
  self:__GenInfityFormation()
end

function EnterFmtData:__GenOfficialSupportId()
  if not self.stageId then
    return
  end
  local stageCfg = ConfigData.sector_stage[self.stageId]
  if stageCfg == nil then
    return
  end
  if self.__officialSupportCfgId == nil and stageCfg.official_assist and stageCfg.official_assist > 0 then
    self:SetOfficialSupportCfgId(stageCfg.official_assist)
  end
end

function EnterFmtData:__GenIsDunAutoBattle()
  if self.gameType == FmtEnum.eFmtGamePlayType.Dungeon then
    self.isAutoBattleState = BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode()
    self.autoCount = BattleDungeonManager.autoCtrl:GetTotalDungeonAutoCount()
  end
end

function EnterFmtData:__GenIsFmtFixed()
  self.isFmtCtrlFixed = false
  self.__isFixedCouldChangeTeam = false
  if self.fromModule == FmtEnum.eFmtFromModule.SectorLevel or self.fromModule == FmtEnum.eFmtFromModule.Brotato then
    local sectorCfg = ConfigData.sector_stage[self.stageId]
    if sectorCfg == nil then
      error("cant get sectorCfg, id = " .. tostring(self.stageId))
      return
    end
    local fixedHeroTeamId = sectorCfg.fixed_hero_team
    if fixedHeroTeamId == 0 then
      return
    end
    self.defaultFmtId = FormationUtil.GetFmtIdByFixedTeamId(fixedHeroTeamId)
    self.__assistTeamCfg = FormationUtil.SetFiexdFmt(self.defaultFmtId, fixedHeroTeamId)
    if not self.__assistTeamCfg.friend_support then
      self.forbidSupport = true
    end
    self.isOpenTotalPower = self:HasFmtFixedShowPow()
    self.isFmtCtrlFixed = true
    return
  end
  if self.fromModule == FmtEnum.eFmtFromModule.HGV3Normal then
    local dungeonStageCfg = ConfigData.battle_dungeon[self.stageId]
    if dungeonStageCfg == nil then
      error("cant get dungeonStageCfg, id = " .. tostring(self.stageId))
      return
    end
    local fixedHeroTeamId = dungeonStageCfg.fixed_hero_team
    self.defaultFmtId = FormationUtil.GetFmtIdByFixedTeamId(fixedHeroTeamId)
    self.__assistTeamCfg = FormationUtil.SetFiexdFmt(self.defaultFmtId, fixedHeroTeamId)
    if not self.__assistTeamCfg.friend_support then
      self.forbidSupport = true
    end
    self.isOpenTotalPower = self:HasFmtFixedShowPow()
    self.isFmtCtrlFixed = true
    return
  end
  if self.fromModule == FmtEnum.eFmtFromModule.WarChess then
    if self.__wcLevelCfg == nil then
      error("cant read wcLevelCfg, id = " .. tostring(self.stageId))
      return
    end
    self.__isFixedCouldChangeTeam = true
    self.__fixedChangeTeamFmtIdDic = {}
    for index, fixedHeroTeamId in pairs(self.__wcLevelCfg.assist) do
      local isFixed = false
      local dTeamData = self.__wcDTeamDataDic[index]
      if dTeamData ~= nil then
        isFixed = dTeamData:GetDTeamIsFixedTeam()
      end
      if isFixed then
        local fixedFmtId = FormationUtil.GetFmtIdByFixedTeamId(fixedHeroTeamId)
        self.__fixedChangeTeamFmtIdDic[index] = fixedFmtId
        if self.__wcCurTeamIndex == index then
          self.defaultFmtId = fixedFmtId
          self.__assistTeamCfg = FormationUtil.SetFiexdFmt(self.defaultFmtId, fixedHeroTeamId)
          if not self.__assistTeamCfg.friend_support then
            self.forbidSupport = true
          end
          self.isOpenTotalPower = self:HasFmtFixedShowPow()
          self.isFmtCtrlFixed = true
        end
      end
    end
    return
  end
end

function EnterFmtData:__GenIsFmtVirtual()
  if self:IsFmtCtrlVirtualFmtData() then
    local isWc, wcType = self:IsWCFormation()
    local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local treeId = userData:GetLastWeeklySkillList(wcType)
    self.__virtualFmtData = VirtualFormationData.New(treeId, self.__specialRuleGenerator, isWc)
    local fmt = userData:GetLastWeeklyChallengeFmt(wcType)
    self.__virtualFmtData:TryRestoreFormation(fmt)
  end
end

function EnterFmtData:__GenIsShowFiary()
  if self:IsWCFormation() then
    self.__isShowFairy = false
  elseif self.fromModule == FmtEnum.eFmtFromModule.Brotato or self:IsBondModule() then
    self.__isShowFairy = false
  elseif self:IsFmtCtrlFiexd() then
    self.__isShowFairy = false
  end
end

function EnterFmtData:__GenMapLogic()
  if self.fromModule == FmtEnum.eFmtFromModule.SectorLevel then
    local sectorStageCfg = ConfigData.sector_stage[self.stageId]
    if sectorStageCfg == nil then
      error("sectorStageCfg is nil ,id:" .. tostring())
      self.__mapLogic = nil
    end
    local expFloorList = sectorStageCfg.exploration_list
    local expCfg = ConfigData.exploration[expFloorList[1]]
    self.__mapLogic = expCfg.map_logic
  elseif self.fromModule == FmtEnum.eFmtFromModule.Infinity then
    local sectorId = self.stageId // 1000
    local index = self.stageId % 100
    local endless = ConfigData.endless[sectorId][index]
    if endless == nil then
      error("endless is nil , id:" .. tostring(self.stageId))
      self.__mapLogic = nil
    end
    local layerCfg = ConfigData.endless_layer[endless.layer[1]]
    local expCfg = ConfigData.exploration[layerCfg.map_para[1]]
    self.__mapLogic = expCfg.map_logic
  elseif self.fromModule == FmtEnum.eFmtFromModule.WeeklyChallenge then
    local weeklyData = PlayerDataCenter.allWeeklyChallengeData:GetWeeklyChallengeDataByDungeonId(self.stageId)
    if weeklyData == nil then
      error(" weeklyChallenge is nil ,id:" .. tostring(self.stageId))
      self.__mapLogic = nil
    end
    self.__mapLogic = weeklyData:GetMapLogic()
  elseif self.fromModule == FmtEnum.eFmtFromModule.DailyDungeonLevel then
    self.__mapLogic = ExplorationEnum.eMapLogic.Default
  end
end

function EnterFmtData:__TryGenDungeonDyncData4InBattleFmt()
  if self.isInBattleFmt then
    self.fmtDungeonDyncData = FormationUtil.GetDyncDgDataByFmtFromModule(self.fromModule)
  end
end

function EnterFmtData:__TryGenSupportData()
  if self:IsFmtChallengeMode() then
    self.isFriendSupport = false
    self.__forceShowSupportNotAvaliable = true
    return
  end
  if self:IsFmtInWarChessDeploy() then
    self.isFriendSupport = false
    self.__forceShowSupportNotAvaliable = true
    return
  end
  if self:IsFmtInBrotatoDeploy() then
    self.isFriendSupport = false
    self.__forceShowSupportNotAvaliable = true
    return
  end
  if self:IsFmtActivityForbidSupport() then
    self.isFriendSupport = false
    self.__forceShowSupportNotAvaliable = true
    return
  end
  local fromModule = self.fromModule
  if fromModule == FmtEnum.eFmtFromModule.DailyDungeonLevel then
    fromModule = FmtEnum.eFmtFromModule.DailyDungeon
  end
  local isActivityDailyChallenge, adcSupportId = self:IsFmtActivityDailyChallengeSupport()
  if isActivityDailyChallenge then
    fromModule = adcSupportId
  end
  local supportLimitCfg = ConfigData.support_limit[fromModule]
  if supportLimitCfg ~= nil then
    self.isFriendSupportHaveTimeLimit = supportLimitCfg.is_limited
    local isSupportUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Support) and PlayerDataCenter.friendDataCenter:IsFriendDataCenterInited()
    self.isFriendSupport = supportLimitCfg.is_open and isSupportUnlock and not self.forbidSupport
    if self.isFriendSupportHaveTimeLimit then
      self:__GenFriendSupportTimeLimit()
    end
    if self:IsFmtInBattleDeploy() and supportLimitCfg.is_open == nil then
      self.isFriendSupport = isSupportUnlock and not self.forbidSupport
    end
    if self.isFriendSupport and fromModule == FmtEnum.eFmtFromModule.CardSet then
      self.isFriendSupport = self.__CardSetFriendSupportOpen
    end
  end
end

function EnterFmtData:__GenFriendSupportTimeLimit()
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterMoudleSupportLimit, 0)
  local isLimit = false
  if counterElem ~= nil then
    self.isFriendSupportTimeLimitted = counterElem.nextExpiredTm > PlayerDataCenter.timestamp and counterElem.times >= self:GetSupportTimeLimit()
  end
end

function EnterFmtData:__GenIsShowScoreRate()
  if self.__isHaveOfficialSupport and self.__scoreRateReduce and self.__scoreRateReduce ~= 0 then
    self.__isShowScoreRate = true
  end
end

function EnterFmtData:__GenInfityFormation()
  if self:GetIsEpInifinity() then
    self.isShowNotEditNormalObj = false
    self.isOpenFmtEvaluation = false
    self.__infinityFmtData = FormationData.FromCustomData(0, {}, nil, {})
    local savingData = self.__epInifinityData
    local fixedHeroDataList = {}
    local fixedHeroIdList = {}
    for index, heroData in ipairs(savingData:GetFmtSvHeroDataList()) do
      if heroData.isFixedFmtHero then
        fixedHeroDataList[index] = heroData
        fixedHeroIdList[index] = heroData.dataId
      elseif heroData.isEpRoleHero then
        fixedHeroDataList[index] = heroData
        fixedHeroIdList[index] = heroData.dataId
      else
        self.__infinityFmtData:SetHero2Formation(index, heroData.dataId)
      end
    end
    self.__infinityFmtData:SetFmtFixedHeroList(fixedHeroDataList, fixedHeroIdList)
    local fairyData = savingData:GetFmtSvFairyData()
    if fairyData ~= nil then
      self.__infinityFmtData:SetFmtFairyUID(fairyData:GetFairyUID())
    end
    self.__infinityFmtData:SetFmtFakeFairyData(savingData:GetFmtSvFairyData())
    local commandTrees, treeId = savingData:GetFmtSaveCSTData()
    if commandTrees ~= nil then
      self.__infinityFmtData:ModifyCSTDataOrg(commandTrees, treeId)
    end
    self.__infinityFmtData:IsIllegalCST(true)
  end
end

function EnterFmtData:__TryGenOfficialSupportData()
  if self.__officialSupportCfgId == nil or self.__officialSupportCfgId == 0 then
    return
  end
  local officialAssistCfg = ConfigData.official_assist[self.__officialSupportCfgId]
  if officialAssistCfg == nil then
    error("officialAssistCfg not exist, wcAssist id:" .. tostring(self.__officialSupportCfgId))
    return
  end
  self.__isHaveOfficialSupport = true
  self.__allOfficialSupportHeroDataDic = {}
  for index, heroId in ipairs(officialAssistCfg.param1) do
    local assistCfgId = officialAssistCfg.assist_lvs[index]
    local power = officialAssistCfg.effective[index]
    local assisLvCfg = ConfigData.assist_level[assistCfgId]
    local isBrotato = self.fromModule == FmtEnum.eFmtFromModule.Brotato
    local osHeroData = OfficialSupportHeroData.GenOfficialSupportHeroData(heroId, assisLvCfg, power, isBrotato)
    osHeroData:SetOfficialSupportCfgId(self.__officialSupportCfgId)
    self.__allOfficialSupportHeroDataDic[heroId] = osHeroData
  end
end

function EnterFmtData:__TryGenFmtRecommendData()
  self.__couldShowRecommendBtn = false
  if self.fromModule == FmtEnum.eFmtFromModule.SectorLevel or self.fromModule == FmtEnum.eFmtFromModule.Infinity then
    local recommeCtrl = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
    if recommeCtrl:IsCanReqRecomme(self.stageId, false) then
      self.__couldShowRecommendBtn = true
    end
  elseif (self.fromModule == FmtEnum.eFmtFromModule.DungeonTower or self.fromModule == FmtEnum.eFmtFromModule.DungeonTwinTower or self.fromModule == FmtEnum.eFmtFromModule.SixHeroTower) and DungeonTowerUtil.TowerHasRecommendFormation(self.stageId) then
    self.__couldShowRecommendBtn = true
  end
end

function EnterFmtData:__TryGenCommandSkillData()
  if FmtEnum.GetFmtGameTypeByModuleId(self.fromModule) == FmtEnum.eFmtGamePlayType.Dungeon then
    local stageCfg = ConfigData.battle_dungeon[self.stageId]
    if stageCfg ~= nil then
      self.isCloseCommandSkill = stageCfg.close_cmdskill
    end
  elseif self.fromModule == FmtEnum.eFmtFromModule.Brotato then
    local stageCfg = ConfigData.sector_stage[self.stageId]
    if stageCfg ~= nil then
      self.isCloseCommandSkill = stageCfg.close_command_skill
    end
  end
end

function EnterFmtData:GetFmtLimitHeroNum()
  if self:GetIsEpInifinity() then
    return 0
  end
  if self.fromModule == FmtEnum.eFmtFromModule.SectorLevel or self.fromModule == FmtEnum.eFmtFromModule.CarnivalEp or self.fromModule == FmtEnum.eFmtFromModule.SpringEp or self.fromModule == FmtEnum.eFmtFromModule.Brotato then
    local sectorStageCfg = ConfigData.sector_stage[self.stageId]
    if sectorStageCfg == nil then
      error("sectorStageCfg is nil ,id:" .. tostring(self.stageId))
      return 0
    end
    return sectorStageCfg.formation_num_limit
  elseif self.gameType == FmtEnum.eFmtGamePlayType.Dungeon then
    local dungeonCfg = ConfigData.battle_dungeon[self.stageId]
    if dungeonCfg ~= nil then
      return dungeonCfg.formation_num_limit
    end
  end
  return 0
end

function EnterFmtData:IsFmtPlatformBan(platformIdx)
  local limitHeroNum = self:GetFmtLimitHeroNum()
  return 0 < limitHeroNum and platformIdx > limitHeroNum
end

function EnterFmtData:TryReGenFixedFmtData(fmtIndex)
  if self:IsFmtFixedCouldChangeTeam() then
    self.__wcCurTeamIndex = fmtIndex
    self:__GenIsFmtFixed()
    return true
  end
  return false
end

function EnterFmtData:GetStageCfg()
  local stageCfg = ConfigData.sector_stage[self.stageId]
  if stageCfg ~= nil then
    return stageCfg
  end
  if WarChessSeasonManager:GetIsInWCSeason() then
    local ctrl = WarChessSeasonManager:GetWCSCtrl()
    stageCfg = WarChessSeasonManager:GetWCSStageInfoByTowerId(ctrl:GetWCSSeasonId(), ctrl:GetWCSTowerId())
    if stageCfg ~= nil then
      return stageCfg
    end
  end
  stageCfg = ConfigData.battle_dungeon[self.stageId]
  if stageCfg ~= nil then
    return stageCfg
  end
  return nil
end

function EnterFmtData:__CheckFormationDataVaild()
  if not self.__isNeedCheckFormation then
    return
  end
  local fmtData = PlayerDataCenter.formationDic[self.defaultFmtId]
  if fmtData == nil then
    return
  end
  local heroIds = {}
  if self.__allOfficialSupportHeroDataDic ~= nil then
    for k, v in pairs(self.__allOfficialSupportHeroDataDic) do
      heroIds[k] = v.__officialSupportCfgId
    end
    local curOfficialSupportData = fmtData:GetIsHaveOfficialSupportDic()
    if curOfficialSupportData ~= nil then
      for k, v in pairs(curOfficialSupportData) do
        local heroId = v.heroId
        local cfgId = heroIds[heroId]
        if cfgId ~= nil and cfgId ~= v.cfgId then
          fmtData:CleanFormation()
          return
        end
        heroIds[heroId] = nil
      end
    end
    local fmtHeros = fmtData:GetFormationHeroDic()
    for k, v in pairs(fmtHeros) do
      if heroIds[v] ~= nil then
        fmtData:CleanFormation()
        return
      end
    end
  end
  if self.__specialRuleGenerator ~= nil then
    for k, v in pairs(self.__specialRuleGenerator.specialRuler.heroIds) do
      heroIds[v] = 1
    end
  end
  local fmtHeros = fmtData:GetFormationHeroDic()
  for k, v in pairs(fmtHeros) do
    if heroIds[v] ~= nil then
      return
    end
  end
  fmtData:CleanFormation()
end

function EnterFmtData:ApplyEpInifinity4Act24FmtData(fmtData)
  if self.__factCardData == nil then
    return
  end
  fmtData:CleanFormation()
  local heroIdxMap = self.__factCardData:GetRfCdFacHeroIdexDic()
  for heroData, fmtIndex in pairs(heroIdxMap) do
    local realHeroData = PlayerDataCenter.heroDic[heroData.dataId]
    if realHeroData ~= nil then
      fmtData:SetHero2Formation(fmtIndex, heroData.dataId)
    end
  end
  local fairyUID = self.__factCardData:GetRfCdFacFairyUID()
  fmtData:SetFmtFairyUID(fairyUID)
  fmtData:RegularFormationFairy()
end

return EnterFmtData
