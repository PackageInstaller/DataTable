local base = ControllerBase
local ActiviryHeroGrowV3Ctrl = class("ActiviryHeroGrowV3Ctrl", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local HeroGrowV3Enum = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3Enum")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local HeroGrowV3Data = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3Data")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local FormationUtil = require("Game.Formation.FormationUtil")

function ActiviryHeroGrowV3Ctrl:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_ui_config)
  ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_rebrush_dungeon)
  ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_challenge_reward)
  ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_challenge_dungeon)
  ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_avg)
  ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_normal_dungeon)
  ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_dungeon_list)
  self._dataDic = {}
  self.__onBattleResutltOpen = BindCallback(self, self.__OnBattleResutltOpenCallback)
  MsgCenter:AddListener(eMsgEventId.OnBattleResutltOpen, self.__onBattleResutltOpen)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

function ActiviryHeroGrowV3Ctrl:InitHeroGrowCtrlV3()
end

function ActiviryHeroGrowV3Ctrl:InitHGV3DataByAct(actFrameData)
  if actFrameData == nil then
    return
  end
  local actId = actFrameData:GetActId()
  if self._dataDic[actId] ~= nil then
    return
  end
  local data = HeroGrowV3Data.New()
  self._dataDic[actId] = data
  data:InitHeroGrowV3Data(actFrameData)
end

function ActiviryHeroGrowV3Ctrl:UpdateHGV3DataByMsg(msg)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actId = msg.actId
  local actFrameId = actFrameCtrl:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.HeroGrowV3, actId)
  local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
  local data = self._dataDic[actId]
  if data == nil then
    self:InitHGV3DataByAct(actFrameData)
    data = self._dataDic[actId]
  end
  data:RefreshHeroGrowV3Data(msg)
end

function ActiviryHeroGrowV3Ctrl:UpdateHGV3DataByMsgs(msgs)
  for _, singleMsg in ipairs(msgs) do
    self:UpdateHGV3DataByMsg(singleMsg)
  end
end

function ActiviryHeroGrowV3Ctrl:GetHeroGrowActivity(actId)
  return self._dataDic[actId]
end

function ActiviryHeroGrowV3Ctrl:GetHeroGrowV3Data()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActiviryHeroGrowV3Ctrl:OpenHeroGrowV3UI(actId, enterFunc, backCallback, selectSector, callback)
  local heroGrowDataV3 = self:GetHeroGrowActivity(actId)
  if heroGrowDataV3 == nil or not heroGrowDataV3:IsActivityRunning() then
    return
  end
  if selectSector ~= nil and not SectorStageDetailHelper.IsSectorNoCollide(selectSector) then
    selectSector = nil
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CharDunVer3, function(window)
    if window == nil then
      return
    end
    window:InitHeroGrowV3(heroGrowDataV3, enterFunc, backCallback)
    if selectSector ~= nil then
      window:EnterCharDunV3Sector(selectSector)
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function ActiviryHeroGrowV3Ctrl:ReqHeroGrowDailyFullReward(actId, day, callback)
  local data = self:GetHeroGrowActivity(actId)
  if not data:IsHeroGrowFullRewardCanReceive(day) then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.HeroGrowV3)
  network:CS_Activity_SectorHeroLite_DailyTaskFullReward(actId, day, function()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActiviryHeroGrowV3Ctrl:ReqHeroGrowDailyTaskAllReward(actId, callback)
  local data = self:GetHeroGrowActivity(actId)
  if not data:IsHeroGrowExistTaskReceive() then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.HeroGrowV3)
  network:CS_Activity_SectorHeroLite_DailyTaskAllReward(actId, function()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActiviryHeroGrowV3Ctrl:ReqHeroGrowSingleTokenReward(actId, tokenRewardLv, callback)
  local data = self:GetHeroGrowActivity(actId)
  if data._tokenRewardLevelDic[tokenRewardLv] then
    return
  end
  local tokenRewardCfg = data:GetTokenConfig()
  if tokenRewardCfg == nil then
    return
  end
  local tokenCfg = tokenRewardCfg[tokenRewardLv]
  if tokenCfg == nil then
    return
  end
  if tokenCfg.need_token > data:GetHeroGrowTokenCount() then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.HeroGrowV3)
  network:CS_Activity_SectorHeroLite_SingleTokenReward(actId, tokenRewardLv, function()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActiviryHeroGrowV3Ctrl:ReqHeroGrowAllTokenReward(actId, callback)
  local data = self:GetHeroGrowActivity(actId)
  if not data:IsHeroGrowExistLvReward() then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.HeroGrowV3)
  network:CS_Activity_SectorHeroLite_AllTokenReward(actId, function()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActiviryHeroGrowV3Ctrl:OnEnterHeroGrowChallenge(heroGrowChallengeData)
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
    
    UIManager:HideWindow(UIWindowTypeID.CahrDunChallengV3)
  end
  
  local function exitFunc(fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.DungeonLevelDetail, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.CahrDunChallengV3)
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = heroGrowChallengeData
    end
    commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
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
      PlayerDataCenter:LocallyAddDungeonLimit(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivitySpring, dungeonId, false, PlayerDataCenter.timestamp)
    end)
    local actData = self:GetHeroGrowActivity(heroGrowChallengeData.levelCfg.id)
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.HeroGrowChallenge):SetLPDActId(actData:GetActId()):SetLPDActData(actData):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(function()
        local mainWin = UIManager:GetWindow(UIWindowTypeID.CharDunVer3)
        if mainWin then
          mainWin:__OnClickChallenge()
        end
      end)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local interfaceData = DungeonInterfaceData.CreateHeroGrowChallengeInterface(dungeonLevelData)
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
  local stageId = heroGrowChallengeData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.FmtModeCommonHard)
  local challengeCfg = heroGrowChallengeData.levelCfg
  local officialCfgId = 0
  if challengeCfg ~= nil then
    officialCfgId = challengeCfg.assistance_id
  end
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.FmtModeCommonHard, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetOfficialSupportCfgId(officialCfgId)
  fmtCtrl:EnterFormation()
end

function ActiviryHeroGrowV3Ctrl:__RealEnterChallengen(interfaceData, formationData, callBack)
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

function ActiviryHeroGrowV3Ctrl:EnterHeroGrowV3Normal(heroGrowV3Data, normalData, dunStageId)
  BattleDungeonManager:InjectBattleExitEvent(function(isBatlleWin)
    ControllerManager:DeleteController(ControllerTypeId.Formation)
    local LastPlayData = require("Game.Sector.Data.LastPlayData")
    local lastPlayData = LastPlayData.New():SetLPDIsWin(isBatlleWin == true):SetLPDActData(heroGrowV3Data):SetLPDActId(heroGrowV3Data:GetActId()):SetLPDActSceneLoadoverCallback(function()
      local mainWin = UIManager:GetWindow(UIWindowTypeID.CharDunVer3)
      if mainWin then
        mainWin:__OnClickNormalLevel(normalData:GetHGV3NormalDataType())
      end
    end)
    UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
    PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
  end)
  BattleDungeonManager:InjectBattleWinEvent(function()
    local moduelId = normalData:GetHGV3ModuleId()
    PlayerDataCenter:LocallyAddDungeonLimit(moduelId, dunStageId, false, PlayerDataCenter.timestamp)
    self:__OnBattleResutltOpenCallback(dunStageId, heroGrowV3Data:GetActId())
  end)
  local formationData
  local groupType = normalData:GetHGV3SuitNumDicDungeonType()
  if normalData:GetHGV3NormalDataType() == HeroGrowV3Enum.HGV3NormalQuestType.officialTeam then
    local dungeonStageCfg = ConfigData.battle_dungeon[dunStageId]
    if dungeonStageCfg == nil then
      error("cant get dungeonStageCfg, id = " .. tostring(dunStageId))
      return
    end
    local fixedHeroTeamId = dungeonStageCfg.fixed_hero_team
    local defaultFmtId = FormationUtil.GetFmtIdByFixedTeamId(fixedHeroTeamId)
    FormationUtil.SetFiexdFmt(defaultFmtId, fixedHeroTeamId)
    formationData = PlayerDataCenter.formationDic[defaultFmtId]
  elseif normalData:GetHGV3NormalDataType() == HeroGrowV3Enum.HGV3NormalQuestType.freeTeam then
    local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastBattleDeployFmtId(groupType)
    formationData = PlayerDataCenter.formationDic[lastFmtId]
    if formationData == nil then
      formationData = PlayerDataCenter:CreateFormation(lastFmtId)
    end
  end
  BattleDungeonManager:SaveFormation(formationData)
  local actLongId = heroGrowV3Data:GetActFrameId()
  local dungeonId = dunStageId
  local moduleId = normalData:GetHGV3ModuleId()
  local interfaceData = DungeonInterfaceData.CreateHGV3Interface(normalData, dunStageId)
  BattleDungeonManager:RequestEnterDungeonGroup(actLongId, dungeonId, moduleId, formationData, interfaceData, function()
    ControllerManager:DeleteController(ControllerTypeId.SectorController)
  end)
end

function ActiviryHeroGrowV3Ctrl:__OnBattleResutltOpenCallback(dungeonId, actId)
  local actData = self:GetHeroGrowV3Data()
  if actData == nil then
    return
  end
  local avgId = actData:GetDungeonCompleteAvgId(dungeonId)
  self:PlayHeroGrowAvg(avgId)
end

function ActiviryHeroGrowV3Ctrl:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    data:RefreshDailyTaskComRed()
  end
end

function ActiviryHeroGrowV3Ctrl:__ItemUpdate(_, _, itemDic)
  for _, data in pairs(self._dataDic) do
    data:RefreshRepeatHaveTicketRed()
    data:RefreshBPRewardComRed()
  end
end

function ActiviryHeroGrowV3Ctrl:PlayHeroGrowAvg(avgId, callback)
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    return
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  if avgPlayCtrl:IsAvgPlayed(avgId) then
    return
  end
  avgPlayCtrl:ReqAvgComplete(avgId)
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:StartAvg(avgCfg.script_id, avgId, callback)
end

function ActiviryHeroGrowV3Ctrl:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_herolite_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_herolite_ui_config)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_herolite_challenge_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_herolite_challenge_dungeon)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_herolite_avg)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_herolite_normal_dungeon)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_herolite_dungeon_list)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleResutltOpen, self.__onBattleResutltOpen)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

return ActiviryHeroGrowV3Ctrl
