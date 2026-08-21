_class("UIN15PoltController", UIController)
UIN15PoltController = UIN15PoltController

function UIN15PoltController:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN15PoltController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  if self._campaign._type == -1 or self._campaign._id == -1 then
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N15)
  else
    self.activityCampaign:ReLoadCampaignInfo_Force(TT, res)
  end
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N15)
  self._draw_cpt = self._campaign:GetComponent(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY)
  self._draw_info = self._campaign:GetComponentInfo(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY)
end

function UIN15PoltController:OnShow(uiParams)
  self:_InitParams(uiParams)
  self:_InitPage()
  self:_InitWidget()
  self:_RefView()
end

function UIN15PoltController:_InitWidget()
  self._polt_bg_i_raw = self:GetUIComponent("RawImageLoader", "_polt_bg_i")
  self._polt_title_i_txt = self:GetUIComponent("UILocalizationText", "_polt_title_i")
  self._polt_content_i_txt = self:GetUIComponent("UILocalizationText", "_polt_content_i")
  self._polt_new_i_obj = self:GetGameObject("_polt_new_i")
  self._polt_lock_i_obj = self:GetGameObject("_polt_lock_i")
  self._polt_condition_i_txt = self:GetUIComponent("UILocalizationText", "_polt_condition_i")
  self._txtContenti1 = self:GetUIComponent("UILocalizationText", "txtContenti1")
  self._txtContenti2 = self:GetUIComponent("UILocalizationText", "txtContenti2")
  self._txtContenti3 = self:GetUIComponent("UILocalizationText", "txtContenti3")
  self._txtContenti4 = self:GetUIComponent("UILocalizationText", "txtContenti4")
  self._polt_bg_ii_raw = self:GetUIComponent("RawImageLoader", "_polt_bg_ii")
  self._polt_title_ii_txt = self:GetUIComponent("UILocalizationText", "_polt_title_ii")
  self._polt_content_ii_txt = self:GetUIComponent("UILocalizationText", "_polt_content_ii")
  self._polt_new_ii_obj = self:GetGameObject("_polt_new_ii")
  self._polt_lock_ii_obj = self:GetGameObject("_polt_lock_ii")
  self._polt_condition_ii_txt = self:GetUIComponent("UILocalizationText", "_polt_condition_ii")
  self._txtContentii1 = self:GetUIComponent("UILocalizationText", "txtContentii1")
  self._txtContentii2 = self:GetUIComponent("UILocalizationText", "txtContentii2")
  self._txtContentii3 = self:GetUIComponent("UILocalizationText", "txtContentii3")
  self._txtContentii4 = self:GetUIComponent("UILocalizationText", "txtContentii4")
  self._polt_title_txt = self:GetUIComponent("UILocalizationText", "_polt_title")
  self._left_btn_obj = self:GetGameObject("_left_btn")
  self._right_btn_obj = self:GetGameObject("_right_btn")
  self._polt_ii_obj = self:GetGameObject("_polt_ii")
  local back_btn = self:GetUIComponent("UISelectObjectPath", "_back_btn")
  self._commonTopBtn = back_btn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
      ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
      self:SwitchState(UIStateType.UIMain)
      return
    end
    self:CloseDialog()
  end, nil, nil, false)
  self._commonTopBtn:HideHomeBtn()
  self._anim = self.view.gameObject:GetComponent("Animation")
end

function UIN15PoltController:_InitParams(Params)
  self._polt_cfg = Cfg.cfg_n15_polt_event({})
  self._page = 1
  self._page_tab = {}
  self._polt_tab = nil
end

function UIN15PoltController:_InitPage()
  self._polt_tab = self._draw_cpt:RandEventInfo()
  local polt_idx = 1
  for i = 1, #self._polt_tab // 2 do
    local page_data = {}
    page_data[1] = self._polt_tab[polt_idx]
    page_data[2] = self._polt_tab[polt_idx + 1]
    polt_idx = polt_idx + 2
    table.insert(self._page_tab, page_data)
  end
  if #self._polt_tab % 2 == 1 then
    local page_data = {}
    page_data[1] = self._polt_tab[#self._polt_tab]
    table.insert(self._page_tab, page_data)
  end
end

function UIN15PoltController:_PlayPolt(polt_id)
  if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
    ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UIStoryController", polt_id, function()
    local dbstr = N15ToolFunctions.GetLocalPoltNewName(polt_id)
    LocalDB.SetInt(dbstr, 1)
    self:_RefView()
  end)
end

function UIN15PoltController:_GetPoltCount()
  local total = #self._polt_tab
  local unlock = 0
  for idx, polt in ipairs(self._polt_tab) do
    if polt.is_unlock then
      unlock = unlock + 1
    end
  end
  local lock = total - unlock
  return total, unlock, lock
end

function UIN15PoltController:_RefView()
  local page_date = self._page_tab[self._page]
  if self._page == 1 then
    self:_RefLRBtn(false, true)
  elseif self._page == #self._page_tab then
    self:_RefLRBtn(true, false)
  else
    self:_RefLRBtn(true, true)
  end
  local dbstr = N15ToolFunctions.GetLocalPoltNewName(page_date[1].event_id)
  local polt_has = LocalDB.HasKey(dbstr)
  self._polt_new_i_obj:SetActive(not polt_has and page_date[1].is_unlock)
  if page_date[1].is_unlock then
    self._polt_lock_i_obj:SetActive(false)
  else
    self._polt_lock_i_obj:SetActive(true)
  end
  if page_date[2] then
    dbstr = N15ToolFunctions.GetLocalPoltNewName(page_date[2].event_id)
    polt_has = LocalDB.HasKey(dbstr)
    self._polt_new_ii_obj:SetActive(not polt_has and page_date[2].is_unlock)
    if page_date[2].is_unlock then
      self._polt_lock_ii_obj:SetActive(false)
    else
      self._polt_lock_ii_obj:SetActive(true)
    end
    self._polt_ii_obj:SetActive(true)
  else
    self._polt_ii_obj:SetActive(false)
  end
  self:_RefTxt()
end

function UIN15PoltController:_RefLRBtn(left, right)
  self._left_btn_obj:SetActive(left)
  self._right_btn_obj:SetActive(right)
end

function UIN15PoltController:_RefTxt()
  local data = self._page_tab[self._page]
  local cfg = self._polt_cfg[data[1].event_id]
  local total, unlock, lock = self:_GetPoltCount()
  self._polt_title_txt:SetText(StringTable.Get("str_n15_polt_title", unlock .. "/" .. total))
  self._polt_bg_i_raw:LoadImage(cfg.Icon)
  self._polt_title_i_txt:SetText(StringTable.Get(cfg.Title))
  self._polt_content_i_txt:SetText(StringTable.Get(cfg.Content))
  self._txtContenti1:SetText(StringTable.Get(cfg.Visibility))
  self._txtContenti2:SetText(StringTable.Get(cfg.Weather))
  self._txtContenti3:SetText(StringTable.Get(cfg.WindSpeed))
  self._txtContenti4:SetText(StringTable.Get(cfg.Temperature))
  self._polt_condition_i_txt:SetText(StringTable.Get("str_n15_polt_condition", self._draw_info.m_cost_count * data[1].lottery_times))
  if data[2] then
    cfg = self._polt_cfg[data[2].event_id]
    self._polt_bg_ii_raw:LoadImage(cfg.Icon)
    self._polt_title_ii_txt:SetText(StringTable.Get(cfg.Title))
    self._polt_content_ii_txt:SetText(StringTable.Get(cfg.Content))
    self._txtContentii1:SetText(StringTable.Get(cfg.Visibility))
    self._txtContentii2:SetText(StringTable.Get(cfg.Weather))
    self._txtContentii3:SetText(StringTable.Get(cfg.WindSpeed))
    self._txtContentii4:SetText(StringTable.Get(cfg.Temperature))
    self._polt_condition_ii_txt:SetText(StringTable.Get("str_n15_polt_condition", self._draw_info.m_cost_count * data[2].lottery_times))
  end
end

function UIN15PoltController:LeftBtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
    ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if self._page > 1 then
    self._page = self._page - 1
    local lockName = "UIN15PoltController:_PageL"
    self:Lock(lockName)
    self:StartTask(function(TT)
      self._anim:Stop()
      self._anim:Play("uieffanim_N15_Polt_in")
      self:_RefView()
      YIELD(TT, 733)
      self:UnLock(lockName)
    end, self)
  end
end

function UIN15PoltController:RightBtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
    ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if self._page < #self._page_tab then
    self._page = self._page + 1
    local lockName = "UIN15PoltController:_PageR"
    self:Lock(lockName)
    self:StartTask(function(TT)
      self._anim:Stop()
      self._anim:Play("uieffanim_N15_Polt_in")
      self:_RefView()
      YIELD(TT, 733)
      self:UnLock(lockName)
    end, self)
  end
end

function UIN15PoltController:PoltPlayIBtnOnClick(go)
  if self._page_tab[self._page][1].is_unlock then
    self:_PlayPolt(self._page_tab[self._page][1].event_id)
  end
end

function UIN15PoltController:PoltPlayIIBtnOnClick(go)
  if self._page_tab[self._page][2].is_unlock then
    self:_PlayPolt(self._page_tab[self._page][2].event_id)
  end
end
