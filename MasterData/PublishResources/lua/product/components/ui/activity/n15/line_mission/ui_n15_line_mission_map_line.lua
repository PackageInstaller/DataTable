_class("UIN15LineMissionMapLine", UICustomWidget)
UIN15LineMissionMapLine = UIN15LineMissionMapLine

function UIN15LineMissionMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIN15LineMissionMapLine:OnHide()
end

function UIN15LineMissionMapLine:Flush(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
