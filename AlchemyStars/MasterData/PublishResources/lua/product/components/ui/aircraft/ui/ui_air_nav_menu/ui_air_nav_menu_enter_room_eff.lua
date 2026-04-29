_class("UIAirNavMenuEnterRoomEff", UICustomWidget)
UIAirNavMenuEnterRoomEff = UIAirNavMenuEnterRoomEff

function UIAirNavMenuEnterRoomEff:OnShow(uiParams)
end

function UIAirNavMenuEnterRoomEff:OnHide()
end

function UIAirNavMenuEnterRoomEff:SetData(pos, size, data, callback)
  self:GetComponents()
  self._size = size
  self._data = data
  self._pos = pos
  self._lv = data.lv
  self._enter = data.enter
  self._build = data.build
  self._callback = callback
  self:OnValue()
end

function UIAirNavMenuEnterRoomEff:OnValue()
  self._rect.anchoredPosition = self._pos
  self._rect.sizeDelta = self._size
  if self._build then
    self._buildGo:SetActive(true)
    self._lvGo:SetActive(false)
    self._enterGo:SetActive(false)
  else
    self._buildGo:SetActive(false)
    self._enterGo:SetActive(self._enter)
    if self._enter then
      self._lvGo:SetActive(false)
    else
      self._lvGo:SetActive(self._lv)
    end
  end
end

function UIAirNavMenuEnterRoomEff:GetComponents()
  self._rect = self:GetUIComponent("RectTransform", "pos")
  self._enterGo = self:GetGameObject("enterGo")
  self._lvGo = self:GetGameObject("lvGo")
  self._buildGo = self:GetGameObject("buildGo")
end

function UIAirNavMenuEnterRoomEff:btnOnClick(go)
  if self._callback then
    self._callback(self._data)
  end
end
