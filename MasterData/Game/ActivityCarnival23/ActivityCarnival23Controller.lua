local ActivityCarnival23Controller = class("ActivityCarnival23Controller", ControllerBase)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityCarnival23Data = require("Game.ActivityCarnival23.Data.ActivityCarnival23Data")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local eActInteract23Carnival = require("Game.ActivityLobby.Activity.2023Carnival.eActInteract")
local eActInteract23Summer = require("Game.ActivityLobby.Activity.2023Summer.eActInteract")
local eActInteract24Summer = require("Game.ActivityLobby.Activity.2024Activity.2024Summer.eActInteract")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local CS_GameObject = CS.UnityEngine.GameObject
local CS_PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local CtrlTypeDic = {
  carnival23 = 1,
  carnival23Repeat = 2,
  summer23 = 3,
  summer23Repeat = 4,
  summer24 = 5
}

function ActivityCarnival23Controller:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_carnival23_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_chapter_interact)
  ConfigData:LoadDynCfg(eDynConfigData.activity_chapter_skybox)
  ConfigData:LoadDynCfg(eDynConfigData.activity_carnival23_surprise)
  self._dataDic = {}
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.__AvgStageChangeCallback = BindCallback(self, self.__AvgStateChange)
  MsgCenter:AddListener(eMsgEventId.OnMainAvgStateChange, self.__AvgStageChangeCallback)
  self.__BpRunningEndCallback = BindCallback(self, self.__BpRunningEnd)
  MsgCenter:AddListener(eMsgEventId.BattlePassRunningEnd, self.__BpRunningEndCallback)
end

function ActivityCarnival23Controller:AddCarnival23(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ActivityCarnival23Data.New()
  self._dataDic[msg.actId] = data
  data:InitCarnival23Data(msg)
  local tinyGameId = data:GetCarnival23TinyGame()
  if tinyGameId == 0 then
    return
  end
  local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
  self.brotataoData = activityBrotatoLobbyCtrl:CreateBrotatoData(tinyGameId, data:GetActFrameId())
end

function ActivityCarnival23Controller:UpdateCarnival23(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateCarnival23Data(msg)
end

function ActivityCarnival23Controller:RemoveCarnival23(actId)
  self._dataDic[actId] = nil
end

function ActivityCarnival23Controller:IsHaveCarnival23()
  return table.count(self._dataDic) > 0
end

function ActivityCarnival23Controller:GetCarnival23Data()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActivityCarnival23Controller:GetBrotataoData()
  return self.brotataoData
end

function ActivityCarnival23Controller:GetCarnival23DataByActId(actId)
  return self._dataDic[actId]
end

function ActivityCarnival23Controller:OnDelete()
  self:CloseUIStarChapterTimer()
  if self.starChapterTimeLineCo ~= nil then
    TimelineUtil.StopTlCo(self.starChapterTimeLineCo)
    self:CloseStartChapterTimeLine()
  end
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_carnival23_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_chapter_interact)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_chapter_skybox)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_carnival23_surprise)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnMainAvgStateChange, self.__AvgStageChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.BattlePassRunningEnd, self.__BpRunningEndCallback)
end

function ActivityCarnival23Controller:__AvgStateChange()
  for _, data in pairs(self._dataDic) do
    data:RefreshRedCarnival23Main()
  end
end

function ActivityCarnival23Controller:__BpRunningEnd()
  for _, data in pairs(self._dataDic) do
    data:RefreshRedCarnival23ActivityBP()
  end
end

function ActivityCarnival23Controller:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local dailyTaskData = data:GetCarnival23DailyTaskData()
    if dailyTaskData ~= nil and dailyTaskData:IsExitInDailyTask(taskData.id) then
      data:RefreshRedCarnival23DailyTask()
    else
      local termTaskData = data:GetCarnival23TermTaskData()
      if termTaskData ~= nil and termTaskData:IsExitInTermTask(taskData.id) then
        data:RefreshRedCarnival23OnceTask()
      else
      end
    end
  end
end

function ActivityCarnival23Controller:__ItemUpdate(_, _, itemDic)
end

function ActivityCarnival23Controller:OpenCarnival23(actId, skipStartShow, callback)
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

function ActivityCarnival23Controller:RunEnterCompleteFunc()
  if self._enterCompleteCallback then
    self._enterCompleteCallback()
  end
  self:TryPlayStarChapterTimeLine()
end

function ActivityCarnival23Controller:OpenCarnival23Obj(objId)
  if objId ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    ctrl.actLbIntrctCtrl:InvokeActLbEntity(objId)
    objId = nil
  end
end

function ActivityCarnival23Controller:OpenCarnival23ObjByStage(stageCfg)
  local actCarnival23Data = self:GetCarnival23Data()
  local objId
  if actCarnival23Data:GetActId() == CtrlTypeDic.carnival23 or actCarnival23Data:GetActId() == CtrlTypeDic.carnival23Repeat then
    objId = self:_GetCarnival23OpenObj(stageCfg)
  elseif actCarnival23Data:GetActId() == CtrlTypeDic.summer23 or actCarnival23Data:GetActId() == CtrlTypeDic.summer23Repeat then
    objId = self:_GetSummer23OpenObj(stageCfg)
  else
    objId = self:_GetSummer24OpenObj(stageCfg)
  end
  if objId then
    self:OpenCarnival23Obj(objId)
  end
end

function ActivityCarnival23Controller:_GetSummer24OpenObj(stageCfg)
  local actCarnival23Data = self:GetCarnival23Data()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actSummer24)
  local isRepeat = sectorLevelChapterCtrl:GetIsRepeat()
  local objId
  if actCarnival23Data ~= nil and stageCfg ~= nil then
    if actCarnival23Data:GetExtraSectorId() == stageCfg.sector then
      objId = eActInteract24Summer.eLbIntrctEntityId.Guard
    end
    if actCarnival23Data:IsCarnival23Sector(stageCfg.sector) then
      if isRepeat then
        objId = eActInteract24Summer.eLbIntrctEntityId.Repeat
      else
        objId = eActInteract24Summer.eLbIntrctEntityId.Main
      end
    end
  end
  return objId
end

function ActivityCarnival23Controller:_GetCarnival23OpenObj(stageCfg)
  local actCarnival23Data = self:GetCarnival23Data()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actCarnival23)
  local isRepeat = sectorLevelChapterCtrl:GetIsRepeat()
  local objId
  if actCarnival23Data ~= nil and stageCfg ~= nil then
    if stageCfg.id == actCarnival23Data:GetCarnival23TinyGameStageId() then
      objId = eActInteract23Carnival.eLbIntrctEntityId.MiniGame
      self:SetIsOpenByResultWithBrotato(true)
    elseif actCarnival23Data:IsCarnival23Sector(stageCfg.sector) then
      if isRepeat then
        objId = eActInteract23Carnival.eLbIntrctEntityId.Repeat
      else
        objId = eActInteract23Carnival.eLbIntrctEntityId.Main
      end
    end
  end
  return objId
end

function ActivityCarnival23Controller:_GetSummer23OpenObj(stageCfg)
  if self.nowChapter == nil then
    return
  end
  local carnival23Data = self:GetCarnival23Data()
  if carnival23Data == nil then
    return
  end
  local objId
  local car23Cfg = carnival23Data:GetCarnival23Cfg()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actCarnival23)
  local isRepeat = sectorLevelChapterCtrl:GetIsRepeat()
  local nowChapter = sectorLevelChapterCtrl:GetLastUnCompleteChapter(car23Cfg.normal_sector)
  if not stageCfg or not carnival23Data:IsCarnival23Sector(stageCfg.sector) then
    return
  end
  if self.nowChapter == nowChapter then
    if isRepeat then
      objId = eActInteract23Summer.eLbIntrctEntityId.Repeat
    else
      objId = eActInteract23Summer.eLbIntrctEntityId.Main
    end
  else
    self.isPlayTimeLine = true
    sectorLevelChapterCtrl:SetNowChapterId(nil)
  end
  return objId
end

function ActivityCarnival23Controller:CloseStartChapterTimeLine()
  if self.starChapterTimeLineCo then
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    self.starChapterTimeLineCo = nil
  end
end

function ActivityCarnival23Controller:CloseUIStarChapterTimer()
  if self.chapterUITimer then
    TimerManager:StopTimer(self.chapterUITimer)
    self.chapterUITimer = nil
  end
end

local uiAniTime = 2

function ActivityCarnival23Controller:TryPlayStarChapterTimeLine()
  if not self.isPlayTimeLine then
    return
  end
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if not actLbCtrl then
    return
  end
  local starChapterTimeLineGO = CS_GameObject.Find("ChapterShowTimeLine")
  local timeLineRoot = CS_GameObject.Find("TimeLine")
  local starChapterVcam = timeLineRoot.transform:Find("Vcam/Vcam_StarChapter")
  if IsNull(starChapterTimeLineGO) then
    return
  end
  if IsNull(starChapterVcam) then
    return
  end
  local playableDir = starChapterTimeLineGO:GetComponent(typeof(CS_PlayableDirector))
  local carnival23Data = self:GetCarnival23Data()
  local actFrameId = carnival23Data:GetActFrameId()
  local cfgList = ConfigData.activity_chapter_interact[actFrameId]
  local allEntityDic = actLbCtrl.actLbIntrctCtrl:GetLbIntrctAllEntityDic()
  local entity
  for i = #cfgList, 1, -1 do
    local cfg = cfgList[i]
    if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      entity = allEntityDic[cfg.obj_id]
      break
    end
  end
  if not entity then
    return
  end
  local pos = entity.transform.position
  pos.y = pos.y + 0.5
  pos.z = pos.z - 1.5
  starChapterVcam.transform.position = pos
  local unlockWin = UIManager:ShowWindow(UIWindowTypeID.Summer23QuestUnlock)
  unlockWin:InitSummer23QuestUnlock(carnival23Data)
  self.starChapterTimeLineCo = TimelineUtil.Play(playableDir, function()
    self:CloseStartChapterTimeLine()
  end, false, true)
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(function()
    local tempUnlockWin = UIManager:GetWindow(UIWindowTypeID.Summer23QuestUnlock)
    if not tempUnlockWin or tempUnlockWin.active == false then
      return
    end
    UIManager:DeleteWindow(UIWindowTypeID.Summer23QuestUnlock)
    playableDir.time = uiAniTime
    playableDir:Evaluate()
    self:CloseUIStarChapterTimer()
  end, nil, nil, nil, false)
  self.chapterUITimer = TimerManager:StartTimer(uiAniTime, function()
    UIManager:DeleteWindow(UIWindowTypeID.Summer23QuestUnlock)
    self.chapterUITimer = nil
  end, nil, true, false)
  self.isPlayTimeLine = false
end

function ActivityCarnival23Controller:IsCarnival23Sector(sectorId)
  for actId, AWTData in pairs(self._dataDic) do
    if AWTData:IsCarnival23Sector(sectorId) then
      return true, AWTData
    end
  end
  return false
end

function ActivityCarnival23Controller:TryEnterCarnivalSector(sectorId, successCallback)
  local isWDSector, AWTData = self:IsCarnival23Sector(sectorId)
  if isWDSector and AWTData:IsActivityRunning() then
    local actId = AWTData:GetActId()
    self:OpenCarnival23(actId, true, successCallback)
    return true
  end
  return false
end

function ActivityCarnival23Controller:GetIsFirstEnterMainEp()
  local carnival23Data = self:GetCarnival23Data()
  local isNotFirstFlag = carnival23Data:GetLastCarnival23MainSector()
  return not isNotFirstFlag
end

function ActivityCarnival23Controller:ReEnterCarnival23MainEp(sectorId, callback)
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local nowSectorId = sectorLevelChapterCtrl:GetSectorId()
  local chapterId = sectorLevelChapterCtrl:GetNowChapterId()
  if not nowSectorId then
    sectorLevelChapterCtrl:SetChapterBaseInfo(sectorId, false, callback)
  end
  self:EnterCarnival23MainEp(sectorId, false, callback, chapterId)
end

function ActivityCarnival23Controller:EnterCarnival23MainEp(sectorId, isRepeat, closeCallback, chapterId, isSpecialShowChapter, eActInteract)
  local carnival23Data = self:GetCarnival23Data()
  local car23Cfg = carnival23Data:GetCarnival23Cfg()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  self.nowChapter = sectorLevelChapterCtrl:GetLastUnCompleteChapter(car23Cfg.normal_sector)
  local actLongId = carnival23Data:GetActFrameId()
  local realEActInteract = eActInteract or eActInteract23Carnival
  local repeatName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][realEActInteract.eLbIntrctActionId.Repeat].obj_func_name)
  local mainName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][realEActInteract.eLbIntrctActionId.Main].obj_func_name)
  sectorLevelChapterCtrl:SetRepeatName(repeatName)
  sectorLevelChapterCtrl:SetMainName(mainName)
  sectorLevelChapterCtrl:SetCloseRepeatShow(false)
  sectorLevelChapterCtrl:SetRepeatArrangeType(carnival23Data:GetRepeatArrangeType())
  sectorLevelChapterCtrl:SelectDiffChangeCallback(BindCallback(self, self.SelectDiffClient))
  sectorLevelChapterCtrl:SetSectorList({
    car23Cfg.normal_sector,
    car23Cfg.hard_stage
  })
  sectorLevelChapterCtrl:SetIsFirstEnter(self:GetIsFirstEnterMainEp())
  sectorLevelChapterCtrl:SetIsSpecialShowChapter(isSpecialShowChapter)
  sectorLevelChapterCtrl:EnterChapterMainEp(sectorId, isRepeat, closeCallback, chapterId)
end

function ActivityCarnival23Controller:SetActCar23TipMode(isTipRepeat)
  self.isTipRepeat = isTipRepeat
end

function ActivityCarnival23Controller:GetActCarnival23NameAndMode()
  local actName, tipName
  if self.isTipRepeat then
    actName, tipName = self:GetActCarnival23NameAndRepeatMode()
  else
    actName, tipName = self:GetActCarnival23NameAndMainMode()
  end
  return actName, tipName
end

function ActivityCarnival23Controller:GetActCarnival23NameAndMainMode(eActInteract)
  local carnival23Data = self:GetCarnival23Data()
  local realEActInteract = eActInteract or eActInteract23Carnival
  local actLongId = carnival23Data:GetActFrameId()
  local mainName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][realEActInteract.eLbIntrctActionId.Main].obj_func_name)
  return LanguageUtil.GetLocaleText(carnival23Data:GetActivityName()), mainName
end

function ActivityCarnival23Controller:GetActCarnival23NameAndRepeatMode(eActInteract)
  local carnival23Data = self:GetCarnival23Data()
  local realEActInteract = eActInteract or eActInteract23Carnival
  local actLongId = carnival23Data:GetActFrameId()
  local repeatName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][realEActInteract.eLbIntrctActionId.Repeat].obj_func_name)
  return LanguageUtil.GetLocaleText(carnival23Data:GetActivityName()), repeatName
end

function ActivityCarnival23Controller:SelectDiffClient(sectorId)
  local carnival23Data = self:GetCarnival23Data()
  carnival23Data:SetCarnival23ClientRecordSector(sectorId)
end

function ActivityCarnival23Controller:SetIsOpenByResultWithBrotato(bValue)
  self.isOpenByBattleResult = bValue
end

return ActivityCarnival23Controller
