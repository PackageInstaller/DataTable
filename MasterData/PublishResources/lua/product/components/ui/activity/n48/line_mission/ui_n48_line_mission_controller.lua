_class("UIN48LineMissionController", UIController)
UIN48LineMissionController = UIN48LineMissionController

function UIN48LineMissionController:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UIN48LineMissionController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N48
  self._componentId_LineMission = UIActivityN48Helper.GetComponentId("line")
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId_LineMission)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and res:GetSucc() then
    self._line_component = self._campaign:GetComponent(self._componentId_LineMission)
    self._raffle_cpt = self._campaign:GetComponent(UIActivityN48Helper.GetComponentId("shop"))
    self._line_info = self._line_component:GetComponentInfo()
    self._raffle_info = self._campaign:GetComponentInfo(UIActivityN48Helper.GetComponentId("shop"))
    if not self._campaign:CheckComponentOpen(self._componentId_LineMission) then
      res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId_LineMission)
      self._campModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  self._process = self._campModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N48)
end

function UIN48LineMissionController:OnShow(uiParams)
  self:_OnValue(uiParams)
  self:_AttachEvents()
  self:_GetComponents()
  self:_Refresh()
  self:_OnShow()
end

function UIN48LineMissionController:_OnValue(uiParams)
  self._timerHolder = UITimerHolder:New()
  UIN48LineMissionController.SLeval = 999
  UIN48LineMissionController.Passed = 888
  UIN48LineMissionController.NodeCfg = {
    [DiscoveryStageType.FightNormal] = {
      [1] = {
        normal = "n48_xxg_di01",
        press = "n48_xxg_di01",
        lock = "",
        textColor = Color(1.0, 0.8705882352941177, 0 / 255),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255),
        normalStar = "n48_xxg_di05",
        passStar = "n48_xxg_di06"
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(0.9764705882352941, 1.0, 0.3803921568627451),
        textShadow = Color(0.7490196078431373, 0.20392156862745098, 0.09803921568627451),
        normalStar = "",
        passStar = ""
      }
    },
    [DiscoveryStageType.FightBoss] = {
      [1] = {
        normal = "n48_xxg_di03",
        press = "n48_xxg_di03",
        lock = "",
        textColor = Color(1.0, 0.3843137254901961, 0.24313725490196078),
        textShadow = Color(1.0, 1.0, 1.0),
        normalStar = "n48_xxg_di05",
        passStar = "n48_xxg_di06"
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.9333333333333333, 0 / 255, 0.13333333333333333),
        normalStar = "",
        passStar = ""
      }
    },
    [DiscoveryStageType.Plot] = {
      [1] = {
        normal = "n48_xxg_di02",
        press = "n48_xxg_di02",
        lock = "",
        textColor = Color(0.8196078431372549, 0.8196078431372549, 0.8196078431372549),
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
    [UIN48LineMissionController.SLeval] = {
      [1] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "",
        passStar = ""
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "",
        passStar = ""
      }
    }
  }
end

function UIN48LineMissionController:_OnShow()
  self:_RefreshMoney()
  local lockName = "UIActivity_LineMissionController_Enter"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
end

function UIN48LineMissionController:_RefreshMoney()
  local itemId = self._raffle_cpt:GetCostItemId()
  local count = ClientCampaignDrawShop.GetMoney(itemId)
  self._raffle_token_ii:SetText(count)
end

function UIN48LineMissionController:_SetRemainingTime(widgetName, descId, endTime, tickCallback, stopCallback)
  if not self._txt_desc then
    self._txt_desc = self:GetUIComponent("UILocalizationText", "_txt_desc")
  end
  local str = "str_n48_remain_time_in_activity"
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local endtime = endTime
  remainTime = endtime - curtime
  if remainTime < 0 then
    self._txt_desc:SetText(StringTable.Get("str_n48_activity_end"))
  else
    self._txt_desc:SetText(StringTable.Get(str, N48ToolFunctions.GetRemainTime(remainTime)))
  end
end

function UIN48LineMissionController:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN48MainController, UIStateType.UIMain, {true}, self._campaign._id)
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
  self._pressup = self:GetUIComponent("RawImage", "_pressup")
  self._pressdown = self:GetUIComponent("RawImage", "_pressdown")
  self._BtnBg = {}
  self._BtnBg[self._pressup.name] = self._pressup
  self._BtnBg[self._pressdown.name] = self._pressdown
  self._pressdown.enabled = false
  self._drawText = self:GetUIComponent("UILocalizedTMP", "DrawText")
  self._raffle_token_ii = self:GetUIComponent("UILocalizationText", "_raffle_token_ii")
end

function UIN48LineMissionController:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  UIActivityHelper.CancelTimerEvent(self._timeEvent)
  UIN48LineMissionController.SLeval = nil
  UIN48LineMissionController.NodeCfg = nil
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIN48LineMissionController.super:Dispose()
end

function UIN48LineMissionController:_Refresh()
  self:FlushNodes()
  self:_StartTimer()
end

function UIN48LineMissionController:_StartTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetTimeInfo()
  end)
end

function UIN48LineMissionController:_IsOver()
  local endTime = self._line_component:GetComponentInfo().m_close_time
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  return endTime - curtime < 0
end

function UIN48LineMissionController:_SetTimeInfo()
  local endTime = self._line_component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_remainingTimePool", nil, endTime)
  local shop_new = self._process:GetLottleryNew()
  self:GetGameObject("new"):SetActive(shop_new)
  self:GetGameObject("red"):SetActive(false)
end

function UIN48LineMissionController:_SetPetTryout_red(isshow)
  local pettry_red = self:GetGameObject("_pettry_red")
  pettry_red:SetActive(isshow)
end

function UIN48LineMissionController:FlushNodes()
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
  self._nodesPool:SpawnObjects("UIN48LineMissionMapNode", levelCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  self._linesPool:SpawnObjects("UIN48LineMissionMapLine", lineCount)
  local lines = self._linesPool:GetAllSpawnList()
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetData(cfg, self._line_info.m_pass_mission_info[missionID], function(stageId, isStory, worldPos)
      self:_onNodeClick(stageId, isStory, worldPos)
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
  self._allMissionCfgs = missionCfgs
end

function UIN48LineMissionController:_onNodeClick(stageId, isStory, worldPos)
  if self:_IsOver() then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    self:SwitchState(UIStateType.UIN48MainController)
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

function UIN48LineMissionController:_EnterStage(stageId, worldPos)
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
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, nil, nil, nil, true)
end

function UIN48LineMissionController:PlotEndCallback(stageId)
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
        self:SwitchState(UIStateType.UIN48LineMissionController)
      end)
    else
      self:SwitchState(UIStateType.UIN48LineMissionController)
    end
  end, self)
end

function UIN48LineMissionController:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIN48LineMissionController:_OnAfterUILayerChanged()
  self:_RefreshMoney()
end

function UIN48LineMissionController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UIN48LineMissionController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN48LineMissionController:TryoutBtnOnClick(go)
  local componentId = self._componentId_LineMissionFixteam
  local component = self._campaign:GetComponent(componentId)
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
end

function UIN48LineMissionController:DrawBtnOnClick(go)
  if not self._raffle_info.m_b_unlock then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    return
  end
  if not self._campaign:CheckCampaignOpen() then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self._process:ClearLottleryNew()
  UIActivityHelper.OpenCampaignShop(self._campaign)
end
