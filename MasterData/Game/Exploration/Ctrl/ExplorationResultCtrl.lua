local ExplorationResultCtrl = class("ExplorationResultCtrl")
local EpMvpData = require("Game.Exploration.Data.EpMvpData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function ExplorationResultCtrl:ctor()
  self.epCtrl = ExplorationManager.epCtrl
  self.sectorId = nil
  self.__TryFormationSave = BindCallback(self, self._TryFormationSave)
  self.__TryReinforceSave = BindCallback(self, self._TryReinforceSave)
  self.__TryOpenStore = BindCallback(self, self._TryOpenStore)
  self.__ReqSettle = BindCallback(self, self._ReqSettle)
  self.__TryOpenStoreReward = BindCallback(self, self._TryOpenStoreReward)
  self.__TryOpenScore = BindCallback(self, self._TryOpenScore)
  self.__TryOpenResult = BindCallback(self, self._TryOpenResult)
  self.__ExitExplorationAndContinueProcess = BindCallback(self, self.ExitExplorationAndContinueProcess)
  self.__ContinueProcessEpExitAfter = BindCallback(self, self._ContinueProcessEpExitAfter)
  self.processTable_InEp = {
    self.__TryFormationSave,
    self.__TryReinforceSave,
    self.__TryOpenStore,
    self.__ReqSettle,
    self.__TryOpenScore,
    self.__TryOpenResult,
    self.__ExitExplorationAndContinueProcess
  }
  self.processTable_InEpNoEffect = {
    self.__ReqSettle,
    self.__ExitExplorationAndContinueProcess
  }
  self.processTable_OutEp = {
    self.__TryFormationSave,
    self.__TryReinforceSave,
    self.__TryOpenStore,
    self.__ReqSettle,
    self.__TryOpenStoreReward,
    self.__ContinueProcessEpExitAfter
  }
  self.processTable_EditorAutoNextEp = {
    self.__ReqSettle,
    function()
      local function endFunc()
        self.__ExitExplorationAndContinueProcess()
      end
      
      ExplorationManager:EditorTryNextEp(endFunc)
    end
  }
end

function ExplorationResultCtrl:EnterResultProcess(isWin, isInEp, battleEndClearCallback)
  if ExplorationManager.epCtrl ~= nil then
    ExplorationManager.epCtrl.autoCtrl:CloseAutoMode()
  end
  self.battleEndClearCallback = battleEndClearCallback
  self.isWin = isWin
  self.isInEp = isInEp
  self.storeRewardDic = nil
  self.pickInfo = nil
  self.resultMsg = nil
  self.firstRewardDic = nil
  self.normalRewardDic = nil
  self.fixRewardDic = nil
  self:CloseBattleUI()
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  if stageCfg ~= nil and stageCfg.isHideEndShop == 1 then
    self.processTable = self.isInEp and self.processTable_InEpNoEffect or self.processTable_OutEp
  else
    self.processTable = self.isInEp and self.processTable_InEp or self.processTable_OutEp
  end
  if ExplorationManager:EnableEpAutoNextStage() then
    self.processTable = self.processTable_EditorAutoNextEp
  end
  self:_ContinueNextStep(true)
end

function ExplorationResultCtrl:ExitExplorationAndContinueProcess(SceneName, loadMainCallback)
  self:ExecuteBattleEndClear()
  ExplorationManager:ExitExploration(SceneName, loadMainCallback, self.isWin, self.__ContinueProcessEpExitAfter)
end

function ExplorationResultCtrl:ExecuteBattleEndClear()
  if self.isExecutedBattleEndClear then
    return
  end
  self.isExecutedBattleEndClear = true
  if self.battleEndClearCallback ~= nil then
    self.battleEndClearCallback()
  end
end

function ExplorationResultCtrl:CloseBattleUI()
  UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
  UIManager:HideWindow(UIWindowTypeID.Exploration)
  UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
  UIManager:HideWindow(UIWindowTypeID.BattlePause)
  UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
end

function ExplorationResultCtrl:_TryFormationSave()
  if not ExplorationManager:HasEpSaveFormation() then
    self:_ContinueNextStep()
    return
  end
  local envId, envDiffId, sectorStageId = ExplorationManager:TryGetEpEnv()
  local heroDataList, dynFairyData, chipList, buffList, infiniteCoe, score, chipNumLimit
  local dynPlayer = ExplorationManager:GetDynPlayer()
  if dynPlayer then
    dynFairyData = dynPlayer:GetDynFairyData()
    chipList = dynPlayer:GetChipList()
    buffList = dynPlayer:GetEpBuffListFromEp()
    heroDataList = {}
    for k, dynHero in ipairs(dynPlayer.heroList) do
      heroDataList[k] = dynHero.heroData
    end
    infiniteCoe = ExplorationManager.epCtrl.mapData:GetEpInfiniteCoe()
    score = ExplorationManager:GetChipScoreInBattle()
    chipNumLimit = dynPlayer:GetChipDiscardLimit()
  else
    heroDataList = ExplorationManager:GetLastEpHeroDataList()
    dynFairyData = ExplorationManager:GetLastEpFairyData()
    chipList = ExplorationManager:GetLastEpChipList()
    buffList = ExplorationManager:GetLastEpBuffInheritList()
    infiniteCoe = ExplorationManager:GetLastEpInfiniteCoe()
    score = ExplorationManager:GetChipScoreByLastData()
    chipNumLimit = ExplorationManager:GetLastEpChipNumLimit()
  end
  local EpFormationSaveData = require("Game.Exploration.UI.FormationSave.Data.EpFormationSaveData")
  local fmtSaveData = EpFormationSaveData.CreateFmtSvData(heroDataList, dynFairyData, buffList, chipList, sectorStageId, infiniteCoe, score)
  fmtSaveData:SetFmtSaveDataEpIsWin(self.isWin)
  fmtSaveData:SetFmtSvChipNumLimit(chipNumLimit)
  UIManager:ShowWindowAsync(UIWindowTypeID.FormationSave, function(win)
    if win == nil then
      return
    end
    win:InitFormationSave(fmtSaveData)
    win:SetFormationSaveCloseFunc(function()
      self:_ContinueNextStep()
    end)
  end)
end

function ExplorationResultCtrl:_TryReinforceSave()
  if not ExplorationManager:IsReinforceCardEp() then
    self:_ContinueNextStep()
    return
  end
  local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")
  local actFrameId = ExplorationManager:GetReinforceCardEpActId()
  local rfCdDataAll = ReinforceUtil.GetRfDataAllByActFrameId(actFrameId)
  local cardDic = rfCdDataAll:GetRfFactorCardDataDic()
  
  local function showWinFunc(objList)
    if objList.Count == 0 then
      error("objList.Count == 0")
    end
    local msg = objList[0]
    if msg.factorCard == nil then
      self:_ContinueNextStep()
      return
    end
    local ReinforceCardDataFactor = require("Game.Reinforce.Data.ReinforceCardDataFactor")
    local cardData = ReinforceCardDataFactor.New()
    cardData:InitRfCardDataFac(msg.factorCard)
    cardData:SetRfCdFactorOrder(nil)
    UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardSave, function(win)
      if win == nil then
        return
      end
      win:InitReinforceCardSave(cardData, cardDic, rfCdDataAll, function()
        self:_ContinueNextStep()
      end)
    end)
  end
  
  local curRoomPos = ExplorationManager:GetEpCurRoomPostion()
  NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_Quest_Reinforce_Over(curRoomPos, showWinFunc)
end

function ExplorationResultCtrl:_TryOpenStore()
  local epBagDropList = ExplorationManager:GetStoreData()
  local hasBagDrop = epBagDropList ~= nil and 0 < #epBagDropList
  if not hasBagDrop then
    self:_ContinueNextStep()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardBag, function(window)
    if window == nil then
      return
    end
    local stageCfg, epModuleId, stageId
    if self.isInEp then
      stageCfg = ExplorationManager:GetSectorStageCfg()
      epModuleId = ExplorationManager:GetEpModuleId()
      stageId = ExplorationManager:GetEpDungeonId()
    else
      stageCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Ep)
      _, stageId, epModuleId, _ = ExplorationManager:HasUncompletedEp()
    end
    local firstClearRewards = self.isWin and ExplorationManager:GetEpFirstClearDic(stageId, epModuleId) or table.emptytable
    window:InitEpRewardBag(epBagDropList, stageCfg, self.isInEp, firstClearRewards, true, epModuleId, stageId)
    if self.mapCtrl ~= nil then
      self.mapCtrl:HideMapCavasWithoutBg()
    end
    window:SetEpRewardBagCloseFunc(function(rewardDic, pickInfo)
      UIUtil.PopFromBackStackByUiTab(self)
      window:Delete()
      self.storeRewardDic = rewardDic
      self.pickInfo = pickInfo
      self:_ContinueNextStep()
    end)
  end)
end

function ExplorationResultCtrl:_ReqFailRewardShowAndShow()
  if self.isWin then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  network:CS_EXPLORATION_RewardsShow(function(dataList)
    local msgData
    if dataList.Count > 0 then
      msgData = dataList[0]
    else
      msgData = {}
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
      if window == nil then
        return
      end
      window:FailExploration(clearAction, msgData.rewards, msgData.backStm)
      window:SetReturnCallback(function()
        self:_ContinueNextStep()
      end)
    end)
  end)
end

function ExplorationResultCtrl:_ReqSettle()
  local position
  local isAutoSettle = false
  local isGiveUpLastEp = false
  local costumeStm = false
  local mvpHeroId = 0
  local refreshLastEp
  local _, suitLevelMap = ExplorationManager:GetChipSuitMaxLevelDic()
  local epNormalStageId
  if self.isInEp then
    local moduleId = ExplorationManager:GetEpModuleId()
    position = ExplorationManager:GetDynPlayer():GetOperatorDetail().curPostion
    mvpHeroId = ExplorationManager.epMvpData ~= nil and ExplorationManager.epMvpData:GetBossFightMvp(true) or ExplorationManager:GetDynPlayer().heroList[1].uid
    local sectorCfg = ExplorationManager:GetSectorCfg()
    if sectorCfg ~= nil then
      self.sectorId = sectorCfg.id
      local stageCfg = ExplorationManager:GetSectorStageCfg()
      if stageCfg ~= nil and moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
        epNormalStageId = stageCfg.id
      end
    end
  elseif ExplorationManager:GetIsLastEpDataQuitMode() then
    ExplorationManager:PopEpQuickBattleReult()
    return
  else
    local lastEpData = ExplorationManager:GetLastEpData()
    position = lastEpData.epOp.curPostion
    local moduleId = lastEpData.epMap.moduleId
    local mapData = EpMvpData.New(lastEpData.epRoleStc.heroes)
    mapData:AddServerSaveData(lastEpData.epStc.record)
    mvpHeroId = mapData:GetBossFightMvp(true)
    isGiveUpLastEp = true
    local sectorStageCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Ep)
    if sectorStageCfg ~= nil then
      self.sectorId = sectorStageCfg.sector
      if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
        epNormalStageId = sectorStageCfg.id
      end
    end
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  local heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  self:CalEpTransDic()
  network:CS_EXPLORATION_Settle(position, isAutoSettle, isGiveUpLastEp, costumeStm, mvpHeroId, self.pickInfo, refreshLastEp, suitLevelMap, function(msg)
    self.resultMsg = msg
    if isGiveUpLastEp then
      MsgCenter:Broadcast(eMsgEventId.GiveUncompleteExploration)
    end
    self:_RewardSplit(epNormalStageId, heroIdSnapShoot)
    self:_ContinueNextStep()
    ExplorationManager:SettleDataDeal(msg)
  end)
end

function ExplorationResultCtrl:CalEpTransDic()
  local stageCfg
  if self.isInEp then
    stageCfg = ExplorationManager:GetSectorStageCfg()
  else
    stageCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Ep)
  end
  if not stageCfg then
    return
  end
  if stageCfg.challengeCfg then
    return
  end
  local rewardIds = {}
  local rewardNums = {}
  local rewardDic = {}
  if stageCfg.endlessCfg then
    for index, id in pairs(stageCfg.endlessCfg.clear_reward_itemIds) do
      rewardDic[id] = (rewardDic[id] or 0) + stageCfg.endlessCfg.clear_reward_itemNums[index]
    end
  else
    for index, id in pairs(stageCfg.first_reward_ids) do
      rewardDic[id] = (rewardDic[id] or 0) + stageCfg.first_reward_nums[index]
    end
    for index, id in pairs(stageCfg.reward_ids) do
      rewardDic[id] = (rewardDic[id] or 0) + stageCfg.reward_nums[index]
    end
  end
  for id, num in pairs(rewardDic) do
    table.insert(rewardIds, id)
    table.insert(rewardNums, num)
  end
  local crTransDic = PlayerDataCenter:CalCrItemTransDic(rewardIds, rewardNums)
  self.crTransDic = crTransDic
end

function ExplorationResultCtrl:_TryOpenScore()
  if ExplorationManager:GetIsInWeeklyChallenge() then
    self:_TryOpenWeeklyChallgeScore()
  elseif ExplorationManager:IsInBrotatoExp() then
    self:_TryOpenBrotatoScore()
  else
    self:_ContinueNextStep()
    return
  end
end

function ExplorationResultCtrl:_TryOpenWeeklyChallgeScore()
  if self.resultMsg == nil or self.resultMsg.Count < 1 then
    error("can't get msg arg0")
    self:_ContinueNextStep()
    return
  end
  local data = self.resultMsg[0]
  if data.scoreShow ~= nil then
    ExplorationManager:GetDynPlayer():SetWeekExtrReward(PlayerDataCenter.allWeeklyChallengeData.ConvetTypeReward2RewadDic(data.scoreShow.reward))
    ExplorationManager:GetDynPlayer().weekExtrIsDouble = data.scoreShow.double
    if self.isWin then
      NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_WEEKLYCHALLENGE_Detail()
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.WCDebuffResult, function(win)
    if win ~= nil then
      local resultWin = UIManager:GetWindow(UIWindowTypeID.ExplorationResult)
      if resultWin ~= nil then
        resultWin:Hide()
      end
      win:InitWCDebuffResult(data.scoreShow, self.isWin, function()
        self:_ContinueNextStep()
      end)
      if ExplorationManager.epCtrl ~= nil and ExplorationManager.epCtrl.mapCtrl ~= nil then
        ExplorationManager.epCtrl.mapCtrl:HideMapCavasWithoutBg()
      end
    else
      self:_ContinueNextStep()
    end
  end)
end

function ExplorationResultCtrl:_TryOpenBrotatoScore()
  if self.resultMsg == nil or self.resultMsg.Count < 1 then
    error("can't get msg arg0")
    self:_ContinueNextStep()
    return
  end
  local data = self.resultMsg[0]
  UIManager:ShowWindowAsync(UIWindowTypeID.UIBrotatoResult, function(win)
    if win ~= nil then
      win:InitBrotatoResult(data.scoreShow, self.isWin, function()
        self:_ContinueNextStep()
      end)
      win:ShowFirstGetReward(data.firstClearRewards, data.overflowRewardTurnInfo)
    else
      self:_ContinueNextStep()
    end
  end)
end

function ExplorationResultCtrl:_TryOpenStoreReward()
  if self.normalRewardDic == nil or table.count(self.normalRewardDic) == 0 then
    self:_ContinueNextStep()
    return
  end
  local data
  if self.resultMsg == nil or self.resultMsg.Count < 1 then
    data = {}
  else
    data = self.resultMsg[0]
  end
  
  local function ShowWinFunc(window)
    local CRData = CommonRewardData.CreateCRDataUseDic(self.normalRewardDic):SetCRItemCustomTransDic(data.overflowRewardTurnInfo):SetCRShowOverFunc(function()
      self:_ContinueNextStep()
    end)
    window:AddAndTryShowReward(CRData)
  end
  
  local rewardWin = UIManager:GetWindow(UIWindowTypeID.CommonReward)
  if rewardWin ~= nil then
    ShowWinFunc(rewardWin)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      ShowWinFunc(window)
    end)
  end
end

function ExplorationResultCtrl:_TryOpenResult()
  PlayerDataCenter.cacheSaveData:SetIsEndBattleForHeroInteration(true)
  if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    self:_ContinueNextStep()
    return
  end
  if ExplorationManager:IsInBrotatoExp() then
    self:_ContinueNextStep()
    return
  end
  local data
  if self.resultMsg == nil or self.resultMsg.Count < 1 then
    data = {}
  else
    data = self.resultMsg[0]
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
    if window == nil then
      return
    end
    if self.isWin then
      local epModuleId = ExplorationManager:GetEpModuleId()
      local stageId = ExplorationManager:GetEpDungeonId()
      local resultSettlementData
      if ExplorationManager.epCtrl ~= nil then
        resultSettlementData = ExplorationManager.epCtrl.dynPlayer:SetResultSettlementData()
      end
      window:SetCRTransDic(self.crTransDic)
      if data.rewards ~= nil then
        window:EpResultOverFlowInfo(data.overflowRewardTurnInfo)
      end
      window:CompleteExploration(data.rewards, self.firstRewardDic, nil, resultSettlementData, self.normalRewardDic, self.fixRewardDic)
    else
      if data.rewards ~= nil then
        window:EpResultOverFlowInfo(data.overflowRewardTurnInfo)
      end
      window:FailExploration(data.rewards, self.normalRewardDic, data.backStm)
    end
    window:SetReturnCallback(function()
      UIManager:DeleteWindow(UIWindowTypeID.ExplorationResult, true)
      self:_ContinueNextStep()
    end)
  end)
end

function ExplorationResultCtrl:_ContinueProcessEpExitAfter()
  local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
  if aftertTeatmentCtrl ~= nil then
    aftertTeatmentCtrl:TeatmentBengin()
  end
end

function ExplorationResultCtrl:_RewardSplit(epNormalStageId, heroIdSnapShoot)
  self.firstRewardDic = {}
  self.normalRewardDic = {}
  local StOCareerRewardDic = {}
  local activityExchangeDic = {}
  local newHeroDic = {}
  if self.resultMsg == nil or self.resultMsg.Count <= 0 then
    return
  end
  local StOCareerItemIdDic = ConfigData.game_config.STOCareerCostDic
  local extrAwardDic = {}
  table.merge(extrAwardDic, ConfigData.activity_time_limit.exchangeMapping)
  local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
  if sectorIICtrl ~= nil then
    local idDic = sectorIICtrl:GetAfterBattleShowItemDic()
    table.merge(extrAwardDic, idDic)
  end
  local skinCfg
  
  local function AddItemFunc(id, count, finalDic, isFirstReward)
    local dic
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("can't get itemCfg with id " .. tostring(id))
      return
    end
    if itemCfg.action_type == eItemActionType.HeroCard then
      local heroId = itemCfg.arg[1]
      if not heroIdSnapShoot[heroId] then
        newHeroDic[heroId] = true
      end
    end
    if itemCfg.type == eItemType.Skin then
      skinCfg = ConfigData.skin[itemCfg.id]
    end
    if StOCareerItemIdDic[id] ~= nil then
      dic = StOCareerRewardDic
    elseif not isFirstReward and extrAwardDic[id] then
      dic = activityExchangeDic
    else
      dic = finalDic
    end
    local newCount = dic[id] or 0
    dic[id] = newCount + count
  end
  
  local data = self.resultMsg[0]
  if data.firstClearRewards ~= nil then
    for id, count in pairs(data.firstClearRewards) do
      AddItemFunc(id, count, self.firstRewardDic, true)
    end
  end
  self.fixRewardDic = data.normalRewards
  local challengeQuestRewards
  if data.rewards ~= nil and data.rewards.rewards ~= nil then
    for id, count in pairs(data.rewards.rewards) do
      AddItemFunc(id, count, self.normalRewardDic, false)
    end
    challengeQuestRewards = data.rewards.challengeQuestRewards
  end
  local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment, true)
  aftertTeatmentCtrl:AddShowStOCareerReward(StOCareerRewardDic)
  aftertTeatmentCtrl:AddShowReward(activityExchangeDic)
  aftertTeatmentCtrl:SaveSectorId(self.sectorId)
  aftertTeatmentCtrl:AddNewHeroReward(newHeroDic)
  local challengeQuestList = data.challengeQuestIds
  if challengeQuestRewards ~= nil and 0 < #challengeQuestList then
    local fromNum = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskCompleteNum(epNormalStageId)
    local toNum = fromNum + #challengeQuestList
    local totalNum = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskNum(epNormalStageId)
    aftertTeatmentCtrl:SetShowChallengeModeReward(challengeQuestRewards, fromNum, toNum, totalNum)
  end
  if skinCfg ~= nil then
    aftertTeatmentCtrl:SetShowSkinPlay(skinCfg)
  end
  for k, questId in ipairs(challengeQuestList) do
    PlayerDataCenter.sectorAchievementDatas:SetChallengeTaskComplete(epNormalStageId, questId)
  end
end

function ExplorationResultCtrl:_ContinueNextStep(isFirst)
  if isFirst then
    self.currentProcess = 0
    self.isExecutedBattleEndClear = false
  end
  self.currentProcess = self.currentProcess + 1
  if self.currentProcess > #self.processTable then
    return
  end
  self.processTable[self.currentProcess]()
end

return ExplorationResultCtrl
