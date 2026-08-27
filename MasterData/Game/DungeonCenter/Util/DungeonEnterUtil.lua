local DungeonEnterUtil = {}
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local FmtEnum = require("Game.Formation.FmtEnum")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon

function DungeonEnterUtil.EnterCommonRepeatDg(dungenLevel, autoBattleCount, stgChallengeData)
  if autoBattleCount ~= nil and 0 < autoBattleCount then
    BattleDungeonManager.autoCtrl:EnterDungeonAutoModel(autoBattleCount, false)
  end
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
    UIManager:HideWindow(UIWindowTypeID.SteinsGateRepeat)
  end
  
  local function exitFunc(fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.DungeonLevelDetail, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.SteinsGateRepeat)
    if BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
      BattleDungeonManager.autoCtrl:ExitDungeonAutoModel()
    end
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = dungenLevel
    end
    commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
    local needKey = dungeonLevelData:GetConsumeKeyNum()
    local keyItemId = dungeonLevelData:GetEnterLevelCost()
    if needKey > PlayerDataCenter:GetItemCount(keyItemId) then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina, nil, nil, {
        needKey - PlayerDataCenter:GetItemCount(keyItemId)
      })
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
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.Repeat, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleWinEvent(function()
      local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
      local moduleId = dungeonLevelData:GetDgLvDoduleId()
      PlayerDataCenter:LocallyAddDungeonLimit(moduleId, dungeonId, false, PlayerDataCenter.timestamp)
    end)
    local actData = dungenLevel:GetRepeatDgLvActData()
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.Repeat):SetLPDActId(actData:GetActId()):SetLPDActData(actData):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(dungenLevel:GetRepeatDgLvReturnFunc())
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local interfaceData = DungeonInterfaceData.CreateCommonRepeatDungeonInterface(dungeonLevelData)
    interfaceData:SetAfterClickBattleFunc(function(callback)
      callback()
    end)
    interfaceData:SetDungeonReplayInfo(startBattleFunc, needKey, keyItemId)
    interfaceData:SetDgInterfaceStgChallengeData(stgChallengeData)
    DungeonEnterUtil.__ReqDungeonBattle(interfaceData, formationData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local needKey = dungenLevel:GetConsumeKeyNum()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = dungenLevel:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.Repeat)
  fmtCtrl:ResetFmtCtrlState()
  local enterFmtData = fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.Repeat, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey)
  if PlayerDataCenter.dungeonCenterData:HasDungeonChallengeTask(stageId) then
    enterFmtData:SetFmtCtrlChallengeData(true, nil, stgChallengeData)
  end
  fmtCtrl:EnterFormation()
end

function DungeonEnterUtil.__ReqDungeonBattle(interfaceData, formationData, callBack)
  local dungeonLevelData = interfaceData:GetIDungeonLevelData()
  local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
  local challengeModeEnter = {}
  local stgChallengeData = interfaceData:GetDgInterfaceStgChallengeData()
  if stgChallengeData then
    challengeModeEnter.chosenQuestIds = stgChallengeData:GetStgClgTaskOpenList()
  end
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
  end, nil, challengeModeEnter)
end

function DungeonEnterUtil.EnterActCommonRepeatDg(dungenLevel, autoBattleCount, stgChallengeData, enterFunc, exitFunc, fmtId, CreateInterfaceFunc)
  local needKey = dungenLevel:GetConsumeKeyNum()
  local keyItemId = dungenLevel:GetEnterLevelCost()
  if needKey > PlayerDataCenter:GetItemCount(keyItemId) then
    if keyItemId == ConstGlobalItem.SKey then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina, nil, nil, {
        needKey - PlayerDataCenter:GetItemCount(keyItemId)
      })
    end
    local err = ConfigData:GetTipContent(7916)
    cs_MessageCommon.ShowMessageTips(err)
    return
  end
  if autoBattleCount ~= nil and 0 < autoBattleCount then
    BattleDungeonManager.autoCtrl:EnterDungeonAutoModel(autoBattleCount, false)
  end
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = dungenLevel
    end
    commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
    local needKey = dungeonLevelData:GetConsumeKeyNum()
    local keyItemId = dungeonLevelData:GetEnterLevelCost()
    if needKey > PlayerDataCenter:GetItemCount(keyItemId) then
      if keyItemId == ConstGlobalItem.SKey then
        JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina, nil, nil, {
          needKey - PlayerDataCenter:GetItemCount(keyItemId)
        })
      end
      local err = ConfigData:GetTipContent(7916)
      cs_MessageCommon.ShowMessageTips(err)
      return
    end
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(fmtId, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleWinEvent(function()
      local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
      local moduleId = dungeonLevelData:GetDgLvDoduleId()
      PlayerDataCenter:LocallyAddDungeonLimit(moduleId, dungeonId, false, PlayerDataCenter.timestamp)
    end)
    local actData = dungenLevel:GetRepeatDgLvActData()
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.Repeat):SetLPDActId(actData:GetActId()):SetLPDActData(actData):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(dungenLevel:GetRepeatDgLvReturnFunc())
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local interfaceData = CreateInterfaceFunc(dungeonLevelData)
    interfaceData:SetAfterClickBattleFunc(function(callback)
      callback()
    end)
    interfaceData:SetDungeonReplayInfo(startBattleFunc, needKey, keyItemId)
    interfaceData:SetDgInterfaceStgChallengeData(stgChallengeData)
    DungeonEnterUtil.__ReqDungeonBattle(interfaceData, formationData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end)
  end
  
  local needKey = dungenLevel:GetConsumeKeyNum()
  local assistId = dungenLevel:GetAssistanceId()
  local keyItemId = dungenLevel:GetEnterLevelCost()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId = dungenLevel:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(fmtId)
  fmtCtrl:ResetFmtCtrlState()
  local enterFmtData = fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(fmtId, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey):SetEnterBattleTicketItemId(keyItemId):SetOfficialSupportCfgId(assistId)
  if PlayerDataCenter.dungeonCenterData:HasDungeonChallengeTask(stageId) then
    enterFmtData:SetFmtCtrlChallengeData(true, nil, stgChallengeData)
  end
  fmtCtrl:EnterFormation()
end

return DungeonEnterUtil
