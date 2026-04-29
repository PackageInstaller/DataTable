_class("UIBattleFinishHandler", Object)
UIBattleFinishHandler = UIBattleFinishHandler

function UIBattleFinishHandler:Constructor(uiBattle)
  self._uiBattle = uiBattle
  self._hasHandleBattleEnd = false
  self._autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self._autoBinder:BindEvent(GameEventType.BattleResultFinish, self, self.OnBattleEnd)
  self._autoBinder:BindEvent(GameEventType.ShowUIResult, self, self.ShowUIResult)
  self._autoBinder:BindEvent(GameEventType.ExitCoreGame, self, self.OnExitCoreGame)
end

function UIBattleFinishHandler:Dispose()
  self._uiBattle = nil
  self._autoBinder:UnBindAllEvents()
end

function UIBattleFinishHandler:OnBattleEnd(victory)
  if self._hasHandleBattleEnd then
    Log.fatal("---------------repeat battle end----------------")
    return
  end
  self._hasHandleBattleEnd = true
  HelperProxy:GetInstance():SetGameTimeScale(1)
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  self._uiBattle:HandleBattleEnd(enterData, victory)
  GameGlobal.GetModule(ItemModule):CommonAutoConversionEventOpen(false)
  self.rt = self._uiBattle:GetBattleResultCompleteRT()
  Log.debug("[match] UIBattle:OnBattleEnd ", enterData._match_type)
  if MatchType.MT_Mission == enterData._match_type then
    local mission = GameGlobal.GetModule(MissionModule)
    local missionID = enterData:GetMissionCreateInfo().mission_id
    local discoveryData = mission:GetDiscoveryData()
    local story = discoveryData:GetStoryByStageIdStoryType(missionID, StoryTriggerType.AfterFight)
    local isActive = mission:IsMissionStoryActive(missionID, ActiveStoryType.ActiveStoryType_AfterBattle)
    local isStage1 = Cfg.cfg_global.stage_1_id.IntValue == missionID
    local isStage1Fail = mission:GetCurMissionID() == 0
    if story and victory and (isStage1 and isStage1Fail or not isActive) then
      Log.debug("[match] UIBattle:OnBattleEnd ShowDialog UIStoryController", enterData._match_type)
      GameGlobal.UIStateManager():ShowDialog("UIStoryController", story.id, function()
        GameGlobal.TaskManager():CoreGameStartTask(function()
          mission:SetMissionStoryActive(self, missionID, ActiveStoryType.ActiveStoryType_AfterBattle)
        end)
        if isStage1 then
          GameGlobal:GetInstance():ExitCoreGame()
          GameGlobal.TaskManager():StartTask(function(TT)
            local guideModule = GameGlobal.GetModule(GuideModule)
            guideModule:DirectEnterStage2(TT)
          end)
        else
          self:OnBattleEndResult(victory)
        end
      end, false, false)
    else
      Log.debug("[match] UIBattle:OnBattleEnd OnBattleEndResult ", enterData._match_type)
      self:OnBattleEndResult(victory)
    end
  elseif MatchType.MT_ExtMission == enterData._match_type then
    local extMissionModule = GameGlobal.GetModule(ExtMissionModule)
    local extTaskID = enterData:GetMissionCreateInfo().m_nExtTaskID
    local story, isActive
    local cfg_extra_mission_story = Cfg.cfg_extra_mission_story({ExtMissionTaskID = extTaskID})[1]
    if cfg_extra_mission_story then
      for i = 1, table.count(cfg_extra_mission_story.StoryID) do
        if cfg_extra_mission_story.StoryActiveType[i] == ActiveStoryType.ActiveStoryType_AfterBattle then
          local extMissionStory = DiscoveryStory:New()
          extMissionStory:Init(cfg_extra_mission_story.StoryID[i], cfg_extra_mission_story.StoryActiveType[i])
          isActive = extMissionModule:IsMissionStoryActive(extTaskID, ActiveStoryType.ActiveStoryType_AfterBattle)
          story = extMissionStory
          break
        end
      end
    end
    if story and not isActive and victory then
      GameGlobal.UIStateManager():ShowDialog("UIStoryController", story.id, function()
        GameGlobal.TaskManager():CoreGameStartTask(function()
          extMissionModule:SetMissionStoryActive(self, extTaskID, ActiveStoryType.ActiveStoryType_AfterBattle)
        end)
        self:OnBattleEndResult(victory)
      end)
    else
      self:OnBattleEndResult(victory)
    end
  elseif MatchType.MT_ResDungeon == enterData._match_type then
    self:OnBattleEndResult(victory)
  elseif MatchType.MT_Maze == enterData._match_type then
    if victory then
      local mazeModule = GameGlobal.GetModule(MazeModule)
      local matchEnterData = GameGlobal.GetModule(MatchModule):GetMatchEnterData()
      local mazeCreateInfo = matchEnterData:GetMazeCreateInfo()
      if mazeModule:IsLastLayerRoom(mazeCreateInfo.maze_version, mazeCreateInfo.maze_layer, mazeCreateInfo.maze_room_index) then
        Log.debug("###maze - the last mission !")
        GameGlobal.UIStateManager():ShowDialog("UIRugueLikeBattleResultController", true)
      else
        Log.debug("###maze - not the last mission !")
        local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
        local matchResult = UI_MatchResult:New()
        matchResult = gameMatchModule:GetMachResult()
        local tempRelics = matchResult.relics
        if 0 < table.count(tempRelics) then
          GameGlobal.UIStateManager():ShowDialog("UIRugueLikeChooseCardController")
        else
          GameGlobal.UIStateManager():ShowDialog("UIRugueLikeBattleResultController", true)
        end
      end
    else
      GameGlobal:GetInstance():ExitCoreGame()
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Maze_Enter, "mj_01")
    end
  elseif MatchType.MT_Tower == enterData._match_type then
    self:OnBattleEndResult(victory)
  elseif MatchType.MT_TalePet == enterData._match_type then
    local mission = GameGlobal.GetModule(MissionModule)
    local info = enterData:GetTalePetMissionInfo()
    local missionID = info.nId
    local story = mission:GetStoryByStageIdStoryType(missionID, StoryTriggerType.AfterFight)
    local isActive = mission:IsMissionStoryActive(missionID, ActiveStoryType.ActiveStoryType_AfterBattle)
    if story and victory and not isActive then
      Log.debug("[match] UIBattle:OnBattleEnd ShowDialog UIStoryController", enterData._match_type)
      GameGlobal.UIStateManager():ShowDialog("UIStoryController", story, function()
        GameGlobal.TaskManager():CoreGameStartTask(function()
          mission:SetMissionStoryActive(self, missionID, ActiveStoryType.ActiveStoryType_AfterBattle)
        end)
        self:OnBattleEndResult(victory)
      end, false, false)
    else
      Log.debug("[match] UIBattle:OnBattleEnd OnBattleEndResult ", enterData._match_type)
      self:OnBattleEndResult(victory)
    end
  elseif MatchType.MT_Campaign == enterData._match_type then
    local mission = GameGlobal.GetModule(MissionModule)
    local missionID = enterData:GetCampaignMissionInfo().nCampaignMissionId
    local story = mission:GetStoryByStageIdStoryType(missionID, StoryTriggerType.AfterFight)
    local isActive = mission:IsMissionStoryActive(missionID, ActiveStoryType.ActiveStoryType_AfterBattle)
    if story and victory and not isActive then
      Log.debug("[match] UIBattle:OnBattleEnd ShowDialog UIStoryController", enterData._match_type)
      GameGlobal.UIStateManager():ShowDialog("UIStoryController", story, function()
        GameGlobal.TaskManager():CoreGameStartTask(function()
          mission:SetMissionStoryActive(self, missionID, ActiveStoryType.ActiveStoryType_AfterBattle)
        end)
        self:OnBattleEndResult(victory)
      end, false, false)
    else
      Log.debug("[match] UIBattle:OnBattleEnd OnBattleEndResult ", enterData._match_type)
      self:OnBattleEndResult(victory)
    end
  elseif MatchType.MT_LostArea == enterData._match_type then
    self:OnBattleEndResult(victory)
  elseif MatchType.MT_Conquest == enterData._match_type then
    self.rt = self._uiBattle:Shot()
    local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    if 0 >= matchResult.m_vecAwardNormal.count and victory then
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Exit_Core_Game, nil, nil)
    else
      self:OnBattleEndResult(victory)
    end
  elseif MatchType.MT_WorldBoss == enterData._match_type then
    self.rt = self._uiBattle:Shot()
    local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    if 0 >= matchResult.m_damage and victory then
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Exit_Core_Game, nil, nil)
    else
      self:OnBattleEndResult(victory)
    end
  elseif MatchType.MT_BlackFist == enterData._match_type then
    self:OnBattleEndResult(victory)
  elseif MatchType.MT_Chess == enterData._match_type then
    self.rt = self._uiBattle:Shot()
    local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    self:OnBattleEndResult(victory)
  elseif MatchType.MT_DifficultyMission == enterData._match_type then
    self:OnBattleEndResult(victory)
  elseif MatchType.MT_SailingMission == enterData._match_type then
    self:OnBattleEndResult(victory)
  elseif MatchType.MT_MiniMaze == enterData._match_type then
    self.rt = self._uiBattle:Shot()
    local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    if 0 >= matchResult.wave and victory then
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Exit_Core_Game, nil, nil)
    else
      self:OnBattleEndResult(victory)
    end
  elseif MatchType.MT_PopStar == enterData._match_type then
    self.rt = self._uiBattle:Shot()
    local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    if 0 >= matchResult._starNum and victory then
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Exit_Core_Game, nil, nil)
    else
      self:OnBattleEndResult(victory)
    end
  elseif MatchType.MT_EightPets == enterData._match_type then
    Log.debug("[match] UIBattle:OnBattleEnd OnBattleEndResult ", enterData._match_type)
    self:OnBattleEndResult(victory)
  elseif MatchType.MT_Season == enterData._match_type then
    local mission = GameGlobal.GetModule(MissionModule)
    local missionID = enterData:GetSeasonMissionInfo().mission_id
    local story = mission:GetStoryByStageIdStoryType(missionID, StoryTriggerType.AfterFight)
    local isActive = mission:IsMissionStoryActive(missionID, ActiveStoryType.ActiveStoryType_AfterBattle)
    local useMissionCfg = Cfg.cfg_season_mission[missionID]
    local secondMissionId
    if useMissionCfg then
      local secondMissionCfg
      local missionGroupId = useMissionCfg.GroupID
      local missionGroupCfgs = Cfg.cfg_season_mission({GroupID = missionGroupId})
      if 0 < #missionGroupCfgs then
        for index, value in ipairs(missionGroupCfgs) do
          if value.OrderID ~= useMissionCfg.OrderID then
            secondMissionCfg = value
            secondMissionId = value.ID
            break
          end
        end
      end
    end
    if story and victory and not isActive then
      Log.debug("[match] UIBattle:OnBattleEnd ShowDialog UIStoryController", enterData._match_type)
      GameGlobal.UIStateManager():ShowDialog("UIStoryController", story, function()
        GameGlobal.TaskManager():CoreGameStartTask(function()
          mission:SetMissionStoryActive(self, missionID, ActiveStoryType.ActiveStoryType_AfterBattle)
          if secondMissionId then
            mission:SetMissionStoryActive(self, secondMissionId, ActiveStoryType.ActiveStoryType_AfterBattle)
          end
        end)
        self:OnBattleEndResult(victory)
      end, false, false)
    else
      Log.debug("[match] UIBattle:OnBattleEnd OnBattleEndResult ", enterData._match_type)
      self:OnBattleEndResult(victory)
    end
  elseif MatchType.MT_PopStarPro == enterData._match_type then
    local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
    local matchResult = UI_MatchResult:New()
    matchResult = gameMatchModule:GetMachResult()
    if victory then
      local anipopModule = GameGlobal.GetModule(AnipopModule)
      local anipopInfo = anipopModule:GetAniPopInfo()
      local roundInfo = anipopInfo.round_info
      if matchResult.layer_mission_num == table.count(roundInfo.level_list) then
        GameGlobal.UIStateManager():ShowDialog("UIEliminateBattleResultController", true, matchResult.layer_mission_num)
        return
      end
      local tempRelics = matchResult.m_ext_star_rewards
      local tempSkills = matchResult.m_ext_skill_rewards
      if 0 < table.count(tempSkills) then
        GameGlobal.UIStateManager():ShowDialog("UIEliminateChooseSkillController", matchResult.layer_mission_num, nil, true)
      elseif 0 < table.count(tempRelics) then
        GameGlobal.UIStateManager():ShowDialog("UIEliminateChooseCardController", matchResult.layer_mission_num)
      else
        GameGlobal.UIStateManager():ShowDialog("UIEliminateBattleResultController", true, matchResult.layer_mission_num)
      end
    else
      GameGlobal.UIStateManager():ShowDialog("UIEliminateBattleResultController", false, matchResult.layer_mission_num)
    end
  elseif MatchType.MT_SeasonMaze == enterData._match_type then
    if enterData:GetSubMatchType() == MatchType.MT_WorldBoss then
      local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
      local matchResult = gameMatchModule:GetMachResult()
      if 0 >= matchResult.m_damage and victory then
        GameGlobal.GetModule(SeasonMazeModule):UIModule():TryExitBattle(enterData, true)
      else
        self:OnBattleEndResult(victory)
      end
    else
      self:OnBattleEndResult(victory)
    end
  else
    Log.exception("### MatchType not implement")
  end
end

function UIBattleFinishHandler:OnBattleEndResult(victory)
  local matchEnterData = GameGlobal.GetModule(MatchModule):GetMatchEnterData()
  if victory then
    local localPlayerInfo = matchEnterData:GetLocalPlayerInfo()
    if localPlayerInfo and localPlayerInfo.pet_list[1] then
      local petID = localPlayerInfo.pet_list[1].pet_pstid
      if petID ~= FormationPetPlaceType.FormationPetPlaceType_None then
        Log.debug("[match] UIBattle:OnBattleEndResult ShowResultUI")
        self:ShowResultUI()
      else
        Log.error("[match] UIBattle:OnBattleEndResult error petid")
      end
    else
      self:ShowResultUI()
    end
  else
    local type = Cfg.cfg_level_failed_revive[matchEnterData._match_type]
    if type and type.ReviveDialog and type.ReviveDialog == 1 then
      Log.debug("[match] UIBattle:OnBattleEndResult ShowDialog UIBattleResultRevive")
      GameGlobal.UIStateManager():ShowDialog("UIBattleResultRevive")
    else
      Log.debug("[match] UIBattle:OnBattleEndResult Dispatch CancelReborn")
      GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelReborn)
    end
  end
  local funcModule = GameGlobal.GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(false)
end

function UIBattleFinishHandler:ShowResultUI()
  local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
  local matchResult = gameMatchModule:GetMachResult()
  local normalRewards = matchResult.m_vecAwardNormal
  local starRewards = matchResult.m_vecAwardPerfect
  local fstRewards = matchResult.m_vecFirstPassAward
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  local dropPets = {}
  if normalRewards then
    local matchType = enterData:GetMatchType()
    if matchType == MatchType.MT_SeasonMaze then
    else
      for i, v in ipairs(normalRewards) do
        if self:IsDropPet(v.assetid) then
          table.insert(dropPets, v)
        end
      end
    end
  end
  if starRewards then
    for i, v in ipairs(starRewards) do
      if self:IsDropPet(v.assetid) then
        table.insert(dropPets, v)
      end
    end
  end
  if fstRewards then
    for i, v in ipairs(fstRewards) do
      if self:IsDropPet(v.assetid) then
        table.insert(dropPets, v)
      end
    end
  end
  if dropPets and table.count(dropPets) > 0 then
    GameGlobal.UIStateManager():ShowDialog("UIPetObtain", dropPets, function()
      self:ShowUIResult(true)
    end)
  else
    self:ShowUIResult(true)
  end
end

function UIBattleFinishHandler:ShowUIResult(isWin)
  local missionModule = GameGlobal.GetModule(MissionModule)
  if missionModule:GetCurMissionID() == 0 then
    Log.debug("[match] UIBattle:ShowUIResult OnExitCoreGame")
    self:OnExitCoreGame()
  else
    local petData
    local matchEnterData = GameGlobal.GetModule(MatchModule):GetMatchEnterData()
    local localPlayerInfo = matchEnterData:GetLocalPlayerInfo()
    self.isWin = isWin
    GameGlobal.UIStateManager():ShowDialog("UIBattleResultComplete", isWin, localPlayerInfo.pet_list, self.rt, self.autoParam)
    Log.debug("[match] UIBattle:ShowUIResult UIBattleResultComplete")
  end
end

function UIBattleFinishHandler:OnExitCoreGame(params)
  GameGlobal:GetInstance():ExitCoreGame()
  local matchModule = GameGlobal.GetModule(MatchModule)
  if matchModule then
    local enterData = matchModule:GetMatchEnterData()
    if enterData then
      local guideModule = GameGlobal.GetModule(GuideModule)
      local triggerGuide = false
      if not NOGUIDE and self.isWin == true then
        local levelId = enterData:GetLevelID()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideLevelFinish, levelId, function(trigger)
          triggerGuide = trigger
        end)
      end
      if not triggerGuide then
        local matchType = enterData:GetMatchType()
        if MatchType.MT_ExtMission == matchType then
          local matchModule = GameGlobal.GetModule(MatchModule)
          local enterData = matchModule:GetMatchEnterData()
          local missionInfo = enterData:GetMissionCreateInfo()
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
          Log.debug("[match] UIBattle:OnExitCoreGame SwitchState UIExtraMission")
          GameGlobal.UIStateManager():SwitchState(UIStateType.UIExtraMissionStage, missionInfo.m_nExtMissionID, stageid)
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_ResDungeon == matchType then
          local module = GameGlobal.GetModule(ResDungeonModule)
          local clientResInstance = module:GetClientResInstance()
          local instanceId = module:GetEnterInstanceId()
          local mainType = clientResInstance:GetMainTypeByInstanceId(instanceId)
          Log.debug("[match] UIBattle:OnExitCoreGame SwitchState UIResDetailController")
          GameGlobal.UIStateManager():SwitchState(UIStateType.UIResDetailController, mainType)
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_Maze == matchType then
          Log.debug("[match] UIBattle:OnExitCoreGame StartLoading Maze_Enter")
          GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Maze_Enter, "mj_01")
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_Tower == matchType then
          local towerData = enterData:GetTowerInfo()
          local cfg = Cfg.cfg_tower_detail[towerData.nId]
          if cfg == nil then
            Log.fatal("尖塔关卡id错误：", towerData.nId)
          end
          GameGlobal.UIStateManager():SwitchState(UIStateType.UITowerLayer, cfg.Type)
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_TalePet == matchType then
          local talePetModule = GameGlobal.GetModule(TalePetModule)
          local uiTalePetModule = talePetModule:GetUIModule(TalePetModule)
          local info = enterData:GetTalePetMissionInfo()
          uiTalePetModule:BattleExist(info.nId)
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_Campaign == matchType then
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
            local rt
            if params then
              rt = params[1]
            end
            campaignModule:ExitBattle(campaignMissionInfo, self.isWin, rt)
          end
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_LostArea == matchType then
          local uiLostLandModule = GameGlobal.GetUIModule(LostAreaModule)
          local resetTime = uiLostLandModule:GetResetTime()
          local svrTimerModule = GameGlobal.GetModule(SvrTimeModule)
          local nowTime = svrTimerModule:GetServerTime() * 0.001
          if resetTime < nowTime then
            uiLostLandModule:SetResetData(true)
          end
          uiLostLandModule:SwitchState()
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_Conquest == matchType then
          local ac = UIActivityCampaign:New()
          ac:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_N5)
          if 0 > ac._id then
            GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
          else
            local campaignModule = GameGlobal.GetModule(CampaignModule)
            campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN5BattleField, UIStateType.UIMain, nil, ac._id, ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD)
          end
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_BlackFist == matchType then
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
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_WorldBoss == matchType then
          GameGlobal.UIStateManager():SwitchState(UIStateType.UIWorldBoss)
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_Chess == matchType then
          self:ChessExit()
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_DifficultyMission == matchType then
          local matchModule = GameGlobal.GetModule(MatchModule)
          local enterData = matchModule:GetMatchEnterData()
          local info = enterData:GetDifficultyMissionInfo()
          local cfg = Cfg.cfg_difficulty_parent_mission[info.parent_mission_id]
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
            if params then
              rt = params[1]
            end
            campaignModule:ExitBattle(campaignMissionInfo, self.isWin, rt)
          else
            local nodeid = info.parent_mission_id
            local module = GameGlobal.GetModule(MissionModule)
            local data = module:GetDiscoveryData()
            data:UpdatePosByEnter(9, nodeid)
            GameGlobal.UIStateManager():SwitchState(UIStateType.UIDiscovery)
          end
        elseif MatchType.MT_SailingMission == matchType then
          GameGlobal.UIStateManager():SwitchState(UIStateType.UISailingChapter)
        elseif MatchType.MT_MiniMaze == matchType then
          GameGlobal.UIStateManager():SwitchState(UIStateType.UIN25VampireLevel)
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif matchType == MatchType.MT_PopStar then
          local missionInfo = enterData._client_create_info.popstar_mission_info[1]
          local campaignModule = GameGlobal.GetModule(CampaignModule)
          local campID, comID, comType = campaignModule:ParseCampaignMissionParams(missionInfo.CampaignMissionParams)
          local campConfig = Cfg.cfg_campaign[campID]
          local campType = campConfig.CampaignType
          local param = {campaign_type = campType}
          GameGlobal.UIStateManager():SwitchState(UIStateType.UISideEnterCenter, param)
        elseif matchType == MatchType.MT_EightPets then
          local eightPetsMissionInfo = enterData:GetEightPetsMissionInfo()
          local campaignModule = GameGlobal.GetModule(CampaignModule)
          local rt
          if params then
            rt = params[1]
          end
          local campaignMissionInfo = CampaignMissionCreateInfo:New()
          campaignMissionInfo.nCampaignMissionId = eightPetsMissionInfo.mission_id
          campaignMissionInfo.nMissionComId = eightPetsMissionInfo.component_id
          campaignMissionInfo.CampaignMissionParams = eightPetsMissionInfo.CampaignMissionParams
          campaignModule:ExitBattle(campaignMissionInfo, self.isWin, rt)
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_Season == matchType then
          Log.debug("[match] UIBattle:OnExitCoreGame SwitchState UISeason")
          local seasonModule = GameGlobal.GetModule(SeasonModule)
          seasonModule:ExitBattle(nil, false)
          GameGlobal.UIStateManager():ShowBusy(false)
        elseif MatchType.MT_PopStarPro == matchType then
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
        else
          Log.debug("[match] UIBattle:OnExitCoreGame SwitchState UIDiscovery")
          local module = GameGlobal.GetModule(MissionModule)
          local data = module:GetDiscoveryData()
          data:UpdatePosByEnter(4)
          GameGlobal.UIStateManager():SwitchState(UIStateType.UIDiscovery)
        end
      else
        GameGlobal.UIStateManager():ShowBusy(false)
      end
    else
      Log.error("[match] UIBattle:OnExitCoreGame error enterdata")
      GameGlobal.UIStateManager():ShowBusy(false)
    end
    matchModule:ClearMatchEnterData()
  end
end

function UIBattleFinishHandler:IsDropPet(roleAssetID)
  return roleAssetID >= RoleAssetID.RoleAssetPetBegin and roleAssetID <= RoleAssetID.RoleAssetPetEnd
end

function UIBattleFinishHandler:BlackFistLeave()
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

function UIBattleFinishHandler:ChessExit()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local process = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N29)
  local component = process:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_CHESS)
  if component:ComponentIsOpen() then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIN29ChessController, UIStateType.UIActivityN29MainController)
  else
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
end
