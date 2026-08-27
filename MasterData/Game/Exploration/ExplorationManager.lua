local DynEpMapData = require("Game.Exploration.MapData.DynEpMapData")
local DynPlayer = require("Game.Exploration.Data.DynPlayer")
local EpMvpData = require("Game.Exploration.Data.EpMvpData")
local CS_PlayerPrefs = CS.UnityEngine.PlayerPrefs
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local util = require("XLua.Common.xlua_util")
local cs_MessageCommon = CS.MessageCommon
local CS_BattleManager_Ins = CS.BattleManager.Instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local SectorEnum = require("Game.Sector.SectorEnum")
local ExplorationResultCtrl = require("Game.Exploration.Ctrl.ExplorationResultCtrl")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ChipData = require("Game.PlayerData.Item.ChipData")
local DynBuff = require("Game.Exploration.Data.DynBuff")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local EpDataCenter = require("Game.Exploration.MapData.EpDataCenter")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local epMainCtrlCfg = {
  [ExplorationEnum.eMapLogic.Default] = require("Game.Exploration.MainCtrl.EpNormalMainCtrl"),
  [ExplorationEnum.eMapLogic.TowerDefence] = require("Game.Exploration.MainCtrl.EpTDMainCtrl"),
  [ExplorationEnum.eMapLogic.Light] = require("Game.Exploration.MainCtrl.EpLightMainCtrl"),
  [ExplorationEnum.eMapLogic.Guard] = require("Game.Exploration.MainCtrl.EpLightMainCtrl"),
  [ExplorationEnum.eMapLogic.Brotato] = require("Game.Exploration.MainCtrl.EpLightMainCtrl")
}
local epDynPlayerCfg = {
  [ExplorationEnum.eMapLogic.Default] = require("Game.Exploration.Data.DynPlayer"),
  [ExplorationEnum.eMapLogic.TowerDefence] = require("Game.BattleTowerDefence.Data.TowerDefenceDynPlayer"),
  [ExplorationEnum.eMapLogic.Light] = require("Game.Exploration.Data.DynPlayer"),
  [ExplorationEnum.eMapLogic.Guard] = require("Game.BattleGuard.Data.GuardProfessorDynPlayer"),
  [ExplorationEnum.eMapLogic.Brotato] = require("Game.Exploration.Data.DynPlayer")
}
ExplorationManager = {__isInExploration = false}

local function __NewExplorationInternal(self, fomationId)
end

local function __ClearCurExploration(self)
  if self.epCtrl ~= nil then
    self.epCtrl:OnDelete()
    self.epCtrl = nil
  end
end

function ExplorationManager:ctor()
  self.resultCtrl = ExplorationResultCtrl.New()
end

function ExplorationManager:IsInExploration()
  return self.__isInExploration
end

function ExplorationManager:IsInTDExp()
  if not self:IsInExploration() then
    return false
  end
  if self.floorId ~= nil then
    local expCfg = ConfigData.exploration[self.floorId]
    if expCfg ~= nil and self:CheckTDModeByMapLogic(expCfg.map_logic) then
      return true
    end
  else
    local dungeonId
    if self.dungeonId == nil then
      _, dungeonId, _ = ExplorationManager:HasUncompletedEp()
    else
      dungeonId = self.dungeonId
    end
    if dungeonId == nil then
      return false
    end
    local sectorStageCfg = ConfigData.sector_stage[self.dungeonId]
    if sectorStageCfg == nil then
      return false
    end
    local expFloorList = sectorStageCfg.exploration_list
    if expFloorList == nil then
      return false
    end
    for _, v in ipairs(expFloorList) do
      local expCfg = ConfigData.exploration[v]
      if expCfg ~= nil and self:CheckTDModeByMapLogic(expCfg.map_logic) then
        return true
      end
    end
  end
  return false
end

function ExplorationManager:IsInGuardExp()
  if not self:IsInExploration() then
    return false
  end
  if self.floorId ~= nil then
    local expCfg = ConfigData.exploration[self.floorId]
    if expCfg ~= nil and self:CheckGuardModeByMapLogic(expCfg.map_logic) then
      return true
    end
  else
    local dungeonId
    if self.dungeonId == nil then
      _, dungeonId, _ = ExplorationManager:HasUncompletedEp()
    else
      dungeonId = self.dungeonId
    end
    if dungeonId == nil then
      return false
    end
    local sectorStageCfg = ConfigData.sector_stage[self.dungeonId]
    if sectorStageCfg == nil then
      return false
    end
    local expFloorList = sectorStageCfg.exploration_list
    if expFloorList == nil then
      return false
    end
    for _, v in ipairs(expFloorList) do
      local expCfg = ConfigData.exploration[v]
      if expCfg ~= nil and self:CheckGuardModeByMapLogic(expCfg.map_logic) then
        return true
      end
    end
  end
  return false
end

function ExplorationManager:IsInBrotatoExp()
  if not self:IsInExploration() then
    return false
  end
  if self.floorId ~= nil then
    local expCfg = ConfigData.exploration[self.floorId]
    if expCfg ~= nil and self:CheckBrotatoModeByMapLogic(expCfg.map_logic) then
      return true
    end
  else
    local dungeonId
    if self.dungeonId == nil then
      _, dungeonId, _ = ExplorationManager:HasUncompletedEp()
    else
      dungeonId = self.dungeonId
    end
    if dungeonId == nil then
      return false
    end
    local sectorStageCfg = ConfigData.sector_stage[self.dungeonId]
    if sectorStageCfg == nil then
      return false
    end
    local expFloorList = sectorStageCfg.exploration_list
    if expFloorList == nil then
      return false
    end
    for _, v in ipairs(expFloorList) do
      local expCfg = ConfigData.exploration[v]
      if expCfg ~= nil and self:CheckBrotatoModeByMapLogic(expCfg.map_logic) then
        return true
      end
    end
  end
  return false
end

function ExplorationManager:CheckTDModeByMapLogic(mapLogicId)
  return mapLogicId == ExplorationEnum.eMapLogic.TowerDefence
end

function ExplorationManager:CheckGuardModeByMapLogic(mapLogicId)
  return mapLogicId == ExplorationEnum.eMapLogic.Guard
end

function ExplorationManager:CheckBrotatoModeByMapLogic(mapLogicId)
  return mapLogicId == ExplorationEnum.eMapLogic.Brotato
end

function ExplorationManager:IsInExplorationAndScene()
  return self.__isInExploration and self.epCtrl ~= nil and self.epCtrl.loadSceneComplete
end

function ExplorationManager:ReqEnterExploration(epId, fomationId, moduleId, ezMode, callback, support, challengeMode, challengeTaskIdList, firstPower, benchPower, selectBuffIds, inifinityData, isEnvBuff, reinforceData)
  self.__enterEpComplete = callback
  
  local function EnterCallback(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    ExplorationManager:RecvEnterExploration(msg)
  end
  
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.network:CS_EXPLORATION_Start(epId, fomationId, moduleId, ezMode, EnterCallback, support, challengeMode, challengeTaskIdList, firstPower, benchPower, selectBuffIds, nil, inifinityData, isEnvBuff, reinforceData)
  self:__ClearEnterData()
end

function ExplorationManager:RecvEnterExploration(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_StartFailure) .. tostring(msg.ret))
    MsgCenter:Broadcast(eMsgEventId.ExplorationEnterComplete, false)
    return
  end
  self:__NewExploration(msg.detail, false)
end

function ExplorationManager:ReqEnterExplorationQuickBattle(epId, fomationId, moduleId, ezMode, callback, support, challengeMode, challengeTaskIdList, stageCfg)
  local network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  
  local function EnterCallback(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    ExplorationManager:PopEpQuickBattlRewardPick(msg.quitModeReward, stageCfg)
    if callback ~= nil then
      callback()
    end
  end
  
  network:CS_EXPLORATION_Start(epId, fomationId, moduleId, ezMode, EnterCallback, support, challengeMode, challengeTaskIdList, 0, 0, nil, true)
  self:__ClearEnterData()
end

function ExplorationManager:PopEpQuickBattlRewardPick(quitModeReward, stageCfg)
  local network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  UIManager:ShowWindowAsync(UIWindowTypeID.SeasonQuickBattle, function(win)
    if win ~= nil then
      local rewardList = quitModeReward.stmStore
      win:RefreshSeasonQuickBattle(rewardList, stageCfg, function(rewardDic, pickInfo)
        network:CS_EXPLORATION_Settle(nil, false, false, nil, nil, pickInfo, nil, nil, function(msg)
          local data = msg[0]
          local StOCareerRewardDic = table.GetDefaulValueTable(0)
          local _rewardDic = table.GetDefaulValueTable(0)
          for k, v in pairs(data.firstClearRewards) do
            _rewardDic[k] = _rewardDic[k] + v
          end
          if data.rewards ~= nil then
            for k, v in pairs(data.rewards.rewards) do
              if ConfigData.game_config.STOCareerCostDic[k] ~= nil then
                StOCareerRewardDic[k] = StOCareerRewardDic[k] + v
              else
                _rewardDic[k] = _rewardDic[k] + v
              end
            end
          end
          for k, v in pairs(data.normalRewards) do
            _rewardDic[k] = _rewardDic[k] + v
          end
          if not table.IsEmptyTable(StOCareerRewardDic) then
            UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
              if window == nil then
                return
              end
              for itemId, num in pairs(StOCareerRewardDic) do
                window:ShowTips({itemId = itemId, num = num}, 2, eMessageSideType.ecParameter)
              end
            end)
          end
          win:Delete()
          MsgCenter:Broadcast(eMsgEventId.OnEpQuickBattleComplete)
          UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
            if window == nil then
              return
            end
            local CRData = CommonRewardData.CreateCRDataUseDic(_rewardDic):SetCRItemCustomTransDic(data.overflowRewardTurnInfo)
            window:AddAndTryShowReward(CRData)
            if self.__lastEpData ~= nil then
              self.__lastEpData = nil
              MsgCenter:Broadcast(eMsgEventId.OnHasUncompletedEp)
            end
          end)
        end)
      end)
    end
  end)
end

function ExplorationManager:__ClearEnterData()
  self.__enterAutoEp = false
end

function ExplorationManager:GetMapCfg(dungeonId)
  if self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local cfg = ConfigData.sector_stage[dungeonId]
    if cfg == nil then
      error("sector stage is null,id:" .. tostring(dungeonId))
      return
    end
    local metatable = getmetatable(cfg)
    local stageCfg = {}
    for key, value in pairs(metatable.__index) do
      stageCfg[key] = value
    end
    for key, value in pairs(cfg) do
      stageCfg[key] = value
    end
    return stageCfg
  elseif self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    local endlessId = dungeonId
    local levelDic = ConfigData.endless.levelDic[endlessId]
    local cfg = ConfigData.endless[levelDic.sectorId][levelDic.index]
    if cfg == nil then
      error("endlessCfg is null,endlessId:" .. tostring(endlessId))
      return
    end
    local stageCfg = {
      endlessCfg = cfg,
      name = cfg.name,
      sector = levelDic.sectorId,
      index = levelDic.index,
      cost_strength_num = cfg.cost_strength_itemNums[1],
      difficulty = SectorLevelDetailEnum.eDifficulty.infinity,
      dungeonId = endlessId,
      combat = cfg.combat,
      active_alg_limit = cfg.active_alg_limit
    }
    return stageCfg
  elseif self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
    local challengeCfg = ConfigData.daily_challenge[dungeonId]
    local stageCfg = {
      challengeCfg = challengeCfg,
      name = LanguageUtil.GetLocaleText(challengeCfg.name),
      sector = nil,
      cost_strength_num = 0,
      difficulty = SectorLevelDetailEnum.eDifficulty.daily_challenge,
      dungeonId = dungeonId,
      combat = 5000,
      active_alg_limit = 0
    }
    return stageCfg
  elseif self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    local challengeCfg = ConfigData.weekly_challenge[dungeonId]
    local stageCfg = {
      challengeCfg = challengeCfg,
      name = LanguageUtil.GetLocaleText(challengeCfg.name),
      sector = nil,
      cost_strength_num = 0,
      difficulty = SectorLevelDetailEnum.eDifficulty.weekly_challenge,
      dungeonId = dungeonId,
      combat = 5000,
      active_alg_limit = 0
    }
    return stageCfg
  end
end

function ExplorationManager:ReqEnterChallengeExploration(fomationId, callback)
  self.__enterEpComplete = callback
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.network:CS_DAILYCHALLENGE_Start(fomationId)
end

function ExplorationManager:ReqEnterWeeklyExploration(challengeId, virtualFormation, callback, firstPower, benchPower)
  self.__enterEpComplete = callback
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.network:CS_WEEKLYCHALLENGE_Start(challengeId, virtualFormation.buffIds, virtualFormation.formation.data, virtualFormation:GetVirFmtCstData(), firstPower, benchPower)
end

function ExplorationManager:__NewExploration(msg, isReconnect)
  self.restartInfo = {
    epId = msg.epMap.dungeonId,
    fomationId = msg.epStc.formId,
    moduleId = msg.epMap.moduleId,
    challengeMode = msg.epMap.challengeMode
  }
  self.moduleId = msg.epMap.moduleId
  self.floorId = msg.epMap.floorId
  self.dungeonId = msg.epMap.dungeonId
  self.astAv = msg.astAv
  self.chipScoreInfiniteCore = msg.epMap.infiniteCoe or 0
  isReconnect = isReconnect or false
  self.epDataCenter = EpDataCenter.New()
  self.epDataCenter:InitEpDataCenter()
  local isChallenge = false
  local moduleId = self:GetEpModuleId()
  self.stageCfg = self:GetMapCfg(self:GetEpDungeonId())
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    self.epDataCenter:GetStageEpChipData(self.stageCfg)
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    local endlessId = self:GetEpDungeonId()
    local levelDic = ConfigData.endless.levelDic[endlessId]
    local cfg = ConfigData.endless[levelDic.sectorId][levelDic.index]
    if cfg == nil then
      error("endlessCfg is null,endlessId:" .. tostring(endlessId))
      return
    end
    self.epDataCenter:GetInfinityEpChipData(cfg)
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
    isChallenge = true
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    isChallenge = true
  end
  NetworkManager:GetNetwork(NetworkTypeID.Sector):SendChipSet()
  if not isChallenge then
    local cfg = ConfigData.sector[self.stageCfg.sector]
    if cfg == nil then
      error("sector cfg is null,id:" .. tostring(self.stageCfg.sector))
      return
    end
    self.sectorCfg = cfg
  end
  local epDynPlayerClass = epDynPlayerCfg[msg.epMap.logic]
  if epDynPlayerClass == nil then
    error("Cant get epDynPlayerClass, logic = " .. tostring(msg.epMap.logic))
    return
  end
  self.__isInExploration = true
  self.dynPlayer = epDynPlayerClass.New()
  self.dynPlayer:UpdateEpCommonData(msg.epCommon)
  self.dynPlayer:CreateDefaultPlayer(msg.epRoleStc, msg.epRoleDyc, msg.epStc, msg.epStmGoods)
  local heroDatas = {}
  for k, v in pairs(msg.epRoleStc.heroes) do
    heroDatas[v.dataId] = v
  end
  self.dynPlayer:InitDynSpecEffect(msg.epEffect)
  self.dynPlayer:InitDynPlayerAttr(msg.epRoleStc.player)
  self.dynPlayer:UpdateHeroAttr(heroDatas)
  self.dynPlayer:UpdateOperatorDetail(msg.epOp)
  self.dynPlayer:UpdateEpEventData(msg.epOp)
  self.dynPlayer:UpdateEpBackpack(msg.epBackpack)
  self.dynPlayer:UpdateEpBuff(msg.epBuff)
  self.dynPlayer:UpdateAllDynServerGrid(msg.epBattleGrid)
  self.dynPlayer:UpdateWcCurrentScore(msg.epWCscore)
  self:EnterCurSectionExploration(msg, isReconnect)
  MsgCenter:Broadcast(eMsgEventId.ExplorationEnterComplete, true)
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  if self.__enterEpComplete ~= nil then
    self.__enterEpComplete()
    self.__enterEpComplete = nil
  end
  self.epMvpData = EpMvpData.New(msg.epRoleStc.heroes)
  self.epMvpData.defaultMVPHeroId = self.dynPlayer.heroList[1].dataId
  if isReconnect then
    self.epMvpData:AddServerSaveData(msg.epStc.record, msg.epRoleStc.heroes)
  end
  self:UpdateChipDataPreview()
  self:__ClearEnterData()
end

function ExplorationManager:TryUpdataEpMvpHeros(heroList, removeHeroList)
  if self.epMvpData ~= nil then
    self.epMvpData:UpdataEpMvpDataHeroIdMapping(heroList, removeHeroList)
  end
end

function ExplorationManager:GetEpModuleId()
  if self.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_InfiniteMode then
    return proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration
  end
  return self.moduleId
end

function ExplorationManager:GetEpModuleTypeCfgId()
  if self:IsInExplorationTD() then
    return ConfigData.game_config.towerEpTypeCfgId
  end
  if self:IsInBrotatoExp() then
    local brotatoChallengeCfg = ConfigData.brotato_challenge[self.dungeonId]
    if brotatoChallengeCfg ~= nil then
      return brotatoChallengeCfg.exploration_type
    end
  end
  if self.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_InfiniteMode then
    return proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration
  end
  return self.moduleId
end

function ExplorationManager:IsSectorNewbee()
  local moduleId = self:GetEpModuleId()
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local stageCfg = self:GetSectorStageCfg()
    local sectorId = stageCfg.sector
    return sectorId == SectorEnum.NewbeeSectorId
  end
  return false
end

function ExplorationManager:GetEpSectorId()
  local stageCfg = self:GetSectorStageCfg()
  if stageCfg == nil then
    return 0
  end
  local sectorId = stageCfg.sector
  return sectorId
end

function ExplorationManager:GetEpBottomOverride()
  local overridBgEffectStr
  local sectorId = self:GetEpSectorId()
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg ~= nil then
    overridBgEffectStr = sectorCfg.bottom_override
  end
  if string.IsNullOrEmpty(overridBgEffectStr) then
    local floorId = self.floorId
    local explorationConfig = ConfigData.exploration[floorId]
    if explorationConfig ~= nil then
      overridBgEffectStr = explorationConfig.bottom_override
    end
  end
  if string.IsNullOrEmpty(overridBgEffectStr) then
    overridBgEffectStr = "commonBgEffect"
  end
  return overridBgEffectStr
end

function ExplorationManager:GetEpBackgroudOverride()
  local backgroundOverride
  local sectorId = self:GetEpSectorId()
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg ~= nil then
    backgroundOverride = sectorCfg.background_override
  end
  if string.IsNullOrEmpty(backgroundOverride) then
    local floorId = self.floorId
    local explorationConfig = ConfigData.exploration[floorId]
    if explorationConfig ~= nil then
      backgroundOverride = explorationConfig.background_override
    end
  end
  return backgroundOverride
end

function ExplorationManager:IsSectorTeach()
  local stageCfg = self:GetSectorStageCfg()
  return stageCfg.teach_tag == 1
end

function ExplorationManager:GetEpTypeCfg()
  local moduleId = self:GetEpModuleTypeCfgId()
  local epTypeCfg = ConfigData.exploration_type[moduleId]
  if epTypeCfg == nil then
    error("Cant get exploration_type, epModuleId = " .. tostring(moduleId))
    return
  end
  return epTypeCfg
end

function ExplorationManager:GetEpDungeonId()
  return self.dungeonId
end

function ExplorationManager:GetSectorStageCfg()
  return self.stageCfg
end

function ExplorationManager:GetSectorCfg()
  return self.sectorCfg
end

function ExplorationManager:GetCurExplorationId()
  return self.floorId
end

function ExplorationManager:ReqRestartEpFloor()
  self.network:CS_EXPLORATION_SnapshotRollback()
end

function ExplorationManager:OnRestartEpFloor(msg)
  CS_BattleManager_Ins:ForceExitBattle()
  self:__NewExploration(msg, true)
end

function ExplorationManager:EnterCurSectionExploration(msg, isReconnect, isNextExp)
  self.floorId = msg.epMap.floorId
  isReconnect = isReconnect or false
  local needEnableAutoEp = false
  if self.epCtrl ~= nil then
    needEnableAutoEp = self.epCtrl.autoCtrl:IsEnableAutoMode() or self.__enterAutoEp
  end
  if ExplorationManager:EnableEpAutoNextStage() then
    print(string.format("【<color=#FF8B08>Dev自动连续探索</color>】开启自动探索，explorationId:%s", self.floorId))
    needEnableAutoEp = true
  end
  __ClearCurExploration(self)
  UIManager:DeleteAllWindow()
  CS.UIManager.Instance:DeleteAllWindow()
  local epMapData = DynEpMapData.New()
  if isNextExp then
    self.stageCfg = self:GetMapCfg(msg.epMap.dungeonId)
  end
  local opDetail = self.dynPlayer:GetOperatorDetail(self:GetSectorStageCfg().id)
  epMapData:InitMapData(msg.epMap, msg.epNext, opDetail)
  self.dynPlayer:SetChipDiscardId(msg.epMap.discardId)
  self.dynPlayer:SetFloorStartRandomBuff(msg.epMap.floorStartRandomBuff)
  local epMainCtrlClass = epMainCtrlCfg[msg.epMap.logic]
  if epMainCtrlClass == nil then
    error("Cant get epMainCtrlClass, logic = " .. tostring(msg.epMap.logic))
    return
  end
  self.epCtrl = epMainCtrlClass.New(epMapData, self.dynPlayer)
  self.epCtrl.autoCtrl:SetDefaultAutoEp(needEnableAutoEp)
  self.epCtrl.overclockCtrl:InitEpOverclockCtrl(msg.epClock)
  if msg.epGrid ~= nil then
    self.epCtrl:UpdateNextRoomInfo(msg.epGrid, msg.epOp)
  end
  if msg.epResident ~= nil then
    self.epCtrl:UpdateResidentDetail(msg.epResident)
  end
  local isFirstEnter = not isReconnect and not isNextExp
  self.epCtrl:Start(isReconnect, isFirstEnter)
  GR.SetIsOneTheEpMap(true)
end

function ExplorationManager:EnterNextSectionExploration()
  local nextBrief = self.epCtrl.mapData:GetNextMapBrief()
  local id
  for k, v in pairs(nextBrief.data) do
    id = k
    break
  end
  self.network:CS_EXPLORATION_NextFloor(id)
end

function ExplorationManager:OnEnterNextSectionExploration(msg)
  AudioManager:PlayAudioById(1028)
  self:EnterCurSectionExploration(msg, false, true)
end

function ExplorationManager.IsCompleteLastEpRoom(msg)
  local x, y = ExplorationManager.Coordination2Pos(msg.epOp.curPostion)
  local nextPos = ExplorationManager.XY2Coordination(x + 1, y)
  return msg.epOp.canFloorOver and msg.epMap.lineData[msg.epOp.curPostion] ~= nil and msg.epMap.lineData[nextPos] == nil and msg.epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over and msg.epMap.floorIdx + 1 >= msg.epMap.floor
end

function ExplorationManager:GetLastEpData()
  return self.__lastEpData
end

function ExplorationManager:GetIsLastEpDataQuitMode()
  if self.__lastEpData == nil then
    return false
  end
  return self.__lastEpData.epMap.quitMode
end

function ExplorationManager:RecordLastEpData(msg)
  self.__lastEpData = msg
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  local isComplete = false
  local hasHasUncompletedEp, dungeonId = ExplorationManager:HasUncompletedEp()
  if hasHasUncompletedEp then
    local noStore = msg.epStmGoods == nil or #msg.epStmGoods.stmStore == 0
    local x, y = ExplorationManager.Coordination2Pos(msg.epOp.curPostion)
    local nextPos = ExplorationManager.XY2Coordination(x + 1, y)
    if ExplorationManager.IsCompleteLastEpRoom(msg) and noStore then
      self.resultCtrl:EnterResultProcess(true, false)
      isComplete = true
    elseif msg.epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleFailure then
      local returnStamina, remainLevelCount, costStamina = self:GetLastEpReturnStamina()
      if costStamina <= 0 and noStore then
        self.resultCtrl:EnterResultProcess(false, false)
        isComplete = true
      end
    end
    local stageCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Ep)
    if stageCfg ~= nil and stageCfg.sector ~= nil and stageCfg.difficulty <= SectorLevelDetailEnum.eDifficulty.infinity then
      PlayerDataCenter.sectorStage:InitSelectStage(stageCfg.sector, stageCfg.difficulty)
    end
  end
  if isComplete then
    self.__lastEpData = nil
  end
  MsgCenter:Broadcast(eMsgEventId.OnHasUncompletedEp)
end

function ExplorationManager:HasUncompletedEp()
  local has = self.__lastEpData ~= nil and self.__lastEpData.epMap ~= nil
  local moduleId = has and self.__lastEpData.epMap.moduleId
  local dungeonId = has and self.__lastEpData.epMap.dungeonId
  local canFloorOver = has and self.__lastEpData.epOp ~= nil and self.__lastEpData.epOp.canFloorOver and self.__lastEpData.epMap.floorIdx + 1 >= self.__lastEpData.epMap.floor
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_InfiniteMode then
    moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration
  end
  return has, dungeonId, moduleId, canFloorOver
end

function ExplorationManager:GetStoreData()
  if self.dynPlayer ~= nil then
    return self.dynPlayer.dynRewardBag:GetEpRewardBagDataList()
  end
  if self.__lastEpData ~= nil and self.__lastEpData.epStmGoods ~= nil then
    return self.__lastEpData.epStmGoods.stmStore
  end
  return nil
end

function ExplorationManager:ContinueLastExploration(callback)
  if not self:HasUncompletedEp() then
    print("Last exploration data is null")
    return
  end
  if self.__lastEpData.epMap.quitMode then
    self:PopEpQuickBattleReult()
    return
  end
  self.__enterEpComplete = callback
  if self.__onContinueLastExploration == nil then
    self.__onContinueLastExploration = BindCallback(self, self.OnContinueLastExploration)
  end
  self.network:CS_EXPLORATION_NtfServerEnter(self.__onContinueLastExploration)
end

function ExplorationManager:PopEpQuickBattleReult()
  local stageCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Ep)
  ExplorationManager:PopEpQuickBattlRewardPick(self.__lastEpData.epMap.quitModeReward, stageCfg)
end

function ExplorationManager:OnContinueLastExploration()
  self:__NewExploration(self.__lastEpData, true)
  self.__lastEpData = nil
end

function ExplorationManager:GiveUpLastExploration()
  if not self:HasUncompletedEp() then
    print("Last exploration data is null")
    return
  end
  local isWin = ExplorationManager.IsCompleteLastEpRoom(self.__lastEpData)
  self.resultCtrl:EnterResultProcess(isWin, false)
end

function ExplorationManager:SendFloorSettle(callback)
  if self.dynPlayer ~= nil then
    self.network:CS_EXPLORATION_SettleFloor(self.dynPlayer:GetOperatorDetail().curPostion, callback)
  else
    print("warning : dynPlayer is nil")
  end
end

function ExplorationManager:ExitExploration(SceneName, loadMainCallback, isWin, scenechangeCallback)
  CS_BattleManager_Ins:ForceExitBattle()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetUnitBlood(0, 0)
  local LastPlayData = require("Game.Sector.Data.LastPlayData")
  local lastPlayData = LastPlayData.New():SetLPDStageCfg(self.stageCfg):SetLPDIsWin(isWin == true)
  self._lastMvpVoiceHeroId = nil
  self._lastVoiceId = nil
  MsgCenter:Broadcast(eMsgEventId.ExplorationExit)
  self.network:CS_EXPLORATION_Detail()
  self:ClearExploration()
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Character)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Monster)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_SupSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Battle_Buff)
  AudioManager:RemoveCueSheet(eAuCueSheet.CommonSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Ambience)
  AudioManager:RemoveAllVoice()
  UIManager:DeleteAllWindow()
  CS.UIManager.Instance:DeleteAllWindow()
  if SceneName == nil or SceneName == Consts.SceneName.Sector then
    local function loadingFunc()
      if scenechangeCallback ~= nil then
        scenechangeCallback()
      end
    end
    
    UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(1)
    PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, loadingFunc)
  elseif SceneName == Consts.SceneName.Main then
    UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(1)
    CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
      ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
      UIManager:CreateWindowAsync(UIWindowTypeID.Home, function(window)
        if window == nil then
          return
        end
        window:SetFrom2Home(AreaConst.Home, true)
        if loadMainCallback ~= nil then
          loadMainCallback()
        end
        if scenechangeCallback ~= nil then
          scenechangeCallback()
        end
      end)
    end)
  end
end

function ExplorationManager:RestartExploratcion(enterAutoEp)
  if self.restartInfo ~= nil then
    self:ReqEnterExploration(self.restartInfo.epId, self.restartInfo.fomationId, self.restartInfo.moduleId, nil, nil, nil, self.restartInfo.challengeMode)
    self.__enterAutoEp = enterAutoEp or false
  end
end

function ExplorationManager:EnableEpAutoNextStage()
  return isEditorMode and CS.GMController.Instance.epAutoNextStage
end

function ExplorationManager:EditorTryNextEp(endFunc)
  if not ExplorationManager:EnableEpAutoNextStage() then
    return
  end
  if self.restartInfo == nil then
    return
  end
  print(string.format("【<color=#FF8B08>Dev自动连续探索</color>】探索关(%s)结束,尝试找下一关", self.restartInfo.epId))
  local nextEpId
  local epIdList = require("Game.Exploration.Editor.EditorEpAutoNextEpCfg")
  for k, stageId in ipairs(epIdList) do
    if self.restartInfo.epId == stageId then
      nextEpId = epIdList[k + 1]
      break
    end
  end
  if nextEpId == nil then
    print(string.format("【<color=#FF8B08>Dev自动连续探索</color>】没有下一关了，全部结束"))
    if endFunc then
      endFunc()
    end
    return
  end
  print(string.format("【<color=#FF8B08>Dev自动连续探索</color>】探索关(%s)开始", nextEpId))
  self.restartInfo.epId = nextEpId
  self.restartInfo.fomationId = 1
  self:RestartExploratcion(true)
end

function ExplorationManager:ClearExploration()
  self.moduleId = nil
  self.dungeonId = nil
  self.dynPlayer = nil
  self.network = nil
  self.__isInExploration = false
  self.stageCfg = nil
  if self.epDataCenter ~= nil then
    self.epDataCenter:CleanEpDataCenter()
    self.epDataCenter = nil
  end
  __ClearCurExploration(self)
end

function ExplorationManager.Coordination2Pos(coordination)
  local x = coordination & CommonUtil.UInt16Max
  local y = coordination >> 16
  return x, y
end

function ExplorationManager.XY2Coordination(x, y)
  local coordination = y << 16 | x
  return coordination
end

function ExplorationManager.ChipServerIdConvert(serverId)
  local chipId = serverId >> 4
  local level = serverId & 15
  return chipId, level
end

function ExplorationManager.ChipConvert2ServerId(chipId, level)
  local serverId = chipId << 4 | level
  return serverId
end

function ExplorationManager:GetCurLevelIndex()
  return self.epCtrl.mapData.floorIdx
end

function ExplorationManager:GetLevelCount()
  return self.epCtrl.mapData.floor
end

function ExplorationManager:GetEpCurRoomPostion()
  local curPositon
  if self:IsInExploration() and self.epCtrl ~= nil then
    curPositon = self.epCtrl:GetCurrentRoomData():GetRoomPosition()
  elseif self.__lastEpData ~= nil and self.__lastEpData.epOp ~= nil then
    curPositon = self.__lastEpData.epOp.curPostion
  end
  return curPositon
end

function ExplorationManager:GetReturnStamina()
  local levelCount = self:GetLevelCount()
  local remainLevelCount = levelCount - (self:GetCurLevelIndex() + 1)
  if self.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless and not PlayerDataCenter.infinityData:IsInfinityDungeonCompleted(self:GetSectorStageCfg().dungeonId) then
    return 0, remainLevelCount, 0
  end
  local stageCfg = self:GetSectorStageCfg()
  local costStamina = stageCfg.cost_strength_num
  if costStamina == 0 or stageCfg.cost_strength_id ~= nil and stageCfg.cost_strength_id ~= ConstGlobalItem.SKey then
    return 0, remainLevelCount, costStamina, 0
  end
  local returnStamina = math.clamp(math.floor(costStamina - ConfigData.game_config.retreatDeductStamina), 0, costStamina)
  local rewardReturnStamina = math.floor(costStamina * (remainLevelCount + ConfigData.game_config.returnStaminaRatio / 1000) / levelCount)
  return returnStamina, remainLevelCount, costStamina, rewardReturnStamina
end

function ExplorationManager:GetLastEpReturnStamina()
  local stageCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Ep)
  if stageCfg == nil then
    return 0
  end
  local levelCount = self.__lastEpData.epMap.floor
  local curLevelIdx = self.__lastEpData.epMap.floorIdx
  local remainLevelCount = levelCount - (curLevelIdx + 1)
  if self.__lastEpData.epMap.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless and not PlayerDataCenter.infinityData:IsInfinityDungeonCompleted(stageCfg.dungeonId) then
    return 0, remainLevelCount, 0
  end
  local costStamina = stageCfg.cost_strength_num
  if costStamina == 0 or stageCfg.cost_strength_id ~= nil and stageCfg.cost_strength_id ~= ConstGlobalItem.SKey then
    return 0, remainLevelCount, costStamina, 0
  end
  local returnStamina = math.clamp(math.floor(costStamina - ConfigData.game_config.retreatDeductStamina), 0, costStamina)
  local rewardReturnStamina = math.floor(costStamina * (remainLevelCount + ConfigData.game_config.returnStaminaRatio / 1000) / levelCount)
  return returnStamina, remainLevelCount, costStamina, rewardReturnStamina
end

function ExplorationManager:HasNextLevel()
  return self:GetCurLevelIndex() < self:GetLevelCount() - 1
end

function ExplorationManager:GetLastEpHeroDataList()
  if self.__lastEpData == nil or self.__lastEpData.epRoleDyc == nil then
    return table.emptytable
  end
  local epRoleDyc = self.__lastEpData.epRoleDyc
  local heroDataList = {}
  local heroIdxDic = {}
  local HeroData = require("Game.PlayerData.Hero.HeroData")
  for uid, heroElem in pairs(self.__lastEpData.epRoleStc.heroes) do
    local heroTeamIndex = epRoleDyc.role.role[uid].dync.formationIdx
    local heroCfg = ConfigData.hero_data[heroElem.dataId]
    local heroData = HeroData.New({
      basic = {
        id = heroElem.dataId,
        level = heroElem.level,
        exp = 0,
        star = heroElem.rank,
        potentialLvl = heroElem.potential,
        ts = -1,
        career = heroCfg.career,
        company = heroCfg.camp,
        skinId = heroElem.skinId,
        cat = heroElem.cat,
        serverModel = epRoleDyc.role.role[uid].dync.texture,
        name = heroElem.name
      },
      spWeapon = heroElem.specWeapon,
      vow = {
        vowTime = heroElem.vowed and 1 or 0,
        name = heroElem.name
      }
    })
    
    function heroData.GetCoordination()
      return epRoleDyc.role.role[uid].dync.coordination
    end
    
    table.insert(heroDataList, heroData)
    heroIdxDic[heroData] = heroTeamIndex
  end
  table.sort(heroDataList, function(a, b)
    if heroIdxDic[a] ~= heroIdxDic[b] then
      return heroIdxDic[a] < heroIdxDic[b]
    end
    return a.dataId < b.dataId
  end)
  return heroDataList
end

function ExplorationManager:GetLastEpFairyData()
  if self.__lastEpData == nil or self.__lastEpData.epRoleStc == nil or self.__lastEpData.epRoleStc.fairy == nil then
    return nil
  end
  local DynFairyData = require("Game.Exploration.Data.DynFairyData")
  local dynFairyData = DynFairyData.GenDynFairyData(self.__lastEpData.epRoleStc.fairy)
  return dynFairyData
end

function ExplorationManager:GetLastEpChipList()
  if self.__lastEpData == nil or self.__lastEpData.epBackpack == nil or self.__lastEpData.epBackpack.algData == nil then
    return table.emptytable
  end
  local chipList = {}
  local algData = self.__lastEpData.epBackpack.algData
  for chipId, num in pairs(algData.alg) do
    local chipData = ChipData.New(chipId, num)
    table.insert(chipList, chipData)
  end
  for chipId, num in pairs(algData.tmpBuff) do
    local chipData = ChipData.New(chipId, num)
    table.insert(chipList, chipData)
  end
  table.sort(chipList, function(a, b)
    return a.dataId < b.dataId
  end)
  return chipList
end

function ExplorationManager:GetLastEpBuffInheritList()
  if self.__lastEpData == nil or self.__lastEpData.epBuff == nil then
    return table.emptytable
  end
  local initBuffIdDic = {}
  for k, buffId in ipairs(self.__lastEpData.epBuff.initBuffId) do
    initBuffIdDic[buffId] = true
  end
  local epBuffList = {}
  for groupId, buffGroup in pairs(self.__lastEpData.epBuff.data) do
    for _, buff in pairs(buffGroup.data) do
      if not initBuffIdDic[buff.id] then
        local epBuff = DynBuff.CreateByEpBuffId(buff.id)
        epBuff:InitDynEpBuffInfo(buff)
        table.insert(epBuffList, epBuff)
      end
    end
  end
  return epBuffList
end

function ExplorationManager:GetLastEpInfiniteCoe()
  if self.__lastEpData == nil or self.__lastEpData.epMap == nil then
    return 0
  end
  return self.__lastEpData.epMap.infiniteCoe
end

function ExplorationManager:GetLastEpChipNumLimit()
  if self.__lastEpData == nil or self.__lastEpData.epBackpack == nil then
    return 0
  end
  return self.__lastEpData.epBackpack.algUpperLimit
end

function ExplorationManager:TryGetEpEnv()
  local moduleId, dungeonId = self:GetCurModuleDungeonId()
  if moduleId == nil then
    return nil
  end
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_InfiniteMode then
    local envId = ConfigData.act_general_ep_env.actGenrEpEnvIdStageIdMap[dungeonId]
    local envDiffId = ConfigData.act_general_ep_env.actGenrEpEnvDiffStageIdMap[dungeonId]
    return envId, envDiffId, dungeonId
  end
  return nil
end

function ExplorationManager:HasEpSaveFormation()
  if ExplorationManager:IsEpInifinity() then
    return false
  end
  local envId = self:TryGetEpEnv()
  if envId == nil then
    return false
  end
  local envCfg = ConfigData.act_general_ep_env[envId]
  return envCfg.save_team > 0
end

function ExplorationManager:IsEpInifinity()
  local envId, envDiffId, dungeonId = self:TryGetEpEnv()
  if envId == nil then
    return false
  end
  local diffCfg = ConfigData.act_general_ep_difficulty[envDiffId]
  if diffCfg.infinite_score ~= nil and diffCfg.infinite_score ~= 0 then
    return true
  end
  return false
end

function ExplorationManager:IsEpInifinity4Act24()
  local moduleId, stageId = self:GetCurModuleDungeonId()
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_InfiniteMode then
    if ConfigData.reinforce_exploration_verify_exploration == nil then
      return false
    end
    for actId, levelCfgDic in pairs(ConfigData.reinforce_exploration_verify_exploration) do
      for levelStageId, levelCfg in pairs(levelCfgDic) do
        if stageId == levelStageId then
          return levelCfg.infinite_score ~= 0
        end
      end
    end
  end
  return false
end

function ExplorationManager:GetChipScoreId()
  if self:IsReinforceCardEp() then
    local mapData = self.epCtrl.mapData
    return mapData:GetReinforceChip()
  end
  local envId, envDiffId = self:TryGetEpEnv()
  if envId == nil then
    return 0
  end
  local envCfg = ConfigData.act_general_ep_env[envId]
  return envCfg.chip_score_id
end

function ExplorationManager:GetCurModuleDungeonId()
  local moduleId, dungeonId
  if self.moduleId == nil then
    if self.__lastEpData ~= nil then
      moduleId = self.__lastEpData.epMap.moduleId
      dungeonId = self.__lastEpData.epMap.dungeonId
    end
  else
    moduleId = self.moduleId
    dungeonId = self.dungeonId
  end
  return moduleId, dungeonId
end

function ExplorationManager:GetReinforceCardEpActId()
  if ConfigData.reinforce_exploration_continue_diff == nil then
    return
  end
  local moduleId, dungeonId = self:GetCurModuleDungeonId()
  if moduleId == nil then
    return
  end
  local actId = ConfigData.reinforce_exploration_continue_diff.rfEpStageIdDic[dungeonId]
  return actId
end

function ExplorationManager:IsReinforceCardEp()
  local actId = self:GetReinforceCardEpActId()
  return actId ~= nil
end

function ExplorationManager:HasEpRewardBag(isUncompleteEp)
  local moduleId, dungeonId
  if isUncompleteEp then
    if self.__lastEpData ~= nil then
      moduleId = self.__lastEpData.epMap.moduleId
      dungeonId = self.__lastEpData.epMap.dungeonId
    end
  else
    moduleId = self.moduleId
    dungeonId = self.dungeonId
  end
  if moduleId == nil then
    return false
  end
  local hasEpRewardBag = false
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local sectorStateCfg = ConfigData.sector_stage[dungeonId]
    if sectorStateCfg == nil then
      error("Can't find sectorStateCfg, id = " .. tostring(dungeonId))
      return
    end
    hasEpRewardBag = sectorStateCfg.hasShopDrop
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    local levelDic = ConfigData.endless.levelDic[dungeonId]
    local cfg = ConfigData.endless[levelDic.sectorId][levelDic.index]
    if cfg == nil then
      error("endlessCfg is null,endlessId:" .. tostring(dungeonId))
      return
    end
    hasEpRewardBag = cfg.hasShopDrop
  end
  return hasEpRewardBag
end

function ExplorationManager:WaitGetLastRoomEpRewardBag()
  local wait = self.__lastEpData ~= nil and self.__lastEpData.epMap ~= nil and ExplorationManager:HasEpRewardBag(true) and ExplorationManager.IsCompleteLastEpRoom(self.__lastEpData) and self:WaitGetLastEpRewardBag()
  return wait
end

function ExplorationManager:WaitGetLastEpRewardBag()
  local wait = self.__lastEpData ~= nil and self.__lastEpData.epStmGoods ~= nil and #self.__lastEpData.epStmGoods.stmStore > 0
  return wait
end

function ExplorationManager:SettleDataDeal(msg)
  if msg.Count < 1 then
    error("can't get msg arg0")
    return
  end
  local data = msg[0]
  if data.scoreShow ~= nil then
    local dungeonId = self.dungeonId
    if dungeonId == nil and self.__lastEpData ~= nil and self.__lastEpData.epMap ~= nil then
      dungeonId = self.__lastEpData.epMap.dungeonId
    end
    PlayerDataCenter.allWeeklyChallengeData:UpdateScoreInfo(dungeonId, data.scoreShow.score, data.scoreShow.reward)
  end
end

function ExplorationManager:GetDynPlayer()
  return self.dynPlayer
end

function ExplorationManager:GetEpDataCenter()
  return self.epDataCenter
end

function ExplorationManager:SetEpAfterEnterSceneExit()
  if self.epCtrl ~= nil then
    self.epCtrl:SetEpAfterEnterSceneExit()
  end
end

function ExplorationManager:GetEpFirstClearDic(stageId, moduleId)
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess then
    if PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
      return table.emptytable
    end
    local stageCfg = ConfigData.sector_stage[stageId]
    if stageCfg == nil then
      error("sector stage is null,id:" .. tostring(stageId))
      return table.emptytable
    end
    local dic = {}
    for k, itemId in ipairs(stageCfg.first_reward_ids) do
      dic[itemId] = stageCfg.first_reward_nums[k]
    end
    self:_AddActivityExRewards(stageCfg, dic)
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    local extraRewardIds, extraRewardNums = activityFrameCtrl:GetExtraSectorStageFirstReward(stageId)
    if extraRewardIds ~= nil then
      for i, itemId in pairs(extraRewardIds) do
        dic[itemId] = (dic[itemId] or 0) + extraRewardNums[i]
      end
    end
    return dic
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    if PlayerDataCenter.infinityData:IsInfinityDungeonCompleted(stageId) then
      return table.emptytable
    end
    local levelDic = ConfigData.endless.levelDic[stageId]
    if levelDic == nil then
      error("Cant get endless.levelDic, stageId = " .. tostring(stageId))
      return table.emptytable
    end
    local endlessCfg = ConfigData.endless[levelDic.sectorId][levelDic.index]
    local dic = {}
    for index, rewardId in ipairs(endlessCfg.clear_reward_itemIds) do
      dic[rewardId] = endlessCfg.clear_reward_itemNums[index]
    end
    return dic
  else
    error("Invalid moduleId:" .. tostring(moduleId))
    return table.emptytable
  end
end

local actExpandRewardsDic = {
  [ActivityFrameEnum.eActivityType.SectorI] = function(dic, stageCfg, actId)
    local _, data, inRuning = PlayerDataCenter.allActivitySectorIData:GetDataBySectorIdRunning(stageCfg.sector)
    local relationCfg = data:GetRelationStage(stageCfg.id)
    if relationCfg ~= nil and not PlayerDataCenter.sectorStage:IsStageComplete(relationCfg.id) then
      for k, itemId in ipairs(relationCfg.first_reward_ids) do
        dic[itemId] = (dic[itemId] or 0) + relationCfg.first_reward_nums[k]
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.Winter23] = function(dic, stageCfg, actId)
    local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    local activityData = win23Ctrl:GetWinter23DataByActId(actId)
    local relationCfg = activityData:GetRelationStage(stageCfg.id)
    if relationCfg ~= nil and relationCfg ~= nil and not PlayerDataCenter.sectorStage:IsStageComplete(relationCfg.id) then
      for k, itemId in ipairs(relationCfg.first_reward_ids) do
        dic[itemId] = (dic[itemId] or 0) + relationCfg.first_reward_nums[k]
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.ActivityCarnival23] = function(dic, stageCfg, actId)
    local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
    local activityData = carnival23Ctrl:GetCarnival23DataByActId(actId)
    local relationCfg = activityData:GetRelationStage(stageCfg.id)
    if relationCfg ~= nil and relationCfg ~= nil and not PlayerDataCenter.sectorStage:IsStageComplete(relationCfg.id) then
      for k, itemId in ipairs(relationCfg.first_reward_ids) do
        dic[itemId] = (dic[itemId] or 0) + relationCfg.first_reward_nums[k]
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.SteinsGate] = function(dic, stageCfg, actId)
    local sgCtrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
    local activityData = sgCtrl:GetSteinsGateDataByActId(actId)
    local storyData = activityData:GetSteinsGateStotyData()
    local bool, nodeData = storyData:Act23Gs_GetIsNodeStage(stageCfg.id)
    if bool then
      local Act23SteinsGateEnum = require("Game.Activity23SteinsGate.Data.Act23SteinsGateEnum")
      local _, diff = nodeData:Act23GSSN_GetIsHaveStageId(stageCfg.id)
      if diff == Act23SteinsGateEnum.eStoryDiff.Hard and not nodeData:Act23GSSN_GetIsClear(Act23SteinsGateEnum.eStoryDiff.Normal) then
        local rewardList = nodeData:Act23GSSN_GetExtrReward(diff)
        for _, cfg in ipairs(rewardList) do
          dic[cfg.id] = (dic[cfg.id] or 0) + cfg.num
        end
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.ActAnniversary24] = function(dic, stageCfg, actId)
    local anni24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
    local activityData = anni24Ctrl:GetActDataByActId(actId)
    local relationCfg = activityData:GetRelationStage(stageCfg.id)
    if relationCfg ~= nil and relationCfg ~= nil and not PlayerDataCenter.sectorStage:IsStageComplete(relationCfg.id) then
      for k, itemId in ipairs(relationCfg.first_reward_ids) do
        dic[itemId] = (dic[itemId] or 0) + relationCfg.first_reward_nums[k]
      end
    end
  end
}

function ExplorationManager:_AddActivityExRewards(stageCfg, dic)
  local actType, actId, actData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(stageCfg.sector)
  if actData and not actData:IsActivityRunningTimeout() and actExpandRewardsDic[actType] then
    actExpandRewardsDic[actType](dic, stageCfg, actId)
  end
end

function ExplorationManager:GetEpSceneBattleFieldSize(floorId)
  return ExplorationManager.__GetEpSceneBattleFieldSizeInternal(self.floorId)
end

function ExplorationManager.__GetEpSceneBattleFieldSizeInternal(floorId)
  local epCfg = ConfigData.exploration[floorId]
  if epCfg == nil then
    error("epCfg is null,floorId:" .. tostring(floorId))
    return
  end
  local sceneCfg = ConfigData.scene[epCfg.scene_id]
  if sceneCfg == nil then
    error("scene cfg is null,scene_id:" .. tostring(epCfg.scene_id))
    return
  end
  return sceneCfg.size_row, sceneCfg.size_col, sceneCfg.deploy_rows, sceneCfg.grid_scale_factor
end

local rewardTypeSortFunc = {
  [eItemType.Arithmetic] = function(a, b)
    if a.athData == nil then
      error("Cant get athData, itemId : " .. tostring(a.itemCfg.id))
      return nil
    end
    if b.athData == nil then
      error("Cant get athData, itemId : " .. tostring(b.itemCfg.id))
      return nil
    end
    local aSuitNum = a.athData:GetAthDataSuitNum()
    local bSuitNum = b.athData:GetAthDataSuitNum()
    if aSuitNum == bSuitNum then
      return nil
    end
    return aSuitNum > bSuitNum
  end
}

function ExplorationManager:RewardSort(rewardList)
  if rewardList == nil or #rewardList < 2 then
    return
  end
  local sortDic = {
    [eItemType.Resource] = -10,
    [eItemType.Arithmetic] = -9,
    [eItemType.LimitRes] = -8,
    [eItemType.GrowUp] = -7,
    [eItemType.FactoryRes] = -6
  }
  
  local function GetTypeSortId(typeId)
    local mappingId = sortDic[typeId]
    return mappingId ~= nil and mappingId or typeId
  end
  
  table.sort(rewardList, function(a, b)
    if a.price ~= nil and b.price ~= nil and a.price ~= b.price and (a.price == 0 or b.price == 0) then
      return a.price == 0
    end
    local aValue = a.itemCfg.quality
    local bValue = b.itemCfg.quality
    if aValue ~= bValue then
      return aValue > bValue
    end
    aValue = GetTypeSortId(a.itemCfg.type)
    bValue = GetTypeSortId(b.itemCfg.type)
    if aValue ~= bValue then
      return aValue < bValue
    end
    local typeSortFunc = rewardTypeSortFunc[a.itemCfg.type]
    if typeSortFunc ~= nil then
      local result = typeSortFunc(a, b)
      if result ~= nil then
        return result
      end
    end
    return a.itemCfg.id > b.itemCfg.id
  end)
end

function ExplorationManager:GetIsInWeeklyChallenge()
  return self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
end

function ExplorationManager:UpdateChipDataPreview()
  local dic = SectorStageDetailHelper.GetChipPreviewByEpModuleId(self.restartInfo.moduleId, self.restartInfo.epId)
  self.previewChipDataDic = {}
  self.previewChipDataList = {}
  for k, v in pairs(dic) do
    local level
    if type(v) == "number" then
      level = v
    end
    local chipData = ChipData.NewChipForLocal(k, level)
    table.insert(self.previewChipDataList, chipData)
    self.previewChipDataDic[k] = chipData
  end
  table.sort(self.previewChipDataList, function(a, b)
    local qualityA = a:GetQuality()
    local qualityB = b:GetQuality()
    return qualityA > qualityB
  end)
end

function ExplorationManager:GetChipDataPreview()
  if self.previewChipDataList == nil then
    error("previewChipDataList is nil")
    return table.emptytable
  end
  return self.previewChipDataList
end

function ExplorationManager:GetChipDataPreviewDic(withoutError)
  if self.previewChipDataDic == nil then
    if not withoutError then
      error("previewChipDataDic is nil")
    end
    return table.emptytable
  end
  return self.previewChipDataDic
end

function ExplorationManager:TryToGetCurrentLevelInfo()
  local infoData = {}
  local moduleId = self:GetEpModuleId()
  local stageCfg = self:GetSectorStageCfg()
  infoData.moduleId = moduleId
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    infoData.sector = stageCfg.sector
    infoData.num = stageCfg.num
    infoData.difficulty = stageCfg.difficulty
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    infoData.cfg = stageCfg.endlessCfg
    infoData.index = stageCfg.endlessCfg.index * 10
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
    infoData = nil
  end
  return infoData
end

function ExplorationManager:GetMonsterLevelCfgs()
  local monsterLevelCfgs
  local epModule = ExplorationManager:GetEpModuleId()
  if self:IsInTDExp() then
    monsterLevelCfgs = ConfigData.tower_data_monster_strength[epModule]
    if monsterLevelCfgs == nil then
      error("monster level cfg is null")
    end
    return monsterLevelCfgs
  end
  if epModule == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    monsterLevelCfgs = ConfigData.monster_level
    if monsterLevelCfgs == nil then
      error("monster level cfg is null")
      return
    end
  elseif epModule == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local sectorCfg = ExplorationManager:GetSectorStageCfg()
    if sectorCfg == nil then
      error("can't get sectorCfg")
      return
    end
    monsterLevelCfgs = sectorCfg.monster_level
    if monsterLevelCfgs == nil then
      error("monster level cfg is null")
      return
    end
  elseif epModule == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    local sectorCfg = ExplorationManager:GetSectorStageCfg()
    if sectorCfg == nil then
      error("can't get sectorCfg")
      return
    end
    local endlessCfg = sectorCfg.endlessCfg
    if endlessCfg == nil then
      error("can't get endlessCfg")
      return
    end
    monsterLevelCfgs = endlessCfg.monster_level
    if monsterLevelCfgs == nil then
      error("monster level cfg is null,level")
      return
    end
  end
  return monsterLevelCfgs
end

function ExplorationManager:TryGiveUpLastExploration(msg, stageCfg)
  local addMsg = msg
  if addMsg == nil and string.IsNullOrEmpty(addMsg) then
    addMsg = ""
  else
    addMsg = addMsg .. [[


]]
  end
  if self:HasEpRewardBag(true) then
    if self:WaitGetLastEpRewardBag() then
      if self:WaitGetLastRoomEpRewardBag() then
        cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(758), function()
          self:GiveUpLastExploration()
        end, nil)
        return
      end
      cs_MessageCommon.ShowMessageBox(addMsg .. ConfigData:GetTipContent(753), function()
        self:GiveUpLastExploration()
      end, nil)
      return
    end
    if self:GetIsLastEpDataQuitMode() then
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(758), function()
        self:PopEpQuickBattleReult()
      end, nil)
      return
    end
    cs_MessageCommon.ShowMessageBox(addMsg .. ConfigData:GetTipContent(752), function()
      self:GiveUpLastExploration()
    end, nil)
    return
  end
  local returnStamina = self:GetLastEpReturnStamina()
  local msg
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
  else
    msg = string.format(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), tostring(returnStamina))
  end
  msg = addMsg .. msg
  cs_MessageCommon.ShowMessageBox(msg, function()
    self:GiveUpLastExploration()
  end, nil)
end

function ExplorationManager:IsInExplorationTD()
  return self:IsInExploration() and self.epCtrl ~= nil and self.epCtrl.mapData:IsEpTD()
end

function ExplorationManager:IsInExplorationLight()
  return self:IsInExploration() and self.epCtrl ~= nil and self.epCtrl.mapData:IsEpLight()
end

function ExplorationManager:HasRoomSceneInEp()
  return self:IsInExploration() and self.epCtrl ~= nil and self.epCtrl.mapData:IsEpDefault()
end

function ExplorationManager:GetChipSuitMaxLevelDic()
  if self.dynPlayer ~= nil then
    local chipSuitList = self.dynPlayer:GetChipSuitSortList()
    if chipSuitList == nil then
      return false, nil
    end
    local levelDic = {}
    for _, dynChipSuit in ipairs(chipSuitList) do
      local level = dynChipSuit:GetActivatedAffixCount()
      if 0 < level then
        levelDic[dynChipSuit.tagId] = level
      end
    end
    return true, levelDic
  elseif self.__lastEpData ~= nil then
    if self.__lastEpData.epBackpack == nil or self.__lastEpData.epBackpack.algData == nil or self.__lastEpData.epBackpack.algData.alg == nil then
      return false, nil
    end
    local chipSuitCountDic = {}
    local chipIdDic = self.__lastEpData.epBackpack.algData.alg
    for chipId, _ in pairs(chipIdDic) do
      local chipCfg = ConfigData.chip[chipId]
      if chipCfg ~= nil and chipCfg.fun_tag ~= 0 then
        local suitId = chipCfg.fun_tag
        local suitCount = chipSuitCountDic[suitId] or 0
        chipSuitCountDic[suitId] = suitCount + 1
      end
    end
    local levelDic = {}
    for suitId, count in pairs(chipSuitCountDic) do
      local suitCfg = ConfigData.chip_tag.tag_suits[suitId]
      if suitCfg ~= nil and #suitCfg ~= 0 then
        local level = 0
        for _, cfg in ipairs(suitCfg) do
          if count >= cfg.number then
            level = level + 1
          end
        end
        if 0 < level then
          levelDic[suitId] = level
        end
      end
    end
    return true, levelDic
  end
  return false, nil
end

function ExplorationManager:GetSectorHeadTexture(sectorId, challengeId, detailType, resloader)
  local path
  if challengeId ~= nil then
    if detailType == SectorLevelDetailEnum.eDetailType.Stage then
      local stageCfg = ConfigData.sector_stage[challengeId]
      if stageCfg ~= nil then
        path = stageCfg.special_pic
      end
    elseif detailType == SectorLevelDetailEnum.eDetailType.Avg then
      local avgCfg = ConfigData.story_avg[challengeId]
      if avgCfg ~= nil then
        path = avgCfg.special_pic
      end
    elseif detailType == SectorLevelDetailEnum.eDetailType.PeriodicChallenge then
      local challengeCfg = ConfigData.daily_challenge[challengeId]
      if challengeCfg ~= nil then
        path = challengeCfg.pic_small
      end
    elseif detailType == SectorLevelDetailEnum.eDetailType.WeeklyChallenge then
      local challengeCfg = ConfigData.weekly_challenge[challengeId]
      if challengeCfg ~= nil then
        path = challengeCfg.pic_small
      end
    end
  end
  if sectorId ~= nil and string.IsNullOrEmpty(path) then
    local sectorCfg = ConfigData.sector[sectorId]
    if sectorCfg ~= nil then
      path = sectorCfg.pic_small
    end
  end
  if string.IsNullOrEmpty(path) then
    return
  end
  return resloader:LoadABAsset(PathConsts:GetSectorBackgroundPath(path))
end

function ExplorationManager:GetEpGuideActionList(roomX, moment)
  local epId = self:GetCurExplorationId()
  local epGuideCfg = ConfigData.exploration_guide[epId]
  if epGuideCfg ~= nil and epGuideCfg[roomX] ~= nil then
    local roomGuideCfg = epGuideCfg[roomX]
    local actionList = roomGuideCfg[moment]
    return actionList
  end
  return nil
end

function ExplorationManager:HasEpGuideActionList(roomX)
  local epId = self:GetCurExplorationId()
  local epGuideCfg = ConfigData.exploration_guide[epId]
  if epGuideCfg ~= nil and epGuideCfg[roomX] ~= nil then
    local roomGuideCfg = epGuideCfg[roomX]
    if roomGuideCfg ~= nil and table.count(roomGuideCfg) > 0 then
      return true
    end
  end
  return false
end

function ExplorationManager:ForceExitEp(returnTargetSceneName)
  if self:IsInExplorationAndScene() then
    self:ExitExploration(returnTargetSceneName)
    if Time.unity_time.timeScale ~= 1 then
      Time.unity_time.timeScale = 1
    end
  else
    self:SetEpAfterEnterSceneExit()
  end
end

function ExplorationManager:_TryGetStageBgmCfg()
  if self.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local sectorStateCfg = ConfigData.sector_stage[self.dungeonId]
    if sectorStateCfg == nil then
      error("Can't find sectorStateCfg, id = " .. tostring(self.dungeonId))
      return
    end
    if sectorStateCfg.stage_bgm_id ~= 0 then
      local stageBgmCfg = ConfigData.sector_stage_bgm[sectorStateCfg.stage_bgm_id]
      return stageBgmCfg
    end
  end
end

function ExplorationManager:PlayEpAuBgm()
  local stageBgmCfg = self:_TryGetStageBgmCfg()
  if stageBgmCfg ~= nil then
    AudioManager:PlayAudioById(stageBgmCfg.bgm_id)
    return
  end
  if self.epCtrl == nil or self.epCtrl.mapData == nil then
    return
  end
  local sceneCfg = self.epCtrl.mapData:GetEpSceneCfg()
  AudioManager:PlayAudioById(sceneCfg.audio_id)
end

function ExplorationManager:PlayEpAuSelctRoomSelect()
  local stageBgmCfg = self:_TryGetStageBgmCfg()
  if stageBgmCfg ~= nil and not string.IsNullOrEmpty(stageBgmCfg.selector) then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, stageBgmCfg.selector, stageBgmCfg.label_lv_select)
    return
  end
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.roomSelect)
end

function ExplorationManager:PlayEpAuSelctNormalCombat()
  local stageBgmCfg = self:_TryGetStageBgmCfg()
  if stageBgmCfg ~= nil and not string.IsNullOrEmpty(stageBgmCfg.selector) then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, stageBgmCfg.selector, stageBgmCfg.label_normal_combat)
    return
  end
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.normalCombat)
end

function ExplorationManager:PlayEpAuSelctBossCombat()
  local stageBgmCfg = self:_TryGetStageBgmCfg()
  if stageBgmCfg ~= nil and not string.IsNullOrEmpty(stageBgmCfg.selector) then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, stageBgmCfg.selector, stageBgmCfg.label_boss_combat)
    return
  end
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.bossCombat)
end

function ExplorationManager:PlayMVPVoice(heroId)
  local voiceId = 0
  if heroId == self._lastMvpVoiceHeroId then
    voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.MVP, self._lastVoiceId, heroId)
  else
    voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.MVP, nil, heroId)
  end
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvCtr:PlayCv(heroId, voiceId)
  self._lastMvpVoiceHeroId = heroId
  self._lastVoiceId = voiceId
end

function ExplorationManager:AddEpNewEpBuffSelect(sectorId, buffList)
  if self._sectorNewEpBuffDic == nil then
    self._sectorNewEpBuffDic = {}
  end
  self._sectorNewEpBuffDic[sectorId] = buffList
end

function ExplorationManager:GetEpNewEpBuffSelect(sectorId)
  if self._sectorNewEpBuffDic == nil then
    return false
  end
  local buffList = self._sectorNewEpBuffDic[sectorId]
  return buffList ~= nil, buffList
end

function ExplorationManager:RemoveEpNewEpBuffSelect(sectorId)
  if self._sectorNewEpBuffDic == nil then
    return false
  end
  self._sectorNewEpBuffDic[sectorId] = nil
end

local function ReFunc(isRe, bool)
  if isRe then
    bool = not bool
  end
  return bool
end

local function positiveFunc(a, b, invert, chipSuitDic)
  local aHasSuit = a:TryGetSuitCfg() ~= nil
  local bHasSuit = b:TryGetSuitCfg() ~= nil
  if aHasSuit and bHasSuit then
    local aSuitCfg = a:TryGetSuitCfg()
    local bSuitCfg = b:TryGetSuitCfg()
    local aChipSuit = chipSuitDic[aSuitCfg.id]
    local bChipSuit = chipSuitDic[bSuitCfg.id]
    local aCount = aChipSuit ~= nil and aChipSuit:GetChipSuitCount() or 0
    local bCount = bChipSuit ~= nil and bChipSuit:GetChipSuitCount() or 0
    if aCount ~= bCount then
      return ReFunc(invert, aCount > bCount)
    end
    local aQty = aChipSuit ~= nil and aChipSuit:GetTotalQty() or 0
    local bQty = bChipSuit ~= nil and bChipSuit:GetTotalQty() or 0
    if aQty ~= bQty then
      return ReFunc(invert, aQty > bQty)
    end
    if aSuitCfg.id ~= bSuitCfg.id then
      return aSuitCfg.id < bSuitCfg.id
    end
  elseif aHasSuit then
    return ReFunc(invert, true)
  elseif bHasSuit then
    return ReFunc(invert, false)
  end
  local aQty = a:GetQuality()
  local bQty = b:GetQuality()
  if aQty ~= bQty then
    return ReFunc(invert, aQty > bQty)
  end
  return a.dataId < b.dataId
end

function ExplorationManager:SortChipDataList(chipDataList, isInvert)
  local DynChipSuitMgr = require("Game.Exploration.Data.ChipSuit.DynChipSuitMgr")
  local chipSuitDic = DynChipSuitMgr.CreateSuitWithChips(chipDataList)
  table.sort(chipDataList, function(a, b)
    return positiveFunc(a, b, isInvert, chipSuitDic)
  end)
  return chipDataList
end

function ExplorationManager.IsCarnivalEp(stageId)
  return ConfigData.activity_carnival_env.stageEnvMapping[stageId] ~= nil
end

function ExplorationManager:IsInEnteringRoom()
  local dynPlayer = ExplorationManager:GetDynPlayer()
  if dynPlayer ~= nil then
    return dynPlayer.playerClientState == ExplorationEnum.ePlayerClientState.Entering
  end
  return false
end

function ExplorationManager:GetChipScoreInfiniteCore()
  local infiniteCore = 0
  if self.chipScoreInfiniteCore == nil then
    if self.__lastEpData ~= nil then
      infiniteCore = self.__lastEpData.epMap.infiniteCore
    end
  else
    infiniteCore = self.chipScoreInfiniteCore
  end
  return infiniteCore or 0
end

function ExplorationManager:GetChipScoreInBattle()
  local dynPlayer = ExplorationManager:GetDynPlayer()
  if dynPlayer ~= nil then
    dynPlayer:UpdateChipValidRoleList()
    return self:GetChipScore(dynPlayer.chipList, dynPlayer:GetChipSuitSortList(), dynPlayer:GetEpBuffWithOutInitBuff(), dynPlayer:GetDeployHeroCount())
  end
  return 0, table.emptytable, 0
end

function ExplorationManager:GetChipScoreByLastData()
  local lastEpData = self:GetLastEpData()
  if lastEpData == nil then
    return 0, table.emptytable, 0
  end
  local buffList = self:GetLastEpBuffInheritList()
  local chipList = self:GetLastEpChipList()
  local chipSuitList = table.emptytable
  local deployCount = 0
  if chipList ~= nil then
    local DynSpecEffectMgr = require("Game.Exploration.Data.SpecEffect.DynSpecEffectMgr")
    local specEffectMgr = DynSpecEffectMgr.New()
    specEffectMgr:InitSpecEffect(lastEpData.epEffect)
    local DynHero = require("Game.Exploration.Data.DynHero")
    local heroDataList = self:GetLastEpHeroDataList()
    local heroList = {}
    local benchX = ConfigData.buildinConfig.BenchX
    for k, v in ipairs(heroDataList) do
      local hero = DynHero.New(v)
      hero:SetCoord(v:GetCoordination(), benchX)
      table.insert(heroList, hero)
      if not hero:IsBench() then
        deployCount = deployCount + 1
      end
    end
    for k, chipData in pairs(chipList) do
      local validCharacters = chipData:GetValidRoleList(heroList, eBattleRoleBelong.player, specEffectMgr)
    end
    local DynChipSuitMgr = require("Game.Exploration.Data.ChipSuit.DynChipSuitMgr")
    local suitMgr = DynChipSuitMgr.New()
    chipSuitList = suitMgr:ExecuteAllSuitChipForListOutBattle(chipList, heroList, specEffectMgr) or table.emptytable
  end
  return self:GetChipScore(chipList, chipSuitList, buffList, deployCount)
end

function ExplorationManager:GetChipScore(chipList, chipSuitList, epBuffList, heroCount)
  local eShowType = SectorLevelDetailEnum.eScoreShowType
  local scoeDic = {}
  for k, v in pairs(eShowType) do
    scoeDic[v] = {}
  end
  local isRefinforce = ExplorationManager:IsReinforceCardEp()
  local chipScoreId = ExplorationManager:GetChipScoreId()
  local chipScoreCfg
  if isRefinforce then
    chipScoreCfg = ConfigData.reinforce_card_chip_score[chipScoreId]
  else
    chipScoreCfg = ConfigData.act_general_ep_chip_score[chipScoreId]
  end
  if chipScoreCfg == nil then
    return 0, table.emptytable, 0, nil
  end
  local isCalRoleCount = true
  if isRefinforce then
    isCalRoleCount = false
  end
  for k, chipData in pairs(chipList) do
    local vaildRoleCount = 0
    if chipData:IsValidDynPlayer() and not chipData:IsConsumeSkillChip() then
      vaildRoleCount = heroCount
    else
      vaildRoleCount = chipData:GetVaildRoleCountWithOutBench()
    end
    if isCalRoleCount == false then
      vaildRoleCount = 1
    end
    if vaildRoleCount ~= 0 then
      local count = chipData:GetCount()
      if scoeDic[eShowType.NormalChip][count] == nil then
        scoeDic[eShowType.NormalChip][count] = 0
      end
      scoeDic[eShowType.NormalChip][count] = scoeDic[eShowType.NormalChip][count] + vaildRoleCount
    end
  end
  for k, v in ipairs(chipSuitList) do
    local suitCount = v:GetChipSuitCount()
    if not (suitCount < 2) then
      local suitLevel = v:GetSuitLevel()
      for level, chipData in pairs(suitLevel) do
        local vaildRoleCount = chipData:GetVaildRoleCountWithOutBench()
        if isCalRoleCount == false then
          vaildRoleCount = 1
        end
        if scoeDic[eShowType.ChipSuit][level] == nil then
          scoeDic[eShowType.ChipSuit][level] = 0
        end
        scoeDic[eShowType.ChipSuit][level] = scoeDic[eShowType.ChipSuit][level] + vaildRoleCount
      end
    end
  end
  for i, v in ipairs(epBuffList) do
    if v.epBuffCfg.is_listshow then
      local buffType = v.epBuffCfg.buff_type
      if buffType ~= 2 then
        if buffType == 1 then
          if scoeDic[eShowType.PositiveBuff][0] == nil then
            scoeDic[eShowType.PositiveBuff][0] = 0
          end
          scoeDic[eShowType.PositiveBuff][0] = scoeDic[eShowType.PositiveBuff][0] + 1
        else
          if scoeDic[eShowType.NeutralBuff][0] == nil then
            scoeDic[eShowType.NeutralBuff][0] = 0
          end
          scoeDic[eShowType.NeutralBuff][0] = scoeDic[eShowType.NeutralBuff][0] + 1
        end
      end
    end
  end
  local infiniteCore = self:GetChipScoreInfiniteCore()
  local totalScore = 0
  for showType, v1 in pairs(scoeDic) do
    for level, num in pairs(v1) do
      if chipScoreCfg[showType] ~= nil and chipScoreCfg[showType][level] ~= nil then
        local baseScore = chipScoreCfg[showType][level].base_score
        if baseScore ~= nil and baseScore ~= 0 then
          local score = math.floor(num * baseScore * (100 + infiniteCore) / 100)
          scoeDic[showType][level] = score
          totalScore = score + totalScore
        end
      end
    end
  end
  return totalScore, scoeDic, infiniteCore, isRefinforce
end

ExplorationManager:ctor()
