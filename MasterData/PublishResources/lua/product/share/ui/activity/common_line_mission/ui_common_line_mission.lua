_class("UICommonLineMission", UIController)
UICommonLineMission = UICommonLineMission

function UICommonLineMission:LoadDataOnEnter(TT, res, uiParams)
  if uiParams and uiParams[1] then
    self._campaign = uiParams[1]
  else
    self._campaign = UIActivityCampaign:New()
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_STORY_ACTIVITY, ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION, ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK)
  end
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function UICommonLineMission:OnShow(uiParams)
  self._line_component = self._campaign:GetComponent(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION)
  self._line_info = self._line_component:GetComponentInfo()
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  self:AttachEvents()
  self:InitWidget()
  self:_Refresh()
  local lockName = "UICommonLineMission_OnShow"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
  UIActivityHelper.SetCmptRedViewed(UICommonLineMissionConst.LineMissionDBID())
end

function UICommonLineMission:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  backBtns:SpawnObject("UINewCommonTopButton"):SetData(function()
    if self:Manager():CurUIStateType() == UIStateType.UICommonLineMission then
      self:SwitchState(UIStateType.UISideEnterCenter, {
        campaign_type = ECampaignType.CAMPAIGN_TYPE_STORY_ACTIVITY
      })
    else
      self:CloseDialog()
    end
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self.timeStr = self:GetUIComponent("UILocalizationText", "timeStr")
  self.awards = self:GetUIComponent("UISelectObjectPath", "AwardsEntry")
end

function UICommonLineMission:AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityClose)
end

function UICommonLineMission:OnHide()
  self._isOpen = false
  self._timerHolder:Dispose()
  if self._scroller then
    self._scroller:Dispose()
  end
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
  end
end

function UICommonLineMission:_Refresh()
  local awardsEntry = self.awards:SpawnObject("UICommonLineMissionAwardsEntry")
  awardsEntry:SetData(self._campaign, function()
    if self:CheckCampaignClose() then
      return true
    else
      return false
    end
  end)
  self:FlushNodes()
  self:TimeStr()
end

function UICommonLineMission:TimeStr()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowLessTime()
  end)
  self:ShowLessTime()
end

function UICommonLineMission:ShowLessTime()
  local endTime = self._line_component:GetComponentInfo().m_close_time
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  local strShow
  if endTime > nowTime then
    local sec = math.modf(endTime - nowTime)
    local timeStr = HelperProxy:GetInstance():FormatTime_3(sec, "#e5b663")
    local titleStr = "str_n22_activity_linemission_lasttime"
    strShow = StringTable.Get(titleStr) .. ":" .. timeStr
  else
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
      self._timer = nil
    end
    strShow = StringTable.Get("str_activity_finished")
  end
  self.timeStr:SetText(strShow)
end

function UICommonLineMission:FlushNodes()
  local cmpID = self._line_component:GetComponentCfgId()
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
  if next(self._line_info.m_pass_mission_info) then
    for missionID, passInfo in pairs(self._line_info.m_pass_mission_info) do
      if not showMission[missionID] then
        showMission[missionID] = missionCfgs[missionID]
        levelCount = levelCount + 1
      end
      if unlockInfo[missionID] then
        for id, cfg in pairs(unlockInfo[missionID]) do
          if not showMission[id] then
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
  self:_SetNodeAndLine(levelCount, lineCount, showMission)
  local right = -99999999
  for _, cfg in pairs(showMission) do
    right = math.max(right, cfg.MapPosX)
  end
  local width = math.abs(right + extra_width)
  width = math.max(self._safeAreaSize.x, width)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
  self:_SetLevelScroller(missionCfgs)
  self._allMissionCfgs = missionCfgs
end

function UICommonLineMission:_SetNodeAndLine(levelCount, lineCount, showMission)
  local nodes = UIWidgetHelper.SpawnObjects(self, "Nodes", "UICommonLineMissionMapNode", levelCount)
  local lines = UIWidgetHelper.SpawnObjects(self, "Lines", "UICommonLineMissionMapLine", lineCount)
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetData(cfg, self._line_info.m_pass_mission_info[missionID], function(stageId, isStory, worldPos)
      self:_OnNodeClick(stageId, isStory, worldPos)
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
end

function UICommonLineMission:_SetLevelScroller(missionCfgs)
  local posx = {}
  for _, cfg in pairs(missionCfgs) do
    posx[#posx + 1] = cfg.MapPosX
  end
  table.sort(posx)
  local sp1, sp2 = 18, 20
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._scroller = UILevelScroller:New(self._contentRect, bgLoader1, bgLoader2, {"n22_xxg_bg", "n22_xxg_bg"}, {
    posx[sp1],
    posx[sp1 + 1],
    posx[sp2]
  })
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
end

function UICommonLineMission:_OnNodeClick(stageId, isStory, worldPos)
  if self:CheckCampaignClose() then
    return
  end
  if isStory then
    self:_OnNodeClick_Story(stageId, worldPos)
  else
    self:_OnNodeClick_Battle(stageId, worldPos)
  end
end

function UICommonLineMission:_OnNodeClick_Story(stageId, worldPos)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local titleId = StringTable.Get(missionCfg.Title)
  local titleName = StringTable.Get(missionCfg.Name)
  local missionModule = self:GetModule(MissionModule)
  local storyId = missionModule:GetStoryByStageIdStoryType(stageId, StoryTriggerType.Node)
  if not storyId then
    Log.exception("配置错误,找不到剧情,关卡id:", stageId)
    return
  end
  self:ShowDialog("UIActivityPlotEnter", titleId, titleName, storyId, function()
    self:PlotEndCallback(stageId)
  end)
end

function UICommonLineMission:_OnNodeClick_Battle(stageId)
  local pos = self._allMissionCfgs[stageId].MapPosX
  local curPos = self._contentRect.anchoredPosition.x
  local areaWidth = 408
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
    local move_time = 0.5
    self._tweener = self._contentRect:DOAnchorPosX(targetPos, move_time)
    local moveLockName = "UIActivityLineMissionController_MoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, move_time * 1000, function()
      self:UnLock(moveLockName)
      self:_EnterStage(stageId)
    end)
  else
    self:_EnterStage(stageId)
  end
end

function UICommonLineMission:_EnterStage(stageId)
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, false, nil, nil, true, nil, nil, nil, nil, function()
    return self:CheckCampaignClose()
  end)
end

function UICommonLineMission:PlotEndCallback(stageId)
  if self:CheckCampaignClose() then
    return
  end
  if self._line_component:IsPassCamMissionID(stageId) then
    return
  end
  self:Lock("UICommonLineMission:PlotEndCallback")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._line_component:HandleCompleteStoryMission(TT, res, stageId)
    if not res:GetSucc() then
      self._campaign._campaign_module:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    else
      res = AsyncRequestRes:New()
      self._campaign:ReLoadCampaignInfo_Force(TT, res)
      self:_Refresh()
    end
  end, self)
  self:UnLock("UICommonLineMission:PlotEndCallback")
end

function UICommonLineMission:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end

function UICommonLineMission:OnActivityClose(id)
  if self._campaign and self._campaign._id == id then
    if self:Manager():CurUIStateType() == UIStateType.UICommonLineMission then
      self:SwitchState(UIStateType.UISideEnterCenter)
    else
      self:CloseDialog()
    end
  end
end

function UICommonLineMission:CheckCampaignClose()
  if not self._campaign:CheckCampaignOpen() then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    return true
  else
    return false
  end
end
