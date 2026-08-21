_class("UIN38MainController", UIController)
UIN38MainController = UIN38MainController

function UIN38MainController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIN38Const:New()
  self._activityConst:LoadData(TT, res)
  self._campaign = self._activityConst:GetCampaign()
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
  end
end

function UIN38MainController:OnShow()
  self._interval = 0
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._showBtnGO = self:GetGameObject("ShowBtn")
  self:_OnValue()
  CutsceneManager.ExcuteCutsceneOut(function()
    UIActivityHelper.PlayFirstPlot_Campaign(self._activityConst:GetCampaign())
  end)
  self._activityConst:ClearEnterNew()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  self:AttachEvent(GameEventType.OnActivityTotalAwardGot, self.RefreshData)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.RefreshData)
  self:AttachEvent(GameEventType.ActivityMainStatusRefreshEvent, self.RefreshData)
  self:PlayEnterAnim()
end

function UIN38MainController:_OnValue()
  self:_SetCommonTopButton()
  self:_SetTitle()
  self:_SetLoginBtn()
  self:_SetBPBtn()
  self:_SetExchange()
  self:_SetLineLevelBtn()
  self:_SetHardLevelBtn()
  self:RefreshRemainTime()
end

function UIN38MainController:AfterUILayerChanged()
  if self._loginWidget then
    self._loginWidget:_CheckPoint()
  end
  if self._bpWidget then
    self._bpWidget:_CheckPoint()
  end
  if self._exchangeWidget then
    self._exchangeWidget:SetNewRedPoint()
    self._exchangeWidget:SetData(self._activityConst)
  end
  if self._lineWidget then
    self._lineWidget:SetNewRedPoint()
  end
  if self._hardWidget then
    self._hardWidget:SetNewRedPoint()
  end
end

function UIN38MainController:_SetCommonTopButton()
  local function closeCallback()
    self:_Back()
  end
  
  local function hideCallback()
    self:StartTask(function(TT)
      self:Lock("UIN38MainControllerHide")
      self:StartTask(function(TT)
        self._anim:Play("uianim_UIN38MainController_hide")
        YIELD(TT, 567)
        self._showBtnGO:SetActive(true)
        self:UnLock("UIN38MainControllerHide")
      end)
    end)
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "BackBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback, nil, nil, false, hideCallback)
end

function UIN38MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UIN38MainController then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN38MainController:_SetExchange()
  self._exchangeWidget = UIWidgetHelper.SpawnObject(self, "ExchangeBtn", "UIN38_ExchangeBtn")
  self._exchangeWidget:SetData(self._activityConst)
  self._exchangeWidget:SetNewRedPoint()
end

function UIN38MainController:_SetTitle()
  self._titleWidget = UIWidgetHelper.SpawnObject(self, "Title", "UIN38_Main_Title")
end

function UIN38MainController:_SetLineLevelBtn()
  self._lineWidget = UIWidgetHelper.SpawnObject(self, "LineLevelBtn", "UIN38_LineLevelBtn")
  self._lineWidget:SetData(self._activityConst)
  self._lineWidget:SetNewRedPoint()
end

function UIN38MainController:_SetHardLevelBtn()
  self._hardWidget = UIWidgetHelper.SpawnObject(self, "HardLevelBtn", "UIN38_HardLevelBtn")
  self._hardWidget:SetData(self._activityConst)
  self._hardWidget:SetNewRedPoint()
end

function UIN38MainController:_SetLoginBtn()
  local cmptId, component, componentInfo = UIN38Helper.GetComponent(self._campaign, "login")
  self._loginWidget = UIWidgetHelper.SpawnObject(self, "LoginBtn", "UIActivityCommonComponentEnter")
  local btnName = "LoginBtn"
  
  local function newCallback()
    local new = not UIN38Helper.LocalDB_Has(btnName, "New")
    return new
  end
  
  self._loginWidget:SetNew("New", newCallback)
  
  local function redCallback()
    return self._campaign:CheckComponentOpen(cmptId) and self._campaign:CheckComponentRed(cmptId)
  end
  
  self._loginWidget:SetRed("Red", redCallback)
  
  local function clickCallback()
    UIN38Helper.LocalDB_Set(btnName, "New")
    local campaignType = UIN38Helper.GetCampaignType()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, campaignType, cmptId)
  end
  
  self._loginWidget:SetData(self._campaign, clickCallback)
end

function UIN38MainController:_SetBPBtn()
  self._bpWidget = UIWidgetHelper.SpawnObject(self, "BattlePassBtn", "UIActivityCommonComponentEnter")
  local btnName = "BattlePassBtn"
  
  local function newCallback()
    local new = not UIN38Helper.LocalDB_Has(btnName, "New")
    return new
  end
  
  self._bpWidget:SetNew("New", newCallback)
  
  local function redCallback()
    return UIActivityHelper.CheckCampaignSampleRedPoint(self._activityConst._battlepassCampaign)
  end
  
  self._bpWidget:SetRed("Red", redCallback)
  
  local function clickCallback()
    UIActivityBattlePassHelper.OpenMainController()
    UIN38Helper.LocalDB_Set(btnName, "New")
  end
  
  self._bpWidget:SetData(self._activityConst._battlepassCampaign, clickCallback)
end

function UIN38MainController:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIN38MainController:PlayEnterAnimCoro(TT)
  self:Lock("UIN38MainController_PlayEnterAnimCoro")
  self._anim:Play("uianim_UIN38MainController_in")
  YIELD(TT, 1000)
  self:UnLock("UIN38MainController_PlayEnterAnimCoro")
  self:_CheckGuide()
end

function UIN38MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN38MainController)
end

function UIN38MainController:OnUpdate(deltaTimeMS)
  self._interval = self._interval + deltaTimeMS
  if self._interval >= 1000 then
    self._interval = 0
    self:RefreshRemainTime()
    if self._lineWidget then
      self._lineWidget:SetData(self._activityConst)
    end
    if self._hardWidget then
      local componentInfo = self._activityConst._hardLineMissionompInfo
      if componentInfo then
        local openTime = componentInfo.m_unlock_time
        local closeTime = componentInfo.m_close_time
        local nowTime = self:GetModule(SvrTimeModule):GetServerTime() / 1000
        if openTime <= nowTime and not self.refreshHard then
          self:RefreshData()
          self.refreshHard = true
        else
          self._hardWidget:SetData(self._activityConst)
        end
      else
        self._hardWidget:SetData(self._activityConst)
      end
    end
  end
end

function UIN38MainController:OnHide()
  self:DetachEvent(GameEventType.OnActivityTotalAwardGot, self.RefreshData)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self.RefreshData)
  self:DetachEvent(GameEventType.ActivityMainStatusRefreshEvent, self.RefreshData)
  if self._taskIdMainBaseRefreshData then
    self._taskIdMainBaseRefreshData = nil
  end
end

function UIN38MainController:ReLoadData(TT, key)
  self:Lock("UIN38MainController_ReLoadData" .. key)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  self:UnLock("UIN38MainController_ReLoadData" .. key)
end

function UIN38MainController:RefreshRemainTime()
  if self._titleWidget then
    if self._activityConst:IsActivityEnd() then
      self._titleWidget:SetRemainTime(StringTable.Get("str_n26_activity_end"))
      return
    end
    local endTime = self._activityConst:GetActiveEndTime()
    local nowTime = self._timeModule:GetServerTime() / 1000
    local seconds = math.floor(endTime - nowTime)
    if seconds <= 0 then
      seconds = 0
    end
    local timeStr = UIN38Helper.GetTimeString(seconds)
    local timeTips = StringTable.Get("str_n26_activity_remain_time", timeStr)
    self._titleWidget:SetRemainTime(timeTips)
  end
end

function UIN38MainController:IntroBtnOnClick()
  self:ShowDialog("UIIntroLoader", "UIN38Intro")
end

function UIN38MainController:ShowBtnOnClick()
  self:Lock("UIN38MainControllerShow")
  self:StartTask(function(TT)
    self._anim:Play("uianim_UIN38MainController_show")
    YIELD(TT, 667)
    self._showBtnGO:SetActive(false)
    self:UnLock("UIN38MainControllerShow")
  end)
end

function UIN38MainController:RefreshData()
  self._taskIdMainBaseRefreshData = self:StartTask(function(TT)
    self:ReLoadData(TT, "Refresh")
  end)
end
