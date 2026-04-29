_class("UIN39LineMissionController", UIController)
UIN39LineMissionController = UIN39LineMissionController

function UIN39LineMissionController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIN39TimeLine")
  obj:SetData(endTime)
end

function UIN39LineMissionController:_Back()
  if self._screenShot and false then
    self._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local rt = self._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CampaignSwitchState(true, UIStateType.UIN39MainController, UIStateType.UIMain, {false, cache_rt}, self._campaign._id)
    end)
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN39MainController, UIStateType.UIMain, {false}, self._campaign._id)
  end
end

function UIN39LineMissionController:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:_Back()
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._screenShot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
end

function UIN39LineMissionController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N39
  self._componentId_LineMission = ECampaignN39ComponentID.ECAMPAIGN_N39_LINE_MISSION
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId_LineMission)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  if res and res:GetSucc() then
    self._line_component = self._campaign:GetComponent(self._componentId_LineMission)
    self._line_info = self._line_component:GetComponentInfo()
    if not self._campaign:CheckComponentOpen(self._componentId_LineMission) then
      res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId_LineMission) or res.m_result
      self._campaign:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    self._campaign._campaign_module:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIN39LineMissionController:OnShow(uiParams)
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  self:AttachEvents()
  self:InitWidget()
  self:_Refresh()
  local lockName = "UIN39LineMissionController_OnShow"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 667, function()
    self:UnLock(lockName)
  end)
  UIN39Helper.SetComRedTime("line")
  UIN39Helper.ClearNew("line")
end

function UIN39LineMissionController:OnHide()
  self._isOpen = false
  self._timerHolder:Dispose()
  UIN39LineMissionController.super:Dispose()
  if self._scroller then
    self._scroller:Dispose()
  end
end

function UIN39LineMissionController:_Refresh()
  self:_SetExchangeBtn()
  self:FlushNodes()
  local endTime = self._line_component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_time", "str_n39_line_remain_time", endTime)
end

function UIN39LineMissionController:_SetExchangeBtn()
  local cmptId, component, componentInfo = UIN39Helper.GetComponent(self._campaign, "exchange")
  local obj = UIWidgetHelper.SpawnObject(self, "_exchangeBtn", "UIN39MainBtnExchange")
  obj:SetLockStateCallback(function(timeStr)
    ToastManager.ShowToast(StringTable.Get("str_n39_main_btn_unlock_time", "", timeStr, ""))
  end, function(missionName)
    ToastManager.ShowToast(StringTable.Get("str_n39_hard_level_lock_tips", missionName))
  end, function()
    ToastManager.ShowToast(StringTable.Get("str_n39_sample_end"))
  end, function()
    if UIN39Helper.CheckCampaignOpen(self._campaign) then
      self:ShowDialog("UIN39ExchangeController", true)
    end
  end, function(tagName)
    local new = UIN39Helper.CheckNew("exchange")
    return new
  end, function(tagName)
    return component:HaveRedPoint()
  end)
  obj:SetHideActive(true)
  obj:SetData("exchange", self._campaign:GetComponent(UIN39Helper.GetComponentId("exchange")), self._campaign)
end

function UIN39LineMissionController:FlushNodes()
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

function UIN39LineMissionController:_SetNodeAndLine(levelCount, lineCount, showMission)
  local nodes = UIWidgetHelper.SpawnObjects(self, "Nodes", "UIN39LineMissionMapNode", levelCount)
  local lines = UIWidgetHelper.SpawnObjects(self, "Lines", "UIN39LineMissionMapLine", lineCount)
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

function UIN39LineMissionController:_SetLevelScroller(missionCfgs)
end

function UIN39LineMissionController:_OnNodeClick(stageId, isStory, worldPos)
  if isStory then
    self:_OnNodeClick_Story(stageId, worldPos)
  else
    self:_OnNodeClick_Battle(stageId, worldPos)
  end
end

function UIN39LineMissionController:_OnNodeClick_Story(stageId, worldPos)
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

function UIN39LineMissionController:_OnNodeClick_Battle(stageId, worldPos)
  local pos = self._allMissionCfgs[stageId].MapPosX
  local curPos = self._contentRect.anchoredPosition.x
  local areaWidth = 408
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
    local move_time = 0.5
    self._tweener = self._contentRect:DOAnchorPosX(targetPos, move_time)
    local moveLockName = "UIActivityLineMissionController_MoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, move_time * 1000, function()
      self:UnLock(moveLockName)
      self:_EnterStage(stageId, worldPos)
    end)
  else
    self:_EnterStage(stageId, worldPos)
  end
end

function UIN39LineMissionController:_EnterStage(stageId, worldPos)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, stageId)
  local pointComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, 1)
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, autoFightShow, pointComponent, true, true)
end

function UIN39LineMissionController:_CheckSerialAutoFightShow(stageType, stageId)
  local autoFightShow = false
  if stageType == DiscoveryStageType.Plot then
    autoFightShow = false
  else
    local missionCfg = Cfg.cfg_campaign_mission[stageId]
    if missionCfg then
      local enableParam = missionCfg.EnableSerialAutoFight
      local tb = {
        [CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE] = false,
        [CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE] = true,
        [CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK] = true
      }
      autoFightShow = tb[enableParam]
    end
  end
  return autoFightShow
end

function UIN39LineMissionController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIN39LineMissionController:PlotEndCallback(stageId)
  local isActive = self._line_component:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self:StartTask(function(TT)
    self._line_component:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self._line_component:HandleCompleteStoryMission(TT, res, stageId)
    if not res:GetSucc() then
      self._campaign._campaign_module:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    elseif table.count(award) ~= 0 then
      self:ShowDialog("UIGetItemController", award, function()
        self:SwitchState(UIStateType.UIN39LineMissionController)
      end)
    else
      self:SwitchState(UIStateType.UIN39LineMissionController)
    end
  end, self)
end

function UIN39LineMissionController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UIN39LineMissionController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN39LineMissionController:_OnComponentClose(componentCfgId)
  local component = self._line_component
  if component and component:GetComponentCfgId() == componentCfgId then
    self:_Back()
  end
end

function UIN39LineMissionController:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end

function UIN39LineMissionController:_OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_SetExchangeBtn()
  end
end
