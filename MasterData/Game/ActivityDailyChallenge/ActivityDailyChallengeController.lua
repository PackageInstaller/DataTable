local ActivityDailyChallengeController = class("ActivityDailyChallengeController", ControllerBase)
local base = ControllerBase
local ADCData = require("Game.ActivityDailyChallenge.ActivityDailyChallengeData")
local ADCDungeonLevelData = require("Game.ActivityDailyChallenge.ADCDungeonLevelData")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")
local PeridicFmtBuffSelectData = require("Game.PeriodicChallenge.PeridicFmtBuffSelectData")

function ActivityDailyChallengeController:OnInit()
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dataDic = {}
  self.__ExpireDealCallback = BindCallback(self, self.__ExpireDeal)
end

function ActivityDailyChallengeController:AddADC(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ADCData.New()
  data:InitADCData(msg)
  self._dataDic[msg.actId] = data
  self._frameCtrl:AddActivityDataUpdateTimeListen(data:GetActFrameId(), data:GetADCKeyItemRecure() + 1, self.__ExpireDealCallback)
end

function ActivityDailyChallengeController:UpdateADC(msg)
  local data = self._dataDic[msg.actId]
  if data == nil then
    return
  end
  data:UpdateADCData(msg)
end

function ActivityDailyChallengeController:RemoveADC(actId)
  self._dataDic[actId] = nil
end

function ActivityDailyChallengeController:GetADC(actId)
  return self._dataDic[actId]
end

function ActivityDailyChallengeController:HasLiveADC()
  return table.count(self._dataDic) > 0
end

function ActivityDailyChallengeController:GetADCOnce()
  for k, v in pairs(self._dataDic) do
    return v
  end
  return nil
end

function ActivityDailyChallengeController:RefreshADCDailyFlush()
  for k, v in pairs(self._dataDic) do
    v:RefreshADCDailyFlush()
  end
end

function ActivityDailyChallengeController:__ExpireDeal(activityFrameId)
  local actFrameData = self._frameCtrl:GetActivityFrameData(activityFrameId)
  local data = self._dataDic[actFrameData:GetActId()]
  if data == nil then
    return
  end
  local ADCNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityDailyChallenge)
  ADCNet:CS_ACTIVITY_DailyChallenge_RefreshUnlockItem(data:GetActId(), function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    data:UpdateADCKeyItemMsg(msg)
    self._frameCtrl:AddActivityDataUpdateTimeListen(activityFrameId, data:GetADCKeyItemRecure() + 1, self.__ExpireDealCallback)
  end)
end

function ActivityDailyChallengeController:TryADCOpenUI(actId, backFunc, callback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EventDaliyChallenge, function(win)
    if win == nil then
      return
    end
    win:InitADCMain(data, backFunc)
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityDailyChallengeController:EnterADCDungeon(ADCDungeonLevelData)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFunc()
    DungeonCenterUtil.EnterDungeonFormationDeal()
    UIManager:HideWindow(UIWindowTypeID.EventDaliyChallenge)
  end
  
  local function exitFunc()
    DungeonCenterUtil.ExitDungeonFormationDeal()
    UIManager:ShowWindowOnly(UIWindowTypeID.EventDaliyChallenge)
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = ADCDungeonLevelData
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
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ADCDungeon, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    local adcData = ADCDungeonLevelData:GetDungeonADCData()
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.ADC):SetLPDIsWin(isWin == true):SetLPDActData(adcData):SetLPDActId(adcData:GetActId())
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local peridicFmtBuffSelect = fmtCtrl:GetCurEnterFmtData():GetPeridicFmtBuffSelect()
    local interfaceData = DungeonInterfaceData.CreateADCDungeonInterface(dungeonLevelData, peridicFmtBuffSelect:GetFmtBuffCurAddScoreRate())
    interfaceData:SetAfterClickBattleFunc(function(callback)
      callback()
    end)
    self:__ReqDungeonBattle(interfaceData, peridicFmtBuffSelect, formationData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local needKey = ADCDungeonLevelData:GetConsumeKeyNum()
  local stageId = ADCDungeonLevelData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ADCDungeon)
  local fmtBuffSelectData = ADCDungeonLevelData:GetDungeonADCData():GetADCBuffSelectData(stageId)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.ADCDungeon, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey):SetIsOpenBuffSelect(fmtBuffSelectData ~= nil):SetPeridicFmtBuffSelect(fmtBuffSelectData):SetIsShowTotalPow(false):SetIsOpenBuffWhenEnter(true)
  fmtCtrl:EnterFormation()
end

function ActivityDailyChallengeController:__ReqDungeonBattle(interfaceData, fmtBuffSelectData, formationData, callBack)
  local dungenLevelData = interfaceData:GetIDungeonLevelData()
  local dungeonId = dungenLevelData:GetDungeonLevelStageId()
  local buff
  if fmtBuffSelectData ~= nil and fmtBuffSelectData:GetFmtBuffSelect() ~= nil then
    local buffIds = fmtBuffSelectData:GetFmtBuffSelect()
    buff = {}
    for _, buffId in ipairs(buffIds) do
      buff[buffId] = true
    end
  end
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNet:CS_ACTIVITY_DUNGEON_GeneralEnter(dungeonId, formationData, buff, function(dataList)
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

function ActivityDailyChallengeController:OnDelete()
end

return ActivityDailyChallengeController
