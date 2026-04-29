_class("UIN27MiniGameWayLine", UICustomWidget)
UIN27MiniGameWayLine = UIN27MiniGameWayLine

function UIN27MiniGameWayLine:OnShow(uiParams)
  self._lineImg = {
    [true] = "n27_poststation_line1",
    [false] = "n27_poststation_line2"
  }
  self:_GetComponents()
end

function UIN27MiniGameWayLine:_GetComponents()
  self._line = self:GetUIComponent("RectTransform", "Line")
  self._atlas = self:GetAsset("UIN27PostStation.spriteatlas", LoadType.SpriteAtlas)
end

function UIN27MiniGameWayLine:SetData(state)
end

function UIN27MiniGameWayLine:Flush(from, to)
  local dis = Vector2.Distance(from, to)
  self._line.sizeDelta = Vector2(dis, self._line.sizeDelta.y)
  self._line.anchoredPosition = Vector2((from.x + to.x) / 2, (from.y + to.y) / 2)
  local v = to - from
  self._line.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
