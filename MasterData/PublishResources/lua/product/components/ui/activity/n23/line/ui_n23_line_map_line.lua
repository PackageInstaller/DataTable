_class("UIN23LineMapLine", UICustomWidget)
UIN23LineMapLine = UIN23LineMapLine

function UIN23LineMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIN23LineMapLine:OnHide()
end

function UIN23LineMapLine:Flush(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
