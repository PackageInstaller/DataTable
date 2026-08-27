local ActivitySpringController = class("ActivitySpringController", ControllerBase)
local JumpManager = require("Game.Jump.JumpManager")
local ActivitySpringData = require("Game.ActivitySpring.Data.ActivitySpringData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local FmtEnum = require("Game.Formation.FmtEnum")
local eActInteract23Spring = require("Game.ActivityLobby.Activity.2023Spring.eActInteract")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local eActInteract = require("Game.ActivityLobby.Activity.2023Music.eActInteract")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local returnToSpringCallbackDic = {
  [3] = function(self, actId, stageCfg)
    local springData = self._dataDic[actId]
    if springData ~= nil and stageCfg ~= nil then
      if stageCfg.sector == springData:GetSpringBrotatoSectorId() then
        self:SetIsOpenByResultWithBrotato(true)
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
        local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        ctrl.actLbIntrctCtrl:InvokeActLbEntity(eActInteract.eLbIntrctEntityId.Brotato)
      elseif stageCfg.sector == springData:GetSpringMainSectorId() then
        local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        if ctrl.actLbIntrctCtrl:GetActLbEntityIsUnlock(eActInteract.eLbIntrctEntityId.EnvSelect) then
          ctrl.actLbIntrctCtrl:InvokeActLbEntity(eActInteract.eLbIntrctEntityId.EnvSelect)
        end
      end
    end
  end
}
local cs_MessageCommon = CS.MessageCommon

function ActivitySpringController:OnInit()
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dataDic = {}
  self._storyDic = {}
  self.__AvgCompleteCallback = BindCallback(self, self.__AvgComplete)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__AvgCompleteCallback)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.__PreConditionCallback = BindCallback(self, self.__PreCondition)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__PreConditionCallback)
  ConfigData:LoadDynCfg(eDynConfigData.activity_spring_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_spring_advanced_env)
  ConfigData:LoadDynCfg(eDynConfigData.activity_spring_difficulty)
  ConfigData:LoadDynCfg(eDynConfigData.activity_spring_difficulty_catalog)
  ConfigData:LoadDynCfg(eDynConfigData.activity_spring_level)
  ConfigData:LoadDynCfg(eDynConfigData.activity_spring_level_detail)
  ConfigData:LoadDynCfg(eDynConfigData.activity_interact_main_story)
  ConfigData:LoadDynCfg(eDynConfigData.activity_interact_info)
  ConfigData:LoadDynCfg(eDynConfigData.activity_interact)
  ConfigData:LoadDynCfg(eDynConfigData.activity_interact_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_interact_story_level)
end

function ActivitySpringController:InitAllSpring(msgs)
  for _, msg in ipairs(msgs) do
    self:AddSpring(msg)
  end
end

function ActivitySpringController:AddSpring(msg)
  local frameData = self._frameCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.Spring, msg.actId)
  if frameData == nil or not frameData:IsActivityOpen() then
    return
  end
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ActivitySpringData.New()
  self._dataDic[msg.actId] = data
  data:InitSpringData(msg)
end

function ActivitySpringController:UpdateSpring(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateSpringMsg(msg)
end

function ActivitySpringController:RemoveSpring(actId)
  self._dataDic[actId]:ClearTimer()
  self._dataDic[actId] = nil
end

function ActivitySpringController:__AvgComplete(avgId)
  for _, data in pairs(self._dataDic) do
    data:CalSpringAvgState(avgId)
    data:RefreshSpringUnlockAvgPlayed()
  end
end

function ActivitySpringController:OpenSpring(actId, skipStartShow, callback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl, true)
  local mainActivityId = data:GetSpringMainCfg().activity_id
  ctrl:InitActLobbyCtrl(mainActivityId)
  if skipStartShow then
    ctrl:SkipActLbStartShow()
  end
  self._enterCompleteCallback = callback
end

function ActivitySpringController:Spirng23OpenObj(ObjId)
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
  if ObjId ~= nil then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    ctrl.actLbIntrctCtrl:InvokeActLbEntity(ObjId)
    ObjId = nil
  end
end

function ActivitySpringController:EnterSpringEp(data, envId, diffculty, index, stageChallengeData, changeChallengCallback)
  if data == nil then
    return
  end
  local envCfg = ConfigData.activity_spring_advanced_env[envId]
  local stageId = envCfg.stage_id[index]
  if stageId == nil then
    error("env and diff can't confirm stage")
    return
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.Spring23Main)
    UIManager:HideWindow(UIWindowTypeID.Spring23LevelModSelect)
  end
  
  local function exitFunc()
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Main)
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23LevelModSelect)
  end
  
  local function startBattleFunc(curSelectFormationData, callBack)
    if PlayerDataCenter.stamina:GetCurrentStamina() < stageCfg.cost_strength_num then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
      return
    end
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(curSelectFormationData)
    local curSelectFormationId = curSelectFormationData.id
    local challengeTaskIdList, isChallengeMode
    if stageChallengeData ~= nil then
      isChallengeMode = stageChallengeData:IsStageChallengeOpen()
      challengeTaskIdList = stageChallengeData:GetStgClgOptionalTaskOpenList()
    end
    PlayerDataCenter.sectorStage:SetSelectSectorId(stageCfg.sector)
    ExplorationManager:ReqEnterExploration(stageId, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, callBack, curSelectFormationData:GetSupportHeroData(), isChallengeMode, challengeTaskIdList, totalFtPower, totalBenchPower)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.SpringEp, curSelectFormationId)
  end
  
  local lastFmtId = saveUserData:GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.SpringEp)
  local isChallengeMode
  if stageChallengeData ~= nil then
    isChallengeMode = stageChallengeData:IsStageChallengeOpen()
  end
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.SpringEp, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleTicketItemId(stageCfg.cost_strength_id):SetEnterBattleCostTicketNum(stageCfg.cost_strength_num):SetFmtCtrlChallengeData(isChallengeMode, changeChallengCallback, stageChallengeData)
  fmtCtrl:EnterFormation()
end

function ActivitySpringController:EnterSpringEpQuickBattle(data, envId, diffculty, index)
  local envCfg = ConfigData.activity_spring_advanced_env[envId]
  local stageId = envCfg.stage_id[index]
  if stageId == nil then
    error("env and diff can't confirm stage")
    return
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  local needKey = stageCfg.cost_strength_num
  if needKey > PlayerDataCenter.stamina:GetCurrentStamina() then
    JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
    return
  end
  ExplorationManager:ReqEnterExplorationQuickBattle(stageId, nil, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, nil, nil, false, nil, stageCfg)
end

function ActivitySpringController:OnEnterSpringChallenge(springDungeonData)
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
    
    UIManager:HideWindow(UIWindowTypeID.Spring23Challenge)
  end
  
  local function exitFunc(fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.DungeonLevelDetail, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Challenge)
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = springDungeonData
    end
    commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
    local needKey = dungeonLevelData:GetConsumeKeyNum()
    if needKey > PlayerDataCenter.stamina:GetCurrentStamina() then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
      return
    end
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.Spring, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleWinEvent(function()
      local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivitySpring, dungeonId, false, PlayerDataCenter.timestamp)
    end)
    local springData = self:GetTheLastSpring()
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local function returnActLbfunc()
        local eActInteract = require("Game.ActivityLobby.Activity.2023Music.eActInteract")
        
        local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        ctrl.actLbIntrctCtrl:InvokeActLbEntity(eActInteract.eLbIntrctEntityId.HardLevel)
      end
      
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.Spring):SetLPDActData(springData):SetLPDActId(springData:GetActId()):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(returnActLbfunc)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local SpringCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    local interfaceData = DungeonInterfaceData.CreateSpringDungeonInterface(dungeonLevelData)
    interfaceData:SetAfterClickBattleFunc(function(callback)
      callback()
    end)
    SpringCtrl:__ReqDungeonBattle(interfaceData, formationData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local needKey = springDungeonData:GetConsumeKeyNum()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = springDungeonData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.Spring)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.Spring, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey)
  fmtCtrl:EnterFormation()
end

function ActivitySpringController:__ReqDungeonBattle(interfaceData, formationData, callBack)
  local dungeonLevelData = interfaceData:GetIDungeonLevelData()
  local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNet:CS_ACTIVITY_DUNGEON_GeneralEnter(dungeonId, formationData, nil, function(dataList)
    if dataList.Count == 0 then
      return
    end
    local NtfEnterMsgData = dataList[0]
    BattleDungeonManager:RealEnterDungeon(NtfEnterMsgData, nil, interfaceData)
    NetworkManager:HandleDiff(NtfEnterMsgData.syncUpdateDiff)
    if callBack ~= nil then
      callBack()
    end
  end)
end

function ActivitySpringController:RunEnterCompleteFunc()
  if self._enterCompleteCallback then
    self._enterCompleteCallback()
  end
end

function ActivitySpringController:IsHaveSpring()
  return table.count(self._dataDic) > 0
end

function ActivitySpringController:GetTheLastSpring()
  local res
  for k, v in pairs(self._dataDic) do
    if res == nil then
      res = v
    elseif v:GetActivityBornTime() > res:GetActivityBornTime() then
      res = v
    end
  end
  return res
end

function ActivitySpringController:GetActSpringDataByFrameId(actFrameId)
  for k, data in pairs(self._dataDic) do
    if data:GetActFrameId() == actFrameId then
      return data
    end
  end
  return nil
end

function ActivitySpringController:GetSpringData(id)
  return self._dataDic[id]
end

function ActivitySpringController:CheckCostIsEnough(actId, interactId)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  local storyData = data:GetSpringStoryData()
  local costNum = storyData:GetNowHaveExp(interactId)
  return storyData:CostIsEnough(costNum, interactId)
end

function ActivitySpringController:CheckAndTalk(actId, heroId, successCallback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  local storyData = data:GetSpringStoryData()
  local interactCfg, cantTalk = storyData:GetNowCfgByHeroId(heroId)
  if cantTalk then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(string.format(ConfigData:GetTipContent(9101)))
    if successCallback then
      successCallback()
    end
    return false
  end
  local costIsEnough = self:CheckCostIsEnough(actId, interactCfg.id)
  if not costIsEnough then
    local itemCfg = ConfigData.item[storyData:GetNeedExpItemId(interactCfg.id)]
    local costName = LanguageUtil.GetLocaleText(itemCfg.name)
    local mainGameName = LanguageUtil.GetLocaleText(storyData:GetInteractMainGameName())
    local tip = string.format(ConfigData:GetTipContent(9103), costName, mainGameName)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(tip)
    if successCallback then
      successCallback()
    end
    return false
  end
  local isLongTail = storyData:IsLongTail(interactCfg.id)
  if isLongTail then
    if PlayerDataCenter.cacheSaveData:GetEnableActivitySpringLongTailConfirm() then
      local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      local heroCfg = ConfigData.hero_data[interactCfg.interact_character]
      local itemId = storyData:GetNeedExpItemId(interactCfg.id)
      local msg = string.format(ConfigData:GetTipContent(9104), LanguageUtil.GetLocaleText(heroCfg.name), LanguageUtil.GetLocaleText(ConfigData.item[itemId].name))
      window:ShowTextBoxWithYesAndNo(msg, function()
        storyData:FinishTalk(interactCfg.id, function()
          data:RefreshSpringUnlockEnv(nil, true)
          if successCallback ~= nil then
            successCallback()
          end
        end)
      end, function()
        if successCallback then
          successCallback()
        end
      end)
      window:ShowDontRemindTog(function(isOn)
        PlayerDataCenter.cacheSaveData:SetEnableActivitySpringLongTailConfirm(not isOn)
      end)
    else
      storyData:FinishTalk(interactCfg.id, function()
        data:RefreshSpringUnlockEnv(nil, true)
        if successCallback ~= nil then
          successCallback()
        end
      end)
    end
  else
    storyData:FinishTalk(interactCfg.id, function()
      data:RefreshSpringUnlockEnv(nil, true)
      if successCallback ~= nil then
        successCallback()
      end
    end)
  end
  return true
end

function ActivitySpringController:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local dailyTaskData = data:GetSpringDailyTaskData()
    if dailyTaskData ~= nil and dailyTaskData:IsExitInDailyTask(taskData.id) then
      data:RefreshRedSpringDailyTask()
    else
      local termTaskData = data:GetSpringTermTaskData()
      if termTaskData:IsExitInTermTask(taskData.id) then
        data:RefreshRedSpringOnceTask()
      else
      end
    end
  end
end

function ActivitySpringController:__ItemUpdate(_, _, itemDic)
  for _, data in pairs(self._dataDic) do
    local techTree = data:GetSpringTechTree()
    if techTree ~= nil then
      local techTypeCostDic = techTree:GetTechTypeCostDic()
      for itemId, _ in pairs(techTypeCostDic) do
        if itemDic[itemId] ~= nil then
          data:RefreshRedSpringTech()
          break
        end
      end
    end
    data:AddRefreshRedTalk()
  end
  ActLbUtil.UpdLbCurInteractList()
end

function ActivitySpringController:__PreCondition(precondition)
  for _, data in pairs(self._dataDic) do
    data:RefreshSpringUnlockEnv(precondition)
  end
end

function ActivitySpringController:GetIsOpenByResultWithBrotato()
  return self.isOpenByBattleResult or false
end

function ActivitySpringController:SetIsOpenByResultWithBrotato(bValue)
  self.isOpenByBattleResult = bValue
end

function ActivitySpringController:DoReturnToSpringCallback(actId, stageCfg)
  if returnToSpringCallbackDic[actId] ~= nil then
    returnToSpringCallbackDic[actId](self, actId, stageCfg)
  end
end

function ActivitySpringController:TryExitSpringBrotatoExploration(actId)
  local springData = self:GetSpringData(actId)
  if springData == nil then
    return
  end
  if ExplorationManager:IsInExploration() then
    local stageCfg = ExplorationManager:GetSectorStageCfg()
    if stageCfg ~= nil and springData:GetSpringBrotatoSectorId() == stageCfg.sector then
      ExplorationManager:ForceExitEp(Consts.SceneName.Main)
    end
  else
    local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
    local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
    if stageCfg ~= nil and springData:GetSpringBrotatoSectorId() == stageCfg.sector then
      ExplorationManager:ForceExitEp()
    end
  end
end

function ActivitySpringController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_spring_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_spring_advanced_env)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_spring_difficulty)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_spring_difficulty_catalog)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_spring_level)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_spring_level_detail)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_main_story)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_info)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_story_level)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__AvgCompleteCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__PreConditionCallback)
  for _, data in pairs(self._dataDic) do
    data:ClearTimer()
  end
end

return ActivitySpringController
