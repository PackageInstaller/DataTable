local ActivityHeroGrowController = class("ActivityHeroGrowController", ControllerBase)
local base = ControllerBase
local ActivityHeroGrow = require("Game.ActivityHeroGrow.ActivityHeroGrow")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local FmtEnum = require("Game.Formation.FmtEnum")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function ActivityHeroGrowController:OnInit()
  self._dataDic = {}
  self.__isFirst = true
  self.__TaskChangeCallback = BindCallback(self, self.__TaskChange)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self.__TaskCommitCallback = BindCallback(self, self.__TaskCommit)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__TaskCommitCallback)
  self.__OnItemChangeFunc = BindCallback(self, self.__OnItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemChangeFunc)
  self.__ListenPreCondtionFunc = BindCallback(self, self.__ListenPreCondtion)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__ListenPreCondtionFunc)
end

function ActivityHeroGrowController:InitHeroGrow()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if activityFrameCtrl == nil then
    error(" activityFrameCtrl is NIL ")
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  self._dataDic = {}
  for k, cfg in pairs(ConfigData.activity_hero) do
    local actId = cfg.id
    local id = activityFrameCtrl:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.HeroGrow, actId)
    if id ~= nil then
      local actInfo = activityFrameCtrl:GetActivityFrameData(id)
      self:InitHeroGrowByAct(actInfo)
    end
  end
end

function ActivityHeroGrowController:InitHeroGrowByAct(actInfo)
  if actInfo == nil or not actInfo:GetCouldShowActivity() then
    return
  end
  local actId = actInfo:GetActId()
  if self._dataDic[actId] ~= nil then
    return
  end
  local data = ActivityHeroGrow.New()
  self._dataDic[actId] = data
  data:InitHeroGrowData(actInfo)
end

function ActivityHeroGrowController:UpdateHeroGrow(msg)
  self._activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if self._activityFrameCtrl == nil then
    error(" activityFrameCtrl is NIL ")
    return
  end
  for _, singleMsg in ipairs(msg) do
    self:UpdateHeroGrowSingle(singleMsg)
  end
  self.__isFirst = false
end

function ActivityHeroGrowController:UpdateHeroGrowSingle(singleMsg)
  if self._activityFrameCtrl == nil then
    self._activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  end
  if self._activityFrameCtrl == nil then
    error(" activityFrameCtrl is NIL ")
    return
  end
  local actId = singleMsg.actId
  local id = self._activityFrameCtrl:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.HeroGrow, actId)
  if id == nil then
    error("heroGrow activity is NIL " .. tostring(actId))
    return
  end
  local actInfo = self._activityFrameCtrl:GetActivityFrameData(id)
  if actInfo == nil then
    error("heroGrow activity is NIL " .. tostring(actId))
    return
  end
  local data = self._dataDic[actId]
  if data == nil then
    data = ActivityHeroGrow.New()
    self._dataDic[actId] = data
    data:InitHeroGrowData(actInfo)
  end
  data:UpdateHeroGrowData(singleMsg, self.__isFirst)
end

function ActivityHeroGrowController:GetHeroGrowActivity(actId)
  local actHeroData = self._dataDic[actId]
  if actHeroData == nil or not actHeroData.actInfo:GetCouldShowActivity() then
    return nil
  end
  return actHeroData
end

function ActivityHeroGrowController:GetHeroGrowActivityNoExchange(actId)
  local actHeroData = self._dataDic[actId]
  if actHeroData == nil then
    return nil
  end
  if not actHeroData:IsActivityRunning() and not actHeroData.actInfo:CanPreviewNoExchange() then
    return nil
  end
  return actHeroData
end

function ActivityHeroGrowController:RefreshHeroGrowStateDailyFlush()
  for _, data in pairs(self._dataDic) do
    if data.actInfo:IsActivityOpen() then
      data:RefreshHeroGrowStateDailyFlush()
    end
  end
  MsgCenter:Broadcast(eMsgEventId.HeroGrowActivityTimePass)
end

function ActivityHeroGrowController:GetHeroGrowDataBySectorId(sectorId)
  local actId = ConfigData.activity_hero.sectorMapping[sectorId]
  if actId == nil then
    return nil, nil, false, false
  end
  local data = self:GetHeroGrowActivity(actId)
  if data == nil then
    return actId, nil, false, false
  end
  return actId, data, data:IsActivityRunning(), data:IsActivityOpen()
end

function ActivityHeroGrowController:IsHeroGrowChallengeStage(sectorStageId)
  local stageCfg = ConfigData.sector_stage[sectorStageId]
  if stageCfg == nil then
    return nil, false, false
  end
  return self:IsHeroGrowChallengeSector(stageCfg.sector)
end

function ActivityHeroGrowController:IsHeroGrowChallengeSector(sectorId)
  local actId, actData, isRuning, isOpening = self:GetHeroGrowDataBySectorId(sectorId)
  if actId == nil then
    return nil, false, false
  end
  local activityHeroCfg = actData ~= nil and actData:GetHeroGrowCfg() or ConfigData.activity_hero[actId]
  local isChallenge = activityHeroCfg ~= nil and activityHeroCfg.rechallenge_stage == sectorId
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroActivity) then
    return actId, isChallenge, false
  end
  local canFight = isRuning or not isChallenge
  return actId, isChallenge, canFight
end

function ActivityHeroGrowController:OpenHeroGrowUI(heroGrowData, enterFunc, backCallback, selectSector, callback)
  local actId = heroGrowData:GetActId()
  local isVer2 = heroGrowData:IsHeroGrowVer2()
  local heroGrowCfg = heroGrowData:GetHeroGrowCfg()
  if selectSector ~= nil then
    if not SectorStageDetailHelper.IsSectorNoCollide(selectSector) then
      selectSector = nil
    elseif heroGrowCfg.main_stage ~= selectSector and not heroGrowData:IsActivityRunning() then
      selectSector = nil
    end
  end
  if not isVer2 then
    UIManager:ShowWindowAsync(UIWindowTypeID.CharacterDungeon, function(window)
      if window == nil then
        return
      end
      window:InitCharactorDungeonMain(heroGrowData, enterFunc, backCallback)
      if selectSector ~= nil then
        window:OnEnterHeroGrowSector(selectSector)
      end
      if callback ~= nil then
        callback()
      end
    end)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CharDunVer2, function(window)
      if window == nil then
        return
      end
      window:InitCharacterDungeon(heroGrowData, enterFunc, backCallback)
      if selectSector ~= nil then
        window:OnEnterCharDunSector(selectSector)
      end
      if callback ~= nil then
        callback()
      end
    end)
  end
end

function ActivityHeroGrowController:EnterHeroGrowDugeon(tmpDungeonLevelData, autoBattleCount)
  local commonBattleFunc
  local fmtModule = FmtEnum.eFmtFromModule.HeroGrow
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
      local costItemName = dungeonLevelData:GetEnterLevelCostItemName()
      local actName = dungeonLevelData:GetDungeonActName()
      CS.MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(7101), costItemName, actName, costItemName))
      return false
    end
    return true
  end
  
  if autoBattleCount ~= nil and 0 < autoBattleCount then
    BattleDungeonManager.autoCtrl:EnterDungeonAutoModel(autoBattleCount, false)
  end
  
  local function enterFunc()
    DungeonCenterUtil.EnterDungeonFormationDeal()
    UIManager:HideWindow(UIWindowTypeID.SectorLevel)
  end
  
  local function exitFunc(fmtId)
    DungeonCenterUtil.ExitDungeonFormationDeal()
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorLevel)
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
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroActivity, dungeonLevelData:GetDungeonLevelStageId(), curSelectFormationData.isHaveSupport, PlayerDataCenter.timestamp)
    end)
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local actId = dungeonLevelData:GetDungeonHeroGrowActId()
      self:__ReturnFromheroGrowBattle(actId, dungeonLevelData, isWin)
    end)
    local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow, true)
    local stageId = dungeonLevelData:GetDungeonLevelStageId()
    local interfaceData = DungeonInterfaceData.CreateHeroGrowInterface(dungeonLevelData)
    interfaceData:SetDungeonReplayInfo(startBattleFunc, needKey, keyItemId)
    local farmDouble = false
    heroGrowCtrl:RequestEnterActSectorIIIDungeon(stageId, interfaceData, formationData, farmDouble, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      local actId = dungeonLevelData:GetDungeonHeroGrowActId()
      local data = self._dataDic[actId]
      if data ~= nil then
        data:SetHeroGrowDungeonBattle(stageId)
      end
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

function ActivityHeroGrowController:RequestEnterActSectorIIIDungeon(stageId, interfaceData, formationData, isDouble, callBack)
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

function ActivityHeroGrowController:__ReturnFromheroGrowBattle(actId, dungeonLevelData, isWin)
  local actData = self._dataDic[actId]
  if actData == nil then
    return
  end
  local LastPlayData = require("Game.Sector.Data.LastPlayData")
  local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
  local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.HeroGrow):SetLPDSectorId(actData:GetHeroGrowCfg().main_stage):SetLPDActId(actData:GetActId()):SetLPDActData(actData):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(function()
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
    if aftertTeatmentCtrl ~= nil then
      aftertTeatmentCtrl:TeatmentBengin()
    end
  end)
  UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
  PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
end

function ActivityHeroGrowController:RemoveHeroGrow(actId)
  self._dataDic[actId] = nil
end

function ActivityHeroGrowController:IsHaveHeroGrow()
  return table.count(self._dataDic) > 0
end

function ActivityHeroGrowController:__TaskChange(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for k, data in pairs(self._dataDic) do
    local taskDic = ConfigData.activity_hero.allTaskCollect[k]
    if taskDic ~= nil and taskDic[taskData.id] ~= nil then
      data:RefreshHeroGrowDailyTaskComReddot()
    end
  end
end

function ActivityHeroGrowController:__TaskCommit(taskCfg)
  for k, data in pairs(self._dataDic) do
    local taskDic = ConfigData.activity_hero.allTaskCollect[k]
    if taskDic ~= nil and taskDic[taskCfg.id] ~= nil then
      data:RefreshHeroGrowDailyTaskComReddot()
    end
  end
end

function ActivityHeroGrowController:__OnItemChange(itemUpdate)
  for k, data in pairs(self._dataDic) do
    local itemId = data:GetHeroGrowCostId()
    if itemUpdate[itemId] ~= nil then
      data:RefreshHeroGrowLvRewrdReddot()
    end
  end
end

function ActivityHeroGrowController:__ListenPreCondtion(conditionId)
  if conditionId == CheckerTypeId.CompleteStage or conditionId == CheckerTypeId.ActivityTask then
    for k, data in pairs(self._dataDic) do
      data:RefreshHeroGrowChallengeNewReddot()
    end
  end
end

function ActivityHeroGrowController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__TaskCommitCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__ListenPreCondtionFunc)
end

return ActivityHeroGrowController
