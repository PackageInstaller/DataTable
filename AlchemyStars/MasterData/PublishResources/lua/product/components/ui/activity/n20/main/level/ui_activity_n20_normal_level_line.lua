_class("UIActivityN20NormalLevelLine", UICustomWidget)
UIActivityN20NormalLevelLine = UIActivityN20NormalLevelLine

function UIActivityN20NormalLevelLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIActivityN20NormalLevelLine:OnHide()
end

function UIActivityN20NormalLevelLine:Flush(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
