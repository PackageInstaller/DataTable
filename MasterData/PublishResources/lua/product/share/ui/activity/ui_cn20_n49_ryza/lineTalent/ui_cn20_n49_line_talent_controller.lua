_class("UICN20N49LineTalentController", UIController)
UICN20N49LineTalentController = UICN20N49LineTalentController

function UICN20N49LineTalentController:Constructor()
  self._isReview = false
end

function UICN20N49LineTalentController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UICN20N49LineTalentController:_SetActionPoint(widgetName)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UICN20N49ActionPointLineTalent")
  obj:SetData(self._campaign, ECampaignCN20ComponentID.ECN20_ACTION_POINT, "UICN20N49ActionPointDetail", false, self:GetName())
end

function UICN20N49LineTalentController:InitWidget()
  local function closeCallback()
    self:_Back()
  end
  
  local function introCallback()
    self:ShowDialog("UIIntroLoader", "UICN20N49TalentIntro", MaskType.MT_BlurMask)
  end
  
  local backBtns = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  backBtns:SetData(closeCallback, introCallback, nil, true)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._nodePool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._linePool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._skillTreePool = self:GetUIComponent("UISelectObjectPath", "_skillTreePool")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._tStarNum = self:GetUIComponent("UILocalizationText", "tStarNum")
  self._tStarRed = self:GetGameObject("tStarRed")
  self._atlas = self:GetAsset("UICN18N47.spriteatlas", LoadType.SpriteAtlas)
  self._normalStar = self._atlas:GetSprite("n47_xxg_icon01")
  self._normalStarNo = self._atlas:GetSprite("n47_xxg_icon02")
  self._bossStar = self._atlas:GetSprite("n47_xxg_icon03")
  self._bossStarNo = self._atlas:GetSprite("n47_xxg_icon04")
end

function UICN20N49LineTalentController:SetTStar()
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

function UICN20N49LineTalentController:_Back()
  local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UICN20N49MainController, nil)
  local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
end

function UICN20N49LineTalentController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = UICN20N49Helper.GetCampaignType(self._isReview)
  self._componentId_LineMission = UICN20N49Helper.GetComponentId("talent", self._isReview)
  self._componentId_Quest = UICN20N49Helper.GetComponentId("quest", self._isReview)
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId_LineMission
  })
  local fRes = AsyncRequestRes:New()
  self._campaign:ReLoadCampaignInfo_Force(TT, fRes)
  self._tree_component = UICN20N49Helper.GetComponent(self._campaign, "tree")
end

function UICN20N49LineTalentController:OnShow(uiParams)
  self._line_component = self._campaign:GetComponent(self._componentId_LineMission)
  self._quest_component = self._campaign:GetComponent(self._componentId_Quest)
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  self:AttachEvents()
  self:InitWidget()
  self:AttachEvent(GameEventType.OnTalentTreeChange, self.SkillTreeInfo)
  self:_Refresh()
  self:SkillTreeInfo()
  local lockName = "UILineMissionController_OnShow"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
    self:CheckGuide()
  end)
end

function UICN20N49LineTalentController:OnHide()
  self:DetachEvents()
  self._isOpen = false
  self._timerHolder:Dispose()
end

function UICN20N49LineTalentController:_Refresh()
  self:FlushNodes()
  if not self._isReview then
    local endTime = self._line_component:GetComponentInfo().m_close_time
    self:_SetActionPoint("_actionPoint")
  end
  if not self._isReview then
    self:SkillTreeInfo()
  end
end

function UICN20N49LineTalentController:TStarBtnOnClick(go)
  self:ShowDialog("UICommonLineMissionAwards", self._quest_component)
end

function UICN20N49LineTalentController:TalentTreeBtnOnClick(go)
end

function UICN20N49LineTalentController:SkillTreeInfo()
  if not self._skillTreeItem then
    self._skillTreeItem = self._skillTreePool:SpawnObject("UICN20N49LineTalentTreeSlot")
  end
  self._skillTreeItem:SetData(self._campaign, self._tree_component)
end

function UICN20N49LineTalentController:FlushNodes()
  local missionCfgs = UIActivityLineMissionHelper.GetMissionCfgs(self._line_component)
  local levelCount, lineCount, showMission = UIActivityLineMissionHelper.GetNodeLineInfo(self._line_component, missionCfgs)
  self:_SetNodeAndLine(levelCount, lineCount, showMission)
  self:_SetContentSize(showMission)
  self:_SetMainBg(showMission, missionCfgs)
  self._allMissionCfgs = missionCfgs
end

function UICN20N49LineTalentController:_SetNodeAndLine(levelCount, lineCount, showMission)
  self._nodePool:SpawnObjects("UICN20N49LineTalentMapNode", levelCount)
  self._linePool:SpawnObjects("UICN20N49LineTalentMapLine", lineCount)
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

function UICN20N49LineTalentController:_SetContentSize(showMission)
  local width = UIActivityLineMissionHelper.CalcContentWidth(self._line_component, showMission, self._safeAreaSize.x)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
end

function UICN20N49LineTalentController:_SetMainBg(showMission, missionCfgs)
  local width = UIActivityLineMissionHelper.CalcContentWidth(self._line_component, showMission, self._safeAreaSize.x)
  width = math.max(self._safeAreaSize.x, width)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeAreaSize.x - width, 0)
end

function UICN20N49LineTalentController:_OnNodeClick(stageId, isStory)
  if isStory then
    UIActivityLineMissionHelper.EnterStage_Story(self._campaign, self._line_component, stageId, function()
      self:SwitchState(UIStateType.UICN20N49LineTalentController)
    end)
  else
    self:_PlayContentMoveEff(stageId, function()
      self:EnterStage_Battle(self._campaign, self._line_component, stageId)
    end)
  end
end

function UICN20N49LineTalentController:EnterStage_Battle(campaign, component, stageId, isReview)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = UIActivityLineMissionHelper._CheckSerialAutoFightShow(missionCfg.Type, stageId)
  local pointComponent = campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, 1)
  GameGlobal.UIStateManager():ShowDialog("UICN20N49LineTalentStage", stageId, component, self._campaign, ECampaignCN20ComponentID.ECN20_ACTION_POINT)
end

function UICN20N49LineTalentController:_PlayContentMoveEff(stageId, callback)
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

function UICN20N49LineTalentController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UICN20N49LineTalentController:DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN20N49LineTalentController:_AfterUILayerChanged()
end

function UICN20N49LineTalentController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN20N49LineTalentController:_OnComponentClose(componentCfgId)
  local component = self._line_component
  if component and component:GetComponentCfgId() == componentCfgId then
    self:_Back()
  end
end

function UICN20N49LineTalentController:_OnItemChanged(id)
  self:_Refresh()
end

function UICN20N49LineTalentController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UICN20N49LineTalentController)
end
