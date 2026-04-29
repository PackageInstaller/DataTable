_class("UIN38_ExchangeBtn", UICustomWidget)
UIN38_ExchangeBtn = UIN38_ExchangeBtn

function UIN38_ExchangeBtn:OnShow(uiParams)
  self:InitWidget()
end

function UIN38_ExchangeBtn:InitWidget()
  self.redGO = self:GetGameObject("Red")
  self.newGO = self:GetGameObject("New")
  self.lockGO = self:GetGameObject("Lock")
  self.count = self:GetUIComponent("UILocalizationText", "Count")
  self.icon = self:GetUIComponent("RawImageLoader", "Icon")
end

function UIN38_ExchangeBtn:SetData(activityConst)
  self._activityConst = activityConst
  self._component, self._componentInfo = self._activityConst:GetShopComponent()
  local icon, count = self._component:GetCostItemIconText()
  if icon then
    self.icon:LoadImage(icon)
  end
  self.count:SetText(UIN38Helper.GetItemCountStr(7, count, "#8D8D8D", "#ffd146"))
  local openTime = self._componentInfo.m_unlock_time
  local closeTime = self._componentInfo.m_close_time
  local nowTime = self:GetModule(SvrTimeModule):GetServerTime() / 1000
  if openTime > nowTime then
    self.lockGO:SetActive(true)
  elseif closeTime <= nowTime then
    self.lockGO:SetActive(true)
  else
    self.lockGO:SetActive(false)
  end
end

function UIN38_ExchangeBtn:SetNewRedPoint()
  if self.lockGO.activeSelf then
    self.newGO:SetActive(false)
    self.redGO:SetActive(false)
    return
  end
  local showNew = self._activityConst:IsShowShopNew()
  if showNew then
    self.newGO:SetActive(true)
    self.redGO:SetActive(false)
  else
    self.newGO:SetActive(false)
    local showRed = self._activityConst:IsShowShopRed()
    self.redGO:SetActive(showRed)
  end
end

function UIN38_ExchangeBtn:BtnOnClick(go)
  if self._activityConst:IsActivityEnd() then
    self:SwitchState(UIStateType.UIMain)
  else
    self:ShowDialog("UIN38Shop")
    self._activityConst:ClearShopNew()
  end
end
