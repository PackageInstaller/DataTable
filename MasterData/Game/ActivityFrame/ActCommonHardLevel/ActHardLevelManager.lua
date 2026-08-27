local ActHardLevelManager = {}
local JumpManager = require("Game.Jump.JumpManager")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local FmtEnum = require("Game.Formation.FmtEnum")

function ActHardLevelManager.AHLM_EnterFormation(actHardLevelDunData)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
    UIManager:HideWindow(UIWindowTypeID.ActivityBlackHoleMain)
    UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.CommonHardLevel)
  end
  
  local function exitFunc(fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.DungeonLevelDetail, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.ActivityBlackHoleMain)
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance)
    UIManager:ShowWindowOnly(UIWindowTypeID.CommonHardLevel)
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = actHardLevelDunData
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
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.FmtModeCommonHard, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleWinEvent(function()
      local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_activity_anniv, dungeonId, false, PlayerDataCenter.timestamp)
    end)
    local actBaseData = dungeonLevelData:GetBelongActData()
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.CommonHard):SetLPDActData(actBaseData):SetLPDActId(actBaseData:GetActId()):SetLPDIsWin(isWin == true)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local peridicFmtBuffSelect = fmtCtrl:GetCurEnterFmtData():GetPeridicFmtBuffSelect()
    local interfaceData = DungeonInterfaceData.CreateCommonHardLevelDungeonInterface(dungeonLevelData, peridicFmtBuffSelect)
    interfaceData:SetAfterClickBattleFunc(function(callback)
      callback()
    end)
    local dungeonLevelData = interfaceData:GetIDungeonLevelData()
    local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
    local fmtBuffSelectData = dungeonLevelData:GetCommonHardLevelBuffSelectData(dungeonId)
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
  
  local needKey = actHardLevelDunData:GetConsumeKeyNum()
  local assistId = actHardLevelDunData:GetAssistanceId()
  local reduceNum = actHardLevelDunData:GetScoreRateReduceNum()
  local stageId = actHardLevelDunData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.FmtModeCommonHard)
  local fmtBuffSelectData = actHardLevelDunData:GetCommonHardLevelBuffSelectData(stageId)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.FmtModeCommonHard, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey):SetIsOpenBuffSelect(fmtBuffSelectData ~= nil):SetPeridicFmtBuffSelect(fmtBuffSelectData):SetOfficialSupportCfgId(assistId):SetScoreRateReduce(reduceNum)
  fmtCtrl:EnterFormation()
end

return ActHardLevelManager
