local Activity23SteinsGateController = class("Activity23SteinsGateController", ControllerBase)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local Activity23SteinsGateData = require("Game.Activity23SteinsGate.Data.Act23SteinsGateData")
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local cs_MessageCommon = CS.MessageCommon
local CS_GameObject = CS.UnityEngine.GameObject
local CS_PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local JumpManager = require("Game.Jump.JumpManager")
local FmtEnum = require("Game.Formation.FmtEnum")
local eActInteract = require("Game.ActivityLobby.Activity.2023SteinsGate.eActInteract")
local Act23SGPerformUtil = require("Game.Activity23SteinsGate.Act23SteinsGatePerformUtil")
local Act23SteinsGateEnum = require("Game.Activity23SteinsGate.Data.Act23SteinsGateEnum")

function Activity23SteinsGateController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_storyline)
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_map)
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_line)
  ConfigData:LoadDynCfg(eDynConfigData.activity_interact)
  ConfigData:LoadDynCfg(eDynConfigData.activity_interact_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_diff)
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_interact_icon)
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_character_switch)
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_professor_sex)
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_avg_text)
  ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_lobby_effect)
  self._dataDic = {}
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.__AvgStageChangeCallback = BindCallback(self, self.__AvgStateChange)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__AvgStageChangeCallback)
  self.__OnSectorStageUpdateCallback = BindCallback(self, self.__OnSectorStageUpdate)
  MsgCenter:AddListener(eMsgEventId.SectorStateUpdate, self.__OnSectorStageUpdateCallback)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__OnSectorStageUpdateCallback)
end

function Activity23SteinsGateController:AddSteinsGate(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = Activity23SteinsGateData.New()
  self._dataDic[msg.actId] = data
  data:InitAct23SteinsGateData(msg)
end

function Activity23SteinsGateController:UpdateSteinsGate(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateSteinsGateData(msg)
end

function Activity23SteinsGateController:RemoveSteinsGate(actId)
  self._dataDic[actId] = nil
end

function Activity23SteinsGateController:IsHaveSteinsGate()
  return table.count(self._dataDic) > 0
end

function Activity23SteinsGateController:GetSteinsGateData()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function Activity23SteinsGateController:GetSteinsGateDataByActId(actId)
  return self._dataDic[actId]
end

function Activity23SteinsGateController:GetActSteinsGateDataByFrameId(actFrameId)
  for k, data in pairs(self._dataDic) do
    if data:GetActFrameId() == actFrameId then
      return data
    end
  end
  return nil
end

function Activity23SteinsGateController:OnDelete()
  self:CloseCmderTimeLine()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_storyline)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_map)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_line)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_diff)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_interact_icon)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_character_switch)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_professor_sex)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_avg_text)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_lobby_effect)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__AvgStageChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.SectorStateUpdate, self.__OnSectorStageUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__OnSectorStageUpdateCallback)
end

function Activity23SteinsGateController:__AvgStateChange(avgId)
end

function Activity23SteinsGateController:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local dailyTaskData = data:GetSteinsGateDailyTaskData()
    if dailyTaskData ~= nil and dailyTaskData:IsExitInDailyTask(taskData.id) then
      data:RefreshRedSteinsGateDailyTask()
    else
      local termTaskData = data:GetSteinsGateTermTaskData()
      if termTaskData:IsExitInTermTask(taskData.id) then
        data:RefreshRedSteinsGateOnceTask()
      else
      end
    end
  end
end

function Activity23SteinsGateController:__ItemUpdate(_, _, itemDic)
end

function Activity23SteinsGateController:__OnSectorStageUpdate()
  for k, v in pairs(self._dataDic) do
    local storyData = v:GetSteinsGateStotyData()
    storyData:Act23SG_UpdateAllData()
  end
end

function Activity23SteinsGateController:PlaySGSceneLoadedFunc()
  local mask_win = UIManager:ShowWindow(UIWindowTypeID.SteinsGateCommonMask)
  if self.decoratePlayId == nil then
    return
  end
  local win = UIManager:ShowWindow(UIWindowTypeID.UI23SteinsGateScenesLoading)
  win:PlaySGScenesLoading(self.decoratePlayId)
  self.decoratePlayId = nil
end

function Activity23SteinsGateController:TryChangeSteinsGate23(paraList, isCloseMask)
  local lobbyIndex = paraList[1]
  local resetBornPara = paraList[2]
  local data = self:GetSteinsGateData()
  if data == nil or lobbyIndex == nil then
    return false
  end
  local cfg = data:GetNowSteinsGateStoryLineCfg()
  self.decoratePlayId = cfg.arg_text
  local isNotResetBorn = resetBornPara == 1
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl, true)
  ctrl:SetActLobbyIndex(lobbyIndex)
  ctrl:SetCloseChangeLobbyMask(isCloseMask)
  ctrl:ChangeActLb(isNotResetBorn)
  return true
end

function Activity23SteinsGateController:OpenSteinsGate23(actId, skipStartShow, callback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl, true)
  local mainActivityId = data:GetActFrameId()
  local cfg = data:GetNowSteinsGateStoryLineCfg()
  local lobbyIndex = self:GetActSpecialLobbyId(actId) or self:GetRecordSteinsGateWorldLineId(cfg.id) or cfg.lobby_index
  self.decoratePlayId = cfg.arg_text
  ctrl:SetMainType(ActLbEnum.LobbyMainType.SteinsGate)
  ctrl:SetActLobbyIndex(lobbyIndex)
  ctrl:SetCloseChangeLobbyMask(false)
  ctrl:InitActLobbyCtrl(mainActivityId)
  if skipStartShow then
    ctrl:SkipActLbStartShow()
  end
  self._enterCompleteCallback = callback
end

function Activity23SteinsGateController:RunEnterCompleteFunc()
  if self._enterCompleteCallback then
    self._enterCompleteCallback()
    self._enterCompleteCallback = nil
  end
end

function Activity23SteinsGateController:SetInLobbyEnter(bool)
  self.isInLobbyEnter = bool
end

function Activity23SteinsGateController:OpenSteinsGate23Obj(objId, args)
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

function Activity23SteinsGateController:IsNeedPlayCmderTimeLine()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if not actLbCtrl then
    return false
  end
  local sg23Data = self:GetSteinsGateData()
  local storyLineCfg = sg23Data:GetNowSteinsGateStoryLineCfg()
  local switchCfg = ConfigData.activity_23steinsgate_character_switch[storyLineCfg.id]
  if not switchCfg then
    return false
  end
  return true
end

function Activity23SteinsGateController:TryPlayCmderTimeLine(timeLineEndCallback)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if not actLbCtrl then
    return false
  end
  local sg23Data = self:GetSteinsGateData()
  local storyLineCfg = sg23Data:GetNowSteinsGateStoryLineCfg()
  local switchCfg = ConfigData.activity_23steinsgate_character_switch[storyLineCfg.id]
  if not switchCfg then
    return false
  end
  local starChapterTimeLineGO = CS_GameObject.Find("ChapterShowTimeLine")
  local timeLineRoot = CS_GameObject.Find("TimeLine")
  local starChapterVcam = timeLineRoot.transform:Find("Vcam/Vcam_StarChapter")
  if IsNull(starChapterTimeLineGO) then
    return false
  end
  if IsNull(starChapterVcam) then
    return false
  end
  local playableDir = starChapterTimeLineGO:GetComponent(typeof(CS_PlayableDirector))
  local entity
  local parentObjPath = switchCfg.user_before_parent
  if not string.IsNullOrEmpty(parentObjPath) then
    local parentGo = CS_GameObject.Find(parentObjPath)
    entity = parentGo.transform:Find(switchCfg.user_before_obj).gameObject
  else
    entity = CS_GameObject.Find(switchCfg.user_before_obj)
  end
  if not entity then
    return false
  end
  local pos = entity.transform.position
  pos.y = pos.y + 1.1
  pos.z = pos.z - 1.1
  starChapterVcam.transform.position = pos
  self.timeLineEndCallback = timeLineEndCallback
  if self.timeLineEndCallback then
    self.timeLineEndCallback(true)
  end
  self.cmderTimeLineCo = TimelineUtil.Play(playableDir, function()
    self:CloseCmderTimeLine()
  end, false, true)
  return true
end

function Activity23SteinsGateController:CloseCmderTimeLine()
  if self.cmderTimeLineCo ~= nil then
    TimelineUtil.StopTlCo(self.cmderTimeLineCo)
    self.cmderTimeLineCo = nil
  end
  if self.timeLineEndCallback then
    self.timeLineEndCallback(false)
    self.timeLineEndCallback = nil
  end
end

function Activity23SteinsGateController:SteinsGateOpenByStageCfg(actId, stageCfg, isWin)
  self._needShowMapStageCfg = nil
  self._lastMainEpIsWin = nil
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  if stageCfg == nil then
    return
  end
  local sectorId = stageCfg.sector
  if data:IsSteinsGateEpSectorId(sectorId) then
    self._needShowMapStageCfg = stageCfg
    self._lastMainEpIsWin = isWin
  elseif data:IsSteinsGateBrotatoSectorId(sectorId) then
    self:OpenSteinsGate23Obj(eActInteract.eLbIntrctEntityId.Brotato)
  end
end

function Activity23SteinsGateController:TryReShowSteinsGateMap(actId)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  if self._needShowMapStageCfg == nil then
    return
  end
  if self._lastMainEpIsWin then
    local storyData = data:GetSteinsGateStotyData()
    local nodeDataDic = storyData:Act23SG_GetAllNodeData()
    local diffIdx = storyData:Act23Gs_GetDiffIndex()
    if diffIdx == Act23SteinsGateEnum.eStoryDiff.Normal then
      local allComplete = true
      for k, v in pairs(nodeDataDic) do
        if not v:Act23GSSN_IsHidenNode() and not v:Act23GSSN_GetIsClear(diffIdx) then
          allComplete = false
          break
        end
      end
      if not allComplete then
        return
      end
    else
      local allComplete = true
      local existUnComplete = false
      for k, v in pairs(nodeDataDic) do
        if not v:Act23GSSN_IsHidenNode() then
          local complpete = v:Act23GSSN_GetIsClear(diffIdx)
          if v:Act23GSSN_GetIsBattleNode() and v:Act23GSSN_GetIsChoulShow() and v:Act23GSSN_GetIsUnlock(diffIdx) and not complpete then
            existUnComplete = true
            break
          end
          if not complpete then
            allComplete = false
          end
        end
      end
      if not existUnComplete and not allComplete then
        return
      end
    end
  end
  self:OpenSteinsGate23Obj(eActInteract.eLbIntrctEntityId.Main, {
    lastStage = self._needShowMapStageCfg
  })
  self._needShowMapStageCfg = nil
end

function Activity23SteinsGateController:CheckAndTalk(actId, heroId, objId, successCallback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  local interactData = data:GetSteinsGateInteractData()
  local interactCfg, cantTalk = interactData:GetNowCfgByHeroIdOrObjId(heroId, objId)
  if cantTalk then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(string.format(ConfigData:GetTipContent(9101)))
    if successCallback then
      successCallback(false)
    end
    return false
  end
  interactData:FinishTalk(interactCfg.id, function()
    local storyData = data:GetSteinsGateStotyData()
    storyData:Act23SG_UpdateAllData()
    if successCallback ~= nil then
      successCallback(true, interactCfg.id)
    end
  end)
  return true
end

function Activity23SteinsGateController:RecordSteinsGateWorldLineChange(interactId, newLobbyId)
  self.interactId = interactId
  self.newLobbyId = newLobbyId
end

function Activity23SteinsGateController:GetActSpecialLobbyId(actId)
  local data = self:GetSteinsGateDataByActId(actId)
  local mainCfg = data:GetSteinsGateCfg()
  local interactId = mainCfg.linecast_off[1]
  local lobbyId = mainCfg.linecast_off[2]
  if interactId and data:GetSteinsGateInteractData():GetThisTalkStateById(interactId) then
    return lobbyId
  end
  return nil
end

function Activity23SteinsGateController:GetRecordSteinsGateWorldLineId(interactId)
  if interactId == self.interactId then
    return self.newLobbyId
  end
  return nil
end

function Activity23SteinsGateController:InitSteinsGatePerform()
  self.steinsGatePerformQueue = self.steinsGatePerformQueue or {}
  table.removeall(self.steinsGatePerformQueue)
end

function Activity23SteinsGateController:InsertSteinsGatePerform(func)
  self.steinsGatePerformQueue = self.steinsGatePerformQueue or {}
  table.insert(self.steinsGatePerformQueue, func)
end

function Activity23SteinsGateController:RunSteinsGatePerform()
  if not self.steinsGatePerformQueue or #self.steinsGatePerformQueue == 0 then
    return
  end
  local func = self.steinsGatePerformQueue[1]
  table.remove(self.steinsGatePerformQueue, 1)
  func()
end

function Activity23SteinsGateController:IsEmptySteinsGatePerformQueue()
  return self.steinsGatePerformQueue == nil or #self.steinsGatePerformQueue == 0
end

function Activity23SteinsGateController:GetIsOpenByResultWithBrotato()
  return self.isOpenByBattleResult or false
end

function Activity23SteinsGateController:SetIsOpenByResultWithBrotato(bValue)
  self.isOpenByBattleResult = bValue
end

return Activity23SteinsGateController
