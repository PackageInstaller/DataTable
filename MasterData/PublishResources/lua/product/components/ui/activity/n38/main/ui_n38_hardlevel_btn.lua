_class("UIN38_HardLevelBtn", UICustomWidget)
UIN38_HardLevelBtn = UIN38_HardLevelBtn

function UIN38_HardLevelBtn:OnShow(uiParams)
  self:InitWidget()
end

function UIN38_HardLevelBtn:InitWidget()
  self.redGO = self:GetGameObject("Red")
  self.newGO = self:GetGameObject("New")
  self.lockGO = self:GetGameObject("Lock")
  self.overGO = self:GetGameObject("Over")
  self.conditionGO = self:GetGameObject("Condition")
  self.conditionText = self:GetUIComponent("UILocalizationText", "ConditionText")
  self.remainTimeGO = self:GetGameObject("RemainTime")
  self.remainTimeText = self:GetUIComponent("UILocalizationText", "RemainTimeText")
end

function UIN38_HardLevelBtn:SetData(activityConst)
  self._activityConst = activityConst
  self._component = self._activityConst._hardLineMissionComponent
  self._componentInfo = self._activityConst._hardLineMissionompInfo
  if self._component == nil or self._componentInfo == nil then
    self.conditionGO:SetActive(false)
    self.overGO:SetActive(false)
    self.lockGO:SetActive(true)
    return
  end
  local openTime = self._componentInfo.m_unlock_time
  local closeTime = self._componentInfo.m_close_time
  local nowTime = self:GetModule(SvrTimeModule):GetServerTime() / 1000
  if openTime > nowTime then
    local timeStr = UIN38Helper.GetTimeString(math.floor(openTime - nowTime))
    self.remainTimeText:SetText(StringTable.Get("str_n38_line_lock_time_tips", timeStr))
    self.remainTimeGO:SetActive(true)
    self.conditionGO:SetActive(false)
    self.overGO:SetActive(false)
    self.lockGO:SetActive(true)
  elseif closeTime <= nowTime then
    self.remainTimeGO:SetActive(false)
    self.conditionGO:SetActive(false)
    self.overGO:SetActive(true)
    self.lockGO:SetActive(true)
  else
    local needID = self._componentInfo.m_need_mission_id
    local passed = self._activityConst._normalLineMissionompInfo.m_pass_mission_info[needID]
    if not passed then
      self.remainTimeGO:SetActive(false)
      self.conditionGO:SetActive(true)
      self.overGO:SetActive(false)
      self.lockGO:SetActive(true)
      local cfgv = Cfg.cfg_campaign_mission[needID]
      if cfgv then
        local lvName = StringTable.Get(cfgv.Name)
        self.conditionText:SetText(StringTable.Get("str_n38_hard_level_lock_tips", lvName))
      end
    else
      local timeStr = UIN38Helper.GetTimeString(math.floor(closeTime - nowTime))
      self.remainTimeText:SetText(StringTable.Get("str_n38_line_remain_time", timeStr))
      self.remainTimeGO:SetActive(true)
      self.conditionGO:SetActive(false)
      self.overGO:SetActive(false)
      self.lockGO:SetActive(false)
    end
  end
  self:SetNewRedPoint()
end

function UIN38_HardLevelBtn:SetNewRedPoint()
  if self.lockGO.activeSelf then
    self.newGO:SetActive(false)
    self.redGO:SetActive(false)
    return
  end
  local showNew = self._activityConst:IsShowHardLineNew() or self._activityConst:IsShowBlackNew()
  if showNew then
    self.newGO:SetActive(true)
    self.redGO:SetActive(false)
  else
    self.newGO:SetActive(false)
    local showRed = self._activityConst:IsShowHardLineRed() or self._activityConst:IsShowBlackRed()
    self.redGO:SetActive(showRed)
  end
end

function UIN38_HardLevelBtn:BtnOnClick(go)
  self._activityConst:GetCampaign()._campaign_module:CampaignSwitchState(true, UIStateType.UIN38HardLevel, UIStateType.UIMain, nil, self._activityConst:GetCampaignId())
end
