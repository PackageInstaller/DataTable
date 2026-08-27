local ActRefreshDunController = class("ActRefreshDunController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActRefreshDunData = require("Game.ActivityRefreshDun.Data.ActRefreshDunData")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")

function ActRefreshDunController:OnInit()
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self.refreshDunNetWork = NetworkManager:GetNetwork(NetworkTypeID.RefreshDun)
  self.__ARDDataDic = {}
  ConfigData:LoadDynCfg(eDynConfigData.activity_refresh_dungeon)
  ConfigData:LoadDynCfg(eDynConfigData.activity_refresh_dungeon_hero)
  ConfigData:LoadDynCfg(eDynConfigData.activity_refresh_dungeon_dun)
  self.__onTaskUpdate = BindCallback(self, self.__OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskSyncFinish, self.__onTaskUpdate)
  self.__ExpireDealCallback = BindCallback(self, self.__ExpireDeal)
end

function ActRefreshDunController:OnRefreshDunActivityOpen(actId)
  if self.__ARDDataDic[actId] ~= nil then
    return
  end
  local ARDData = ActRefreshDunData.New(actId)
  self.__ARDDataDic[actId] = ARDData
end

function ActRefreshDunController:OnRefreshDunActivityClose(actId)
  local ARDData = self.__ARDDataDic[actId]
  self.__ARDDataDic[actId] = nil
  if table.count(self.__ARDDataDic) <= 0 then
    ControllerManager:DeleteController(ControllerTypeId.ActRefreshDungeon)
  end
end

function ActRefreshDunController:UpdataSingleRefreshDunActivity(msg)
  if msg == nil then
    return
  end
  local actId = msg.actId
  local ARDData = self:GetRefreshDunDataByActId(actId)
  if ARDData == nil then
    return
  end
  ARDData:UpdateARDByMsg(msg)
  self._frameCtrl:AddActivityDataUpdateTimeListen(ARDData:GetActFrameId(), ARDData:GetARDExpiredTm() + 1, self.__ExpireDealCallback)
end

function ActRefreshDunController:UpdateAllRefreshDunActivity(msgs)
  if msgs == nil then
    return
  end
  for _, msg in pairs(msgs) do
    self:UpdataSingleRefreshDunActivity(msg)
  end
end

function ActRefreshDunController:GetRefreshDunDataByActId(actId)
  return self.__ARDDataDic[actId]
end

function ActRefreshDunController:TryOpenRefreshDun(actId, allLoadOverCallabck)
  if actId == nil then
    return false
  end
  local ARDData = self:GetRefreshDunDataByActId(actId)
  if ARDData == nil then
    return false
  end
  if UIManager:GetWindow(UIWindowTypeID.AprilFool) ~= nil then
    if allLoadOverCallabck ~= nil then
      allLoadOverCallabck()
    end
    return
  end
  
  local function openFunc()
    if ARDData == nil or not ARDData:IsActivityOpen() then
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.AprilFool, function(win)
      if ARDData == nil or not ARDData:IsActivityOpen() then
        UIUtil.ReturnHome()
        return
      end
      if win ~= nil then
        win:InitAprilFoolMain(self, ARDData)
      end
      if allLoadOverCallabck ~= nil then
        allLoadOverCallabck()
      end
      GuideManager:TryTriggerGuide(eGuideCondition.ActAprilFool)
    end)
  end
  
  local avgId = ARDData:GetARDAvgId()
  if avgId ~= nil and 0 < avgId then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(avgId)
    if not played and ARDData:IsActivityOpen() then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId, openFunc)
    else
      openFunc()
    end
  else
    openFunc()
  end
  return true
end

function ActRefreshDunController:ARDBuyReset(actId, callback)
  self.refreshDunNetWork:CS_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh(actId, callback)
end

function ActRefreshDunController:ARDDunRefresh(actId, dungeonId, callback)
  self.refreshDunNetWork:CS_ACTIVITY_REFRESHDUNGEON_SingleRefresh(actId, dungeonId, callback)
end

function ActRefreshDunController:ARDDunDayPass(callback)
  self.refreshDunNetWork:CS_ACTIVITY_REFRESHDUNGEON_FetchOverDay(callback)
end

function ActRefreshDunController:__ExpireDeal(activityFrameId)
  local actFrameData = self._frameCtrl:GetActivityFrameData(activityFrameId)
  local data = self.__ARDDataDic[actFrameData:GetActId()]
  if data == nil then
    return
  end
  self:ARDDunDayPass(function()
    local aprilFoolWin = UIManager:GetWindow(UIWindowTypeID.AprilFool)
    if aprilFoolWin ~= nil then
      aprilFoolWin:RefreshAprilFoolMain()
    end
    self._frameCtrl:AddActivityDataUpdateTimeListen(activityFrameId, data:GetARDExpiredTm() + 1, self.__ExpireDealCallback)
  end)
end

function ActRefreshDunController:EnterARDDungeonFormation(ARDDunData)
  local function enterFunc()
    DungeonCenterUtil.EnterDungeonFormationDeal()
    
    UIManager:HideWindow(UIWindowTypeID.AprilFool)
  end
  
  local function exitFunc(fmtId)
    DungeonCenterUtil.ExitDungeonFormationDeal()
    UIManager:ShowWindowOnly(UIWindowTypeID.AprilFool)
  end
  
  local commonBattleFunc
  
  local function nextBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    if dinterfaceData == nil then
      error("dungeon interface data is null,can't to next level")
      return
    end
    local dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    if dungeonLevelData == nil then
      error("dungeon tower level data is null,can't to next level")
      return
    end
    local nextDunLevelData = dungeonLevelData:GetNextTowerLevelData()
    commonBattleFunc(curSelectFormationData, callBack, nextDunLevelData)
  end
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = ARDDunData
    end
    commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
    local actId = dungeonLevelData.ARDData:GetActId()
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
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ARDDun, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    local ARDData = ARDCtrl:GetRefreshDunDataByActId(actId)
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.AprilFool):SetLPDActData(ARDData):SetLPDIsWin(isWin == true)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local ARDCtrl = ControllerManager:GetController(ControllerTypeId.ActRefreshDungeon)
    local interfaceData = DungeonInterfaceData.CreateARDDungeonInterface(dungeonLevelData)
    interfaceData:SetAfterClickBattleFunc(function(callback)
      local avgId = dungeonLevelData:GetARDDAvgId()
      local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
      local played = avgPlayCtrl:IsAvgPlayed(avgId)
      if not played then
        ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId, callback)
      else
        callback()
      end
    end)
    local firstPower, benchPower
    local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, false)
    if fmtCtrl ~= nil then
      firstPower, benchPower = fmtCtrl:CalculatePower(formationData)
    end
    ARDCtrl:RequestEnterARDDungeon(interfaceData, formationData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end, firstPower, benchPower)
  end
  
  local needKey = ARDDunData:GetConsumeKeyNum()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = ARDDunData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ARDDun)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.ARDDun, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey)
  fmtCtrl:EnterFormation()
end

function ActRefreshDunController:RequestEnterARDDungeon(interfaceData, formationData, callBack, firstPower, benchPower)
  local dungeonLevelData = interfaceData:GetIDungeonLevelData()
  local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
  local actId = dungeonLevelData.ARDData:GetActId()
  self.refreshDunNetWork:CS_ACTIVITY_REFRESHDUNGEON_EnterDungeon(actId, dungeonId, formationData, function(dataList)
    if dataList.Count == 0 then
      return
    end
    local NtfEnterMsgData = dataList[0]
    BattleDungeonManager:RealEnterDungeon(NtfEnterMsgData, nil, interfaceData)
    NetworkManager:HandleDiff(NtfEnterMsgData.syncUpdateDiff)
    if callBack ~= nil then
      callBack()
    end
  end, firstPower, benchPower)
end

function ActRefreshDunController:__OnTaskUpdate()
  for _, ARDData in pairs(self.__ARDDataDic) do
    ARDData:ARDRefreshTaskReddot()
  end
end

function ActRefreshDunController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskSyncFinish, self.__onTaskUpdate)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_refresh_dungeon)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_refresh_dungeon_hero)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_refresh_dungeon_dun)
end

return ActRefreshDunController
