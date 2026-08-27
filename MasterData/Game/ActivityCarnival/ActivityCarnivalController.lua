local ActivityCarnivalController = class("ActivityCarnivalController", ControllerBase)
local base = ControllerBase
local ActivityCarnivalEnum = require("Game.ActivityCarnival.ActivityCarnivalEnum")
local ActivityCarnivalData = require("Game.ActivityCarnival.ActivityCarnivalData")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")

function ActivityCarnivalController:OnInit()
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dataDic = {}
  self.__PreconditionCallback = BindCallback(self, self.__Precondition)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__PreconditionCallback)
  self.__AvgPlayedCallBack = BindCallback(self, self.__AvgPlayed)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__AvgPlayedCallBack)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskChange)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self.__TaskCommitCallback = BindCallback(self, self.__TaskCommit)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__TaskCommitCallback)
  self.__ExpireDealCallback = BindCallback(self, self.__ExpireDeal)
end

function ActivityCarnivalController:InitAllCarnival(msgs)
  for i, msg in ipairs(msgs) do
    self:AddCarnivalAct(msg)
  end
end

function ActivityCarnivalController:AddCarnivalAct(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ActivityCarnivalData.New()
  data:InitActivityCarnival(msg)
  self._dataDic[msg.actId] = data
  self._frameCtrl:AddActivityDataUpdateTimeListen(data:GetActFrameId(), data:GetCarnivalTaskNextTm() + 1, self.__ExpireDealCallback)
end

function ActivityCarnivalController:UpdateCarnivalAct(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateCarnival(msg)
  MsgCenter:Broadcast(eMsgEventId.ActivityCarnivalTimePass)
end

function ActivityCarnivalController:RemoveCarnivalAct(actId)
  self._dataDic[actId] = nil
end

function ActivityCarnivalController:__Precondition(precondition)
  for _, carnivalData in pairs(self._dataDic) do
    carnivalData:CalCarnivalEnvByCondition(precondition)
    carnivalData:CalCarnivalStageAndAvgState(precondition)
  end
end

function ActivityCarnivalController:__AvgPlayed(avgId)
  for _, carnivalData in pairs(self._dataDic) do
    carnivalData:CalCarnivalAvgState(avgId)
  end
end

function ActivityCarnivalController:__TaskChange(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local questDic = data:GetCarnivalTask()
    if questDic[taskData.id] ~= nil then
      data:UpdateCarnivalTaskReddot()
    end
  end
end

function ActivityCarnivalController:__TaskCommit(taskCfg)
  for _, data in pairs(self._dataDic) do
    local questDic = data:GetCarnivalTask()
    if questDic[taskCfg.id] ~= nil then
      data:UpdateCarnivalTaskReddot()
    end
  end
end

function ActivityCarnivalController:GetCarnivalAct(actId)
  return self._dataDic[actId]
end

function ActivityCarnivalController:IsHaveCarnivalAct()
  return table.count(self._dataDic) > 0
end

function ActivityCarnivalController:GetTheLastCarnival()
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

function ActivityCarnivalController:GetCarnivalDataBySectorId(sectorId)
  local actId = ConfigData.activity_carnival.sectorMapping[sectorId]
  if actId == nil then
    return nil, nil, nil, nil
  end
  local data = self._dataDic[actId]
  if data == nil then
    return actId, nil, false, false
  end
  return actId, data, data:IsActivityRunning(), data:IsActivityOpen()
end

function ActivityCarnivalController:__ExpireDeal(activityFrameId)
  local actFrameData = self._frameCtrl:GetActivityFrameData(activityFrameId)
  local data = self._dataDic[actFrameData:GetActId()]
  if data == nil then
    return
  end
  local actCarnivalNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityCarnival)
  actCarnivalNetCtrl:CS_ACTIVITY_Carnival_RefreshPeriod(data:GetActId(), function()
    if UIManager:GetWindow(UIWindowTypeID.Carnival22Task) ~= nil then
      return
    end
    local reddot = data:GetActivityReddot()
    if reddot == nil then
      return
    end
    local childReddot = reddot:AddChild(ActivityCarnivalEnum.eActivityCarnivalReddot.TaskPeriod)
    childReddot:SetRedDotCount(1)
    self._frameCtrl:AddActivityDataUpdateTimeListen(activityFrameId, data:GetCarnivalTaskNextTm() + 1, self.__ExpireDealCallback)
  end)
end

function ActivityCarnivalController:TryCarnivalOpenUI(actId, enterSectorFunc, backFunc, callback)
  local carnivalData = self._dataDic[actId]
  if carnivalData == nil then
    return false
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22Main, function(window)
    if window == nil then
      return
    end
    window:InitCarnivalMain(carnivalData, enterSectorFunc, backFunc)
    if callback ~= nil then
      callback(window)
    end
  end)
  return true
end

function ActivityCarnivalController:OnEnterCarnivalChallenge(carnivalDungeonData)
  local function enterFunc()
    DungeonCenterUtil.EnterDungeonFormationDeal()
    
    UIManager:HideWindow(UIWindowTypeID.Carnival22Main)
    UIManager:HideWindow(UIWindowTypeID.Carnival22Challenge)
  end
  
  local function exitFunc(fmtId)
    DungeonCenterUtil.ExitDungeonFormationDeal()
    UIManager:ShowWindowOnly(UIWindowTypeID.Carnival22Main)
    UIManager:ShowWindowOnly(UIWindowTypeID.Carnival22Challenge)
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = carnivalDungeonData
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
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.CarnivalDungeon, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleWinEvent(function()
      local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityCarnival, dungeonId, false, PlayerDataCenter.timestamp)
    end)
    local carnivalData = self:GetTheLastCarnival()
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.Carnival):SetLPDIsWin(isWin == true):SetLPDActData(carnivalData)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local ARDCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival)
    local interfaceData = DungeonInterfaceData.CreateCarnivalDungeonInterface(dungeonLevelData)
    interfaceData:SetAfterClickBattleFunc(function(callback)
      callback()
    end)
    ARDCtrl:__ReqDungeonBattle(interfaceData, formationData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local needKey = carnivalDungeonData:GetConsumeKeyNum()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = carnivalDungeonData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.CarnivalDungeon)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.CarnivalDungeon, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey)
  fmtCtrl:EnterFormation()
end

function ActivityCarnivalController:__ReqDungeonBattle(interfaceData, formationData, callBack)
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

function ActivityCarnivalController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__PreconditionCallback)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__AvgPlayedCallBack)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__TaskCommitCallback)
end

return ActivityCarnivalController
