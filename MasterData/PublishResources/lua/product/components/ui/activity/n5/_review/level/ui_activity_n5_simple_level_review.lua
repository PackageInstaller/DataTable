_class("UIActivityN5SimpleLevelReview", UIController)
UIActivityN5SimpleLevelReview = UIActivityN5SimpleLevelReview

function UIActivityN5SimpleLevelReview:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._lineMissionManager = UIActivityN5LineMissionManager:New()
end

function UIActivityN5SimpleLevelReview:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N5, ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_LINE_MISSION, ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_POINT_PROGRESS)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and res:GetSucc() then
    self._line_component = self._campaign:GetComponent(ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_LINE_MISSION)
    self._line_info = self._line_component:GetComponentInfo()
    local simpleOpenTime = self._line_info.m_unlock_time
    local simpleCloseTime = self._line_info.m_close_time
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    if simpleOpenTime > now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    elseif simpleCloseTime < now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityN5SimpleLevelReview:OnShow(uiParams)
  self._isOpen = true
  if uiParams and uiParams[1] and uiParams[1][2] then
    self._fromMissionResult = uiParams[1][3]
  end
  UIActivityN5SimpleLevel.SLeval = 999
  UIActivityN5SimpleLevel.Passed = 888
  UIActivityN5SimpleLevel.NodeCfg = {
    [DiscoveryStageType.FightNormal] = {
      [1] = {
        normal = "n5_map_normal",
        press = "n5_map_normal1",
        lock = "n5_map_normal1",
        textColor = Color(0 / 255, 0 / 255, 0 / 255),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255),
        normalStar = "n5_map_touming",
        passStar = "n5_map_badge"
      },
      [2] = {
        normal = "n5_map_boss",
        press = "n5_map_boss1",
        lock = "n5_map_boss1",
        textColor = Color(0.8549019607843137, 0.8549019607843137, 0.8549019607843137),
        textShadow = Color(0.8549019607843137, 0.8549019607843137, 0.8549019607843137),
        normalStar = "n5_map_touming",
        passStar = "n5_map_badge"
      }
    },
    [DiscoveryStageType.FightBoss] = {
      [1] = {
        normal = "n5_map_boss",
        press = "n5_map_boss1",
        lock = "n5_map_boss1",
        textColor = Color(0.8549019607843137, 0.8549019607843137, 0.8549019607843137),
        textShadow = Color(0.8549019607843137, 0.8549019607843137, 0.8549019607843137),
        normalStar = "n5_map_touming",
        passStar = "n5_map_badge"
      },
      [2] = {
        normal = "n5_map_boss",
        press = "n5_map_boss1",
        lock = "n5_map_boss1",
        textColor = Color(0.8549019607843137, 0.8549019607843137, 0.8549019607843137),
        textShadow = Color(0.8549019607843137, 0.8549019607843137, 0.8549019607843137),
        normalStar = "n5_map_touming",
        passStar = "n5_map_badge"
      }
    },
    [DiscoveryStageType.Plot] = {
      [1] = {
        normal = "n5_map_plot",
        press = "n5_map_plot1",
        lock = "n5_map_plot1",
        textColor = Color(0 / 255, 0 / 255, 0 / 255),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255)
      },
      [2] = {
        normal = "n5_map_plot",
        press = "n5_map_plot1",
        lock = "n5_map_plot1",
        textColor = Color(0 / 255, 0 / 255, 0 / 255),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255)
      }
    },
    [UIActivityN5SimpleLevel.SLeval] = {
      [1] = {
        normal = "n5_map_normal",
        press = "n5_map_normal1",
        lock = "n5_map_normal1",
        textColor = Color(0 / 255, 0 / 255, 0 / 255),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255),
        normalStar = "n5_map_touming",
        passStar = "n5_map_badge"
      },
      [2] = {
        normal = "n5_map_normal",
        press = "n5_map_normal1",
        lock = "n5_map_normal1",
        textColor = Color(0 / 255, 0 / 255, 0 / 255),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255),
        normalStar = "n5_map_touming",
        passStar = "n5_map_badge"
      }
    }
  }
  self:AttachEvents()
  self:_GetComponents()
  local componentCfgId = self._line_component:GetComponentCfgId()
  self._lineMissionManager:Init(self._line_info, componentCfgId)
  self._lineMissionManager:Update()
  self:Flush()
  self._enterLockName = "UIActivityN5SimpleLevelReview_OnShow"
  self._enterLockTimeEvent = UIActivityHelper.StartLockEvent(self._enterLockName, self._enterLockTimeEvent, nil)
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  local bgNames = {"n5_map_bg", "n5_map_bg2"}
  self._scroller = UIActivityN5Scroller:New(self._contentRect, bgLoader1, bgLoader2, bgNames, self._lineMissionManager:GetScrollSpliterVec())
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
  CutsceneManager.ExcuteCutsceneOut()
end

function UIActivityN5SimpleLevelReview:OnHide()
  UIActivityHelper.CancelLockEvent(self._enterLockName, self._enterLockTimeEvent)
  UIActivityHelper.CancelLockEvent(self._moveLockName, self._moveLockTimeEvent)
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._pointCountdownTimer then
    GameGlobal.Timer():CancelEvent(self._pointCountdownTimer)
    self._pointCountdownTimer = nil
  end
  UIActivityN5SimpleLevelReview.SLeval = nil
  UIActivityN5SimpleLevelReview.NodeCfg = nil
  self._isOpen = false
end

function UIActivityN5SimpleLevelReview:Flush()
  self:FlushPanel()
  self:FlushNodes()
  self:FlushLines()
end

function UIActivityN5SimpleLevelReview:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIActivityN5SimpleLevelReview.super:Dispose()
end

function UIActivityN5SimpleLevelReview:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:_Close()
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._normalNodesPool = self:GetUIComponent("UISelectObjectPath", "NormalNodes")
  self._bossNodesPool = self:GetUIComponent("UISelectObjectPath", "BossNodes")
  self._plotNodesPool = self:GetUIComponent("UISelectObjectPath", "PlotNodes")
  self._slevelNodesPool = self:GetUIComponent("UISelectObjectPath", "SLevelNodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._safeWidth = self:GetUIComponent("RectTransform", "SafeArea").rect.size.x
end

function UIActivityN5SimpleLevelReview:_Close()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5CloseDoor)
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIActivityN5, function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN5MainController_Review, UIStateType.UIMain, nil, self._campaign._id)
  end)
end

function UIActivityN5SimpleLevelReview:FlushPanel()
  local totalWidth = self._lineMissionManager:GetTotalWidth()
  self._contentRect.sizeDelta = Vector2(totalWidth, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeWidth / 2 - totalWidth, 0)
end

function UIActivityN5SimpleLevelReview:FlushNodes()
  local normalNodeCount, bossNodeCount, plotNodeCount, slevelNodeCount = 0, 0, 0, 0
  local normalNodeIndex, bossNodeIndex, plotNodeIndex, slevelNodeIndex = 1, 1, 1, 1
  local missionNodes = self._lineMissionManager:GetNodes()
  for i, node in pairs(missionNodes) do
    if node.isSLevel then
      slevelNodeCount = slevelNodeCount + 1
    elseif node.type == DiscoveryStageType.FightNormal then
      normalNodeCount = normalNodeCount + 1
    elseif node.type == DiscoveryStageType.FightBoss then
      bossNodeCount = bossNodeCount + 1
    else
      plotNodeCount = plotNodeCount + 1
    end
  end
  self._normalNodesPool:SpawnObjects("UIActivityN5MissionNode", normalNodeCount)
  self._bossNodesPool:SpawnObjects("UIActivityN5MissionNode", bossNodeCount)
  self._plotNodesPool:SpawnObjects("UIActivityN5MissionNode", plotNodeCount)
  self._slevelNodesPool:SpawnObjects("UIActivityN5MissionNode", slevelNodeCount)
  local normalNodes = self._normalNodesPool:GetAllSpawnList()
  local bossNodes = self._bossNodesPool:GetAllSpawnList()
  local plotNodes = self._plotNodesPool:GetAllSpawnList()
  local slevelNodes = self._slevelNodesPool:GetAllSpawnList()
  self._uiMapNodes = {}
  for i, node in pairs(missionNodes) do
    local uiNode
    if node.isSLevel then
      uiNode = slevelNodes[slevelNodeIndex]
      slevelNodeIndex = slevelNodeIndex + 1
    elseif node.type == DiscoveryStageType.FightNormal then
      uiNode = normalNodes[normalNodeIndex]
      normalNodeIndex = normalNodeIndex + 1
    elseif node.type == DiscoveryStageType.FightBoss then
      uiNode = bossNodes[bossNodeIndex]
      bossNodeIndex = bossNodeIndex + 1
    else
      uiNode = plotNodes[plotNodeIndex]
      plotNodeIndex = plotNodeIndex + 1
    end
    uiNode:SetData(node, function(stageId, needScroll, trans)
      self:_MoveToStage(stageId, needScroll, trans)
    end, self._fromMissionResult)
    self._uiMapNodes[#self._uiMapNodes + 1] = uiNode
  end
  self._fromMissionResult = nil
end

function UIActivityN5SimpleLevelReview:FlushLines()
  local lines = self._lineMissionManager:GetLines()
  local len = table.count(lines)
  if not lines or len <= 0 then
    return
  end
  self._linesPool:SpawnObjects("UIActivityN5MissionLine", len)
  local spawnLines = self._linesPool:GetAllSpawnList()
  local i = 1
  for k, v in ipairs(lines) do
    local sNode = v[1]
    local eNode = v[2]
    spawnLines[i]:Flush(sNode, eNode, false)
    i = i + 1
  end
end

function UIActivityN5SimpleLevelReview:ShotTest()
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local shotRect = self:GetUIComponent("RectTransform", "screenShot")
  self._width = shotRect.rect.width
  self._height = shotRect.rect.height
  local LeftTop = self:GetGameObject("LeftTop")
  local LeftBottom = self:GetGameObject("LeftBottom")
  local RightTop = self:GetGameObject("RightTop")
  local RightBottom = self:GetGameObject("RightBottom")
  LeftTop:SetActive(false)
  LeftBottom:SetActive(false)
  RightTop:SetActive(false)
  RightBottom:SetActive(false)
  self._shot.width = self._width
  self._shot.height = self._height
  self._shot.blurTimes = 0
  self._shot:CleanRenderTexture()
  self._rt = self._shot:RefreshBlurTexture()
  LeftTop:SetActive(true)
  LeftBottom:SetActive(true)
  RightTop:SetActive(true)
  RightBottom:SetActive(true)
end

function UIActivityN5SimpleLevelReview:_CalcShotOffset(trans)
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local screenPos = camera:WorldToScreenPoint(trans.position)
  return -(Vector2(screenPos.x, screenPos.y) - Vector2(UnityEngine.Screen.width, UnityEngine.Screen.height) / 2)
end

function UIActivityN5SimpleLevelReview:_MoveToStage(stageId, needScroll, trans)
  local pos = self._lineMissionManager:GetScrollPos(stageId).x
  local curPos = self._contentRect.anchoredPosition.x
  local areaWidth = 408
  local halfScreen = self._safeWidth / 2
  local targetPos
  if needScroll then
    if curPos < pos - (halfScreen - areaWidth) then
      targetPos = pos - (halfScreen - areaWidth)
    elseif curPos > pos + (halfScreen - areaWidth) then
      targetPos = pos + (halfScreen - areaWidth)
    end
  end
  if targetPos then
    self._scrollRect:StopMovement()
    if self._tweener then
      self._tweener:Kill()
    end
    local moveTime = 0.5
    self._tweener = self._contentRect:DOAnchorPosX(targetPos, moveTime)
    self._moveLockName = "UIActivityN5SimpleLevelReview_MoveToStage"
    self._moveLockTimeEvent = UIActivityHelper.StartLockEvent(self._moveLockName, self._moveLockTimeEvent, function()
      self:_EnterStage(stageId, trans)
    end, moveTime * 1000)
  else
    self:_EnterStage(stageId, trans)
  end
end

function UIActivityN5SimpleLevelReview:_EnterStage(stageId, trans)
  local nodes = self._lineMissionManager:GetNodes()
  local node = nodes[stageId]
  local stageType = node.type
  if stageType == DiscoveryStageType.Plot then
    self:CloseUIStage()
    local titleId = StringTable.Get(node.title)
    local titleName = StringTable.Get(node.name)
    local storyId = self._missionModule:GetStoryByStageIdStoryType(stageId, StoryTriggerType.Node)
    self:ShowDialog("UIActivityPlotEnter", titleId, titleName, storyId, function()
      self:PlotEndCallback(stageId)
    end)
  else
    local passInfo = self._line_info.m_pass_mission_info[stageId]
    self:ShowDialog("UIActivityLevelStageNew", stageId, passInfo, self._line_component, false, nil, true, true)
  end
end

function UIActivityN5SimpleLevelReview:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIActivityN5SimpleLevelReview:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIActivityN5SimpleLevelReview:PlotEndCallback(stageId)
  local isActive = self._line_component:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self:StartTask(function(TT)
    self._line_component:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self._line_component:HandleCompleteStoryMission(TT, res, stageId)
    if not res:GetSucc() then
      local campaignModule = self:GetModule(CampaignModule)
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    elseif table.count(award) ~= 0 then
      self:ShowDialog("UIGetItemController", award, function()
        self:SwitchState(UIStateType.UIActivityN5SimpleLevelReview)
      end)
    else
      self:SwitchState(UIStateType.UIActivityN5SimpleLevelReview)
    end
  end, self)
end

function UIActivityN5SimpleLevelReview:CloseUIStage()
  if GameGlobal.UIStateManager():IsShow("UIActivityN5Stage") then
    GameGlobal.UIStateManager():CloseDialog("UIActivityN5Stage")
  end
end

function UIActivityN5SimpleLevelReview:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityN5SimpleLevelReview:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN5SimpleLevelReview:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end

function UIActivityN5SimpleLevelReview:_OnCampaignShopEnter()
  self:CloseDialog()
end

function UIActivityN5SimpleLevelReview:_ShowUIGetItemController(rewards)
  self:ShowDialog("UIGetItemController", rewards, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
  end)
end
