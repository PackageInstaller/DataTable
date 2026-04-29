_class("UIN7Level", UIController)
UIN7Level = UIN7Level

function UIN7Level:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
end

function UIN7Level:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N7, ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION, ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  if res and res:GetSucc() then
    self._line_component = self._campaign:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
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

function UIN7Level:OnShow(uiParams)
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  UIN7Level.SLeval = 999
  UIN7Level.Passed = 888
  UIN7Level.NodeCfg = {
    [DiscoveryStageType.FightNormal] = {
      [1] = {
        normal = "n7_map_stage",
        press = "n7_map_click",
        lock = "n7_map_stage",
        textColor = Color(0 / 0, 0 / 255, 0 / 255),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255, 0.0392156862745098),
        normalStar = "n7_map_blank",
        passStar = "n7_map_badge"
      }
    },
    [DiscoveryStageType.FightBoss] = {
      [1] = {
        normal = "n7_map_boss",
        press = "n7_map_click",
        lock = "n7_map_boss",
        textColor = Color(0.9647058823529412, 0.9647058823529412, 0.9647058823529412),
        textShadow = Color(1.0, 1.0, 1.0, 0.0392156862745098),
        normalStar = "n7_map_blank",
        passStar = "n7_map_badge"
      }
    },
    [DiscoveryStageType.Plot] = {
      [1] = {
        normal = "n7_map_plot",
        press = "n7_map_click",
        lock = "n7_map_plot",
        textColor = Color(0 / 0, 0 / 255, 0 / 255),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255, 0.0392156862745098)
      }
    },
    [UIN7Level.SLeval] = {
      [1] = {
        normal = "n7_map_boss",
        press = "n7_map_click",
        lock = "n7_map_boss",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(1.0, 1.0, 1.0, 0.0392156862745098),
        normalStar = "n7_map_blank",
        passStar = "n7_map_badge"
      }
    }
  }
  self:AttachEvents()
  self:InitWidget()
  local componentCfgId = self._line_component:GetComponentCfgId()
  self:FlushNodes()
  self:RefreshCountdown()
  self:RefreshTryout()
  local lockName = "UINP7Level_OnShow"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
end

function UIN7Level:OnHide()
  UIN7Level.SLeval = nil
  UIN7Level.NodeCfg = nil
  self._isOpen = false
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIN7Level.super:Dispose()
  self._scroller:Dispose()
end

function UIN7Level:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self._campModule:CampaignSwitchState(true, UIStateType.UIActivityN7MainController, UIStateType.UIMain, nil, self._campaign._id)
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._tryOutTip = self:GetGameObject("RedPoint")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._shot.width = self._safeAreaSize.x
  self._shot.height = self._safeAreaSize.y
end

function UIN7Level:RefreshCountdown()
  self._time = self:GetUIComponent("UILocalizationText", "time")
  local closeTime = self._line_info.m_close_time
  self._isValid = true
  local timerName = "CountDown"
  
  local function countDown()
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local timeStr = self:GetFormatTimerStr(time)
    if self._timeString ~= timeStr then
      self._time:SetText(timeStr)
      self._timeString = timeStr
    end
    if time < 0 then
      self._isValid = false
      self._timerHolder:StopTimer(timerName)
    end
  end
  
  countDown()
  self._timerHolder:StartTimerInfinite(timerName, 1000, countDown)
end

function UIN7Level:GetFormatTimerStr(time, id)
  local default_id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  id = id or default_id
  local timeStr = StringTable.Get(id.over)
  if time < 0 then
    return timeStr
  end
  local day, hour, min, second = UIActivityHelper.Time2Str(time)
  if 0 < day then
    timeStr = "<color=#9fafee><size=34>" .. day .. "</size></color>" .. StringTable.Get(id.day) .. " " .. "<color=#9fafee><size=34>" .. hour .. "</size></color>" .. StringTable.Get(id.hour)
  elseif 0 < hour then
    timeStr = "<color=#9fafee><size=34>" .. hour .. "</size></color>" .. StringTable.Get(id.hour) .. " " .. "<color=#9fafee><size=34>" .. min .. "</size></color>" .. StringTable.Get(id.min)
  elseif 0 < min then
    timeStr = "<color=#9fafee><size=34>" .. min .. "</size></color>" .. StringTable.Get(id.min)
  else
    timeStr = StringTable.Get(id.zero)
  end
  return timeStr
end

function UIN7Level:RefreshTryout()
  local cmp = self._campaign:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM)
  local cmpInfo = cmp:GetComponentInfo()
  local passInfo = cmpInfo.m_pass_mission_info or {}
  
  function self._isTryoutLevelPass(mid)
    return passInfo[mid] ~= nil
  end
  
  local tryOutRed = self._campaign:CheckComponentRed(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM)
  self._tryOutTip:SetActive(tryOutRed)
end

function UIN7Level:FlushNodes()
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
      if not showMission[missionID] and missionCfgs[missionID] then
        showMission[missionID] = missionCfgs[missionID]
        levelCount = levelCount + 1
      end
      if unlockInfo[missionID] then
        for id, cfg in pairs(unlockInfo[missionID]) do
          if not showMission[id] and missionCfgs[missionID] then
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
  self._nodesPool:SpawnObjects("UIN7LevelNode", levelCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  self._linesPool:SpawnObjects("UIN7LevelLine", lineCount)
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
  local sp1, sp2 = 4, 8
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._scroller = UILevelScroller:New(self._contentRect, bgLoader1, bgLoader2, {
    "n7_map_bg1",
    "n7_map_bg2",
    "n7_map_bg3"
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

function UIN7Level:_onNodeClick(stageId, isStory, worldPos)
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
    local moveLockName = "UINP6Level_MoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, _moveTime * 1000, function()
      self:UnLock(moveLockName)
      self:_EnterStage(stageId, worldPos)
    end)
  else
    self:_EnterStage(stageId, worldPos)
  end
end

function UIN7Level:_EnterStage(stageId, worldPos)
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._shot:CleanRenderTexture()
  local rt = self._shot:RefreshBlurTexture()
  local scale = 1.3
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local offset = -(Vector2(screenPos.x, screenPos.y) - Vector2(UnityEngine.Screen.width, UnityEngine.Screen.height) / 2)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, stageId)
  self:ShowDialog("UIActivityLevelStage", stageId, self._line_info.m_pass_mission_info[stageId], self._line_component, rt, offset, self._safeAreaSize.x, self._safeAreaSize.y, scale, autoFightShow, pointCpm)
end

function UIN7Level:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIN7Level:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIN7Level:PlotEndCallback(stageId)
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
        self:SwitchState(UIStateType.UIN7Level)
      end)
    else
      self:SwitchState(UIStateType.UIN7Level)
    end
  end, self)
end

function UIN7Level:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIN7Level:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN7Level:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:_Refresh()
  end
end

function UIN7Level:_ShowUIGetItemController(rewards)
  self:ShowDialog("UIGetItemController", rewards, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
  end)
end

function UIN7Level:TryoutButtonOnClick()
  if not self._isValid then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
    return
  end
  self:ShowDialog("UIActivityPetTryController", ECampaignType.CAMPAIGN_TYPE_N7, ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM, self._isTryoutLevelPass, function(missionid)
    local ctx = self._missionModule:TeamCtx()
    local localProcess = self._campaign:GetLocalProcess()
    local missionComponent = localProcess:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM)
    local param = {
      missionid,
      missionComponent:GetCampaignMissionComponentId(),
      missionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end
