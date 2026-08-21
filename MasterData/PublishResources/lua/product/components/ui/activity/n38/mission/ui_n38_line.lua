_class("UIN38Line", UIController)
UIN38Line = UIN38Line

function UIN38Line:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
end

function UIN38Line:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_N9
  self._componentId_LineMission = ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION
  self._activityConst = UIN38Const:New()
  self._activityConst:LoadData(TT, res)
  self._campaign = self._activityConst:GetCampaign()
  self._campaignID = self._campaign._id
  if res and res:GetSucc() then
    self._line_component = self._campaign:GetComponent(self._componentId_LineMission)
    self._line_info = self._line_component:GetComponentInfo()
    if not self._campaign:CheckComponentOpen(self._componentId_LineMission) then
      res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId_LineMission)
      self._campModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIN38Line:OnShow(uiParams)
  local spine, bgm = self:GetSpineAndBgm()
  if bgm then
    AudioHelperController.PlayBGM(bgm, AudioConstValue.BGMCrossFadeTime)
  end
  self:InitWidget()
  self:InitCommonTopButton()
  self:_Refresh()
  local lockName = "UIN38Line.Enter"
  self:Lock(lockName)
  self._timerHolder = UITimerHolder:New()
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
  self._isOpen = true
  self:AttachEvents()
  UIN38Helper.SetFirstEnterTodayFlag("UIN38Helper_EnterTime_")
end

function UIN38Line:OnHide()
  self._isOpen = false
  self._timerHolder:Dispose()
  self._scroller:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  self:DetachEvents()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN26ActivityMainRedStatusRefresh)
  do return end
  UIN38Line.super:Dispose()
end

function UIN38Line:InitCommonTopButton()
  local function fnHelpTest()
  end
  
  fnHelpTest = nil
  self._backBtns = self._ltBtn:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:_Back()
  end, fnHelpTest, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, nil, false)
end

function UIN38Line:_Back()
  self._campModule:CampaignSwitchState(true, UIStateType.UIN38MainController, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN38Line:InitWidget()
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._txtRemainingTime = self:GetUIComponent("UILocalizationText", "remainingTime")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._atlas = self:GetAsset("UIN26Line.spriteatlas", LoadType.SpriteAtlas)
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._shot.width = self._safeAreaSize.x
  self._shot.height = self._safeAreaSize.y
end

function UIN38Line:OnUpdate()
  self:RefreshTime()
end

function UIN38Line:_Refresh()
  self:FlushNodes()
  self:_SetExchangeBtn()
  self:RefreshTime()
end

function UIN38Line:RefreshTime()
  local endTime = self._line_component:GetComponentInfo().m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if endTime <= curTime then
    self._txtRemainingTime:SetText(StringTable.Get("str_activity_common_notice_content"))
  else
    local str = self:GetFormatTimerStr(endTime - curTime, "FDFCFB")
    self._txtRemainingTime:SetText(StringTable.Get("str_activity_time_tips1", str))
  end
end

function UIN38Line:GetFormatTimerStr(time, txtColor)
  local id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  local timeStr
  if time <= 0 then
    return StringTable.Get(id.over)
  end
  if txtColor == nil then
    txtColor = "fb81cc"
  end
  local labelColor = string.format("<color=#%s>", txtColor)
  local day, hour, min, second = UIActivityHelper.Time2Str(time)
  if 0 < day and 0 < hour then
    timeStr = labelColor .. day .. "</color>" .. StringTable.Get(id.day) .. labelColor .. hour .. "</color>" .. StringTable.Get(id.hour)
  elseif 0 < day then
    timeStr = labelColor .. day .. "</color>" .. StringTable.Get(id.day)
  elseif 0 < hour and 0 < min then
    timeStr = labelColor .. hour .. "</color>" .. StringTable.Get(id.hour) .. labelColor .. min .. "</color>" .. StringTable.Get(id.min)
  elseif 0 < hour then
    timeStr = labelColor .. hour .. "</color>" .. StringTable.Get(id.hour)
  elseif 0 < min then
    timeStr = labelColor .. min .. "</color>" .. StringTable.Get(id.min)
  else
    timeStr = labelColor .. StringTable.Get(id.zero) .. "</color>"
  end
  return timeStr
end

function UIN38Line:_SetExchangeBtn()
  local componentId = ECampaignCN9ComponentID.ECAMPAIGN_N9_SHOP
  local obj = self:_SpawnObject("exchangeBtn", "UIActivityCommonComponentEnter")
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId) and self._campaign:CheckComponentRed(componentId)
  end)
  local component = self._campaign:GetComponent(componentId)
  local icon, count = component:GetCostItemIconText()
  if icon then
    obj:SetIcon("icon", icon)
  end
  obj:SetText("text", count)
  obj:SetText("txtNumbg", string.format("%.7d", count))
  obj:SetData(self._campaign, function()
    self._activityConst:ClearShopNew()
    ClientCampaignShop.OpenCampaignShop(self._campaign._type, self._campaign._id, function()
      local uiParams = {}
      uiParams[1] = self._activityConst
      self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIN38Line, UIStateType.UIMain, uiParams, self._campaign._id, componentId)
    end, self._activityConst)
  end)
  local lockTr = obj:GetUIComponent("RectTransform", "lock")
  lockTr.gameObject:SetActive(false)
end

function UIN38Line.GetItemCountStr(count, preColor, countColor)
  local dight = 0
  local tmpCount = count
  if tmpCount < 0 then
    tmpCount = -tmpCount
  end
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  if 0 <= count then
    for i = 1, 7 - dight do
      pre = pre .. "0"
    end
  else
    for i = 1, 7 - dight - 1 do
      pre = pre .. "0"
    end
  end
  if 0 < count then
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  elseif count == 0 then
    return string.format("<color=" .. preColor .. ">%s</color>", pre)
  else
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  end
end

function UIN38Line:FlushNodes()
  local cmpID = self._line_component:GetComponentCfgId()
  local extra_cfg = Cfg.cfg_component_line_mission_extra({ComponentID = cmpID})
  local extra_width = 600
  if extra_cfg then
    extra_width = extra_cfg[1].MarginRight
  end
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
  local pass_mission_info = self._line_info.m_pass_mission_info
  local showMission = {}
  local levelCount, lineCount = 0, 0
  if next(pass_mission_info) then
    for missionID, passInfo in pairs(pass_mission_info) do
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
  self._nodesPool:SpawnObjects("UIN38LineMapNode", levelCount)
  self._linesPool:SpawnObjects("UIN38LineMapLine", lineCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  local lines = self._linesPool:GetAllSpawnList()
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetAtlas(self._atlas)
    uiNode:SetData(cfg, self._line_info.m_pass_mission_info[missionID], function(stageId, isStory, worldPos)
      self:OnNodeClick(stageId, isStory, worldPos)
    end)
    nodeIdx = nodeIdx + 1
    if cfg.WayPointType ~= 4 and cfg.NeedMissionId ~= 0 then
      local n1 = showMission[cfg.NeedMissionId]
      local n2 = cfg
      local line = lines[lineIdx]
      line:SetAtlas(self._atlas)
      line:Flush(Vector2(n2.MapPosX, n2.MapPosY), Vector2(n1.MapPosX, n1.MapPosY))
      lineIdx = lineIdx + 1
    end
  end
  local right = -1111111111111111
  for _, cfg in pairs(showMission) do
    right = math.max(right, cfg.MapPosX)
  end
  local width = math.abs(right + extra_width)
  width = math.max(self._safeAreaSize.x, width)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
  local posx = {}
  for _, cfg in pairs(missionCfgs) do
    posx[#posx + 1] = cfg.MapPosX
  end
  table.sort(posx)
  local sp1, sp2 = 5, 9
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._scroller = UILevelScroller:New(self._contentRect, bgLoader1, bgLoader2, {
    "n26_xxg_bg01",
    "n26_xxg_bg03"
  }, {
    posx[sp1],
    posx[sp2],
    posx[sp2 + 1]
  })
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
  self._allMissionCfgs = missionCfgs
end

function UIN38Line:OnNodeClick(stageId, isStory, worldPos)
  if self:_CheckClose() then
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
    local moveTime = 0.5
    self._tweener = self._contentRect:DOAnchorPosX(targetPos, moveTime)
    local moveLockName = "UIN38Line.MoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, moveTime * 1000, function()
      self:UnLock(moveLockName)
      self:_EnterStage(stageId, worldPos)
    end)
  else
    self:_EnterStage(stageId, worldPos)
  end
end

function UIN38Line:_EnterStage(stageId, worldPos)
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._shot:CleanRenderTexture()
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, stageId)
  local pointComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, 1)
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, autoFightShow, pointComponent, true, true)
end

function UIN38Line:PlotEndCallback(stageId)
  local isActive = self._line_component:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self:StartTask(function(TT)
    self._line_component:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self._line_component:HandleCompleteStoryMission(TT, res, stageId)
    if not res:GetSucc() then
      self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    elseif table.count(award) ~= 0 then
      self:ShowDialog("UIGetItemController", award, function()
        self:SwitchState(UIStateType.UIN38Line, self._activityConst)
      end)
    else
      self:SwitchState(UIStateType.UIN38Line, self._activityConst)
    end
  end, self)
end

function UIN38Line:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIN38Line:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIN38Line:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIN38Line:DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIN38Line:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN38Line:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end

function UIN38Line:AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_CheckClose()
  end
  self:_SetExchangeBtn()
end

function UIN38Line:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN38Line:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIN38Line:_SetText(widgetName, str)
  widgetName = widgetName or "text"
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(str)
end

function UIN38Line:GetSpineAndBgm()
  return nil, nil
end

function UIN38Line:_CheckClose()
  if not self._campaign:CheckComponentOpen(self._componentId_LineMission) then
    local result = self._campaign:CheckComponentOpenClientError(self._componentId_LineMission)
    self._campModule:ShowErrorToast(result, true)
    self:_Back()
    return true
  end
  return false
end
