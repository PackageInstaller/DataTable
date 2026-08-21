_class("UICN12N41MainController", UIController)
UICN12N41MainController = UICN12N41MainController

function UICN12N41MainController:_SetCommonTopButton()
  self:GetGameObject("shareTip"):SetActive(false)
  
  local function closeCallback()
    self:_Back()
  end
  
  local function hideCallback()
    self:_HideUI()
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback, nil, nil, false, hideCallback)
end

function UICN12N41MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UICN12N41MainController then
    self:SwitchState(UIStateType.UIMain)
  else
    self:_PlayAnim("out", function()
      self:CloseDialog()
    end)
  end
end

function UICN12N41MainController:_HideUI()
  self:_PlayAnim("hide", function()
    self:GetGameObject("_backBtns"):SetActive(false)
    self:GetGameObject("_showBtn"):SetActive(true)
    self:GetGameObject("_uiElements"):SetActive(false)
  end)
end

function UICN12N41MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(true)
  self:_PlayAnim("show", function()
  end)
end

function UICN12N41MainController:_SetRemainingTime(widgetName, descId, endTime, tickCallback, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UICN12N41MainController:_SetBg()
  UIWidgetHelper.SetRawImage(self, "_mainBg", "N41_zjm_bg")
  local req = ResourceManager:GetInstance():SyncLoadAsset("N41_zjm_tx05.mat", LoadType.Mat)
  if req then
    local srcMat = self:GetAsset("N41_zjm_tx05.mat", LoadType.Mat)
    local mainTitle = self:GetUIComponent("RawImage", "MainTitle")
    mainTitle.material:SetTexture("_MainTex", srcMat.mainTexture)
  end
end

function UICN12N41MainController:_SetSpine()
  self:GetGameObject("_mainBg"):SetActive(false)
  self:GetGameObject("_spine"):SetActive(true)
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n41_kv_1_spine_idle")
  local req = ResourceManager:GetInstance():SyncLoadAsset("N41_zjm_tx05.mat", LoadType.Mat)
  if req then
    local srcMat = self:GetAsset("N41_zjm_tx05.mat", LoadType.Mat)
    local mainTitle = self:GetUIComponent("RawImage", "MainTitle")
    mainTitle.material:SetTexture("_MainTex", srcMat.mainTexture)
  end
end

function UICN12N41MainController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = imgRT
    return true
  end
  return false
end

function UICN12N41MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UICN12N41MainController)
end

function UICN12N41MainController:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uieff_UICN12N41MainController_in",
      duration = 1567
    },
    hide = {
      animName = "uieff_UINCN12N41MainController_hide",
      duration = 433
    },
    show = {
      animName = "uieff_UINCN12N41MainController_show",
      duration = 500
    },
    out = {
      animName = "uieff_UICN12N41MainController_out",
      duration = 367
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UICN12N41MainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = UICN12N41Helper.GetCampaignType()
  local componentIds = {}
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  self._campaign:ClearCampaignNew(TT)
  self._bp_campaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._bp_campaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UICN12N41MainController:OnShow(uiParams)
  self:_AttachEvents()
  self:_SetCommonTopButton()
  self:_SetSpine()
  self:_UpdateRemainingTime()
  self:GetGameObject("rt"):SetActive(false)
  self:_PlayAnim("in", function()
    self:_CheckGuide()
    self:_Refresh()
  end)
end

function UICN12N41MainController:OnHide()
  self:_DetachEvents()
end

function UICN12N41MainController:_Refresh()
  UICN12N41Helper.SetBattlePassBtn(self, "_battlePassBtn", self._bp_campaign)
  UICN12N41Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign)
  self:_SetLoginBtn()
  self:_SetLineBtn()
  self:_SetHardBtn()
end

function UICN12N41MainController:_UpdateRemainingTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local lineComponentInfo = UICN12N41Helper.GetComponentInfo(self._campaign, "line")
  local endTime = lineComponentInfo.m_close_time
  local stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_time", "str_cn12_n41_shop_close_time_tips", endTime, nil, function(first)
      self:_Refresh()
    end)
    return
  end
  local exchangeItemComponent = UICN12N41Helper.GetComponentInfo(self._campaign, "exchange")
  endTime = exchangeItemComponent.m_close_time
  stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_time", "str_cn12_n41_shop_close_time_tips", endTime)
    return
  end
end

function UICN12N41MainController:_SetLoginBtn()
  local name = "login"
  local cmptId = UICN12N41Helper.GetComponentId(name)
  local obj = UIWidgetHelper.SpawnObject(self, "_loginBtn", "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = UICN12N41Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("new", newCallback)
  
  local function redCallback()
    local red = UICN12N41Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("red", redCallback)
  
  local function clickCallback()
    UICN12N41Helper.LocalDB_Set(name, "New")
    local campaignType = UICN12N41Helper.GetCampaignType()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, campaignType, cmptId)
  end
  
  obj:SetData(self._campaign, clickCallback)
end

function UICN12N41MainController:_SetLineBtn()
  local name = "line"
  local cmptId = UICN12N41Helper.GetComponentId(name)
  local component = UICN12N41Helper.GetComponent(self._campaign, name)
  local obj = UIWidgetHelper.SpawnObject(self, "_lineBtn", "UIActivityCN12N41CommonComponentEnterLock")
  
  local function newCallback()
    local new = UICN12N41Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN12N41Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("_red", redCallback)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  local closeTime = component and component:GetComponentInfo().m_close_time or 0
  obj:SetActivityCommonRemainingTime("_time_unlock", "str_cn12_n41_shop_close_time_tips", closeTime, true)
  local tb = {
    {"state_lock"},
    {"state_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  
  local function lockWithTimeCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  end
  
  local lockCallback
  
  local function closedCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
  end
  
  obj:SetLockStateCallback(lockWithTimeCallback, lockCallback, closedCallback)
  local state = UIStateType.UICN12N41LineController
  
  local function clickCallback()
    UICN12N41Helper.LocalDB_Set(name, "New")
    UICN12N41Helper.LocalDB_Set_CrossDay(name, "Red")
    local componentMain = CampaignConst.GetSafeStateInfo(self._campaign._id, cmptId, state, nil)
    self._campaign._campaign_module:SwitchState_Safe(true, {componentMain})
  end
  
  obj:SetData(self._campaign, cmptId, clickCallback)
end

function UICN12N41MainController:_SetHardBtn()
  local name = "hard"
  local cmptId = UICN12N41Helper.GetComponentId(name)
  local component = UICN12N41Helper.GetComponent(self._campaign, name)
  local obj = UIWidgetHelper.SpawnObject(self, "_hardBtn", "UIActivityCN12N41CommonComponentEnterLock")
  
  local function newCallback()
    local new = UICN12N41Helper.CalcNew_Component(self._campaign, name)
    local newblack = UICN12N41Helper.CalcNew_Component(self._campaign, "black")
    return new or newblack
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN12N41Helper.CalcRed_Component(self._campaign, name)
    local redblack = UICN12N41Helper.CalcRed_Component(self._campaign, "black")
    return red or redblack
  end
  
  obj:SetRed("_red", redCallback)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local endTime = component:ComponentUnLockTime() or 0
  local stamp = endTime - curTime
  local lineComponentInfo = UICN12N41Helper.GetComponentInfo(self._campaign, "line")
  local isMissionLock = lineComponentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] == nil
  local passlock = obj:GetUIComponent("UILocalizedTMP", "_pass_lock")
  local missionName = Cfg.cfg_campaign_mission[component:GetComponentInfo().m_need_mission_id].Name
  local lvName = StringTable.Get(missionName)
  local text = StringTable.Get("str_cn12_n41_hard_level_lock_tips", lvName)
  passlock:SetText(text)
  if isMissionLock or 0 < stamp then
    if 0 < stamp then
      obj:SetActivityCommonRemainingTime("_time_lock", "str_cn12_n41_line_lock_time_tips", unlockTime, true, nil, function(first)
        if lineComponentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] ~= nil then
          obj:GetGameObject("state_lock"):SetActive(true)
          UIWidgetHelper.PlayAnimation(obj, "_anime", "uieff_UINCN12N41MainController_BtnUnlock", 667, function()
            self:_Refresh()
          end)
        else
          self:_Refresh()
        end
      end)
    elseif isMissionLock then
    end
  end
  local tb = {
    {"state_lock", "_time_lock"},
    {"state_lock", "_pass_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  local closeTime = component and component:GetComponentInfo().m_close_time or 0
  obj:SetActivityCommonRemainingTime("_time_unlock", "str_cn12_n41_shop_close_time_tips", closeTime, false)
  
  local function lockWithTimeCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  end
  
  local function lockCallback()
    local missionName = Cfg.cfg_campaign_mission[component:GetComponentInfo().m_need_mission_id].Name
    local lvName = StringTable.Get(missionName)
    ToastManager.ShowToast(StringTable.Get("str_cn12_n41_hard_level_lock_tips", lvName))
  end
  
  local function closedCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
  end
  
  obj:SetLockStateCallback(lockWithTimeCallback, lockCallback, closedCallback)
  local state = UIStateType.UICN12N41HardController
  
  local function clickCallback()
    UICN12N41Helper.LocalDB_Set(name, "New")
    UICN12N41Helper.LocalDB_Set_CrossDay(name, "Red")
    local componentMain = CampaignConst.GetSafeStateInfo(self._campaign._id, cmptId, state, nil)
    self._campaign._campaign_module:SwitchState_Safe(true, {componentMain})
  end
  
  obj:SetData(self._campaign, cmptId, clickCallback)
end

function UICN12N41MainController:_HardBtnUnlockLocalDB(save)
  local key = UIActivityHelper.GetLocalDBKeyWithPstId("HardBtnUnlock")
  if save then
    LocalDB.SetInt(key, 1)
  else
    return LocalDB.HasKey(key)
  end
end

function UICN12N41MainController:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UICN12N41Intro")
end

function UICN12N41MainController:ShowBtnOnClick()
  self:_ShowUI()
end

function UICN12N41MainController:_AttachEvents()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN12N41MainController:_DetachEvents()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN12N41MainController:_AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end

function UICN12N41MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
  if self._ny_campaign and self._ny_campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN12N41MainController:_OnItemChanged(id)
  self:_Refresh()
end
