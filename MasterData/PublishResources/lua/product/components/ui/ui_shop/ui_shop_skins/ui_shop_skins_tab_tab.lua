_class("UIShopSkinsTabTab", UICustomWidget)
UIShopSkinsTabTab = UIShopSkinsTabTab

function UIShopSkinsTabTab:Constructor()
end

function UIShopSkinsTabTab:OnShow(uiParams)
  self:UIWidget()
end

function UIShopSkinsTabTab:OnHide()
end

function UIShopSkinsTabTab:UIWidget()
  self._uiSel = self:GetUIComponent("RectTransform", "uiSel")
  self._uiUnsel = self:GetUIComponent("RectTransform", "uiUnsel")
  self._txtNameSel = self:GetUIComponent("UILocalizationText", "txtNameSel")
  self._txtNameUnsel = self:GetUIComponent("UILocalizationText", "txtNameUnsel")
end

function UIShopSkinsTabTab:BtnOnClick(go)
  if self._clickCB ~= nil then
    self._clickCB(self._keyTab, go)
  end
end

function UIShopSkinsTabTab:SetData(keyTab, cfgTab, clickCB)
  self._keyTab = keyTab
  self._cfgTab = cfgTab
  self._clickCB = clickCB
  self._isSelected = false
  self:Flush()
  self:SetSelected(false)
end

function UIShopSkinsTabTab:Flush()
  local txtName = StringTable.Get(self._cfgTab.Name)
  self._txtNameSel:SetText(txtName)
  self._txtNameUnsel:SetText(txtName)
end

function UIShopSkinsTabTab:SetSelected(isSelected)
  self._isSelected = isSelected
  self._uiSel.gameObject:SetActive(isSelected)
  self._uiUnsel.gameObject:SetActive(not isSelected)
end

function UIShopSkinsTabTab:IsSelected()
  return self._isSelected
end
