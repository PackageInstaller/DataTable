_class("UIActivityN33LevelController", UIController)
UIActivityN33LevelController = UIActivityN33LevelController

function UIActivityN33LevelController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIActivityCustomConst:New(ECampaignType.CAMPAIGN_TYPE_N33, self:GetComponentIds())
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
  end
  self._normalComponent = nil
  self._normalComponentInfo = nil
  self._hardComponent = nil
  self._hardComponentInfo = nil
  self._normalComponent, self._normalComponentInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
  self._hardComponent, self._hardComponentInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
end

function UIActivityN33LevelController:LoadData(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
end

function UIActivityN33LevelController:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnN33RefreshBuildStatus, self.RefreshShop)
  self:AttachEvent(GameEventType.UIActivityN33LevelRefresh, self.Refresh)
  self._levelType = uiParams[1]
  if self._levelType == nil then
    self._levelType = 1
  end
  self._isNormalUI = uiParams[2] and true
  self._selectMission = uiParams[3]
  self._battleReturn = uiParams[4] and true
  self._levelNameLabel = self:GetUIComponent("UILocalizationText", "LevelName")
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._shopRed = self:GetGameObject("ShopRed")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._positionBtn = self:GetGameObject("PositionBtn")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._btns = self:GetGameObject("Btns")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._currentBuild = nil
  self:Init()
end

function UIActivityN33LevelController:OnHide()
  self:DetachEvent(GameEventType.UIActivityN33LevelRefresh, self.Refresh)
  self:DetachEvent(GameEventType.OnN33RefreshBuildStatus, self.RefreshShop)
end

function UIActivityN33LevelController:GetBuildDatas(component, componentInfo, isHard)
  local cfgs = Cfg.cfg_n33_build({
    ComponentID = component:GetComponentCfgId()
  })
  if not cfgs then
    return {}
  end
  local result = {}
  for i = 1, #cfgs do
    local lockIcon, openIcon, selectIcon = self:GetBuildIcons(cfgs[i].ArchitectureId)
    result[#result + 1] = UIActivityExploreBuildData:New(cfgs[i], component, componentInfo, lockIcon, openIcon, selectIcon, isHard)
  end
  return result
end

function UIActivityN33LevelController:GetBuildIcons(buildId)
  local level = UIActivityN33DateHelper.GetDateBuildLvel(self._activityConst:GetCampaign(), buildId)
  local lockIcon = "N33_jyms_image_" .. buildId .. "_" .. level .. "_" .. self._levelType
  local openIcon = "N33_jyms_image_" .. buildId .. "_" .. level .. "_" .. self._levelType
  local selectIcon = "N33_jyms_sj_" .. buildId .. "_" .. level .. "_" .. self._levelType
  return lockIcon, openIcon, selectIcon
end

function UIActivityN33LevelController:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION
  return componentIds
end

function UIActivityN33LevelController:FocusBuild(buildId)
  self:SetBtnsStatus(false)
  local builds = {}
  if self._levelType == 1 then
    builds = self._normalLevels
  else
    builds = self._hardLevels
  end
  for i = 1, #builds do
    local build = builds[i]
    local data = build:GetData()
    if data:BuildId() == buildId then
      self._currentBuild = build
      break
    end
  end
  if self._currentBuild then
    self._currentBuild:SetSelectStatus(true)
  end
end

function UIActivityN33LevelController:CancelFocusBuild()
  local builds = {}
  if self._levelType == 1 then
    builds = self._normalLevels
  else
    builds = self._hardLevels
  end
  for i = 1, #builds do
    local build = builds[i]
    local data = build:GetData()
    if data:BuildId() == buildId then
      self._currentBuild = build
      break
    end
  end
  if self._currentBuild then
    self._currentBuild:SetSelectStatus(false)
  end
end

function UIActivityN33LevelController:RefreshBuilds()
  self._normalBuilds = self:GetBuildDatas(self._normalComponent, self._normalComponentInfo, false)
  self._hardBuilds = self:GetBuildDatas(self._hardComponent, self._hardComponentInfo, true)
  self._bossEnterTime = self:GetBossEnterTime()
  self._bossDisappearTime = self:GetBossDisappearTime()
  self._openTime = self:GetBuildOpenAnimationTime()
  local normalLevelLoader = self:GetUIComponent("UISelectObjectPath", "NormalLevelLoader")
  local hardLevelLoader = self:GetUIComponent("UISelectObjectPath", "HardLevelLoader")
  normalLevelLoader:SpawnObjects("UIActivityN33LevelItem", #self._normalBuilds)
  self._normalLevels = normalLevelLoader:GetAllSpawnList()
  for i = 1, #self._normalLevels do
    self._normalLevels[i]:SetData(self._normalBuilds[i], function(data)
      if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION, "", "") then
        return
      end
      local com, comInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
      self:ShowDialog("UIActivityN33LevelDetail", data, com, comInfo, self, ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
    end)
  end
  hardLevelLoader:SpawnObjects("UIActivityN33LevelItem", #self._hardBuilds)
  self._hardLevels = hardLevelLoader:GetAllSpawnList()
  for i = 1, #self._hardLevels do
    self._hardLevels[i]:SetData(self._hardBuilds[i], function(data)
      if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION, "", "") then
        return
      end
      local com, comInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
      self:ShowDialog("UIActivityN33LevelDetail", data, com, comInfo, self, ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
    end)
  end
end

function UIActivityN33LevelController:GetCurrentBuildDatas()
  if self._levelType == 1 then
    return self._normalBuilds
  end
  if self._levelType == 2 then
    return self._hardBuilds
  end
end

function UIActivityN33LevelController:GetLevelType()
  return self._levelType
end

function UIActivityN33LevelController:Init()
  self:RefreshActivityRemainTime()
  self:Refresh()
  self:PlayAnimation()
end

function UIActivityN33LevelController:PlayAnimation()
  self:StartTask(self.PlayAnimationCoro, self)
end

function UIActivityN33LevelController:PlayAnimationCoro(TT)
  self:Lock("UIActivityN33LevelController_PlayAnimEnterCoro")
  local normalLevelSelect = self:GetGameObject("NormalLevelSelected")
  local hardLevelSelect = self:GetGameObject("HardLevelSelected")
  normalLevelSelect:SetActive(self._levelType == 1)
  hardLevelSelect:SetActive(self._levelType == 2)
  local normal = self:GetGameObject("Normal")
  local hard = self:GetGameObject("Hard")
  normal:SetActive(self._levelType == 1)
  hard:SetActive(self._levelType == 2)
  if self._levelType == 1 then
    for i = 1, #self._normalLevels do
      self._normalLevels[i]:CheckPlayAnim()
    end
  else
    for i = 1, #self._hardLevels do
      self._hardLevels[i]:CheckPlayAnim()
    end
  end
  if self._openTime > 0 then
    YIELD(TT, self._openTime)
  end
  if 0 < self._bossEnterTime then
    YIELD(TT, self._bossEnterTime)
  end
  if 0 < self._bossDisappearTime then
    YIELD(TT, self._bossDisappearTime)
  end
  if self._battleReturn then
    if UIActivityN33LevelController.FromLevelList == true then
      self:BtnLevelsOnClick()
    else
      local currentLevelId = self:GetCurrentLevelId()
      local cacheCurrentLevelId = UIActivityN33LevelController.CurrentLevel
      local jumpId = self._selectMission
      if (0 < currentLevelId or 0 < cacheCurrentLevelId) and currentLevelId ~= cacheCurrentLevelId then
        jumpId = currentLevelId
      end
      if jumpId then
        if self._levelType == 1 then
          local data = self:GetMissionBuildData(self._normalBuilds, jumpId)
          if data then
            local com, comInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
            self:ShowDialog("UIActivityN33LevelDetail", data, com, comInfo, self, ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
          end
        elseif self._levelType == 2 then
          local data = self:GetMissionBuildData(self._hardBuilds, jumpId)
          if data then
            local com, comInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
            self:ShowDialog("UIActivityN33LevelDetail", data, com, comInfo, self, ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
          end
        end
      end
    end
  end
  self:UnLock("UIActivityN33LevelController_PlayAnimEnterCoro")
end

function UIActivityN33LevelController:GetBuildOpenAnimationTime()
  local builds = self._normalBuilds
  if self._levelType == 2 then
    builds = self._hardBuilds
  end
  local time = 0
  for i = 1, #builds do
    local build = builds[i]
    local canPlayOpenAnim = build:GetCanPlayOpenAnim()
    if canPlayOpenAnim then
      time = build:GetBuildUnlockAnimationLength()
      break
    end
  end
  return time
end

function UIActivityN33LevelController:GetBossEnterTime()
  local builds = self._normalBuilds
  if self._levelType == 2 then
    builds = self._hardBuilds
  end
  local time = 0
  for i = 1, #builds do
    local build = builds[i]
    local enterBoss = build:GetCanPlayEnterAnimBoss()
    if enterBoss then
      local boss = enterBoss:GetBoss()
      return boss:GetUnlockAnimLength()
    end
  end
  return time
end

function UIActivityN33LevelController:GetBossDisappearTime()
  local builds = self._normalBuilds
  if self._levelType == 2 then
    builds = self._hardBuilds
  end
  local time = 0
  for i = 1, #builds do
    local build = builds[i]
    local enterBoss = build:GetCanPlayDiappearAnimBoss()
    if enterBoss then
      local boss = enterBoss:GetBoss()
      return boss:GetDisappearAnimLength()
    end
  end
  return time
end

function UIActivityN33LevelController:CacheCurrentLevelId()
  UIActivityN33LevelController.CurrentLevel = self:GetCurrentLevelId()
end

function UIActivityN33LevelController:GetCurrentLevelId()
  local builds = self._normalBuilds
  if self._levelType == 2 then
    builds = self._hardBuilds
  end
  for i = 1, #builds do
    local build = builds[i]
    local level = build:GetCurrentLevel()
    if level then
      return level:GetMissionId()
    end
  end
  return 0
end

function UIActivityN33LevelController:GetMissionBuildData(builds, missionId)
  for i = 1, #builds do
    local build = builds[i]
    local missions = build:GetMissions()
    for j = 1, #missions do
      if missionId == missions[j]:GetMissionId() then
        return build
      end
    end
  end
  return nil
end

function UIActivityN33LevelController:RefreshShop()
  local com, comInfo
  com, comInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY)
  local icon, count = com:GetLotteryCostItemIconText()
  if 9999999 < count then
    count = 9999999
  end
  self._shopCountLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, count, "#B5B5B4", "#C8DD2A"))
  self._iconLoader:LoadImage(icon)
end

function UIActivityN33LevelController:Refresh()
  self:RefreshShop()
  local hardLevelLock = self:GetGameObject("HardLevelLock")
  local status = self._activityConst:GetComponentStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
  if status == ActivityComponentStatus.Open then
    hardLevelLock:SetActive(false)
  else
    hardLevelLock:SetActive(true)
  end
  local hardLevelNew = self:GetGameObject("HardLevelNew")
  hardLevelNew:SetActive(self._activityConst:IsShowComponentNew(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION))
  self:RereshRed()
  self:RefreshBuilds()
  local builds = self._normalBuilds
  if self._levelType == 2 then
    builds = self._hardBuilds
  end
  local showPosition = false
  for i = 1, #builds do
    local build = builds[i]
    if build:GetCurrentLevel() ~= nil then
      showPosition = true
      self._levelNameLabel:SetText(build:GetCurrentLevel():GetName())
      break
    end
  end
  self._positionBtn:SetActive(showPosition)
  self:SetBuildForcusStatus(false)
  self:_CheckGuide()
end

function UIActivityN33LevelController:SetBuildForcusStatus(status)
  if self._levelType == 1 then
    for i = 1, #self._normalLevels do
      self._normalLevels[i]:SetForcusStatus(status)
    end
  else
    for i = 1, #self._hardLevels do
      self._hardLevels[i]:SetForcusStatus(status)
    end
  end
end

function UIActivityN33LevelController:RereshRed()
  local isShow = self._activityConst:IsShowComponentRed(ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY)
  self._shopRed:SetActive(isShow)
end

function UIActivityN33LevelController:SwitchLevel(levelType)
  if self._levelType == levelType then
    return
  end
  self._levelType = levelType
  local normalLevelSelect = self:GetGameObject("NormalLevelSelected")
  local hardLevelSelect = self:GetGameObject("HardLevelSelected")
  normalLevelSelect:SetActive(self._levelType == 1)
  hardLevelSelect:SetActive(self._levelType == 2)
  self:Refresh()
  self:StartTask(self.SwitchLevelCoro, self)
end

function UIActivityN33LevelController:SwitchLevelCoro(TT)
  self:Lock("UIActivityN33LevelController_SwitchLevelCoro")
  local hardLevelNew = self:GetGameObject("HardLevelNew")
  hardLevelNew:SetActive(self._activityConst:IsShowComponentNew(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION))
  local normal = self:GetGameObject("Normal")
  local hard = self:GetGameObject("Hard")
  normal:SetActive(true)
  hard:SetActive(true)
  if self._levelType == 1 then
    self._anim:Play("uianim_UIActivityN33LevelController_switch_out")
    for i = 1, #self._normalLevels do
      self._normalLevels[i]:SwitLevelType(true)
    end
    for i = 1, #self._hardLevels do
      self._hardLevels[i]:SwitLevelType(false)
    end
  else
    self._anim:Play("uianim_UIActivityN33LevelController_switch_in")
    for i = 1, #self._normalLevels do
      self._normalLevels[i]:SwitLevelType(false)
    end
    for i = 1, #self._hardLevels do
      self._hardLevels[i]:SwitLevelType(true)
    end
  end
  YIELD(TT, 400)
  for i = 1, #self._normalLevels do
    self._normalLevels[i]:CheckPlayAnim()
  end
  for i = 1, #self._hardLevels do
    self._hardLevels[i]:CheckPlayAnim()
  end
  normal:SetActive(self._levelType == 1)
  hard:SetActive(self._levelType == 2)
  self:UnLock("UIActivityN33LevelController_SwitchLevelCoro")
end

function UIActivityN33LevelController:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
end

function UIActivityN33LevelController:RefreshActivityRemainTime()
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n33_activity_end"))
    return
  end
  local status, endTime = self._activityConst:GetComponentStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
  if self._levelType == 2 then
    status, endTime = self._activityConst:GetComponentStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
  end
  local tipsStr = "str_n33_activity_remain_time"
  local seconds = endTime
  if seconds <= 0 then
    seconds = 0
    self._timeLabel:SetText(StringTable.Get("str_n33_activity_end"))
    return
  end
  local timeStr = UIActivityCustomHelper.GetTimeString(seconds, "str_n33_day", "str_n33_hour", "str_n33_minus", "str_n33_less_one_minus")
  local timeTips = StringTable.Get(tipsStr, timeStr)
  self._timeLabel:SetText(timeTips)
end

function UIActivityN33LevelController:SetBtnsStatus(status)
  self._btns:SetActive(status)
end

function UIActivityN33LevelController:ShopOnClick()
  if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY, "str_n33_activity_shop_lock_time_tips", "str_n33_activity_shop_lock_mission_tips") then
    return
  end
  self:ShowDialog("UIN33ShopController")
end

function UIActivityN33LevelController:BtnGameOnClick()
  if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION, "str_n33_activity_game_lock_time_tips", "str_n33_activity_game_lock_mission_tips") then
    return
  end
  self:ShowDialog("UIActivityN33DateMainController")
end

function UIActivityN33LevelController:BtnLevelsOnClick()
  if self._levelType == 1 then
    if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION, "", "") then
      return
    end
  elseif not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION, "", "") then
    return
  end
  self:SetBtnsStatus(false)
  self:ShowDialog("UIActivityN33LevelList", self)
end

function UIActivityN33LevelController:NormalLevelOnClick()
  if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION, "", "") then
    return
  end
  self:SwitchLevel(1)
end

function UIActivityN33LevelController:HardLevelOnClick()
  if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION, "str_n33_activity_hard_level_lock_time_tips", "str_n33_activity_hard_level_lock_mission_tips") then
    return
  end
  self._activityConst:ClearComponentNew(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
  local hardLevelNew = self:GetGameObject("HardLevelNew")
  hardLevelNew:SetActive(false)
  self:SwitchLevel(2)
end

function UIActivityN33LevelController:PositionBtnOnClick()
  local builds = self._normalBuilds
  if self._levelType == 2 then
    builds = self._hardBuilds
  end
  local buildData
  for i = 1, #builds do
    local build = builds[i]
    if build:GetCurrentLevel() ~= nil then
      buildData = build
      break
    end
  end
  if buildData then
    if self._levelType == 1 then
      if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION, "", "") then
        return
      end
      local com, comInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
      self:ShowDialog("UIActivityN33LevelDetail", buildData, com, comInfo, self, ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
    else
      if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION, "", "") then
        return
      end
      local com, comInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
      self:ShowDialog("UIActivityN33LevelDetail", buildData, com, comInfo, self, ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
    end
  end
end

function UIActivityN33LevelController:CheckButtonStatus(componentId, timeLockStr, missionLockStr)
  local status, time = self._activityConst:GetComponentStatus(componentId)
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    if status == ActivityComponentStatus.ActivityEnd then
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
    else
      self:SwitchState(UIStateType.UIActivityN33MainController)
    end
    return false
  elseif status == ActivityComponentStatus.TimeLock then
    ToastManager.ShowToast(StringTable.Get(timeLockStr, UIActivityCustomHelper.GetTimeString(time, "str_n33_day", "str_n33_hour", "str_n33_minus", "str_n33_less_one_minus")))
    return false
  elseif status == ActivityComponentStatus.MissionLock then
    ToastManager.ShowToast(StringTable.Get(missionLockStr))
    return false
  end
  return true
end

function UIActivityN33LevelController:BtnReturnOnClick()
  if self._levelType == 1 then
    if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION, "", "") then
      return
    end
  elseif not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION, "", "") then
    return
  end
  if self._isNormalUI then
    self:SwitchState(UIStateType.UIActivityN33MainController)
  else
    self:SwitchState(UIStateType.UIActivityN33MainController)
  end
end

function UIActivityN33LevelController:BtnHomeOnClick()
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
end

function UIActivityN33LevelController:BtnDesOnClick()
  if self._levelType == 1 then
    if not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION, "", "") then
      return
    end
  elseif not self:CheckButtonStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION, "", "") then
    return
  end
  self:ShowDialog("UIIntroLoader", "UIActivityN33LevelIntro")
end

function UIActivityN33LevelController:_CheckGuide()
  local campaign = self._activityConst:GetCampaign()
  local isOpen = UIActivityN33DateHelper.CheckDateOpen(campaign)
  local guideModule = GameGlobal.GetModule(GuideModule)
  if isOpen and not guideModule:IsGuideDone(123001) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN33LevelController)
  end
end
