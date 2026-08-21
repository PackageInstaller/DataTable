_class("UICN20N49LineController", UIController)
UICN20N49LineController = UICN20N49LineController

function UICN20N49LineController:Constructor()
  self._isReview = false
end

function UICN20N49LineController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UICN20N49LineController:InitWidget()
  local function closeCallback()
    self:_Back()
  end
  
  local backBtns = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  backBtns:SetData(closeCallback)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._nodePool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._linePool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._tStarNum = self:GetUIComponent("UILocalizationText", "tStarNum")
  self._tStarRed = self:GetGameObject("tStarRed")
  self._atlas = self:GetAsset("UICN20N49.spriteatlas", LoadType.SpriteAtlas)
  self._normalStar = self._atlas:GetSprite("cn20_lsxxg_di05")
  self._normalStarNo = self._atlas:GetSprite("cn20_lsxxg_di06")
  self._bossStar = self._atlas:GetSprite("cn20_lsxxg_di07")
  self._bossStarNo = self._atlas:GetSprite("cn20_lsxxg_di06")
end

function UICN20N49LineController:SetTStar()
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

function UICN20N49LineController:_Back()
  local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UICN20N49MainController, nil)
  local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
end

function UICN20N49LineController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = UICN20N49Helper.GetCampaignType(self._isReview)
  self._componentId_LineMission = UICN20N49Helper.GetComponentId("line", self._isReview)
  self._componentId_Quest = UICN20N49Helper.GetComponentId("quest", self._isReview)
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId_LineMission
  })
  local fRes = AsyncRequestRes:New()
  self._campaign:ReLoadCampaignInfo_Force(TT, fRes)
end

function UICN20N49LineController:OnShow(uiParams)
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
end

function UICN20N49LineController:OnHide()
  self:DetachEvents()
  self._isOpen = false
  self._timerHolder:Dispose()
end

function UICN20N49LineController:_Refresh()
  self:FlushNodes()
  if not self._isReview then
    local endTime = self._line_component:GetComponentInfo().m_close_time
    self:_SetRemainingTime("_time", "str_cn20_n49_shop_close_time_tips", endTime)
  else
    self:_SetRemainingTime("_time", "", endTime)
  end
  if not self._isReview then
    UICN20N49Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign)
  end
end

function UICN20N49LineController:TStarBtnOnClick(go)
  self:ShowDialog("UICommonLineMissionAwards", self._quest_component)
end

function UICN20N49LineController:FlushNodes()
  local missionCfgs = UIActivityLineMissionHelper.GetMissionCfgs(self._line_component)
  local levelCount, lineCount, showMission = UIActivityLineMissionHelper.GetNodeLineInfo(self._line_component, missionCfgs)
  self:_SetNodeAndLine(levelCount, lineCount, showMission)
  self:_SetContentSize(showMission)
  self:_SetMainBg(showMission, missionCfgs)
  self._allMissionCfgs = missionCfgs
end

function UICN20N49LineController:_SetNodeAndLine(levelCount, lineCount, showMission)
  self._nodePool:SpawnObjects("UICN20N49LineMapNode", levelCount)
  self._linePool:SpawnObjects("UICN20N49LineMapLine", lineCount)
  local nodes = self._nodePool:GetAllSpawnList()
  local lines = self._linePool:GetAllSpawnList()
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetStarSp(self._normalStar, self._normalStarNo, self._bossStar, self._bossStarNo)
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

function UICN20N49LineController:_SetContentSize(showMission)
  local width = UIActivityLineMissionHelper.CalcContentWidth(self._line_component, showMission, self._safeAreaSize.x)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
end

function UICN20N49LineController:_SetMainBg(showMission, missionCfgs)
  local width = UIActivityLineMissionHelper.CalcContentWidth(self._line_component, showMission, self._safeAreaSize.x)
  width = math.max(self._safeAreaSize.x, width)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
end

function UICN20N49LineController:_OnNodeClick(stageId, isStory)
  if isStory then
    UIActivityLineMissionHelper.EnterStage_Story(self._campaign, self._line_component, stageId, function()
      self:SwitchState(UIStateType.UICN20N49LineController)
    end)
  else
    self:_PlayContentMoveEff(stageId, function()
      UIActivityLineMissionHelper.EnterStage_Battle(self._campaign, self._line_component, stageId, true)
    end)
  end
end

function UICN20N49LineController:_PlayContentMoveEff(stageId, callback)
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

function UICN20N49LineController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UICN20N49LineController:DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN20N49LineController:_AfterUILayerChanged()
  if not self._isReview then
    UICN20N49Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign)
  end
end

function UICN20N49LineController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN20N49LineController:_OnComponentClose(componentCfgId)
  local component = self._line_component
  if component and component:GetComponentCfgId() == componentCfgId then
    self:_Back()
  end
end

function UICN20N49LineController:_OnItemChanged(id)
  self:_Refresh()
end
