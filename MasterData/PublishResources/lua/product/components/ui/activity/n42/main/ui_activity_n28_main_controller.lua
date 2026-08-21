_class("UIActivityN28MainController", UIController)
UIActivityN28MainController = UIActivityN28MainController

function UIActivityN28MainController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIActivityN28Const:New()
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
  end
end

function UIActivityN28MainController:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnActivityTotalAwardGot, self.RefreshRedData)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.RefreshRedData)
  self:AttachEvent(GameEventType.OnN26ActivityMainRedStatusRefresh, self.RefreshRedData)
  self:AttachEvent(GameEventType.ItemCountChanged, self.RefreshRedData)
  self._taskIDLine = nil
  self._taskIDHard = nil
  self._taskIDAvg = nil
  self._taskIDTiile = nil
  self._eventRed = self:GetGameObject("EventRed")
  self._loginRed = self:GetGameObject("LoginRed")
  self._loginNew = self:GetGameObject("LoginNew")
  self._normalLevelRed = self:GetGameObject("NormalLevelRed")
  self._normalLevelNew = self:GetGameObject("NormalLevelNew")
  self._hardLevelRed = self:GetGameObject("HardLevelRed")
  self._hardLevelNew = self:GetGameObject("HardLevelNew")
  self._shopNew = self:GetGameObject("ShopNew")
  self._shopRed = self:GetGameObject("ShopRed")
  self._avgGameNew = self:GetGameObject("MiniGameNew")
  self._avgGameRed = self:GetGameObject("MiniGameRed")
  self._normalLevelRemainTimePanel = self:GetGameObject("NormalLevelRemainTimePanel")
  self._normalLevelEndPanel = self:GetGameObject("NormalLevelEndPanel")
  self._normalLevelRemainTimeLabel = self:GetUIComponent("UILocalizationText", "NormalLevelRemainTime")
  self._hardLevelEndPanel = self:GetGameObject("HardLevelEndPanel")
  self._hardLevelLockTipsPanel = self:GetGameObject("HardLevelLockTipsPanel")
  self._hardLevelRemainTimePanel = self:GetGameObject("HardLevelRemainTimePanel")
  self._hardLevelRemainTimeLabel = self:GetUIComponent("UILocalizationText", "HardLevelRemainTime")
  self._hardLevelLockTipsLabel = self:GetUIComponent("UILocalizationText", "HardLevelLockTips")
  self._shopIconLoader = self:GetUIComponent("RawImageLoader", "ShopIcon")
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._minGameEndPanel = self:GetGameObject("MiniGameEndPanel")
  self._minGameRemainTimePanel = self:GetGameObject("MiniGameRemainTimePanel")
  self._miniGameRemainTimeLabel = self:GetUIComponent("UILocalizationText", "MiniGameRemainTime")
  self._miniGameLockTipsPanel = self:GetGameObject("MiniGameLockTipsPanel")
  self._miniGameLockTipsLabel = self:GetUIComponent("UILocalizationText", "MiniGameLockTips")
  self._minGameMask = self:GetGameObject("MiniGameIcon")
  self._normalLevelMask = self:GetGameObject("NormalLevelIcon")
  self._hardLevelMask = self:GetGameObject("HardLevelIcon")
  self._shopIconMask = self:GetGameObject("ShopIcon")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._btnPanel = self:GetGameObject("BtnPanel")
  self._showBtn = self:GetGameObject("ShowBtn")
  self._showBtn:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._shot = self:GetUIComponent("RawImage", "shot")
  self._topBtn = self:GetGameObject("TopBtn")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    GameGlobal.TaskManager():StartTask(self.SetButtonShowStatus, self, false)
  end)
  self:InitUI()
  CutsceneManager.ExcuteCutsceneOut(function()
    UIActivityHelper.PlayFirstPlot_Campaign(self._activityConst:GetCampaign())
  end)
  self._activityConst:ClearEnterNew()
  CutsceneManager.ExcuteCutsceneOut_Shot()
  self:PlayEnterAnim()
  self:_CheckGuide()
end

function UIActivityN28MainController:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN28MainController:PlayEnterAnimCoro(TT)
  self:Lock("UIActivityN26MainController_PlayEnterAnimCoro")
  self._anim:Play("uieff_UIActivityN28MainController_in")
  YIELD(TT, 1500)
  self:UnLock("UIActivityN26MainController_PlayEnterAnimCoro")
  self:_CheckGuide()
end

function UIActivityN28MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN42MainController)
end

function UIActivityN28MainController:OnUpdate(deltaTimeMS)
  self:RefreshUI()
end

function UIActivityN28MainController:OnHide()
  self:DetachEvent(GameEventType.OnActivityTotalAwardGot, self.RefreshRedData)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self.RefreshRedData)
  self:DetachEvent(GameEventType.OnN26ActivityMainRedStatusRefresh, self.RefreshRedData)
  self:DetachEvent(GameEventType.ItemCountChanged, self.RefreshRedData)
end

function UIActivityN28MainController:InitUI()
  self:RefreshShopBtnStatus()
  self:RefreshUI()
  self:RefreshNew()
  self:RefreshRed()
end

function UIActivityN28MainController:RefreshBtnRemain()
  self:RefreshLineRemain()
  self:RefreshHardRemain()
  self:RefreshMiniGameRemain()
end

function UIActivityN28MainController:RefreshLineRemain()
  local lineTimeStr
  local showLineMask = true
  local showPanel = true
  local status, time = self._activityConst:GetNormalLineMissionComponentStatus()
  if time == 0 and status ~= ActivityN28ComponentStatus.Close and status ~= ActivityN28ComponentStatus.ActivityEnd and self._taskIDLine == nil then
    self._taskIDLine = self:StartTask(function(TT)
      YIELD(TT, 50)
      self._activityConst:ForceUpdate(TT)
    end, self)
    status, time = self._activityConst:GetNormalLineMissionComponentStatus()
  end
  showPanel = true
  if status == ActivityN28ComponentStatus.Open then
    showLineMask = false
    lineTimeStr = StringTable.Get("str_n28_activity_normal_level_remain_time", UIActivityN28Helper.GetTimeString(time))
  elseif status == ActivityN28ComponentStatus.Close or status == ActivityN28ComponentStatus.ActivityEnd or status == ActivityN28ComponentStatus.None then
    lineTimeStr = StringTable.Get("str_n28_activity_end")
  elseif status == ActivityN28ComponentStatus.TimeLock then
    showLineMask = true
    showPanel = false
  elseif status == ActivityN28ComponentStatus.MissionLock then
    showLineMask = true
  end
  self._normalLevelMask:SetActive(showLineMask)
  self._normalLevelRemainTimePanel:SetActive(showPanel)
  self._normalLevelRemainTimeLabel:SetText(lineTimeStr)
end

function UIActivityN28MainController:RefreshHardRemain()
  local showHardMask = true
  local hardTimeStr
  local tipsStr = ""
  local showTips = true
  local status, time = self._activityConst:GetHardLineMissionComponentStatus()
  if time == 0 and status ~= ActivityN28ComponentStatus.Close and status ~= ActivityN28ComponentStatus.ActivityEnd and self._taskIDHard == nil then
    self._taskIDHard = self:StartTask(function(TT)
      YIELD(TT, 50)
      self._activityConst:ForceUpdate(TT)
    end, self)
    status, time = self._activityConst:GetHardLineMissionComponentStatus()
  end
  showTips = false
  if status == ActivityN28ComponentStatus.Open then
    showHardMask = false
    hardTimeStr = StringTable.Get("str_n28_activity_hard_level_remain_time", UIActivityN28Helper.GetTimeString(time))
  elseif status == ActivityN28ComponentStatus.Close or status == ActivityN28ComponentStatus.ActivityEnd or status == ActivityN28ComponentStatus.None then
    hardTimeStr = StringTable.Get("str_n28_activity_end")
  elseif status == ActivityN28ComponentStatus.TimeLock then
    showTips = true
    showHardMask = true
    tipsStr = StringTable.Get("str_n28_activity_hard_level_lock_time_tips", UIActivityN28Helper.GetTimeString(time))
  elseif status == ActivityN28ComponentStatus.MissionLock then
    showTips = true
    showHardMask = true
    tipsStr = StringTable.Get("str_n28_activity_hard_level_lock_mission_tips")
  end
  self._hardLevelLockTipsPanel:SetActive(showTips)
  self._hardLevelMask:SetActive(showHardMask)
  self._hardLevelLockTipsLabel:SetText(tipsStr)
  self._hardLevelRemainTimePanel:SetActive(not showTips)
  self._hardLevelRemainTimeLabel:SetText(hardTimeStr)
end

function UIActivityN28MainController:RefreshMiniGameRemain()
  local minigameTime
  local showLockTips = true
  local tipStr = ""
  local showMiniGameMask = true
  local status, time = self._activityConst:GetAVGGameComponentStatus()
  if time == 0 and status ~= ActivityN28ComponentStatus.Close and status ~= ActivityN28ComponentStatus.ActivityEnd and self._taskIDAvg == nil then
    self._taskIDAvg = self:StartTask(function(TT)
      YIELD(TT, 50)
      self._activityConst:ForceUpdate(TT)
    end, self)
    status, time = self._activityConst:GetAVGGameComponentStatus()
  end
  showLockTips = false
  if status == ActivityN28ComponentStatus.Open then
    showMiniGameMask = false
    minigameTime = StringTable.Get("str_n28_activity_minigame_remain_time", UIActivityN28Helper.GetTimeString(time))
  elseif status == ActivityN28ComponentStatus.Close or status == ActivityN28ComponentStatus.ActivityEnd or status == ActivityN28ComponentStatus.None then
    minigameTime = StringTable.Get("str_n28_activity_end")
  elseif status == ActivityN28ComponentStatus.TimeLock then
    showLockTips = true
    showMiniGameMask = true
    tipStr = StringTable.Get("str_n28_activity_minigame_lock_time_tips", UIActivityN28Helper.GetTimeString(time))
  elseif status == ActivityN28ComponentStatus.MissionLock then
    showLockTips = true
    showMiniGameMask = true
    local tips = StringTable.Get("str_n28_activity_minigame_lock_mission_tips")
    tipStr = StringTable.Get("str_n28_activity_minigame_lock_mission_tips")
  end
  self._minGameMask:SetActive(showMiniGameMask)
  self._miniGameLockTipsPanel:SetActive(showLockTips)
  self._miniGameLockTipsLabel:SetText(tipStr)
  self._minGameEndPanel:SetActive(false)
  self._minGameRemainTimePanel:SetActive(not showLockTips)
  self._miniGameRemainTimeLabel:SetText(minigameTime)
end

function UIActivityN28MainController:RefreshRedData()
  self:StartTask(function(TT)
    self:Lock("UIActivityN28MainController_ReLoadData")
    self:ReLoadData(TT, "Refresh")
    self:RefreshRed()
    self:RefreshShopBtnStatus()
    self:UnLock("UIActivityN28MainController_ReLoadData")
  end)
end

function UIActivityN28MainController:RefreshNew()
  self._normalLevelNew:SetActive(self._activityConst:IsShowNormalLineNew())
  self._hardLevelNew:SetActive(self._activityConst:IsShowHardLineNew())
  self._shopNew:SetActive(self._activityConst:IsShowShopNew())
  self._avgGameNew:SetActive(self._activityConst:IsShowAVGGameNew())
  self._loginNew:SetActive(self._activityConst:IsShowLoginNew())
end

function UIActivityN28MainController:RefreshRed()
  self._eventRed:SetActive(self._activityConst:IsShowBattlePassRed())
  self._loginRed:SetActive(self._activityConst:IsShowLoginRed())
  self._normalLevelRed:SetActive(self._activityConst:IsShowNormalLineRed())
  self._hardLevelRed:SetActive(self._activityConst:IsShowHardLineRed())
  self._shopRed:SetActive(self._activityConst:IsShowShopRed())
  self._avgGameRed:SetActive(self._activityConst:IsShowAVGGameRed())
end

function UIActivityN28MainController:ReLoadData(TT, key)
  self:Lock("UIActivityN28MainController_ReLoadData" .. key)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  self:UnLock("UIActivityN28MainController_ReLoadData" .. key)
end

function UIActivityN28MainController:CloseCoro(TT)
  self:Lock("UIActivityN21CCMainController_CloseCoro")
  self:SwitchState(UIStateType.UIMain)
  self:UnLock("UIActivityN21CCMainController_CloseCoro")
end

function UIActivityN28MainController:RefreshUI()
  self:RefreshActivityRemainTime()
  self:RefreshBtnRemain()
end

function UIActivityN28MainController:RefreshActivityRemainTime()
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n28_activity_end"))
    return
  end
  local timeTips
  local endTime = self._activityConst:GetActiveEndTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
  end
  local ActivetimeStr = UIActivityN28Helper.GetTimeString(seconds)
  local status, time = self._activityConst:GetNormalLineMissionComponentStatus()
  if time == 0 and status ~= ActivityN28ComponentStatus.Close and status ~= ActivityN28ComponentStatus.ActivityEnd and self._taskIDTiile == nil then
    self._taskIDTiile = self:StartTask(function(TT)
      YIELD(TT, 50)
      self._activityConst:ForceUpdate(TT)
    end, self)
    status, time = self._activityConst:GetNormalLineMissionComponentStatus()
  end
  if status == ActivityN28ComponentStatus.Open then
    timeTips = StringTable.Get("str_n28_activity_remain_time_line") .. UIActivityN28Helper.GetTimeString(time)
  else
    timeTips = StringTable.Get("str_n28_activity_remain_time", ActivetimeStr)
  end
  self._timeLabel:SetText(timeTips)
end

function UIActivityN28MainController:SetButtonShowStatus(TT, isShow)
  self._showBtn:SetActive(not isShow)
  self._topBtn:SetActive(isShow)
  local aniName = "uieff_UIActivityN28MainController_show_out"
  if isShow then
    aniName = "uieff_UIActivityN28MainController_show_in"
  end
  self:Lock("UIActivityN28MainController_SetButtonShowStatus")
  self._anim:Play(aniName)
  YIELD(TT, 1500)
  self:UnLock("UIActivityN28MainController_SetButtonShowStatus")
end

function UIActivityN28MainController:PlayEnterPlot()
  self:ShowDialog("UIStoryController", self._activityConst:GetPlotId())
  self._activityConst:SetPlayPlotStatus()
end

function UIActivityN28MainController:RefreshShopBtnStatus()
  local shopCom, info = self._activityConst:GetShopComponent()
  local icon, count = shopCom:GetCostItemIconText()
  self._shopIconLoader:LoadImage(icon)
  self._shopCountLabel:SetText(UIActivityN28Helper.GetItemCountStr(7, count, "#b07f08", "#ffffff"))
end

function UIActivityN28MainController:InfoBtnOnClick()
  self:ShowDialog("UIIntroLoader", "UIN28Intro")
end

function UIActivityN28MainController:EventOnClick()
  UIActivityBattlePassHelper.OpenMainController()
end

function UIActivityN28MainController:LoginOnClick()
  local status, time = self._activityConst:GetLoginComponentStatus()
  if status == ActivityN28ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    return
  elseif status == ActivityN28ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self._activityConst:ClearLoginNew()
  self:RefreshNew()
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N42, ECampaignN28ComponentID.ECAMPAIGN_N28_CUMULATIVE_LOGIN)
end

function UIActivityN28MainController:ShowBtnOnClick()
  GameGlobal.TaskManager():StartTask(self.SetButtonShowStatus, self, true)
end

function UIActivityN28MainController:PilotBtnOnClick()
  self:PlayEnterPlot()
end

function UIActivityN28MainController:NormalLevelOnClick()
  local status, time = self._activityConst:GetNormalLineMissionComponentStatus()
  if status == ActivityN28ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    return
  elseif status == ActivityN28ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self._activityConst:ClearNormalLineNew()
  self:RefreshNew()
  UIActivityN28Helper.LocalDB_Set_CrossDay("line", "Red")
  self:SwitchState("UIN28Line")
end

function UIActivityN28MainController:HardLevelOnClick()
  local status, time = self._activityConst:GetHardLineMissionComponentStatus()
  if status == ActivityN28ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    return
  elseif status == ActivityN28ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return
  elseif status == ActivityN28ComponentStatus.TimeLock then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_hard_level_lock_time_tips", UIActivityN28Helper.GetTimeString(time)))
    return
  elseif status == ActivityN28ComponentStatus.MissionLock then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_hard_level_lock_mission_tips"))
    return
  end
  self._activityConst:ClearHardLineNew()
  self:RefreshNew()
  UIActivityN28Helper.LocalDB_Set_CrossDay("hard", "Red")
  self:ShowDialog("UIN28HardLevel")
end

function UIActivityN28MainController:ShopOnClick()
  local status, time = self._activityConst:GetShopComponentStatus()
  if status == ActivityN28ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    return
  elseif status == ActivityN28ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self._activityConst:ClearShopNew()
  self:RefreshNew()
  UIActivityHelper.OpenCampaignShop(self._activityConst:GetCampaign())
end

function UIActivityN28MainController:AVGGameOnClick()
  local status, time = self._activityConst:GetAVGGameComponentStatus()
  if status == ActivityN28ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    return
  elseif status == ActivityN28ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return
  elseif status == ActivityN28ComponentStatus.TimeLock then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_minigame_lock_time_tips", UIActivityN28Helper.GetTimeString(time)))
    return
  elseif status == ActivityN28ComponentStatus.MissionLock then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_minigame_lock_mission_tips"))
    return
  end
  self._activityConst:ClearAVGGameNew()
  self:RefreshNew()
  self:SwitchState(UIStateType.UIN28AVGMain)
end
