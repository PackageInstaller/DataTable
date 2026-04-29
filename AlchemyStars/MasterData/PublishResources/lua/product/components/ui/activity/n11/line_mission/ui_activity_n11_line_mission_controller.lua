_class("UIActivityN11LineMissionController", UIController)
UIActivityN11LineMissionController = UIActivityN11LineMissionController

function UIActivityN11LineMissionController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN11LineMissionController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIActivityN11LineMissionController:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN11LineMissionController:_SetText(widgetName, str)
  widgetName = widgetName or "text"
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(str)
end

function UIActivityN11LineMissionController:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
end

function UIActivityN11LineMissionController:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN11Main, UIStateType.UIMain, nil, self._campaign._id)
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._shot.width = self._safeAreaSize.x
  self._shot.height = self._safeAreaSize.y
end

function UIActivityN11LineMissionController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N11
  self._componentId_LineMission = ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON
  self._componentId_LineMissionFixteam = ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_FIXTEAM
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId_LineMission, self._componentId_LineMissionFixteam)
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

function UIActivityN11LineMissionController:OnShow(uiParams)
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  UIActivityN11LineMissionController.SLeval = 111111
  UIActivityN11LineMissionController.Passed = 888
  UIActivityN11LineMissionController.NodeCfg = {
    [DiscoveryStageType.FightNormal] = {
      [1] = {
        normal = "n11_xxg_normal",
        press = "n11_xxg_normal_click",
        lock = "",
        textColor = Color(0.21568627450980393, 0.21176470588235294, 0.19607843137254902),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255),
        normalStar = "",
        passStar = "n11_xxg_star"
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(0.9450980392156862, 1.0, 0.4588235294117647),
        textShadow = Color(0.43529411764705883, 0.20392156862745098, 0.09803921568627451),
        normalStar = "",
        passStar = ""
      }
    },
    [DiscoveryStageType.FightBoss] = {
      [1] = {
        normal = "n11_xxg_boss",
        press = "n11_xxg_boss_click",
        lock = "",
        textColor = Color.New(1.0, 0.27450980392156865, 0.22745098039215686),
        textShadow = Color.New(1.0, 1.0, 1.0),
        normalStar = "",
        passStar = "n11_xxg_star"
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color.New(1.0, 1.0, 1.0),
        textShadow = Color.New(0.9333333333333333, 0 / 255, 0.13333333333333333),
        normalStar = "",
        passStar = ""
      }
    },
    [DiscoveryStageType.Plot] = {
      [1] = {
        normal = "n11_xxg_plot",
        press = "n11_xxg_plot_click",
        lock = "",
        textColor = Color.New(1.0, 0.8862745098039215, 0.25098039215686274),
        textShadow = Color.New(0 / 255, 0 / 255, 0 / 255)
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color.New(0.9450980392156862, 1.0, 0.4588235294117647),
        textShadow = Color.New(0.43529411764705883, 0.20392156862745098, 0.09803921568627451)
      }
    },
    [UIActivityN11LineMissionController.SLeval] = {
      [1] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color.New(1.0, 1.0, 1.0),
        textShadow = Color.New(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "",
        passStar = ""
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color.New(1.0, 1.0, 1.0),
        textShadow = Color.New(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "",
        passStar = ""
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

function UIActivityN11LineMissionController:OnHide()
  UIActivityN11LineMissionController.SLeval = nil
  UIActivityN11LineMissionController.NodeCfg = nil
  self._isOpen = false
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIActivityN11LineMissionController.super:Dispose()
  self._scroller:Dispose()
  self:DetachEvents()
end

function UIActivityN11LineMissionController:_Refresh()
  self:FlushNodes()
  self:_SetTimeInfo()
  self:_SetActionPoint()
  self:_SetTryoutBtn()
  self:_SetExchangeBtn()
end

function UIActivityN11LineMissionController:_SetTimeInfo()
  local endTime = self._line_component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_remainingTimePool", nil, endTime)
end

function UIActivityN11LineMissionController:_SetActionPoint()
  local componentId = ECampaignN11ComponentID.ECAMPAIGN_N11_ACTION_POINT
  local component = self._campaign:GetComponent(componentId)
  local icon = component:GetItemReplaceIcon()
  if icon then
    self:_SetIcon("_iconActionPoint", icon)
  end
  local n1, n2 = component:GetItemCount()
  self:_SetText("_txtActionPoint", n1 .. "/" .. n2)
  local endTime = component:GetRegainEndTime()
  self:_SetRemainingTime("_actionPointPool", nil, endTime)
  local state_time = self:GetGameObject("state_time")
  local state_max = self:GetGameObject("state_max")
  state_time:SetActive(n1 < n2)
  state_max:SetActive(n2 <= n1)
end

function UIActivityN11LineMissionController:_SetTryoutBtn()
  local componentId = self._componentId_LineMissionFixteam
  local redDotModule = GameGlobal.GetModule(RedDotModule)
  local obj = self:_SpawnObject("_tryoutBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed("red", function()
    return redDotModule:_RequestRedDotStatus4N11(RedDotType.RDT_N11_FIXLINEMISSION)
  end)
  local component = self._campaign:GetComponent(componentId)
  obj:SetData(self._campaign, componentId, function()
    self:ShowDialog("UIActivityPetTryController", self._campaignType, componentId, function(mid)
      return component:IsPassCamMissionID(mid)
    end, function(missionid)
      local ctx = self._missionModule:TeamCtx()
      local missionComponent = self._campaign:GetComponent(componentId)
      local param = {
        missionid,
        missionComponent:GetCampaignMissionComponentId(),
        missionComponent:GetCampaignMissionParamKeyMap()
      }
      ctx:Init(TeamOpenerType.Campaign, param)
      ctx:ShowDialogUITeams(false)
    end)
  end)
end

function UIActivityN11LineMissionController:_SetExchangeBtn()
  local componentId = ECampaignN11ComponentID.ECAMPAIGN_N11_SHOP
  local obj = self:_SpawnObject("_exchangeBtn", "UIActivityCommonComponentEnter")
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId) and self._campaign:CheckComponentRed(componentId)
  end)
  local component = self._campaign:GetComponent(componentId)
  local icon, count = component:GetCostItemIconText()
  if icon then
    obj:SetIcon("icon", icon)
  end
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#545454>%s</color><color=#f2c641>%s</color>", preZero, tostring(count))
  obj:SetText("text", fmtStr)
  obj:SetData(self._campaign, function()
    ClientCampaignShop.OpenCampaignShop(self._campaign._type, self._campaign._id, function()
      self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIActivityN11LineMissionController, UIStateType.UIMain, nil, self._campaign._id, componentId)
    end)
  end)
end

function UIActivityN11LineMissionController:FlushNodes()
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
  self._nodesPool:SpawnObjects("UIActivityN11LineMissionMapNode", levelCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  self._linesPool:SpawnObjects("UIActivityN11LineMissionMapLine", lineCount)
  local lines = self._linesPool:GetAllSpawnList()
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetData(cfg, self._line_info.m_pass_mission_info[missionID], function(stageId, isStory, worldPos)
      self:_onNodeClick(stageId, isStory, worldPos)
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
  local sp1, sp2 = 8, 12
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._scroller = UILevelScroller:New(self._contentRect, bgLoader1, bgLoader2, {
    "n11_xxg_bg1",
    "n11_xxg_bg2"
  }, {
    posx[sp1],
    posx[sp1 + 1],
    posx[sp2]
  })
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
  self._allMissionCfgs = missionCfgs
end

function UIActivityN11LineMissionController:_onNodeClick(stageId, isStory, worldPos)
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
    local _moveTime = 0.5
    self._tweener = self._contentRect:DOAnchorPosX(targetPos, _moveTime)
    local moveLockName = "UIActivityLineMissionController_MoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, _moveTime * 1000, function()
      self:UnLock(moveLockName)
      self:_EnterStage(stageId, worldPos)
    end)
  else
    self:_EnterStage(stageId, worldPos)
  end
end

function UIActivityN11LineMissionController:_EnterStage(stageId, worldPos)
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
  self:ShowDialog("UIActivityLevelStage", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, rt, offset, self._safeAreaSize.x, self._safeAreaSize.y, scale, autoFightShow, pointComponent)
end

function UIActivityN11LineMissionController:PlotEndCallback(stageId)
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
        self:SwitchState(UIStateType.UIActivityN11LineMissionController)
      end)
    else
      self:SwitchState(UIStateType.UIActivityN11LineMissionController)
    end
  end, self)
end

function UIActivityN11LineMissionController:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIActivityN11LineMissionController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIActivityN11LineMissionController:ActionPointBtnOnClick(go)
  local componentId = ECampaignN11ComponentID.ECAMPAIGN_N11_ACTION_POINT
  local component = self._campaign:GetComponent(componentId)
  self:ShowDialog("UIActivityN11ActionPointDetail", component:GetItemReplaceIcon())
end

function UIActivityN11LineMissionController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityN11LineMissionController:DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityN11LineMissionController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN11LineMissionController:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end
