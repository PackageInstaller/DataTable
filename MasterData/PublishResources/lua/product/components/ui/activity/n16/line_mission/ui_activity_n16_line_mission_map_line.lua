_class("UIActivityN16LineMissionMapLine", UICustomWidget)
UIActivityN16LineMissionMapLine = UIActivityN16LineMissionMapLine

function UIActivityN16LineMissionMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
  self._lineImg = self:GetUIComponent("Image", "line")
end

function UIActivityN16LineMissionMapLine:OnHide()
end

function UIActivityN16LineMissionMapLine:Flush(from, to, cfg, atlas)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
  local spStr = cfg.ID % 2 == 1 and "n16_xxg_xian01" or "n16_xxg_xian02"
  self._lineImg.sprite = atlas:GetSprite(spStr)
end
