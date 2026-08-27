local base = require("Game.Common.Activity.Lobby.ActLobbyCtrlBase")
local ActivityCarnival24Controller = class("ActivityCarnival24Controller", base)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityCarnival24Data = require("Game.ActivityCarnival24.Data.ActivityCarnival24Data")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local PeridicFmtBuffSelectDataNew = require("Game.PeriodicChallengeNew.PeridicFmtBuffSelectDataNew")
local cs_MessageCommon = CS.MessageCommon
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local FmtEnum = require("Game.Formation.FmtEnum")
local JumpManager = require("Game.Jump.JumpManager")
local eActInteract = require("Game.ActivityLobby.Activity.2024Activity.2024Carnival.eActInteract")

function ActivityCarnival24Controller:OnInit()
  base.OnInit(self)
end

function ActivityCarnival24Controller:NewActData()
  local data = ActivityCarnival24Data.New()
  return data
end

function ActivityCarnival24Controller:LoadAllCfg()
  ConfigData:LoadDynCfg(eDynConfigData.activity_carnival24_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_monster_card)
  ConfigData:LoadDynCfg(eDynConfigData.activity_monster_card_card)
  ConfigData:LoadDynCfg(eDynConfigData.activity_monster_card_card_level)
  ConfigData:LoadDynCfg(eDynConfigData.activity_monster_card_label)
  ConfigData:LoadDynCfg(eDynConfigData.activity_general_act_bp)
end

function ActivityCarnival24Controller:LoadAllListener()
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  self.__OnRankScoreChangeCallback = BindCallback(self, self.__OnRankScoreChange)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:AddListener(eMsgEventId.ActivityRankScoreChange, self.__OnRankScoreChangeCallback)
end

function ActivityCarnival24Controller:UnLoadAllCfg()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_carnival24_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_monster_card)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_monster_card_card)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_monster_card_card_level)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_monster_card_label)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_general_act_bp)
end

function ActivityCarnival24Controller:UnLoadAllListener()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityRankScoreChange, self.__OnRankScoreChangeCallback)
end

function ActivityCarnival24Controller:TryOpenActLobby(actId, skipStartShow, callback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl, true)
  local mainActivityId = data:GetActFrameId()
  local lobbyData = self:GetNowLobbyData(actId)
  ctrl:SetActLobbyIndex(lobbyData.lobbyId)
  ctrl:SetCloseChangeLobbyMask(false)
  ctrl:InitActLobbyCtrl(mainActivityId)
  if skipStartShow then
    ctrl:SkipActLbStartShow()
  end
  self._enterCompleteCallback = callback
end

function ActivityCarnival24Controller:TryChangeLobby(actId, callBack)
  actId = actId or 1
  local lobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if lobbyCtrl == nil then
    return
  end
  local lobbyId = lobbyCtrl:GetActLobbyIndex()
  local lobbyData = self:GetNowLobbyData(actId)
  if lobbyId == lobbyData.lobbyId then
    return
  end
  if callBack == nil then
    function callBack()
      self:ReEnterMemoryFunc(lobbyData)
    end
  end
  self._enterCompleteCallback = callBack
  lobbyCtrl:SetActLobbyIndex(lobbyData.lobbyId)
  lobbyCtrl:SetCloseChangeLobbyMask(false)
  lobbyCtrl:ChangeActLb(false)
end

function ActivityCarnival24Controller:ReEnterMemoryFunc(lobbyData)
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityAnniversary23Unlock, function(win)
    if not win then
      return
    end
    win:InitCommonUnlock(lobbyData.nameList, lobbyData.index, function()
    end, function()
      self:OpenActLobbyObj(3)
    end)
  end)
end

function ActivityCarnival24Controller:GetNowLobbyData(actId)
  local actData = self:GetActDataByActId(actId)
  local lobbyData = actData:GetRecentLobbyData()
  return lobbyData
end

function ActivityCarnival24Controller:Carnival24OpenByStage(actId, stageCfg)
  local Carnival24Data = self:GetActDataByActId(actId)
  if Carnival24Data == nil then
    return
  end
  if not Carnival24Data:IsActivityRunning() then
    return
  end
  if stageCfg ~= nil and stageCfg.sector == Carnival24Data:Carnival24MainSectorId() then
    self:OpenCarnival24Obj(eActInteract.eLbIntrctEntityId.Main)
    return
  end
  if stageCfg ~= nil and stageCfg.sector == Carnival24Data:GetCarnival24StoryStageId() then
    self:OpenCarnival24Obj(eActInteract.eLbIntrctEntityId.Story)
    return
  end
end

function ActivityCarnival24Controller:OpenCarnival24Obj(objId, args)
  if objId ~= nil then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if not ctrl.actLbIntrctCtrl:GetActLbEntityIsUnlock(objId) then
      local unLockTip = ctrl.actLbIntrctCtrl:GetActLbIntrctActionUnlockTip(objId)
      cs_MessageCommon.ShowMessageTips(unLockTip)
      return
    end
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
    ctrl.actLbIntrctCtrl:InvokeActLbEntity(objId, args)
    self.isInLobbyEnter = nil
    return
  end
  if self.isInLobbyEnter then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
    self.isInLobbyEnter = nil
  end
end

function ActivityCarnival24Controller:EnterAnniversaryEp(envId, diffculty, index, stageChallengeData, changeChallengCallback, epInifinityData)
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
    
    local selectBuffIds
    local enterFmtData = fmtCtrl:GetCurEnterFmtData()
    if enterFmtData ~= nil then
      local buffSelectData = enterFmtData:GetPeridicFmtBuffSelect()
      if buffSelectData ~= nil then
        selectBuffIds = buffSelectData:GetFmtBuffSelect()
      end
    end
    local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(curSelectFormationData)
    local curSelectFormationId = curSelectFormationData.id
    local challengeTaskIdList, isChallengeMode
    if stageChallengeData ~= nil then
      isChallengeMode = stageChallengeData:IsStageChallengeOpen()
      challengeTaskIdList = stageChallengeData:GetStgClgOptionalTaskOpenList()
    end
    local inifinityData, fromModeule
    if epInifinityData ~= nil then
      local epInifinityEnvID = epInifinityData:GetEpFormationSaveDataEnvId()
      local cstDataList = curSelectFormationData:GetFmtCSTDatDic()
      inifinityData = {
        epInifinityEnvID = epInifinityEnvID,
        cstDataList = cstDataList,
        tree = curSelectFormationData:GetFmtCSTDataCurId()
      }
      fromModeule = proto_csmsg_SystemFunctionID.SystemFunctionID_InfiniteMode
    else
      saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.SpringEp, curSelectFormationId, stageId)
      fromModeule = proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration
    end
    PlayerDataCenter.sectorStage:SetSelectSectorId(stageCfg.sector)
    ExplorationManager:ReqEnterExploration(stageId, curSelectFormationId, fromModeule, false, enterEpFunc, curSelectFormationData:GetSupportHeroData(), isChallengeMode, challengeTaskIdList, totalFtPower, totalBenchPower, selectBuffIds, inifinityData, true)
  end
  
  local lastFmtId = saveUserData:GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.SpringEp, stageId)
  local isChallengeMode
  if stageChallengeData ~= nil then
    isChallengeMode = stageChallengeData:IsStageChallengeOpen()
  end
  local fmtBuffSelectData
  if epInifinityData == nil then
    fmtBuffSelectData = PeridicFmtBuffSelectDataNew.CreateFmtBuffNewByEnvSelect(diffculty)
    fmtBuffSelectData:SetFmtBuffSelect(self:GetCarnival24SelectBuffIds(diffculty))
    fmtBuffSelectData:SetSelectCallback(function(buffDic)
      self:SetCarnival24SelectBuffIds(diffculty, buffDic)
    end)
  end
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.SpringEp, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetPeridicFmtBuffSelect(fmtBuffSelectData):SetEnterBattleTicketItemId(stageCfg.cost_strength_id):SetEnterBattleCostTicketNum(stageCfg.cost_strength_num):SetIsOpenEnvBuffSelect(epInifinityData == nil):SetFmtCtrlChallengeData(isChallengeMode, changeChallengCallback, stageChallengeData):SetEpInifinityData(epInifinityData)
  fmtCtrl:EnterFormation()
end

function ActivityCarnival24Controller:EnterAnniversaryEpQuickBattle(envId, diffculty, index)
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

function ActivityCarnival24Controller:UpdateMemoryDemandPickedList(msgOri)
  local carnival24Data = self:GetActFirstData()
  for index, demandId in ipairs(msgOri.demandIds) do
    carnival24Data:UpdateMemoryDemand(msgOri.stageId, demandId, true)
  end
end

function ActivityCarnival24Controller:UpdateMemoryDemandPicked(msgOri)
  local carnival24Data = self:GetActFirstData()
  carnival24Data:UpdateMemoryDemand(msgOri.stageId, msgOri.demandId, true)
end

function ActivityCarnival24Controller:GetCarnival24SelectBuffIds(diff)
  local actData = self:GetActFirstData()
  local ids = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetCarnival24SelectBuffIds(actData:GetActId(), diff)
  return ids or {}
end

function ActivityCarnival24Controller:SetCarnival24SelectBuffIds(diff, buffDic)
  local buffIds = {}
  for id, _ in pairs(buffDic) do
    table.insert(buffIds, id)
  end
  local actData = self:GetActFirstData()
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userData:SetCarnival24SelectBuffIds(actData:GetActId(), diff, buffIds)
end

function ActivityCarnival24Controller:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local dailyTaskData = data:GetCarnival24DailyTaskData()
    if dailyTaskData ~= nil and dailyTaskData:IsExitInDailyTask(taskData.id) then
      data:RefreshRedCarnival24DailyTask()
    else
      local termTaskData = data:GetCarnival24TermTaskData()
      if termTaskData:IsExitInTermTask(taskData.id) then
        data:RefreshRedCarnival24OnceTask()
      else
      end
    end
  end
end

function ActivityCarnival24Controller:__OnRankScoreChange(rankId2ScoreDic)
  for _, data in pairs(self._dataDic) do
    data:RefreshAllInfinityRankData(rankId2ScoreDic)
  end
end

function ActivityCarnival24Controller:ShowRewardBp(closeCallback)
  local currentData = self:GetActFirstData()
  if currentData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonActRewardBp, function(window)
    if window == nil then
      return
    end
    window:InitActivityCommonRewardBp(currentData:GetRewardBpData())
    window:SetCloseCallback(closeCallback)
  end)
end

function ActivityCarnival24Controller:OnDelete()
  base.OnDelete(self)
end

return ActivityCarnival24Controller
