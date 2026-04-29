_class("UIN28ErrandController", UIController)
UIN28ErrandController = UIN28ErrandController

function UIN28ErrandController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIN28ErrandController:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:OutAnim()
  end, function()
    UIActivityHelper.ShowActivityIntro("UIN28ErrandController")
  end, nil, true)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self.timeStr = self:GetUIComponent("UILocalizationText", "timeStr")
  self._anim = self:GetUIComponent("Animation", "anim")
  self:EffMatTexture()
end

function UIN28ErrandController:EffMatTexture()
  local nameImgLoader = self:GetUIComponent("RawImageLoader", "Image")
  local nameRawImg = self:GetUIComponent("RawImage", "Image")
  local nameImg = "n28_dbg_title"
  nameImgLoader:LoadImage(nameImg)
  local mat = nameRawImg.material
  local mainTex = mat:GetTexture("_MainTex")
  local eff1 = self:GetUIComponent("MeshRenderer", "Image_eff")
  local eff2 = self:GetUIComponent("MeshRenderer", "Image_eff_02")
  local eff1mat = eff1.sharedMaterial
  if eff1mat then
    local t = eff1mat:GetTexture("_MainTex")
    eff1mat:SetTexture("_MainTex", mainTex)
    local t2 = eff1mat:GetTexture("_MainTex")
    local a = 1
  end
  local eff2mat = eff2.sharedMaterial
  if eff2mat then
    eff2mat:SetTexture("_MainTex", mainTex)
  end
end

function UIN28ErrandController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_LINE_MISSION
  self._componentId_LineMission = ECampaignLineMissionComponentID.ECAMPAIGN_LINE_MISSION
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId_LineMission)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
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
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._lineMissionComponentInfo = self._campaign:GetComponentInfo(ECampaignLineMissionComponentID.ECAMPAIGN_LINE_MISSION)
end

function UIN28ErrandController:OnShow(uiParams)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  self._select_key = "UIN28Errand_Select_ID" .. openID
  self._missionModule = GameGlobal.GetModule(MissionModule)
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  self:AttachEvents()
  self:InitWidget()
  self:_Refresh()
  self:InAnim()
end

function UIN28ErrandController:InAnim()
  local anim = "uieff_UIN28ErrandController_in"
  self._anim:Play(anim)
  local lockName = "UIN28ErrandController:InAnim"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 1167, function()
    self:UnLock(lockName)
  end)
end

function UIN28ErrandController:OutAnim()
  self:SwitchState(UIStateType.UIMain)
end

function UIN28ErrandController:OnHide()
  self._isOpen = false
  self._timerHolder:Dispose()
  UIN28ErrandController.super:Dispose()
  if self._scroller then
    self._scroller:Dispose()
  end
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  local lock1 = "UIN28ErrandController:InAnim"
  self:UnLock(lock1)
  local lock2 = "UIN28ErrandController:OutAnim"
  self:UnLock(lock2)
end

function UIN28ErrandController:CheckComponentLock(componentid)
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

function UIN28ErrandController:_Refresh()
  self:FlushNodes()
  self:TimeStr()
end

function UIN28ErrandController:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  return bShow
end

function UIN28ErrandController:TimeStr()
  self.svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowLessTime()
  end)
  self.isInnerTime = true
  self:ShowLessTime()
end

function UIN28ErrandController:ShowLessTime()
  local endTime = self._line_component:GetComponentInfo().m_close_time
  local nowTime = self.svrTimeModule:GetServerTime() * 0.001
  if endTime > nowTime then
    local sec = math.modf(endTime - nowTime)
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    self.timeStr:SetText(StringTable.Get("str_n28_errand_remainingtime", timeStr))
  else
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
      self._timer = nil
    end
    self.isInnerTime = false
  end
end

function UIN28ErrandController:FlushNodes()
  local cmpID = self._line_component:GetComponentCfgId()
  local extra_cfg = Cfg.cfg_component_line_mission_extra({ComponentID = cmpID})
  local extra_right = extra_cfg[1].MarginRight
  local missionCfgs_temp = Cfg.cfg_component_line_mission({ComponentID = cmpID})
  self._allMissionCfgs = {}
  for _, cfg in pairs(missionCfgs_temp) do
    self._allMissionCfgs[cfg.CampaignMissionId] = cfg
  end
  local current
  self._unlockInfo = {}
  self._missionCfgList = {}
  for m_id, cfg in pairs(self._allMissionCfgs) do
    local needMID = cfg.NeedMissionId
    if not needMID or needMID == 0 then
      self._unlockInfo[m_id] = true
    elseif self._line_info.m_pass_mission_info[needMID] then
      self._unlockInfo[m_id] = true
    else
      self._unlockInfo[m_id] = false
    end
    table.insert(self._missionCfgList, cfg)
  end
  table.sort(self._missionCfgList, function(a, b)
    local a_sort = a.SortId
    local b_sort = b.SortId
    return a_sort < b_sort
  end)
  local levelCount = #self._missionCfgList
  local lineCount = #self._missionCfgList - 1
  self:_SetNodeAndLine(levelCount, lineCount, self._missionCfgList)
  local r = -99999999
  for _, cfg in pairs(self._allMissionCfgs) do
    r = math.max(r, cfg.MapPosX)
  end
  local width = math.abs(r + extra_right)
  width = math.max(width, self._safeAreaSize.x)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
  self:InitSelectNode()
end

function UIN28ErrandController:_SetNodeAndLine(levelCount, lineCount, showMission)
  self._nodes = UIWidgetHelper.SpawnObjects(self, "Nodes", "UIN28ErrandMapNode", levelCount)
  local lines = UIWidgetHelper.SpawnObjects(self, "Lines", "UIN28ErrandMapLine", lineCount)
  local nodeIdx, lineIdx = 1, 1
  local nodeYieldAnim = 100
  local nodeYieldGaps = 40
  local lineYieldAnim = 100
  local lineYieldGaps = 40
  for index, cfg in ipairs(showMission) do
    local uiNode = self._nodes[nodeIdx]
    local missionID = cfg.CampaignMissionId
    local nodeYieldTime = nodeYieldAnim + nodeYieldGaps * (nodeIdx - 1)
    uiNode:SetData(cfg, self._line_info.m_pass_mission_info[missionID], function(stageId, isStory, worldPos)
      self:_OnNodeClick(stageId, isStory, worldPos)
    end, self._unlockInfo[missionID], nodeYieldTime)
    nodeIdx = nodeIdx + 1
    if cfg.WayPointType ~= 4 and cfg.NeedMissionId ~= 0 then
      local n1 = self._allMissionCfgs[cfg.NeedMissionId]
      local n2 = cfg
      local line = lines[lineIdx]
      local lineYieldTime = lineYieldAnim + lineYieldGaps * (lineIdx - 1)
      line:Flush(Vector2(n2.MapPosX, n2.MapPosY), Vector2(n1.MapPosX, n1.MapPosY), lineYieldTime)
      lineIdx = lineIdx + 1
    end
  end
end

function UIN28ErrandController:InitSelectNode()
  local selectNode = LocalDB.GetString(self._select_key, "")
  local selectid
  if not string.isnullorempty(selectNode) then
    selectid = tonumber(selectNode)
  else
    selectid = self._missionCfgList[1].CampaignMissionId
  end
  self:NodeSelect(selectid)
  self:MoveContent(selectid)
end

function UIN28ErrandController:NodeSelect(selectID)
  if self._nodes then
    for key, value in pairs(self._nodes) do
      value:Select(selectID)
    end
  end
end

function UIN28ErrandController:SaveSelectNode(selectID)
  LocalDB.SetString(self._select_key, tostring(selectID))
end

function UIN28ErrandController:_OnNodeClick(stageId, isStory, worldPos)
  if not self.isInnerTime then
    local tips = StringTable.Get("str_activity_common_notice_content")
    Log.debug("###[UIN28ErrandController] _OnNodeClick over time !")
    ToastManager.ShowToast(tips)
    return
  end
  self:ClearNodeRed(stageId)
  self:NodeSelect(stageId)
  self:SaveSelectNode(stageId)
  if isStory then
    self:_OnNodeClick_Story(stageId, worldPos)
  else
    self:_OnNodeClick_Battle(stageId, worldPos)
  end
end

function UIN28ErrandController:ClearNodeRed(stageId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local localdbMissionKey = "UIN28ErrandSideEnter_Mission"
  local id = stageId
  local mission_key = localdbMissionKey .. id .. openID
  LocalDB.SetInt(mission_key, 1)
end

function UIN28ErrandController:_OnNodeClick_Story(stageId, worldPos)
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

function UIN28ErrandController:MoveContent(stageId)
  local pos = self._allMissionCfgs[stageId].MapPosX
  local curPos = self._contentRect.anchoredPosition.x
  local areaWidth = 458
  local targetPos
  local left, right = -curPos + areaWidth, -curPos + self._safeAreaSize.x - areaWidth
  if pos < left then
    targetPos = curPos + left - pos
  elseif pos > right then
    targetPos = curPos + right - pos
  end
  self._scrollRect:StopMovement()
  if targetPos then
    self._contentRect.anchoredPosition = Vector2(targetPos, self._contentRect.anchoredPosition.y)
  end
end

function UIN28ErrandController:_OnNodeClick_Battle(stageId, worldPos)
  local pos = self._allMissionCfgs[stageId].MapPosX
  local curPos = self._contentRect.anchoredPosition.x
  local areaWidth = 458
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

function UIN28ErrandController:_EnterStage(stageId, worldPos)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, stageId)
  local pointComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, 1)
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, autoFightShow, pointComponent, true, true, "n28_dbg_di06", true)
end

function UIN28ErrandController:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIN28ErrandController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIN28ErrandController:PlotEndCallback(stageId)
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
        self:SwitchState(UIStateType.UIN28Errand)
      end)
    else
      self:SwitchState(UIStateType.UIN28Errand)
    end
  end, self)
end

function UIN28ErrandController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN28ErrandController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end
