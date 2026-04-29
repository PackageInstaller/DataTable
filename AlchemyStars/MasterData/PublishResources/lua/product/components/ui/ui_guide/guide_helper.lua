_class("GuideHelper", Object)
GuideHelper = GuideHelper

function GuideHelper.Goto(showOpenUI)
  local uiName
  local type = showOpenUI[1]
  if type == GuideGotoType.FromAircraftTo then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftJumpOutTo, function()
      table.remove(showOpenUI, 1)
      uiName = GuideHelper._Goto(showOpenUI)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.OpenUI)
    end)
  else
    uiName = GuideHelper._Goto(showOpenUI)
  end
  return uiName
end

function GuideHelper._Goto(showOpenUI)
  local uiName
  local controllerType = showOpenUI[1]
  if controllerType == GuideGotoType.UIDiscovery then
    local missionId = showOpenUI[2]
    if missionId then
      local module = GameGlobal.GetModule(MissionModule)
      local data = module:GetDiscoveryData()
      data:UpdatePosByEnter(3, missionId)
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIDiscovery, true)
    else
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIDiscovery, true)
    end
    uiName = "UIDiscovery"
  elseif controllerType == GuideGotoType.UIPlayer then
    local petTempId = showOpenUI[2]
    if petTempId then
      local showTrain = showOpenUI[3]
      if showTrain == 1 then
        local pets = GameGlobal.GetModule(PetModule):GetPets()
        local petPsdId
        for key, v in pairs(pets) do
          if v:GetTemplateID() == petTempId then
            petPsdId = key
            break
          end
        end
        if petPsdId then
          uiName = "UIUpLevelInterfaceController"
          GameGlobal.UIStateManager():ShowDialog(uiName, petPsdId)
        end
      else
        uiName = "UISpiritDetailGroupController"
        GameGlobal.UIStateManager():ShowDialog(uiName, petTempId)
      end
    else
      uiName = "UIHeartSpiritController"
      GameGlobal.UIStateManager():ShowDialog(uiName)
    end
  elseif controllerType == GuideGotoType.UICard then
    uiName = "UIRecruit"
    GameGlobal.UIStateManager():ShowDialog("UIRecruit")
  elseif controllerType == GuideGotoType.UIQuest then
    uiName = "UIQuestController"
    GameGlobal.UIStateManager():ShowDialog(uiName)
  elseif controllerType == GuideGotoType.UIMain then
    uiName = "UIMainLobbyController"
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  elseif controllerType == GuideGotoType.UITeam then
    local missionId = showOpenUI[2]
    if missionId then
      local module = GameGlobal.GetModule(MissionModule)
      local data = module:GetDiscoveryData()
      data:UpdatePosByEnter(5, missionId)
      local ctx = module:TeamCtx()
      ctx:Init(TeamOpenerType.Stage, missionId)
      GameGlobal.UIStateManager():SwitchState(UIStateType.UITeams)
      uiName = "UITeams"
    end
  elseif controllerType == GuideGotoType.UIHelp then
    local helpEnum = showOpenUI[2]
    local cfg = Cfg.cfg_help({Enum = helpEnum})[1]
    if cfg then
      GameGlobal.UIStateManager():ShowDialog("UIHelpController", cfg.ID)
    end
    uiName = "UIHelpController"
  elseif controllerType == GuideGotoType.UIAircraft then
    local controller = GameGlobal.UIStateManager():GetController("UIAircraftController")
    if controller then
      local module = GameGlobal.GetModule(AircraftModule)
      local main = module:GetClientMain()
      main:MoveCameraToFar(function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.OpenUI)
      end)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, nil)
    else
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Enter, "fc_ui")
    end
    uiName = "UIAircraftController"
  elseif controllerType == GuideGotoType.CloseCurUI then
    local stateManager = GameGlobal.UIStateManager()
    local visibleUIList = stateManager.uiControllerManager:VisibleUIList()
    for i = 1, visibleUIList:Size() do
      local name = visibleUIList:GetAt(i)
      if stateManager:IsTopUI(name) then
        stateManager:CloseDialog(name)
        break
      end
    end
    uiName = ""
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.OpenUI)
  elseif controllerType == GuideGotoType.UIVideo then
    local videoName = showOpenUI[2]
    local duration = showOpenUI[3]
    GameGlobal.UIStateManager():ShowDialog("UIGuideVideoController", videoName, duration)
    uiName = "UIGuideVideoController"
  end
  return uiName
end

function GuideHelper.DontShowThreeMission()
  if not GuideHelper._dontShowThreeMissions then
    GuideHelper._dontShowThreeMissions = Cfg.cfg_guide_const.guide_no_threestar_missions.ArrayValue
  end
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  if enterData._match_type == MatchType.MT_Mission then
    local missionID = enterData:GetMissionCreateInfo().mission_id
    return table.icontains(GuideHelper._dontShowThreeMissions, missionID)
  else
    return false
  end
end

function GuideHelper.DontShowMainSkillMission()
  if not GuideHelper._dontShowMainSkillMissions then
    GuideHelper._dontShowMainSkillMissions = Cfg.cfg_guide_const.guide_no_active_skill_missions.ArrayValue
  end
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  if enterData._match_type == MatchType.MT_Mission then
    local missionID = enterData:GetMissionCreateInfo().mission_id
    return table.icontains(GuideHelper._dontShowMainSkillMissions, missionID)
  else
    return false
  end
end

function GuideHelper.GuideLoadLock(lock, mark)
  Log.debug("GuideHelper.GuideLoadLock", lock, mark, debug.traceback())
  if lock then
    GameGlobal.UIStateManager():Lock("GuideLoadLock")
  elseif GameGlobal.UIStateManager().uiControllerManager.lockManager:HasLock("GuideLoadLock") then
    GameGlobal.UIStateManager():UnLock("GuideLoadLock")
  end
end

function GuideHelper.IsUIGuideShow()
  return GameGlobal.GuideMessageBoxMng():IsGuideBoxShowing()
end

function GuideHelper.GuideInProgress()
  local guideModule = GameGlobal.GetModule(GuideModule)
  return guideModule:GuideInProgress()
end

function GuideHelper.IsUIGuideFailedComplete(TT)
  local uiGuideFailedShow = GameGlobal.UIStateManager():IsShow("UIGuideFailedController")
  while uiGuideFailedShow == false do
    uiGuideFailedShow = GameGlobal.UIStateManager():IsShow("UIGuideFailedController")
    YIELD(TT)
    if not GameGlobal:GetInstance():IsCoreGameRunning() then
      return
    end
  end
  while uiGuideFailedShow == true do
    uiGuideFailedShow = GameGlobal.UIStateManager():IsShow("UIGuideFailedController")
    YIELD(TT)
    if not GameGlobal:GetInstance():IsCoreGameRunning() then
      return
    end
  end
end
