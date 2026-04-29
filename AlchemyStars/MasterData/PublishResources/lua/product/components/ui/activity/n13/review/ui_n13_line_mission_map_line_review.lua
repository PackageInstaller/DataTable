_class("UIN13LineMissionMapLineReview", UICustomWidget)
UIN13LineMissionMapLineReview = UIN13LineMissionMapLineReview

function UIN13LineMissionMapLineReview:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIN13LineMissionMapLineReview:OnHide()
end

function UIN13LineMissionMapLineReview:Flush(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
