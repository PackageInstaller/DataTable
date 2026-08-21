_class("UIAirNavMenuAssetRoomEff", UICustomWidget)
UIAirNavMenuAssetRoomEff = UIAirNavMenuAssetRoomEff

function UIAirNavMenuAssetRoomEff:OnShow(uiParams)
end

function UIAirNavMenuAssetRoomEff:OnHide()
end

function UIAirNavMenuAssetRoomEff:SetData(pos, size, data, callback)
  self:GetComponents()
  self._size = size
  self._data = data
  self._pos = pos
  self._callback = callback
  self:OnValue()
end

function UIAirNavMenuAssetRoomEff:OnValue()
  self._rect.anchoredPosition = self._pos
  self._rect.sizeDelta = self._size
end

function UIAirNavMenuAssetRoomEff:GetComponents()
  self._rect = self:GetUIComponent("RectTransform", "pos")
end

function UIAirNavMenuAssetRoomEff:btnOnClick(go)
  if self._callback then
    self._callback(self._data)
  end
end
