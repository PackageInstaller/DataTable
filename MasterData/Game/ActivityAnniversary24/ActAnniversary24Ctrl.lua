local base = require("Game.Common.Activity.Lobby.ActLobbyCtrlBase")
local ActAnniversary24Ctrl = class("ActAnniversary24Ctrl", base)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActAnniversary24Data = require("Game.ActivityAnniversary24.Data.ActAnniversary24Data")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local cs_MessageCommon = CS.MessageCommon
local FmtEnum = require("Game.Formation.FmtEnum")
local JumpManager = require("Game.Jump.JumpManager")
local eActInteract = require("Game.ActivityLobby.Activity.2024Activity.2024Anniversary.eActInteract")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local eReinforce = require("Game.Reinforce.Enum.eReinforce")
local FormationUtil = require("Game.Formation.FormationUtil")
local CS_GameObject = CS.UnityEngine.GameObject
local CS_PlayableDirector = CS.UnityEngine.Playables.PlayableDirector

function ActAnniversary24Ctrl:OnInit()
  base.OnInit(self)
end

function ActAnniversary24Ctrl:AddActData(msg)
  base.AddActData(self, msg)
  local actData = self._dataDic[msg.actId]
  if actData ~= nil then
    local rfDataAll = actData:GetActAnv24RfCardDataAll()
    ReinforceUtil.ReqRfCardFactorData(rfDataAll)
    ReinforceUtil.ReqRfCardGroupData(rfDataAll)
  end
end

function ActAnniversary24Ctrl:DiffActAnv24Ctrl(msg)
  for k, v in ipairs(msg.data) do
    local actData = self:GetActDataByActId(v.actId)
    if actData then
      actData:UpdateAnniversary24Data(v)
    end
  end
end

function ActAnniversary24Ctrl:NewActData()
  local data = ActAnniversary24Data.New()
  return data
end

function ActAnniversary24Ctrl:LoadAllCfg()
  ConfigData:LoadDynCfg(eDynConfigData.activity_anniversary24_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_anniversary24_lobby_surprise)
  ConfigData:LoadDynCfg(eDynConfigData.activity_anniversary24_talk_surprise)
  ReinforceUtil.LoadReinforceCfg()
end

function ActAnniversary24Ctrl:LoadAllListener()
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self.__OnCardSysChangeCallback = BindCallback(self, self.__OnCardSysChange)
  MsgCenter:AddListener(eMsgEventId.ReinforceCardSysChange, self.__OnCardSysChangeCallback)
  self.__AvgStageChangeCallback = BindCallback(self, self.__AvgStateChange)
  MsgCenter:AddListener(eMsgEventId.OnMainAvgStateChange, self.__AvgStageChangeCallback)
end

function ActAnniversary24Ctrl:UnLoadAllCfg()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_anniversary24_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_anniversary24_lobby_surprise)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_anniversary24_talk_surprise)
  ReinforceUtil.UnloadReinforceCfg()
end

function ActAnniversary24Ctrl:UnLoadAllListener()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.ReinforceCardSysChange, self.__OnCardSysChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.OnMainAvgStateChange, self.__AvgStageChangeCallback)
end

function ActAnniversary24Ctrl:GetNowLobbyId(data)
  local startId = 1
  local midId = 2
  local endId = 3
  local actFrameId = data:GetActFrameId()
  local surpriseCfg = ConfigData.activity_anniversary24_lobby_surprise[actFrameId]
  if surpriseCfg[endId] ~= nil then
    local cfg = surpriseCfg[endId]
    local stageId = cfg.surprise_param[1]
    local isComplete = PlayerDataCenter.sectorStage:IsStageComplete(stageId)
    if isComplete then
      return cfg.lobby_id
    end
  end
  if surpriseCfg[midId] ~= nil then
    local cfg = surpriseCfg[midId]
    local stageId = cfg.surprise_param[1]
    local isComplete = PlayerDataCenter.sectorStage:IsStageComplete(stageId)
    if isComplete then
      return cfg.lobby_id
    end
  end
  if surpriseCfg[startId] ~= nil then
    local cfg = surpriseCfg[startId]
    local stageId = cfg.surprise_param[1]
    local isComplete = PlayerDataCenter.sectorStage:IsStageComplete(stageId)
    if isComplete then
      return cfg.lobby_id
    end
  end
  return nil
end

function ActAnniversary24Ctrl:Anniversary24OpenByStage(actId, stageCfg)
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actAnniversary24)
  local isRepeat = sectorLevelChapterCtrl:GetIsRepeat()
  local actAnniversary24Data = self:GetActDataByActId(actId)
  local objId
  local playType = 0
  if self:CheckIsNeedPlaySceneChange(actAnniversary24Data) then
    return
  end
  if actAnniversary24Data ~= nil and stageCfg ~= nil then
    if actAnniversary24Data:IsAnniversary24Sector(stageCfg.sector) then
      if isRepeat then
        objId = eActInteract.eLbIntrctEntityId.Repeat
      else
        objId = eActInteract.eLbIntrctEntityId.Main
      end
    end
    if objId == nil and actAnniversary24Data:IsAnniversary24DunSector(stageCfg.sector) then
      playType = self:GetStageWhichPlayType(stageCfg, actAnniversary24Data)
      objId = eActInteract.eLbIntrctEntityId.Dungeon
    end
  end
  self:OpenActLobbyObj(objId, {playType = playType})
end

function ActAnniversary24Ctrl:CheckIsNeedPlaySceneChange(actData)
  local actFrameId = actData:GetActFrameId()
  local cfgList = ConfigData.activity_anniversary24_lobby_surprise[actFrameId]
  local performId = actData:GetAnni24PerformId()
  local cfg = cfgList[3]
  if performId < 3 and PlayerDataCenter.sectorStage:IsStageComplete(cfg.surprise_param[1]) then
    self.performId = 3
    self.isPlayPerform = true
    return true
  end
  cfg = cfgList[2]
  if performId < 2 and PlayerDataCenter.sectorStage:IsStageComplete(cfg.surprise_param[1]) then
    self.performId = 2
    self.isPlayPerform = true
    return true
  end
  return false
end

function ActAnniversary24Ctrl:RunEnterCompleteFunc(actData)
  base.RunEnterCompleteFunc(self)
  self:PlayAnni24LobbyPerform(actData)
end

local performTimeLineId = 3

function ActAnniversary24Ctrl:PlayAnni24LobbyPerform(actData)
  if not self.isPlayPerform then
    return
  end
  local actFrameId = actData:GetActFrameId()
  local cfgList = ConfigData.activity_anniversary24_lobby_surprise[actFrameId]
  local nameList = {}
  for i, cfg in pairs(cfgList) do
    table.insert(nameList, cfg.lobby_name)
  end
  
  local function unlockFunc()
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityAnniversary23Unlock, function(win)
      if not win then
        return
      end
      win:InitCommonUnlock(nameList, self.performId, function()
      end, nil, 2)
    end)
    actData:SetAnni24PerformId(self.performId)
    self.isPlayPerform = false
  end
  
  if self.performId == performTimeLineId then
    local startTimeLineGO = CS_GameObject.Find("StartTimeLine")
    if IsNull(startTimeLineGO) then
      unlockFunc()
      return
    end
    local playableDir = startTimeLineGO:GetComponent(typeof(CS_PlayableDirector))
    UIUtil.AddOneCover("Anni24PlayTimeLine")
    ActLbUtil.OnActLbInteractEnter(true)
    self.startTimeLineCo = TimelineUtil.Play(playableDir, function()
      unlockFunc()
      ActLbUtil.OnActLbInteractEnter(false)
      self:CloseStartTimeLine()
    end, false, true)
  else
    unlockFunc()
  end
end

function ActAnniversary24Ctrl:CloseStartTimeLine()
  if self.startTimeLineCo then
    UIUtil.CloseOneCover("Anni24PlayTimeLine")
    self.startTimeLineCo = nil
  end
end

function ActAnniversary24Ctrl:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local dailyTaskData = data:GetAnniversary24DailyTaskData()
    if dailyTaskData ~= nil and dailyTaskData:IsExitInDailyTask(taskData.id) then
      data:RefreshRedAnniversary24DailyTask()
    else
      local termTaskData = data:GetAnniversary24TermTaskData()
      if termTaskData:IsExitInTermTask(taskData.id) then
        data:RefreshRedAnniversary24OnceTask()
      else
      end
    end
  end
end

function ActAnniversary24Ctrl:__OnCardSysChange()
  local anni24Data = self:GetActFirstData()
  anni24Data:RefreshRedAnni24HandBookCollection()
end

function ActAnniversary24Ctrl:__AvgStateChange()
  for _, data in pairs(self._dataDic) do
    data:RefreshRedAnni24Main()
  end
end

function ActAnniversary24Ctrl:GetIsFirstEnterMainEp()
  local anni24Data = self:GetActFirstData()
  local isNotFirstFlag = anni24Data:GetLastAnniversary24MainSector()
  return not isNotFirstFlag
end

function ActAnniversary24Ctrl:ReEnterAnniversary24MainEp(sectorId, callback)
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local nowSectorId = sectorLevelChapterCtrl:GetSectorId()
  local chapterId = sectorLevelChapterCtrl:GetNowChapterId()
  if not nowSectorId then
    sectorLevelChapterCtrl:SetChapterBaseInfo(sectorId, false, callback)
  end
  self:EnterAnniversary24MainEp(sectorId, false, callback, chapterId)
end

function ActAnniversary24Ctrl:EnterAnniversary24MainEp(sectorId, isRepeat, closeCallback, chapterId, isSpecialShowChapter, eActInteract, sectorStageId)
  local anni24Data = self:GetActFirstData()
  local anni24Cfg = anni24Data:GetAnniversary24Cfg()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  self.nowChapter = sectorLevelChapterCtrl:GetLastUnCompleteChapter(anni24Cfg.normal_sector)
  local actLongId = anni24Data:GetActFrameId()
  local realEActInteract = eActInteract or eActInteract
  if ConfigData.activity_lobby_index == nil then
    ConfigData:LoadDynCfg(eDynConfigData.activity_lobby_index)
  end
  if ConfigData.activity_lobby_interact_action == nil then
    ConfigData:LoadDynCfg(eDynConfigData.activity_lobby_interact_action)
  end
  local lobbyId = ConfigData.activity_lobby_index[actLongId][1].lobby_id
  local repeatName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[lobbyId][realEActInteract.eLbIntrctActionId.Repeat].obj_func_name)
  local mainName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[lobbyId][realEActInteract.eLbIntrctActionId.Main].obj_func_name)
  sectorLevelChapterCtrl:SetRepeatName(repeatName)
  sectorLevelChapterCtrl:SetMainName(mainName)
  sectorLevelChapterCtrl:SetCloseRepeatShow(false)
  sectorLevelChapterCtrl:SetRepeatArrangeType(anni24Data:GetRepeatArrangeType())
  sectorLevelChapterCtrl:SelectDiffChangeCallback(BindCallback(self, self.SelectDiffClient))
  sectorLevelChapterCtrl:SetSectorList({
    anni24Cfg.normal_sector,
    anni24Cfg.hard_stage
  })
  sectorLevelChapterCtrl:SetIsFirstEnter(self:GetIsFirstEnterMainEp())
  sectorLevelChapterCtrl:SetIsSpecialShowChapter(isSpecialShowChapter)
  sectorLevelChapterCtrl:RecordNowStageId(sectorStageId)
  sectorLevelChapterCtrl:EnterChapterMainEp(sectorId, isRepeat, closeCallback, chapterId)
end

function ActAnniversary24Ctrl:GetActAnniversary24NameAndMainMode(eActInteract)
  local anni24Data = self:GetActFirstData()
  local realEActInteract = eActInteract
  local actLongId = anni24Data:GetActFrameId()
  local mainName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][realEActInteract.eLbIntrctActionId.Main].obj_func_name)
  return LanguageUtil.GetLocaleText(anni24Data:GetActivityName()), mainName
end

function ActAnniversary24Ctrl:GetActAnniversary24NameAndRepeatMode(eActInteract)
  local anni24Data = self:GetActFirstData()
  local realEActInteract = eActInteract
  local actLongId = anni24Data:GetActFrameId()
  local repeatName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][realEActInteract.eLbIntrctActionId.Repeat].obj_func_name)
  return LanguageUtil.GetLocaleText(anni24Data:GetActivityName()), repeatName
end

function ActAnniversary24Ctrl:SelectDiffClient(sectorId)
  local anni24Data = self:GetActFirstData()
  anni24Data:SetAnniversary24ClientRecordSector(sectorId)
end

function ActAnniversary24Ctrl:CheckStageIsThisPlayType(stageCfg, type, actData)
  local actFrameId = actData:GetActFrameId()
  if type == eReinforce.dunPlayType.infiniteLevel then
    local cfgDic = ConfigData.reinforce_exploration_verify_exploration[actFrameId]
    for id, cfg in pairs(cfgDic) do
      if stageCfg.id == id and cfg.infinite_score == 1 then
        return true
      end
    end
  elseif type == eReinforce.dunPlayType.HardLevel then
    local cfgDic = ConfigData.reinforce_exploration_verify_exploration[actFrameId]
    for id, cfg in pairs(cfgDic) do
      if stageCfg.id == id and cfg.infinite_score == 0 then
        return true
      end
    end
  else
    local cfgDic = ConfigData.reinforce_exploration_continue_diff[actFrameId]
    for id, cfg in pairs(cfgDic) do
      if stageCfg.id == cfg.stage_id then
        return true
      end
    end
  end
  return false
end

function ActAnniversary24Ctrl:GetStageWhichPlayType(stageCfg, actData)
  local actFrameId = actData:GetActFrameId()
  local cfgDic = ConfigData.reinforce_exploration_verify_exploration[actFrameId]
  for id, cfg in pairs(cfgDic) do
    if stageCfg.id == id and cfg.infinite_score == 1 then
      return eReinforce.dunPlayType.infiniteLevel
    end
  end
  for id, cfg in pairs(cfgDic) do
    if stageCfg.id == id and cfg.infinite_score == 0 then
      return eReinforce.dunPlayType.HardLevel
    end
  end
  local cfgConDic = ConfigData.reinforce_exploration_continue_diff[actFrameId]
  for id, cfg in pairs(cfgConDic) do
    if stageCfg.id == cfg.stage_id then
      return eReinforce.dunPlayType.repeatLevel
    end
  end
  return 0
end

function ActAnniversary24Ctrl:PreOpenPlayModule(playModule, actData, closeFunc)
  local sectorId = ConfigData.reinforce_exploration_main[actData:GetActFrameId()].continue_sector
  local unCompleteCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Ep)
  if unCompleteCfg then
    if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      if closeFunc then
        closeFunc()
      end
    else
      local isPlayType = self:CheckStageIsThisPlayType(unCompleteCfg, playModule, actData)
      if isPlayType then
        ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
        SectorStageDetailHelper.ContinueUncompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
      else
        SectorStageDetailHelper.TryToShowCurrentLevelTips(SectorStageDetailHelper.PlayMoudleType.Ep)
        if closeFunc then
          closeFunc()
        end
      end
    end
    return false
  end
  return true
end

function ActAnniversary24Ctrl:OpenReinforceCardSet(actData, closeFunc)
  local isContinue = self:PreOpenPlayModule(eReinforce.dunPlayType.repeatLevel, actData, closeFunc)
  if not isContinue then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardSet, function(win)
    if win == nil then
      return
    end
    win:InitReinforceCardSet(actData, closeFunc)
  end)
end

function ActAnniversary24Ctrl:EnterAnniversaryEp(actData, diffId, cardList, factorId, supportfacCardUID)
  local actFrameId = actData:GetActFrameId()
  local diffCfg = ConfigData.reinforce_exploration_continue_diff[actFrameId][diffId]
  local stageId = diffCfg.stage_id
  if stageId == nil then
    error("diff can't confirm stage")
    return
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.UIReinforceCardSet)
  end
  
  local function exitFunc()
    UIManager:ShowWindowOnly(UIWindowTypeID.UIReinforceCardSet)
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
    PlayerDataCenter.sectorStage:SetSelectSectorId(stageCfg.sector)
    local reinforceCardData = {
      reinforceCardId = cardList,
      reinforceDiffId = diffId,
      factorCardId = factorId,
      supportfacCardUID = supportfacCardUID
    }
    ExplorationManager:ReqEnterExploration(stageId, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, enterEpFunc, curSelectFormationData:GetSupportHeroData(), false, nil, totalFtPower, totalBenchPower, nil, nil, nil, reinforceCardData)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ContinueAct24, curSelectFormationId, stageId)
  end
  
  local effectNum = ReinforceUtil.CalEffectBySelectCardId(cardList, factorId, supportfacCardUID, actFrameId, diffId)
  local lastFmtId = saveUserData:GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ContinueAct24, stageId)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.ContinueAct24, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetContinueRecBattlePow(effectNum):SetEnterBattleTicketItemId(stageCfg.cost_strength_id):SetEnterBattleCostTicketNum(stageCfg.cost_strength_num)
  fmtCtrl:EnterFormation()
end

function ActAnniversary24Ctrl:OpenReinforceCardDun(actData, closeFunc, isInfinityBlood)
  local isContinue = self:PreOpenPlayModule(isInfinityBlood and eReinforce.dunPlayType.infiniteLevel or eReinforce.dunPlayType.HardLevel, actData, closeFunc)
  if not isContinue then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDun, function(win)
    if win == nil then
      return
    end
    win:InitReinforceDun(actData, isInfinityBlood, closeFunc)
  end)
end

function ActAnniversary24Ctrl:EnterAnniversaryCardDunEp(stageId, factCardData, isHighEp, layerLevel)
  if stageId == nil then
    error("diff can't confirm stage")
    return
  end
  local factorId
  if factCardData ~= nil then
    factorId = factCardData:GetRfCdFactorOrder()
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.UIReinforceCardDun)
  end
  
  local function exitFunc()
    UIManager:ShowWindowOnly(UIWindowTypeID.UIReinforceCardDun)
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
    local reinforceCardData = {
      reinforceCardId = nil,
      reinforceDiffId = nil,
      factorCardId = factorId,
      highExploration = true,
      layerLevel = layerLevel
    }
    ExplorationManager:ReqEnterExploration(stageId, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, enterEpFunc, curSelectFormationData:GetSupportHeroData(), false, nil, totalFtPower, totalBenchPower, nil, nil, nil, reinforceCardData)
  end
  
  local fmtId = FormationUtil.GetFmtIdOffsetByFmtFromModule(FmtEnum.eFmtFromModule.Infinity4Act24) + 1
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.Infinity4Act24, stageId, fmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleTicketItemId(stageCfg.cost_strength_id):SetEnterBattleCostTicketNum(stageCfg.cost_strength_num):SetEpInifinity424ActData(factCardData)
  fmtCtrl:EnterFormation()
end

function ActAnniversary24Ctrl:OnDelete()
  if self.startTimeLineCo ~= nil then
    TimelineUtil.StopTlCo(self.startTimeLineCo)
    self:CloseStartTimeLine()
  end
  base.OnDelete(self)
end

return ActAnniversary24Ctrl
