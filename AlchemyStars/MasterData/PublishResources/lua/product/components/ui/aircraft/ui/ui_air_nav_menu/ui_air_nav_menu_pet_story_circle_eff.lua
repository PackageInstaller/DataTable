_class("UIAirNavMenuPetStoryCircleEff", UICustomWidget)
UIAirNavMenuPetStoryCircleEff = UIAirNavMenuPetStoryCircleEff

function UIAirNavMenuPetStoryCircleEff:OnShow(uiParams)
  self._offset = Vector2(0, 20)
end

function UIAirNavMenuPetStoryCircleEff:OnHide()
end

function UIAirNavMenuPetStoryCircleEff:SetData(pos, size, data)
  self:GetComponents()
  self._size = size
  self._data = data
  self._pos = pos
  self:OnValue()
end

function UIAirNavMenuPetStoryCircleEff:FlushPos(pos)
  self._pos = pos
  self._rect.anchoredPosition = self._pos + self._offset
end

function UIAirNavMenuPetStoryCircleEff:OnValue()
  self._rect.anchoredPosition = self._pos + self._offset
  self._rect.sizeDelta = self._size
end

function UIAirNavMenuPetStoryCircleEff:GetComponents()
  self._rect = self:GetUIComponent("RectTransform", "pos")
end
