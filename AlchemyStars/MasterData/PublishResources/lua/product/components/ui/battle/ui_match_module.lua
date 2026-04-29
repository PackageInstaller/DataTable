_class("UIMatchModule", UIModule)
UIMatchModule = UIMatchModule

function UIMatchModule:Init()
  self._isAutoFighting = false
end

function UIMatchModule:Dispose()
end

function UIMatchModule:Constructor()
  self:AttachEvent(GameEventType.MatchError, self.OnGameError)
  self:AttachEvent(GameEventType.OnGameOver, self.OnGameOver)
  self:Init()
end

function UIMatchModule:LeaveCoreGameOnError()
  GameGlobal:GetInstance():ExitCoreGame()
  Log.debug("[match] UIMatchModule:OnGameError:", GameGlobal.UIStateManager():CurUIStateType())
  local us = GameGlobal.UIStateManager():CurUIStateType()
  if us == UIStateType.Login or us == UIStateType.LoginEmpty then
    if GameGlobal.UIStateManager():IsShow("UIStoryController") then
      GameGlobal.UIStateManager():CloseDialog("UIStoryController")
    end
    if GameGlobal.UIStateManager():IsShow("UICommonLoading") then
      GameGlobal.UIStateManager():CloseDialog("UICommonLoading")
    end
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_match_net_error"), function(param)
      GameGlobal.GetModule(LoginModule):Logout("UIMatchModule LeaveCoreGame *at login state* logout")
      GameGlobal.GameLogic():BackToLogin(false, LoginModule, "player logout", false)
    end)
  elseif GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.Login and GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIMain then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_match_net_error"), function(param)
      GameGlobal.GetModule(LoginModule):Logout("UIMatchModule LeaveCoreGame *not at login or main state* logout")
      GameGlobal.GameLogic():BackToLogin(false, LoginModule, "player logout", false)
    end)
  end
end

function UIMatchModule:OnGameError()
  self:GetModule(MatchModule):StopFastCheck()
  GameGlobal:GetInstance():StopCoreGame()
  GameGlobal.TaskManager():KillCoreGameTasks()
  if not GameGlobal.TaskManager():IsAnyCoreGameTask() then
    self:LeaveCoreGameOnError()
    return
  end
  GameGlobal.TaskManager():WaitCoreGameTaskFinish(self.LeaveCoreGameOnError, self)
end

function UIMatchModule:OnGameOver(result)
  local funcModule = self:GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(true)
  local md = self:GetModule(MatchModule)
  local matchEnterData = md:GetMatchEnterData()
  md:SetMatchResult(result)
  local show_save = not table.icontains(BattleConst.MazeNoSaveArchiveLevelID, matchEnterData:GetLevelID())
  if not result.victory and matchEnterData:GetMatchType() == MatchType.MT_Maze then
    GameGlobal.UIStateManager():ShowDialog("UIRugueLikeDefeatedController", show_save)
  else
    md:GameOver(result)
  end
end

function UIMatchModule:IsAutoFighting()
  return self._isAutoFighting
end

function UIMatchModule:ShowAutoFightForbiddenMsg()
  self._autoFightForbiddenStr = StringTable.Get("str_battle_forbidden_operation_in_autofight")
  ToastManager.ShowToast(self._autoFightForbiddenStr)
end

function UIMatchModule:SetIsAutoFighting(isAutoFighting)
  self._isAutoFighting = isAutoFighting
end

function UIMatchModule:CheckAutoEnable()
  local match = GameGlobal.GetModule(MatchModule)
  local show, enable, value, msg
  local enterData = match:GetMatchEnterData()
  local matchType = enterData._match_type
  if MatchType.MT_Mission == matchType or MatchType.MT_ExtMission == matchType then
    show = true
    local data = enterData:GetMissionCreateInfo()
    local cfgId = {}
    if matchType == MatchType.MT_Mission then
      cfgId = {
        data.mission_id
      }
    elseif matchType == MatchType.MT_ExtMission then
      cfgId = {
        data.m_nExtMissionID,
        data.m_nExtTaskID
      }
    end
    enable, msg = GameGlobal.GetModule(RoleModule):GetAutoFightStatusUI(cfgId, matchType)
  elseif MatchType.MT_ResDungeon == matchType then
    show = true
    local data = enterData:GetResDungeonInfo()
    local ids = {
      data.res_dungeon_id
    }
    enable, msg = GameGlobal.GetModule(RoleModule):GetAutoFightStatusUI(ids, matchType)
  elseif MatchType.MT_Campaign == matchType then
    local campaignMissionInfo = enterData:GetCampaignMissionInfo()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    show = true
    enable, msg = campaignModule:CheckMissionCanAutoFight(campaignMissionInfo)
  elseif MatchType.MT_SailingMission == matchType then
    show = false
    enable = false
  elseif MatchType.MT_Season == matchType then
    local seasonMissionInfo = enterData:GetSeasonMissionInfo()
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    show = true
    enable, msg = seasonModule:CheckMissionCanAutoFight(seasonMissionInfo)
  elseif MatchType.MT_PopStarPro == matchType then
    show = true
    enable = true
  elseif MatchType.MT_EightPets == matchType then
    local eightPetsMissionInfo = enterData:GetEightPetsMissionInfo()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    show = true
    enable, msg = campaignModule:CheckEightPetsMissionCanAutoFight(eightPetsMissionInfo)
  elseif MatchType.MT_SeasonMaze == matchType then
    local seasonMissionInfo = enterData:GetSeasonMissionInfo()
    local module = GameGlobal.GetModule(SeasonMazeModule)
    show = true
    enable, msg = module:CheckCanAutoFight(seasonMissionInfo)
  elseif MatchType.MT_Chess == matchType then
    show = false
    enable = false
  else
    show = true
    enable = true
  end
  local triggerGuideBattle = false
  if enable == true then
    local pstId = GameGlobal.GetModule(RoleModule):GetPstId()
    local key = pstId .. "GuideAutoBattle"
    local isGuideAutoBattle = LocalDB.GetInt(key)
    if isGuideAutoBattle <= 0 then
      triggerGuideBattle = true
      LocalDB.SetInt(key, 1)
    end
  end
  value = GameGlobal.GetModule(SerialAutoFightModule):IsRunning()
  return {
    bShow = show,
    bEnable = enable,
    bSerialRunning = value,
    disableMsg = msg,
    bTriggerGuideBattle = triggerGuideBattle
  }
end

local FastFightEnableType = {
  Enable = 0,
  EqualAutoFight = 1,
  Disable = 2
}
_enum("FastFightEnableType", FastFightEnableType)

function UIMatchModule:CheckExSpeedEnable()
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  local matchType = enterData._match_type
  local enableType = FastFightEnableType.Enable
  if MatchType.MT_Mission == matchType then
    local data = enterData:GetMissionCreateInfo()
    local cfg = Cfg.cfg_mission[data.mission_id]
    if cfg then
      enableType = cfg.FastFightEnable or FastFightEnableType.Enable
    end
  elseif MatchType.MT_Campaign == matchType then
    local campaignMissionInfo = enterData:GetCampaignMissionInfo()
    local missionCfg = Cfg.cfg_campaign_mission[campaignMissionInfo.nCampaignMissionId]
    if missionCfg then
      enableType = missionCfg.FastFightEnable or FastFightEnableType.Enable
    end
  elseif MatchType.MT_Season == matchType then
    local missionID = enterData:GetSeasonMissionInfo().mission_id
    local useMissionCfg = Cfg.cfg_season_mission[missionID]
    if useMissionCfg then
      enableType = useMissionCfg.FastFightEnable or FastFightEnableType.Enable
    end
  elseif MatchType.MT_SailingMission == matchType then
    local missionID = enterData:GetSailingMissionInfo().mission_id
    local cfgSailingMission = Cfg.cfg_sailing_mission[missionID]
    if cfgSailingMission then
      enableType = cfgSailingMission.FastFightEnable or FastFightEnableType.Enable
    end
  elseif MatchType.MT_ExtMission == matchType then
    local data = enterData:GetMissionCreateInfo()
    local cfg = Cfg.cfg_extra_mission_task[data.m_nExtTaskID]
    if cfg then
      enableType = cfg.FastFightEnable or FastFightEnableType.Enable
    end
  elseif MatchType.MT_EightPets == matchType then
    local data = enterData:GetEightPetsMissionInfo()
    local cfg = Cfg.cfg_eight_pets_mission[data.mission_id]
    if cfg then
      enableType = cfg.FastFightEnable or FastFightEnableType.Enable
    end
  else
    enableType = FastFightEnableType.EqualAutoFight
  end
  if enableType == FastFightEnableType.Enable then
    return true
  elseif enableType == FastFightEnableType.EqualAutoFight then
    local data = self:CheckAutoEnable()
    return data.bEnable
  elseif enableType == FastFightEnableType.Disable then
    return false
  elseif MatchType.MT_SeasonMaze == matchType then
    local missionID = enterData:GetSeasonMazeMissionInfo().mission_id
    local useMissionCfg = Cfg.cfg_season_maze_mission[missionID]
    if useMissionCfg then
      enableType = useMissionCfg.FastFightEnable
    end
  else
    Log.fatal("Invalid FastFightEnableType")
    return true
  end
end
