_class("UIActivityN6Line", UICustomWidget)
UIActivityN6Line = UIActivityN6Line

function UIActivityN6Line:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIActivityN6Line:OnHide()
end

function UIActivityN6Line:Flush(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
