_class("UILeaveMatchHandler", Object)
UILeaveMatchHandler = UILeaveMatchHandler

function UILeaveMatchHandler:Constructor(uiBattle)
  self._uiBattle = uiBattle
  self._autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self._autoBinder:BindEvent(GameEventType.MatchClosed, self, self._OnMatchClosed)
  self._autoBinder:BindEvent(GameEventType.MazeReset, self._OnMazeReset)
end

function UILeaveMatchHandler:Dispose()
  self._uiBattle = nil
  self._autoBinder:UnBindAllEvents()
end

function UILeaveMatchHandler:_OnMatchClosed(isReStart)
  Log.fatal("UILeaveMatchHandler-------------------MatchClosed")
  GameGlobal.UIStateManager():Lock("battle-quit")
  GameGlobal.UIStateManager():ShowBusy(true)
  GameGlobal:GetInstance():StopCoreGame()
  GameGlobal.TaskManager():KillCoreGameTasks()
  GameGlobal.TaskManager():StartTask(self._LeaveMatch, self, isReStart)
end

function UILeaveMatchHandler:_LeaveMatch(TT, isReStart)
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  if not GameSingle then
    local res = GameGlobal.GetModule(GameMatchModule):LeaveMatch(TT, isReStart)
    if not res:GetSucc() then
      Log.fatal("离开对局失败")
      return
    end
  end
  GameGlobal:GetInstance():ExitCoreGame()
  GameGlobal.UIStateManager():ShowBusy(false)
  GameGlobal.UIStateManager():UnLock("battle-quit")
  if isReStart then
    local uiStateManager = GameGlobal.UIStateManager()
    local uiBattle = uiStateManager:GetController("UIBattle")
    if uiBattle then
      uiBattle:_CloseAllDialogs(true)
    end
    if uiStateManager:IsShow("UIBattle") then
      uiStateManager:CloseDialog("UIBattle")
    end
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.ReStart_Core_Game)
  else
    local matchType = enterData:GetMatchType()
    if matchType == MatchType.MT_Mission then
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIDiscovery, nil, enterData:GetLevelID())
    elseif self:IsSeasonOnceMission(enterData) then
      self:HandleLeaveMatchFor_SeasonOnceMission(TT, enterData)
    elseif matchType == MatchType.MT_DifficultyMission then
      self:HandleLeaveMatchFor_CampDiff(TT, enterData)
    elseif matchType == MatchType.MT_ExtMission then
      self:HandleLeaveMatchFor_ExtMission(TT, enterData)
    elseif matchType == MatchType.MT_ResDungeon then
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Res_Exit, "UI")
    elseif matchType == MatchType.MT_Maze then
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Maze_Enter, "mj_01")
    elseif matchType == MatchType.MT_Tower then
      self:HandleLeaveMatchFor_Tower(TT, enterData)
    elseif matchType == MatchType.MT_TalePet then
      self:HandleLeaveMatchFor_TalePet(TT, enterData)
    elseif matchType == MatchType.MT_Campaign then
      self:HandleLeaveMatchFor_Campaign(TT, enterData)
    elseif matchType == MatchType.MT_BlackFist then
      self:HandleLeaveMatchFor_BlackFist(TT, enterData)
    elseif matchType == MatchType.MT_Chess then
      self:HandleLeaveMatchFor_Chess(TT, enterData)
    elseif matchType == MatchType.MT_SailingMission then
      GameGlobal.UIStateManager():SwitchState(UIStateType.UISailingChapter)
    elseif matchType == MatchType.MT_PopStar then
      self:HandleLeaveMatchFor_PopStar(TT, enterData)
    elseif matchType == MatchType.MT_EightPets then
      self:HandleLeaveMatchFor_EightPets(TT, enterData)
    elseif matchType == MatchType.MT_Season then
      self:HandleLeaveMatchFor_Season(TT, enterData)
    elseif matchType == MatchType.MT_PopStarPro then
      self:HandleLeaveMatchFor_PopStarPro(TT, enterData)
    elseif matchType == MatchType.MT_SeasonMaze then
      self:HandleLeaveMatchFor_SeasonMaze(TT, enterData)
    end
    matchModule:ClearMatchEnterData()
  end
end

function UILeaveMatchHandler:HandleLeaveMatchFor_ExtMission(TT, enterData)
  local missionInfo = enterData:GetMissionCreateInfo()
  if missionInfo then
    local extMissionModule = GameGlobal.GetModule(ExtMissionModule)
    local stageid
    local extState = extMissionModule:UI_GetExtMissionState(missionInfo.m_nExtMissionID)
    local cfg_ext_mission = Cfg.cfg_extra_mission[missionInfo.m_nExtMissionID]
    if cfg_ext_mission then
      local stagelist = cfg_ext_mission.ExtTaskList
      if extState == EnumExtMissionState.Down then
        stageid = stagelist[1]
      else
        for i = 1, #stagelist do
          stageid = stagelist[i]
          local star = extMissionModule:UI_GetExtTaskState(missionInfo.m_nExtMissionID, stageid)
          if star <= 0 then
            break
          end
        end
      end
    else
      stageid = missionInfo.m_nExtTaskID
    end
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIExtraMissionStage, missionInfo.m_nExtMissionID, stageid)
  end
end

function UILeaveMatchHandler:HandleLeaveMatchFor_Tower(TT, enterData)
  local towerData = enterData:GetTowerInfo()
  local cfg = Cfg.cfg_tower_detail[towerData.nId]
  if cfg == nil then
    Log.fatal("尖塔关卡id错误：", towerData.nId)
  end
  GameGlobal.UIStateManager():SwitchState(UIStateType.UITowerLayer, cfg.Type)
end

function UILeaveMatchHandler:HandleLeaveMatchFor_TalePet(TT, enterData)
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  local uiTalePetModule = talePetModule:GetUIModule(TalePetModule)
  local info = enterData:GetTalePetMissionInfo()
  uiTalePetModule:BattleExist(info.nId)
end

function UILeaveMatchHandler:HandleLeaveMatchFor_Campaign(TT, enterData)
  local isSwitchCard = false
  if GameGlobal.GetModule(AircraftModule):IsAircraftCartridgeMission(enterData:GetCampaignMissionInfo().nMissionComId) then
    isSwitchCard = true
  end
  if isSwitchCard then
    Log.debug("###[UIBattle] 战术卡带退局load到风船")
    local handler = LoadingHandlerName.Aircraft_Enter
    GameGlobal.TaskManager():StartTask(function()
      YIELD(TT)
      if GameGlobal.UIStateManager():IsShow("UICommonLoading") then
        GameGlobal.UIStateManager():CloseDialog("UICommonLoading")
      end
      GameGlobal.LoadingManager():StartLoading(handler, "fc_ui", OpenAircraftParamType.Spaceid, 16, "UIAircraftTactic")
    end)
  else
    local campaignMissionInfo = enterData:GetCampaignMissionInfo()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    local campID, comID, comType = campaignModule:ParseCampaignMissionParams(campaignMissionInfo.CampaignMissionParams)
    local campConfig = Cfg.cfg_campaign[campID]
    local campType = campConfig and campConfig.CampaignType
    if campType == ECampaignType.CAMPAIGN_TYPE_SEASON_TASK_MISSION then
      self:HandleLeaveMatchFor_Season(TT, enterData)
    elseif campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON and comID == ECCampaignSeasonComponentID.LINE_MISSION then
      GameGlobal.GetUIModule(SeasonModule):SetTalentTreeBattleOut(true)
      local missionID = campaignMissionInfo.nCampaignMissionId
      Log.debug("###[UILeaveMatchHandler] SaveFinishLineMissionList leave battle save id:", missionID)
      GameGlobal.GetUIModule(SeasonModule):SaveFinishLineMissionList(missionID)
      self:HandleLeaveMatchFor_Season(TT, enterData)
    else
      self._uiBattle:ShotBattleResult()
      local rt
      if self._uiBattle._battleResultRt then
        rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
        YIELD(TT)
        UnityEngine.Graphics.Blit(self._uiBattle._battleResultRt, rt)
      end
      campaignModule:ExitBattle(campaignMissionInfo, false, rt)
    end
  end
  GameGlobal.UIStateManager():ShowBusy(false)
end

function UILeaveMatchHandler:HandleLeaveMatchFor_BlackFist(TT, enterData)
  local isSwitchCard = false
  if GameGlobal.GetModule(AircraftModule):IsAircraftCartridgeMission(enterData:GetBlackFistInfo().component_id) then
    isSwitchCard = true
  end
  if isSwitchCard then
    Log.debug("###[UIBattle] 战术卡带退局load到风船")
    local handler = LoadingHandlerName.Aircraft_Enter
    GameGlobal.TaskManager():StartTask(function()
      YIELD(TT)
      if GameGlobal.UIStateManager():IsShow("UICommonLoading") then
        GameGlobal.UIStateManager():CloseDialog("UICommonLoading")
      end
      GameGlobal.LoadingManager():StartLoading(handler, "fc_ui", OpenAircraftParamType.Spaceid, 16, "UIAircraftTactic")
    end)
  elseif enterData:GetBlackFistInfo().component_id == ECampaignMissionComponentId.ECampaignMissionComponentId_SimulatorBlackfist then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    local camp = UIActivityCampaign:New()
    camp:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_N8)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN8BattleSimulatorController, UIStateType.UIMain, nil, camp._id, ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR)
  else
    self:BlackFistLeave()
  end
end

function UILeaveMatchHandler:HandleLeaveMatchFor_Chess(TT, enterData)
  local isSwitchCard = false
  if GameGlobal.GetModule(AircraftModule):IsAircraftCartridgeMission(enterData:GetChessInfo().component_id) then
    isSwitchCard = true
  end
  if isSwitchCard then
    Log.debug("###[UIBattle] 战术卡带退局load到风船")
    local handler = LoadingHandlerName.Aircraft_Enter
    GameGlobal.TaskManager():StartTask(function()
      YIELD(TT)
      if GameGlobal.UIStateManager():IsShow("UICommonLoading") then
        GameGlobal.UIStateManager():CloseDialog("UICommonLoading")
      end
      GameGlobal.LoadingManager():StartLoading(handler, "fc_ui", OpenAircraftParamType.Spaceid, 16, "UIAircraftTactic")
    end)
  elseif enterData:GetChessInfo().component_id == ECampaignMissionComponentId.ECampaignMissionComponentId_ChessMission then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    local camp = UIActivityCampaign:New()
    camp:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_N29)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN29ChessController, UIStateType.UIMain, {
      UIStateType.UIN29ChessController
    }, camp._id, ECampaignN29ComponentID.ECAMPAIGN_N29_CHESS)
  else
    self:ChessLeave()
  end
end

function UILeaveMatchHandler:BlackFistLeave()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local blackFightData = campaignModule:GetN7BlackFightData()
  local c = blackFightData:GetComponentBlackFight()
  if not c or not c:ComponentIsOpen() then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  else
    local diff = blackFightData.curDifficulty
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIN7LevelDetailsController, blackFightData.curDifficulty)
  end
end

function UILeaveMatchHandler:ChessLeave()
end

function UILeaveMatchHandler:_OnMazeReset()
  Log.error("---------- maze reset and match closed --------------")
  GameGlobal.UIStateManager():ShowDialog("UIRugueLikeResetMsgBoxController", StringTable.Get("str_maze_tips_reset"), function()
    self:_OnMatchClosed()
  end)
end

function UILeaveMatchHandler:HandleLeaveMatchFor_CampDiff(TT, enterData)
  local info = enterData:GetDifficultyMissionInfo()
  local nodeid = info.parent_mission_id
  local cfg = Cfg.cfg_difficulty_parent_mission[nodeid]
  local isCampaign = cfg.ComponentID and cfg.ComponentID ~= 0
  if isCampaign then
    local campaignMissionInfo = CampaignMissionCreateInfo:New()
    campaignMissionInfo.nCampaignMissionId = info.parent_mission_id
    campaignMissionInfo.nMissionComId = EDifficultyMissionComponentId.EDifficultyMissionComponentId_Campaign
    campaignMissionInfo.CampaignMissionParams = {
      [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = info.campaign_component_cfg_id
    }
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    local rt
    campaignModule:ExitBattle(campaignMissionInfo, self.isWin, rt)
  else
    local module = GameGlobal.GetModule(MissionModule)
    local data = module:GetDiscoveryData()
    data:UpdatePosByEnter(9, nodeid)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIDiscovery)
  end
end

function UILeaveMatchHandler:HandleLeaveMatchFor_PopStar(TT, enterData)
  local missionInfo = enterData._client_create_info.popstar_mission_info[1]
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campID, comID, comType = campaignModule:ParseCampaignMissionParams(missionInfo.CampaignMissionParams)
  local campConfig = Cfg.cfg_campaign[campID]
  local campType = campConfig.CampaignType
  local param = {campaign_type = campType}
  GameGlobal.UIStateManager():SwitchState(UIStateType.UISideEnterCenter, param)
end

function UILeaveMatchHandler:HandleLeaveMatchFor_PopStarPro(TT, enterData)
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  local roundInfo = anipopInfo.round_info
  local levelInfo = roundInfo.level_list[roundInfo.mission_index]
  if not anipopInfo or not levelInfo then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIEliminateController)
    ToastManager.ShowToast(StringTable.Get("str_pet_config_pet_error_faild19"))
  else
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIEliminateLevelController)
  end
end

function UILeaveMatchHandler:HandleLeaveMatchFor_EightPets(TT, enterData)
  local eightPetsMissionInfo = enterData:GetEightPetsMissionInfo()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._uiBattle:ShotBattleResult()
  local rt
  if self._uiBattle._battleResultRt then
    rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    YIELD(TT)
    UnityEngine.Graphics.Blit(self._uiBattle._battleResultRt, rt)
  end
  local campaignMissionInfo = CampaignMissionCreateInfo:New()
  campaignMissionInfo.nCampaignMissionId = eightPetsMissionInfo.mission_id
  campaignMissionInfo.nMissionComId = eightPetsMissionInfo.component_id
  campaignMissionInfo.CampaignMissionParams = eightPetsMissionInfo.CampaignMissionParams
  campaignModule:ExitBattle(campaignMissionInfo, false, rt)
  GameGlobal.UIStateManager():ShowBusy(false)
end

function UILeaveMatchHandler:HandleLeaveMatchFor_Season(TT, enterData)
  local seasonMissionInfo = enterData:GetSeasonMissionInfo()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  self._uiBattle:ShotBattleResult()
  local rt
  if self._uiBattle._battleResultRt then
    rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    YIELD(TT)
    UnityEngine.Graphics.Blit(self._uiBattle._battleResultRt, rt)
  end
  seasonModule:ExitBattle(seasonMissionInfo, false, rt)
  GameGlobal.UIStateManager():ShowBusy(false)
end

function UILeaveMatchHandler:IsSeasonOnceMission(enterData)
  local createInfo = enterData:GetMissionCreateInfo()
  if createInfo and createInfo.CampaignMissionParams then
    local campId, comId, comType = GameGlobal.GetModule(CampaignModule):ParseCampaignMissionParams(createInfo.CampaignMissionParams)
    local campConfig = Cfg.cfg_campaign[campId]
    local campType = campConfig and campConfig.CampaignType
    if campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON and (comId == ECCampaignSeasonComponentID.LINE_MISSION_BLACKFIST or comId == ECCampaignSeasonComponentID.LINE_MISSION_TALEN or comId == ECCampaignSeasonComponentID.LINE_MISSION_POPSTAR) then
      return true
    end
  end
  return false
end

function UILeaveMatchHandler:HandleLeaveMatchFor_SeasonOnceMission(TT, enterData)
  UISeasonHelper.TrySeasonBattleExit(enterData._match_type, false)
end

function UILeaveMatchHandler:HandleLeaveMatchFor_SeasonMaze(TT, enterData)
  self._uiBattle:ShotBattleResult()
  local rt
  if self._uiBattle._battleResultRt then
    rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    YIELD(TT)
    UnityEngine.Graphics.Blit(self._uiBattle._battleResultRt, rt)
  end
  GameGlobal.GetModule(SeasonMazeModule):UIModule():Enter()
  GameGlobal.UIStateManager():ShowBusy(false)
end
