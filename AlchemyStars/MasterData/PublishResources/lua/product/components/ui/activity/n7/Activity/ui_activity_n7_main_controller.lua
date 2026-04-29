_class("UIActivityN7MainController", UIController)
UIActivityN7MainController = UIActivityN7MainController

function UIActivityN7MainController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self.data = self._campaignModule:GetN7BlackFightData()
  local ret = self.data:RequestCampaign(TT)
  self._campaign = self.data.activityCampaign
  res:SetResult(ret:GetResult())
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  if not (self._campaign and self._campaign._id) or self._campaign._id <= 0 then
    Log.warn("### campain not open.")
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  local bpRes = AsyncRequestRes:New()
  bpRes:SetSucc(true)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, bpRes, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  if not bpRes:GetSucc() then
    Log.error("获取战斗通行证数据失败")
  end
  self._cumulativeLoginComponent = self._localProcess:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN)
  self._cumulativeLoginCompInfo = self._localProcess:GetComponentInfo(ECampaignN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN)
  self._lineMissionComponet = self._localProcess:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
  self._lineMissionCompInfo = self._localProcess:GetComponentInfo(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
  self._lineMissionFixteamComponet = self._localProcess:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM)
  self._lineMissionFixteamCompInfo = self._localProcess:GetComponentInfo(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM)
  self._blackfistComponent = self._localProcess:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_BLACKFIST)
  self._blackfistComponentInfo = self._localProcess:GetComponentInfo(ECampaignN7ComponentID.ECAMPAIGN_N7_BLACKFIST)
  self._personProgressComponent = self._localProcess:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_PRESTIGE)
  self._personProgressComponentInfo = self._localProcess:GetComponentInfo(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_PRESTIGE)
  self._campaignId = self._campaign._id
  local cfg_campaign = Cfg.cfg_campaign[self._campaignId]
  self._name = StringTable.Get(cfg_campaign.CampaignName)
  self._subName = StringTable.Get(cfg_campaign.CampaignSubtitle)
  local missionEndTime = 0
  if self._blackfistComponentInfo then
    missionEndTime = self._blackfistComponentInfo.m_close_time
  end
  local sample = self._campaign:GetSample()
  if not sample then
    return
  end
  local nowTime = self._timeModule:GetServerTime() / 1000
  self._activeEndTime = sample.end_time
  if nowTime > self._activeEndTime then
    Log.error("Time error!")
    return
  end
  if missionEndTime <= nowTime then
    self._status = 2
    self._endTime = self._activeEndTime
  else
    self._status = 1
    self._endTime = missionEndTime
  end
  self._campaign:ClearCampaignNew(TT)
  self._redDotModule = GameGlobal.GetModule(RedDotModule)
  self:RequestData(TT)
end

function UIActivityN7MainController:RefreshData()
  local curSalutation = self.data:GetCurSalutation()
  if curSalutation then
    self._blackFightAwardName = curSalutation.salutation or ""
  end
end

function UIActivityN7MainController:IsLoginEnable()
  if not self._cumulativeLoginComponent then
    return false
  end
  return self._cumulativeLoginComponent:ComponentIsOpen()
end

function UIActivityN7MainController:IsMissionEnable()
  if not self._lineMissionComponet then
    return false
  end
  return self._lineMissionComponet:ComponentIsOpen()
end

function UIActivityN7MainController:IsBlackFightAwardEnable()
  if not self._personProgressComponent then
    return false
  end
  return self._personProgressComponent:ComponentIsOpen()
end

function UIActivityN7MainController:IsBlackFightEnable()
  if not self._blackfistComponent then
    return false
  end
  return self._blackfistComponent:ComponentIsOpen()
end

function UIActivityN7MainController:IsShowLoginRed()
  if not self:IsLoginEnable() then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN)
end

function UIActivityN7MainController:IsShowEventRed()
  if self._battlepassCampaign then
    return UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  end
  return false
end

function UIActivityN7MainController:IsShowLevelRed()
  if not self:IsMissionEnable() then
    return false
  end
  return self._redStatus[RedDotType.RDT_SHADOW_TOWN] or false
end

function UIActivityN7MainController:IsShowBlackFightAwardRed()
  if not self:IsBlackFightAwardEnable() then
    return false
  end
  local existNotReadPaper, _ = GameGlobal.GetModule(CampaignModule):GetN7BlackFightData():ExistNotReadPaper()
  if existNotReadPaper then
    return true
  end
  return self._redStatus[RedDotType.RDT_BLACKFIST_PRESTIGE] or false
end

function UIActivityN7MainController:IsShowBlackFightRed()
  if not self:IsBlackFightEnable() then
    return false
  end
  return self._redStatus[RedDotType.RDT_BLACKFIST_FUNCTION] or false
end

function UIActivityN7MainController:_GetComponent()
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._showBtn = self:GetGameObject("ShowBtn")
  self._showBtn:SetActive(false)
  self._btnPanel = self:GetGameObject("BtnPanel")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    self._showBtn:SetActive(true)
    self._anim:Play("uieff_N7_Main_Hide")
  end)
  self._loginRed = self:GetGameObject("LoginRed")
  self._eventRed = self:GetGameObject("EventRed")
  self._blackFightAwardRed = self:GetGameObject("BlackFightAwardRed")
  self._levelRed = self:GetGameObject("LevelRed")
  self._blackFightRed = self:GetGameObject("BlackFightRed")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._timeTitleLabel = self:GetUIComponent("UILocalizationText", "TimeTitle")
  self._timeTitleBgLabel = self:GetUIComponent("UILocalizationText", "TimeTitleBg")
  self._awardNameLabel = self:GetUIComponent("UILocalizationText", "AwardName")
  self._awardNamebgLabel = self:GetUIComponent("UILocalizationText", "AwardNameBg")
end

function UIActivityN7MainController:OnShow(uiParams)
  local isMainEnter = uiParams[1] and true
  self:_GetComponent()
  self:AttachEvent(GameEventType.ActivityN7MainRefresh, self.RequestAndRefresh)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.OnComponentStepChange)
  self:AttachEvent(GameEventType.SummerTwoLoginRed, self.RefreshRed)
  self:InitRemainTime()
  self:Refresh()
  self:CheckGuide()
  if isMainEnter then
    self._anim:Play("uieff_N7_Main_In2")
  else
    self._anim:Play("uieff_N7_Main_In")
  end
  CutsceneManager.ExcuteCutsceneOut()
end

function UIActivityN7MainController:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self.OnComponentStepChange)
  self:DetachEvent(GameEventType.ActivityN7MainRefresh, self.RequestAndRefresh)
  self:DetachEvent(GameEventType.SummerTwoLoginRed, self.RefreshRed)
end

function UIActivityN7MainController:RequestAndRefresh()
  self:StartTask(self.RequestData, self, function()
    self:Refresh()
  end)
end

function UIActivityN7MainController:RequestData(TT, callback)
  self:Lock("UIActivityN7MainController_RequestData")
  local checkList = {}
  checkList[#checkList + 1] = RedDotType.RDT_SHADOW_TOWN
  checkList[#checkList + 1] = RedDotType.RDT_BLACKFIST_PRESTIGE
  checkList[#checkList + 1] = RedDotType.RDT_BLACKFIST_FUNCTION
  self._redStatus = self._redDotModule:RequestRedDotStatus(TT, checkList)
  if callback then
    callback()
  end
  self:UnLock("UIActivityN7MainController_RequestData")
end

function UIActivityN7MainController:CloseCoro(TT)
  self:Lock("UIActivityN7MainController_CloseCoro")
  self:SwitchState(UIStateType.UIMain)
  self:UnLock("UIActivityN7MainController_CloseCoro")
end

function UIActivityN7MainController:Refresh()
  self:RefreshData()
  self:RefreshUI()
end

function UIActivityN7MainController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN7MainController)
end

function UIActivityN7MainController:RefreshUI()
  self._awardNameLabel:SetText(self._blackFightAwardName)
  self._awardNamebgLabel:SetText(self._blackFightAwardName)
  self:RefreshRed()
end

function UIActivityN7MainController:RefreshRed()
  self._loginRed:SetActive(self:IsShowLoginRed())
  self._eventRed:SetActive(self:IsShowEventRed())
  self._blackFightAwardRed:SetActive(self:IsShowBlackFightAwardRed())
  self._levelRed:SetActive(self:IsShowLevelRed())
  self._blackFightRed:SetActive(self:IsShowBlackFightRed())
end

function UIActivityN7MainController:OnComponentStepChange(campaign_id, component_id, component_step)
  self._eventRed:SetActive(self:IsShowEventRed())
end

function UIActivityN7MainController:InitRemainTime()
  self:RefreshRemainTime()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:RefreshRemainTime()
  end)
end

function UIActivityN7MainController:RefreshRemainTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  if self._endTime == nil then
    return
  end
  local seconds = math.floor(self._endTime - nowTime)
  if seconds < 0 then
    seconds = 0
  end
  if seconds == 0 and self._status == 2 then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if seconds == 0 and self._status == 1 then
    self._endTime = self._activeEndTime
    self._status = 2
    return
  end
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_n7_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_n7_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_n7_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_n7_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_n7_less_minus")
  end
  local timeTips = ""
  if self._status == 1 then
    timeTips = StringTable.Get("str_n7_time_tips1")
  elseif self._status == 2 then
    timeTips = StringTable.Get("str_n7_time_tips2")
  end
  self._timeLabel:SetText(timeStr)
  self._timeTitleBgLabel:SetText(timeTips)
  self._timeTitleLabel:SetText(timeTips)
end

function UIActivityN7MainController:ShowBtnOnClick()
  self._showBtn:SetActive(false)
  self._anim:Play("uieff_N7_Main_Show")
end

function UIActivityN7MainController:InfoBtnOnClick()
  self:ShowDialog("UIActivityN7Intro", "UIActivityN7MainController")
end

function UIActivityN7MainController:EventBtnOnClick()
  UIActivityBattlePassHelper.OpenMainController()
end

function UIActivityN7MainController:LoginBtnOnClick()
  if not self:IsLoginEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n7_login_component_close_tips"))
    return
  end
  self:ShowDialog("UIActivityTotalLoginAwardController", true, ECampaignType.CAMPAIGN_TYPE_N7, ECampaignN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN)
end

function UIActivityN7MainController:LevelBtnOnClick()
  if not self:IsMissionEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n7_level_component_close_tips"))
    return
  end
  Log.error("LevelBtnOnClick")
  self._campaignModule:CampaignSwitchState(true, UIStateType.UIN7Level, UIStateType.UIMain, nil, self._campaign._id)
end

function UIActivityN7MainController:BlackFightAwardBtnOnClick()
  if not self:IsBlackFightAwardEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n7_black_fight_award_component_close_tips"))
    return
  end
  self:ShowDialog("UIBlackFightReputation")
end

function UIActivityN7MainController:BlackFightBtnOnClick()
  self:SwitchState(UIStateType.UIBlackFightMain)
end
