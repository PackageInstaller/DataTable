WarChessManager = {}
local cs_MessageCommon = CS.MessageCommon
local util = require("XLua.Common.xlua_util")
local WarChessCtrl = require("Game.WarChess.WarChessCtrl")
local WCGuideUtil = require("Game.WarChess.Util.WCGuideUtil")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")

function WarChessManager:ctor()
  self.__isInWarChess = false
  self.__isHaveUncompleteWarChess = false
  self.__uncompleteData = nil
  self.__wcCtrl = nil
  self.wcLevelId = nil
  self.wcLevelCfg = nil
  self.restartFunc = nil
  self.restartCostId = nil
  self.restartCostNum = nil
  self.__levelNameStr = nil
  self.__levelIndexStr = nil
  self.__recommendPower = nil
  self.__wcNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.WarChess)
end

function WarChessManager:InitWarchessCtrl()
  self.__isInWarChess = true
  self.__wcCtrl = WarChessCtrl.New()
end

function WarChessManager:ExitWarChessClean()
  self:_ClearFinishCo()
  if self.__isInWarChess then
    if self.__wcCtrl ~= nil then
      self.__wcCtrl:Delete()
    end
    self:CleamWCManager()
  end
end

function WarChessManager:CleamWCManager()
  self.__isInWarChess = false
  self.__wcCtrl = nil
  self.wcLevelId = nil
  self.wcLevelCfg = nil
  self.restartFunc = nil
  self.restartCostId = nil
  self.restartCostNum = nil
  self._stageId = nil
  self.isWCFinish = nil
  WarChessManager:ClearWcAudio()
end

function WarChessManager:GetIsInWarChess()
  return self.__isInWarChess
end

function WarChessManager:SetLevelNameAndIndex(nameStr, indexStr)
  self.__levelNameStr = nameStr
  self.__levelIndexStr = indexStr
end

function WarChessManager:SetWCRecommendPower(power)
  self.__recommendPower = power
end

function WarChessManager:GetLevelNameAndIndex()
  return self.__levelNameStr, self.__levelIndexStr
end

function WarChessManager:SyncIsHaveUncompletedWarChess()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess) then
    return
  end
  self.__wcNetworkCtrl:CS_WarChess_Brief_Detail(function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    self.__isHaveUncompleteWarChess = false
    self.__uncompleteData = nil
    WarChessSeasonManager:SetUncompleteWCSData(false)
    local msg = args[0]
    for _, briefMsg in pairs(msg.detail) do
      if briefMsg.detailType == eWarChessEnum.eBriefDetailType.normal then
        if 0 < (briefMsg.sectorId or 0) then
          self.__isHaveUncompleteWarChess = true
          self.__uncompleteData = {
            sectorStageId = briefMsg.sectorId,
            warchessId = briefMsg.warchessId,
            strengthWinReward = briefMsg.strengthWinReward
          }
          local stageCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Warchess)
          self.__recommendPower = stageCfg.combat
          if stageCfg.sector ~= nil and stageCfg.difficulty <= SectorLevelDetailEnum.eDifficulty.infinity then
            PlayerDataCenter.sectorStage:InitSelectStage(stageCfg.sector, stageCfg.difficulty)
          end
        end
      elseif briefMsg.detailType == eWarChessEnum.eBriefDetailType.season then
        WarChessSeasonManager:SetUncompleteWCSData(true, briefMsg)
      end
    end
    MsgCenter:Broadcast(eMsgEventId.OnHasUncompletedEp)
  end)
end

function WarChessManager:ContinueLastWarchess()
  local warChessType = eWarChessEnum.eBriefDetailType.normal
  self.__wcNetworkCtrl:CS_WarChess_Detail(warChessType, function(argList)
    if argList.Count ~= 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local warChessMsg = argList[0]
    self:InitWarchessCtrl()
    local sectorStageCfg = ConfigData.sector_stage[self.__uncompleteData.sectorStageId]
    self._stageId = self.__uncompleteData.sectorStageId
    PlayerDataCenter.sectorStage:SetSelectSectorId(sectorStageCfg.sector)
    self.__levelNameStr = LanguageUtil.GetLocaleText(sectorStageCfg.name)
    self.__levelIndexStr = ConfigData:GetSectorInfoMsg(sectorStageCfg.sector, sectorStageCfg.num, sectorStageCfg.difficulty)
    self.wcLevelId = sectorStageCfg.exploration_list[1]
    self.wcLevelCfg = ConfigData.warchess_level[self.wcLevelId]
    if self.wcLevelCfg == nil then
      error(string.format("can't read wcLevelCfg by stageId:%s, levelId:%s", tostring(self._stageId), tostring(self.wcLevelId)))
      return
    end
    self:CleanOrtherWhenEnter()
    self.__wcCtrl:EnterWarChessByMsg(warChessMsg.data, true)
  end)
end

function WarChessManager:GetWCSectorStageCfg()
  if self._stageId == nil then
    return nil
  end
  local sectorStageCfg = ConfigData.sector_stage[self._stageId]
  return sectorStageCfg
end

function WarChessManager:GetIsMainSectorStageWC()
  local stageCfg = self:GetWCSectorStageCfg()
  if stageCfg ~= nil then
    local sectorId = stageCfg.sector
    local isWarChess = stageCfg.is_warchess
    local isInMain = ConfigData.sector_sector_resident.sectorId2ChapterIdMap[sectorId] ~= nil
    if isWarChess and isInMain then
      return true
    end
  end
  return false
end

function WarChessManager:GiveUpWarchess()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local rewardList = wcCtrl.backPackCtrl:GetIsWCRewardBagItemList()
  UIManager:HideWindow(UIWindowTypeID.BattlePause)
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessGameFail, function(window)
    window:SetPlayOverCallback(function()
      WarChessManager:OpenWCRewardBagSelect(rewardList, function(pickInfo)
        wcCtrl.wcNetworkCtrl:CS_WarChess_Quit(pickInfo, function(msg)
          WarChessManager:WarChessFinishSubFunc(msg, false, nil)
        end)
      end)
    end)
  end)
end

function WarChessManager:GiveUpLastWarchess()
  local rewardList
  rewardList = self.__uncompleteData ~= nil and self.__uncompleteData.strengthWinReward
  self._stageId = self.__uncompleteData ~= nil and self.__uncompleteData.sectorStageId
  WarChessManager:OpenWCRewardBagSelect(rewardList, function(pickInfo)
    self.__wcNetworkCtrl:CS_WarChess_Quit(pickInfo, function(args)
      self.__uncompleteData = nil
      self.__isHaveUncompleteWarChess = false
      local warChessSettleData = args[0].data
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window ~= nil then
          local CommonRewardData = require("Game.CommonUI.CommonRewardData")
          local CRData = CommonRewardData.CreateCRDataUseDic(warChessSettleData.rewards.stmStorePickRewards):SetCRNotHandledGreat(true)
          window:AddAndTryShowReward(CRData)
        end
      end)
      WarChessSeasonManager:SetUncompleteWCSData(false)
      MsgCenter:Broadcast(eMsgEventId.GiveUncompleteExploration)
      MsgCenter:Broadcast(eMsgEventId.OnHasUncompletedEp)
      self._stageId = nil
    end)
  end)
end

function WarChessManager:TryGiveUpLastWarChess(msg, stageCfg)
  local addMsg = msg
  if addMsg == nil and string.IsNullOrEmpty(addMsg) then
    addMsg = ""
  else
    addMsg = addMsg .. [[


]]
  end
  local rewardList = self.__uncompleteData ~= nil and self.__uncompleteData.strengthWinReward
  if rewardList ~= nil then
    if 0 < #rewardList then
      cs_MessageCommon.ShowMessageBox(addMsg .. ConfigData:GetTipContent(753), function()
        self:GiveUpLastWarchess()
      end, nil)
      return
    else
      cs_MessageCommon.ShowMessageBox(addMsg .. ConfigData:GetTipContent(752), function()
        self:GiveUpLastWarchess()
      end, nil)
      return
    end
  end
  local returnStamina = 0
  local msg
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
  else
    msg = string.format(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), tostring(returnStamina))
  end
  msg = addMsg .. msg
  cs_MessageCommon.ShowMessageBox(msg, function()
    self:GiveUpLastWarchess()
  end, nil)
end

function WarChessManager:GetIsHaveUncompletedWarChess()
  if self.__uncompleteData == nil then
    return false
  end
  return self.__isHaveUncompleteWarChess, self.__uncompleteData.sectorStageId, proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess, false
end

function WarChessManager:GetWarChessCtrl()
  return self.__wcCtrl
end

function WarChessManager:GetWCLevelShopId()
  return self:GetWCLevelCfg().shop
end

function WarChessManager:GetWCLevelId()
  return self.wcLevelId
end

function WarChessManager:GetWCLevelCfg()
  return self.wcLevelCfg
end

function WarChessManager:GetWCLevelStressId()
  return self.wcLevelCfg.stress
end

function WarChessManager:GetWCOfficialSupportCfgId()
  if self.wcLevelCfg.assist_id <= 0 then
    return nil
  end
  return self.wcLevelCfg.assist_id
end

function WarChessManager:GetWCLevelStressCfg()
  local stressId = self.wcLevelCfg.stress
  local stressCfg = ConfigData.warchess_stress[stressId]
  return stressCfg
end

function WarChessManager:GetWCLevelGlobalTriggerCfg()
  local isHaveGTrigger = self.wcLevelCfg.trigger_id ~= nil
  return isHaveGTrigger, self.wcLevelCfg.trigger_icon, self.wcLevelCfg.trigger_id
end

function WarChessManager:GetWCGlobalData()
  return self.__wcCtrl.wcGlobalData
end

function WarChessManager:GetWCGuideActionList(moment, logicCoord, tipArg)
  local wcLevelId = self:GetWCLevelId()
  return WCGuideUtil.GetWCGuideActionsById(wcLevelId, moment, logicCoord, tipArg)
end

function WarChessManager:QuickExeWCGuideActions(moment, logicCoord, battleCount, tipArg)
  local actionList = self:GetWCGuideActionList(moment, logicCoord, tipArg)
  if actionList ~= nil and 0 < #actionList then
    WCGuideUtil.ExecuteWCGuideActions(actionList, battleCount)
    return true
  else
    return false
  end
end

function WarChessManager:EnterWarChessBySectorStageId(stageId, challengeData)
  self:InitWarchessCtrl()
  local stageCfg = ConfigData.sector_stage[stageId]
  self._stageId = stageId
  PlayerDataCenter.sectorStage:SetSelectSectorId(stageCfg.sector)
  self.__levelNameStr = LanguageUtil.GetLocaleText(stageCfg.name)
  self.__levelIndexStr = ConfigData:GetSectorInfoMsg(stageCfg.sector, stageCfg.num, stageCfg.difficulty)
  self.wcLevelId = stageCfg.exploration_list[1]
  self.wcLevelCfg = ConfigData.warchess_level[self.wcLevelId]
  self.__recommendPower = stageCfg.combat
  if self.wcLevelCfg == nil then
    error("war chess LevelCfg not exist:" .. tostring(self.wcLevelId))
    return
  end
  local isChallengeMode, challengeQuestsList
  if challengeData ~= nil then
    isChallengeMode = challengeData:IsStageChallengeOpen()
    challengeQuestsList = challengeData:GetStgClgOptionalTaskOpenList()
  end
  local warChessType = eWarChessEnum.eBriefDetailType.normal
  self.__wcCtrl.wcNetworkCtrl:CS_WarChess_SingleStart(stageId, isChallengeMode, challengeQuestsList, warChessType, function(argList)
    if argList.Count ~= 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local warChessMsg = argList[0]
    self:CleanOrtherWhenEnter()
    self.__wcCtrl:EnterWarChessByMsg(warChessMsg)
  end)
end

function WarChessManager:EnterWarChessByOutMsg(warChessOutMsg, isReconnect)
  self:InitWarchessCtrl()
  self.__levelNameStr = self.__levelNameStr or "???"
  self.__levelIndexStr = self.__levelIndexStr or "???"
  self.wcLevelId = warChessOutMsg.configId
  self.wcLevelCfg = ConfigData.warchess_level[self.wcLevelId]
  self.__recommendPower = self.__recommendPower or 0
  if self.wcLevelCfg == nil then
    error("war chess LevelCfg not exist:" .. tostring(self.wcLevelId))
    return
  end
  self:CleanOrtherWhenEnter()
  self.__wcCtrl:EnterWarChessByMsg(warChessOutMsg, isReconnect)
end

function WarChessManager:CleanOrtherWhenEnter()
  UIManager:DeleteAllWindow()
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
end

function WarChessManager:SetWCRestart(restartFunc, restartCostId, restartCostNum)
  self.restartFunc = restartFunc
  self.restartCostId = restartCostId
  self.restartCostNum = restartCostNum
end

function WarChessManager:GetWCRestart()
  return self.restartFunc, self.restartCostId, self.restartCostNum
end

function WarChessManager:IsWCCouldRestart()
  return self.restartFunc ~= nil
end

function WarChessManager:IsWCInBattle()
  return self.__wcCtrl:GetWCSurSubSystemCat() == eWarChessEnum.eSystemCat.battle
end

function WarChessManager:IsWCInGuardBattle()
  if self.__wcCtrl ~= nil and self.__wcCtrl:GetWCSurSubSystemCat() == eWarChessEnum.eSystemCat.battle then
    return self.__wcCtrl.battleCtrl:IsInGuardBattle()
  end
  return false
end

function WarChessManager:GetWCCoinNum()
  if self.__wcCtrl ~= nil and self.__wcCtrl.backPackCtrl ~= nil then
    return self.__wcCtrl.backPackCtrl:GetWCCoinNum()
  end
  return 0
end

function WarChessManager:AddWCCacheCoinNum(goldCount)
  if self.__wcCtrl ~= nil and self.__wcCtrl.backPackCtrl ~= nil then
    return self.__wcCtrl.backPackCtrl:AddCacheMoneyCount(goldCount)
  end
  return 0
end

function WarChessManager:SetWCCacheCoinNum(goldCount)
  if self.__wcCtrl ~= nil and self.__wcCtrl.backPackCtrl ~= nil then
    return self.__wcCtrl.backPackCtrl:SetCacheMoneyCount(goldCount)
  end
  return 0
end

function WarChessManager:GetWCCacheCoinNum()
  if self.__wcCtrl ~= nil and self.__wcCtrl.backPackCtrl ~= nil then
    return self.__wcCtrl.backPackCtrl:GetCacheMoneyCount()
  end
  return 0
end

function WarChessManager:TryExitWCBattle()
  if self.__wcCtrl:GetWCSurSubSystemCat() == eWarChessEnum.eSystemCat.battle then
    self.__wcCtrl.battleCtrl:WCEscapeFromBattle()
  end
end

function WarChessManager:WarChessFinishSubFunc(args, isWin, heroIdSnapShoot)
  if args.Count == 0 then
    error("args.Count == 0")
    return
  end
  local warChessSettleData = args[0].data
  local warChessSeasonSettleData = args[0].seasonData
  local wcSettelRewardData = {}
  if warChessSettleData.rewards ~= nil then
    wcSettelRewardData.firstPassRewardDic = warChessSettleData.rewards.firstClear
    wcSettelRewardData.innerWCReardDic = warChessSettleData.rewards.normalRewards
    wcSettelRewardData.stmStorePickRewardDic = warChessSettleData.rewards.stmStorePickRewards
  end
  if warChessSeasonSettleData ~= nil then
    if wcSettelRewardData.innerWCReardDic == nil then
      wcSettelRewardData.innerWCReardDic = warChessSeasonSettleData.rewardItems
    else
      for itemId, itemNum in pairs(warChessSeasonSettleData.rewardItems) do
        wcSettelRewardData.innerWCReardDic[itemId] = (wcSettelRewardData.innerWCReardDic[itemId] or 0) + itemNum
      end
    end
  end
  
  local function WCResultFunc(isFakeWin)
    local settelRewardData = wcSettelRewardData
    if settelRewardData.innerWCReardDic ~= nil then
      local new_normalReward = {}
      local aftertTeatmentRewardDic = {}
      local aftertTeatmentCareerDic = {}
      local StOCareerItemIdDic = ConfigData.game_config.STOCareerCostDic
      local extrAwardDic = ConfigData.activity_time_limit.exchangeMapping
      for itemId, num in pairs(settelRewardData.innerWCReardDic) do
        if StOCareerItemIdDic[itemId] ~= nil then
          aftertTeatmentCareerDic[itemId] = num
        elseif extrAwardDic[itemId] ~= nil then
          aftertTeatmentRewardDic[itemId] = num
        else
          new_normalReward[itemId] = num
        end
      end
      local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment, true)
      aftertTeatmentCtrl:AddShowStOCareerReward(aftertTeatmentCareerDic)
      aftertTeatmentCtrl:AddShowReward(aftertTeatmentRewardDic)
      settelRewardData.innerWCReardDic = new_normalReward
    end
    local newHeroDic = {}
    
    local function AddItem_func(itemDic)
      for k, v in pairs(itemDic) do
        local itemCfg = ConfigData.item[k]
        if itemCfg ~= nil and itemCfg.action_type == eItemActionType.HeroCard then
          local heroId = itemCfg.arg[1]
          if not heroIdSnapShoot[heroId] then
            newHeroDic[heroId] = true
          end
        end
      end
    end
    
    if settelRewardData.firstPassRewardDic ~= nil then
      AddItem_func(settelRewardData.firstPassRewardDic)
    end
    if settelRewardData.stmStorePickRewardDic ~= nil then
      AddItem_func(settelRewardData.stmStorePickRewardDic)
    end
    if table.count(newHeroDic) > 0 then
      local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment, true)
      aftertTeatmentCtrl:AddNewHeroReward(newHeroDic)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessResult, function(window)
      if window ~= nil then
        window:InitWarChessResult(isFakeWin or isWin)
        window:RefreshWCResultReward(settelRewardData)
        window:RefreshWCLevelInfo(self.__levelNameStr, self.__levelIndexStr)
      end
    end)
  end
  
  if WarChessSeasonManager:GetIsInWCSeason() then
    WarChessSeasonManager:WCSSettle(isWin, args[0], WCResultFunc)
    return
  end
  WCResultFunc()
  if self._stageId ~= nil and warChessSettleData.rewards ~= nil then
    local challengeQuestRewards = warChessSettleData.rewards.challengeRewards
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment, true)
    local challengeQuestList = warChessSettleData.challengeQuests
    if challengeQuestRewards ~= nil and 0 < #challengeQuestList then
      local fromNum = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskCompleteNum(self._stageId)
      local toNum = fromNum + #challengeQuestList
      local totalNum = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskNum(self._stageId)
      aftertTeatmentCtrl:SetShowChallengeModeReward(challengeQuestRewards, fromNum, toNum, totalNum)
    end
    for k, questId in ipairs(challengeQuestList) do
      PlayerDataCenter.sectorAchievementDatas:SetChallengeTaskComplete(self._stageId, questId)
    end
  end
end

function WarChessManager:WarchesFinish(isWin, castOverData)
  local function Finish(selectedRewardInfo)
    UIManager:HideWindow(UIWindowTypeID.WarChessNotice)
    
    local heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    self.__wcCtrl.wcNetworkCtrl:CS_WarChess_Settle(selectedRewardInfo, function(args)
      WarChessManager:WarChessFinishSubFunc(args, isWin, heroIdSnapShoot)
    end)
  end
  
  self.isWCWaitingFinish = true
  self.finishCo = GR.StartCoroutine(util.cs_generator(function()
    while not self.__wcCtrl:GetIsInWarChessScene() do
      coroutine.yield(nil)
    end
    
    local function IsPlaying()
      if self.__wcCtrl.state == eWarChessEnum.eWarChessState.play and (self.__wcCtrl.curState:IsMovingMonster() or self.__wcCtrl.curState:IsMovingTeam() or self.__wcCtrl.curState:GetIsWaitingEntityAnimation()) then
        return true
      end
      if self.__wcCtrl:IsWCInSubSystem() then
        return true
      end
      return false
    end
    
    while IsPlaying() do
      coroutine.yield(nil)
    end
    self.isWCFinish = true
    local wcsFloorReward = true
    if castOverData ~= nil then
      local overReward = castOverData.overReward
      if overReward == nil then
        wcsFloorReward = false
      else
        while UIManager:GetWindow(UIWindowTypeID.WarChessSelectChip) ~= nil do
          coroutine.yield(nil)
        end
        local celanFloorRewardDynCtrl = self.__wcCtrl:LazyLoadDynCtrl(eWarChessEnum.eDynCtrl.cleanFloorReward)
        celanFloorRewardDynCtrl:OpenCleanFloorRewardSelect(overReward, function()
          wcsFloorReward = false
        end)
      end
    else
      wcsFloorReward = false
    end
    self.__wcCtrl:SetIsWCInAfterSettleProcess(true)
    while wcsFloorReward do
      coroutine.yield(nil)
    end
    self.__wcCtrl:SetIsWCInAfterSettleProcess(false)
    local waitWinOrFailPlayOver = true
    if isWin then
      UIManager:ShowWindowAsync(UIWindowTypeID.WarChessGameWin, function(window)
        window:SetPlayOverCallback(function()
          waitWinOrFailPlayOver = false
        end)
      end)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.WarChessGameFail, function(window)
        window:SetPlayOverCallback(function()
          waitWinOrFailPlayOver = false
        end)
      end)
    end
    while waitWinOrFailPlayOver do
      coroutine.yield(nil)
    end
    UIManager:HideWindow(UIWindowTypeID.WarChessGameWin)
    UIManager:HideWindow(UIWindowTypeID.WarChessGameFail)
    local isSelecting, selectedRewardInfo
    if self.__wcCtrl.backPackCtrl:GetIsWCHaveRewardBag() then
      local isInWCS = WarChessSeasonManager:GetIsInWCSeason()
      local isLastFloor
      if isInWCS then
        local wcsCtrl = WarChessSeasonManager:GetWCSCtrl()
        isLastFloor = wcsCtrl:WCSGetIsAtLastFloor()
      end
      if not isInWCS or isInWCS and (isLastFloor or not isWin) then
        isSelecting = true
        local rewardList = self.__wcCtrl.backPackCtrl:GetIsWCRewardBagItemList()
        WarChessManager:OpenWCRewardBagSelect(rewardList, function(pickInfo)
          selectedRewardInfo = pickInfo
          isSelecting = false
        end, isWin)
      end
    end
    while isSelecting do
      coroutine.yield(nil)
    end
    if Finish ~= nil then
      Finish(selectedRewardInfo)
    end
    self.finishCo = nil
    self.isWCWaitingFinish = nil
  end))
end

function WarChessManager:OpenWCRewardBagSelect(rewardList, selectOverCallback, isWin)
  if rewardList ~= nil and 0 < #rewardList then
    UIManager:HideWindow(UIWindowTypeID.WarChessMain)
    UIManager:HideWindow(UIWindowTypeID.WarChessInfo)
    UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardBag, function(window)
      if window == nil then
        return
      end
      local epModuleId, stageId, firstClearDic
      local isInWCS = WarChessSeasonManager:IsInWCS()
      if isInWCS then
        local towerId = WarChessSeasonManager:GetWCSSeasonTowerID()
        local wcsTowerShopDropCfg = ConfigData.warchess_tower_shop_drop[towerId]
        epModuleId = proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason
        if wcsTowerShopDropCfg == nil then
          error("wcs not have reward bag config, but server send it, pls check")
        end
        local fakeStageId = wcsTowerShopDropCfg.stage_id
        stageId = fakeStageId
      else
        local sectorStageCfg = WarChessManager:GetWCSectorStageCfg()
        epModuleId = proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess
        stageId = sectorStageCfg.id
        if stageId and isWin then
          firstClearDic = ExplorationManager:GetEpFirstClearDic(stageId, epModuleId)
        end
      end
      if window == nil then
        return
      end
      window:InitEpRewardBag(rewardList, nil, true, firstClearDic, true, epModuleId, stageId)
      window:SetEpRewardBagCloseFunc(function(rewardDic, pickInfo)
        if selectOverCallback ~= nil then
          selectOverCallback(pickInfo)
        end
        window:Delete()
      end)
    end)
  else
    if isGameDev then
      print("reward bag try to show, but not have any thing")
    end
    if selectOverCallback ~= nil then
      selectOverCallback(nil)
    end
  end
end

function WarChessManager:ForceExitWarchess()
  if self.__wcCtrl:GetIsInWarChessScene() then
    self:ExitWarChess()
  else
    self.__wcCtrl:SetExitWhenLoadSuccess()
  end
end

function WarChessManager:ExitWarChess(exit2SceneName, isWin, loadMainCallback, scenechangeCallback)
  local LastPlayData = require("Game.Sector.Data.LastPlayData")
  local lastPlayData = LastPlayData.New():SetLPDStageCfg(ConfigData.sector_stage[self._stageId]):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(scenechangeCallback)
  CS.BattleManager.Instance:ForceExitBattle()
  MsgCenter:Broadcast(eMsgEventId.WC_ExitWC)
  AudioManager:RemoveAllVoice()
  UIManager:DeleteAllWindow()
  self:ExitWarChessClean()
  self:SyncIsHaveUncompletedWarChess()
  local isInWCS = WarChessSeasonManager:GetIsInWCSeason()
  local seasonId, towerId, seasonLevelIndex
  if isInWCS then
    seasonId = WarChessSeasonManager:GetWCSSeasonId()
    towerId = WarChessSeasonManager:GetWCSSeasonTowerID()
    seasonLevelIndex = WarChessSeasonManager:GetWCSCtrl():WCSGetFloor()
    lastPlayData = LastPlayData.New():SetLPDSeasonId(seasonId, towerId, seasonLevelIndex):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(scenechangeCallback)
    WarChessSeasonManager:ExitWarChessClean()
  end
  if exit2SceneName == nil or exit2SceneName == Consts.SceneName.Sector then
    UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(1)
    PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, scenechangeCallback)
  elseif exit2SceneName == Consts.SceneName.Main then
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

function WarChessManager:GetEpSceneBattleFieldSize()
  local sceneCfg = self:GetWcSceneCfg()
  return sceneCfg.size_row, sceneCfg.size_col, sceneCfg.deploy_rows
end

function WarChessManager:GetWcSceneCfg()
  local sceneCfg = ConfigData.scene[self.wcLevelCfg.prefeb_id]
  if sceneCfg == nil then
    error("scene cfg is null,scene_id:" .. tostring(self.wcLevelCfg.prefeb_id))
  end
  return sceneCfg
end

function WarChessManager:GetWCRecommenPower()
  return self.__recommendPower or 0
end

function WarChessManager:_TryGetStageBgmCfg()
  local sectorStateCfg = self:GetWCSectorStageCfg()
  if sectorStateCfg == nil or sectorStateCfg.stage_bgm_id == 0 then
    return nil
  end
  local stageBgmCfg = ConfigData.sector_stage_bgm[sectorStateCfg.stage_bgm_id]
  return stageBgmCfg
end

function WarChessManager:PlayWcAuBgm()
  local stageBgmCfg = self:_TryGetStageBgmCfg()
  if stageBgmCfg ~= nil then
    AudioManager:PlayAudioById(stageBgmCfg.bgm_id)
    return
  end
  local sceneCfg = self:GetWcSceneCfg()
  AudioManager:PlayAudioById(sceneCfg.audio_id)
end

function WarChessManager:PlayWcAuSelctRoomSelect()
  local stageBgmCfg = self:_TryGetStageBgmCfg()
  if stageBgmCfg ~= nil and not string.IsNullOrEmpty(stageBgmCfg.selector) then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, stageBgmCfg.selector, stageBgmCfg.label_lv_select)
    return
  end
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.roomSelect)
end

function WarChessManager:PlayWcAuSelctNormalCombat()
  local stageBgmCfg = self:_TryGetStageBgmCfg()
  if stageBgmCfg ~= nil and not string.IsNullOrEmpty(stageBgmCfg.selector) then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, stageBgmCfg.selector, stageBgmCfg.label_normal_combat)
    return
  end
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.normalCombat)
end

function WarChessManager:PlayWcAuSelctBossCombat()
  local stageBgmCfg = self:_TryGetStageBgmCfg()
  if stageBgmCfg ~= nil and not string.IsNullOrEmpty(stageBgmCfg.selector) then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, stageBgmCfg.selector, stageBgmCfg.label_boss_combat)
    return
  end
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.bossCombat)
end

function WarChessManager:ClearWcAudio()
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Character)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Monster)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_SupSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Battle_Buff)
  AudioManager:RemoveCueSheet(eAuCueSheet.CommonSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Ambience)
  AudioManager:RemoveAllVoice()
end

function WarChessManager:_ClearFinishCo()
  if self.finishCo ~= nil then
    GR.StopCoroutine(self.finishCo)
    self.finishCo = nil
  end
  self.isWCWaitingFinish = nil
end

function WarChessManager:Delete()
  self:_ClearFinishCo()
end

return WarChessManager
