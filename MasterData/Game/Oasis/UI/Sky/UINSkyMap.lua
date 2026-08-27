local UINSkyMap = class("UINSkyMap", UIBaseNode)
local base = UIBaseNode
local CS_EventTriggerListener = CS.EventTriggerListener

function UINSkyMap:ctor(uiSkyRoot)
  self.uiSkyRoot = uiSkyRoot
end

function UINSkyMap:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.slider, self, self._OnScaleValueChange)
  self.ui.slider.minValue = 1
  self.ui.slider.maxValue = 2
  CS_EventTriggerListener.Get(self.ui.scrollMap):onClick("+", BindCallback(self, self._OnMapClick))
  CS_EventTriggerListener.Get(self.ui.slider.gameObject):onBeginDrag("+", BindCallback(self, self._OnScaleSliderBeginDrag))
  CS_EventTriggerListener.Get(self.ui.slider.gameObject):onEndDrag("+", BindCallback(self, self._OnScaleSliderEndDrag))
end

function UINSkyMap:InitSkyMap(latitude, longitude)
  self.ui.slider.value = 1
  self:SetSkyMapLocation(latitude, longitude)
end

function UINSkyMap:_OnMapClick(go, eventData)
  if eventData.dragging then
    return
  end
  local uiPos = UIManager:Screen2UIPosition(eventData.position, self.ui.map)
  local latitude, longitude = self:_UIPos2Location(uiPos)
  self.ui.posItem.anchoredPosition = uiPos
  self.uiSkyRoot:UpdSkySystemLocation(latitude, longitude, true, true)
end

function UINSkyMap:_OnScaleSliderBeginDrag()
  local mapSize = self.ui.map.sizeDelta
  local curPos = self.ui.posItem.anchoredPosition
  local newPivot = Vector2.New(curPos.x / mapSize.x, curPos.y / mapSize.y)
  local mapPos = self.ui.map.anchoredPosition
  local mapPosOffset = mapSize * self.ui.map.localScale.x
  mapPos.x = mapPos.x + mapPosOffset.x * newPivot.x
  mapPos.y = mapPos.y + mapPosOffset.y * newPivot.y
  self.ui.map.pivot = newPivot
  self.ui.map.anchoredPosition = mapPos
end

function UINSkyMap:_OnScaleSliderEndDrag()
  local pivot = self.ui.map.pivot
  local mapPos = self.ui.map.anchoredPosition
  local mapPosOffset = self.ui.map.sizeDelta * self.ui.map.localScale.x
  mapPos.x = mapPos.x - mapPosOffset.x * pivot.x
  mapPos.y = mapPos.y - mapPosOffset.y * pivot.y
  self.ui.map.pivot = Vector2.zero
  self.ui.map.anchoredPosition = mapPos
end

function UINSkyMap:_Location2UIPos(lat, lon)
  local L = 6381372 * math.pi * 2
  local W = L
  local H = L / 2
  local mill = 2.3
  local x = lon * math.pi / 180
  local y = lat * math.pi / 180
  y = 1.25 * math.log(math.tan(0.25 * math.pi + 0.4 * y))
  x = W / 2 + W / (2 * math.pi) * x
  y = H / 2 - H / (2 * mill) * y
  x = x / W
  y = 1 - y / H
  return Vector2.New(x * self.ui.map.sizeDelta.x, y * self.ui.map.sizeDelta.y)
end

function UINSkyMap:_UIPos2Location(pos)
  local x = pos.x / self.ui.map.sizeDelta.x
  local y = 1 - pos.y / self.ui.map.sizeDelta.y
  local L = 6381372 * math.pi * 2
  local W = L
  local H = L / 2
  x = x * W
  y = y * H
  local mill = 2.3
  local lat
  lat = (H / 2 - y) * 2 * mill / (1.25 * H)
  lat = (math.atan(math.exp(lat)) - 0.25 * math.pi) * 180 / (0.4 * math.pi)
  local lon
  lon = (x - W / 2) * 360 / W
  lat = math.floor(lat)
  lon = math.floor(lon)
  return lat, lon
end

function UINSkyMap:_OnScaleValueChange(value)
  self.ui.map.localScale = Vector3.New(value, value, value)
  local posItemScale = 1 / value
  self.ui.posItem.localScale = Vector3.New(posItemScale, posItemScale, posItemScale)
end

function UINSkyMap:SetSkyMapLocation(latitude, longitude)
  local uiPos = self:_Location2UIPos(latitude, longitude)
  self.ui.posItem.anchoredPosition = uiPos
  local mapSize = self.ui.map.sizeDelta
  local uiPos = self.ui.posItem.anchoredPosition
  local posRatioX = uiPos.x / mapSize.x
  local posRatioY = uiPos.y / mapSize.y
  local scale = self.ui.map.localScale.x
  local scrollSize = self.ui.scrollMap.transform.rect.size
  local posX = (mapSize.x * scale - scrollSize.x) * posRatioX
  local posY = (mapSize.y * scale - scrollSize.y) * posRatioY
  self.ui.map.anchoredPosition = Vector2.New(-posX, -posY)
end

function UINSkyMap:OnDelete()
  base.OnDelete(self)
end

return UINSkyMap
