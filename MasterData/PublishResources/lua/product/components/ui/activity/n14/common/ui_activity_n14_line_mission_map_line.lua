_class("UIActivityN14LineMissionMapLine", UICustomWidget)
UIActivityN14LineMissionMapLine = UIActivityN14LineMissionMapLine

function UIActivityN14LineMissionMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
  self._image = self:GetUIComponent("Image", "line")
end

function UIActivityN14LineMissionMapLine:OnHide()
end

function UIActivityN14LineMissionMapLine:Flush(from, to, condition)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
  if not condition then
    self._image.color = Color(0, 0, 0, 1)
  end
end
