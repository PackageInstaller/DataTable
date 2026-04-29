_class("UISeasonOnceMission", UIController)
UISeasonOnceMission = UISeasonOnceMission

function UISeasonOnceMission:LoadDataOnEnter(TT, res, uiParams)
  self._onceMissonData = GameGlobal.GetModule(SeasonModule):GetOnceMissionData()
  self._onceMissonData:ForceLoadData(TT)
  self._missionCpts = self._onceMissonData:GetMissionComponents()
  self.openCb = uiParams[2]
  if self.openCb then
    self.openCb(true)
  end
  local ComState = {
    ComState_Normal = 1,
    ComState_OpenButLock = 2,
    ComState_NotOpen = 3,
    ComState_Closed = 4
  }
  local ComState = {
    [SeasonOnceMissionData.ComState_Normal] = 1,
    [SeasonOnceMissionData.ComState_Closed] = 2,
    [SeasonOnceMissionData.ComState_NotOpen] = 3,
    [SeasonOnceMissionData.ComState_OpenButLock] = 4
  }
  local showToastState = ComState[SeasonOnceMissionData.ComState_Normal]
  local normalStateCont = 0
  for _, cpt in ipairs(self._missionCpts) do
    local state = self._onceMissonData:GetCompState(cpt)
    if state == SeasonOnceMissionData.ComState_Normal then
      normalStateCont = normalStateCont + 1
    end
    if showToastState < ComState[state] then
      showToastState = ComState[state]
    end
  end
  if normalStateCont == 0 and showToastState ~= ComState[SeasonOnceMissionData.ComState_Normal] then
    if showToastState == ComState[SeasonOnceMissionData.ComState_OpenButLock] then
      ToastManager.ShowToast(StringTable.Get("str_activity_common_clear_mission_to_unlock"))
    elseif showToastState == ComState[SeasonOnceMissionData.ComState_NotOpen] then
      ToastManager.ShowToast(StringTable.Get("str_season_s5_branch_tab_lock"))
    elseif showToastState == ComState[SeasonOnceMissionData.ComState_Closed] then
      ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    end
    res:SetSucc(false)
  else
    res:SetSucc(true)
  end
end

function UISeasonOnceMission:OnShow(uiParams)
  self:InitWidget()
  self.topBtn:SpawnObject("UICommonTopButton"):SetData(function()
    self:_PlayAnim("out", function()
      self:CloseDialog()
      local uiController = GameGlobal.UIStateManager():GetController("UISeasonMainS5")
      if uiController then
        uiController:RefreshAfterCloseOnceMission()
      end
    end)
  end, nil, nil, false, nil, false, nil)
  self._tabBtns = self.tabBtns:SpawnObjects("UISeasonOnceMissionTab", #self._missionCpts)
  
  local function onSelect(idx)
    self:_OnSelect(idx, false)
  end
  
  local default
  if uiParams and uiParams[3] then
    local cptID = uiParams[3]
    for i, cpt in ipairs(self._missionCpts) do
      if cpt:GetComponentCfgId() == cptID and self._onceMissonData:IsComponentOpening(cpt) then
        default = i
        break
      end
    end
  end
  if not default then
    default = #self._missionCpts
    for i = #self._missionCpts, 1, -1 do
      local cpt = self._missionCpts[i]
      if self._onceMissonData:IsComponentOpening(cpt) then
        default = i
        break
      end
    end
  end
  for i, cpt in ipairs(self._missionCpts) do
    self._tabBtns[i]:SetData(self._onceMissonData, i, cpt, onSelect)
  end
  self:_OnSelect(default, true)
  self:_PlayAnim("in")
end

function UISeasonOnceMission:OnHide()
  self:CancelTimer()
end

function UISeasonOnceMission:InitWidget()
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self.tabBtns = self:GetUIComponent("UISelectObjectPath", "TabBtns")
  self.missions = self:GetUIComponent("UISelectObjectPath", "Missions")
  self.links = self:GetUIComponent("UISelectObjectPath", "Links")
  self.countdown = self:GetUIComponent("UILocalizationText", "Countdown")
  self._scrollWidth = self:GetUIComponent("RectTransform", "MissionScrollview").rect.size.x
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._tipsGo = self:GetGameObject("tipsGo")
  self._txtTips = self:GetUIComponent("UILocalizationText", "txtTips")
end

function UISeasonOnceMission:_OnSelect(idx, isOnShow)
  if self._curIdx == idx then
    return
  end
  if self._curIdx then
    self._tabBtns[self._curIdx]:Deselect()
  end
  self._curIdx = idx
  self._tabBtns[self._curIdx]:Select()
  local curCpt = self._missionCpts[self._curIdx]
  local missionCfgs = UIActivityLineMissionHelper.GetMissionCfgs(curCpt)
  local levelCount, lineCount, showMission = UIActivityLineMissionHelper.GetNodeLineInfo(curCpt, missionCfgs)
  local width = UIActivityLineMissionHelper.CalcContentWidth(curCpt, showMission, self._scrollWidth)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  if width ~= self._scrollWidth then
    self._contentRect.anchoredPosition = Vector2(self._scrollWidth - width, 0)
  end
  local nodes = self.missions:SpawnObjects("UISeasonOnceMissionItem", levelCount)
  local lines = self.links:SpawnObjects("UISeasonOnceMissionLink", lineCount)
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    if not isOnShow then
      if nodeIdx % 2 == 0 then
        uiNode:_PlayAnim("up")
      else
        uiNode:_PlayAnim("down")
      end
    elseif nodeIdx % 2 ~= 0 then
      uiNode:_PlayAnim("in")
    end
    uiNode:SetData(cfg, curCpt:GetComponentInfo().m_pass_mission_info[missionID], function(stageId, isStory)
      self:_OnNodeClick(stageId, isStory)
    end)
    nodeIdx = nodeIdx + 1
    if cfg.WayPointType ~= 4 and cfg.NeedMissionId ~= 0 then
      local from = showMission[cfg.NeedMissionId]
      local to = cfg
      local line = lines[lineIdx]
      line:SetData(Vector2(from.MapPosX, from.MapPosY), Vector2(to.MapPosX, to.MapPosY))
      lineIdx = lineIdx + 1
    end
  end
  self:RefreshTime()
  self:_CheckAndShowTips()
  self:RefreshCountDown()
end

function UISeasonOnceMission:_OnNodeClick(stageId, isStory)
  if isStory then
  else
    self:_ShowUITeam(stageId, self._missionCpts[self._curIdx])
  end
end

function UISeasonOnceMission:_ShowUITeam(stageID, cpt)
  self:ShowDialog("UISeasonOnceMissionStage", stageID, self._onceMissonData, cpt)
end

function UISeasonOnceMission:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uieff_UISeasonOnceMission_in"
    },
    out = {
      animName = "uieff_UISeasonOnceMission_out",
      duration = 333
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UISeasonOnceMission:_CheckAndShowTips()
  local curTab = self._tabBtns[self._curIdx]
  local curCpt = self._missionCpts[self._curIdx]
  if not curTab or not curCpt then
    return
  end
  local bShowTips = self._onceMissonData:HasNewByComp(curCpt)
  local cfg = Cfg.cfg_season_brance_tab[curCpt:GetComponentCfgId()]
  if cfg then
    self._txtTips:SetText(StringTable.Get("str_season_s5_branch_tab_unlock", StringTable.Get(cfg.TabName)))
  end
  self._tipsGo:SetActive(bShowTips)
  if not bShowTips then
    return
  end
  UIWidgetHelper.PlayAnimation(self, "_tipsAnim", "uieff_UISeasonOnceMission_top", nil, nil)
  curTab:ReadNew()
  self:Lock("UISeasonOnceMission_Tips")
  self:StartTask(function(TT)
    YIELD(TT, 600)
    self:UnLock("UISeasonOnceMission_Tips")
  end)
end

function UISeasonOnceMission:TipsBgOnClick()
  self._tipsGo:SetActive(false)
end

function UISeasonOnceMission:CancelTimer()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UISeasonOnceMission:RefreshCountDown()
  self._curActivityEnd = false
  self:CancelTimer()
  self:RefreshTime()
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:RefreshTime()
  end)
end

function UISeasonOnceMission:RefreshTime()
  local curCpt = self._missionCpts[self._curIdx]
  if not curCpt then
    return
  end
  local cInfo = curCpt:GetComponentInfo()
  if not cInfo then
    return
  end
  local endTime = cInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local timeStr = UIActivityCustomHelper.GetTimeString(endTime - curTime)
  self.countdown:SetText(StringTable.Get("str_activity_common_remainingtime") .. timeStr)
  if endTime < curTime then
    self.countdown:SetText(StringTable.Get("str_activity_error_107"))
    self:CancelTimer()
    self._curActivityEnd = true
  end
end
