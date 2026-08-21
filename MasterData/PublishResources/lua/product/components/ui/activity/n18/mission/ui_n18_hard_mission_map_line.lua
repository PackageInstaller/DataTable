_class("UIN18HardMissionMapLine", UICustomWidget)
UIN18HardMissionMapLine = UIN18HardMissionMapLine

function UIN18HardMissionMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
  self._image = self:GetUIComponent("Image", "line")
end

function UIN18HardMissionMapLine:OnHide()
end

function UIN18HardMissionMapLine:Flush(from, to, condition, config)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
  if not condition then
    self._image.sprite = config.unnormal
  else
    self._image.sprite = config.normal
  end
end
