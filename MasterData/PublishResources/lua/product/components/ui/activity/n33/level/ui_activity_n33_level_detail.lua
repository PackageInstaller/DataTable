_class("UIActivityN33LevelDetail", UIController)
UIActivityN33LevelDetail = UIActivityN33LevelDetail

function UIActivityN33LevelDetail:OnShow(uiParams)
  self:AttachEvent(GameEventType.UIActivityN33LevelRefresh, self.RefreshHandle)
  self._data = uiParams[1]
  self._lineComponent = uiParams[2]
  self._lineComponentInfo = uiParams[3]
  self._levelController = uiParams[4]
  self._componentId = uiParams[5]
  self._levelController:FocusBuild(self._data:BuildId())
  self._normal = self:GetGameObject("NormalBG")
  self._normalNameLabel = self:GetUIComponent("UILocalizationText", "NormalName")
  self._normalDesLabel = self:GetUIComponent("UILocalizationText", "NormalDes")
  self._hard = self:GetGameObject("HardBG")
  self._hardNameLabel = self:GetUIComponent("UILocalizationText", "HardName")
  self._hardDesLabel = self:GetUIComponent("UILocalizationText", "HardDes")
  self._normal1 = self:GetGameObject("NormalBG1")
  self._hard1 = self:GetGameObject("HardBG1")
  self._build = self:GetGameObject("Build")
  self._boss = self:GetGameObject("Boss")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._buildStarLabel = self:GetUIComponent("UILocalizationText", "BuildStar")
  self._buildNameLabel = self:GetUIComponent("UILocalizationText", "BuildName")
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  self._bossStarLabel = self:GetUIComponent("UILocalizationText", "BossStar")
  self._bossNameLabel = self:GetUIComponent("UILocalizationText", "BossName")
  local levelType = self._levelController:GetLevelType()
  if levelType == 1 then
    self._normal:SetActive(true)
    self._normal1:SetActive(true)
    self._hard:SetActive(false)
    self._hard1:SetActive(false)
    self._normalNameLabel:SetText(self._data:GetName())
    self._normalDesLabel:SetText(self._data:GetDes())
  else
    self._normal:SetActive(false)
    self._normal1:SetActive(false)
    self._hard:SetActive(true)
    self._hard1:SetActive(true)
    self._hardNameLabel:SetText(self._data:GetName())
    self._hardDesLabel:SetText(self._data:GetDes())
  end
  self._loader = self:GetUIComponent("UISelectObjectPath", "Levels")
  self._scrollRect = self:GetUIComponent("ScrollRect", "Scroll View")
  self:Refresh()
end

function UIActivityN33LevelDetail:OnHide()
  self:DetachEvent(GameEventType.UIActivityN33LevelRefresh, self.RefreshHandle)
end

function UIActivityN33LevelDetail:RefreshBuildInfo()
  self._iconLoader:LoadImage(self._data:GetSelectIcon())
  self._buildNameLabel:SetText(self._data:GetName())
  self._buildStarLabel:SetText(self._data:GetStar() .. "/" .. self._data:TotalStar())
  self._build:SetActive(true)
  self._boss:SetActive(false)
  local currentLevel = self._data:GetCurrentLevel()
  if currentLevel then
    local boss = currentLevel:GetBoss()
    if boss then
      self._boss:SetActive(true)
      self._build:SetActive(false)
      self._bossNameLabel:SetText(boss:GetName())
      self._bossStarLabel:SetText(self._data:GetStar() .. "/" .. self._data:TotalStar())
      self._spine:LoadSpine(boss:GetSpine())
      self:PlaySpine(boss:GetIdleAnim())
    end
  end
end

function UIActivityN33LevelDetail:PlaySpine(animName)
  self._spineSke = self._spine.CurrentSkeleton
  if not self._spineSke then
    self._spineSke = self._spine.CurrentMultiSkeleton
  end
  if self._spineSke then
    self._spineSke.AnimationState:SetAnimation(0, animName, true)
  end
end

function UIActivityN33LevelDetail:RefreshHandle()
  local builds = self._levelController:GetCurrentBuildDatas()
  for i = 1, #builds do
    local build = builds[i]
    if build:BuildId() == self._data:BuildId() then
      self._data = build
      break
    end
  end
  self:Refresh()
end

function UIActivityN33LevelDetail:Refresh()
  local missions = self._data:GetMissions()
  self._loader:SpawnObjects("UIActivityN33LevelListItem", #missions)
  local levels = self._loader:GetAllSpawnList()
  for i = 1, #levels do
    levels[i]:SetData(self._data:GetCurrentLevel(), missions[i], function(data)
      if not self._levelController:CheckButtonStatus(self._componentId) then
        return
      end
      self:EnterLevel(data)
      UIActivityN33LevelController.FromLevelList = false
      self._levelController:CacheCurrentLevelId()
    end)
  end
  self:MoveToLast()
  self:RefreshBuildInfo()
end

function UIActivityN33LevelDetail:MoveToLast()
  local missions = self._data:GetMissions()
  local height = 119
  local space = 5
  local totalHeight = #missions * (height + space) + 7
  if 1 <= #missions then
    totalHeight = totalHeight - space
  end
  local go = self:GetGameObject("Scroll View")
  UIHelper.RefreshLayout(go:GetComponent("RectTransform"))
  local viewport = self._scrollRect.viewport
  local heightDelta = totalHeight - viewport.rect.height
  local lastIndex = 0
  for i = 1, #missions do
    local mission = missions[i]
    if mission:IsOpen() then
      lastIndex = i
    end
  end
  local currentHeight = lastIndex * (height + space) - viewport.rect.height + 7
  local percent = currentHeight / heightDelta
  if percent < 0 then
    percent = 0
  end
  if 1 < percent then
    percent = 1
  end
  percent = 1 - percent
  self._scrollRect.verticalNormalizedPosition = percent
end

function UIActivityN33LevelDetail:EnterLevel(data)
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
      self:PlotEndCallback(data:GetMissionId())
    end)
    return
  end
  local missionCfg = Cfg.cfg_campaign_mission[data:GetMissionId()]
  local autoFightShow = self:CheckSerialAutoFightShow(missionCfg.Type, data:GetMissionId())
  self:ShowDialog("UIActivityLevelStageNew", data:GetMissionId(), self._lineComponentInfo.m_pass_mission_info[data:GetMissionId()], self._lineComponent, autoFightShow, nil, nil, nil, nil, nil, false, true)
end

function UIActivityN33LevelDetail:CheckSerialAutoFightShow(stageType, stageId)
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

function UIActivityN33LevelDetail:PlotEndCallback(stageId)
  local isActive = self._lineComponent:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self:StartTask(function(TT)
    self._lineComponent:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self._lineComponent:HandleCompleteStoryMission(TT, res, stageId)
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

function UIActivityN33LevelDetail:PlayPlotComplete()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIActivityN33LevelRefresh)
end

function UIActivityN33LevelDetail:ClosBtnOnClick()
  if not self._levelController:CheckButtonStatus(self._componentId) then
    return
  end
  self._levelController:SetBtnsStatus(true)
  self._levelController:CancelFocusBuild()
  self:CloseDialog()
end

function UIActivityN33LevelDetail:BtnLevelsOnClick()
  if not self._levelController:CheckButtonStatus(self._componentId) then
    self:CloseDialog()
    return
  end
  self._levelController:CancelFocusBuild()
  self:CloseDialog()
  self:ShowDialog("UIActivityN33LevelList", self._levelController)
end

function UIActivityN33LevelDetail:MaskOnClick()
  self:ClosBtnOnClick()
end
