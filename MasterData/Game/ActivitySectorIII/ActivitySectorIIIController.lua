local ActivitySectorIIIController = class("ActivitySectorIIIController", ControllerBase)
local base = ControllerBase
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local ActivitySectorIIIData = require("Game.ActivitySectorIII.ActivitySectorIIIData")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function ActivitySectorIIIController:OnInit()
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dataDic = {}
  self._OnItemChangeFunc = BindCallback(self, self._OnItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskChange)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self.__TaskCommitCallback = BindCallback(self, self.__TaskCommit)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__TaskCommitCallback)
  self.__ListenPreCondtion = BindCallback(self, self.ListenPreCondtion)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__ListenPreCondtion)
  self.__ListenAvgPlayed = BindCallback(self, self.ListenAvgPlayed)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__ListenAvgPlayed)
  self.__ExpireDealCallback = BindCallback(self, self.__ExpireDeal)
end

function ActivitySectorIIIController:InitSectorIIIData(msgs)
  for i, msg in ipairs(msgs) do
    self:UpdateSectorIIIAct(msg)
  end
end

function ActivitySectorIIIController:UpdateSectorIIIAct(msg)
  if self._dataDic[msg.actId] ~= nil then
    self._dataDic[msg.actId]:UpdateSectorIIIData(msg)
  else
    local data = ActivitySectorIIIData.New()
    data:InitSectorIIIData(msg)
    self._dataDic[msg.actId] = data
    local expireTm = data:GetSum22TechNextRefreshTime()
    if expireTm > data:GetActSectorIIIExpireTime() then
      expireTm = data:GetActSectorIIIExpireTime()
    end
    self._frameCtrl:AddActivityDataUpdateTimeListen(data:GetActFrameId(), expireTm + 1, self.__ExpireDealCallback)
  end
end

function ActivitySectorIIIController:RemoveSectorIIIData(actId)
  self._dataDic[actId] = nil
end

function ActivitySectorIIIController:GetSectorIIIAct(actId)
  return self._dataDic[actId]
end

function ActivitySectorIIIController:GetOneSectorIIIAct()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActivitySectorIIIController:IsHaveSectorIIIAct()
  return table.count(self._dataDic) > 0
end

function ActivitySectorIIIController:__ExpireDeal(activityFrameId)
  local actFrameData = self._frameCtrl:GetActivityFrameData(activityFrameId)
  local data = self._dataDic[actFrameData:GetActId()]
  if data == nil then
    return
  end
  local actFrameNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  actFrameNetwork:CS_ACTIVITY_SingleConcreteInfo(data:GetActFrameId(), function()
    local expireTm = data:GetSum22TechNextRefreshTime()
    if expireTm > data:GetActSectorIIIExpireTime() then
      expireTm = data:GetActSectorIIIExpireTime()
    end
    self._frameCtrl:AddActivityDataUpdateTimeListen(data:GetActFrameId(), expireTm + 1, self.__ExpireDealCallback)
    MsgCenter:Broadcast(eMsgEventId.ActivitySectorIIIDayTimeout)
  end)
end

function ActivitySectorIIIController:__TaskChange(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for k, data in pairs(self._dataDic) do
    data:RefreshSectorIIITaskReddot()
  end
end

function ActivitySectorIIIController:__TaskCommit(taskCfg)
  for k, data in pairs(self._dataDic) do
    data:RefreshSectorIIITaskReddot()
  end
end

function ActivitySectorIIIController:TryEnterSectorIII(actId, sectorId, closeCallback, enterCallback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSum22Main, function(win)
    if win == nil then
      return
    end
    win:InitSum22Main(data, closeCallback)
    if sectorId ~= nil then
      win:SelectSum22Sector(sectorId)
    end
    if enterCallback then
      enterCallback()
    end
  end)
end

function ActivitySectorIIIController:ReqSum22RefreshTechSelect(actId, callBack)
  self._RefreshTechActId = actId
  self._onRefreshTechFunc = callBack
  self._OnSum22RefreshTechSelectFunc = self._OnSum22RefreshTechSelectFunc or BindCallback(self, self.OnSum22RefreshTechSelect)
  NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ActivityTech_Refresh(actId, self._OnSum22RefreshTechSelectFunc)
end

function ActivitySectorIIIController:OnSum22RefreshTechSelect()
  if self._onRefreshTechFunc ~= nil then
    self._onRefreshTechFunc()
  end
end

function ActivitySectorIIIController:ReqSum22TechSelect(techData, callBack)
  local actId = techData:GetTechActId()
  NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ActivityTech_Upgrade(techData:GetActFrameId(), techData:GetTechId(), function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local upgradedTechElement = args[0]
    local sumData = self:GetSectorIIIAct(actId)
    for i, elemt in ipairs(upgradedTechElement) do
      local techData = sumData:GetSum22TechDataById(elemt.id)
      if techData ~= nil then
        local oldLevel = techData:GetCurLevel()
        techData:UpdateWATechByMsg(elemt)
        local curLevel = techData:GetCurLevel()
        if oldLevel ~= curLevel then
          sumData:Sum22TechLevelUpInstallBonus(techData, oldLevel, curLevel)
        end
      end
    end
    if callBack ~= nil then
      callBack(techData)
    end
  end)
end

function ActivitySectorIIIController:EnterActSectorIIIDungeonFormation(tmpDungeonLevelData, autoBattleCount)
  local commonBattleFunc
  local fmtModule = FmtEnum.eFmtFromModule.ActSectorIIIDun
  local forbidSupport = 0 < (autoBattleCount or 0)
  
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
    end
    DungeonCenterUtil.EnterDungeonFormationDeal()
    UIManager:HideWindow(UIWindowTypeID.ActSum22DunRepeat)
  end
  
  local function exitFunc(fmtId)
    DungeonCenterUtil.ExitDungeonFormationDeal()
    UIManager:ShowWindowOnly(UIWindowTypeID.ActSum22DunRepeat)
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
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivitySummer22, dungeonLevelData:GetDungeonLevelStageId(), curSelectFormationData.isHaveSupport, PlayerDataCenter.timestamp)
    end)
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local actId = dungeonLevelData:GetDungeonLevelActId()
      self:_ReturnFromSectorIIIBattle(actId, dungeonLevelData, isWin)
    end)
    local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII, true)
    local stageId = dungeonLevelData:GetDungeonLevelStageId()
    local interfaceData = DungeonInterfaceData.CreateActIIIDunInterface(dungeonLevelData)
    local actData = dungeonLevelData:GetSectorIIIActivityData()
    local farmDouble = false
    if actData ~= nil then
      farmDouble = actData:SectorIII_IsFarmDouble()
    end
    if judgeIsHaveEnoughTicket(dungeonLevelData, true) then
      local keyItemId = dungeonLevelData:GetEnterLevelCost()
      local needKey = dungeonLevelData:GetConsumeKeyNum()
      interfaceData:SetDungeonReplayInfo(startBattleFunc, needKey, keyItemId)
    end
    sectorIICtrl:RequestEnterActSectorIIIDungeon(stageId, interfaceData, formationData, farmDouble, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local keyItemId = tmpDungeonLevelData:GetEnterLevelCost()
  local needKey = tmpDungeonLevelData:GetConsumeKeyNum()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = tmpDungeonLevelData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(fmtModule)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(fmtModule, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleTicketItemId(keyItemId):SetEnterBattleCostTicketNum(needKey):SetFmtForbidSupport(forbidSupport)
  fmtCtrl:EnterFormation()
end

function ActivitySectorIIIController:RequestEnterActSectorIIIDungeon(stageId, interfaceData, formationData, isDouble, callBack)
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

function ActivitySectorIIIController:_ReturnFromSectorIIIBattle(actId, dungeonLevelData, isWin)
  local actData = self:GetSectorIIIAct(actId)
  if actData == nil then
    return
  end
  local LastPlayData = require("Game.Sector.Data.LastPlayData")
  local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
  local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.SectorIII):SetLPDActData(actData):SetLPDIsWin(isWin == true):SetLPDActId(actData:GetActId()):SetLPDActSceneLoadoverCallback(function()
    local win = UIManager:GetWindow(UIWindowTypeID.ActSum22Main)
    if win then
      win:OnClickRepeatLevel()
    end
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
    if aftertTeatmentCtrl ~= nil then
      aftertTeatmentCtrl:TeatmentBengin()
    end
  end)
  UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
  PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
end

function ActivitySectorIIIController:_OnItemChange(itemDic)
  for k, data in pairs(self._dataDic) do
    if itemDic[data:GetSectorIIIDunPointId()] ~= nil then
      data:UpdActSum22TechRedDot()
    end
  end
end

function ActivitySectorIIIController:ListenPreCondtion(conditionId)
  if conditionId == CheckerTypeId.CompleteStage then
    for k, data in pairs(self._dataDic) do
      data:RefreshSectorIIIMapReddot()
    end
  end
end

function ActivitySectorIIIController:ListenAvgPlayed()
  for k, data in pairs(self._dataDic) do
    data:RefreshSectorIIIMapReddot()
  end
end

function ActivitySectorIIIController:IsHardLevel(challgeId)
  for k, data in pairs(self._dataDic) do
    local mainCfg = data:GetSectorIIIMainCfg()
    if mainCfg.hard_rank1[1] == challgeId then
      return true
    end
    if mainCfg.hard_rank2[1] == challgeId then
      return true
    end
  end
  return false
end

function ActivitySectorIIIController:GetHardLevelRankId(challgeId)
  for k, data in pairs(self._dataDic) do
    local mainCfg = data:GetSectorIIIMainCfg()
    if mainCfg.hard_rank1[1] == challgeId then
      return mainCfg.hard_rank1[2]
    end
    if mainCfg.hard_rank2[1] == challgeId then
      return mainCfg.hard_rank2[2]
    end
  end
  return nil
end

function ActivitySectorIIIController:GetHardLevelScore(challgeId)
  for k, data in pairs(self._dataDic) do
    local hardScores = data:GetActSectorIIIHardDungeonScore()
    if hardScores[challgeId] ~= nil then
      return hardScores[challgeId].score
    end
  end
  return 0
end

function ActivitySectorIIIController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__TaskCommitCallback)
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__ListenPreCondtion)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__ListenAvgPlayed)
end

return ActivitySectorIIIController
