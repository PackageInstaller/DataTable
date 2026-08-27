local base = ControllerBase
local ActivitySectorIICtrl = class("ActivitySectorIICtrl", base)
local ActivitySectorIIData = require("Game.ActivitySectorII.ActivitySectorIIData")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")
local CS_GSceneManager_Ins = CS.GSceneManager.Instance

function ActivitySectorIICtrl:ctor()
  self.__sectorIINetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.DungeonSectorII)
  self.__SectorIIDataDic = {}
  self.__SectorIIDataSectorIdDic = {}
  self.__onTaskUpdate = BindCallback(self, self.__OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskSyncFinish, self.__onTaskUpdate)
  self.__onDungeonLimitChange = BindCallback(self, self.__OnDungeonLimitChange)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDungeonLimitChange)
  MsgCenter:AddListener(eMsgEventId.ExplorationExit, self.__onDungeonLimitChange)
  self.__onItemUpdate = BindCallback(self, self.__OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  self.__onDungeonBattleTimeChange = BindCallback(self, self.__OnDungeonBattleTimeChange)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitInit, self.__onDungeonBattleTimeChange)
end

function ActivitySectorIICtrl:OnSectorIIActivityOpen(actId)
  if self.__SectorIIDataDic[actId] ~= nil then
    return
  end
  local actSectorIIData = ActivitySectorIIData.New()
  actSectorIIData:InitActSectorIIData(actId)
  local sectorId = actSectorIIData:GetSectorIISectorId()
  self.__SectorIIDataDic[actId] = actSectorIIData
  self.__SectorIIDataSectorIdDic[sectorId] = actSectorIIData
end

function ActivitySectorIICtrl:OnSectorIIActivityClose(actId)
  local actSectorIIData = self.__SectorIIDataDic[actId]
  local sectorId = actSectorIIData:GetSectorIISectorId()
  self.__SectorIIDataDic[actId] = nil
  self.__SectorIIDataSectorIdDic[sectorId] = nil
  if table.count(self.__SectorIIDataDic) <= 0 then
    ControllerManager:DeleteController(ControllerTypeId.SectorII)
  end
end

function ActivitySectorIICtrl:UpdataSectorIIActivityByMsg(msg)
  for _, elem in pairs(msg) do
    self:UpdataSectorIIActivityBySingleMsg(elem)
  end
end

function ActivitySectorIICtrl:UpdataSectorIIActivityBySingleMsg(elem)
  local actId = elem.actId
  local tech = elem.tech
  local bird = elem.bird
  local dungeonSuits = elem.dungeonSuits
  local sectorIIData = self:GetSectorIIDataByActId(actId)
  if sectorIIData == nil then
    return
  end
  local actTechDataDic = sectorIIData:RefreshAWTechDatas(tech)
  self:InstallAllTechBonus(actTechDataDic)
  sectorIIData:SetSectorIIBirdData(bird)
  sectorIIData:SetSectorIIDungeonSuitData(dungeonSuits)
  sectorIIData:UpdSctIIWinChallengeData(elem.verify)
  sectorIIData:OnSectorIIMsgInitOver()
  sectorIIData:UpdateActFrameDataSingleMsg(elem)
end

function ActivitySectorIICtrl:UpdSectorIIActivityByDiff(msg)
  local elem = msg.data
  local sectorIIData = self:GetSectorIIDataByActId(elem.actId)
  if sectorIIData == nil then
    error("Cant get sectorIIData, actId:" .. tostring(elem.actId))
    return
  end
  sectorIIData:UpdSctIIWinChallengeData(elem.verify)
end

function ActivitySectorIICtrl:TryEnterSectorIIWin(sectorId, actId, isDun)
  local sectorIIData
  if sectorId ~= nil then
    sectorIIData = self:GetSectorIIDataBySectorId(sectorId)
    if sectorIIData ~= nil then
      actId = sectorIIData:GetSectorIIActId()
    end
  elseif actId ~= nil then
    sectorIIData = self:GetSectorIIDataByActId(actId)
  end
  if sectorIIData == nil then
    return false
  end
  
  local function callback()
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityWinterMainMap, function(win)
      if win ~= nil then
        if not isDun then
          win:InitWAMainMap(actId)
        else
          win:SetWADungeonCallBack(function()
            local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
            if aftertTeatmentCtrl ~= nil then
              aftertTeatmentCtrl:TeatmentBengin()
            end
          end)
          win:InitWAMainMap(actId, true)
          win:OnClickWADungeon()
        end
      end
    end)
  end
  
  local avgId = sectorIIData:GetSectorIIFirstEnterAvgId()
  if avgId ~= nil and 0 < avgId then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(avgId)
    if not played and sectorIIData:IsActivityRunning() then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId, callback)
    else
      callback()
    end
  end
  return true
end

function ActivitySectorIICtrl:_ReturnFromBattle(actId, dungeonLevelData, isWin)
  local SectorIIData = self:GetSectorIIDataByActId(actId)
  local LastPlayData = require("Game.Sector.Data.LastPlayData")
  local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
  local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.SectorII):SetLPDActData(SectorIIData):SetLPDIsWin(isWin == true)
  UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
  PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
end

function ActivitySectorIICtrl:ReqEnterActSctIIChallengeDg(dunLevelData)
  local dungeonId = dunLevelData:GetDungeonLevelStageId()
  local actId = dunLevelData:GetSectorIIActivityData().actId
  BattleDungeonManager:InjectBattleExitEvent(function(isWin)
    self:_ReturnFromBattle(actId, dunLevelData, isWin)
  end)
  BattleDungeonManager:InjectBattleWinEvent(function()
    PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinterChallenge, dungeonId, false, PlayerDataCenter.timestamp)
  end)
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastBattleDeployFmtId(proto_csmsg_DungeonType.DungeonType_WinterHard)
  local formationData = PlayerDataCenter.formationDic[lastFmtId]
  if formationData == nil then
    formationData = PlayerDataCenter:CreateFormation(lastFmtId)
  end
  BattleDungeonManager:SaveFormation(formationData)
  local interfaceData = DungeonInterfaceData.CreateSctWinChallengeInterface(dunLevelData)
  self.__sectorIINetworkCtrl:CS_DUNGEONWinterVerify_Enter(dungeonId, formationData, function(dataList)
    if dataList.Count == 0 then
      error("dataList.Count == 0")
      return
    end
    local NtfEnterMsgData = dataList[0]
    BattleDungeonManager:RealEnterDungeon(NtfEnterMsgData, nil, interfaceData)
    NetworkManager:HandleDiff(NtfEnterMsgData.syncUpdateDiff)
    ControllerManager:DeleteController(ControllerTypeId.SectorController)
  end)
end

function ActivitySectorIICtrl:ReqSettleActSctIIChallengeDg(sectorIIChallengeDgData, callback)
  local dungeonId = sectorIIChallengeDgData:GetDungeonLevelStageId()
  local curScore = sectorIIChallengeDgData:GetSctIIChallengeDgScore()
  
  local function yesFunc()
    self.__sectorIINetworkCtrl:CS_DUNGEONWinterVerify_Settle(dungeonId, callback)
  end
  
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    local msg = string.format(ConfigData:GetTipContent(7111), curScore)
    win:ShowTextBoxWithYesAndNo(msg, yesFunc, nil)
  end)
end

function ActivitySectorIICtrl:GetSectorIIDataByActId(actId)
  return self.__SectorIIDataDic[actId]
end

function ActivitySectorIICtrl:GetSectorIIFirstData()
  for i, v in pairs(self.__SectorIIDataDic) do
    return v
  end
  return nil
end

function ActivitySectorIICtrl:GetSectorIIDataBySectorId(sectorId)
  return self.__SectorIIDataSectorIdDic[sectorId]
end

function ActivitySectorIICtrl:UpgradeSectorIIActTech(techData, callback)
  local actId = techData:GetTechActId()
  local oldLevel = techData:GetCurLevel()
  NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ActivityTech_Upgrade(techData:GetActFrameId(), techData:GetTechId(), function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local upgradedTechElement = args[0]
    local sectorIIData = self:GetSectorIIDataByActId(actId)
    for i, elemt in ipairs(upgradedTechElement) do
      local techData = sectorIIData:RefreshAWTechData(elemt)
      self:TechLevelUpInstallBonus(techData, oldLevel, techData:GetCurLevel())
    end
    if callback ~= nil then
      callback(techData)
    end
  end)
end

function ActivitySectorIICtrl:InstallAllTechBonus(ActTechDataDic)
  for col, techData in pairs(ActTechDataDic) do
    if techData:GetIsTechUnlocked() then
      local techId = techData:GetTechId()
      local logicArray, para1Array, para2Array, para3Array = techData:GetTechLogic(techData:GetCurLevel())
      for index, logic in ipairs(logicArray) do
        local para1 = para1Array[index]
        local para2 = para2Array[index]
        local para3 = para3Array[index]
        PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinter, techId, logic, para1, para2, para3)
      end
    end
  end
end

function ActivitySectorIICtrl:TechLevelUpInstallBonus(techData, oldLevel, curLevel)
  local techId = techData:GetTechId()
  if 0 < oldLevel then
    local logicArray, para1Array, para2Array, para3Array = techData:GetTechLogic(oldLevel)
    for index, logic in ipairs(logicArray) do
      local para1 = para1Array[index]
      local para2 = para2Array[index]
      local para3 = para3Array[index]
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinter, techId, logic, para1, para2, para3)
    end
  end
  local logicArray, para1Array, para2Array, para3Array = techData:GetTechLogic(curLevel)
  for index, logic in ipairs(logicArray) do
    local para1 = para1Array[index]
    local para2 = para2Array[index]
    local para3 = para3Array[index]
    PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinter, techId, logic, para1, para2, para3)
  end
end

function ActivitySectorIICtrl:EnterActSectorIIDungeonFormation(tmpDungeonLevelData, autoBattleCount)
  local commonBattleFunc
  
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
  
  local function enterFunc()
    if autoBattleCount ~= nil and 0 < autoBattleCount then
      BattleDungeonManager.autoCtrl:EnterDungeonAutoModel(autoBattleCount, false)
      BattleDungeonManager.autoCtrl:SetAutoSelectSuitDic(tmpDungeonLevelData:GetLastCompleteSelectedSuitDic())
    end
    DungeonCenterUtil.EnterDungeonFormationDeal()
  end
  
  local function exitFunc(fmtId)
    DungeonCenterUtil.ExitDungeonFormationDeal()
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
    BattleDungeonManager:InjectBattleWinEvent(function()
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinter, dungeonLevelData:GetDungeonLevelStageId(), false, PlayerDataCenter.timestamp)
      if not BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
        local interfaceData = BattleDungeonManager.dunInterfaceData
        dungeonLevelData:SaveLastCompleteSelectedSuitDic(interfaceData:GetLastSelectSuit())
        dungeonLevelData:SaveLastCompleteSelectedFormatId(curSelectFormationId)
      end
    end)
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local actId = dungeonLevelData:GetDungeonLevelActId()
      self:_ReturnFromBattle(actId, dungeonLevelData, isWin)
    end)
    local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII, true)
    local stageId = dungeonLevelData:GetDungeonLevelStageId()
    local interfaceData = DungeonInterfaceData.CreateActSectorIIDungeonInterface(dungeonLevelData)
    local rewardRate = dungeonLevelData:GetWADunRewardRate()
    if judgeIsHaveEnoughTicket(dungeonLevelData, true) then
      local keyItemId = dungeonLevelData:GetEnterLevelCost()
      local needKey = dungeonLevelData:GetConsumeKeyNum()
      interfaceData:SetDungeonReplayInfo(startBattleFunc, needKey, keyItemId)
    end
    sectorIICtrl:RequestEnterActSectorIIDungeon(stageId, interfaceData, formationData, rewardRate, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local keyItemId = tmpDungeonLevelData:GetEnterLevelCost()
  local needKey = tmpDungeonLevelData:GetConsumeKeyNum()
  if autoBattleCount and 0 < autoBattleCount then
    needKey = needKey * autoBattleCount
  end
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = tmpDungeonLevelData:GetDungeonLevelStageId()
  local lastFmtId = tmpDungeonLevelData:GetLastCompleteSelectedFormatId()
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.SectorIIDun, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleTicketItemId(keyItemId):SetEnterBattleCostTicketNum(needKey):SetIsShowSupportHolder(true)
  fmtCtrl:EnterFormation()
end

function ActivitySectorIICtrl:RequestEnterActSectorIIDungeon(stageId, interfaceData, formationData, rewardRate, callBack)
  self.__sectorIINetworkCtrl:CS_DUNGEONWINTER_Enter(stageId, formationData, rewardRate, function(dataList)
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

function ActivitySectorIICtrl:GetAfterBattleShowItemDic()
  local extrAwardDic = {}
  for activityId, sectorIIData in pairs(self.__SectorIIDataDic) do
    extrAwardDic[sectorIIData:GetSectorIIDunPointId()] = true
    extrAwardDic[sectorIIData:GetSectorIIDunTicketId()] = true
  end
  return extrAwardDic
end

function ActivitySectorIICtrl:__OnTaskUpdate()
  for activityId, sectorIIData in pairs(self.__SectorIIDataDic) do
    sectorIIData:RefreshSectorIIReddot4Task()
  end
end

function ActivitySectorIICtrl:__OnDungeonLimitChange()
  for activityId, sectorIIData in pairs(self.__SectorIIDataDic) do
    sectorIIData:RefreshSectorIIReddot4Dundeon()
  end
end

function ActivitySectorIICtrl:__OnItemUpdate()
  for activityId, sectorIIData in pairs(self.__SectorIIDataDic) do
    sectorIIData:RefreshSectorIIReddot4Tech()
  end
end

function ActivitySectorIICtrl:__OnDungeonBattleTimeChange()
  self:__OnDungeonLimitChange()
  for activityId, sectorIIData in pairs(self.__SectorIIDataDic) do
    sectorIIData:RefreshAWSectorLevelState()
  end
end

function ActivitySectorIICtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskSyncFinish, self.__onTaskUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDungeonLimitChange)
  MsgCenter:RemoveListener(eMsgEventId.ExplorationExit, self.__onDungeonLimitChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitInit, self.__onDungeonBattleTimeChange)
  for _, SectorIIData in pairs(self.__SectorIIDataDic) do
    SectorIIData:Delete()
  end
  base.OnDelete(self)
end

return ActivitySectorIICtrl
