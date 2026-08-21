_class("UIN34DispatchMain", UIController)
UIN34DispatchMain = UIN34DispatchMain

function UIN34DispatchMain:Constructor()
  self._cdStatus = {tick = 0, period = 30000}
  self._cdReward = {
    tick = 0,
    period = math.maxinteger
  }
  self._cdDispatchLog = {
    tick = 0,
    period = math.maxinteger,
    idPopup = 0
  }
  self._cdHideLog = {
    tick = 0,
    period = math.maxinteger
  }
end

function UIN34DispatchMain:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N34, ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._dispatchComponent = self._localProcess:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH)
  self._localDb = UIN34DispatchLocalDb:New()
  self._localDb:ViewedLoadDB()
  self._missionAllOver = false
  self._atlasDispatch = self:GetAsset("UIN34Dispatch.spriteatlas", LoadType.SpriteAtlas)
  self:PlayEnterStory()
end

function UIN34DispatchMain:PlayEnterStory()
  local playStoryKey = "N34UIN34DispatchMain_STORY"
  local pstid = GameGlobal.GetModule(RoleModule):GetPstId()
  local key = playStoryKey .. pstid
  local val = LocalDB.GetInt(key, 0)
  if val == 0 then
    local storyId = self._dispatchComponent:GetComponentInfo().m_first_story_id
    self:ShowDialog("UIStoryController", storyId, function()
      LocalDB.SetInt(key, 1)
    end)
  end
end

function UIN34DispatchMain:OnShow(uiParams)
  self:AddEvents()
  self:UIWidget()
  self:InitCommonTopButton()
  self:CreateMission()
  self:EnterFullScreenBg(false)
  self:ShowDispatchLog(false, false, nil)
  self:BreakPosition()
  self:FlushMission()
  self:FlushSelection()
  self:FlushQPlayer()
  self:FlushWuEffect()
  self:FlushDispatch()
  self:FlushAllOver()
  self:InAnimation()
end

function UIN34DispatchMain:OnHide()
end

function UIN34DispatchMain:OnUpdate(deltaTimeMS)
  self._cdStatus.tick = self._cdStatus.tick + deltaTimeMS
  if self._cdStatus.tick >= self._cdStatus.period then
    self._cdStatus.tick = 0
    self:FlushDispatch()
  end
  self._cdReward.tick = self._cdReward.tick + deltaTimeMS
  if self._cdReward.tick >= self._cdReward.period then
    local uiTerminal = "UIN34DispatchTerminalMainControlller"
    local uiStateManager = GameGlobal.UIStateManager()
    if not uiStateManager:IsShow(uiTerminal) then
      self._cdReward.tick = 0
      self._cdReward.period = math.maxinteger
      local lockName = "UIN34DispatchMain:GetRewardsTask"
      self:StartSafeTask(lockName, self.GetRewardsTask, self, self._requestLock)
    end
  end
  self._cdDispatchLog.tick = self._cdDispatchLog.tick + deltaTimeMS
  if self._cdDispatchLog.tick >= self._cdDispatchLog.period and self._cdHideLog.period == math.maxinteger then
    local idPopup = self._cdDispatchLog.idPopup
    local cfgPopup = Cfg.cfg_mission_dispatch_log[idPopup]
    self:ShowDispatchLog(true, true, StringTable.Get(cfgPopup.ChatId))
    self:StartHideLogTimer(cfgPopup.DisplayPeriod * 1000)
    self:StartDispatchLogTimer()
  end
  self._cdHideLog.tick = self._cdHideLog.tick + deltaTimeMS
  if self._cdHideLog.tick >= self._cdHideLog.period then
    self._cdHideLog.tick = 0
    self._cdHideLog.period = math.maxinteger
    self:ShowDispatchLog(false, true, nil)
  end
end

function UIN34DispatchMain:OnActivityCloseEvent(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN34DispatchMain:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
end

function UIN34DispatchMain:BtnAnywhereOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIN34DispatchMain:BtnPlotReviewOnClick(go)
  local storyId = self._dispatchComponent:GetComponentInfo().m_first_story_id
  self:ShowDialog("UIStoryController", storyId, function()
  end)
end

function UIN34DispatchMain:BtnCommunicationOnClick(go)
  if not self:InActivityTime() then
    self._campaign:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED, nil, nil)
    return
  end
  self:ShowDialog("UIN34DispatchTerminalMainControlller")
end

function UIN34DispatchMain:BtnDispatchOnClick(go)
  if self._missionAllOver then
    ToastManager.ShowToast(StringTable.Get("str_n34_dispatch_all_over_tips"))
    return
  elseif not self._currentNode.selected then
    ToastManager.ShowToast(StringTable.Get("str_n34_dispatch_need_selected_tips"))
    return
  end
  local lockName = "UIN34DispatchMain:DispatchTask"
  self:StartSafeTask(lockName, self.DispatchTask, self)
end

function UIN34DispatchMain:NodeOnClick(nodeWidget)
  if self._currentNode.nodeWidget ~= nodeWidget then
    local archId = nodeWidget:ID()
    local clickNode = self._dicMissions[archId]
    if clickNode.archInfo == nil then
      ToastManager.ShowToast(StringTable.Get("str_n34_dispatch_selected_locked_tips"))
    else
      ToastManager.ShowToast(StringTable.Get("str_n34_dispatch_selected_completed_tips"))
    end
    return
  end
  if self._currentNode.archInfo ~= nil then
    if self._currentNode.archInfo.status == ComDispatchStatus.DISPATCHING then
      ToastManager.ShowToast(StringTable.Get("str_n34_dispatch_selected_progress_tips"))
    elseif self._currentNode.archInfo.status == ComDispatchStatus.COMPLETE then
      ToastManager.ShowToast(StringTable.Get("str_n34_dispatch_selected_completed_tips"))
    end
  else
    for k, v in pairs(self._dicMissions) do
      if v.nodeWidget == nodeWidget then
        v.selected = not v.selected
      else
        v.selected = false
      end
    end
    self:FlushSelection()
  end
end

function UIN34DispatchMain:StartRewardTimer()
  local endTime = self._currentNode.archInfo.end_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = svrTimeModule:GetServerTime()
  self._cdReward.tick = 0
  self._cdReward.period = endTime * 1000 - curTime
  self._cdReward.period = self._cdReward.period + 1000
end

function UIN34DispatchMain:StartDispatchLogTimer()
  local archInfo = self._currentNode.archInfo
  local allCfg = Cfg.cfg_mission_dispatch_log({
    BuildingId = archInfo.arch_id
  })
  local sortList = {}
  if allCfg ~= nil then
    for k, v in pairs(allCfg) do
      table.insert(sortList, v)
    end
  end
  table.sort(sortList, function(a, b)
    return a.DispatchTime < b.DispatchTime
  end)
  local endTime = self._currentNode.archInfo.end_time
  local dispatchPeriod = self._currentNode.cfgMission.DispatchTime
  local startTime = endTime - dispatchPeriod
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local cfgPopup
  local cdPeriod = 0
  for k, v in pairs(sortList) do
    if curTime < startTime + v.DispatchTime then
      cfgPopup = v
      cdPeriod = startTime + v.DispatchTime - curTime
      cdPeriod = cdPeriod * 1000 + 1000
      break
    end
  end
  if cfgPopup ~= nil then
    self._cdDispatchLog.tick = 0
    self._cdDispatchLog.period = cdPeriod
    self._cdDispatchLog.idPopup = cfgPopup.ID
  else
    self._cdDispatchLog.tick = 0
    self._cdDispatchLog.period = math.maxinteger
    self._cdDispatchLog.idPopup = 0
  end
end

function UIN34DispatchMain:StartHideLogTimer(period)
  self._cdHideLog.tick = 0
  self._cdHideLog.period = period
end

function UIN34DispatchMain:InActivityTime()
  local endTime = self._dispatchComponent:GetComponentInfo().m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  return endTime >= curTime
end

function UIN34DispatchMain:AddEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UIN34DispatchMain:UIWidget()
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._lineContent = self:GetUIComponent("UISelectObjectPath", "lineContent")
  self._nodeContent = self:GetUIComponent("UISelectObjectPath", "nodeContent")
  self._selectedFrame = self:GetUIComponent("RectTransform", "selectedFrame")
  self._rootPlayer = self:GetUIComponent("RectTransform", "rootPlayer")
  self._rootPlayerEff = self:GetChildComponent(self._rootPlayer, "RectTransform", "eff")
  self._dispatchStatusText = self:GetUIComponent("UILocalizationText", "dispatchStatusText")
  self._btnDispatchText = self:GetUIComponent("UILocalizationText", "btnDispatchText")
  self._dispatchTime = self:GetUIComponent("UILocalizationText", "txtTime")
  self._btnDispatch = self:GetUIComponent("RectTransform", "btnDispatch")
  self._uiTime = self:GetUIComponent("RectTransform", "uiTime")
  self._redDispatch = self:View():GetUIComponent("UISelectObjectPath", "redDispatch")
  self._redDispatchSpawn = nil
  self._dispatchLog = self:GetUIComponent("RectTransform", "dispatchLog")
  self._dispatchLogText = self:GetUIComponent("UILocalizationText", "dispatchLogText")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._dispatchLogAnim = self:GetUIComponent("Animation", "dispatchLogAnim")
  self._wuRoot = self:GetUIComponent("RectTransform", "wuRoot")
  self._wuAnim = self:GetUIComponent("Animation", "wuAnim")
  self._wuNode = {
    [1] = nil,
    [2] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke2"),
    [3] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke3"),
    [4] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke4"),
    [5] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke5"),
    [6] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke6"),
    [7] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke7")
  }
  self._wuNodeUnlock = {
    [1] = nil,
    [2] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke2 (1)"),
    [3] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke3 (1)"),
    [4] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke4 (1)"),
    [5] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke5 (1)"),
    [6] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke6 (1)"),
    [7] = self:GetChildComponent(self._wuRoot, "RectTransform", "smoke7 (1)")
  }
  self._wuAnimName = {
    [1] = nil,
    [2] = "uieff_UIN34DispatchMain_unlock2",
    [3] = "uieff_UIN34DispatchMain_unlock3",
    [4] = "uieff_UIN34DispatchMain_unlock4",
    [5] = "uieff_UIN34DispatchMain_unlock5",
    [6] = "uieff_UIN34DispatchMain_unlock6",
    [7] = "uieff_UIN34DispatchMain_unlock7"
  }
  self._wuAnimLength = {
    [1] = 0,
    [2] = 1000,
    [3] = 1500,
    [4] = 1000,
    [5] = 1033,
    [6] = 1200,
    [7] = 1567
  }
  self._wuAnimUnlockName = {
    [1] = nil,
    [2] = "uieff_UIN34DispatchMain_unlock2_m",
    [3] = "uieff_UIN34DispatchMain_unlock3_m",
    [4] = "uieff_UIN34DispatchMain_unlock4_m",
    [5] = "uieff_UIN34DispatchMain_unlock5_m",
    [6] = "uieff_UIN34DispatchMain_unlock6_m",
    [7] = "uieff_UIN34DispatchMain_unlock7_m"
  }
  self._wuAnimUnlockLength = {
    [1] = 0,
    [2] = 533,
    [3] = 533,
    [4] = 533,
    [5] = 533,
    [6] = 533,
    [7] = 533
  }
end

function UIN34DispatchMain:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:OutAnimation(function()
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN34MainController, UIStateType.UIMain, nil, self._campaign._id)
    end)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, nil, false, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIN34DispatchMain:CreateMission()
  local componentID = self._dispatchComponent:GetComponentCfgId()
  local allCfg = Cfg.cfg_component_dispatch_arch({ComponentID = componentID})
  local componentInfo = self._dispatchComponent:GetComponentInfo()
  local dispatchInfo = componentInfo.dispatch_infos
  self._missions = {}
  self._dicMissions = {}
  for k, v in pairs(allCfg) do
    local level = {
      structName = "UIN34DispatchMain::Level",
      cfgMission = v,
      archInfo = dispatchInfo[v.ID],
      selected = false,
      nodeWidget = nil,
      lineWidget = nil,
      order = nil
    }
    self._dicMissions[v.ID] = level
    table.insert(self._missions, level)
  end
  local order = 1000
  local missionCount = #self._missions
  local theHeadNode = self._missions[missionCount]
  local loopNode = theHeadNode
  while loopNode ~= nil do
    loopNode.order = order
    order = order - 1
    local idPre = loopNode.cfgMission.PreArchitectureId
    loopNode = self._dicMissions[idPre]
  end
  local loopNode = theHeadNode
  order = loopNode.order
  while loopNode ~= nil do
    local loopNodeID = loopNode.cfgMission.ID
    loopNode = nil
    for k, v in pairs(self._dicMissions) do
      if v.cfgMission.PreArchitectureId == loopNodeID then
        order = order + 1
        v.order = order
        loopNode = v
        break
      end
    end
  end
  table.sort(self._missions, function(a, b)
    return a.order < b.order
  end)
  self._widgetNodes = self._nodeContent:SpawnObjects("UIN34DispatchNode", missionCount)
  self._widgetLines = self._lineContent:SpawnObjects("UIN34DispatchLine", missionCount + 1)
  for k, v in pairs(self._missions) do
    local uiWidget = self._widgetNodes[k]
    uiWidget:GetGameObject().name = k - 1
    v.order = k
    v.nodeWidget = uiWidget
    local view = uiWidget:View()
    local anchoredPosition = Vector2(v.cfgMission.NodePosX, v.cfgMission.NodePosY)
    self:NormalizeNode(view.transform, anchoredPosition)
    uiWidget:SetData(self._atlasDispatch, v)
    local uiWidget = self._widgetLines[k]
    uiWidget:GetGameObject().name = k - 1
    v.lineWidget = uiWidget
    local view = uiWidget:View()
    local anchoredPosition = Vector2(v.cfgMission.LinePosX, v.cfgMission.LinePosY)
    self:NormalizeNode(view.transform, anchoredPosition)
    uiWidget:SetData(self._atlasDispatch, v.cfgMission, k)
  end
  self._widgetLines[missionCount]:SetTail(true)
  self._rootPlayer:SetParent(self._nodeContent:Engine().transform, false)
  self:NormalizeNode(self._rootPlayer, Vector2.zero)
  self._selectedFrame:SetParent(self._nodeContent:Engine().transform, false)
  self:NormalizeNode(self._selectedFrame, Vector2.zero)
  local theFirstLineK = missionCount + 1
  local theFirstLine = self._widgetLines[theFirstLineK]
  if theFirstLine ~= nil then
    theFirstLine:GetGameObject().name = theFirstLineK - 1
    local view = theFirstLine:View()
    local anchoredPosition = Vector2(802, -209)
    self:NormalizeNode(view.transform, anchoredPosition)
    local cfgMission = {
      LineSizeW = 128,
      LineSizeH = 178,
      LineImage = nil
    }
    theFirstLine:SetData(self._atlasDispatch, cfgMission, theFirstLineK)
  end
end

function UIN34DispatchMain:NormalizeNode(rt, anchoredPosition)
  rt.pivot = Vector2.one * 0.5
  rt.localScale = Vector3.one
  rt.anchorMin = Vector2(0.5, 1)
  rt.anchorMax = Vector2(0.5, 1)
  rt.sizeDelta = Vector3.one * 100
  rt.anchoredPosition = anchoredPosition
end

function UIN34DispatchMain:GetAtlasDispatch()
  return self._atlasDispatch
end

function UIN34DispatchMain:FlushMission()
  local currentOrder = 1
  local archInfo = self._currentNode.archInfo
  if archInfo ~= nil then
    if archInfo.status == ComDispatchStatus.DISPATCHING then
      currentOrder = self._currentNode.order
    elseif archInfo.status == ComDispatchStatus.COMPLETE then
      currentOrder = self._currentNode.order
    end
  else
    local prevNode
    for k, v in pairs(self._missions) do
      if self._currentNode == v then
        break
      end
      prevNode = v
    end
    if prevNode ~= nil then
      currentOrder = prevNode.order
    end
  end
  for k, v in pairs(self._dicMissions) do
    v.nodeWidget:FlushStatus()
    v.nodeWidget:LoopAnimation(false)
    v.lineWidget:ShowImgLine(k < currentOrder)
  end
end

function UIN34DispatchMain:FlushSelection()
  local selectedNode
  for k, v in pairs(self._dicMissions) do
    if v.selected then
      selectedNode = v
      break
    end
  end
  if selectedNode == nil then
    self._selectedFrame.gameObject:SetActive(false)
  else
    self._selectedFrame.gameObject:SetActive(true)
    self._selectedFrame.anchoredPosition = selectedNode.nodeWidget:View().transform.anchoredPosition
  end
  self._selectedFrame.gameObject:SetActive(false)
  for k, v in pairs(self._dicMissions) do
    v.nodeWidget:LoopSelection(v.selected)
  end
end

function UIN34DispatchMain:BreakPosition()
  local currentNode, dispatchNode, completedNode
  for k, v in pairs(self._missions) do
    local archInfo = v.archInfo
    if archInfo == nil then
      currentNode = v
      break
    elseif archInfo.status == ComDispatchStatus.DISPATCHING then
      currentNode = v
      dispatchNode = v
      break
    elseif archInfo.status == ComDispatchStatus.COMPLETE then
      currentNode = v
      completedNode = v
    end
  end
  self._currentNode = currentNode
  if dispatchNode ~= nil then
    self._currentNode = currentNode
  elseif completedNode ~= nil then
    if self._localDb:IsViewed(completedNode.cfgMission.ID) then
      self._currentNode = currentNode
    else
      self._currentNode = completedNode
    end
  end
  local archInfo = self._currentNode.archInfo
  local viewedDialogue = self._localDb:IsViewed(self._currentNode.cfgMission.ID)
  if archInfo == nil then
    return
  elseif archInfo.status == ComDispatchStatus.DISPATCHING then
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    if curTime >= archInfo.end_time then
      local lockName = "UIN34DispatchMain:GetRewardsTask"
      self:StartSafeTask(lockName, self.GetRewardsTask, self)
    else
      self:StartRewardTimer()
      self:StartDispatchLogTimer()
      self:PopupDispatchLog()
    end
  elseif archInfo.status == ComDispatchStatus.COMPLETE and not viewedDialogue then
    local archId = self._currentNode.cfgMission.ID
    local lockName = "UIN34DispatchMain:OpenDialogueTask"
    self:StartSafeTask(lockName, self.OpenDialogueTask, self, archId)
  elseif archInfo.status == ComDispatchStatus.COMPLETE and viewedDialogue then
    local count = #self._missions
    local theLastNode = self._missions[count]
    self._missionAllOver = self._currentNode == theLastNode
  end
end

function UIN34DispatchMain:ShowQPlayer(node)
  local nodeWidget = node.nodeWidget
  local offset = nodeWidget:QPlayerOffset()
  self._rootPlayerEff.gameObject:SetActive(true)
  self._rootPlayer.gameObject:SetActive(true)
  self._rootPlayer.anchoredPosition = nodeWidget:View().transform.anchoredPosition + offset
end

function UIN34DispatchMain:FlushQPlayer()
  local playerVisible = false
  local archInfo = self._currentNode.archInfo
  if archInfo ~= nil then
    if archInfo.status == ComDispatchStatus.DISPATCHING then
      playerVisible = true
      self:ShowQPlayer(self._currentNode)
    elseif archInfo.status == ComDispatchStatus.COMPLETE then
      playerVisible = true
      self:ShowQPlayer(self._currentNode)
    end
  else
    local prevNode
    for k, v in pairs(self._missions) do
      if self._currentNode == v then
        break
      end
      prevNode = v
    end
    if prevNode ~= nil then
      playerVisible = true
      self:ShowQPlayer(prevNode)
    end
  end
  if not playerVisible then
    self._rootPlayer.gameObject:SetActive(playerVisible)
  end
end

function UIN34DispatchMain:FlushWuEffect()
  local prevNode
  local visibleOrder = 1
  local archInfo = self._currentNode.archInfo
  if archInfo ~= nil then
    if archInfo.status == ComDispatchStatus.DISPATCHING then
      visibleOrder = self._currentNode.order
    elseif archInfo.status == ComDispatchStatus.COMPLETE then
      visibleOrder = self._currentNode.order
    end
  else
    for k, v in pairs(self._missions) do
      if self._currentNode == v then
        break
      end
      prevNode = v
    end
    if prevNode ~= nil then
      visibleOrder = prevNode.order
    end
  end
  for k, v in pairs(self._wuNode) do
    if v ~= nil then
      v.gameObject:SetActive(k > visibleOrder)
    end
  end
  for k, v in pairs(self._wuNodeUnlock) do
    if v ~= nil then
      v.gameObject:SetActive(k > visibleOrder)
    end
  end
  if prevNode ~= nil then
    local lockName = "UIN34DispatchMain:WuAnimUnlockTT"
    self:StartTask(function(TT)
      self:Lock(lockName)
      self:WuAnimUnlockTT(TT, self._currentNode.order)
      self:UnLock(lockName)
    end)
  end
end

function UIN34DispatchMain:FlushDispatch()
  local theStatus = ComDispatchStatus.COMPLETE
  local archInfo = self._currentNode.archInfo
  if archInfo == nil then
    theStatus = ComDispatchStatus.COMPLETE
  else
    theStatus = archInfo.status
  end
  self._uiTime.gameObject:SetActive(theStatus == ComDispatchStatus.DISPATCHING)
  self._btnDispatch.gameObject:SetActive(theStatus == ComDispatchStatus.COMPLETE)
  local showRedPoint = false
  if theStatus == ComDispatchStatus.COMPLETE then
    self._dispatchStatusText:SetText(StringTable.Get("str_n34_dispatch_wait_btn_status"))
    local count = #self._missions
    local theLastNode = self._missions[count]
    showRedPoint = self._currentNode ~= theLastNode
  elseif theStatus == ComDispatchStatus.DISPATCHING then
    self._currentNode.nodeWidget:LoopAnimation(true)
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local deltaTime = math.max(archInfo.end_time - curTime, 0)
    local timerStr = self:GetFormatTimerStr(deltaTime, "FFF004")
    self._dispatchStatusText:SetText(StringTable.Get("str_n34_dispatch_progress_btn_status"))
    self._dispatchTime:SetText(StringTable.Get("str_n34_dispatch_progress_btn", timerStr))
  end
  if self._redDispatchSpawn == nil then
    self._redDispatchSpawn = self._redDispatch:SpawnOneObject("ManualLoad0")
  end
  self._redDispatchSpawn:SetActive(showRedPoint)
end

function UIN34DispatchMain:GetFormatTimerStr(deltaTime, txtColor)
  local id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107",
    clrFormat = "<color=#%s>%s</color>"
  }
  if txtColor == nil then
    txtColor = "FFF004"
  end
  local day = 0
  local hour = 0
  local min = 0
  local second = 0
  if 0 <= deltaTime then
    day, hour, min, second = UIActivityHelper.Time2Str(deltaTime)
  end
  local timeStr
  if 0 < day and 0 < hour then
    timeStr = string.format(id.clrFormat, txtColor, day) .. StringTable.Get(id.day)
    timeStr = timeStr .. string.format(id.clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
  elseif 0 < day then
    timeStr = string.format(id.clrFormat, txtColor, day) .. StringTable.Get(id.day)
  elseif 0 < hour and 0 < min then
    timeStr = string.format(id.clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
    timeStr = timeStr .. string.format(id.clrFormat, txtColor, min) .. StringTable.Get(id.min)
  elseif 0 < hour then
    timeStr = string.format(id.clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
  elseif 0 < min then
    timeStr = string.format(id.clrFormat, txtColor, min) .. StringTable.Get(id.min)
  else
    timeStr = string.format(id.clrFormat, txtColor, StringTable.Get(id.zero))
  end
  return timeStr
end

function UIN34DispatchMain:FlushAllOver()
  if self._missionAllOver then
    self._rootPlayer.gameObject:SetActive(false)
    self._dispatchStatusText:SetText(StringTable.Get("str_n34_dispatch_over_btn_status"))
    self._btnDispatchText:SetText(StringTable.Get("str_n34_dispatch_over_btn"))
  end
end

function UIN34DispatchMain:InAnimation()
  local lockName = "UIN34DispatchMain:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN34DispatchMain_in")
    YIELD(TT, 367)
    self:UnLock(lockName)
  end)
end

function UIN34DispatchMain:OutAnimation(endCb)
  local lockName = "UIN34DispatchMain:OutAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN34DispatchMain_out")
    YIELD(TT, 167)
    if endCb ~= nil then
      endCb()
    end
    self:UnLock(lockName)
  end)
end

function UIN34DispatchMain:PopupDispatchLog()
  local archInfo = self._currentNode.archInfo
  local allCfg = Cfg.cfg_mission_dispatch_log({
    BuildingId = archInfo.arch_id
  })
  local sortList = {}
  if allCfg ~= nil then
    for k, v in pairs(allCfg) do
      table.insert(sortList, v)
    end
  end
  table.sort(sortList, function(a, b)
    return a.DispatchTime < b.DispatchTime
  end)
  local endTime = self._currentNode.archInfo.end_time
  local dispatchPeriod = self._currentNode.cfgMission.DispatchTime
  local startTime = endTime - dispatchPeriod
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local cfgPopup
  for k, v in pairs(sortList) do
    if curTime >= startTime + v.DispatchTime then
      cfgPopup = v
    else
      break
    end
  end
  if cfgPopup ~= nil then
    self:ShowDispatchLog(true, true, StringTable.Get(cfgPopup.ChatId))
    self:StartHideLogTimer(cfgPopup.DisplayPeriod * 1000)
  end
end

function UIN34DispatchMain:ShowDispatchLog(inVisible, playAnim, logMessage)
  if inVisible then
    self._dispatchLogText:SetText(logMessage)
  end
  if not playAnim then
    self._dispatchLog.gameObject:SetActive(inVisible)
  else
    self._dispatchLog.gameObject:SetActive(inVisible)
    local lockName = "UIN34DispatchMain:ShowDispatchLog"
    self:StartTask(function(TT)
      self:Lock(lockName)
      if inVisible then
        self._dispatchLogAnim:Play("uieff_UIN34DispatchMain_Log_in")
        YIELD(TT, 333)
      else
        self._cdHideLog.tick = 0
        self._cdHideLog.period = math.maxinteger - 1000
        self._dispatchLogAnim:Play("uieff_UIN34DispatchMain_Log_out")
        YIELD(TT, 167)
        self._cdHideLog.tick = 0
        self._cdHideLog.period = math.maxinteger
      end
      self._dispatchLog.gameObject:SetActive(inVisible)
      self:UnLock(lockName)
    end)
  end
end

function UIN34DispatchMain:DispatchTask(TT, lockName)
  self:Lock(lockName)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local archId = self._currentNode.cfgMission.ID
  self._dispatchComponent:HandleDispatch(TT, res, archId)
  if not res:GetSucc() then
    self._campaign:CheckErrorCode(res:GetResult(), nil, nil)
  else
    self:WuAnimTT(TT, self._currentNode.order)
    local componentInfo = self._dispatchComponent:GetComponentInfo()
    local dispatchInfo = componentInfo.dispatch_infos
    local archInfo = dispatchInfo[archId]
    self._currentNode.selected = false
    self._currentNode.archInfo = archInfo
    self:FlushMission()
    self:FlushSelection()
    self:FlushQPlayer()
    self:FlushWuEffect()
    self:FlushDispatch()
    self:StartRewardTimer()
    self:StartDispatchLogTimer()
  end
  self:UnLock(lockName)
end

function UIN34DispatchMain:WuAnimTT(TT, order)
  if self._wuNode[order] == nil then
    return
  end
  self._wuAnim:Play(self._wuAnimName[order])
  YIELD(TT, self._wuAnimLength[order])
end

function UIN34DispatchMain:WuAnimUnlockTT(TT, order)
  if self._wuNode[order] == nil then
    return
  end
  self._wuAnim:Play(self._wuAnimUnlockName[order])
  YIELD(TT, self._wuAnimUnlockLength[order])
end

function UIN34DispatchMain:GetRewardsTask(TT, lockName)
  self:Lock(lockName)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local archId = self._currentNode.cfgMission.ID
  self._dispatchComponent:HandleGetDispatchRewards(TT, res, archId)
  if not res:GetSucc() then
    self._campaign:CheckErrorCode(res:GetResult(), nil, nil)
  else
    local componentInfo = self._dispatchComponent:GetComponentInfo()
    local dispatchInfo = componentInfo.dispatch_infos
    local newArchInfo = dispatchInfo[archId]
    self:GetRewardsSuccess(TT, lockName, newArchInfo)
  end
  self:UnLock(lockName)
end

function UIN34DispatchMain:GetRewardsTask_TestCase(TT)
  local lockName = "UIN34DispatchMain:GetRewardsTask"
  self:Lock(lockName)
  local archInfo = self._currentNode.archInfo
  local newArchInfo = DispatchArchInfo:New()
  newArchInfo.arch_id = archInfo.arch_id
  newArchInfo.end_time = archInfo.end_time
  newArchInfo.status = ComDispatchStatus.COMPLETE
  self:GetRewardsSuccess(TT, lockName, newArchInfo)
  self:UnLock(lockName)
end

function UIN34DispatchMain:GetRewardsSuccess(TT, lockName, newArchInfo)
  local archId = newArchInfo.arch_id
  local uiComplete = "UIN34DispatchComplete"
  local uiStateManager = GameGlobal.UIStateManager()
  self:ShowDialog(uiComplete, archId)
  while not uiStateManager:IsShow(uiComplete) do
    YIELD(TT)
  end
  YIELD(TT, 1000)
  self._currentNode.archInfo = newArchInfo
  self:FlushMission()
  self:FlushQPlayer()
  self:FlushWuEffect()
  self:FlushDispatch()
  self:UnLock(lockName)
  while uiStateManager:IsShow(uiComplete) do
    YIELD(TT)
  end
  self:Lock(lockName)
  YIELD(TT, 500)
  local lockName = "UIN34DispatchMain:OpenDialogueTask"
  self:StartSafeTask(lockName, self.OpenDialogueTask, self, archId)
end

function UIN34DispatchMain:OpenDialogueTask(TT, lockName, archId)
  self:Lock(lockName)
  local uiDialogueOpen = "UIN34DispatchDialogueOpen"
  local uiTerminalMain = "UIN34DispatchTerminalMainControlller"
  local uiStateManager = GameGlobal.UIStateManager()
  local openTerminal = false
  self:ShowDialog(uiDialogueOpen, archId, function()
    openTerminal = true
  end)
  while not uiStateManager:IsShow(uiDialogueOpen) do
    YIELD(TT)
  end
  self:UnLock(lockName)
  while uiStateManager:IsShow(uiDialogueOpen) do
    YIELD(TT)
    if openTerminal then
      break
    end
  end
  self:Lock(lockName)
  self:ShowDialog(uiTerminalMain, UIN34DispatchType.OpenDialogue, archId)
  while not uiStateManager:IsShow(uiTerminalMain) do
    YIELD(TT)
  end
  YIELD(TT, 50)
  uiStateManager:CloseDialog(uiDialogueOpen)
  self:UnLock(lockName)
  while uiStateManager:IsShow(uiTerminalMain) do
    YIELD(TT)
  end
  self:Lock(lockName)
  local count = #self._missions
  local theLastNode = self._missions[count]
  self._missionAllOver = self._currentNode == theLastNode
  self:PopupAllOverTask(TT, lockName)
  self._localDb:ViewedLoadDB()
  if self._localDb:IsViewed(archId) then
    local playUnlockAnim = false
    local findCurrentNode = false
    for k, v in pairs(self._missions) do
      if self._currentNode == v then
        findCurrentNode = true
      elseif findCurrentNode then
        playUnlockAnim = true
        self._currentNode = v
        break
      end
    end
    if playUnlockAnim then
      self:WuAnimUnlockTT(TT, self._currentNode.order)
    end
  end
  self:UnLock(lockName)
end

function UIN34DispatchMain:PopupAllOverTask(TT, lockName)
  if self._missionAllOver then
    local uiAllOver = "UIN34DispatchAllOver"
    local uiStateManager = GameGlobal.UIStateManager()
    self:ShowDialog(uiAllOver)
    while not uiStateManager:IsShow(uiAllOver) do
      YIELD(TT)
    end
    self:UnLock(lockName)
    while uiStateManager:IsShow(uiAllOver) do
      YIELD(TT)
    end
    self:Lock(lockName)
    self:FlushAllOver()
  end
end

_class("UIN34DispatchNode", UICustomWidget)
UIN34DispatchNode = UIN34DispatchNode

function UIN34DispatchNode:Constructor()
  self:InstDefine()
end

function UIN34DispatchNode:InstDefine()
  if self._wuNodeSel ~= nil then
    return
  end
  UIN34DispatchNode._wuNodeSel = {
    [1] = "UIN34DispatchNode01Smoke.prefab",
    [2] = "UIN34DispatchNode02Smoke.prefab",
    [3] = "UIN34DispatchNode03Smoke.prefab",
    [4] = "UIN34DispatchNode04Smoke.prefab",
    [5] = "UIN34DispatchNode05Smoke.prefab",
    [6] = "UIN34DispatchNode06Smoke.prefab",
    [7] = "UIN34DispatchNode07Smoke.prefab"
  }
end

function UIN34DispatchNode:OnShow()
  self._uiWu = self:GetUIComponent("Image", "uiWu")
  self._uiWuPath = self:GetUIComponent("UISelectObjectPath", "uiWu")
  self._uiNormal = self:GetUIComponent("Image", "uiNormal")
  self._uiProgress = self:GetUIComponent("RectTransform", "uiProgress")
  self._uiCompleted = self:GetUIComponent("RectTransform", "uiCompleted")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN34DispatchNode:OnHide()
end

function UIN34DispatchNode:BtnOnClick(go)
  self:RootUIOwner():NodeOnClick(self)
end

function UIN34DispatchNode:SetData(atlasDispatch, data)
  self._atlasDispatch = atlasDispatch
  self._data = data
  self._selPrefabName = self._wuNodeSel[self._data.order]
  if self._selPrefabName ~= nil then
    self._uiWuPath.dynamicInfoOfEngine:SetObjectName(self._selPrefabName)
  end
  self:FlushNormal()
end

function UIN34DispatchNode:ID()
  return self._data.cfgMission.ID
end

function UIN34DispatchNode:QPlayerOffset()
  return self._uiProgress.anchoredPosition
end

function UIN34DispatchNode:FlushNormal()
  local cfgMission = self._data.cfgMission
  self._uiWu.transform.sizeDelta = Vector2(cfgMission.NodeSizeW, cfgMission.NodeSizeH)
  self._uiNormal.transform.sizeDelta = Vector2(cfgMission.NodeSizeW, cfgMission.NodeSizeH)
  if cfgMission.NodeWuImage ~= nil then
    self._uiWu.sprite = self._atlasDispatch:GetSprite(cfgMission.NodeWuImage)
  end
  if cfgMission.NodeImage ~= nil then
    self._uiNormal.sprite = self._atlasDispatch:GetSprite(cfgMission.NodeImage)
  end
  if self._selPrefabName ~= nil then
    local instSel = self._uiWuPath:SpawnObject("UICustomWidget")
    self._selection = instSel:GetGameObject().transform
    self._selection.gameObject:SetActive(false)
  end
end

function UIN34DispatchNode:FlushStatus()
  self._uiProgress.gameObject:SetActive(false)
  self._uiCompleted.gameObject:SetActive(false)
  local archInfo = self._data.archInfo
  if archInfo ~= nil then
    self._uiCompleted.gameObject:SetActive(archInfo.status == ComDispatchStatus.COMPLETE)
  end
end

function UIN34DispatchNode:LoopSelection(inSel)
  self._selection.gameObject:SetActive(inSel)
end

function UIN34DispatchNode:LoopAnimation(inPlaying)
  if inPlaying then
    self._animation:Play("uieff_UIN34DispatchNode_loop")
  else
    self._animation:Stop()
  end
end

_class("UIN34DispatchLine", UICustomWidget)
UIN34DispatchLine = UIN34DispatchLine

function UIN34DispatchLine:Constructor()
  self._isTail = false
  self:InstDefine()
end

function UIN34DispatchLine:InstDefine()
  if self._instMap ~= nil then
    return
  end
  UIN34DispatchLine._instMap = {
    [1] = "UIN34DispatchLine01.prefab",
    [2] = "UIN34DispatchLine02.prefab",
    [3] = "UIN34DispatchLine03.prefab",
    [4] = "UIN34DispatchLine04.prefab",
    [5] = "UIN34DispatchLine05.prefab",
    [6] = "UIN34DispatchLine06.prefab",
    [7] = "UIN34DispatchLine07.prefab"
  }
end

function UIN34DispatchLine:OnShow()
  self._imgRoot = self:GetUIComponent("Image", "imgRoot")
  self._instLine = nil
  self._instLinePath = self:GetUIComponent("UISelectObjectPath", "instLine")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN34DispatchLine:SetData(atlasDispatch, cfgMission, luaIndex)
  self._atlasDispatch = atlasDispatch
  self._cfgMission = cfgMission
  self._luaIndex = luaIndex
  self._instPrefabName = self._instMap[self._luaIndex]
  if self._instPrefabName ~= nil then
    self._instLinePath.dynamicInfoOfEngine:SetObjectName(self._instPrefabName)
  end
  self:Flush()
end

function UIN34DispatchLine:Flush()
  local cfgMission = self._cfgMission
  self._imgRoot.transform.sizeDelta = Vector2(cfgMission.LineSizeW, cfgMission.LineSizeH)
  if cfgMission.LineImage ~= nil then
    self._imgRoot.sprite = self._atlasDispatch:GetSprite(cfgMission.LineImage)
  end
  if self._instPrefabName ~= nil then
    self._imgRoot.gameObject:SetActive(false)
    self._instLine = self._instLinePath:SpawnObject("UIN34DispatchLine")
    self._instLine:GetGameObject().name = "InstLine"
    self._instRoot = self._instLine:GetUIComponent("RectTransform", "imgRoot")
    self:View().transform.anchoredPosition = Vector2(0, 0)
    self._imgRoot.transform.anchoredPosition = Vector2(cfgMission.LinePosX, cfgMission.LinePosY)
    self._instRoot.anchoredPosition = Vector2(cfgMission.LinePosX, cfgMission.LinePosY)
  end
end

function UIN34DispatchLine:ShowImgLine(inShow)
  self._imgRoot.gameObject:SetActive(inShow)
end

function UIN34DispatchLine:OnHide()
end

function UIN34DispatchLine:SetTail()
  self._isTail = true
end
