_class("UICN12N41LineController", UIController)
UICN12N41LineController = UICN12N41LineController

function UICN12N41LineController:Constructor()
  self._isReview = false
end

function UICN12N41LineController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UICN12N41LineController:InitWidget()
  local function closeCallback()
    self:_Back()
  end
  
  local backBtns = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  backBtns:SetData(closeCallback)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
end

function UICN12N41LineController:_Back()
  local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UICN12N41MainController, nil)
  local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
end

function UICN12N41LineController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = UICN12N41Helper.GetCampaignType(self._isReview)
  self._componentId_LineMission = UICN12N41Helper.GetComponentId("line", self._isReview)
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId_LineMission
  })
  local fRes = AsyncRequestRes:New()
  self._campaign:ReLoadCampaignInfo_Force(TT, fRes)
end

function UICN12N41LineController:OnShow(uiParams)
  self:_SetDebug()
  self._line_component = self._campaign:GetComponent(self._componentId_LineMission)
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
end

function UICN12N41LineController:OnHide()
  self:DetachEvents()
  self._isOpen = false
  self._timerHolder:Dispose()
end

function UICN12N41LineController:_Refresh()
  self:FlushNodes()
  if not self._isReview then
    local endTime = self._line_component:GetComponentInfo().m_close_time
    self:_SetRemainingTime("_time", "str_cn12_n41_remain_time_in_activity", endTime)
  end
  if not self._isReview then
    UICN12N41Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign)
  end
end

function UICN12N41LineController:FlushNodes()
  local missionCfgs = UIActivityLineMissionHelper.GetMissionCfgs(self._line_component)
  local levelCount, lineCount, showMission = UIActivityLineMissionHelper.GetNodeLineInfo(self._line_component, missionCfgs)
  self:_SetNodeAndLine(levelCount, lineCount, showMission)
  self:_SetContentSize(showMission)
  self:_SetMainBg(showMission, missionCfgs)
  self._allMissionCfgs = missionCfgs
end

function UICN12N41LineController:_SetNodeAndLine(levelCount, lineCount, showMission)
  local nodes = UIWidgetHelper.SpawnObjects(self, "Nodes", "UICN12N41LineMapNode", levelCount)
  local lines = UIWidgetHelper.SpawnObjects(self, "Lines", "UICN12N41LineMapLine", lineCount)
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

function UICN12N41LineController:_SetContentSize(showMission)
  local width = UIActivityLineMissionHelper.CalcContentWidth(self._line_component, showMission, self._safeAreaSize.x)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
end

function UICN12N41LineController:_SetMainBg(showMission, missionCfgs)
  self:GetGameObject("bg1"):SetActive(false)
  self:GetGameObject("bg2"):SetActive(true)
  local width = UIActivityLineMissionHelper.CalcContentWidth(self._line_component, showMission, self._safeAreaSize.x)
  width = math.max(self._safeAreaSize.x, width)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
  local posx = {}
  for _, cfg in pairs(missionCfgs) do
    posx[#posx + 1] = cfg.MapPosX
  end
  table.sort(posx)
  local sp1, sp2 = 7, 13
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._scroller = UILevelScroller:New(self._contentRect, bgLoader1, bgLoader2, {
    "n41_xxg_bg01",
    "n41_xxg_bg02",
    "n41_xxg_bg03"
  }, {
    posx[sp1],
    posx[sp1 + 1],
    posx[sp2],
    posx[sp2 + 1]
  })
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
end

function UICN12N41LineController:_OnNodeClick(stageId, isStory)
  if isStory then
    UIActivityLineMissionHelper.EnterStage_Story(self._campaign, self._line_component, stageId, function()
      self:SwitchState(UIStateType.UICN12N41LineController)
    end)
  else
    self:_PlayContentMoveEff(stageId, function()
      UIActivityLineMissionHelper.EnterStage_Battle(self._campaign, self._line_component, stageId, true)
    end)
  end
end

function UICN12N41LineController:_PlayContentMoveEff(stageId, callback)
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

function UICN12N41LineController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN12N41LineController:DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN12N41LineController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN12N41LineController:_OnComponentClose(componentCfgId)
  local component = self._line_component
  if component and component:GetComponentCfgId() == componentCfgId then
    self:_Back()
  end
end

function UICN12N41LineController:_OnItemChanged(id)
  self:_Refresh()
end

function UICN12N41LineController:_SetDebug()
  local show = UIActivityHelper.CheckDebugOpen()
  self:GetGameObject("_debug"):SetActive(show)
end

function UICN12N41LineController:DebugBtnOnClick(go)
  UIActivityLineMissionHelper.PassLineCampMission(self._line_component, function()
    self:_Refresh()
  end)
end
