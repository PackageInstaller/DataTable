local ActivityAnniversary23Controller = class("ActivityAnniversary23Controller", ControllerBase)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityAnniversary23Data = require("Game.ActivityAnniversary23.Data.ActivityAnniversary23Data")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local cs_MessageCommon = CS.MessageCommon
local ActivityAnniversary23Enum = require("Game.ActivityAnniversary23.Data.ActivityAnniversary23Enum")
local JumpManager = require("Game.Jump.JumpManager")
local FmtEnum = require("Game.Formation.FmtEnum")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local CS_GameObject = CS.UnityEngine.GameObject
local CS_PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local cs_DoTween = CS.DG.Tweening.DOTween

function ActivityAnniversary23Controller:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_anniversary_main)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_general_env)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_stage_info)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season)
  ConfigData:LoadDynCfg(eDynConfigData.activity_monster_card)
  ConfigData:LoadDynCfg(eDynConfigData.activity_monster_card_card)
  ConfigData:LoadDynCfg(eDynConfigData.activity_monster_card_card_level)
  ConfigData:LoadDynCfg(eDynConfigData.activity_hard_dungeon)
  ConfigData:LoadDynCfg(eDynConfigData.activity_hard_dungeon_stage)
  ConfigData:LoadDynCfg(eDynConfigData.activity_monster_card_label)
  self._dataDic = {}
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.__AvgStageChangeCallback = BindCallback(self, self.__AvgStateChange)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__AvgStageChangeCallback)
  self.__OnDayPassCallback = BindCallback(self, self.__OnDayPass)
  MsgCenter:AddListener(eMsgEventId.OnCommonDayPass, self.__OnDayPassCallback)
end

function ActivityAnniversary23Controller:AddAnniversary23(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ActivityAnniversary23Data.New()
  self._dataDic[msg.actId] = data
  data:InitAnniversary23Data(msg)
  local brotatoId = data:GetBrotatoId()
  if brotatoId ~= 0 then
    local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
    activityBrotatoLobbyCtrl:CreateBrotatoData(brotatoId, data:GetActFrameId())
  end
end

function ActivityAnniversary23Controller:RemoveAnniversary23(actId)
  local data = self._dataDic[actId]
  if data ~= nil then
    data:OnDataRemoved()
  end
  self._dataDic[actId] = nil
end

function ActivityAnniversary23Controller:IsHaveAnniversary23()
  return table.count(self._dataDic) > 0
end

function ActivityAnniversary23Controller:GetAnniversary23Data()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActivityAnniversary23Controller:GetAnniversary23DataByActId(actId)
  return self._dataDic[actId]
end

function ActivityAnniversary23Controller:GetActAnniversary23DataByFrameId(actFrameId)
  for k, data in pairs(self._dataDic) do
    if data:GetActFrameId() == actFrameId then
      return data
    end
  end
  return nil
end

function ActivityAnniversary23Controller:EnterActAnvsr23WarChessSeasonLevelSelect(closeCallback)
  local anvsr23Data = self:GetAnniversary23Data()
  UIManager:ShowWindowAsync(UIWindowTypeID.WCSModeSelect, function(window)
    if window == nil then
      return
    end
    local seasonId = anvsr23Data:GetAnvsr23WarchessSeasonId()
    local loadSavingDataCallback = BindCallback(self, self._WCSLoadSaving)
    local startNewWCSCallback = BindCallback(self, self._EnterWarChessSeason)
    local actRed = anvsr23Data:GetActivityReddot()
    local taskReddot = actRed and actRed:GetChild(ActivityAnniversary23Enum.reddotType.WCSEnvTask)
    local taskUpdDotFunc = BindCallback(anvsr23Data, anvsr23Data.RefreshRedAnniversary23WCSTask)
    window:SetWCSModeSelectTask(taskReddot, taskUpdDotFunc)
    window:InitWCSModeSelect(seasonId, loadSavingDataCallback, startNewWCSCallback, closeCallback)
  end)
end

function ActivityAnniversary23Controller:_EnterWarChessSeason(stageInfoCfg, envId)
  local anvsr23Data = self:GetAnniversary23Data()
  if not anvsr23Data:IsActivityRunning() then
    return
  end
  local towerId = stageInfoCfg.season_id
  local seasonId = anvsr23Data:GetAnvsr23WarchessSeasonId()
  ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
  WarChessSeasonManager:EnterWarChessSeasonBySeasonGroupId(seasonId, towerId, envId or 0)
  self:__SetEnterrChessSeasonData(anvsr23Data, stageInfoCfg, seasonId, envId)
end

function ActivityAnniversary23Controller:__SetEnterrChessSeasonData(anvsr23Data, stageInfoCfg, seasonId, envId)
  local addtionData = anvsr23Data:GetAnvsr23SeasonAddtion()
  addtionData:SetSeasonCompleteFloor(stageInfoCfg.floor_id)
  addtionData:SetSeasonRecommendPower(stageInfoCfg.combat)
  addtionData:SetSeasonCompleteFloorTip(ConfigData:GetTipContent(8701))
  if seasonId and envId then
    local maxNum = WarChessSeasonManager:GetWCSPassedEnvMaxNum(seasonId, envId)
    addtionData:SetSeasonHighesScore(maxNum)
  end
  WarChessSeasonManager:SetSeasonAddtionData(addtionData)
  WarChessSeasonManager:SetWarChessSeasonName(LanguageUtil.GetLocaleText(stageInfoCfg.difficulty_name))
end

function ActivityAnniversary23Controller:_WCSLoadSaving(archive)
  local anvsr23Data = self:GetAnniversary23Data()
  local seasonId = anvsr23Data:GetAnvsr23WarchessSeasonId()
  local towerId = archive.warChessTowerId
  local stageInfoCfg = WarChessSeasonManager:GetWCSStageInfoByTowerId(seasonId, towerId)
  local envCfg = WarChessSeasonManager:GetWCSEnvIdByTowerId(seasonId, towerId)
  if stageInfoCfg ~= nil then
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    WarChessSeasonManager:ReadWCSSavingData(archive.warChessSeasonbackUpId)
    self:__SetEnterrChessSeasonData(anvsr23Data, stageInfoCfg, seasonId, envCfg.id)
  end
end

function ActivityAnniversary23Controller:ContinueAnvsr23Season()
  local isUnComplete, wcsdata = WarChessSeasonManager:GetUncompleteWCSData()
  if not isUnComplete then
    return
  end
  local anvsr23Data = self:GetAnniversary23Data()
  local seasonId = anvsr23Data:GetAnvsr23WarchessSeasonId()
  local towerId = wcsdata.towerId
  local stageInfoCfg = WarChessSeasonManager:GetWCSStageInfoByTowerId(seasonId, towerId)
  local envCfg = WarChessSeasonManager:GetWCSEnvIdByTowerId(seasonId, towerId)
  if stageInfoCfg ~= nil then
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    WarChessSeasonManager:WCSReconnect()
    self:__SetEnterrChessSeasonData(anvsr23Data, stageInfoCfg, seasonId, envCfg.id)
  end
end

function ActivityAnniversary23Controller:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_anniversary_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_general_env)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_stage_info)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_monster_card)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_monster_card_card)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_monster_card_card_level)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hard_dungeon)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hard_dungeon_stage)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_monster_card_label)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__AvgStageChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.OnCommonDayPass, self.__OnDayPassCallback)
  self:ClearStoryChangeSequence()
  self:ClearPlayableDir()
end

function ActivityAnniversary23Controller:ClearPlayableDir()
  if not IsNull(self.playableDir) then
    self.playableDir:Stop()
    self.playableDir = nil
  end
end

function ActivityAnniversary23Controller:__AvgStateChange(avgId)
  for _, data in pairs(self._dataDic) do
    data:RefreshRedAnniversary23MainStory()
  end
end

function ActivityAnniversary23Controller:__OnDayPass()
  for _, data in pairs(self._dataDic) do
    data:RefreshtHardLevelRedDot()
  end
end

function ActivityAnniversary23Controller:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local envId = ConfigData.warchess_season_general_env.taskEnvDic[taskData.id]
    if envId ~= nil then
      data:RefreshRedAnniversary23WCSTask(taskData)
    end
    local dailyTaskData = data:GetAnniversary23DailyTaskData()
    if dailyTaskData ~= nil and dailyTaskData:IsExitInDailyTask(taskData.id) then
      data:RefreshRedAnniversary23DailyTask()
    else
      local termTaskData = data:GetAnniversary23TermTaskData()
      if termTaskData:IsExitInTermTask(taskData.id) then
        data:RefreshRedAnniversary23OnceTask()
      else
      end
    end
  end
end

function ActivityAnniversary23Controller:__ItemUpdate(_, _, itemDic)
  for _, data in pairs(self._dataDic) do
    local techTree = data:GetAnniversary23TechTree()
    if techTree ~= nil then
      local techTypeCostDic = techTree:GetTechTypeCostDic()
      for itemId, _ in pairs(techTypeCostDic) do
        if itemDic[itemId] ~= nil then
          data:RefreshRedAnniversary23Tech()
          break
        end
      end
    end
  end
end

function ActivityAnniversary23Controller:OpenAnniversary23(actId, skipStartShow, callback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl, true)
  local mainActivityId = data:GetActFrameId()
  ctrl:InitActLobbyCtrl(mainActivityId)
  if skipStartShow then
    ctrl:SkipActLbStartShow()
  end
  self._enterCompleteCallback = callback
end

function ActivityAnniversary23Controller:RunEnterCompleteFunc()
  if self._enterCompleteCallback then
    self._enterCompleteCallback()
  end
end

function ActivityAnniversary23Controller:OpenAnniversary23Obj(objId)
  if objId ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if not ctrl.actLbIntrctCtrl:GetActLbEntityIsUnlock(objId) then
      local unLockTip = ctrl.actLbIntrctCtrl:GetActLbIntrctActionUnlockTip(objId)
      cs_MessageCommon.ShowMessageTips(unLockTip)
      return
    end
    ctrl.actLbIntrctCtrl:InvokeActLbEntity(objId)
  end
end

function ActivityAnniversary23Controller:OpenAnniversary23ObjByStageCfg(stageCfg, isHardLevel)
  local anniversary23Data = self:GetAnniversary23Data()
  if anniversary23Data == nil then
    return
  end
  if not anniversary23Data:IsActivityRunning() then
    return
  end
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  local eActInteract = actLbCtrl.actLbIntrctCtrl:GeteActIntrct()
  if stageCfg ~= nil and stageCfg.sector == anniversary23Data:GetAnniversary23MainSector() and eActInteract.eLbIntrctEntityId.Main ~= nil then
    self:OpenAnniversary23Obj(eActInteract.eLbIntrctEntityId.Main)
  elseif stageCfg ~= nil and anniversary23Data:IsAnniversary23BrotatoSectorId(stageCfg.sector) then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    local broatatoObjId = ctrl.actLbIntrctCtrl:GetObjId("Brotato")
    self:OpenAnniversary23Obj(broatatoObjId)
  elseif isHardLevel and eActInteract.eLbIntrctEntityId.HardLevel ~= nil then
    self:OpenAnniversary23Obj(eActInteract.eLbIntrctEntityId.HardLevel)
  elseif stageCfg ~= nil and anniversary23Data:IsAnniversary23GuardSectorId(stageCfg.sector) then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    local objId = ctrl.actLbIntrctCtrl:GetObjId("Guard")
    self:OpenAnniversary23Obj(objId)
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
    if aftertTeatmentCtrl ~= nil then
      aftertTeatmentCtrl:TeatmentBengin()
    end
  end
end

function ActivityAnniversary23Controller:IsAnniversary23Sector(sectorId)
  for actId, AWTData in pairs(self._dataDic) do
    if AWTData:IsAnniversary23Sector(sectorId) then
      return true, AWTData
    end
  end
  return false
end

function ActivityAnniversary23Controller:TryEnterAnniversary23Sector(sectorId, successCallback)
  local isWDSector, AWTData = self:IsAnniversary23Sector(sectorId)
  if isWDSector and AWTData:IsActivityRunning() then
    local actId = AWTData:GetActId()
    self:OpenAnniversary23(actId, true, successCallback)
    return true
  end
  return false
end

function ActivityAnniversary23Controller:EnterAnniversaryEp(envId, diffculty, index, stageChallengeData, changeChallengCallback)
  local envCfg = ConfigData.act_general_ep_env[envId]
  local stageId = envCfg.stage_id[index]
  if stageId == nil then
    error("env and diff can't confirm stage")
    return
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.CommonEpModeSelect)
  end
  
  local function exitFunc()
    UIManager:ShowWindowOnly(UIWindowTypeID.CommonEpModeSelect)
  end
  
  local function startBattleFunc(curSelectFormationData, callBack)
    if PlayerDataCenter.stamina:GetCurrentStamina() < stageCfg.cost_strength_num then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
      return
    end
    
    local function enterEpFunc()
      ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      if callBack then
        callBack()
      end
    end
    
    local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(curSelectFormationData)
    local curSelectFormationId = curSelectFormationData.id
    local challengeTaskIdList, isChallengeMode
    if stageChallengeData ~= nil then
      isChallengeMode = stageChallengeData:IsStageChallengeOpen()
      challengeTaskIdList = stageChallengeData:GetStgClgOptionalTaskOpenList()
    end
    PlayerDataCenter.sectorStage:SetSelectSectorId(stageCfg.sector)
    ExplorationManager:ReqEnterExploration(stageId, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, enterEpFunc, curSelectFormationData:GetSupportHeroData(), isChallengeMode, challengeTaskIdList, totalFtPower, totalBenchPower)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.SpringEp, curSelectFormationId, stageId)
  end
  
  local lastFmtId = saveUserData:GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.SpringEp, stageId)
  local isChallengeMode
  if stageChallengeData ~= nil then
    isChallengeMode = stageChallengeData:IsStageChallengeOpen()
  end
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.SpringEp, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleTicketItemId(stageCfg.cost_strength_id):SetEnterBattleCostTicketNum(stageCfg.cost_strength_num):SetFmtCtrlChallengeData(isChallengeMode, changeChallengCallback, stageChallengeData)
  fmtCtrl:EnterFormation()
end

function ActivityAnniversary23Controller:EnterAnniversaryEpQuickBattle(envId, diffculty, index)
  local envCfg = ConfigData.act_general_ep_env[envId]
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

local uiAnitime = 2

function ActivityAnniversary23Controller:TryPlayStarChapterTimeLine()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if not actLbCtrl then
    return
  end
  local starChapterTimeLineGO = CS_GameObject.Find("ChapterShowTimeLine")
  if IsNull(starChapterTimeLineGO) then
    return
  end
  self.playableDir = starChapterTimeLineGO:GetComponent(typeof(CS_PlayableDirector))
  self.playableDir.time = 0
  self.playableDir:Evaluate()
end

function ActivityAnniversary23Controller:ChangeTimeLineState(isPause, time)
  if IsNull(self.playableDir) then
    return
  end
  if isPause then
    self.playableDir:Pause()
  else
    self.playableDir:Resume()
  end
  if time then
    self.playableDir.time = time
    self.playableDir:Evaluate()
  end
end

function ActivityAnniversary23Controller:GetStoryChangeSequence()
  self:ClearStoryChangeSequence()
  self.storyChangeSequence = cs_DoTween.Sequence()
  return self.storyChangeSequence
end

function ActivityAnniversary23Controller:ClearStoryChangeSequence()
  if self.storyChangeSequence ~= nil then
    self.storyChangeSequence:Kill()
    self.storyChangeSequence = nil
  end
end

function ActivityAnniversary23Controller:IsNeedRefreshText(nowNum, targetNum)
  local lastNowNum, lastTargetNum = self.nowProgressNum, self.targetProgressNum
  self:SetProgressValue(nowNum, targetNum)
  if lastNowNum == nil then
    return false, false
  end
  if lastTargetNum ~= targetNum then
    return true, true
  end
  if lastNowNum < lastTargetNum and targetNum <= nowNum then
    return true, true
  end
  if lastNowNum < lastTargetNum and lastNowNum ~= nowNum then
    return true, false
  end
  return false, false
end

function ActivityAnniversary23Controller:SetProgressValue(nowNum, targetNum)
  self.nowProgressNum = nowNum
  self.targetProgressNum = targetNum
end

function ActivityAnniversary23Controller:IsCanPlayStoryUnLockSequence(storyBpId)
  local storyList = ConfigData.activity_general_story_bp[storyBpId].story_id
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local nowNum = 0
  local targetNum = 0
  for i, storyId in ipairs(storyList) do
    local avgCfg = ConfigData.story_avg[storyId]
    if not avgCfg then
      error("avg Id:" .. tostring(storyId) .. "not have avg")
    end
    if avgCfg.pre_condition[1] == CheckerTypeId.ActivityGeneralNormal then
      targetNum = targetNum + 1
      local taskId = avgCfg.pre_para1[1]
      if actFrameCtrl:isCompleteActivityTask(taskId) then
        nowNum = nowNum + 1
      else
        break
      end
    end
  end
  local needFresh, isChange = self:IsNeedRefreshText(nowNum, targetNum)
  if not needFresh then
    return false
  end
  if not isChange then
    return false
  end
  return true
end

function ActivityAnniversary23Controller:GetIsOpenByResultWithBrotato()
  return self.isOpenByBattleResult or false
end

function ActivityAnniversary23Controller:SetIsOpenByResultWithBrotato(bValue)
  self.isOpenByBattleResult = bValue
end

function ActivityAnniversary23Controller:GetActTaskIsJump()
  return self.isTaskJump
end

function ActivityAnniversary23Controller:SetActTaskIsJump(bool)
  self.isTaskJump = bool
end

return ActivityAnniversary23Controller
