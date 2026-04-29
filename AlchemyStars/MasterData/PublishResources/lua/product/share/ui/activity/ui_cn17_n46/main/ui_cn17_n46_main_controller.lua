_class("UICN17N46MainController", UIShareController)
UICN17N46MainController = UICN17N46MainController

function UICN17N46MainController:_SetCommonTopButton()
  local shareComponent = UICN17N46Helper.GetComponent(self._campaign, "share")
  self:InitShare(shareComponent)
  
  local function closeCallback()
    self:_Back()
  end
  
  local function hideCallback()
    self:_HideUI()
  end
  
  local showShare = true
  
  local function shareCallback()
    self:OnShare(function()
      self:_HideUI()
      self:GetGameObject("_backBtns"):SetActive(false)
      self:GetGameObject("_showBtn"):SetActive(true)
      self:GetGameObject("_uiElements"):SetActive(false)
    end, function()
      self:_ShowUI()
    end)
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback, nil, nil, false, hideCallback, showShare, shareCallback)
end

function UICN17N46MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UICN17N46MainController then
    self:SwitchState(UIStateType.UIMain)
  else
    self:CloseDialog()
  end
end

function UICN17N46MainController:_HideUI()
  self:_PlayAnim("hide", function()
    self:GetGameObject("_backBtns"):SetActive(false)
    self:GetGameObject("_showBtn"):SetActive(true)
    self:GetGameObject("_uiElements"):SetActive(false)
  end)
end

function UICN17N46MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(true)
  self:_PlayAnim("show", function()
  end)
end

function UICN17N46MainController:_SetRemainingTime(widgetName, descId, endTime, tickCallback, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UICN17N46MainController:_SetSpine()
  local spine = self:GetUIComponent("SpineLoader", "_spine")
  local campid = self._campaign._id
  local cfg = Cfg.cfg_campaign_main_spine[campid]
  if cfg then
    local spineName = cfg.SpineName
    if spineName then
      spine:LoadSpine(spineName)
    end
    local spineAnim = cfg.SpineAnim
    if spineAnim then
      local lineComInfo = self._campaign:GetComponentInfo(UICN17N46Helper.GetComponentId("line"))
      local passInfo = lineComInfo.m_pass_mission_info
      local showSpineAnim
      for i = #spineAnim, 1, -1 do
        local data = spineAnim[i]
        local missionid = tonumber(data[1])
        if passInfo[missionid] then
          showSpineAnim = data[2]
          break
        end
      end
      if showSpineAnim then
        local skeleton
        if spine.CurrentSkeleton then
          skeleton = spine.CurrentSkeleton
        else
          skeleton = spine.CurrentMultiSkeleton
        end
        skeleton.AnimationState:SetAnimation(0, showSpineAnim, true)
      end
    end
  end
end

function UICN17N46MainController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = imgRT
    return true
  end
  return false
end

function UICN17N46MainController:_CheckGuide()
end

function UICN17N46MainController:_PlayAnim(idx, callback)
  local tb = {
    hide = {
      animName = "uieffanim_UICN17N46MainController_hide",
      duration = 500
    },
    show = {
      animName = "uieffanim_UICN17N46MainController_show",
      duration = 500
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UICN17N46MainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = UICN17N46Helper.GetCampaignType()
  local componentIds = {}
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  UICN17N46Helper.LocalDB_Set("main", "New")
  self._bp_campaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._bp_campaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UICN17N46MainController:OnShow(uiParams)
  self:_AttachEvents()
  self:_SetCommonTopButton()
  self:_SetSpine()
  self:_UpdateRemainingTime()
  self:_CheckGuide()
  self:_Refresh()
  self.overFirstTime = true
end

function UICN17N46MainController:OnHide()
  self:_DetachEvents()
end

function UICN17N46MainController:_Refresh()
  UICN17N46Helper.SetBattlePassBtn(self, "_battlePassBtn", self._bp_campaign)
  UICN17N46Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign, not self.overFirstTime)
  self:_SetLoginBtn()
  self:_SetLineBtn()
  self:_SetBlackBtn()
end

function UICN17N46MainController:_UpdateRemainingTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local exchangeItemComponent = UICN17N46Helper.GetComponentInfo(self._campaign, "exchange")
  local endTime = exchangeItemComponent.m_close_time
  local stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_time", "str_cn17_n46_btn_time_2", endTime)
    return
  end
end

function UICN17N46MainController:_SetLoginBtn()
  local name = "login"
  local cmptId = UICN17N46Helper.GetComponentId(name)
  local obj = UIWidgetHelper.SpawnObject(self, "_loginBtn", "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = UICN17N46Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("new", newCallback)
  
  local function redCallback()
    local red = UICN17N46Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("red", redCallback)
  
  local function clickCallback()
    UICN17N46Helper.LocalDB_Set(name, "New")
    local campaignType = UICN17N46Helper.GetCampaignType()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, campaignType, cmptId)
  end
  
  obj:SetData(self._campaign, clickCallback)
end

function UICN17N46MainController:_SetLineBtn()
  local name = "line"
  local cmptId = UICN17N46Helper.GetComponentId(name)
  local component = UICN17N46Helper.GetComponent(self._campaign, name)
  local obj = UIWidgetHelper.SpawnObject(self, "_lineBtn", "UIActivityCN17N46CommonComponentEnterLock")
  obj:SetAnimName("uieffanim_UICN17N46_LineBtn", "uieffanim_UICN17N46_LineBtn_lock")
  
  local function newCallback()
    local new = UICN17N46Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN17N46Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("_red", redCallback)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  local closeTime = component and component:GetComponentInfo().m_close_time or 0
  obj:SetActivityCommonRemainingTime("_time_unlock", "str_cn17_n46_btn_time_1", closeTime, true)
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
  local state = UIStateType.UICN17N46LineController
  
  local function clickCallback()
    UICN17N46Helper.LocalDB_Set(name, "New")
    local lineKey = UICN17N46Helper._LocalDB_GetKey(name, "Red")
    UIActivityHelper.SetCmptRedViewed(lineKey)
    local componentMain = CampaignConst.GetSafeStateInfo(self._campaign._id, cmptId, state, nil)
    self._campaign._campaign_module:SwitchState_Safe(true, {componentMain})
  end
  
  obj:SetData(self._campaign, cmptId, clickCallback)
  if not self.overFirstTime then
    obj:PlayAnim()
  end
end

function UICN17N46MainController:_SetBlackBtn()
  local name = "black"
  local cmptId = UICN17N46Helper.GetComponentId(name)
  local component = UICN17N46Helper.GetComponent(self._campaign, name)
  local obj = UIWidgetHelper.SpawnObject(self, "_hardBtn", "UIActivityCN17N46CommonComponentEnterLock")
  obj:SetAnimName("uieffanim_UICN17N46_HardBtn", "uieffanim_UICN17N46_LineBtn_lock")
  
  local function newCallback()
    local new = UICN17N46Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN17N46Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("_red", redCallback)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local endTime = component:ComponentUnLockTime() or 0
  local stamp = endTime - curTime
  local lineComponentInfo = UICN17N46Helper.GetComponentInfo(self._campaign, "line")
  local isMissionLock = lineComponentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] == nil
  if isMissionLock or 0 < stamp then
    if 0 < stamp then
      obj:SetActivityCommonRemainingTime("_time_lock", "str_activity_start_in", unlockTime, true, nil, function(first)
        if lineComponentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] ~= nil then
          obj:GetGameObject("state_lock"):SetActive(true)
          self:_Refresh()
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
  obj:SetActivityCommonRemainingTime("_time_unlock", "str_cn17_n46_btn_time_1", closeTime, false)
  
  local function lockWithTimeCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  end
  
  local function lockCallback()
    local missionName = Cfg.cfg_campaign_mission[component:GetComponentInfo().m_need_mission_id].Name
    local lvName = StringTable.Get(missionName)
    ToastManager.ShowToast(StringTable.Get("str_activity_hard_level_lock_tips", lvName))
  end
  
  local function closedCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
  end
  
  obj:SetLockStateCallback(lockWithTimeCallback, lockCallback, closedCallback)
  local state = UIStateType.UICN17N46HardLevel
  
  local function clickCallback()
    UICN17N46Helper.LocalDB_Set(name, "New")
    local blackKey = UICN17N46Helper._LocalDB_GetKey(name, "Red")
    UIActivityHelper.SetCmptRedViewed(blackKey)
    local componentMain = CampaignConst.GetSafeStateInfo(self._campaign._id, cmptId, state, nil)
    self._campaign._campaign_module:SwitchState_Safe(true, {componentMain})
  end
  
  obj:SetData(self._campaign, cmptId, clickCallback)
  if not self.overFirstTime then
    obj:PlayAnim()
  end
end

function UICN17N46MainController:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UICN17N46Intro", MaskType.MT_BlurMask)
end

function UICN17N46MainController:ShowBtnOnClick()
  self:_ShowUI()
end

function UICN17N46MainController:_AttachEvents()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN17N46MainController:_DetachEvents()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN17N46MainController:_AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end

function UICN17N46MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
  if self._ny_campaign and self._ny_campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN17N46MainController:_OnItemChanged(id)
  self:_Refresh()
end
