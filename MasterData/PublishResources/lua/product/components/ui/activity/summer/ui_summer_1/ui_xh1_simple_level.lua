_class("UIXH1SimpleLevel", UIController)
UIXH1SimpleLevel = UIXH1SimpleLevel

function UIXH1SimpleLevel:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._lineMissionManager = UIXH1LineMissionManager:New()
end

function UIXH1SimpleLevel:LoadDataOnEnter(TT, res, uiParams)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SUMMER_I)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  if res and res:GetSucc() then
    self._line_component = self._campaign:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_COMMON)
    self._line_info = self._line_component:GetComponentInfo()
    local simpleOpenTime = self._line_info.m_unlock_time
    local simpleCloseTime = self._line_info.m_close_time
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    if simpleOpenTime > now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
      self._campModule:ShowErrorToast(res.m_result, true)
      return
    elseif simpleCloseTime < now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
      self._campModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIXH1SimpleLevel:OnShow(uiParams)
  self._isOpen = true
  UIXH1SimpleLevel.SLeval = 999
  UIXH1SimpleLevel.Passed = 888
  UIXH1SimpleLevel.NodeCfg = {
    [DiscoveryStageType.FightNormal] = {
      [1] = {
        normal = "summer_ludian_btn1",
        press = "summer_ludian_btn3",
        lock = "summer_ludian_btn4",
        textColor = Color(0.9764705882352941, 1.0, 0.3803921568627451),
        textShadow = Color(0.7490196078431373, 0.20392156862745098, 0.09803921568627451),
        normalStar = "summer_ludian_icon1",
        passStar = "summer_ludian_icon2"
      },
      [2] = {
        normal = "summer_ludian_btn17",
        press = "summer_ludian_btn18-1",
        lock = "summer_ludian_btn18-2",
        textColor = Color(0.9764705882352941, 1.0, 0.3803921568627451),
        textShadow = Color(0.7490196078431373, 0.20392156862745098, 0.09803921568627451),
        normalStar = "summer_ludian_icon1-2",
        passStar = "summer_ludian_icon2"
      }
    },
    [DiscoveryStageType.FightBoss] = {
      [1] = {
        normal = "summer_ludian_btn13",
        press = "summer_ludian_btn15",
        lock = "summer_ludian_btn16",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.9333333333333333, 0 / 255, 0.13333333333333333),
        normalStar = "summer_ludian_icon1",
        passStar = "summer_ludian_icon2"
      },
      [2] = {
        normal = "summer_ludian_btn23",
        press = "summer_ludian_btn25",
        lock = "summer_ludian_btn26",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.9333333333333333, 0 / 255, 0.13333333333333333),
        normalStar = "summer_ludian_icon1-3",
        passStar = "summer_ludian_icon2"
      }
    },
    [DiscoveryStageType.Plot] = {
      [1] = {
        normal = "summer_ludian_btn5",
        press = "summer_ludian_btn7",
        lock = "summer_ludian_btn8",
        textColor = Color(0.9764705882352941, 1.0, 0.3803921568627451),
        textShadow = Color(0.7490196078431373, 0.20392156862745098, 0.09803921568627451)
      },
      [2] = {
        normal = "summer_ludian_btn19",
        press = "summer_ludian_btn20-1",
        lock = "summer_ludian_btn20-2",
        textColor = Color(0.9764705882352941, 1.0, 0.3803921568627451),
        textShadow = Color(0.7490196078431373, 0.20392156862745098, 0.09803921568627451)
      }
    },
    [UIXH1SimpleLevel.SLeval] = {
      [1] = {
        normal = "summer_ludian_btn9",
        press = "summer_ludian_btn11",
        lock = "summer_ludian_btn12",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "summer_ludian_icon1-2",
        passStar = "summer_ludian_icon2"
      },
      [2] = {
        normal = "summer_ludian_btn21",
        press = "summer_ludian_btn22-1",
        lock = "summer_ludian_btn22-2",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "summer_ludian_icon1",
        passStar = "summer_ludian_icon2"
      }
    }
  }
  self:AttachEvents()
  self:_GetComponents()
  local componentCfgId = self._line_component:GetComponetCfgId(self._line_info.m_campaign_id, self._line_info.m_component_id)
  self._lineMissionManager:Init(self._line_info, componentCfgId)
  self._lineMissionManager:Update()
  self:Flush()
  self._enterLockName = "UIXH1SimpleLevel_OnShow"
  self._enterLockTimeEvent = UIActivityHelper.StartLockEvent(self._enterLockName, self._enterLockTimeEvent, nil)
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._scroller = UIXH1Scroller:New(self._contentRect, bgLoader1, bgLoader2, self._lineMissionManager:GetScrollSpliter())
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
end

function UIXH1SimpleLevel:OnHide()
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
  UIXH1SimpleLevel.SLeval = nil
  UIXH1SimpleLevel.NodeCfg = nil
  self._isOpen = false
end

function UIXH1SimpleLevel:Flush()
  self:FlushPanel()
  self:FlushNodes()
  self:FlushLines()
  self:RefreshCountdown()
  self:RefreshTryout()
  self:RefreshPower()
end

function UIXH1SimpleLevel:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIXH1SimpleLevel.super:Dispose()
end

function UIXH1SimpleLevel:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self._campModule:CampaignSwitchState(true, UIStateType.UISummer1, UIStateType.UIMain, nil, self._campaign._id)
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._coin = self:GetUIComponent("UILocalizationText", "Coin")
  self:RefreshShopCount()
  self._powerText = self:GetUIComponent("UILocalizationText", "powerText")
  self._powerCountdown = self:GetUIComponent("UILocalizationText", "powerCountdown")
  self._tryOutTip = self:GetGameObject("UICommonRedPoint")
  self._safeWidth = self:GetUIComponent("RectTransform", "SafeArea").rect.size.x
end

function UIXH1SimpleLevel:RefreshShopCount()
  local count = self:GetModule(ItemModule):GetItemCount(3000211)
  count = count or 0
  self._coin:SetText(count)
end

function UIXH1SimpleLevel:RefreshCountdown()
  self._time = self:GetUIComponent("UILocalizationText", "time")
  local closeTime = self._line_info.m_close_time
  self._isValid = true
  
  local function countDown()
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local timeStr = UIActivityHelper.GetFormatTimerStr(time)
    if self._timeString ~= timeStr then
      self._time:SetText(timeStr)
      self._timeString = timeStr
    end
    if time < 0 and self._countdownTimer then
      GameGlobal.Timer():CancelEvent(self._countdownTimer)
      self._countdownTimer = nil
      self._isValid = false
    end
  end
  
  countDown()
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  self._countdownTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, countDown)
end

function UIXH1SimpleLevel:RefreshTryout()
  local cmp = self._campaign:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_FIXTEAM)
  local cmpInfo = cmp:GetComponentInfo()
  local cmpID = cmp:GetComponentCfgId()
  local newConfig = {}
  local missionCfgs = Cfg.cfg_component_line_mission({ComponentID = cmpID})
  for _, v in ipairs(missionCfgs) do
    newConfig[v.CampaignMissionId] = v
  end
  local passInfo = cmpInfo.m_pass_mission_info or {}
  
  function self._isTryoutLevelPass(mid)
    return passInfo[mid] ~= nil
  end
  
  local allPass = true
  for id, value in pairs(newConfig) do
    if not self._isTryoutLevelPass(id) then
      allPass = false
      break
    end
  end
  self._tryOutTip:SetActive(not allPass)
end

function UIXH1SimpleLevel:RefreshPower()
  local cmp = self._campaign:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_ACTION_POINT)
  if cmp == nil or not cmp:ComponentIsOpen() then
    Log.exception("严重错误,行动点组件已关闭!")
  end
  local cmpID = cmp:GetComponentCfgId()
  local pointCfg = cmp:GetActionPointConfig()
  local itemCfg = Cfg.cfg_item[pointCfg.ItemID]
  local count = self:GetModule(ItemModule):GetItemCount(pointCfg.ItemID)
  self._powerText:SetText(count .. "/" .. pointCfg.RegainMax)
  if count < pointCfg.RegainMax then
    local closeTime = cmp:GetRegainEndTime()
    
    local function countDown()
      local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
      local time = math.ceil(closeTime - now)
      local timeStr = HelperProxy:GetInstance():FormatTime(time)
      self._powerCountdown:SetText(StringTable.Get("str_activity_summer_i_nextpoint", timeStr))
      if time <= 0 then
        self:StartTask(self.PowerTimeUp, self)
      end
    end
    
    countDown()
    if self._pointCountdownTimer then
      GameGlobal.Timer():CancelEvent(self._pointCountdownTimer)
      self._pointCountdownTimer = nil
    end
    self._pointCountdownTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, countDown)
  else
    self._powerCountdown:SetText("MAX")
  end
end

function UIXH1SimpleLevel:PowerTimeUp(TT)
  if self._pointCountdownTimer then
    GameGlobal.Timer():CancelEvent(self._pointCountdownTimer)
    self._pointCountdownTimer = nil
  end
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  self:forceReq(TT, res)
  if res:GetSucc() and self._isOpen then
    self:RefreshPower()
  end
end

function UIXH1SimpleLevel:FlushPanel()
  local totalWidth = self._lineMissionManager:GetTotalWidth()
  self._contentRect.sizeDelta = Vector2(totalWidth, self._contentRect.sizeDelta.y)
  self._contentRect.anchoredPosition = Vector2(self._safeWidth / 2 - totalWidth, 0)
end

function UIXH1SimpleLevel:FlushNodes()
  local missionNodes = self._lineMissionManager:GetNodes()
  local count = table.count(missionNodes)
  self._nodesPool:SpawnObjects("UIXH1MissionNode", count)
  local nodes = self._nodesPool:GetAllSpawnList()
  self._uiMapNodes = {}
  local idx = 1
  for i, node in pairs(missionNodes) do
    local uiNode = nodes[idx]
    uiNode:SetData(node, function(stageId, needScroll, trans)
      self:_MoveToStage(stageId, needScroll, trans)
    end)
    self._uiMapNodes[idx] = uiNode
    idx = idx + 1
  end
end

function UIXH1SimpleLevel:FlushLines()
  local lines = self._lineMissionManager:GetLines()
  local len = table.count(lines)
  if not lines or len <= 0 then
    return
  end
  self._linesPool:SpawnObjects("UIXH1MissionLine", len)
  local spawnLines = self._linesPool:GetAllSpawnList()
  local i = 1
  for k, v in ipairs(lines) do
    local sNode = v[1]
    local eNode = v[2]
    spawnLines[i]:Flush(sNode, eNode, false)
    i = i + 1
  end
end

function UIXH1SimpleLevel:ShotTest()
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

function UIXH1SimpleLevel:_CalcShotOffset(trans)
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local screenPos = camera:WorldToScreenPoint(trans.position)
  return -(Vector2(screenPos.x, screenPos.y) - Vector2(UnityEngine.Screen.width, UnityEngine.Screen.height) / 2)
end

function UIXH1SimpleLevel:_MoveToStage(stageId, needScroll, trans)
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
    local _moveTime = 0.5
    self._tweener = self._contentRect:DOAnchorPosX(targetPos, _moveTime)
    self._moveLockName = "UIXH1SimpleLevel_MoveToStage"
    self._moveLockTimeEvent = UIActivityHelper.StartLockEvent(self._moveLockName, self._moveLockTimeEvent, function()
      self:_EnterStage(stageId, trans)
    end, _moveTime * 1000)
  else
    self:_EnterStage(stageId, trans)
  end
end

function UIXH1SimpleLevel:_EnterStage(stageId, trans)
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
    self:ShotTest()
    local passInfo = self._line_info.m_pass_mission_info[stageId]
    local extraCfg = self._lineMissionManager:GetLineExtraConfig()
    local scale = extraCfg._Scale
    local offset = self:_CalcShotOffset(trans)
    local autoFightShow = self:_CheckSerialAutoFightShow(stageType, stageId)
    self:ShowDialog("UIXH1Stage", stageId, passInfo, self._line_component, self._rt, offset, self._width, self._height, scale, autoFightShow, self._campaign:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_ACTION_POINT))
  end
end

function UIXH1SimpleLevel:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIXH1SimpleLevel:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIXH1SimpleLevel:PlotEndCallback(stageId)
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
        self:SwitchState(UIStateType.UIXH1SimpleLevel)
      end)
    else
      self:SwitchState(UIStateType.UIXH1SimpleLevel)
    end
  end, self)
end

function UIXH1SimpleLevel:CloseUIStage()
  if GameGlobal.UIStateManager():IsShow("UIXH1Stage") then
    GameGlobal.UIStateManager():CloseDialog("UIXH1Stage")
  end
end

function UIXH1SimpleLevel:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshShopCount)
end

function UIXH1SimpleLevel:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIXH1SimpleLevel:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end

function UIXH1SimpleLevel:_ShowUIGetItemController(rewards)
  self:ShowDialog("UIGetItemController", rewards, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
  end)
end

function UIXH1SimpleLevel:TryoutButtonOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  if not self._isValid then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
    return
  end
  self:ShowDialog("UIActivityPetTryController", ECampaignType.CAMPAIGN_TYPE_SUMMER_I, ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_FIXTEAM, self._isTryoutLevelPass, function(missionid)
    local missiontModule = GameGlobal.GetModule(MissionModule)
    local ctx = missiontModule:TeamCtx()
    local localProcess = self._campaign:GetLocalProcess()
    local missionComponent = localProcess:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_FIXTEAM)
    local param = {
      missionid,
      missionComponent:GetCampaignMissionComponentId(),
      missionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end

function UIXH1SimpleLevel:ShopButtonOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  self:ShowDialog("UIXH1Shop")
end

function UIXH1SimpleLevel:powerBtnOnClick()
  self:ShowDialog("UIXH1PointDetail")
end
