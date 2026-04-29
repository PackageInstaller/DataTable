_class("UICN17N46LineController", UIController)
UICN17N46LineController = UICN17N46LineController

function UICN17N46LineController:Constructor()
  self._isReview = false
end

function UICN17N46LineController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UICN17N46LineController:InitWidget()
  local function closeCallback()
    self:_Back()
  end
  
  local backBtns = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  backBtns:SetData(closeCallback)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._tStarNum = self:GetUIComponent("UILocalizationText", "tStarNum")
  self._tStarRed = self:GetGameObject("tStarRed")
end

function UICN17N46LineController:SetTStar()
  local missionCfgs = UIActivityLineMissionHelper.GetMissionCfgs(self._line_component)
  local all = 0
  local now = 0
  for k, v in pairs(missionCfgs) do
    local missionCfg = Cfg.cfg_campaign_mission[k]
    if missionCfg.Type == DiscoveryStageType.Plot then
    else
      all = all + 3
      if self._line_component:GetComponentInfo().m_pass_mission_info[k] then
        now = now + 3
      end
    end
  end
  local red = self._quest_component:HaveRedPoint()
  self._tStarRed:SetActive(red)
  self._tStarNum:SetText(now .. "/" .. all)
end

function UICN17N46LineController:_Back()
  local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UICN17N46MainController, nil)
  local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
end

function UICN17N46LineController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = UICN17N46Helper.GetCampaignType(self._isReview)
  self._componentId_LineMission = UICN17N46Helper.GetComponentId("line", self._isReview)
  self._componentId_Quest = UICN17N46Helper.GetComponentId("quest", self._isReview)
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId_LineMission
  })
  local fRes = AsyncRequestRes:New()
  self._campaign:ReLoadCampaignInfo_Force(TT, fRes)
end

function UICN17N46LineController:OnShow(uiParams)
  self._line_component = self._campaign:GetComponent(self._componentId_LineMission)
  self._quest_component = self._campaign:GetComponent(self._componentId_Quest)
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  self:AttachEvents()
  self:InitWidget()
  self:_Refresh()
  local lockName = "UILineMissionController_OnShow"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
  self.overFirstTime = true
end

function UICN17N46LineController:OnHide()
  self:DetachEvents()
  self._isOpen = false
  self._timerHolder:Dispose()
end

function UICN17N46LineController:_Refresh()
  self:FlushNodes()
  if not self._isReview then
    local endTime = self._line_component:GetComponentInfo().m_close_time
    self:_SetRemainingTime("_time", "str_cn17_n46_btn_time_2", endTime)
  end
  if not self._isReview then
    UICN17N46Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign, not self.overFirstTime)
  end
end

function UICN17N46LineController:TStarBtnOnClick(go)
  self:ShowDialog("UICommonLineMissionAwards", self._quest_component)
end

function UICN17N46LineController:FlushNodes()
  local missionCfgs = UIActivityLineMissionHelper.GetMissionCfgs(self._line_component)
  local levelCount, lineCount, showMission = UIActivityLineMissionHelper.GetNodeLineInfo(self._line_component, missionCfgs)
  self:_SetNodeAndLine(levelCount, lineCount, showMission)
  self:_SetContentSize(showMission)
  self:_SetMainBg(showMission, missionCfgs)
  self._allMissionCfgs = missionCfgs
end

function UICN17N46LineController:_SetNodeAndLine(levelCount, lineCount, showMission)
  local nodes = UIWidgetHelper.SpawnObjects(self, "Nodes", "UICN17N46LineMapNode", levelCount)
  local lines = UIWidgetHelper.SpawnObjects(self, "Lines", "UICN17N46LineMapLine", lineCount)
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetData(cfg, self._line_component:GetComponentInfo().m_pass_mission_info[missionID], function(stageId, isStory)
      self:_OnNodeClick(stageId, isStory)
    end)
    nodeIdx = nodeIdx + 1
    if cfg.WayPointType ~= 4 and cfg.NeedMissionId ~= 0 then
      local from = showMission[cfg.NeedMissionId]
      local to = cfg
      local line = lines[lineIdx]
      line:Flush(Vector2(from.MapPosX, from.MapPosY), Vector2(to.MapPosX, to.MapPosY))
      lineIdx = lineIdx + 1
    end
  end
end

function UICN17N46LineController:_SetContentSize(showMission)
  local width = UIActivityLineMissionHelper.CalcContentWidth(self._line_component, showMission, self._safeAreaSize.x)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
end

function UICN17N46LineController:_SetMainBg(showMission, missionCfgs)
  local width = UIActivityLineMissionHelper.CalcContentWidth(self._line_component, showMission, self._safeAreaSize.x)
  width = math.max(self._safeAreaSize.x, width)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
end

function UICN17N46LineController:_OnNodeClick(stageId, isStory)
  if isStory then
    UIActivityLineMissionHelper.EnterStage_Story(self._campaign, self._line_component, stageId, function()
      self:SwitchState(UIStateType.UICN17N46LineController)
    end)
  else
    self:_PlayContentMoveEff(stageId, function()
      UIActivityLineMissionHelper.EnterStage_Battle(self._campaign, self._line_component, stageId, true)
    end)
  end
end

function UICN17N46LineController:_PlayContentMoveEff(stageId, callback)
  local pos = self._allMissionCfgs[stageId].MapPosX
  local curPos = self._contentRect.anchoredPosition.x
  local areaWidth = 327
  local halfScreen = self._safeAreaSize.x / 2
  local targetPos
  local left, right = -curPos + areaWidth + 10, -curPos + self._safeAreaSize.x - areaWidth + 310
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
      callback()
    end)
  else
    callback()
  end
end

function UICN17N46LineController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UICN17N46LineController:DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN17N46LineController:_AfterUILayerChanged()
  if not self._isReview then
    UICN17N46Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign)
  end
end

function UICN17N46LineController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN17N46LineController:_OnComponentClose(componentCfgId)
  local component = self._line_component
  if component and component:GetComponentCfgId() == componentCfgId then
    self:_Back()
  end
end

function UICN17N46LineController:_OnItemChanged(id)
  self:_Refresh()
end
