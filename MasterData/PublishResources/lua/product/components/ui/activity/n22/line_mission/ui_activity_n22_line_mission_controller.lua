_class("UIActivityN22LineMissionController", UIController)
UIActivityN22LineMissionController = UIActivityN22LineMissionController

function UIActivityN22LineMissionController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN22LineMissionController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  local timecolor = {
    day = "str_n22_reset_time_day",
    hour = "str_n22_reset_time_hour",
    min = "str_n22_reset_time_min",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  obj:SetCustomTimeStr_Common_1()
  obj:SetCustomTimeStr(timecolor)
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIActivityN22LineMissionController:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN22LineMissionController:_SetText(widgetName, str)
  widgetName = widgetName or "text"
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(str)
end

function UIActivityN22LineMissionController:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
end

function UIActivityN22LineMissionController:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN22MainController, UIStateType.UIMain, nil, self._campaign._id)
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

function UIActivityN22LineMissionController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N22
  self._componentId_LineMission = ECampaignN22ComponentID.ECAMPAIGN_N22_LINE_MISSION
  self._componentId_LineMissionFixteam = ECampaignN22ComponentID.ECAMPAIGN_N22_FIRST_MEET
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

function UIActivityN22LineMissionController:OnShow(uiParams)
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  UIActivityN22LineMissionController.SLeval = 111111
  UIActivityN22LineMissionController.Passed = 888
  UIActivityN22LineMissionController.NodeCfg = {
    [DiscoveryStageType.FightNormal] = {
      [1] = {
        normal = "n22_xxg_spot1",
        press = "",
        lock = "",
        textColor = Color(0.48627450980392156, 0.3411764705882353, 0.23529411764705882),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255),
        normalStar = "n22_xxg_star0",
        passStar = "n22_xxg_star1"
      },
      [2] = {
        normal = "n22_xxg_spot1",
        press = "",
        lock = "",
        textColor = Color(0.9450980392156862, 1.0, 0.4588235294117647),
        textShadow = Color(0.43529411764705883, 0.20392156862745098, 0.09803921568627451),
        normalStar = "n22_xxg_star0",
        passStar = "n22_xxg_star1"
      }
    },
    [DiscoveryStageType.FightBoss] = {
      [1] = {
        normal = "n22_xxg_spot2",
        press = "",
        lock = "",
        textColor = Color.New(0.5843137254901961, 0.08627450980392157, 0.07450980392156863),
        textShadow = Color.New(1.0, 1.0, 1.0),
        normalStar = "n22_xxg_star0",
        passStar = "n22_xxg_star1"
      },
      [2] = {
        normal = "n22_xxg_spot2",
        press = "",
        lock = "",
        textColor = Color.New(1.0, 1.0, 1.0),
        textShadow = Color.New(0.9333333333333333, 0 / 255, 0.13333333333333333),
        normalStar = "n22_xxg_star0",
        passStar = "n22_xxg_star1"
      }
    },
    [DiscoveryStageType.Plot] = {
      [1] = {
        normal = "n22_xxg_spot3",
        press = "n22_xxg_plot_click",
        lock = "",
        textColor = Color.New(0.2823529411764706, 0.1607843137254902, 0.1607843137254902),
        textShadow = Color.New(0 / 255, 0 / 255, 0 / 255)
      },
      [2] = {
        normal = "n22_xxg_spot3",
        press = "",
        lock = "",
        textColor = Color.New(0.9450980392156862, 1.0, 0.4588235294117647),
        textShadow = Color.New(0.43529411764705883, 0.20392156862745098, 0.09803921568627451)
      }
    },
    [UIActivityN22LineMissionController.SLeval] = {
      [1] = {
        normal = "n22_xxg_spot4",
        press = "",
        lock = "",
        textColor = Color.New(1.0, 1.0, 1.0),
        textShadow = Color.New(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "n22_xxg_star0",
        passStar = "n22_xxg_star1"
      },
      [2] = {
        normal = "n22_xxg_spot4",
        press = "",
        lock = "",
        textColor = Color.New(1.0, 1.0, 1.0),
        textShadow = Color.New(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "n22_xxg_star0",
        passStar = "n22_xxg_star1"
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

function UIActivityN22LineMissionController:OnHide()
  UIActivityN22LineMissionController.SLeval = nil
  UIActivityN22LineMissionController.NodeCfg = nil
  self._isOpen = false
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIActivityN22LineMissionController.super:Dispose()
  self._scroller:Dispose()
  self:DetachEvents()
end

function UIActivityN22LineMissionController:_Refresh()
  self:FlushNodes()
  self:_SetTimeInfo()
  self:_SetTryoutBtn()
  self:_SetExchangeBtn()
end

function UIActivityN22LineMissionController:_SetTimeInfo()
  local endTime = self._line_component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_remainingTimePool", "", endTime)
end

function UIActivityN22LineMissionController:_SetActionPoint()
  local componentId = ECampaignN22ComponentID.ECAMPAIGN_N22_ACTION_POINT
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

function UIActivityN22LineMissionController:_SetTryoutBtn()
  local componentId = self._componentId_LineMissionFixteam
  local obj = self:_SpawnObject("_tryoutBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed("red", function()
    return self._campaign:GetLocalProcess():GetFixMissionRedDot()
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

function UIActivityN22LineMissionController:_SetExchangeBtn()
  local componentId = ECampaignN22ComponentID.ECAMPAIGN_N22_SHOP
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
  obj:SetText("txtNum", fmtStr)
  obj:SetData(self._campaign, function()
    ClientCampaignShop.OpenCampaignShop(self._campaign._type, self._campaign._id, function()
      self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIActivityN22LineMissionController, UIStateType.UIMain, nil, self._campaign._id, componentId)
    end)
  end)
end

function UIActivityN22LineMissionController:FlushNodes()
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
  self._nodesPool:SpawnObjects("UIActivityN22LineMissionMapNode", levelCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  self._linesPool:SpawnObjects("UIActivityN22LineMissionMapLine", lineCount)
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
  self._scroller = UILevelScroller:New(self._contentRect, bgLoader1, bgLoader2, {"n22_xxg_bg", "n22_xxg_bg"}, {
    posx[sp1],
    posx[sp1 + 1],
    posx[sp2]
  })
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
  self._allMissionCfgs = missionCfgs
end

function UIActivityN22LineMissionController:_OnNodeClick(stageId, isStory, worldPos)
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

function UIActivityN22LineMissionController:_EnterStage(stageId, worldPos)
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._shot:CleanRenderTexture()
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, stageId)
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, autoFightShow, nil)
end

function UIActivityN22LineMissionController:PlotEndCallback(stageId)
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
        self:SwitchState(UIStateType.UIActivityN22LineMissionController)
      end)
    else
      self:SwitchState(UIStateType.UIActivityN22LineMissionController)
    end
  end, self)
end

function UIActivityN22LineMissionController:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIActivityN22LineMissionController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIActivityN22LineMissionController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityN22LineMissionController:DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityN22LineMissionController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN22LineMissionController:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end
