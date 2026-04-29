_class("UIActivityLineLevelBase", UIController)
UIActivityLineLevelBase = UIActivityLineLevelBase

function UIActivityLineLevelBase:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
end

function UIActivityLineLevelBase:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self:GetCampaignType(), self._campaignType, self:GetLineComponentType(), self:GetFirstMeetComponentType())
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and res:GetSucc() then
    self._lineComponent = self._campaign:GetComponent(self:GetLineComponentType())
    self._lineComponentInfo = self._lineComponent:GetComponentInfo()
    local simpleOpenTime = self._lineComponentInfo.m_unlock_time
    local simpleCloseTime = self._lineComponentInfo.m_close_time
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    if simpleOpenTime > now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
      self._campModule:ShowErrorToast(res.m_result, true)
      return
    elseif simpleCloseTime < now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
      self._campModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityLineLevelBase:CheckTime()
  local simpleCloseTime = self._lineComponentInfo.m_close_time
  local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
  if simpleCloseTime < now then
    return false
  end
  return true
end

function UIActivityLineLevelBase:OnShow(uiParams)
  self._isNormalUI = uiParams[1] and true
  local backBtns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self._isNormalUI then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityMainStatusRefreshEvent)
      self:CloseWindow()
    else
      self:SwitchMainUI()
    end
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._shot.width = self._safeAreaSize.x
  self._shot.height = self._safeAreaSize.y
  self._time = self:GetUIComponent("UILocalizationText", "Time")
  self._firstRedPoint = self:GetGameObject("RedPoint")
  self._bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  self._bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  self:OnInit()
  self:AttachEvents()
  self:FlushNodes()
  self:RefreshCountdown()
  self:RefreshTryout()
  local lockName = "UINP7Level_OnShow"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
end

function UIActivityLineLevelBase:OnHide()
  self._isOpen = false
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  if self.BGRoll then
    self._scroller:Dispose()
  end
end

function UIActivityLineLevelBase:RefreshCountdown()
  local closeTime = self._lineComponentInfo.m_close_time
  self._isValid = true
  local timerName = "CountDown"
  
  local function countDown()
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local timeStr = self:GetFormatTimerStr(time)
    if self._timeString ~= timeStr then
      self._time:SetText(timeStr)
      self._timeString = timeStr
    end
    if time < 0 then
      self._isValid = false
      self._timerHolder:StopTimer(timerName)
    end
  end
  
  countDown()
  self._timerHolder:StartTimerInfinite(timerName, 1000, countDown)
end

function UIActivityLineLevelBase:GetFormatTimerStr(time, id)
  local timeStr = StringTable.Get("str_activity_error_107")
  if time < 0 then
    return timeStr
  end
  local dayStr, hourStr, minusStr, lessOneMinusStr = self:GetCustomTimeStr()
  timeStr = UIActivityCustomHelper.GetTimeString(time, dayStr, hourStr, minusStr, lessOneMinusStr)
  return StringTable.Get(self:GetCustomTimeTipsStr(), timeStr)
end

function UIActivityLineLevelBase:RefreshTryout()
  local cmp = self._campaign:GetComponent(self:GetFirstMeetComponentType())
  if not cmp then
    return
  end
  local cmpInfo = cmp:GetComponentInfo()
  if not cmpInfo then
    return
  end
  local passInfo = cmpInfo.m_pass_mission_info or {}
  
  function self._isTryoutLevelPass(mid)
    return passInfo[mid] ~= nil
  end
  
  local tryOutRed = self._campaign:CheckComponentRed(self:GetFirstMeetComponentType())
  if self._firstRedPoint then
    self._firstRedPoint:SetActive(tryOutRed)
  end
end

function UIActivityLineLevelBase:TryoutButtonOnClick()
  if not self._isValid then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
    return
  end
  self:ShowDialog("UIActivityPetTryController", self:GetCampaignType(), self:GetFirstMeetComponentType(), self._isTryoutLevelPass, function(missionid)
    local ctx = self._missionModule:TeamCtx()
    local localProcess = self._campaign:GetLocalProcess()
    local missionComponent = localProcess:GetComponent(self:GetFirstMeetComponentType())
    local param = {
      missionid,
      missionComponent:GetCampaignMissionComponentId(),
      missionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end

function UIActivityLineLevelBase:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityLineLevelBase:CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityLineLevelBase:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end

function UIActivityLineLevelBase:FlushNodes()
  local cmpID = self._lineComponent:GetComponentCfgId()
  local extra_cfg = Cfg.cfg_component_line_mission_extra({ComponentID = cmpID})
  local extra_width = extra_cfg[1].MarginRight
  local missionCfgs_temp = Cfg.cfg_component_line_mission({ComponentID = cmpID})
  local missionCfgs = {}
  for _, cfg in pairs(missionCfgs_temp) do
    missionCfgs[cfg.CampaignMissionId] = cfg
  end
  local unlockInfo = {}
  local firstMissionID
  for _, cfg in pairs(missionCfgs) do
    if unlockInfo[cfg.NeedMissionId] == nil then
      unlockInfo[cfg.NeedMissionId] = {}
    end
    unlockInfo[cfg.NeedMissionId][cfg.CampaignMissionId] = cfg
    if cfg.NeedMissionId == 0 then
      firstMissionID = cfg.CampaignMissionId
    end
  end
  local showMission = {}
  local levelCount, lineCount = 0, 0
  if next(self._lineComponentInfo.m_pass_mission_info) then
    for missionID, passInfo in pairs(self._lineComponentInfo.m_pass_mission_info) do
      if not showMission[missionID] and missionCfgs[missionID] then
        showMission[missionID] = missionCfgs[missionID]
        levelCount = levelCount + 1
      end
      if unlockInfo[missionID] then
        for id, cfg in pairs(unlockInfo[missionID]) do
          if not showMission[id] and missionCfgs[missionID] then
            showMission[id] = missionCfgs[id]
            levelCount = levelCount + 1
          end
          if cfg.WayPointType ~= 4 and cfg.NeedMissionId ~= 0 then
            lineCount = lineCount + 1
          end
        end
      end
    end
  else
    showMission[firstMissionID] = missionCfgs[firstMissionID]
    levelCount = 1
  end
  if 0 >= table.count(showMission) then
    showMission[firstMissionID] = missionCfgs[firstMissionID]
    levelCount = 1
  end
  self._nodesPool:SpawnObjects(self:GetLevelNodeName(), levelCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  self._linesPool:SpawnObjects(self:GetLevelLineName(), lineCount)
  local lines = self._linesPool:GetAllSpawnList()
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetData(cfg, self._lineComponentInfo.m_pass_mission_info[missionID], function(stageId, isStory, worldPos)
      self:OnNodeClick(stageId, isStory, worldPos)
    end)
    nodeIdx = nodeIdx + 1
    if cfg.WayPointType ~= 4 and cfg.NeedMissionId ~= 0 then
      local n1 = showMission[cfg.NeedMissionId]
      local n2 = cfg
      local line = lines[lineIdx]
      line:Flush(Vector2(n2.MapPosX, n2.MapPosY), Vector2(n1.MapPosX, n1.MapPosY))
      lineIdx = lineIdx + 1
    end
  end
  local right = -99999999
  for _, cfg in pairs(showMission) do
    right = math.max(right, cfg.MapPosX)
  end
  local width = math.abs(right + extra_width)
  width = math.max(self._safeAreaSize.x, width)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
  self.BGRoll = self:GetBgList()
  if self.BGRoll then
    local posx = {}
    for _, cfg in pairs(missionCfgs) do
      posx[#posx + 1] = cfg.MapPosX
    end
    table.sort(posx)
    local sp1, sp2 = 4, 8
    self._scroller = UILevelScroller:New(self._contentRect, self._bgLoader1, self._bgLoader2, self:GetBgList(), {
      posx[sp1],
      posx[sp1 + 1],
      posx[sp2],
      posx[sp2 + 1]
    })
    self._scrollRect.onValueChanged:AddListener(function()
      self._scroller:OnChange()
    end)
  end
  self._allMissionCfgs = missionCfgs
end

function UIActivityLineLevelBase:OnNodeClick(stageId, isStory, worldPos)
  local open = self:CheckTime()
  if not open then
    local lockName = self:GetLockName()
    self:StartTask(function(TT)
      self:Lock(lockName)
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
      YIELD(TT, 1000)
      self:UnLock(lockName)
      self:SwitchMainUI()
    end)
    return
  end
  if isStory then
    local missionCfg = Cfg.cfg_campaign_mission[stageId]
    local titleId = StringTable.Get(missionCfg.Title)
    local titleName = StringTable.Get(missionCfg.Name)
    local storyId = self._missionModule:GetStoryByStageIdStoryType(stageId, StoryTriggerType.Node)
    if not storyId then
      Log.exception("配置错误,找不到剧情,关卡id:", stageId)
      return
    end
    self:ShowDialog("UIActivityPlotEnter", titleId, titleName, storyId, function()
      self:PlotEndCallback(stageId)
    end)
    return
  end
  local pos = self._allMissionCfgs[stageId].MapPosX
  local curPos = self._contentRect.anchoredPosition.x
  local areaWidth = 258
  local halfScreen = self._safeAreaSize.x / 2
  local targetPos
  local left, right = -curPos + areaWidth, -curPos + self._safeAreaSize.x - areaWidth
  if pos < left then
    targetPos = curPos + left - pos
  elseif pos > right then
    targetPos = curPos + right - pos
  end
  self._scrollRect:StopMovement()
  if self._tweener then
    self._tweener:Kill()
    self._tweener = nil
  end
  if targetPos then
    local moveTime = 0.5
    self._tweener = self._contentRect:DOAnchorPosX(targetPos, moveTime)
    local moveLockName = "UINP6Level_MoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, moveTime * 1000, function()
      self:UnLock(moveLockName)
      self:EnterStage(stageId, worldPos)
    end)
  else
    self:EnterStage(stageId, worldPos)
  end
end

function UIActivityLineLevelBase:PlotEndCallback(stageId)
  local isActive = self._lineComponent:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self:StartTask(function(TT)
    self._lineComponent:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self._lineComponent:HandleCompleteStoryMission(TT, res, stageId)
    if not res:GetSucc() then
      self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    elseif table.count(award) ~= 0 then
      self:ShowDialog("UIGetItemController", award, function()
        self:SwitchState(self:GetLineLevelState())
      end)
    else
      self:SwitchState(self:GetLineLevelState())
    end
  end, self)
end

function UIActivityLineLevelBase:EnterStage(stageId, worldPos)
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local offset = -(Vector2(screenPos.x, screenPos.y) - Vector2(UnityEngine.Screen.width, UnityEngine.Screen.height) / 2)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:CheckSerialAutoFightShow(missionCfg.Type, stageId)
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._lineComponentInfo.m_pass_mission_info[stageId], self._lineComponent, autoFightShow, nil, nil, true, nil, nil, false, true)
end

function UIActivityLineLevelBase:CheckSerialAutoFightShow(stageType, stageId)
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

function UIActivityLineLevelBase:GetCampaignType()
  return nil
end

function UIActivityLineLevelBase:GetLineComponentType()
  return nil
end

function UIActivityLineLevelBase:GetFirstMeetComponentType()
  return nil
end

function UIActivityLineLevelBase:GetLevelNodeName()
  return ""
end

function UIActivityLineLevelBase:GetLevelLineName()
  return ""
end

function UIActivityLineLevelBase:GetBgList()
  return nil
end

function UIActivityLineLevelBase:GetLineLevelState()
  return nil
end

function UIActivityLineLevelBase:GetCustomTimeStr()
  return nil
end

function UIActivityLineLevelBase:GetCustomTimeTipsStr()
  return ""
end

function UIActivityLineLevelBase:CloseWindow()
  self:CloseDialog()
end

function UIActivityLineLevelBase:SwitchMainUI()
end

function UIActivityLineLevelBase:OnInit()
end

function UIActivityLineLevelBase:GetLockName()
  return nil
end
