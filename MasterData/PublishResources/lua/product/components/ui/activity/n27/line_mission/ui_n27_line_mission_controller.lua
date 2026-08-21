_class("UIN27LineMissionController", UIController)
UIN27LineMissionController = UIN27LineMissionController

function UIN27LineMissionController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIN27LineMissionController:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseWithAnim()
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self.PetTryRed = self:GetGameObject("PetTryRed")
  self.PoolRed = self:GetGameObject("PoolRed")
  self.timeStr = self:GetUIComponent("RollingText", "timeStr")
  self.PoolLockGo = self:GetGameObject("poolLock")
  self.PoolTimerTex2 = self:GetUIComponent("UILocalizationText", "PoolTimerTex2")
  self.PoolTimerTex = self:GetUIComponent("UILocalizationText", "PoolTimerTex")
  self.PoolItemGo = self:GetGameObject("item")
  self.PoolLockTexGo = self:GetGameObject("lockTex")
  self.itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self.itemCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.itemCount2 = self:GetUIComponent("UILocalizationText", "itemCount2")
  self.uiAnim = self:GetUIComponent("Animation", "UIN27LineMissionController")
end

function UIN27LineMissionController:CloseWithAnim()
  CutsceneManager.ExcuteCutsceneIn_Shot()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:CampaignSwitchState(true, UIStateType.UIN27Controller, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN27LineMissionController:OpenWithAnim()
  self:Lock("UIN27LineMissionController:OpenWithAnim")
  self.uiAnim:Play("uieff_UIN27LineMissionController_in")
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
  end
  self.animEvent = GameGlobal.Timer():AddEvent(433, function()
    self:UnLock("UIN27LineMissionController:OpenWithAnim")
  end)
end

function UIN27LineMissionController:PoolBtnOnClick(go)
  if self.poolLock == N27ComponetStatus.NotStart then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.poolLock == N27ComponetStatus.OverTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  elseif self.poolLock == N27ComponetStatus.Lock then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.poolLock == N27ComponetStatus.Other then
    Log.fatal("###[UIN27Controller] PoolBtnOnClick lock --> other !")
  else
    self:ShowDialog("UIN27LotteryMain")
  end
end

function UIN27LineMissionController:PetTryBtnOnClick(go)
  local component = self._campaign:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET)
  local endTime = component.m_close_time
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  self._petTryLock = endTime < nowTime
  if self._petTryLock then
    local tips = StringTable.Get("str_activity_common_notice_content")
    ToastManager.ShowToast(tips)
    return
  end
  self:ShowDialog("UIActivityPetTryController", ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET, function(mid)
    local component = self._campaign:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET)
    return component:IsPassCamMissionID(mid)
  end, function(missionid)
    local ctx = self._missionModule:TeamCtx()
    local missionComponent = self._campaign:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET)
    local param = {
      missionid,
      missionComponent:GetCampaignMissionComponentId(),
      missionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end

function UIN27LineMissionController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N27
  self._componentId_LineMission = ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION
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
      CutsceneManager.ExcuteCutsceneOut_Shot()
      return
    end
  end
  if res and not res:GetSucc() then
    self._campaign._campaign_module:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    CutsceneManager.ExcuteCutsceneOut_Shot()
  end
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY)
  self._costItemID = self._lotteryComponentInfo.m_cost_item_id
end

function UIN27LineMissionController:ItemCount()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local count = itemModule:GetItemCount(self._costItemID)
  self.itemCount:SetText(UIN27Controller.GetItemCountStr(count, "#bcd4f3", "#ffffff"))
  self.itemCount2:SetText(UIN27Controller.GetItemCountStr(count, "#193352", "#193352"))
  local cfg = Cfg.cfg_item[self._costItemID]
  if not cfg then
    Log.error("###[UIN27Controller] cfg is nil ! id --> ", self._costItemID)
  end
  self.itemIcon:LoadImage(cfg.Icon)
end

function UIN27LineMissionController:OnShow(uiParams)
  self._missionModule = GameGlobal.GetModule(MissionModule)
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  self:AttachEvents()
  self:InitWidget()
  self:_Refresh()
  local hideAnim = uiParams[1]
  if not hideAnim then
    self:OpenWithAnim()
  end
  CutsceneManager.ExcuteCutsceneOut_Shot()
  local lockName = "UIN27LineMissionController_OnShow"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
end

function UIN27LineMissionController:CheckBtnLock()
  self:PoolLock()
end

function UIN27LineMissionController:PoolLock()
  self.poolLock = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY)
  self.PoolLockGo:SetActive(self.poolLock ~= N27ComponetStatus.Open)
  self.PoolItemGo:SetActive(self.poolLock ~= N27ComponetStatus.OverTime)
  self.PoolLockTexGo:SetActive(self.poolLock == N27ComponetStatus.OverTime)
  if self.poolLock == N27ComponetStatus.OverTime then
    local tex = "str_n27_main_component_over_time"
    self.PoolTimerTex:SetText(StringTable.Get(tex))
    self.PoolTimerTex2:SetText(StringTable.Get(tex))
  end
end

function UIN27LineMissionController:OnHide()
  self._isOpen = false
  self._timerHolder:Dispose()
  UIN27LineMissionController.super:Dispose()
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

function UIN27LineMissionController:CheckComponentLock(componentid)
  local component = self._campaign:GetComponent(componentid)
  if not component then
    Log.error("###[UIN27Controller] UIN27Controller:CheckComponentLock component == nil,componentid=", componentid)
    return N27ComponetStatus.Other
  end
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local unlockTime = component:ComponentUnLockTime()
  local stamp = unlockTime - curTime
  if component:ComponentIsClose() then
    return N27ComponetStatus.OverTime
  elseif 0 < stamp then
    return N27ComponetStatus.NotStart, unlockTime
  elseif not component:ComponentIsUnLock() then
    local missionid = component:GetComponentInfo().m_need_mission_id
    return N27ComponetStatus.Lock, missionid
  else
    local cInfo = self._campaign:GetComponentInfo(componentid)
    local closeTime = cInfo.m_close_time
    return N27ComponetStatus.Open, closeTime
  end
end

function UIN27LineMissionController:_Refresh()
  self:FlushNodes()
  self:ItemCount()
  self:TimeStr()
  self:CheckBtnLock()
  local redTry = self:_CheckRedPoint(self.PetTryRed, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET)
  self.PetTryRed:SetActive(redTry)
  local redPool = self:_CheckRedPoint(self.PoolRed, ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY)
  self.PoolRed:SetActive(redPool)
end

function UIN27LineMissionController:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  return bShow
end

function UIN27LineMissionController:TimeStr()
  self.svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowLessTime()
  end)
  self:ShowLessTime()
end

function UIN27LineMissionController:ShowLessTime()
  local endTime = self._line_component:GetComponentInfo().m_close_time
  local nowTime = self.svrTimeModule:GetServerTime() * 0.001
  if endTime > nowTime then
    local sec = math.modf(endTime - nowTime)
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    self.timeStr:RefreshText(StringTable.Get("str_n27_line_mission_remainingtime", timeStr))
  elseif self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UIN27LineMissionController:FlushNodes()
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

function UIN27LineMissionController:_SetNodeAndLine(levelCount, lineCount, showMission)
  local nodes = UIWidgetHelper.SpawnObjects(self, "Nodes", "UIN27LineMissionMapNode", levelCount)
  local lines = UIWidgetHelper.SpawnObjects(self, "Lines", "UIN27LineMissionMapLine", lineCount)
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

function UIN27LineMissionController:_SetLevelScroller(missionCfgs)
  local posx = {}
  for _, cfg in pairs(missionCfgs) do
    posx[#posx + 1] = cfg.MapPosX
  end
  table.sort(posx)
  local sp1, sp2 = 8, 12
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._scroller = UILevelScroller:New(self._contentRect, bgLoader1, bgLoader2, {
    "n27_xxg_bg01",
    "n27_xxg_bg02",
    "n27_xxg_bg03"
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

function UIN27LineMissionController:_OnNodeClick(stageId, isStory, worldPos)
  if isStory then
    self:_OnNodeClick_Story(stageId, worldPos)
  else
    self:_OnNodeClick_Battle(stageId, worldPos)
  end
end

function UIN27LineMissionController:_OnNodeClick_Story(stageId, worldPos)
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

function UIN27LineMissionController:_OnNodeClick_Battle(stageId, worldPos)
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

function UIN27LineMissionController:_EnterStage(stageId, worldPos)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, stageId)
  local pointComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, 1)
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, autoFightShow, pointComponent)
end

function UIN27LineMissionController:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIN27LineMissionController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIN27LineMissionController:PlotEndCallback(stageId)
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
        self:SwitchState(UIStateType.UIN27LineMissionController, true)
      end)
    else
      self:SwitchState(UIStateType.UIN27LineMissionController, true)
    end
  end, self)
end

function UIN27LineMissionController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIN27LineMissionController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN27LineMissionController:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end
