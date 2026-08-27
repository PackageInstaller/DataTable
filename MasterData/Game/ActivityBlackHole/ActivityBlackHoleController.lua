local ActivityBlackHoleController = class("ActivityBlackHoleController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local JumpManager = require("Game.Jump.JumpManager")
local FmtEnum = require("Game.Formation.FmtEnum")
local ActivityBlackHoleData = require("Game.ActivityBlackHole.Data.ActivityBlackHoleData")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local CS_MessageCommon = CS.MessageCommon

function ActivityBlackHoleController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_blackhole_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_blackhole_floor)
  ConfigData:LoadDynCfg(eDynConfigData.activity_blackhole_reward)
  ConfigData:LoadDynCfg(eDynConfigData.activity_blackhole_ui_config)
  ConfigData:LoadDynCfg(eDynConfigData.activity_blackhole_dungeon)
  ConfigData:LoadDynCfg(eDynConfigData.activity_blackhole_tag)
  self._dataDic = {}
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
end

function ActivityBlackHoleController:InitBlackHole(msg)
  local data = ActivityBlackHoleData.New()
  self._dataDic[msg.actId] = data
  data:InitBlackHoleData(msg)
  return data
end

function ActivityBlackHoleController:UpdateBlackHole(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateBlackHoleData(msg, true)
end

function ActivityBlackHoleController:RemoveBlackHole(actId)
  self._dataDic[actId] = nil
end

function ActivityBlackHoleController:IsHaveBlackHole()
  return table.count(self._dataDic) > 0
end

function ActivityBlackHoleController:ShowBlackHoleMainByActId(actId)
  local bHData = self:GetBlackHoleDataByActId(actId)
  if bHData == nil then
    return
  end
  bHData:SetBlackHoleLooked()
  local objNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  
  local function initFunc(myRank)
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityBlackHoleMain, function(window)
      if window == nil then
        return
      end
      window:InitEventBlackHoleMain(bHData, myRank)
    end)
  end
  
  local rankId = bHData:GetBlackHoleRankId()
  if rankId == 0 then
    initFunc(nil)
    return
  end
  objNetwork:CS_Rank_Detail(bHData:GetBlackHoleRankId(), 0, function(args)
    if not args then
      return
    end
    local msg = args[0]
    initFunc(msg.myRank)
  end)
end

function ActivityBlackHoleController:OnEnterBlackHoleDungeon(blackHoleDungeonData)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
    UIManager:HideWindow(UIWindowTypeID.ActivityBlackHoleMain)
    UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
  end
  
  local function exitFunc(fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.DungeonLevelDetail, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.ActivityBlackHoleMain)
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance)
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = blackHoleDungeonData
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
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ActBlackHole, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleWinEvent(function()
      local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_activity_blackhole, dungeonId, false, PlayerDataCenter.timestamp)
    end)
    local blackHoleData = self:GetBlackHoleData()
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local function returnActLbfunc()
      end
      
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.ActBlackHole):SetLPDActData(blackHoleData):SetLPDActId(blackHoleData:GetActId()):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(returnActLbfunc)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local actBlackHoleCtrl = ControllerManager:GetController(ControllerTypeId.ActBlackHole)
    local peridicFmtBuffSelect = fmtCtrl:GetCurEnterFmtData():GetPeridicFmtBuffSelect()
    local interfaceData = DungeonInterfaceData.CreateBlackHoleDungeonInterface(dungeonLevelData, peridicFmtBuffSelect)
    interfaceData:SetAfterClickBattleFunc(function(callback)
      callback()
    end)
    actBlackHoleCtrl:__ReqDungeonBattle(interfaceData, formationData, peridicFmtBuffSelect, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local blackHoleFloorData = blackHoleDungeonData:GetBlackHoleFloorData()
  local heroDic, fairyDic = blackHoleFloorData:GetRejectHeroAndFairyDic(blackHoleDungeonData:GetDungeonLevelStageId())
  local needKey = blackHoleDungeonData:GetConsumeKeyNum()
  local assistId = blackHoleDungeonData:GetAssistanceId()
  local reduceNum = blackHoleDungeonData:GetScoreRateReduceNum()
  local stageId = blackHoleDungeonData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.ActBlackHole)
  local fmtBuffSelectData = blackHoleDungeonData:GetBlackHoleBuffSelectData(stageId)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.ActBlackHole, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey):SetCardSetTempBannedHeroDic(heroDic):SetCardSetTempBannedFairyDic(fairyDic):SetIsOpenBuffSelect(fmtBuffSelectData ~= nil):SetPeridicFmtBuffSelect(fmtBuffSelectData):SetOfficialSupportCfgId(assistId):SetScoreRateReduce(reduceNum):AddStartBattleCustomCheckFunc("checkBlackHole", function(enterFmtData, fmtData)
    local heroIdDic = fmtData:GetFormationHeroDic()
    local bannedHeroDic = enterFmtData:GetCardSetTempBannedHeroDic()
    local supportHeroData = fmtData:GetSupportHeroData()
    for _, heroId in pairs(heroIdDic) do
      if bannedHeroDic ~= nil and bannedHeroDic[heroId] ~= nil and (supportHeroData == nil or supportHeroData.heroId ~= heroId) then
        CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7507))
        return false
      end
    end
    local bannedFairyDic = enterFmtData:GetCardSetTempBannedFairyDic()
    local fairyUid = fmtData:GetFmtFairyUID()
    if bannedFairyDic ~= nil and bannedFairyDic[fairyUid] and fairyUid ~= 0 then
      CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7507))
      return false
    end
    return true
  end)
  fmtCtrl:EnterFormation()
end

function ActivityBlackHoleController:__ReqDungeonBattle(interfaceData, formationData, fmtBuffSelectData, callBack)
  local dungeonLevelData = interfaceData:GetIDungeonLevelData()
  local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
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

function ActivityBlackHoleController:GetBlackHoleDataByActId(actId)
  return self._dataDic[actId]
end

function ActivityBlackHoleController:GetBlackHoleData()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActivityBlackHoleController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_blackhole_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_blackhole_floor)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_blackhole_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_blackhole_ui_config)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_blackhole_dungeon)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_blackhole_tag)
end

return ActivityBlackHoleController
