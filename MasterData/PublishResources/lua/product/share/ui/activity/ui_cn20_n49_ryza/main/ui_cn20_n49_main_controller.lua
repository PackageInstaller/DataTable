require("ui_share_controller")
_class("UICN20N49MainController", UIShareController)
UICN20N49MainController = UICN20N49MainController

function UICN20N49MainController:_SetCommonTopButton()
  local shareComponent = UICN20N49Helper.GetComponent(self._campaign, "share")
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

function UICN20N49MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UICN20N49MainController then
    self:SwitchState(UIStateType.UIMain)
  else
    self:_PlayAnim("out", function()
      self:CloseDialog()
    end)
    self:CloseDialog()
  end
end

function UICN20N49MainController:_HideUI()
  self:_PlayAnim("out01", function()
    self:GetGameObject("_backBtns"):SetActive(false)
    self:GetGameObject("_showBtn"):SetActive(true)
    self:GetGameObject("_uiElements"):SetActive(false)
  end)
end

function UICN20N49MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(true)
  self:_PlayAnim("in01", function()
  end)
end

function UICN20N49MainController:_SetRemainingTime(widgetName, descId, endTime, tickCallback, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UICN20N49MainController:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n49_kv_spine_idle")
end

function UICN20N49MainController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = imgRT
    return true
  end
  return false
end

function UICN20N49MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UICN20N49MainController)
end

function UICN20N49MainController:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uieff_UICN20N49MainController_in",
      duration = 1167
    },
    out01 = {
      animName = "uieff_UICN20N49MainController_out01",
      duration = 333
    },
    in01 = {
      animName = "uieff_UICN20N49MainController_in01",
      duration = 900
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UICN20N49MainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = UICN20N49Helper.GetCampaignType()
  local componentIds = {}
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  UICN20N49Helper.LocalDB_Set("main", "New")
  self._bp_campaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._bp_campaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UICN20N49MainController:OnShow(uiParams)
  local fromMain = uiParams[1]
  self:_AttachEvents()
  self:_SetCommonTopButton()
  self:_SetSpine()
  self:GetComponents()
  self:_UpdateRemainingTime()
  self:_Refresh()
  self:PlayAnimIn(fromMain)
  self.overFirstTime = true
end

function UICN20N49MainController:GetComponents()
  local linePool = self:GetUIComponent("UISelectObjectPath", "_lineBtn")
  self._lineObj = linePool:SpawnObject("UIActivityCommonComponentEnterLock")
  self._lineAnim = self._lineObj:GetUIComponent("Animation", "anim")
  local lineTalentPool = self:GetUIComponent("UISelectObjectPath", "_lineTalentBtn")
  self._lineTalentObj = lineTalentPool:SpawnObject("UIActivityCommonComponentEnterLock")
  self._lineTalentAnim = self._lineTalentObj:GetUIComponent("Animation", "anim")
  local alchemyPool = self:GetUIComponent("UISelectObjectPath", "_alchemyBtn")
  self._alchemyObj = alchemyPool:SpawnObject("UIActivityCommonComponentEnterLock")
  self._alchemyAnim = self._alchemyObj:GetUIComponent("Animation", "anim")
  local alchemyShopPool = self:GetUIComponent("UISelectObjectPath", "_alchemyShopBtn")
  self._alchemyShopObj = alchemyShopPool:SpawnObject("UIActivityCommonComponentEnterLock")
  self._alchemyShopAnim = self._alchemyShopObj:GetUIComponent("Animation", "anim")
end

function UICN20N49MainController:PlayAnimIn(fromMain)
  if fromMain then
    self:_PlayAnim("in", function()
      self:_CheckGuide()
    end)
  else
    self:_PlayAnim("in", function()
      self:_CheckGuide()
    end)
  end
end

function UICN20N49MainController:OnHide()
  self:_DetachEvents()
end

function UICN20N49MainController:_Refresh()
  UICN20N49Helper.SetBattlePassBtn(self, "_battlePassBtn", self._bp_campaign)
  self._exchangeObj = UICN20N49Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign)
  self:_SetLoginBtn()
  self:_SetLineBtn()
  self:_SetLineTalentBtn()
  self:_SetAlchemyBtn()
  self:_SetAlchemyShopBtn()
end

function UICN20N49MainController:_UpdateRemainingTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local exchangeItemComponent = UICN20N49Helper.GetComponentInfo(self._campaign, "exchange")
  local endTime = exchangeItemComponent.m_close_time
  local stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_time", "str_cn20_n49_shop_close_time_tips", endTime)
    return
  end
end

function UICN20N49MainController:_SetLoginBtn()
  local name = "login"
  local cmptId = UICN20N49Helper.GetComponentId(name)
  local obj = UIWidgetHelper.SpawnObject(self, "_loginBtn", "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = UICN20N49Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  obj:SetNew("new", newCallback)
  
  local function redCallback()
    local red = UICN20N49Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  obj:SetRed("red", redCallback)
  
  local function clickCallback()
    UICN20N49Helper.LocalDB_Set(name, "New")
    local campaignType = UICN20N49Helper.GetCampaignType()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, campaignType, cmptId)
  end
  
  obj:SetData(self._campaign, clickCallback)
end

function UICN20N49MainController:_SetLineBtn()
  local name = "line"
  local cmptId = UICN20N49Helper.GetComponentId(name)
  local component = UICN20N49Helper.GetComponent(self._campaign, name)
  
  local function newCallback()
    local new = UICN20N49Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  self._lineObj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN20N49Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  self._lineObj:SetRed("_red", redCallback)
  local closeTime = component and component:GetComponentInfo().m_close_time or 0
  self._lineObj:SetActivityCommonRemainingTime("_time_unlock", "str_cn20_n49_shop_close_time_tips", closeTime, true)
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
  self._lineObj:SetWidgetNameGroup(tb)
  
  local function lockWithTimeCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  end
  
  local lockCallback
  
  local function closedCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
  end
  
  self._lineObj:SetLockStateCallback(lockWithTimeCallback, lockCallback, closedCallback)
  local state = UIStateType.UICN20N49LineController
  
  local function clickCallback()
    UICN20N49Helper.LocalDB_Set(name, "New")
    local lineKey = UICN20N49Helper._LocalDB_GetKey(name, "Red")
    UIActivityHelper.SetCmptRedViewed(lineKey)
    local componentMain = CampaignConst.GetSafeStateInfo(self._campaign._id, cmptId, state, nil)
    self._campaign._campaign_module:SwitchState_Safe(true, {componentMain})
  end
  
  self._lineObj:SetData(self._campaign, cmptId, clickCallback)
end

function UICN20N49MainController:_SetLineTalentBtn()
  local name = "talent"
  local cmptId = UICN20N49Helper.GetComponentId(name)
  local component = UICN20N49Helper.GetComponent(self._campaign, name)
  
  local function newCallback()
    local new = UICN20N49Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  self._lineTalentObj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN20N49Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  self._lineTalentObj:SetRed("_red", redCallback)
  local txtLock = self._lineTalentObj:GetUIComponent("UILocalizationText", "_txtLock")
  local action_point_num = self._lineTalentObj:GetUIComponent("UILocalizationText", "action_point_num")
  local unlockTime = component and component:ComponentUnLockTime() or 0
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local endTime = component:ComponentUnLockTime() or 0
  local stamp = endTime - curTime
  local lineComponentInfo = UICN20N49Helper.GetComponentInfo(self._campaign, name)
  local isMissionLock = component:GetComponentInfo().m_need_mission_id ~= 0 and lineComponentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] == nil
  if isMissionLock or 0 < stamp then
    if 0 < stamp then
      self._lineTalentObj:SetActivityCommonRemainingTime("_time_lock", "str_activity_start_in", unlockTime, true, nil, function(first)
        if lineComponentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] ~= nil then
          self._lineTalentObj:GetGameObject("state_lock"):SetActive(true)
          self:_Refresh()
        else
          self:_Refresh()
        end
      end)
    elseif isMissionLock then
      local missionName = Cfg.cfg_campaign_mission[component:GetComponentInfo().m_need_mission_id].Name
      local lvName = StringTable.Get(missionName)
      txtLock:SetText(StringTable.Get("str_cn20_n49_level_lock_tips", lvName))
    end
  end
  local actionPointComponent = UICN20N49Helper.GetComponent(self._campaign, "actionPoint")
  local icon = actionPointComponent:GetItemIcon()
  if icon then
    local action_point_icon = self._lineTalentObj:GetUIComponent("Image", "action_point_icon")
    action_point_icon.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(icon)
  end
  local n1, n2 = actionPointComponent:GetItemCount()
  action_point_num:SetText(n1 .. "/" .. n2)
  local tb = {
    {"state_lock", "_time_lock"},
    {"state_lock", "_txtLock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  self._lineTalentObj:SetWidgetNameGroup(tb)
  local closeTime = component and component:GetComponentInfo().m_close_time or 0
  self._lineTalentObj:SetActivityCommonRemainingTime("_time_unlock", "str_cn20_n49_shop_close_time_tips", closeTime, false)
  
  local function lockWithTimeCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  end
  
  local function lockCallback()
    local missionName = Cfg.cfg_campaign_mission[component:GetComponentInfo().m_need_mission_id].Name
    local lvName = StringTable.Get(missionName)
    ToastManager.ShowToast(StringTable.Get("str_cn20_n49_level_lock_tips", lvName))
  end
  
  local function closedCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
  end
  
  self._lineTalentObj:SetLockStateCallback(lockWithTimeCallback, lockCallback, closedCallback)
  local state = UIStateType.UICN20N49LineTalentController
  
  local function clickCallback()
    UICN20N49Helper.LocalDB_Set(name, "New")
    local blackKey = UICN20N49Helper._LocalDB_GetKey(name, "Red")
    UIActivityHelper.SetCmptRedViewed(blackKey)
    local componentMain = CampaignConst.GetSafeStateInfo(self._campaign._id, cmptId, state, nil)
    self._campaign._campaign_module:SwitchState_Safe(true, {componentMain})
  end
  
  self._lineTalentObj:SetData(self._campaign, cmptId, clickCallback)
end

function UICN20N49MainController:_SetAlchemyBtn()
  local name = "alchemy"
  local cmptId = UICN20N49Helper.GetComponentId(name)
  local component = UICN20N49Helper.GetComponent(self._campaign, name)
  
  local function newCallback()
    local new = UICN20N49Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  self._alchemyObj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN20N49Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  self._alchemyObj:SetRed("_red", redCallback)
  local txtLock = self._lineTalentObj:GetUIComponent("UILocalizationText", "_txtLock")
  local unlockTime = component and component:ComponentUnLockTime() or 0
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local endTime = component:ComponentUnLockTime() or 0
  local stamp = endTime - curTime
  local componentInfo = UICN20N49Helper.GetComponentInfo(self._campaign, name)
  local isMissionLock = component:GetComponentInfo().m_need_mission_id ~= 0 and componentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] == nil
  if isMissionLock or 0 < stamp then
    if 0 < stamp then
      self._lineTalentObj:SetActivityCommonRemainingTime("_time_lock", "str_activity_start_in", unlockTime, true, nil, function(first)
        if componentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] ~= nil then
          self._lineTalentObj:GetGameObject("state_lock"):SetActive(true)
          self:_Refresh()
        else
          self:_Refresh()
        end
      end)
    elseif isMissionLock then
      local missionName = Cfg.cfg_campaign_mission[component:GetComponentInfo().m_need_mission_id].Name
      local lvName = StringTable.Get(missionName)
      txtLock:SetText(StringTable.Get("str_cn20_n49_level_lock_tips", lvName))
    end
  end
  local closeTime = component and component:GetComponentInfo().m_close_time or 0
  self._alchemyObj:SetActivityCommonRemainingTime("_time_unlock", "str_cn20_n49_shop_close_time_tips", closeTime, true)
  local tb = {
    {"state_lock", "_time_lock"},
    {"state_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  self._alchemyObj:SetWidgetNameGroup(tb)
  
  local function lockWithTimeCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  end
  
  local function lockCallback()
    local missionName = Cfg.cfg_campaign_mission[component:GetComponentInfo().m_need_mission_id].Name
    local lvName = StringTable.Get(missionName)
    ToastManager.ShowToast(StringTable.Get("str_cn20_n49_level_lock_tips", lvName))
  end
  
  local function closedCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
  end
  
  self._alchemyObj:SetLockStateCallback(lockWithTimeCallback, lockCallback, closedCallback)
  local state = UIStateType.UICN20AlchemyMainController
  
  local function clickCallback()
    UICN20N49Helper.LocalDB_Set(name, "New")
    local lineKey = UICN20N49Helper._LocalDB_GetKey(name, "Red")
    UIActivityHelper.SetCmptRedViewed(lineKey)
    self:ShowDialog("UICN20AlchemyMainController", self._campaign)
  end
  
  self._alchemyObj:SetData(self._campaign, cmptId, clickCallback)
end

function UICN20N49MainController:_SetAlchemyShopBtn()
  local name = "alchemyShop"
  local cmptId = UICN20N49Helper.GetComponentId(name)
  local component = UICN20N49Helper.GetComponent(self._campaign, name)
  
  local function newCallback()
    local new = UICN20N49Helper.CalcNew_Component(self._campaign, name)
    return new
  end
  
  self._alchemyShopObj:SetNew("_new", newCallback)
  
  local function redCallback()
    local red = UICN20N49Helper.CalcRed_Component(self._campaign, name)
    return red
  end
  
  self._alchemyShopObj:SetRed("_red", redCallback)
  local txtLock = self._lineTalentObj:GetUIComponent("UILocalizationText", "_txtLock")
  local unlockTime = component and component:ComponentUnLockTime() or 0
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local endTime = component:ComponentUnLockTime() or 0
  local stamp = endTime - curTime
  local componentInfo = UICN20N49Helper.GetComponentInfo(self._campaign, name)
  local isMissionLock = component:GetComponentInfo().m_need_mission_id ~= 0 and componentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] == nil
  if isMissionLock or 0 < stamp then
    if 0 < stamp then
      self._lineTalentObj:SetActivityCommonRemainingTime("_time_lock", "str_activity_start_in", unlockTime, true, nil, function(first)
        if componentInfo.m_pass_mission_info[component:GetComponentInfo().m_need_mission_id] ~= nil then
          self._lineTalentObj:GetGameObject("state_lock"):SetActive(true)
          self:_Refresh()
        else
          self:_Refresh()
        end
      end)
    elseif isMissionLock then
      local missionName = Cfg.cfg_campaign_mission[component:GetComponentInfo().m_need_mission_id].Name
      local lvName = StringTable.Get(missionName)
      txtLock:SetText(StringTable.Get("str_cn20_n49_level_lock_tips", lvName))
    end
  end
  local closeTime = component and component:GetComponentInfo().m_close_time or 0
  self._alchemyShopObj:SetActivityCommonRemainingTime("_time_unlock", "str_cn20_n49_shop_close_time_tips", closeTime, true)
  local tb = {
    {"state_lock", "_time_lock"},
    {"state_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  self._alchemyShopObj:SetWidgetNameGroup(tb)
  
  local function lockWithTimeCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  end
  
  local function lockCallback()
    local missionName = Cfg.cfg_campaign_mission[component:GetComponentInfo().m_need_mission_id].Name
    local lvName = StringTable.Get(missionName)
    ToastManager.ShowToast(StringTable.Get("str_cn20_n49_level_lock_tips", lvName))
  end
  
  local function closedCallback()
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
  end
  
  self._alchemyShopObj:SetLockStateCallback(lockWithTimeCallback, lockCallback, closedCallback)
  local state = UIStateType.UICN20N49Ryza_Shop
  
  local function clickCallback()
    UICN20N49Helper.LocalDB_Set(name, "New")
    local lineKey = UICN20N49Helper._LocalDB_GetKey(name, "Red")
    UIActivityHelper.SetCmptRedViewed(lineKey)
    self:ShowDialog("UICN20N49Ryza_Shop")
  end
  
  self._alchemyShopObj:SetData(self._campaign, cmptId, clickCallback)
end

function UICN20N49MainController:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UICN20N49Intro", MaskType.MT_BlurMask)
end

function UICN20N49MainController:ShowBtnOnClick()
  self:_ShowUI()
end

function UICN20N49MainController:_AttachEvents()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN20N49MainController:_DetachEvents()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN20N49MainController:_AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end

function UICN20N49MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN20N49MainController:_OnItemChanged(id)
  self:_Refresh()
end
