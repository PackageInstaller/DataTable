_class("UIN39MainController", UIController)
UIN39MainController = UIN39MainController

function UIN39MainController:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime)
end

function UIN39MainController:_SetCommonTopButton()
  local function closeCallback()
    self:_Back()
  end
  
  local function hideCallback()
    self:_HideUI()
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback, nil, nil, false, hideCallback)
end

function UIN39MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UIN39MainController then
    if self._fromDis then
      self:SwitchState(UIStateType.UIDiscovery)
    else
      self:SwitchState(UIStateType.UIMain)
    end
  else
    self:CloseDialog()
  end
end

function UIN39MainController:_HideUI()
  self:GetGameObject("_showBtn"):SetActive(true)
  self:PlayAnim("hide")
end

function UIN39MainController:_ShowUI()
  self:GetGameObject("_showBtn"):SetActive(false)
  self:PlayAnim("show")
end

function UIN39MainController:_SetBg()
  local url = "n39_zjm_BG"
  if url then
    UIWidgetHelper.SetRawImage(self, "_mainBg", url)
  end
  local Title_wq = self:GetUIComponent("RawImageLoader", "Title_wq")
  local Title_wq_rawImage = self:GetUIComponent("RawImage", "Title_wq")
  local eff_zi = self:GetUIComponent("RawImage", "zi")
  Title_wq:LoadImage("n39_zjm_slogan2")
  local texture = Title_wq_rawImage.material.mainTexture
  eff_zi.texture = texture
end

function UIN39MainController:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n39_kv_1_spine_idle")
end

function UIN39MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN39MainController)
end

function UIN39MainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = UIN39Helper.GetCampaignType()
  local componentIds = UIN39Helper.GetComponentIds()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, campaignType, table.unpack(componentIds))
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self._campaign:ClearCampaignNew(TT)
  self._bp_campaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._bp_campaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  self._ny_campaign = UIActivityCampaign:New()
  self._ny_campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_N25_NEW_YEAR)
end

function UIN39MainController:SetPhoto()
  self._photo = self:GetUIComponent("RawImage", "Photo")
  if self._rt and self._photo then
    self._photo.gameObject:SetActive(true)
    self._photo.texture = self._rt
  else
    self._photo.gameObject:SetActive(false)
    Log.error("###[UIN39MainController] not photo or not rt !")
  end
end

function UIN39MainController:OnShow(uiParams)
  self._fromDis = uiParams[1]
  self._rt = uiParams[2]
  self:SetPhoto()
  self:_AttachEvents()
  self._isOpen = true
  self:_SetCommonTopButton()
  self:_SetBg()
  self:_SetSpine()
  local stop = self._campaign:GetSample().end_time
  self:_SetRemainingTime("_time", "str_n39_sample_remain_time", stop, true)
  self:_Refresh()
  self:InitAnim()
  self:PlayAnim("in")
  self:_CheckGuide()
  UIN39Helper.ClearNew("main")
end

function UIN39MainController:InitAnim()
  self._anim = self:GetUIComponent("Animation", "_anim")
  self._tag2anim = {
    ["in"] = {
      name = "uieffanim_UIN39MainController_in",
      time = 1167
    },
    out = {
      name = "uieffanim_UIN39MainController_out",
      time = 600
    },
    hide = {
      name = "uieffanim_UIN39MainController_hide",
      time = 500
    },
    show = {
      name = "uieffanim_UIN39MainController_show",
      time = 500
    }
  }
end

function UIN39MainController:PlayAnim(tag, callback)
  local tag2anim = self._tag2anim[tag]
  local animName = tag2anim.name
  self._anim:Play(animName)
  local time = tag2anim.time
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
  end
  self:Lock("UIN39MainController:PlayAnim")
  self._animTimer = GameGlobal.Timer():AddEvent(time, function()
    self:UnLock("UIN39MainController:PlayAnim")
    if callback then
      callback()
    end
  end)
end

function UIN39MainController:OnHide()
  self:_DetachEvents()
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
  end
  self:UnLock("UIN39MainController:PlayAnim")
  self._isOpen = false
end

function UIN39MainController:_Refresh()
  UIN39Helper.SetBattlePassBtn(self, "_battlePassBtn", self._bp_campaign)
  self:_SetLoginBtn()
  self:_SetLineLevelBtn()
  self:_SetHardLevelBtn()
  self:_SetExchangeBtn()
  self:_SetNYLoginBtn()
end

function UIN39MainController:_SetExchangeBtn()
  local cmptId, component, componentInfo = UIN39Helper.GetComponent(self._campaign, "exchange")
  local obj = UIWidgetHelper.SpawnObject(self, "_exchangeBtn", "UIN39MainBtnExchange")
  obj:SetLockStateCallback(function(timeStr)
    ToastManager.ShowToast(StringTable.Get("str_n39_main_btn_unlock_time", "", timeStr, ""))
  end, function(missionName)
    ToastManager.ShowToast(StringTable.Get("str_n39_hard_level_lock_tips", missionName))
  end, function()
    ToastManager.ShowToast(StringTable.Get("str_n39_sample_end"))
  end, function()
    if UIN39Helper.CheckCampaignOpen(self._campaign) then
      self:ShowDialog("UIN39ExchangeController")
    end
  end, function(tagName)
    local new = UIN39Helper.CheckNew("exchange")
    return new
  end, function(tagName)
    return component:HaveRedPoint()
  end)
  obj:SetData("exchange", self._campaign:GetComponent(UIN39Helper.GetComponentId("exchange")), self._campaign)
end

function UIN39MainController:_SetNYLoginBtn()
  local useStateUI = false
  local open_sample = self._ny_campaign:CheckCampaignOpen()
  local poolGo = self:GetGameObject("_ny_loginBtn")
  poolGo:SetActive(open_sample)
  if open_sample then
    local pool = self:GetUIComponent("UISelectObjectPath", "_ny_loginBtn")
    self._ny_btn = pool:SpawnObject("UICampaignEnterN39NYLogin")
    
    local function callback()
      if self._ny_campaign:CheckCampaignClose_ShowClientError() then
        return
      end
      UIActivityHelper.PlayFirstPlot_Campaign(self._ny_campaign, function()
        self._ny_campaign:OpenMainUI(useStateUI)
        UIN39Helper.ClearNew("ny_login")
      end, true)
    end
    
    self._ny_btn:SetData(self._ny_campaign, useStateUI, callback)
  end
end

function UIN39MainController:_SetLoginBtn()
  local cmptId, component, componentInfo = UIN39Helper.GetComponent(self._campaign, "login")
  local obj = UIWidgetHelper.SpawnObject(self, "_loginBtn", "UIActivityCommonComponentEnter")
  local btnName = "LoginBtn"
  
  local function newCallback()
    local new = UIN39Helper.CheckNew("login")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return self._campaign:CheckComponentOpen(cmptId) and self._campaign:CheckComponentRed(cmptId)
  end
  
  obj:SetRed("_red", redCallback)
  
  local function clickCallback()
    if UIN39Helper.CheckCampaignOpen(self._campaign) then
      UIN39Helper.ClearNew("login")
      local campaignType = UIN39Helper.GetCampaignType()
      self:ShowDialog("UIActivityTotalLoginAwardController", false, campaignType, cmptId)
    end
  end
  
  obj:SetData(self._campaign, clickCallback)
end

function UIN39MainController:_SetLineLevelBtn()
  local cmptId, component, componentInfo = UIN39Helper.GetComponent(self._campaign, "line")
  local obj = UIWidgetHelper.SpawnObject(self, "_lineLevelBtn", "UIN39MainBtnBase")
  obj:SetLockStateCallback(function(timeStr)
    ToastManager.ShowToast(StringTable.Get("str_n39_main_btn_unlock_time", "", timeStr, ""))
  end, function(missionName)
    ToastManager.ShowToast(StringTable.Get("str_n39_hard_level_lock_tips", missionName))
  end, function()
    ToastManager.ShowToast(StringTable.Get("str_n39_sample_end"))
  end, function()
    if UIN39Helper.CheckCampaignOpen(self._campaign) then
      self:SwitchState(UIStateType.UIN39LineMissionController)
    end
  end, function(tagName)
    local new = UIN39Helper.CheckNew("line")
    return new
  end, function(tagName)
    local haveRed = component:HaveRedPoint()
    local timePass = UIN39Helper.CheckComRedTime("line")
    return haveRed and timePass
  end)
  obj:SetRefreshCallback(function()
    self:RefreshCampaignInfo()
  end)
  obj:SetData("line", self._campaign:GetComponent(UIN39Helper.GetComponentId("line")), self._campaign)
end

function UIN39MainController:_SetHardLevelBtn()
  local cmptId, component, componentInfo = UIN39Helper.GetComponent(self._campaign, "hard")
  local cmptId2, component2, componentInfo2 = UIN39Helper.GetComponent(self._campaign, "black")
  local obj = UIWidgetHelper.SpawnObject(self, "_hardLevelBtn", "UIN39MainBtnBase")
  obj:SetLockStateCallback(function(timeStr)
    ToastManager.ShowToast(StringTable.Get("str_n39_main_btn_unlock_time", "", timeStr, ""))
  end, function(missionName)
    ToastManager.ShowToast(StringTable.Get("str_n39_hard_level_lock_tips", missionName))
  end, function()
    ToastManager.ShowToast(StringTable.Get("str_n39_sample_end"))
  end, function()
    if UIN39Helper.CheckCampaignOpen(self._campaign) then
      self:SwitchState(UIStateType.UIN39HardLevelMain)
    end
  end, function(tagName)
    local new = (not component:ComponentIsOpen() or not UIN39Helper.CheckNew("hard")) and component2:ComponentIsOpen() and UIN39Helper.CheckNew("black")
    return new
  end, function(tagName)
    local haveRed_hard = component:HaveRedPoint()
    local timePass_hard = UIN39Helper.CheckComRedTime("hard")
    local haveRed_black = component2:HaveRedPoint()
    local timePass_black = UIN39Helper.CheckComRedTime("black")
    return haveRed_hard and timePass_hard or haveRed_black and timePass_black
  end)
  obj:SetRefreshCallback(function()
    self:RefreshCampaignInfo()
  end)
  obj:SetData("hard", self._campaign:GetComponent(UIN39Helper.GetComponentId("hard")), self._campaign)
end

function UIN39MainController:RefreshCampaignInfo()
  if self._isLoadingCampaignInfo then
    return
  end
  self._isLoadingCampaignInfo = true
  self:Lock("UIN39MainController:RefreshCampaignInfo")
  GameGlobal.TaskManager():StartTask(self.OnRefreshCampaignInfo, self)
end

function UIN39MainController:OnRefreshCampaignInfo(TT)
  local res = AsyncRequestRes:New()
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._bp_campaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._bp_campaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  self._ny_campaign = UIActivityCampaign:New()
  self._ny_campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_N25_NEW_YEAR)
  self:_Refresh()
  self._isLoadingCampaignInfo = false
  self:UnLock("UIN39MainController:RefreshCampaignInfo")
end

function UIN39MainController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIN39MainController:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN39Intro", MaskType.MT_BlurMask)
end

function UIN39MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UIN39MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UIN39MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
  if self._ny_campaign and self._ny_campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN39MainController:_OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end
