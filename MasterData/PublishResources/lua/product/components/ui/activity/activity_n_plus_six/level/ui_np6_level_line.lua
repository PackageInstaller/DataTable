_class("UINP6LevelLine", UICustomWidget)
UINP6LevelLine = UINP6LevelLine

function UINP6LevelLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UINP6LevelLine:OnHide()
end

function UINP6LevelLine:Flush(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
