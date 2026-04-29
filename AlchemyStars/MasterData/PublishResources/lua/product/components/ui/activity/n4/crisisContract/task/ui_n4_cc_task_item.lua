_class("UIN4CCTaskItem", UICustomWidget)
UIN4CCTaskItem = UIN4CCTaskItem

function UIN4CCTaskItem:OnShow(uiParams)
  local iconRect = self:GetUIComponent("RectTransform", "_icon")
  self._defaultSizeDelta = Vector2(iconRect.sizeDelta.x, iconRect.sizeDelta.y)
end

function UIN4CCTaskItem:SetData(roleAsset, tipsCallback)
  self._roleAsset = roleAsset
  self._tipsCallback = tipsCallback
  self:_SetIcon(self._roleAsset)
end

function UIN4CCTaskItem:_SetIcon(roleAsset)
  local itemId, itemText = roleAsset.assetid, roleAsset.count
  UIWidgetHelper.SetItemIcon(self, itemId, "_icon")
  UIWidgetHelper.SetLocalizationText(self, "_txt", itemText)
end

function UIN4CCTaskItem:BtnOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end
