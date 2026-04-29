_class("UIActivityN33LevelList", UIController)
UIActivityN33LevelList = UIActivityN33LevelList

function UIActivityN33LevelList:OnShow(uiParams)
  self:AttachEvent(GameEventType.UIActivityN33LevelRefresh, self.RefreshHandle)
  self._levelController = uiParams[1]
  self._normal = self:GetGameObject("NormalBG")
  self._hard = self:GetGameObject("HardBG")
  self._loader = self:GetUIComponent("UISelectObjectPath", "Levels")
  self._levelController:SetBuildForcusStatus(true)
  self._scrollRect = self:GetUIComponent("ScrollRect", "Scroll View")
  self:Refresh()
end

function UIActivityN33LevelList:OnHide()
  self:DetachEvent(GameEventType.UIActivityN33LevelRefresh, self.RefreshHandle)
end

function UIActivityN33LevelList:RefreshHandle()
  self:Refresh()
end

function UIActivityN33LevelList:Refresh()
  local levelType = self._levelController:GetLevelType()
  self._normal:SetActive(levelType == 1)
  self._hard:SetActive(levelType == 2)
  local missions = {}
  local builds = self._levelController:GetCurrentBuildDatas()
  local currentLevel
  for i = 1, #builds do
    local build = builds[i]
    local cur = build:GetCurrentLevel()
    if cur then
      currentLevel = cur
    end
    local totalMissions = build:GetMissions()
    for j = 1, #totalMissions do
      local mission = totalMissions[j]
      if mission:IsOpen() then
        missions[#missions + 1] = totalMissions[j]
      end
    end
  end
  self._loader:SpawnObjects("UIActivityN33LevelListItem", #missions)
  local levels = self._loader:GetAllSpawnList()
  for i = 1, #levels do
    levels[i]:SetData(currentLevel, missions[i], function(data)
      local lineComponent = data:GetComponent()
      if not lineComponent:ComponentIsOpen() then
        ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
        self:CloseDialog()
        return
      end
      self:EnterLevel(data)
      UIActivityN33LevelController.FromLevelList = true
    end)
  end
  self:MoveToLast()
end

function UIActivityN33LevelList:MoveToLast()
  self._scrollRect.verticalNormalizedPosition = 0
end

function UIActivityN33LevelList:EnterLevel(data)
  if data:GetLevelType() == DiscoveryStageType.Plot then
    local missionCfg = Cfg.cfg_campaign_mission[data:GetMissionId()]
    local titleId = StringTable.Get(missionCfg.Title)
    local titleName = StringTable.Get(missionCfg.Name)
    local missionModule = GameGlobal.GetModule(MissionModule)
    local storyId = missionModule:GetStoryByStageIdStoryType(data:GetMissionId(), StoryTriggerType.Node)
    if not storyId then
      Log.exception("配置错误,找不到剧情,关卡id:", data:GetMissionId())
      return
    end
    self:ShowDialog("UIActivityPlotEnter", titleId, titleName, storyId, function()
      self:PlotEndCallback(data)
    end)
    return
  end
  local componentInfo = data:GetComponentInfo()
  local missionCfg = Cfg.cfg_campaign_mission[data:GetMissionId()]
  local autoFightShow = self:CheckSerialAutoFightShow(missionCfg.Type, data:GetMissionId())
  self:ShowDialog("UIActivityLevelStageNew", data:GetMissionId(), componentInfo.m_pass_mission_info[data:GetMissionId()], data:GetComponent(), autoFightShow, nil, nil, nil, nil, nil, false, true)
end

function UIActivityN33LevelList:CheckSerialAutoFightShow(stageType, stageId)
  local autoFightShow = false
  if stageType == DiscoveryStageType.Plot then
    autoFightShow = false
  else
    local missionCfg = Cfg.cfg_campaign_mission[stageId]
    if missionCfg then
      local enableParam = missionCfg.EnableSerialAutoFight
      if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE then
        autoFightShow = false
      elseif enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE or enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK then
        autoFightShow = true
      end
    end
  end
  return autoFightShow
end

function UIActivityN33LevelList:PlotEndCallback(data)
  local lineComponent = data:GetComponent()
  local stageId = data:GetMissionId()
  local isActive = lineComponent:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self:StartTask(function(TT)
    lineComponent:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = lineComponent:HandleCompleteStoryMission(TT, res, stageId)
    if not res:GetSucc() then
      local campModule = GameGlobal.GetModule(CampaignModule)
    else
      self._levelController:LoadData(TT)
      if table.count(award) ~= 0 then
        self:ShowDialog("UIGetItemController", award, function()
          self:PlayPlotComplete()
        end)
      else
        self:PlayPlotComplete()
      end
    end
  end, self)
end

function UIActivityN33LevelList:PlayPlotComplete()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIActivityN33LevelRefresh)
end

function UIActivityN33LevelList:ClosBtnOnClick()
  self._levelController:SetBuildForcusStatus(false)
  self._levelController:SetBtnsStatus(true)
  self:CloseDialog()
end

function UIActivityN33LevelList:MaskOnClick()
  self:ClosBtnOnClick()
end
