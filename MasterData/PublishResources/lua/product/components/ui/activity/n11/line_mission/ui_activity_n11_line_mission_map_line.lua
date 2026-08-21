_class("UIActivityN11LineMissionMapLine", UICustomWidget)
UIActivityN11LineMissionMapLine = UIActivityN11LineMissionMapLine

function UIActivityN11LineMissionMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIActivityN11LineMissionMapLine:OnHide()
end

function UIActivityN11LineMissionMapLine:Flush(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
