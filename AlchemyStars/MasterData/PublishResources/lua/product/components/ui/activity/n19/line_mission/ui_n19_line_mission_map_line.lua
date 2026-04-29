_class("UIN19LineMissionMapLine", UICustomWidget)
UIN19LineMissionMapLine = UIN19LineMissionMapLine

function UIN19LineMissionMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIN19LineMissionMapLine:OnHide()
end

function UIN19LineMissionMapLine:Flush(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
