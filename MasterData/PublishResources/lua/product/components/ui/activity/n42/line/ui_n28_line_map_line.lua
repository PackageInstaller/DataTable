_class("UIN28LineMapLine", UICustomWidget)
UIN28LineMapLine = UIN28LineMapLine

function UIN28LineMapLine:OnShow()
  self._shape = self:GetUIComponent("RectTransform", "shape")
  self._line = self:GetUIComponent("Image", "line")
  self._atlas = nil
end

function UIN28LineMapLine:OnHide()
end

function UIN28LineMapLine:LineCfg()
  local cfg = {
    [1] = {
      url = "n28_xxg_xian01",
      offset = Vector2(-36, -50),
      rotation = -12
    },
    [2] = {
      url = "n28_xxg_xian01",
      offset = Vector2(0, -38),
      rotation = 12
    }
  }
  return cfg
end

function UIN28LineMapLine:SetAtlas(atlas)
  self._atlas = atlas
end

function UIN28LineMapLine:Flush(from, to)
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
