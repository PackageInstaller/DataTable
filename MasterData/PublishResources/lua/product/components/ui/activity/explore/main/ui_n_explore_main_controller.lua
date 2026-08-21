_class("UINExploreMainController", UIController)
UINExploreMainController = UINExploreMainController

function UINExploreMainController:_SetCommonTopButton()
  local function closeCallback()
    self:_Back()
  end
  
  local function hideCallback()
    self:_HideUI()
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback, nil, nil, false, hideCallback)
end

function UINExploreMainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UINExploreMainController then
    self:SwitchState(UIStateType.UIMain)
  else
    self:_PlayAnim("out", function()
      self:CloseDialog()
    end)
  end
end

function UINExploreMainController:_HideUI()
  self:GetGameObject("_backBtns"):SetActive(false)
  self:GetGameObject("_showBtn"):SetActive(true)
  self:_PlayAnim("hide")
end

function UINExploreMainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:_PlayAnim("show")
end

function UINExploreMainController:_SetRemainingTime(widgetName, descId, endTime, tickCallback, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UINExploreMainController:_SetBg()
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, 1)
  if url then
    UIWidgetHelper.SetRawImage(self, "_mainBg", url)
  end
end

function UINExploreMainController:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n40_kv_1_spine_idle")
end

function UINExploreMainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UINExploreMainController)
end

function UINExploreMainController:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uieff_UINExploreMainController_in",
      duration = 1033
    },
    hide = {
      animName = "uieff_UINExploreMainController_hide",
      duration = 500
    },
    show = {
      animName = "uieff_UINExploreMainController_show",
      duration = 500
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UINExploreMainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = UINExploreHelper.GetCampaignType()
  local componentIds = {}
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  self._campaign:ClearCampaignNew(TT)
  self._bp_campaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._bp_campaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UINExploreMainController:OnShow(uiParams)
  self:_AttachEvents()
  self:_SetCommonTopButton()
  self:_SetBg()
  self:_SetSpine()
  local stop = self._campaign:GetSample().end_time
  self:_SetRemainingTime("_time", "str_n37_sample_remain_time", stop)
  self:_Refresh()
  UIActivityHelper.Snap_SetImgRt(uiParams[1], self, "rt", function(setImgRt)
    local idx = setImgRt and "in" or ""
    self:_PlayAnim(idx, function()
      self:_CheckGuide()
    end)
  end)
end

function UINExploreMainController:OnHide()
  self:_DetachEvents()
end

function UINExploreMainController:Destroy()
end

function UINExploreMainController:_Refresh()
  UINExploreHelper.SetBattlePassBtn(self, "_battlePassBtn", self._bp_campaign)
  self:_SetLoginBtn()
  self:_SetPowerBtn()
  UINExploreHelper.SetExchangeBtn(self, "_exchangeBtn", self._campaign)
end

function UINExploreMainController:_SetLoginBtn()
  local name = "login"
  local cmptId, component, componentInfo = UINExploreHelper.GetComponent(self._campaign, name)
  local obj = UIWidgetHelper.SpawnObject(self, "_loginBtn", "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = UINExploreHelper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UINExploreHelper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("_red", redCallback)
  
  local function clickCallback()
    UINExploreHelper.LocalDB_Set(name, "New")
    local campaignType = UINExploreHelper.GetCampaignType()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, campaignType, cmptId)
  end
  
  obj:SetData(self._campaign, clickCallback)
end

function UINExploreMainController:_SetPowerBtn()
  local name = "power"
  local cmptId, component, componentInfo = UINExploreHelper.GetComponent(self._campaign, name)
  local obj = UIWidgetHelper.SpawnObject(self, "_powerBtn", "UIActivityCommonComponentEnterLock")
  obj:SetLockStateCallback(nil, nil, function()
    ToastManager.ShowToast(StringTable.Get("str_n37_sample_end"))
  end)
  
  local function newCallback()
    local new = not UINExploreHelper.LocalDB_Has(name, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return component:HaveRedPoint()
  end
  
  obj:SetRed("_red", redCallback)
  local tb = {
    {"state_lock", "time_lock"},
    {"state_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  local state = UIStateType.UIDiscovery
  
  local function clickCallback()
    UINExploreHelper.LocalDB_Set(name, "New")
    self:_GotoCanPlayNode()
  end
  
  obj:SetData(self._campaign, cmptId, clickCallback)
  local node = self:_GetCanPlayNode()
  local str = node and StringTable.Get("str_nexplore_main_power_progress", node.name) or ""
  UIWidgetHelper.SetLocalizationText(obj, "txtProgress", str)
end

function UINExploreMainController:_GetCanPlayNode()
  local missionModule = self:GetModule(MissionModule)
  local discoveryData = missionModule:GetDiscoveryData()
  local node = discoveryData:GetCanPlayNode()
  return node
end

function UINExploreMainController:_GotoCanPlayNode()
  local node = self:_GetCanPlayNode()
  if node then
    DiscoveryData.EnterStateUIDiscovery(5, node.id)
  else
    discoveryData.EnterStateUIDiscovery(1)
  end
end

function UINExploreMainController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UINExploreMainController:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UINExploreIntro")
end

function UINExploreMainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UINExploreMainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UINExploreMainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UINExploreMainController:_OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end

function UINExploreMainController:_SetTexture(targetWidget, srcName)
  local test = self:_LoadAsset(srcName, LoadType.Mat)
  if test then
    local srcMat = self:GetAsset(srcName, LoadType.Mat)
    local meshRenderer = self:GetUIComponent("MeshRenderer", targetWidget)
    meshRenderer.sharedMaterial:SetTexture("_MainTex", srcMat:GetTexture("_MainTex"))
  end
end

function UINExploreMainController:_LoadAsset(name, type)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, type)
  if req == nil or req.Obj == nil then
    Log.info("UINExploreMainController:_LoadAsset() name =", name, "type =", type)
    return
  end
  return req.Obj
end
