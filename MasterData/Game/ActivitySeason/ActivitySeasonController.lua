local ActivitySeasonController = class("ActivitySeasonController", ControllerBase)
local ActivitySeasonData = require("Game.ActivitySeason.Data.ActivitySeasonData")
local eActInteractSeason = require("Game.ActivityLobby.Activity.Season.eActInteract")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local ActivitySeasonEnum = require("Game.ActivitySeason.ActivitySeasonEnum")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local FmtEnum = require("Game.Formation.FmtEnum")
local JumpManager = require("Game.Jump.JumpManager")

function ActivitySeasonController:OnInit()
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dataDic = {}
  ConfigData:LoadDynCfg(eDynConfigData.activity_season_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_season_reward)
  ConfigData:LoadDynCfg(eDynConfigData.activity_lobby_interact_action)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_general_env)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_stage_info)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season)
  ConfigData:LoadDynCfg(eDynConfigData.activity_season_battle_ex)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.__AvgCompleteCallback = BindCallback(self, self.__AvgComplete)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__AvgCompleteCallback)
  self.__OnWarChessSeasonRecordCallback = BindCallback(self, self.__OnWarChessSeasonRecord)
  MsgCenter:AddListener(eMsgEventId.WCS_WarChessSeasonRecord, self.__OnWarChessSeasonRecordCallback)
end

function ActivitySeasonController:InitSeasons(msgs)
  for _, msg in ipairs(msgs) do
    self:AddSeason(msg)
  end
end

function ActivitySeasonController:AddSeason(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ActivitySeasonData.New()
  self._dataDic[msg.actId] = data
  data:InitSeasonData(msg)
  WarChessSeasonManager:RefreshWCSPassedTowerData(data:GetSeasonId())
end

function ActivitySeasonController:UpdateSeasons(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateSeasonData(msg)
end

function ActivitySeasonController:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local dailyTaskData = data:GetSeasonDailyTaskData()
    if dailyTaskData ~= nil and dailyTaskData:IsExitInDailyTask(taskData.id) then
      data:RefreshRedSeasonDailyTask()
    else
      local termTaskData = data:GetSeasonTermTaskData()
      if termTaskData:IsExitInTermTask(taskData.id) then
        data:RefreshRedSeasonOnceTask()
      else
      end
    end
  end
end

function ActivitySeasonController:__ItemUpdate(_, _, itemDic)
  for _, data in pairs(self._dataDic) do
    local techTree = data:GeSeasonTechTree()
    if techTree ~= nil then
      local techTypeCostDic = techTree:GetTechTypeCostDic()
      for itemId, _ in pairs(techTypeCostDic) do
        if itemDic[itemId] ~= nil then
          data:RefreshRedSeasonTech()
          break
        end
      end
    end
  end
end

function ActivitySeasonController:__AvgComplete(avgId)
  for _, data in pairs(self._dataDic) do
    if data:IsSeasonSectorAvg(avgId) then
      data:RefreshRedSeasonMainStory()
    end
  end
end

function ActivitySeasonController:__OnWarChessSeasonRecord(seasonId)
  for _, data in pairs(self._dataDic) do
    if data:GetSeasonId() == seasonId then
      data:UpdateSeasonUnlockRepeat()
    end
  end
end

function ActivitySeasonController:OpenSeason(actId, skipStartShow, callback)
  local data = self._dataDic[actId]
  if data == nil then
    return false
  end
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl, true)
  local mainActivityId = data:GetSeasonMainCfg().activity_general_id
  ctrl:InitActLobbyCtrl(mainActivityId)
  if skipStartShow then
    ctrl:SkipActLbStartShow()
  end
  self._enterCompleteCallback = callback
  return true
end

function ActivitySeasonController:ShowSeasonBonus(closeCallback)
  local currentData = self:GetSeasonData()
  if currentData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivitySeasonBonus, function(window)
    if window == nil then
      return
    end
    window:InitActivitySeasonBouns(currentData)
    window:SetCloseCallback(closeCallback)
  end)
end

function ActivitySeasonController:OpenSeasonObj(objId)
  if self:GetSeasonData() == nil then
    return
  end
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
  if objId ~= nil then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if ctrl ~= nil then
      ctrl.actLbIntrctCtrl:InvokeActLbEntity(objId)
    else
      do
        local actId = self:GetSeasonData():GetActId()
        self:OpenSeason(actId, true, function()
          ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
          ctrl.actLbIntrctCtrl:InvokeActLbEntity(objId)
        end)
      end
    end
  end
end

function ActivitySeasonController:OnEnterActSeasonChallenge(dungenLevel, autoBattleCount)
  if autoBattleCount ~= nil and 0 < autoBattleCount then
    BattleDungeonManager.autoCtrl:EnterDungeonAutoModel(autoBattleCount, false)
  end
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
    UIManager:HideWindow(UIWindowTypeID.CommonActivityRepeatDungeon)
  end
  
  local function exitFunc(fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.DungeonLevelDetail, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.CommonActivityRepeatDungeon)
    if BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
      BattleDungeonManager.autoCtrl:ExitDungeonAutoModel()
    end
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = dungenLevel
    end
    commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
    local needKey = dungeonLevelData:GetConsumeKeyNum()
    local keyItemId = dungeonLevelData:GetEnterLevelCost()
    if needKey > PlayerDataCenter:GetItemCount(keyItemId) then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina, nil, nil, {
        needKey - PlayerDataCenter:GetItemCount(keyItemId)
      })
      return
    end
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ActSeasonDun, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleWinEvent(function()
      local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason, dungeonId, false, PlayerDataCenter.timestamp)
    end)
    local seasonData = self:GetSeasonData()
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local lastPlayData = LastPlayData.New():SetLPDActId(seasonData:GetActId()):SetLPDActData(seasonData):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(function()
        if seasonData:IsActivityRunning() then
          local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
          if ctrl ~= nil then
            ctrl.actLbIntrctCtrl:InvokeActLbEntity(eActInteractSeason.eLbIntrctEntityId.Repeat)
            self:SetIgnoreUnlockWinOnce()
          end
        end
      end)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local seasonCtr = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    local interfaceData = DungeonInterfaceData.CreateSpringDungeonInterface(dungeonLevelData)
    interfaceData:SetAfterClickBattleFunc(function(callback)
      callback()
    end)
    interfaceData:SetDungeonReplayInfo(startBattleFunc, needKey, keyItemId)
    seasonCtr:__ReqDungeonBattle(interfaceData, formationData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local needKey = dungenLevel:GetConsumeKeyNum()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = dungenLevel:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ActSeasonDun)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.ActSeasonDun, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey)
  fmtCtrl:EnterFormation()
end

function ActivitySeasonController:__ReqDungeonBattle(interfaceData, formationData, callBack)
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

function ActivitySeasonController:EnterGreenHandWarChessSeasonLevels(sectorId, closeCallback)
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

function ActivitySeasonController:EnterCommonSeasonWarChessSeasonLevelSelect(closeCallback)
  local seasonData = self:GetSeasonData()
  UIManager:ShowWindowAsync(UIWindowTypeID.WCSModeSelect, function(window)
    if window == nil then
      return
    end
    local seasonId = seasonData:GetSeasonId()
    local loadSavingDataCallback = BindCallback(self, self.CommonSeasonWCSLoadSaving)
    local startNewWCSCallback = BindCallback(self, self.EnterCommonSeasonWarChessSeason)
    window:InitWCSModeSelect(seasonId, loadSavingDataCallback, startNewWCSCallback, closeCallback)
  end)
end

function ActivitySeasonController:EnterCommonSeasonWarChessSeason(stageInfoCfg, envId)
  local seasonData = self:GetSeasonData()
  if not seasonData:IsActivityRunning() then
    return
  end
  local towerId = stageInfoCfg.season_id
  local seasonId = seasonData:GetSeasonId()
  ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
  WarChessSeasonManager:EnterWarChessSeasonBySeasonGroupId(seasonId, towerId, envId or 0)
  self:__SetEnterrChessSeasonData(seasonData, stageInfoCfg, seasonId, envId)
end

function ActivitySeasonController:CommonSeasonWCSLoadSaving(archive)
  local seasonData = self:GetSeasonData()
  local seasonId = seasonData:GetSeasonId()
  local towerId = archive.warChessTowerId
  local stageInfoCfg = WarChessSeasonManager:GetWCSStageInfoByTowerId(seasonId, towerId)
  local envCfg = WarChessSeasonManager:GetWCSEnvIdByTowerId(seasonId, towerId)
  if stageInfoCfg ~= nil then
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    WarChessSeasonManager:ReadWCSSavingData(archive.warChessSeasonbackUpId)
    self:__SetEnterrChessSeasonData(seasonData, stageInfoCfg, seasonId, envCfg.id)
  end
end

function ActivitySeasonController:ContinueSeason()
  local isUnComplete, wcsdata = WarChessSeasonManager:GetUncompleteWCSData()
  if not isUnComplete then
    return
  end
  local seasonData = self:GetSeasonData()
  local seasonId = seasonData:GetSeasonId()
  local towerId = wcsdata.towerId
  local stageInfoCfg = WarChessSeasonManager:GetWCSStageInfoByTowerId(seasonId, towerId)
  local envCfg = WarChessSeasonManager:GetWCSEnvIdByTowerId(seasonId, towerId)
  if stageInfoCfg ~= nil then
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    WarChessSeasonManager:WCSReconnect()
    self:__SetEnterrChessSeasonData(seasonData, stageInfoCfg, seasonId, envCfg.id)
  end
end

function ActivitySeasonController:__SetEnterrChessSeasonData(seasonData, stageInfoCfg, seasonId, envId)
  local addtionData = seasonData:GetSeasonAddtion()
  addtionData:SetSeasonCompleteFloor(stageInfoCfg.floor_id)
  addtionData:SetSeasonRecommendPower(stageInfoCfg.combat)
  addtionData:SetSeasonCompleteFloorTip(ConfigData:GetTipContent(8701))
  if seasonId and envId then
    local maxNum = WarChessSeasonManager:GetWCSPassedEnvMaxNum(seasonId, envId)
    addtionData:SetSeasonHighesScore(maxNum)
  end
  WarChessSeasonManager:SetSeasonAddtionData(addtionData)
  WarChessSeasonManager:SetWarChessSeasonName(LanguageUtil.GetLocaleText(stageInfoCfg.difficulty_name))
  WarChessSeasonManager:SetSeasonTechJumpFunc(function()
    self:OpenSeasonObj(eActInteractSeason.eLbIntrctEntityId.Tech)
  end, function()
    local reddot = seasonData:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local techReddot = reddot:GetChild(ActivitySeasonEnum.reddotType.Tech)
    if techReddot == nil then
      return false
    end
    return techReddot:GetRedDotCount() > 0
  end)
end

function ActivitySeasonController:SetIgnoreUnlockWinOnce()
  self.ignoreUnlockWinOnce = true
end

function ActivitySeasonController:TryOpenUnlockWin(seasonData)
  local unlockInfo = seasonData:GetSeasonUnlockInfo()
  if unlockInfo ~= nil and unlockInfo:IsExistActUnlockInfo() then
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivitySeasonUnlcok, function(win)
      if win == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win:InitSpring23Unlock(unlockInfo, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
      win:BindSeasonUnlockFunc(eActInteractSeason.eUnlockIntrctFunc[eActInteractSeason.eLbIntrctEntityId.MainStory], eActInteractSeason.eIntrctFuncs[eActInteractSeason.eLbIntrctActionId.MainStory], eActInteractSeason.eUnlockIntrctFunc[eActInteractSeason.eLbIntrctEntityId.Repeat], eActInteractSeason.eIntrctFuncs[eActInteractSeason.eLbIntrctActionId.Repeat])
    end)
  end
end

function ActivitySeasonController:RunEnterCompleteFunc()
  if self._enterCompleteCallback then
    self._enterCompleteCallback()
  end
  if not self.ignoreUnlockWinOnce then
    self:TryOpenUnlockWin(self:GetSeasonData())
  else
    self.ignoreUnlockWinOnce = false
  end
end

function ActivitySeasonController:RemoveSeason(id)
  self._dataDic[id] = nil
end

function ActivitySeasonController:IsHaveSeason()
  return table.count(self._dataDic) > 0
end

function ActivitySeasonController:GetSeasonData()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActivitySeasonController:GetSeasonDataByActId(id)
  return self._dataDic[id]
end

function ActivitySeasonController:Delete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_season_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_season_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby_interact_action)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_general_env)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_stage_info)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_season_battle_ex)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__AvgCompleteCallback)
  MsgCenter:RemoveListener(eMsgEventId.WCS_WarChessSeasonRecord, self.__OnWarChessSeasonRecordCallback)
end

return ActivitySeasonController
