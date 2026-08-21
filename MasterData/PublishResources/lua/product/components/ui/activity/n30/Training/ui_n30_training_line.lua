_class("UIN30TrainingLine", UICustomWidget)
UIN30TrainingLine = UIN30TrainingLine

function UIN30TrainingLine:OnShow()
  self._shape = self:GetUIComponent("RectTransform", "shape")
  self._line = self:GetUIComponent("Image", "line")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._atlas = nil
end

function UIN30TrainingLine:OnHide()
end

function UIN30TrainingLine:LineCfg()
  local cfg = {
    [1] = {
      url = "n30_yhjf_di05",
      offset = Vector2(27, 23),
      rotation = 30,
      anim = "uieff_UIN30TrainingLine_down"
    },
    [2] = {
      url = "n30_yhjf_di06",
      offset = Vector2(5, -3),
      rotation = -17,
      anim = "uieff_UIN30TrainingLine_up"
    }
  }
  return cfg
end

function UIN30TrainingLine:SetAtlas(atlas)
  self._atlas = atlas
end

function UIN30TrainingLine:Flush(from, to)
  local cfg
  if to.y > from.y then
    cfg = self:LineCfg()[1]
  else
    cfg = self:LineCfg()[2]
  end
  self._anim:Play(cfg.anim)
  self._line.sprite = self._atlas:GetSprite(cfg.url)
  self._line.transform.anchoredPosition = cfg.offset
  self._line.transform.localEulerAngles = Vector3(0, 0, cfg.rotation)
  local anchoredPosition = (from + to) * 0.5
  self._shape.anchoredPosition = anchoredPosition
  local v = from - to
  self._shape.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
