_class("UIActivityN26MainController", UIController)
UIActivityN26MainController = UIActivityN26MainController

function UIActivityN26MainController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIActivityN26Const:New()
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
  end
end

function UIActivityN26MainController:OnShow()
  self:AttachEvent(GameEventType.OnActivityTotalAwardGot, self.RefreshRedData)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.RefreshRedData)
  self:AttachEvent(GameEventType.OnN26ActivityMainRedStatusRefresh, self.RefreshRedData)
  self._eventRed = self:GetGameObject("EventRed")
  self._loginRed = self:GetGameObject("LoginRed")
  self._normalLevelRed = self:GetGameObject("NormalLevelRed")
  self._normalLevelNew = self:GetGameObject("NormalLevelNew")
  self._hardLevelRed = self:GetGameObject("HardLevelRed")
  self._hardLevelNew = self:GetGameObject("HardLevelNew")
  self._shopNew = self:GetGameObject("ShopNew")
  self._shopRed = self:GetGameObject("ShopRed")
  self._movieRed = self:GetGameObject("MovieRed")
  self._movieNew = self:GetGameObject("MovieNew")
  self._miniGameNew = self:GetGameObject("MiniGameNew")
  self._miniGameRed = self:GetGameObject("MiniGameRed")
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
  self._movieEndPanel = self:GetGameObject("MovieEndPanel")
  self._movieRemainTimePanel = self:GetGameObject("MovieRemainTimePanel")
  self._movieRemainTimeLabel = self:GetUIComponent("UILocalizationText", "MovieRemainTime")
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
  self:PlayEnterAnim()
end

function UIActivityN26MainController:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN26MainController:PlayEnterAnimCoro(TT)
  self:Lock("UIActivityN26MainController_PlayEnterAnimCoro")
  self._anim:Play("uieff_N26_MainController")
  YIELD(TT, 1500)
  self:UnLock("UIActivityN26MainController_PlayEnterAnimCoro")
  self:_CheckGuide()
end

function UIActivityN26MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN26MainController)
end

function UIActivityN26MainController:OnUpdate(deltaTimeMS)
  self:RefreshUI()
end

function UIActivityN26MainController:OnHide()
  self._normalLevelButtonStatus:Release()
  self._hardLevelButtonStatus:Release()
  self._movieButtonStatus:Release()
  self._miniGameButtonStatus:Release()
  self:DetachEvent(GameEventType.OnActivityTotalAwardGot, self.RefreshRedData)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self.RefreshRedData)
  self:DetachEvent(GameEventType.OnN26ActivityMainRedStatusRefresh, self.RefreshRedData)
end

function UIActivityN26MainController:InitUI()
  self:RefreshShopBtnStatus()
  self:RefreshUI()
  self:RefreshNew()
  self:RefreshRed()
  self._normalLevelButtonStatus = UIActivityN26ButtonStatus:New(function()
    return self._activityConst:GetNormalLineMissionComponentStatus()
  end, function(TT)
    self:ReLoadData(TT, "normallevel")
  end, function(status, timeStr)
    self._normalLevelRemainTimePanel:SetActive(false)
    self._normalLevelEndPanel:SetActive(false)
    if status == ActivityComponentStatus.Open then
      self._normalLevelMask:SetActive(false)
      self._normalLevelRemainTimePanel:SetActive(true)
      self._normalLevelRemainTimeLabel:SetText(StringTable.Get("str_n26_activity_normal_level_remain_time", timeStr))
    elseif status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd or status == ActivityComponentStatus.None then
      self._normalLevelEndPanel:SetActive(true)
      self._normalLevelMask:SetActive(true)
    elseif status == ActivityComponentStatus.TimeLock then
      self._normalLevelMask:SetActive(true)
    elseif status == ActivityComponentStatus.MissionLock then
      self._normalLevelMask:SetActive(true)
    end
  end)
  self._hardLevelButtonStatus = UIActivityN26ButtonStatus:New(function()
    return self._activityConst:GetHardLineMissionComponentStatus()
  end, function(TT)
    self:ReLoadData(TT, "hardlevel")
  end, function(status, timeStr)
    self._hardLevelEndPanel:SetActive(false)
    self._hardLevelLockTipsPanel:SetActive(false)
    self._hardLevelRemainTimePanel:SetActive(false)
    if status == ActivityComponentStatus.Open then
      self._hardLevelMask:SetActive(false)
      self._hardLevelRemainTimePanel:SetActive(true)
      self._hardLevelRemainTimeLabel:SetText(StringTable.Get("str_n26_activity_hard_level_remain_time", timeStr))
    elseif status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd or status == ActivityComponentStatus.None then
      self._hardLevelEndPanel:SetActive(true)
      self._hardLevelMask:SetActive(true)
    elseif status == ActivityComponentStatus.TimeLock then
      self._hardLevelLockTipsPanel:SetActive(true)
      self._hardLevelMask:SetActive(true)
      self._hardLevelLockTipsLabel:SetText(StringTable.Get("str_n26_activity_hard_level_lock_time_tips", timeStr))
    elseif status == ActivityComponentStatus.MissionLock then
      self._hardLevelLockTipsPanel:SetActive(true)
      self._hardLevelMask:SetActive(true)
      self._hardLevelLockTipsLabel:SetText(StringTable.Get("str_n26_activity_hard_level_lock_mission_tips"))
    end
  end)
  self._movieButtonStatus = UIActivityN26ButtonStatus:New(function()
    return self._activityConst:GetMovieComponentStatus()
  end, function(TT)
    self:ReLoadData(TT, "movie")
  end, function(status, timeStr)
    self._movieEndPanel:SetActive(false)
    self._movieRemainTimePanel:SetActive(false)
    if status == ActivityComponentStatus.Open then
      self._movieRemainTimePanel:SetActive(true)
      self._movieRemainTimeLabel:SetText(StringTable.Get("str_n26_activity_movie_remain_time", timeStr))
    elseif status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd or status == ActivityComponentStatus.None then
      self._movieEndPanel:SetActive(true)
    elseif status == ActivityComponentStatus.TimeLock then
    elseif status == ActivityComponentStatus.MissionLock then
    end
  end)
  self._miniGameButtonStatus = UIActivityN26ButtonStatus:New(function()
    return self._activityConst:GetMiniGameComponentStatus()
  end, function(TT)
    self:ReLoadData(TT, "minigame")
  end, function(status, timeStr)
    self._minGameEndPanel:SetActive(false)
    self._minGameRemainTimePanel:SetActive(false)
    self._miniGameLockTipsPanel:SetActive(false)
    if status == ActivityComponentStatus.Open then
      self._minGameMask:SetActive(false)
      self._minGameRemainTimePanel:SetActive(true)
      self._miniGameRemainTimeLabel:SetText(StringTable.Get("str_n26_activity_minigame_remain_time", timeStr))
    elseif status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd or status == ActivityComponentStatus.None then
      self._minGameEndPanel:SetActive(true)
      self._minGameMask:SetActive(true)
    elseif status == ActivityComponentStatus.TimeLock then
      self._miniGameLockTipsPanel:SetActive(true)
      self._minGameMask:SetActive(true)
      self._miniGameLockTipsLabel:SetText(StringTable.Get("str_n26_activity_minigame_lock_time_tips", timeStr))
    elseif status == ActivityComponentStatus.MissionLock then
      self._miniGameLockTipsPanel:SetActive(true)
      self._minGameMask:SetActive(true)
      self._miniGameLockTipsLabel:SetText(StringTable.Get("str_n26_activity_minigame_lock_mission_tips"))
    end
  end)
end

function UIActivityN26MainController:RefreshRedData()
  self:StartTask(function(TT)
    self:Lock("UIActivityN26MainController_ReLoadData")
    self:ReLoadData(TT, "Refresh")
    self:RefreshRed()
    self:RefreshShopBtnStatus()
    self:UnLock("UIActivityN26MainController_ReLoadData")
  end)
end

function UIActivityN26MainController:RefreshNew()
  self._normalLevelNew:SetActive(self._activityConst:IsShowNormalLineNew())
  self._hardLevelNew:SetActive(self._activityConst:IsShowHardLineNew())
  self._shopNew:SetActive(self._activityConst:IsShowShopNew())
  self._movieNew:SetActive(self._activityConst:IsShowMovieNew())
  self._miniGameNew:SetActive(self._activityConst:IsShowMiniGameNew())
end

function UIActivityN26MainController:RefreshRed()
  self._eventRed:SetActive(self._activityConst:IsShowBattlePassRed())
  self._loginRed:SetActive(self._activityConst:IsShowLoginRed())
  self._normalLevelRed:SetActive(self._activityConst:IsShowNormalLineRed())
  self._hardLevelRed:SetActive(self._activityConst:IsShowHardLineRed())
  self._shopRed:SetActive(self._activityConst:IsShowShopRed())
  self._movieRed:SetActive(self._activityConst:IsShowMovieRed())
  self._miniGameRed:SetActive(self._activityConst:IsShowMiniGameRed())
end

function UIActivityN26MainController:ReLoadData(TT, key)
  self:Lock("UIActivityN26MainController_ReLoadData" .. key)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  self:UnLock("UIActivityN26MainController_ReLoadData" .. key)
end

function UIActivityN26MainController:CloseCoro(TT)
  self:Lock("UIActivityN21CCMainController_CloseCoro")
  self:SwitchState(UIStateType.UIMain)
  self:UnLock("UIActivityN21CCMainController_CloseCoro")
end

function UIActivityN26MainController:RefreshUI()
  self:RefreshActivityRemainTime()
end

function UIActivityN26MainController:RefreshActivityRemainTime()
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n26_activity_end"))
    return
  end
  local endTime = self._activityConst:GetActiveEndTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
  end
  local timeStr = UIActivityN26Helper.GetTimeString(seconds)
  local timeTips = StringTable.Get("str_n26_activity_remain_time", timeStr)
  self._timeLabel:SetText(timeTips)
end

function UIActivityN26MainController:SetButtonShowStatus(TT, isShow)
  self._showBtn:SetActive(not isShow)
  self._btnPanel:SetActive(isShow)
  local aniName = "uieff_N26_MainController_out"
  if isShow then
    aniName = "uieff_N26_MainController_in"
  end
  self:Lock("UIActivityN26MainController_SetButtonShowStatus")
  self._anim:Play(aniName)
  YIELD(TT, 1500)
  self:UnLock("UIActivityN26MainController_SetButtonShowStatus")
end

function UIActivityN26MainController:PlayEnterPlot()
  self:ShowDialog("UIStoryController", self._activityConst:GetPlotId())
  self._activityConst:SetPlayPlotStatus()
end

function UIActivityN26MainController:RefreshShopBtnStatus()
  local shopCom, info = self._activityConst:GetShopComponent()
  local icon, count = shopCom:GetCostItemIconText()
  self._shopIconLoader:LoadImage(icon)
  self._shopCountLabel:SetText(UIActivityN26Helper.GetItemCountStr(7, count, "#8D8D8D", "#ffd146"))
end

function UIActivityN26MainController:InfoBtnOnClick()
  self:ShowDialog("UIIntroLoader", "UIN26Intro")
end

function UIActivityN26MainController:EventOnClick()
  UIActivityBattlePassHelper.OpenMainController()
end

function UIActivityN26MainController:LoginOnClick()
  local status, time = self._activityConst:GetLoginComponentStatus()
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_end"))
    return
  end
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N26, ECampaignN26ComponentID.ECAMPAIGN_N26_CUMULATIVE_LOGIN)
end

function UIActivityN26MainController:ShowBtnOnClick()
  GameGlobal.TaskManager():StartTask(self.SetButtonShowStatus, self, true)
end

function UIActivityN26MainController:PilotBtnOnClick()
  self:PlayEnterPlot()
end

function UIActivityN26MainController:NormalLevelOnClick()
  local status, time = self._activityConst:GetNormalLineMissionComponentStatus()
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_end"))
    return
  end
  self._activityConst:ClearNormalLineNew()
  self:RefreshNew()
  self:SwitchState(UIStateType.UIN26Line, self._activityConst)
end

function UIActivityN26MainController:HardLevelOnClick()
  local status, time = self._activityConst:GetHardLineMissionComponentStatus()
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_end"))
    return
  elseif status == ActivityComponentStatus.TimeLock then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_hard_level_lock_time_tips", UIActivityN26Helper.GetTimeString(time)))
    return
  elseif status == ActivityComponentStatus.MissionLock then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_hard_level_lock_mission_tips"))
    return
  end
  self._activityConst:ClearHardLineNew()
  self:RefreshNew()
  self:SwitchState(UIStateType.UIN26HardLevel, self._activityConst)
end

function UIActivityN26MainController:ShopOnClick()
  local status, time = self._activityConst:GetShopComponentStatus()
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_end"))
    return
  end
  self._activityConst:ClearShopNew()
  self:RefreshNew()
  self:ShowDialog("UIActivityN26Shop")
end

function UIActivityN26MainController:MovieOnClick()
  local status, time = self._activityConst:GetMovieComponentStatus()
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_end"))
    return
  end
  self._activityConst:ClearMovieNew()
  self:RefreshNew()
  self:ShowDialog("UIN26Movie")
end

function UIActivityN26MainController:MiniGameOnClick()
  local status, time = self._activityConst:GetMiniGameComponentStatus()
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_end"))
    return
  elseif status == ActivityComponentStatus.TimeLock then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_minigame_lock_time_tips", UIActivityN26Helper.GetTimeString(time)))
    return
  elseif status == ActivityComponentStatus.MissionLock then
    ToastManager.ShowToast(StringTable.Get("str_n26_activity_minigame_lock_mission_tips"))
    return
  end
  self._activityConst:ClearMiniGameNew()
  self:RefreshNew()
  self:SwitchState(UIStateType.UIN26CookMainController)
end
