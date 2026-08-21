_class("UIActivityN25MainController", UIController)
UIActivityN25MainController = UIActivityN25MainController

function UIActivityN25MainController:Constructor(ui_root_transform)
  self.normalEntryBtn = nil
  self.hardEntryBtn = nil
  self.idolEntryBtn = nil
  self.bloodSuckerEntryBtn = nil
  self.mCampaign = self:GetModule(CampaignModule)
  self.strsLeftTime = {
    "str_n25_left_time_d_h",
    "str_n25_left_time_d",
    "str_n25_left_time_h_m",
    "str_n25_left_time_h",
    "str_n25_left_time_m"
  }
  self.strsLineLeftTime = {
    "str_n25_line_left_time_d_h",
    "str_n23_line_left_time_d",
    "str_n25_line_left_time_h_m",
    "str_n25_line_left_time_h",
    "str_n25_line_left_time_m"
  }
end

function UIActivityN25MainController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIActivityN25Const:New()
  self._activityConst:LoadData(TT, res)
end

function UIActivityN25MainController:OnShow(uiParam)
  self.screenShot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._eventRed = self:GetGameObject("EventRed")
  self._loginRed = self:GetGameObject("LoginRed")
  self.animation = self:GetUIComponent("Animation", "animation")
  self.showBtn = self:GetGameObject("ShowBtn")
  self.showBtn:SetActive(false)
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._btnPanel = self:GetGameObject("BtnPanel")
  self._topBtn = self:GetGameObject("TopBtn")
  self.shotImage = self:GetUIComponent("RawImage", "ScrrenTex")
  self.shotImageGo = self:GetGameObject("ScrrenTex")
  self.shotImageGo:SetActive(false)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UINewCommonTopButton")
  backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    self:SetButtonShowStatus(false)
  end)
  self:AttachEvent(GameEventType.OnActivityTotalAwardGot, self.ForceUpdate)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.ForceUpdate)
  self:AttachEvent(GameEventType.ItemCountChanged, self.SetExchangeBtn)
  self:InitUI()
  UIActivityN25Const.ClearEnterNewStatus()
end

function UIActivityN25MainController:OnHide()
  self:DetachEvent(GameEventType.OnActivityTotalAwardGot, self.ForceUpdate)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self.ForceUpdate)
  self:DetachEvent(GameEventType.ItemCountChanged, self.SetExchangeBtn)
  self:CancelTimerEventNormal()
  if self.screenShot then
    self.screenShot:CleanRenderTexture()
    self.screenShot = nil
  end
end

function UIActivityN25MainController:OnUpdate(deltaTimeMS)
  self:RefreshUI()
end

function UIActivityN25MainController:CloseCoro(TT)
  self:Lock("UIActivityN21CCMainController_CloseCoro")
  self:SwitchState(UIStateType.UIMain)
  self:UnLock("UIActivityN21CCMainController_CloseCoro")
end

function UIActivityN25MainController:SetButtonShowStatus(isShow)
  self.showBtn:SetActive(not isShow)
  if isShow then
    self.animation:Play("uianim_UIActivityN25MainController_in2")
  else
    self.animation:Play("uianim_UIActivityN25MainController_in1")
  end
end

function UIActivityN25MainController:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN25MainController:PlayEnterAnimCoro(TT)
  self:_CheckGuide()
end

function UIActivityN25MainController:InitUI()
  self:SetSpineAndBgm()
  self:RefreshRedAndNew()
  self:SetNormalLevelBtn()
  self:SetHardLevelBtn()
  self:SetExchangeBtn()
  self:SetIdolBtn()
  self:SetBloodSuckerBtn()
  self:RefreshUI()
  self:RefreshButtonStatus()
  self:PlayEnterAnim()
end

function UIActivityN25MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN25MainController)
end

function UIActivityN25MainController:RefreshUI()
  self:RefreshActivityRemainTime()
end

function UIActivityN25MainController:RefreshButtonStatus()
  self:FlushRedPointStageNormal()
  self:FlushNormalStage()
end

function UIActivityN25MainController:FlushNormalStage()
  if not self.normalEntryBtn then
    Log.fatal("### FlushNormalStage, btn is nil")
    return
  end
  self.normalEntryBtn:SetLock(true)
  local c, cInfo = self._activityConst:GetLineComponent()
  if not cInfo then
    Log.fatal("### GetLineComponent nil.")
    return
  end
  local componentId = ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION
  local state = self._activityConst:GetStateNormal()
  if state == UISummerOneEnterBtnState.NotOpen then
  elseif state == UISummerOneEnterBtnState.Closed then
    self:CancelTimerEventNormal()
    self.normalEntryBtn:SetLeftTime(StringTable.Get("str_activity_finished"))
  elseif state == UISummerOneEnterBtnState.Normal then
    self.normalEntryBtn:SetLock(false)
    self.normalEntryBtn:SetLeftTimeShow(false)
    local closeTime = cInfo.m_close_time
    local leftSeconds = UICommonHelper.CalcLeftSeconds(closeTime)
    self:RegisterTimeEvent(leftSeconds, componentId)
  else
    Log.fatal("### state=", state)
  end
end

function UIActivityN25MainController:RegisterTimeEvent(seconds, componentId)
  if componentId == ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION then
    self:CancelTimerEventNormal()
  else
    Log.warn("### RegisterTimeEvent componentId=", componentId)
    return
  end
  if seconds < 60 then
    seconds = 60
  end
  local ms = seconds * 1000
  local te = GameGlobal.Timer():AddEvent(ms, function()
    self:StartTask(function(TT)
      self._activityConst:ForceUpdate(TT)
      if componentId == ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION then
        self:FlushNormalStage()
      end
    end, self)
  end)
  if componentId == ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION then
    self.teNormal = te
  end
end

function UIActivityN25MainController:FlushRedPointStageNormal()
  if self.normalEntryBtn then
    local red = self._activityConst:CheckRedNormal() or self._activityConst:CheckRedTryPet() or self._activityConst:CheckRedShop()
    local new = self._activityConst:CheckNewNormal()
    self.normalEntryBtn:SetNewAndRed(new, red)
  end
end

function UIActivityN25MainController:RefreshActivityRemainTime()
  local endTime = self._activityConst:GetActiveEndTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
  end
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n25_activity_end"))
    return
  end
  local status = self._activityConst:GetStatus()
  if seconds == 0 and status == 1 then
    self._activityConst:SetStatus(2)
    return
  end
  local timeStr = UIActivityN25Const.GetTimeString(seconds)
  local timeTips
  local c, cInfo = self._activityConst:GetLineComponent()
  if cInfo then
    local lineEndTime = cInfo.m_close_time
    local lineSeconds = math.floor(lineEndTime - nowTime)
    if 0 < lineSeconds then
      local timeStr = UIActivityN25Const.GetTimeString(lineSeconds)
      timeTips = StringTable.Get("str_n25_activity_remain_time", timeStr)
      self._timeLabel:SetText(timeTips)
      return
    end
  end
  timeTips = StringTable.Get("str_n25_activity_remain_time", timeStr)
  self._timeLabel:SetText(timeTips)
end

function UIActivityN25MainController:CancelTimerEventNormal()
  if self.teNormal then
    GameGlobal.Timer():CancelEvent(self.teNormal)
    self.teNormal = nil
  end
end

function UIActivityN25MainController:RefreshRedAndNew()
  self._eventRed:SetActive(self._activityConst:IsShowBattlePassRed())
  self._loginRed:SetActive(self._activityConst:CheckRedAward())
end

function UIActivityN25MainController:ForceUpdate(callback)
  self:StartTask(self.ReLoadData, self, callback)
end

function UIActivityN25MainController:ReLoadData(TT, callback)
  self:Lock("UIActivityN25MainController_ReLoadData")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  self:RefreshRedAndNew()
  self:UnLock("UIActivityN25MainController_ReLoadData")
  if callback and type(callback) == "function" then
    callback()
  end
end

function UIActivityN25MainController:ShowBtnOnClick()
  self:SetButtonShowStatus(true)
end

function UIActivityN25MainController:EventOnClick()
  UIActivityBattlePassHelper.OpenMainController()
end

function UIActivityN25MainController:LoginOnClick()
  if self._activityConst:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_n25_activity_end"))
    return
  end
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_CUMULATIVE_LOGIN)
end

function UIActivityN25MainController:SetNormalLevelBtn()
  local normalEntry = self:_SpawnObject("NormalLevelBtn", "UIN25EntryBtnBase")
  self.normalEntryBtn = normalEntry
  local isNew = self._activityConst:CheckNewNormal()
  local isRed = self._activityConst:CheckRedNormal() or self._activityConst:CheckRedTryPet() or self._activityConst:CheckRedShop()
  local state = self._activityConst:GetStateNormal()
  if state == UISummerOneEnterBtnState.Normal then
    normalEntry:SetLock(false)
  else
    normalEntry:SetLock(true)
  end
  normalEntry:SetData(function()
    local s = self._activityConst:GetStateNormal()
    if s == UISummerOneEnterBtnState.Normal then
      self:SwitchState(UIStateType.UIN25Line, self._activityConst)
    else
      self:_ShowBtnErrorMsg(s)
    end
  end)
  normalEntry:SetNewAndRed(isNew, isRed)
end

function UIActivityN25MainController:SetHardLevelBtn()
  local hardEntry = self:_SpawnObject("HardLevelBtn", "UIN25EntryBtnHardLevel")
  self.hardEntryBtn = hardEntry
  hardEntry:SetData(function()
    local s = self._activityConst:GetStateHard()
    if s == UISummerOneEnterBtnState.Normal then
      N25Data.SetPrefsHard()
      self:SwitchState(UIStateType.UIActivtiyN25HardLevelController)
    elseif s == UISummerOneEnterBtnState.Locked then
      ToastManager.ShowToast(StringTable.Get("str_n25_hardlevel_locktip"))
    else
      self:_ShowBtnErrorMsg(s)
    end
  end)
  hardEntry:RefreshState(self._activityConst)
end

function UIActivityN25MainController:_ShowBtnErrorMsg(btnState)
  local errType = 0
  if btnState == UISummerOneEnterBtnState.NotOpen then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
  elseif btnState == UISummerOneEnterBtnState.Closed then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
  end
  self.mCampaign:ShowErrorToast(errType, true)
end

function UIActivityN25MainController:SetExchangeBtn()
  local componentId = ECampaignN25ComponentID.ECAMPAIGN_N25_SHOP
  local obj = self:_SpawnObject("ExchangeBtn", "UIActivityCommonComponentEnter")
  local campain = self._activityConst:GetCampaign()
  local red = self._activityConst:CheckRedShop()
  obj:SetRed("red", function()
    return campain:CheckComponentOpen(componentId) and campain:CheckComponentRed(componentId)
  end)
  local component, componentInfo = self._activityConst:GetShopComponent()
  local icon, count = component:GetCostItemIconText()
  if icon then
    obj:SetIcon("icon", icon)
  end
  local fmtStr = UIActivityN20MainController.GetItemCountStr(count, "#847D7D", "#ffe671")
  obj:SetText("text", fmtStr)
  obj:SetText("txtNumbg", UIActivityN20MainController.GetItemCountStr(count, "#312E1B", "#312E1B"))
  obj:SetData(campain, function()
    if campain:CheckCampaignClose_ShowClientError() then
      return
    end
    UIActivityHelper.OpenCampaignShop(campain)
  end)
end

function UIActivityN25MainController:SetIdolBtn()
  local idolEntry = self:_SpawnObject("IdolBtn", "UIN25EntryBtnIdol")
  self.idolEntryBtn = idolEntry
  idolEntry:SetData(function()
    local s = self._activityConst:GetStateGameIdol()
    if s == UISummerOneEnterBtnState.Normal then
      local c, cInfo = self._activityConst:GetIdolComponent()
      if cInfo.m_b_unlock then
        self:OpenIdol()
      else
        self:ForceUpdate(function()
          self:OpenIdol()
        end)
      end
    elseif s == UISummerOneEnterBtnState.Locked then
      ToastManager.ShowToast(StringTable.Get("str_n25_hardlevel_locktip"))
    else
      self:_ShowBtnErrorMsg(s)
    end
  end)
  idolEntry:RefreshState(self._activityConst)
end

function UIActivityN25MainController:OpenIdol()
  N25Data.SetPrefsGameIdol()
  UIActivityHelper.PlayFirstPlot_Component(self._activityConst._campaign, ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL, function()
    self:SwitchState(UIStateType.UIN25IdolLogin, self._activityConst)
  end)
end

function UIActivityN25MainController:SetBloodSuckerBtn()
  local bloodSuckerEntry = self:_SpawnObject("BloodSuckerBtn", "UIN25EntryBtnBloodSucker")
  self.bloodSuckerEntryBtn = bloodSuckerEntry
  bloodSuckerEntry:SetData(function()
    local s = self._activityConst:GetStateGameBloodSucker()
    if s == UISummerOneEnterBtnState.Normal then
      self:OpenBloodSucker()
    else
      self:_ShowBtnErrorMsg(s)
    end
  end)
  bloodSuckerEntry:RefreshState(self._activityConst)
end

function UIActivityN25MainController:OpenBloodSucker()
  UIActivityHelper.Snap(self.screenShot, self:GetUIComponent("RectTransform", "SafeArea").rect.size, GameGlobal.UIStateManager():GetControllerCamera(self:GetName()), function(cache_rt)
    N25Data.SetPrefsGameBloodSucker()
    self:SwitchState(UIStateType.UIN25VampireMain, cache_rt)
  end)
end

function UIActivityN25MainController:InfoBtnOnClick()
  self:ShowDialog("UIIntroLoader", "UIN25Intro")
end

function UIActivityN25MainController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN25MainController:SetSpineAndBgm()
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  local spine, bgm = self._activityConst:GetSpineAndBgm()
  if spine then
    self._spine:LoadSpine(spine)
  end
  if bgm then
    AudioHelperController.PlayBGM(bgm, AudioConstValue.BGMCrossFadeTime)
  end
end
