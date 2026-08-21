require("ui_share_controller")
_class("UICN16N45MainController", UIShareController)
UICN16N45MainController = UICN16N45MainController

function UICN16N45MainController:_SetCommonTopButton()
  local shareComponent = UICN16N45Helper.GetComponent(self._campaign, "share")
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

function UICN16N45MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UICN16N45MainController then
    self:SwitchState(UIStateType.UIMain)
  else
    self:CloseDialog()
  end
end

function UICN16N45MainController:_HideUI()
  self:_PlayAnim("hide", function()
    self:GetGameObject("_backBtns"):SetActive(false)
    self:GetGameObject("_showBtn"):SetActive(true)
    self:GetGameObject("_uiElements"):SetActive(false)
  end)
end

function UICN16N45MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(true)
  self:_PlayAnim("show", function()
  end)
end

function UICN16N45MainController:_SetRemainingTime(widgetName, descId, endTime, tickCallback, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UICN16N45MainController:_SetSpine()
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
      local lineComInfo = self._campaign:GetComponentInfo(UICN16N45Helper.GetComponentId("line"))
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

function UICN16N45MainController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = imgRT
    return true
  end
  return false
end

function UICN16N45MainController:_CheckGuide()
end

function UICN16N45MainController:_PlayAnim(idx, callback)
  local tb = {
    hide = {
      animName = "uieff_UICN16N45MainController_out",
      duration = 433
    },
    show = {
      animName = "uieff_UICN16N45MainController_in",
      duration = 500
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UICN16N45MainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = UICN16N45Helper.GetCampaignType()
  local componentIds = {}
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  UICN16N45Helper.LocalDB_Set("main", "New")
  self._bp_campaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._bp_campaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UICN16N45MainController:OnShow(uiParams)
  self:_AttachEvents()
  self:_SetCommonTopButton()
  self:_SetSpine()
  self:_UpdateRemainingTime()
  self:_CheckGuide()
  self:_Refresh()
  self.overFirstTime = true
end

function UICN16N45MainController:OnHide()
  self:_DetachEvents()
end

function UICN16N45MainController:_Refresh()
  UICN16N45Helper.SetBattlePassBtn(self, "_battlePassBtn", self._bp_campaign)
  UICN16N45Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign)
  self:_SetLoginBtn()
  self:_SetLineBtn()
  self:_SetBlackBtn()
end

function UICN16N45MainController:_UpdateRemainingTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local exchangeItemComponent = UICN16N45Helper.GetComponentInfo(self._campaign, "exchange")
  local endTime = exchangeItemComponent.m_close_time
  local stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_time", "str_cn16_n45_shop_close_time_tips", endTime)
    return
  end
end

function UICN16N45MainController:_SetLoginBtn()
  local name = "login"
  local cmptId = UICN16N45Helper.GetComponentId(name)
  local obj = UIWidgetHelper.SpawnObject(self, "_loginBtn", "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = UICN16N45Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("new", newCallback)
  
  local function redCallback()
    local red = UICN16N45Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("red", redCallback)
  
  local function clickCallback()
    UICN16N45Helper.LocalDB_Set(name, "New")
    local campaignType = UICN16N45Helper.GetCampaignType()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, campaignType, cmptId)
  end
  
  obj:SetData(self._campaign, clickCallback)
end

function UICN16N45MainController:_SetLineBtn()
  local name = "line"
  local cmptId = UICN16N45Helper.GetComponentId(name)
  local component = UICN16N45Helper.GetComponent(self._campaign, name)
  local obj = UIWidgetHelper.SpawnObject(self, "_lineBtn", "UIActivityCN16N45CommonComponentEnterLock")
  
  local function newCallback()
    local new = UICN16N45Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN16N45Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("_red", redCallback)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  local closeTime = component and component:GetComponentInfo().m_close_time or 0
  obj:SetActivityCommonRemainingTime("_time_unlock", "str_cn16_n45_remain_time_in_activity", closeTime, true)
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
  local state = UIStateType.UICN16N45LineController
  
  local function clickCallback()
    UICN16N45Helper.LocalDB_Set(name, "New")
    local lineKey = UICN16N45Helper._LocalDB_GetKey(name, "Red")
    UIActivityHelper.SetCmptRedViewed(lineKey)
    local componentMain = CampaignConst.GetSafeStateInfo(self._campaign._id, cmptId, state, nil)
    self._campaign._campaign_module:SwitchState_Safe(true, {componentMain})
  end
  
  obj:SetData(self._campaign, cmptId, clickCallback)
end

function UICN16N45MainController:_SetBlackBtn()
  local name = "black"
  local cmptId = UICN16N45Helper.GetComponentId(name)
  local component = UICN16N45Helper.GetComponent(self._campaign, name)
  local obj = UIWidgetHelper.SpawnObject(self, "_hardBtn", "UIActivityCN16N45CommonComponentEnterLock")
  
  local function newCallback()
    local new = UICN16N45Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN16N45Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("_red", redCallback)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local endTime = component:ComponentUnLockTime() or 0
  local stamp = endTime - curTime
  local lineComponentInfo = UICN16N45Helper.GetComponentInfo(self._campaign, "line")
  local isMissionLock = lineComponentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] == nil
  if isMissionLock or 0 < stamp then
    if 0 < stamp then
      obj:SetActivityCommonRemainingTime2("_time_lock", "str_activity_start_in", unlockTime, true, nil, function(first)
        if lineComponentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] ~= nil then
          obj:GetGameObject("state_lock"):SetActive(true)
          UIWidgetHelper.PlayAnimation(obj, "_anime", "uieff_UINCN16N45MainController_BtnUnlock", 667, function()
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
  obj:SetActivityCommonRemainingTime("_time_unlock", "str_cn16_n45_remain_time_in_activity", closeTime, false)
  
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
  local state = UIStateType.UICN16N45HardLevel
  
  local function clickCallback()
    UICN16N45Helper.LocalDB_Set(name, "New")
    local blackKey = UICN16N45Helper._LocalDB_GetKey(name, "Red")
    UIActivityHelper.SetCmptRedViewed(blackKey)
    local componentMain = CampaignConst.GetSafeStateInfo(self._campaign._id, cmptId, state, nil)
    self._campaign._campaign_module:SwitchState_Safe(true, {componentMain})
  end
  
  obj:SetData(self._campaign, cmptId, clickCallback)
end

function UICN16N45MainController:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UICN16N45Intro", MaskType.MT_BlurMask)
end

function UICN16N45MainController:ShowBtnOnClick()
  self:_ShowUI()
end

function UICN16N45MainController:_AttachEvents()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN16N45MainController:_DetachEvents()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN16N45MainController:_AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end

function UICN16N45MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
  if self._ny_campaign and self._ny_campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN16N45MainController:_OnItemChanged(id)
  self:_Refresh()
end
