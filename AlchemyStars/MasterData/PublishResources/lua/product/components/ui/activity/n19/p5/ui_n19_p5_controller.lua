_class("UIN19P5Controller", UIController)
UIN19P5Controller = UIN19P5Controller

function UIN19P5Controller:LoadDataOnEnter(TT, res, uiParams)
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N19_P5, ECampaignN19P5ComponentID.POWER2ITEM, ECampaignN19P5ComponentID.POWER_SHOP, ECampaignN19P5ComponentID.CUMULATIVE_LOGIN, ECampaignN19P5ComponentID.LEVEL)
  self._lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignN19P5ComponentID.POWER_SHOP)
  self._costItemID = self._lotteryComponentInfo.m_cost_item_id
  self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N19_P5)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, function()
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
  self:LoadDataOnEnter_BattlePass(TT)
end

function UIN19P5Controller:LoadDataOnEnter_BattlePass(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN19P5Controller:OnShow(uiParams)
  CutsceneManager.ExcuteCutsceneOut()
  self._rt = uiParams[1]
  self:GetComponents()
  self:AddListener()
  self:OnValue()
end

function UIN19P5Controller:AddListener()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.N19P5SignInRed, self.N19P5SignInRed)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self.OnComponentStepChange)
end

function UIN19P5Controller:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN19P5Controller:GetComponents()
  self.TimeDay = self:GetUIComponent("UILocalizationText", "TimeDay")
  self.TimeHour = self:GetUIComponent("UILocalizationText", "TimeHour")
  self.TimeMin = self:GetUIComponent("UILocalizationText", "TimeMin")
  self.itemCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self.backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self.SignInRed = self:GetGameObject("SignInRed")
  self.EventRed = self:GetGameObject("EventRed")
  self.PoolRed = self:GetGameObject("PoolRed")
  self.PetTryRed = self:GetGameObject("PetTryRed")
  self.EndStoryRed = self:GetGameObject("EndStoryRed")
  self.EndStory = self:GetGameObject("EndStory")
  self.ShowBtn = self:GetGameObject("ShowBtn")
  self.Full = self:GetGameObject("Full")
  self.uiAnim = self:GetUIComponent("Animation", "uiAnim")
  self.PetTryBtnView = self:GetUIComponent("RawImage", "PetTryBtnView")
  self.SignInBtnView = self:GetUIComponent("RawImage", "SignInBtnView")
  self.PetTryLock = self:GetGameObject("PetTryLock")
  self.SignInLock = self:GetGameObject("SignInLock")
  self.SignInRedRect = self:GetUIComponent("RectTransform", "SignInRed")
  self:SignInRedPos()
end

function UIN19P5Controller:SignInRedPos()
  local pos = Vector2(153, 14)
  local type = Localization.GetCurLanguage()
  if LanguageType.zh == type then
    pos = Vector2(153, 14)
  elseif LanguageType.tw == type then
    pos = Vector2(153, 14)
  elseif LanguageType.us == type then
    pos = Vector2(250, -60)
  elseif LanguageType.kr == type then
    pos = Vector2(153, 14)
  elseif LanguageType.jp == type then
    pos = Vector2(153, 14)
  elseif LanguageType.pt == type then
    pos = Vector2(250, -60)
  elseif LanguageType.es == type then
    pos = Vector2(250, -60)
  elseif LanguageType.idn == type then
    pos = Vector2(250, -60)
  elseif LanguageType.th == type then
    pos = Vector2(204, -20)
  end
  self.SignInRedRect.anchoredPosition = pos
end

function UIN19P5Controller:SetPetTryLock()
  local component = self._campaign:GetComponentInfo(ECampaignN19P5ComponentID.LEVEL)
  local endTime = component.m_close_time
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  self._petTryLock = endTime < nowTime
  local color
  if self._petTryLock then
    color = Color(0.39215686274509803, 0.39215686274509803, 0.39215686274509803, 1)
  else
    color = Color(1, 1, 1, 1)
  end
  self.PetTryLock:SetActive(self._petTryLock)
  self.PetTryBtnView.color = color
end

function UIN19P5Controller:SetSignInLock()
  local component = self._campaign:GetComponentInfo(ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  local endTime = component.m_close_time
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  self._signInLock = endTime < nowTime
  local color
  if self._signInLock then
    color = Color(0.39215686274509803, 0.39215686274509803, 0.39215686274509803, 1)
  else
    color = Color(1, 1, 1, 1)
  end
  self.SignInLock:SetActive(self._signInLock)
  self.SignInBtnView.color = color
end

function UIN19P5Controller:SetBtnLockState()
  self:SetSignInLock()
  self:SetPetTryLock()
end

function UIN19P5Controller:ItemCount()
  local itemModule = GameGlobal.GetModule(ItemModule)
  self.itemCount:SetText(itemModule:GetItemCount(self._costItemID))
  local cfg = Cfg.cfg_item[self._costItemID]
  if not cfg then
    Log.error("###[UIN19P5Controller] cfg is nil ! id --> ", self._costItemID)
  end
  self.itemIcon:LoadImage(cfg.Icon)
end

function UIN19P5Controller:OnHide()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
    self.animEvent = nil
  end
  if self._guideTask then
    GameGlobal.TaskManager():KillTask(self._guideTask)
    self._guideTask = nil
  end
end

function UIN19P5Controller:OnValue()
  local btns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, function()
    self:HideBtnOnClick()
  end)
  self:InitTimer()
  self:SetBtnLockState()
  self:ItemCount()
  self:Red()
  self:RT()
  self:_CheckGuide()
end

function UIN19P5Controller:RT()
  if self._rt then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = self._rt
  end
end

function UIN19P5Controller:InitTimer()
  local sample = self._campaign:GetSample()
  local overTime = sample.end_time
  self._overTime = overTime or 0
  if self._overTime > self._svrTimeModule:GetServerTime() * 0.001 then
    self._open = true
  else
    self._open = false
  end
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  if self._open then
    self._timerEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:SetTimerTex()
    end)
  end
  self:SetTimerTex()
end

function UIN19P5Controller:SetTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._overTime - svrTime
  if sec < 0 then
    self._open = false
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
  else
    local day, hour, min = HelperProxy:GetInstance():Sec2DayHourMin(sec)
    self.TimeDay:SetText(day)
    self.TimeHour:SetText(hour)
    self.TimeMin:SetText(min)
  end
end

function UIN19P5Controller:HideBtnOnClick()
  self.ShowBtn:SetActive(true)
  self:Lock("UIN19P5ControllerAnim")
  self.uiAnim:Play("UIN19P5Controller_out")
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
  end
  self.animEvent = GameGlobal.Timer():AddEvent(400, function()
    self:UnLock("UIN19P5ControllerAnim")
  end)
end

function UIN19P5Controller:N19P5SignInRed()
  local redSignIn = self:_CheckRedPoint(self.SignInRed, ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  self.SignInRed:SetActive(redSignIn)
end

function UIN19P5Controller:Red()
  local redEvent = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.EventRed:SetActive(redEvent)
  self:EndStoryShowAndRed()
  local redSignIn = self:_CheckRedPoint(self.SignInRed, ECampaignN19P5ComponentID.CUMULATIVE_LOGIN) and not self._signInLock
  self.SignInRed:SetActive(redSignIn)
  local redPool = self:_CheckRedPoint(self.PoolRed, ECampaignN19P5ComponentID.POWER_SHOP)
  self.PoolRed:SetActive(redPool)
  local redTry = self._localProcess:PetStageRedPoint() and not self._petTryLock
  self.PetTryRed:SetActive(redTry)
end

function UIN19P5Controller:OnComponentStepChange()
  local redEvent = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.EventRed:SetActive(redEvent)
end

function UIN19P5Controller:EndStoryShowAndRed()
  self._endStoryRed = false
  self._endStoryKey = "N19P5EndStoryKey"
  if LocalDB.GetInt(self._endStoryKey, 0) == 1 then
    self._endStoryRed = false
  else
    self._endStoryRed = true
  end
  self.EndStoryRed:SetActive(self._endStoryRed)
  self.EndStory:SetActive(self:_GetCampaignEndStoryBtnState())
end

function UIN19P5Controller:_GetCampaignEndStoryBtnState()
  local cfg = Cfg.cfg_n19_p5_end_story[1]
  if not cfg then
    return false
  end
  local endTime = self._loginModule:GetTimeStampByTimeStr(cfg.OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  return endTime <= nowTime
end

function UIN19P5Controller:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  return bShow
end

function UIN19P5Controller:IntrBtnOnClick(go)
  self:ShowDialog("UIN19P5IntrController", "UIN19P5Controller")
end

function UIN19P5Controller:SignInBtnOnClick(go)
  if self._signInLock then
    local tips = StringTable.Get("str_activity_common_notice_content")
    ToastManager.ShowToast(tips)
    return
  end
  self:ShowDialog("UIN19P5SignInController")
end

function UIN19P5Controller:EventBtnOnClick(go)
  UIActivityBattlePassHelper.OpenMainController()(self._battlepassCampaign)
end

function UIN19P5Controller:PoolBtnOnClick(go)
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIN19P5DrawCard .. "Open", function()
    self._campaignModule:CampaignSwitchState(true, UIStateType.UIN19P5DrawCard, UIStateType.UIMain, nil, self._campaign._id)
  end)
end

function UIN19P5Controller:PetTryBtnOnClick(go)
  if self._petTryLock then
    local tips = StringTable.Get("str_activity_common_notice_content")
    ToastManager.ShowToast(tips)
    return
  end
  self:ShowDialog("UIActivityPetTryPlusController", ECampaignType.CAMPAIGN_TYPE_N19_P5, ECampaignN19P5ComponentID.LEVEL, function(mid)
    local component = self._campaign:GetComponent(ECampaignN19P5ComponentID.LEVEL)
    return component:IsPassCamMissionID(mid)
  end, function(missionid)
    local ctx = self._missionModule:TeamCtx()
    local missionComponent = self._campaign:GetComponent(ECampaignN19P5ComponentID.LEVEL)
    local param = {
      missionid,
      missionComponent:GetCampaignMissionComponentId(),
      missionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end

function UIN19P5Controller:StartStoryBtnOnClick(go)
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  if cfg then
    local storyIDs = cfg.FirstEnterStoryID
    if storyIDs then
      local id = storyIDs[1]
      if id then
        self:ShowDialog("UIStoryController", id)
      end
    end
  end
end

function UIN19P5Controller:EndStoryBtnOnClick(go)
  if self._endStoryRed then
    LocalDB.SetInt(self._endStoryKey, 1)
  end
  self.EndStoryRed:SetActive(false)
  local cfg = Cfg.cfg_n19_p5_end_story[1]
  local id = cfg.StoryID
  self:ShowDialog("UIStoryController", id)
end

function UIN19P5Controller:ShowBtnOnClick(go)
  self.ShowBtn:SetActive(false)
  self:Lock("UIN19P5ControllerAnim")
  self.uiAnim:Play("UIN19P5Controller_in")
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
  end
  self.animEvent = GameGlobal.Timer():AddEvent(400, function()
    self:UnLock("UIN19P5ControllerAnim")
  end)
end

function UIN19P5Controller:_CheckGuide()
  self:Lock("UIN19P5ControllerCheckGuide")
  self._guideTask = self:StartTask(function(TT)
    YIELD(TT, 400)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN19P5Controller)
    self:UnLock("UIN19P5ControllerCheckGuide")
  end)
end
