_class("UIFLTTLevelLine", UICustomWidget)
UIFLTTLevelLine = UIFLTTLevelLine

function UIFLTTLevelLine:OnShow()
  self._shape = self:GetUIComponent("RectTransform", "shape")
  self._line = self:GetUIComponent("Image", "line")
  self._atlas = self:GetAsset("UIN26Line.spriteatlas", LoadType.SpriteAtlas)
end

function UIFLTTLevelLine:OnHide()
end

function UIFLTTLevelLine:LineCfg()
  local cfg = {
    [1] = {
      url = "n26_xxg_xian01",
      offset = Vector2(0, 20),
      rotation = 25
    },
    [2] = {
      url = "n26_xxg_xian02",
      offset = Vector2(0, 0),
      rotation = -33
    }
  }
  return cfg
end

function UIFLTTLevelLine:Flush(from, to)
  local cfg
  if to.y > from.y then
    cfg = self:LineCfg()[1]
  else
    cfg = self:LineCfg()[2]
  end
  self._line.sprite = self._atlas:GetSprite(cfg.url)
  self._line.transform.anchoredPosition = cfg.offset
  self._line.transform.localEulerAngles = Vector3(0, 0, cfg.rotation)
  local anchoredPosition = (from + to) * 0.5
  self._shape.anchoredPosition = anchoredPosition
  local v = from - to
  self._shape.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
