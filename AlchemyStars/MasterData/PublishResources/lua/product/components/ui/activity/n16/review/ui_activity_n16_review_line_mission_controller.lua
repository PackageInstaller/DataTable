_class("UIActivityN16ReviewLineMissionController", UIController)
UIActivityN16ReviewLineMissionController = UIActivityN16ReviewLineMissionController

function UIActivityN16ReviewLineMissionController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN16ReviewLineMissionController:_SetRemainingTime(widgetName, descId, endTime, tickCallback, stopCallback)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UIActivityN16ReviewLineMissionController:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN16ReviewLineMissionController:_SetText(widgetName, str)
  widgetName = widgetName or "text"
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(str)
end

function UIActivityN16ReviewLineMissionController:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
end

function UIActivityN16ReviewLineMissionController:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN16ReviewMainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, nil)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._shot.width = self._safeAreaSize.x
  self._shot.height = self._safeAreaSize.y
  self._atlas = self:GetAsset("UIN16.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityN16ReviewLineMissionController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_REVIEW_N16
  self._componentId_LineMission = ECampaignReviewN16ComponentID.ECAMPAIGN_REVIEW_ReviewN16_LINE_MISSION
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId_LineMission)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  if res and res:GetSucc() then
    self._line_component = self._campaign:GetComponent(self._componentId_LineMission)
    self._line_info = self._line_component:GetComponentInfo()
    if not self._campaign:CheckComponentOpen(self._componentId_LineMission) then
      res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId_LineMission)
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityN16ReviewLineMissionController:OnShow(uiParams)
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  UIActivityN16ReviewLineMissionController.SLeval = 999
  UIActivityN16ReviewLineMissionController.Passed = 888
  UIActivityN16ReviewLineMissionController.NodeCfg = {
    [DiscoveryStageType.FightNormal] = {
      [1] = {
        normal = "n16_xxg_btn01",
        press = "",
        lock = "",
        textColor = Color(0.0392156862745098, 0.043137254901960784, 0.047058823529411764),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255),
        normalStar = "n16_xxg_xin01",
        passStar = "n16_xxg_xin02"
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(0.9764705882352941, 1.0, 0.3803921568627451),
        textShadow = Color(0.7490196078431373, 0.20392156862745098, 0.09803921568627451),
        normalStar = "n16_xxg_xin01",
        passStar = "n16_xxg_xin02"
      }
    },
    [DiscoveryStageType.FightBoss] = {
      [1] = {
        normal = "n16_xxg_btn04",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(1.0, 1.0, 1.0),
        normalStar = "n16_xxg_xin01",
        passStar = "n16_xxg_xin02"
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.9333333333333333, 0 / 255, 0.13333333333333333),
        normalStar = "n16_xxg_xin01",
        passStar = "n16_xxg_xin02"
      }
    },
    [DiscoveryStageType.Plot] = {
      [1] = {
        normal = "n16_xxg_btn02",
        press = "",
        lock = "",
        textColor = Color(0.0392156862745098, 0.043137254901960784, 0.047058823529411764),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255)
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(0.9764705882352941, 1.0, 0.3803921568627451),
        textShadow = Color(0.7490196078431373, 0.20392156862745098, 0.09803921568627451)
      }
    },
    [UIActivityN16ReviewLineMissionController.SLeval] = {
      [1] = {
        normal = "n16_xxg_btn04",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "n16_xxg_xin01",
        passStar = "n16_xxg_xin02"
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "n16_xxg_xin01",
        passStar = "n16_xxg_xin02"
      }
    }
  }
  self:AttachEvents()
  self:InitWidget()
  self:_Refresh()
  local lockName = "UIActivity_LineMissionController_Enter"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
end

function UIActivityN16ReviewLineMissionController:OnHide()
  UIActivityN16ReviewLineMissionController.SLeval = nil
  UIActivityN16ReviewLineMissionController.NodeCfg = nil
  self._isOpen = false
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIActivityN16ReviewLineMissionController.super:Dispose()
  self._scroller:Dispose()
end

function UIActivityN16ReviewLineMissionController:_Refresh()
  self:FlushNodes()
end

function UIActivityN16ReviewLineMissionController:_SetActionPoint()
  local componentId = ECampaignN16ComponentID.ECAMPAIGN_N16_ACTION_POINT
  local component = self._campaign:GetComponent(componentId)
  local n1, n2 = component:GetItemCount()
  self:_SetText("_txtActionPoint", n1 .. "/" .. n2)
  local state_time = self:GetGameObject("state_time")
  local state_max = self:GetGameObject("state_max")
  state_time:SetActive(n1 < n2)
  state_max:SetActive(n2 <= n1)
end

function UIActivityN16ReviewLineMissionController:_ReloadAndRefreshActionPoint()
  Log.info("UIActivityN16ReviewLineMissionController:_ReloadAndRefreshActionPoint()")
  self:StartTask(function(TT)
    YIELD(1)
    local res = AsyncRequestRes:New()
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self:_SetActionPoint()
  end, self)
end

function UIActivityN16ReviewLineMissionController:FlushNodes()
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
  self._nodesPool:SpawnObjects("UIActivityN16ReviewLineMissionMapNode", levelCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  self._linesPool:SpawnObjects("UIActivityN16LineMissionMapLine", lineCount)
  local lines = self._linesPool:GetAllSpawnList()
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
      line:Flush(Vector2(n2.MapPosX, n2.MapPosY), Vector2(n1.MapPosX, n1.MapPosY), cfg, self._atlas)
      lineIdx = lineIdx + 1
    end
  end
  local right = -99999999
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
  local sp1, sp2 = 6, 12
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._scroller = UILevelScroller:New(self._contentRect, bgLoader1, bgLoader2, {
    "n16_xxg_bj01",
    "n16_xxg_bj02",
    "n16_xxg_bj03"
  }, {
    posx[sp1],
    posx[sp1 + 1],
    posx[sp2],
    posx[sp2 + 1]
  })
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
  self._allMissionCfgs = missionCfgs
end

function UIActivityN16ReviewLineMissionController:_OnNodeClick(stageId, isStory, worldPos)
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
    local moveLockName = "UIActivityLineMissionController_MoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, moveTime * 1000, function()
      self:UnLock(moveLockName)
      self:_EnterStage(stageId, worldPos)
    end)
  else
    self:_EnterStage(stageId, worldPos)
  end
end

function UIActivityN16ReviewLineMissionController:_EnterStage(stageId, worldPos)
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._shot:CleanRenderTexture()
  local rt = self._shot:RefreshBlurTexture()
  local scale = 1.3
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local offset = -(Vector2(screenPos.x, screenPos.y) - Vector2(UnityEngine.Screen.width, UnityEngine.Screen.height) / 2)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, stageId)
  local pointComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, 1)
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, autoFightShow, pointComponent)
end

function UIActivityN16ReviewLineMissionController:PlotEndCallback(stageId)
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
        self:SwitchState(UIStateType.UIActivityN16ReviewLineMissionController)
      end)
    else
      self:SwitchState(UIStateType.UIActivityN16ReviewLineMissionController)
    end
  end, self)
end

function UIActivityN16ReviewLineMissionController:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIActivityN16ReviewLineMissionController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIActivityN16ReviewLineMissionController:AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityN16ReviewLineMissionController:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end
