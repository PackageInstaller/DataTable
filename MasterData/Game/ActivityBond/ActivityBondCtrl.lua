local base = require("Game.Common.Activity.ActCommonCtrlBase")
local ActivityBondCtrl = class("ActivityBondCtrl", base)
local ActivityBondData = require("Game.ActivityBond.Data.ActivityBondData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local FormationUtil = require("Game.Formation.FormationUtil")
local CS_MessageCommon = CS.MessageCommon

function ActivityBondCtrl:OnInit()
  base.OnInit(self)
end

function ActivityBondCtrl:LoadAllCfg()
  ConfigData:LoadDynCfg(eDynConfigData.activity_bond_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_bond_dun_group)
  ConfigData:LoadDynCfg(eDynConfigData.activity_bond_dunlist)
  ConfigData:LoadDynCfg(eDynConfigData.activity_bond_bond)
  ConfigData:LoadDynCfg(eDynConfigData.activity_bond_transfer_buff)
  ConfigData:LoadDynCfg(eDynConfigData.activity_bond_reward)
  ConfigData:LoadDynCfg(eDynConfigData.activity_bond_stage)
end

function ActivityBondCtrl:LoadAllListener()
end

function ActivityBondCtrl:UnLoadAllCfg()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_bond_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_bond_dun_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_bond_dunlist)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_bond_bond)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_bond_transfer_buff)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_bond_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_bond_stage)
end

function ActivityBondCtrl:UnLoadAllListener()
end

function ActivityBondCtrl:NewActData()
  local actData = ActivityBondData.New()
  return actData
end

function ActivityBondCtrl:OpenActBondUI(actId, backCallback, openCallback, formActData, battleReturnFunc, enterBattleCallback)
  local actBondData = self:GetActDataByActId(actId)
  actBondData:SetBondParentActData(formActData, battleReturnFunc, enterBattleCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.ActBondMain, function(win)
    if win == nil then
      return
    end
    win:InitActBond(actBondData, backCallback)
    if openCallback ~= nil then
      openCallback()
    end
  end)
end

function ActivityBondCtrl:ResetBondActRedDotRoot(reddotNode, actId)
  local actData = self:GetActDataByActId(actId)
  if actData ~= nil then
    actData:ReSetActivityReddotRoot(reddotNode)
  end
end

function ActivityBondCtrl:EnterBondDugeon(bondDunData)
  local actData = self:GetActFirstData()
  local formActData, battleReturnFunc, enterBattleCallback = actData:GetBondParentActData()
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.ActBondDunSelect)
    UIManager:HideWindow(UIWindowTypeID.ActBondMain)
    UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
  end
  
  local function exitFunc(fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.ActBondDunSelect)
    UIManager:ShowWindowOnly(UIWindowTypeID.ActBondMain)
    UIManager:ShowWindowOnly(UIWindowTypeID.DungeonLevelDetail, true)
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = bondDunData
    end
    if enterBattleCallback ~= nil then
      enterBattleCallback()
    end
    commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.BondDun, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleWinEvent(function()
      local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_activity_bond, dungeonId, false, PlayerDataCenter.timestamp)
    end)
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData
      if formActData ~= nil then
        lastPlayData = LastPlayData.New():SetLPDActId(formActData:GetActId()):SetLPDActData(formActData):SetLPDActSceneLoadoverCallback(function()
          if battleReturnFunc ~= nil then
            battleReturnFunc()
          end
          local bondWin = UIManager:GetWindow(UIWindowTypeID.ActBondMain)
          if bondWin ~= nil then
            bondWin:BondAct_ReopenDun(bondDunData)
          end
        end):SetLPDIsWin(isWin == true)
      else
        lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.Bond):SetLPDActId(actData:GetActId()):SetLPDActData(actData):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(function()
          local bondWin = UIManager:GetWindow(UIWindowTypeID.ActBondMain)
          if bondWin ~= nil then
            bondWin:BondAct_ReopenDun(bondDunData)
          end
        end)
      end
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local interfaceData = DungeonInterfaceData.CreateBondDungeonInterface(dungeonLevelData, actData:GetFormationRuleCfg())
    interfaceData:SetAfterClickBattleFunc(function(callback)
      callback()
    end)
    self:__RealEnterChallengen(interfaceData, formationData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = bondDunData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.BondDun)
  local bannedHeroDic = actData:GetBandHeroDic()
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.BondDun, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetIsShowTotalPow(false):SetIsEditShowPow(false):SetIsShowBtnLineupCmd(false):SetFormationRuleCfg(actData:GetFormationRuleCfg()):SetCardSetTempBannedHeroDic(bannedHeroDic):SetBondBuffId(bondDunData:GetBondBuff()):SetBondActId(actData:GetActId()):AddStartBattleCustomCheckFunc("checkBond", function(enterFmtData, fmtData)
    local heroIdDic = fmtData:GetFormationHeroDic()
    local bannedHeroDic = enterFmtData:GetCardSetTempBannedHeroDic()
    local supportHeroData = fmtData:GetSupportHeroData()
    for _, heroId in pairs(heroIdDic) do
      if bannedHeroDic ~= nil and bannedHeroDic[heroId] ~= nil and (supportHeroData == nil or supportHeroData.heroId ~= heroId) then
        CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7507))
        return false
      end
    end
    return true
  end)
  fmtCtrl:EnterFormation()
end

function ActivityBondCtrl:__RealEnterChallengen(interfaceData, formationData, callBack)
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

return ActivityBondCtrl
