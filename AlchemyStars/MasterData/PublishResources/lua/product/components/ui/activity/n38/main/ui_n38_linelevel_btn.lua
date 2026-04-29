_class("UIN38_LineLevelBtn", UICustomWidget)
UIN38_LineLevelBtn = UIN38_LineLevelBtn

function UIN38_LineLevelBtn:OnShow(uiParams)
  self:InitWidget()
end

function UIN38_LineLevelBtn:InitWidget()
  self.redGO = self:GetGameObject("Red")
  self.newGO = self:GetGameObject("New")
  self.lockGO = self:GetGameObject("Lock")
  self.overGO = self:GetGameObject("Over")
  self.remainTimeGO = self:GetGameObject("RemainTime")
  self.remainTimeText = self:GetUIComponent("UILocalizationText", "RemainTimeText")
end

function UIN38_LineLevelBtn:SetData(activityConst)
  self._activityConst = activityConst
  self._component = self._activityConst._normalLineMissionComponent
  self._componentInfo = self._activityConst._normalLineMissionompInfo
  if self._component and self._componentInfo then
    local openTime = self._componentInfo.m_unlock_time
    local closeTime = self._componentInfo.m_close_time
    local nowTime = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    if openTime > nowTime then
      local timeStr = UIN38Helper.GetTimeString(math.floor(openTime - nowTime))
      self.remainTimeText:SetText(StringTable.Get("str_n38_line_lock_time_tips", timeStr))
      self.remainTimeGO:SetActive(true)
      self.lockGO:SetActive(true)
      self.overGO:SetActive(false)
    elseif closeTime <= nowTime then
      self.remainTimeGO:SetActive(false)
      self.lockGO:SetActive(true)
      self.overGO:SetActive(true)
    else
      local timeStr = UIN38Helper.GetTimeString(math.floor(closeTime - nowTime))
      self.remainTimeText:SetText(StringTable.Get("str_n38_line_remain_time", timeStr))
      self.remainTimeGO:SetActive(true)
      self.lockGO:SetActive(false)
      self.overGO:SetActive(false)
    end
  end
end

function UIN38_LineLevelBtn:SetNewRedPoint()
  if self.lockGO.activeSelf then
    self.newGO:SetActive(false)
    self.redGO:SetActive(false)
    return
  end
  local showNew = self._activityConst:IsShowNormalLineNew()
  if showNew then
    self.newGO:SetActive(true)
    self.redGO:SetActive(false)
  else
    self.newGO:SetActive(false)
    local showRed = self._activityConst:IsShowNormalLineRed() or self._activityConst:IsShowShopRed()
    self.redGO:SetActive(showRed)
  end
end

function UIN38_LineLevelBtn:BtnOnClick(go)
  self._activityConst:GetCampaign()._campaign_module:CampaignSwitchState(true, UIStateType.UIN38Line, UIStateType.UIMain, nil, self._activityConst:GetCampaignId())
  self._activityConst:ClearNormalLineNew()
end
