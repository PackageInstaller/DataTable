_class("UIActivityNPlusSixBuildingItemName", UICustomWidget)
UIActivityNPlusSixBuildingItemName = UIActivityNPlusSixBuildingItemName

function UIActivityNPlusSixBuildingItemName:OnShow()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._maskPanel = self:GetUIComponent("RectTransform", "Mask")
  self._go = self:GetGameObject("Go")
end

function UIActivityNPlusSixBuildingItemName:Refresh(buildingData)
  local operatorName = {
    [UIActivityNPlusSixBuildingStatus.CleanUp] = "str_n_plus_six_building_tips_cleanup_operator_name",
    [UIActivityNPlusSixBuildingStatus.CleanUpComplete] = "str_n_plus_six_building_tips_repair_operator_name",
    [UIActivityNPlusSixBuildingStatus.RepairComplete] = "str_n_plus_six_building_tips_decorate_operator_name"
  }
  self._buildingData = buildingData
  if not self._buildingData then
    self._go:SetActive(false)
    return
  end
  if not self._buildingData:IsShow() then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._go.transform.anchoredPosition = self._buildingData:GetWidgetPos()
  self._maskPanel.anchoredPosition = self._buildingData:GetWidgetDesPos()
  local status = self._buildingData:GetStatusType()
  if self._buildingData:CanBuild() == false or self._buildingData:IsUnLock() == false or self._buildingData:IsNextStatusUnLock() == false then
    self._go:SetActive(false)
  else
    self._go:SetActive(true)
    local str = operatorName[status]
    if str then
      self._name.text = StringTable.Get(str, self._buildingData:GetName())
    else
      self._go:SetActive(false)
    end
  end
end

function UIActivityNPlusSixBuildingItemName:UIAreaLimit(target, area, root)
  local bounds = UnityEngine.RectTransformUtility.CalculateRelativeRectTransformBounds(root, target)
  local delta = Vector2.zero
  if bounds.center.x - bounds.extents.x < area.x then
    delta.x = delta.x + math.abs(bounds.center.x - bounds.extents.x - area.x)
  elseif bounds.center.x + bounds.extents.x > area.width / 2 then
    delta.x = delta.x - math.abs(bounds.center.x + bounds.extents.x - area.width / 2)
  end
  if bounds.center.y - bounds.extents.y < area.y then
    delta.y = delta.y + math.abs(bounds.center.y - bounds.extents.y - area.y)
  elseif bounds.center.y + bounds.extents.y > area.height / 2 then
    delta.y = delta.y - math.abs(bounds.center.y + bounds.extents.y - area.height / 2)
  end
  target.anchoredPosition = target.anchoredPosition + delta
  return delta ~= Vector2.zero
end

function UIActivityNPlusSixBuildingItemName:NamePanelOnClick()
  self:Click()
end

function UIActivityNPlusSixBuildingItemName:Click()
  if not self._buildingData then
    return
  end
  if not self._buildingData:CanBuild() then
    return
  end
  if not self._buildingData:IsUnLock() then
    return
  end
  if not self._buildingData:IsNextStatusUnLock() then
    return
  end
  self:ShowDialog("UIActivityNPlusSixBuildingTipsController", self._buildingData)
end
