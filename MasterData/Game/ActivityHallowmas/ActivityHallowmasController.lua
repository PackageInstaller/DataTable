local ActivityHallowmasController = class("ActivityHallowmasController", ControllerBase)
local ActivityHallowmasData = require("Game.ActivityHallowmas.ActivityHallowmasData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local FmtEnum = require("Game.Formation.FmtEnum")
local JumpManager = require("Game.Jump.JumpManager")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local HallowmasActIdEnum = {hallowmas = 1, christmas = 2}

function ActivityHallowmasController:OnInit()
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dataDic = {}
  ConfigData:LoadDynCfg(eDynConfigData.activity_hallowmas_exp)
  ConfigData:LoadDynCfg(eDynConfigData.activity_hallowmas_stage_info)
  ConfigData:LoadDynCfg(eDynConfigData.activity_hallowmas_name)
  ConfigData:LoadDynCfg(eDynConfigData.activity_hallowmas_achievement)
  ConfigData:LoadDynCfg(eDynConfigData.activity_hallowmas_general_env)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.__AvgCompleteCallback = BindCallback(self, self.__AvgComplete)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__AvgCompleteCallback)
  self.__ExpireDealCallback = BindCallback(self, self.__ExpireDeal)
end

function ActivityHallowmasController:InitHallowmas(msgs)
  for _, msg in ipairs(msgs) do
    self:AddHallowmas(msg)
  end
end

function ActivityHallowmasController:AddHallowmas(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ActivityHallowmasData.New()
  self._dataDic[msg.actId] = data
  data:InitHallowmasData(msg)
  local expireTm = data:GetHallowmasExpiredTm()
  if expireTm < data:GetTaskInitTaskTime() then
    expireTm = data:GetTaskInitTaskTime()
  end
  self._frameCtrl:AddActivityDataUpdateTimeListen(data:GetActFrameId(), expireTm + 1, self.__ExpireDealCallback)
end

function ActivityHallowmasController:UpdateHallowmas(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateHallowmasData(msg)
end

function ActivityHallowmasController:__ExpireDeal(activityFrameId)
  local actFrameData = self._frameCtrl:GetActivityFrameData(activityFrameId)
  local data = self._dataDic[actFrameData:GetActId()]
  if data == nil then
    return
  end
  local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  actFrameNet:CS_ACTIVITY_SingleConcreteInfo(data:GetActFrameId(), function(objList)
    local msg = objList[0]
    if msg ~= nil and msg.activityHalloween ~= nil then
      data:UpdateHallowmasData(msg.activityHalloween)
      self._frameCtrl:AddActivityDataUpdateTimeListen(activityFrameId, data:GetHallowmasExpiredTm() + 1, self.__ExpireDealCallback)
    end
    MsgCenter:Broadcast(eMsgEventId.ActivityHallowmasExpired, data:GetActId())
  end)
end

function ActivityHallowmasController:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local taskIdDic = data:GetHallowmasDailyTaskIdDic()
    if taskIdDic ~= nil and taskIdDic[taskData.id] ~= nil then
      data:RefreshHallowmasRedDailyTask(taskData)
    else
      local achienementCfg = data:GetHallowmasAchievementCfg()
      if achienementCfg[taskData.id] ~= nil then
        data:RefreshHallowmasRedAchievement(taskData)
      else
        local envId = ConfigData.activity_hallowmas_general_env.taskEnvDic[taskData.id]
        if envId ~= nil then
          data:RefreshHallowmasRedRedEnvTask(taskData)
        end
      end
    end
  end
end

function ActivityHallowmasController:__ItemUpdate(_, _, itemDic)
  for _, data in pairs(self._dataDic) do
    if itemDic[data:GetHallowmasScoreItemId()] ~= nil then
      data:RefreshHallowmasRedExp()
      data:RefreshHallowmasRedSectorAvg()
    end
    local techTree = data:GetHallowmasTechTree()
    if techTree ~= nil then
      local techTypeCostDic = techTree:GetTechTypeCostDic()
      for itemId, _ in pairs(techTypeCostDic) do
        if itemDic[itemId] ~= nil then
          data:RefreshHallowmasRedTech()
          break
        end
      end
    end
  end
end

function ActivityHallowmasController:__AvgComplete(avgId)
  for _, data in pairs(self._dataDic) do
    if data:IsHallowmasSectorAvg(avgId) then
      data:RefreshHallowmasRedSectorAvg()
    end
  end
end

function ActivityHallowmasController:OpenHallowmas(actId, enterFunc, backCallback, selectSector, callback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  if actId == HallowmasActIdEnum.hallowmas then
    UIManager:ShowWindowAsync(UIWindowTypeID.Halloween22Main, function(window)
      if window == nil then
        return
      end
      window:InitHalloween22(data, enterFunc, backCallback)
      if 0 < (selectSector or 0) then
        window:EnterHallowmasSector(selectSector)
      end
      if callback ~= nil then
        callback()
      end
    end)
  elseif actId == HallowmasActIdEnum.christmas then
    UIManager:ShowWindowAsync(UIWindowTypeID.Christmas22Main, function(window)
      if window == nil then
        return
      end
      window:InitChristmas22Main(data, enterFunc, backCallback)
      if 0 < (selectSector or 0) then
        window:EnterChristmas22Sector(selectSector)
      end
      if callback ~= nil then
        callback()
      end
    end)
  end
end

function ActivityHallowmasController:EnterSeasonDugeon(tmpDungeonLevelData, autoBattleCount)
  local commonBattleFunc
  local fmtModule = FmtEnum.eFmtFromModule.Season
  local forbidSupport = 0 < (autoBattleCount or 0)
  local keyItemId = tmpDungeonLevelData:GetEnterLevelCost()
  local needKey = tmpDungeonLevelData:GetConsumeKeyNum()
  
  local function judgeIsHaveEnoughTicket(dungeonLevelData, judgeReplay)
    local keyItemId = dungeonLevelData:GetEnterLevelCost()
    local needKey = dungeonLevelData:GetConsumeKeyNum()
    if judgeReplay then
      needKey = needKey * 2
    end
    if needKey > PlayerDataCenter:GetItemCount(keyItemId) then
      if judgeReplay then
        return false
      end
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
      return false
    end
    return true
  end
  
  if autoBattleCount ~= nil and 0 < autoBattleCount then
    BattleDungeonManager.autoCtrl:EnterDungeonAutoModel(autoBattleCount, false)
  end
  
  local function enterFunc()
    DungeonCenterUtil.EnterDungeonFormationDeal()
    UIManager:HideWindow(UIWindowTypeID.Christmas22Repeat)
  end
  
  local function exitFunc(fmtId)
    DungeonCenterUtil.ExitDungeonFormationDeal()
    UIManager:ShowWindowOnly(UIWindowTypeID.Christmas22Repeat)
    if BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
      BattleDungeonManager.autoCtrl:ExitDungeonAutoModel()
    end
  end
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = tmpDungeonLevelData
    end
    if not judgeIsHaveEnoughTicket(dungeonLevelData) then
      return
    end
    commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
    if not judgeIsHaveEnoughTicket(dungeonLevelData) then
      return
    end
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(fmtModule, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleWinEvent(function()
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason, dungeonLevelData:GetDungeonLevelStageId(), curSelectFormationData.isHaveSupport, PlayerDataCenter.timestamp)
    end)
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local actId = dungeonLevelData:GetSeasonId()
      self:__ReturnFromSeasonBattle(actId, dungeonLevelData, isWin)
    end)
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas, true)
    local stageId = dungeonLevelData:GetDungeonLevelStageId()
    local interfaceData = DungeonInterfaceData.CreateActSeasonDunInterface(dungeonLevelData)
    interfaceData:SetDungeonReplayInfo(startBattleFunc, needKey, keyItemId)
    local farmDouble = false
    seasonCtrl:RequestEnterActSeasonDungeon(stageId, interfaceData, formationData, farmDouble, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = tmpDungeonLevelData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(fmtModule)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(fmtModule, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleTicketItemId(keyItemId):SetEnterBattleCostTicketNum(needKey):SetFmtForbidSupport(forbidSupport)
  fmtCtrl:EnterFormation()
end

function ActivityHallowmasController:RequestEnterActSeasonDungeon(stageId, interfaceData, formationData, isDouble, callBack)
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNet:CS_ACTIVITY_DUNGEON_GeneralEnter(stageId, formationData, nil, function(dataList)
    if dataList.Count == 0 then
      return
    end
    local NtfEnterMsgData = dataList[0]
    BattleDungeonManager:RealEnterDungeon(NtfEnterMsgData, nil, interfaceData)
    NetworkManager:HandleDiff(NtfEnterMsgData.syncUpdateDiff)
    if callBack ~= nil then
      callBack()
    end
  end, isDouble)
end

function ActivityHallowmasController:__ReturnFromSeasonBattle(actId, dungeonLevelData, isWin)
  local actData = self._dataDic[actId]
  if actData == nil then
    return
  end
  local LastPlayData = require("Game.Sector.Data.LastPlayData")
  local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
  local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.Season):SetLPDActData(actData):SetLPDIsWin(isWin == true)
  UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
  PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
end

function ActivityHallowmasController:EnterhallowmasSeason(actId, diffculty, envId)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  if not data:IsActivityRunning() then
    return
  end
  local stageInfoCfgs = data:GetHallowmasStageInfoCfg()
  local stageInfoCfg = stageInfoCfgs[diffculty]
  if stageInfoCfg == nil then
    return
  end
  if envId ~= nil and not data:IsHallowmasEnvDiffcultyExist(envId, diffculty) then
    if isGameDev then
      error("env diff no mapping, envId:" .. tostring(envId) .. " diffId:" .. tostring(diffculty) .. " actId:" .. tostring(actId))
    end
    return
  end
  local towerId = stageInfoCfg.season_id
  local seasonId = data:GetHallowmasMainCfg().warchess_season_id
  WarChessSeasonManager:EnterWarChessSeasonBySeasonGroupId(seasonId, towerId, envId or 0)
  self:__SetHallowmasWarChessSeasonData(data, stageInfoCfg)
end

function ActivityHallowmasController:ArchivehallowmasSeason(archive)
  local data, cfg = self:__GetActStageCfgByTowerId(archive.warChessTowerId)
  if cfg ~= nil then
    WarChessSeasonManager:ReadWCSSavingData(archive.warChessSeasonbackUpId)
    self:__SetHallowmasWarChessSeasonData(data, cfg)
  end
end

function ActivityHallowmasController:ContinuehallowmasSeason()
  local isUnComplete, wcdata = WarChessSeasonManager:GetUncompleteWCSData()
  if not isUnComplete then
    return
  end
  local data, cfg = self:__GetActStageCfgByTowerId(wcdata.towerId)
  if cfg ~= nil then
    WarChessSeasonManager:WCSReconnect()
    self:__SetHallowmasWarChessSeasonData(data, cfg)
  end
end

function ActivityHallowmasController:__SetHallowmasWarChessSeasonData(hallowmasData, stageInfoCfg)
  local addtionData = hallowmasData:GetHallowmasSeasonAddtion()
  addtionData:SetSeasonCompleteFloor(stageInfoCfg.floor_id)
  local envId = hallowmasData:GetHallowmasEnvIdByDifficultyId(stageInfoCfg.difficulty_id)
  local seasonHighesScore
  if envId ~= -1 then
    seasonHighesScore = hallowmasData:GetHallowmasEnvScore(envId)
  else
    seasonHighesScore = hallowmasData:GetHallowmasHighestScore()
  end
  addtionData:SetSeasonHighesScore(seasonHighesScore)
  addtionData:SetSeasonRecommendPower(stageInfoCfg.combat)
  if hallowmasData:GetActId() == HallowmasActIdEnum.christmas then
    addtionData:SetSeasonSaveUIType(UIWindowTypeID.WCSSavingPanel_Christmas22)
  elseif hallowmasData:GetActId() == HallowmasActIdEnum.hallowmas then
    addtionData:SetSeasonSaveUIType(UIWindowTypeID.WCSSavingPanel_Halloween22)
  end
  WarChessSeasonManager:SetSeasonAddtionData(addtionData)
  WarChessSeasonManager:SetWarChessSeasonName(LanguageUtil.GetLocaleText(stageInfoCfg.difficulty_name))
end

function ActivityHallowmasController:RemoveHallowmas(id)
  self._dataDic[id] = nil
end

function ActivityHallowmasController:IsHaveHallowmas()
  return table.count(self._dataDic) > 0
end

function ActivityHallowmasController:GetHallowmasData(id)
  return self._dataDic[id]
end

function ActivityHallowmasController:__GetActStageCfgByTowerId(towerId)
  for k, v in pairs(self._dataDic) do
    local stageInfoCfgs = v:GetHallowmasStageInfoCfg()
    for i, cfg in pairs(stageInfoCfgs) do
      if cfg.season_id == towerId then
        return v, cfg
      end
    end
  end
  return nil, nil
end

function ActivityHallowmasController:Delete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hallowmas_exp)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hallowmas_stage_info)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hallowmas_name)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hallowmas_achievement)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hallowmas_general_env)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__AvgCompleteCallback)
end

return ActivityHallowmasController
