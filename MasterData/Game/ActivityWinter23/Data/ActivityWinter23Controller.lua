local ActivityWinter23Controller = class("ActivityWinter23Controller", ControllerBase)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityWinter23Data = require("Game.ActivityWinter23.Data.ActivityWinter23Data")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local eActInteract23Winter = require("Game.ActivityLobby.Activity.2023Winter.eActInteract")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")

function ActivityWinter23Controller:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_winter23_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_lobby_interact_action)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_general_env)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_stage_info)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season)
  self._dataDic = {}
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.__AvgStageChangeCallback = BindCallback(self, self.__AvgStateChange)
  MsgCenter:AddListener(eMsgEventId.OnMainAvgStateChange, self.__AvgStageChangeCallback)
end

function ActivityWinter23Controller:AddWinter23(msg)
  local frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameData = frameCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.Winter23, msg.actId)
  if frameData == nil or not frameData:IsActivityOpen() then
    return
  end
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ActivityWinter23Data.New()
  self._dataDic[msg.actId] = data
  data:InitWinter23Data(msg)
  WarChessSeasonManager:RefreshWCSPassedTowerData(data:GetWinter23WarchessSeasonId())
end

function ActivityWinter23Controller:UpdateWinter23(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateWinter23Data(msg)
end

function ActivityWinter23Controller:RemoveWinter23(actId)
  self._dataDic[actId] = nil
end

function ActivityWinter23Controller:IsHaveWinter23()
  return table.count(self._dataDic) > 0
end

function ActivityWinter23Controller:GetWinter23Data()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActivityWinter23Controller:GetWinter23DataByActId(actId)
  return self._dataDic[actId]
end

function ActivityWinter23Controller:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_winter23_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby_interact_action)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_general_env)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_stage_info)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnMainAvgStateChange, self.__AvgStageChangeCallback)
end

function ActivityWinter23Controller:__AvgStateChange()
  for _, data in pairs(self._dataDic) do
    data:RefreshRedWinter23Main()
  end
end

function ActivityWinter23Controller:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local dailyTaskData = data:GetWinter23DailyTaskData()
    if dailyTaskData ~= nil and dailyTaskData:IsExitInDailyTask(taskData.id) then
      data:RefreshRedWinter23DailyTask()
    else
      local termTaskData = data:GetWinter23TermTaskData()
      if termTaskData:IsExitInTermTask(taskData.id) then
        data:RefreshRedWnter23OnceTask()
      else
      end
    end
  end
end

function ActivityWinter23Controller:__ItemUpdate(_, _, itemDic)
  for _, data in pairs(self._dataDic) do
    local techTree = data:GetWinter23TechTree()
    if techTree ~= nil then
      local techTypeCostDic = techTree:GetTechTypeCostDic()
      for itemId, _ in pairs(techTypeCostDic) do
        if itemDic[itemId] ~= nil then
          data:RefreshRedWinter23Tech()
          break
        end
      end
    end
  end
end

function ActivityWinter23Controller:OpenWinter23(actId, skipStartShow, callback)
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

function ActivityWinter23Controller:RunEnterCompleteFunc()
  if self._enterCompleteCallback then
    self._enterCompleteCallback()
  end
end

function ActivityWinter23Controller:OpenWinter23Obj(objId)
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
  if objId ~= nil then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    ctrl.actLbIntrctCtrl:InvokeActLbEntity(objId)
    objId = nil
  end
end

function ActivityWinter23Controller:OpenWinter23ObjByStage(stageCfg)
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actWinter23)
  local isRepeat = sectorLevelChapterCtrl:GetIsRepeat()
  local actWinter23Data = self:GetWinter23Data()
  local objId
  if actWinter23Data ~= nil and stageCfg ~= nil and actWinter23Data:IsWinter23Sector(stageCfg.sector) then
    if isRepeat then
      objId = eActInteract23Winter.eLbIntrctEntityId.Repeat
    else
      objId = eActInteract23Winter.eLbIntrctEntityId.Main
    end
  end
  self:OpenWinter23Obj(objId)
end

function ActivityWinter23Controller:IsWinter23Sector(sectorId)
  for actId, AWTData in pairs(self._dataDic) do
    if AWTData:IsWinter23Sector(sectorId) then
      return true, AWTData
    end
  end
  return false
end

function ActivityWinter23Controller:TryEnterWTSector(sectorId, successCallback)
  local isWDSector, AWTData = self:IsWinter23Sector(sectorId)
  if isWDSector and AWTData:IsActivityRunning() then
    local actId = AWTData:GetActId()
    self:OpenWinter23(actId, true, successCallback)
    return true
  end
  return false
end

function ActivityWinter23Controller:TryEnterWT23Season(seasonId, successCallback)
  for actId, AWTData in pairs(self._dataDic) do
    if AWTData:GetWinter23WarchessSeasonId() == seasonId then
      if AWTData:IsActivityRunning() then
        local actId = AWTData:GetActId()
        self:OpenWinter23(actId, true, successCallback)
        return true
      end
      break
    end
  end
  return false
end

function ActivityWinter23Controller:GetIsFirstEnterMainEp()
  local winter23Data = self:GetWinter23Data()
  local isNotFirstFlag = winter23Data:GetLastWinter23MainSector()
  return not isNotFirstFlag
end

function ActivityWinter23Controller:ReEnterWinter23MainEp(sectorId, callback)
  local winter23Data = self:GetWinter23Data()
  if sectorId == winter23Data:GetWarChessGreenHandSectorId() then
    self:EnterGreenHandWarChessSeasonLevels(sectorId, callback)
    return
  end
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local nowSectorId = sectorLevelChapterCtrl:GetSectorId()
  local chapterId = sectorLevelChapterCtrl:GetNowChapterId()
  if not nowSectorId then
    sectorLevelChapterCtrl:SetChapterBaseInfo(sectorId, false, callback)
  end
  self:EnterWinter23MainEp(sectorId, false, callback, chapterId)
end

function ActivityWinter23Controller:EnterWinter23MainEp(sectorId, isRepeat, closeCallback, chapterId)
  local winter23Data = self:GetWinter23Data()
  local win23Cfg = winter23Data:GetWinter23Cfg()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local actLongId = winter23Data:GetActFrameId()
  local repeatName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][eActInteract23Winter.eLbIntrctActionId.Repeat].obj_func_name)
  local mainName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][eActInteract23Winter.eLbIntrctActionId.Main].obj_func_name)
  sectorLevelChapterCtrl:SetRepeatName(repeatName)
  sectorLevelChapterCtrl:SetMainName(mainName)
  sectorLevelChapterCtrl:SetCloseRepeatShow(false)
  sectorLevelChapterCtrl:SetRepeatArrangeType(winter23Data:GetRepeatArrangeType())
  sectorLevelChapterCtrl:SelectDiffChangeCallback(BindCallback(self, self.SelectDiffClient))
  sectorLevelChapterCtrl:SetSectorList({
    win23Cfg.normal_sector,
    win23Cfg.hard_stage
  })
  sectorLevelChapterCtrl:SetIsFirstEnter(self:GetIsFirstEnterMainEp())
  sectorLevelChapterCtrl:EnterChapterMainEp(sectorId, isRepeat, closeCallback, chapterId)
end

function ActivityWinter23Controller:EnterGreenHandWarChessSeasonLevels(sectorId, closeCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
    if window == nil then
      return
    end
    window:InitSectorLevel(sectorId, closeCallback, 1, nil, nil, nil, nil)
    window:SetCustomEnterFmtCallback(function()
      ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    end)
  end)
end

function ActivityWinter23Controller:EnterWinter23WarChessSeasonLevelSelect(closeCallback)
  local winter23Data = self:GetWinter23Data()
  UIManager:ShowWindowAsync(UIWindowTypeID.WCSModeSelect, function(window)
    if window == nil then
      return
    end
    local seasonId = winter23Data:GetWinter23WarchessSeasonId()
    local loadSavingDataCallback = BindCallback(self, self.Winter32WCSLoadSaving)
    local startNewWCSCallback = BindCallback(self, self.EnterWinter23WarChessSeason)
    window:InitWCSModeSelect(seasonId, loadSavingDataCallback, startNewWCSCallback, closeCallback)
  end)
end

function ActivityWinter23Controller:EnterWinter23WarChessSeason(stageInfoCfg, envId)
  local winter23Data = self:GetWinter23Data()
  if not winter23Data:IsActivityRunning() then
    return
  end
  local towerId = stageInfoCfg.season_id
  local seasonId = winter23Data:GetWinter23WarchessSeasonId()
  ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
  WarChessSeasonManager:EnterWarChessSeasonBySeasonGroupId(seasonId, towerId, envId or 0)
  self:__SetWinter23EnterrChessSeasonData(winter23Data, stageInfoCfg, seasonId, envId)
end

function ActivityWinter23Controller:Winter32WCSLoadSaving(archive)
  local winter23Data = self:GetWinter23Data()
  local seasonId = winter23Data:GetWinter23WarchessSeasonId()
  local towerId = archive.warChessTowerId
  local stageInfoCfg = WarChessSeasonManager:GetWCSStageInfoByTowerId(seasonId, towerId)
  local envCfg = WarChessSeasonManager:GetWCSEnvIdByTowerId(seasonId, towerId)
  if stageInfoCfg ~= nil then
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    WarChessSeasonManager:ReadWCSSavingData(archive.warChessSeasonbackUpId)
    self:__SetWinter23EnterrChessSeasonData(winter23Data, stageInfoCfg, seasonId, envCfg.id)
  end
end

function ActivityWinter23Controller:ContinuehallowmasSeason()
  local isUnComplete, wcsdata = WarChessSeasonManager:GetUncompleteWCSData()
  if not isUnComplete then
    return
  end
  local winter23Data = self:GetWinter23Data()
  local seasonId = winter23Data:GetWinter23WarchessSeasonId()
  local towerId = wcsdata.towerId
  local stageInfoCfg = WarChessSeasonManager:GetWCSStageInfoByTowerId(seasonId, towerId)
  local envCfg = WarChessSeasonManager:GetWCSEnvIdByTowerId(seasonId, towerId)
  if stageInfoCfg ~= nil then
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    WarChessSeasonManager:WCSReconnect()
    self:__SetWinter23EnterrChessSeasonData(winter23Data, stageInfoCfg, seasonId, envCfg.id)
  end
end

function ActivityWinter23Controller:__SetWinter23EnterrChessSeasonData(winter23Data, stageInfoCfg, seasonId, envId)
  local addtionData = winter23Data:GetHallowmasSeasonAddtion()
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

function ActivityWinter23Controller:ChangeWinter23MainEpRepeat(chapterId)
  if self.repeatLevel then
    self.repeatLevel = false
  else
    self.repeatLevel = true
  end
  local detailWin = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if detailWin and detailWin.active then
    UIUtil.OnClickBackByUiTab(self)
  end
  self:_FinEnterMainEp(chapterId)
  return self.repeatLevel
end

function ActivityWinter23Controller:RecordNowStageId(stageId)
  self.nowStageId = stageId
end

function ActivityWinter23Controller:SendRecordEnterInterface()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local isRepeat = sectorLevelChapterCtrl:GetIsRepeat()
  local interfaceId = isRepeat and 2 or 1
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_Client_Enter_Interface(interfaceId, self.nowStageId)
end

function ActivityWinter23Controller:SetActWin23TipMode(isTipRepeat)
  self.isTipRepeat = isTipRepeat
end

function ActivityWinter23Controller:GetActWin23NameAndMode()
  local actName, tipName
  if self.isTipRepeat then
    actName, tipName = self:GetActWin23NameAndRepeatMode()
  else
    actName, tipName = self:GetActWin23NameAndMainMode()
  end
  return actName, tipName
end

function ActivityWinter23Controller:GetActWin23NameAndMainMode()
  local actData = self:GetWinter23Data()
  local actLongId = actData:GetActFrameId()
  local mainName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][eActInteract23Winter.eLbIntrctActionId.Main].obj_func_name)
  return LanguageUtil.GetLocaleText(actData:GetActivityName()), mainName
end

function ActivityWinter23Controller:GetActWin23NameAndRepeatMode()
  local actData = self:GetWinter23Data()
  local actLongId = actData:GetActFrameId()
  local repeatName = LanguageUtil.GetLocaleText(ConfigData.activity_lobby_interact_action[actLongId][eActInteract23Winter.eLbIntrctActionId.Repeat].obj_func_name)
  return LanguageUtil.GetLocaleText(actData:GetActivityName()), repeatName
end

function ActivityWinter23Controller:SelectDiffClient(sectorId)
  local actData = self:GetWinter23Data()
  actData:SetWinter23ClientRecordSector(sectorId)
end

return ActivityWinter23Controller
