_class("UIActivityBlackBoxMainDiffLevelLine", UICustomWidget)
UIActivityBlackBoxMainDiffLevelLine = UIActivityBlackBoxMainDiffLevelLine

function UIActivityBlackBoxMainDiffLevelLine:OnShow()
  self._shape = self:GetUIComponent("RectTransform", "shape")
  self._line = self:GetUIComponent("RawImageLoader", "line")
end

function UIActivityBlackBoxMainDiffLevelLine:OnHide()
end

function UIActivityBlackBoxMainDiffLevelLine:Flush(cfg)
  self._cfg = cfg
  local pos = Vector2(cfg.Position[1], cfg.Position[2])
  local rot = cfg.Rotation
  local pic = cfg.Pic
  self._line.transform.localEulerAngles = Vector3(0, 0, rot)
  self._shape.anchoredPosition = pos
  self._line:LoadImage(pic)
end
