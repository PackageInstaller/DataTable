_class("UIHomelandBreedItem", UICustomWidget)
UIHomelandBreedItem = UIHomelandBreedItem

function UIHomelandBreedItem:Constructor()
  self._data = nil
end

function UIHomelandBreedItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIHomelandBreedItem:_GetComponents()
  self._backgroundRect = self:GetUIComponent("RectTransform", "Background")
  self._quality = self:GetUIComponent("Image", "Quality")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconRect = self:GetUIComponent("RectTransform", "Icon")
  self._flag = self:GetUIComponent("Image", "Flag")
end

function UIHomelandBreedItem:SetData(data, backgroundSize, iconSize)
  self._data = data
  self.view.gameObject:SetActive(self._data ~= nil)
  if self._data then
    self._icon:LoadImage(self._data.Icon)
  end
  if backgroundSize then
    self._backgroundRect.sizeDelta = backgroundSize
  end
  if iconSize then
    self._iconRect.sizeDelta = iconSize
  end
end
