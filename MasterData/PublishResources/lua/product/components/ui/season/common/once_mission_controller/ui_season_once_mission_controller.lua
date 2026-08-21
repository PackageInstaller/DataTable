_class("UISeasonOnceMissionController", UIController)
UISeasonOnceMissionController = UISeasonOnceMissionController

function UISeasonOnceMissionController:LoadDataOnEnter(TT, res, uiParams)
  self._onceMissonData = GameGlobal.GetModule(SeasonModule):GetOnceMissionData()
  self._onceMissonData:ForceLoadData(TT)
  self.uiStyle = UISeasonOnceMissionControllerUIStyle:New()
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

function UISeasonOnceMissionController:OnShow(uiParams)
  self:InitWidget()
  self.topBtn:SpawnObject("UICommonTopButton"):SetData(function()
    self:_PlayAnim("out", function()
      if self._fromSeasonMainAfterBattle then
        UISeasonHelper.ShowCurSeasonMainController()
      end
      self:CloseDialog()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnceMissonControllerClosed)
    end)
  end, nil, nil, false, nil, false, nil)
  self._tabBtns = self.tabBtns:SpawnObjects("UISeasonOnceMissionControllerTab", #self._missionCpts)
  
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
  self._fromSeasonMain = uiParams[4]
  self._fromSeasonMainAfterBattle = uiParams[5]
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

function UISeasonOnceMissionController:OnHide()
  self:CancelTimer()
end

function UISeasonOnceMissionController:InitWidget()
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self.tabBtns = self:GetUIComponent("UISelectObjectPath", "TabBtns")
  self.missions = self:GetUIComponent("UISelectObjectPath", "Missions")
  self.countdown = self:GetUIComponent("UILocalizationText", "Countdown")
  self._scrollWidth = self:GetUIComponent("RectTransform", "MissionScrollview").rect.size.x
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._tipsGo = self:GetGameObject("tipsGo")
  self._txtTips = self:GetUIComponent("UILocalizationText", "txtTips")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
end

function UISeasonOnceMissionController:_OnSelect(idx, isOnShow)
  if self._curIdx == idx then
    return
  end
  if self._curIdx then
    self._tabBtns[self._curIdx]:Deselect()
  end
  self._curIdx = idx
  self._tabBtns[self._curIdx]:Select()
  if isOnShow then
    self:RefreshContent()
  else
    self:StartTask(function(TT)
      self:_PlayAnim("out2", function()
        self:_PlayAnim("out1")
        self:RefreshContent()
      end)
    end)
  end
end

function UISeasonOnceMissionController:GetStyleIndex(index)
  local curCpt = self._missionCpts[index]
  local styleIndex = 1
  local cfgTab = Cfg.cfg_season_brance_tab[curCpt:GetComponentCfgId()]
  if cfgTab then
    styleIndex = cfgTab.UIStyle or 1
  end
  return self.uiStyle:GetSyle(styleIndex)
end

function UISeasonOnceMissionController:RefreshContent()
  local curCpt = self._missionCpts[self._curIdx]
  local styleIndex = 1
  local cfgTab = Cfg.cfg_season_brance_tab[curCpt:GetComponentCfgId()]
  if cfgTab then
    styleIndex = cfgTab.UIStyle or 1
  end
  self._curUIStyleCfg = self.uiStyle:GetSyle(styleIndex)
  self._bg:LoadImage(self._curUIStyleCfg.controllerBg)
  local missionCfgs = UIActivityLineMissionHelper.GetMissionCfgs(curCpt)
  local levelCount, lineCount, showMission = UIActivityLineMissionHelper.GetNodeLineInfo(curCpt, missionCfgs)
  local width = UIActivityLineMissionHelper.CalcContentWidth(curCpt, showMission, self._scrollWidth)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  if width ~= self._scrollWidth then
    self._contentRect.anchoredPosition = Vector2(self._scrollWidth - width, 0)
  end
  local nodes = self.missions:SpawnObjects("UISeasonOnceMissionControllerItem", levelCount)
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetData(cfg, curCpt:GetComponentInfo().m_pass_mission_info[missionID], self._curUIStyleCfg, function(stageId, isStory)
      self:_OnNodeClick(stageId, isStory)
    end)
    nodeIdx = nodeIdx + 1
  end
  self:RefreshTime()
  self:_CheckAndShowTips()
  self:RefreshCountDown()
end

function UISeasonOnceMissionController:_OnNodeClick(stageId, isStory)
  if isStory then
  else
    self:_ShowUITeam(stageId, self._missionCpts[self._curIdx])
  end
end

function UISeasonOnceMissionController:_ShowUITeam(stageID, cpt)
  self:ShowDialog("UISeasonOnceMissionStage", stageID, self._onceMissonData, cpt, self._fromSeasonMain)
end

function UISeasonOnceMissionController:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uieff_UISeasonOnceMissionController_in"
    },
    out1 = {
      animName = "uieff_UISeasonOnceMissionController_out01",
      duration = 100
    },
    out2 = {
      animName = "uieff_UISeasonOnceMissionController_out02",
      duration = 200
    },
    out3 = {
      animName = "uieff_UISeasonOnceMissionController_out03",
      duration = 200
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UISeasonOnceMissionController:_CheckAndShowTips()
  local curTab = self._tabBtns[self._curIdx]
  local curCpt = self._missionCpts[self._curIdx]
  if not curTab or not curCpt then
    return
  end
  local bShowTips = self._onceMissonData:HasNewByComp(curCpt)
  local cfg = Cfg.cfg_season_brance_tab[curCpt:GetComponentCfgId()]
  if cfg then
    self._txtTips:SetText(StringTable.Get("str_season_s5_branch_tab_unlock", StringTable.Get(cfg.TabName)))
    self._txtDesc:SetText(StringTable.Get(cfg.LevelDesc))
  end
  self._tipsGo:SetActive(bShowTips)
  if not bShowTips then
    return
  end
  UIWidgetHelper.PlayAnimation(self, "_tipsAnim", "uieff_UISeasonOnceMission_top", nil, nil)
  curTab:ReadNew()
  self:Lock("UISeasonOnceMissionController_Tips")
  self:StartTask(function(TT)
    YIELD(TT, 600)
    self:UnLock("UISeasonOnceMissionController_Tips")
  end)
end

function UISeasonOnceMissionController:TipsBgOnClick()
  self._tipsGo:SetActive(false)
end

function UISeasonOnceMissionController:CancelTimer()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UISeasonOnceMissionController:RefreshCountDown()
  self._curActivityEnd = false
  self:CancelTimer()
  self:RefreshTime()
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:RefreshTime()
  end)
end

function UISeasonOnceMissionController:RefreshTime()
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
