_class("UIAirNavMenuDiscoveryRoomEff", UICustomWidget)
UIAirNavMenuDiscoveryRoomEff = UIAirNavMenuDiscoveryRoomEff

function UIAirNavMenuDiscoveryRoomEff:OnShow(uiParams)
end

function UIAirNavMenuDiscoveryRoomEff:OnHide()
end

function UIAirNavMenuDiscoveryRoomEff:SetData(pos, size, data, callback)
  self:GetComponents()
  self._size = size
  self._data = data
  self._pos = pos
  self._callback = callback
  self:OnValue()
end

function UIAirNavMenuDiscoveryRoomEff:OnValue()
  self._rect.anchoredPosition = self._pos
  self._rect.sizeDelta = self._size
  local tex
  if self._data.finish then
    tex = "str_aircraft_quality_menu_can_dispatch_finish"
  else
    tex = "str_aircraft_quality_menu_can_dispatch"
  end
  self._tex:SetText(StringTable.Get(tex))
end

function UIAirNavMenuDiscoveryRoomEff:GetComponents()
  self._rect = self:GetUIComponent("RectTransform", "pos")
  self._tex = self:GetUIComponent("UILocalizationText", "tex")
end

function UIAirNavMenuDiscoveryRoomEff:btnOnClick(go)
  if self._callback then
    self._callback(self._data.room)
  end
end
