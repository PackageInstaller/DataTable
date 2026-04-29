_class("UISailingKvItem", UICustomWidget)
UISailingKvItem = UISailingKvItem

function UISailingKvItem:Constructor()
  self._cfgChapter = nil
end

function UISailingKvItem:OnShow()
  self._imgChapterValue = self:GetUIComponent("RawImageLoader", "imgChapterValue")
  self._imgChapterImage = self:GetUIComponent("RawImage", "imgChapterValue")
  self._txtChapterValue = self:GetUIComponent("UILocalizationText", "txtChapterValue")
  self._selectedImage = self:GetUIComponent("RawImageLoader", "selectedImage")
  self._lockedImage = self:GetUIComponent("RawImageLoader", "lockedImage")
end

function UISailingKvItem:OnHide()
end

function UISailingKvItem:Init(luaIndex, cfg)
  self._cfgChapter = cfg
  local chapterValue = StringTable.Get("str_sailing_mission_arg_layer", luaIndex)
  self._txtChapterValue:SetText(chapterValue)
  self._imgChapterValue:LoadImage(cfg.LayerDrawing)
  local localPosition = Vector2.zero
  local localScale = Vector3.one
  local transform = self:View().transform
  local cfgLayerTransform = cfg.LayerTransform
  if cfgLayerTransform ~= nil and 3 <= #cfgLayerTransform then
    localPosition = Vector3(cfgLayerTransform[1], cfgLayerTransform[2], 0)
    localScale = Vector3(cfgLayerTransform[3], cfgLayerTransform[3], 1)
  end
  transform.localPosition = localPosition
  transform.localScale = localScale
end

function UISailingKvItem:InitStair(luaIndex, cfg)
  self._cfgChapter = cfg
  self._imgChapterValue.gameObject:SetActive(cfg.StairDrawing ~= nil)
  self._imgChapterValue:LoadImage(cfg.StairDrawing)
  self._imgChapterValue.transform.sizeDelta = Vector2(280, 273)
  local localPosition = Vector2.zero
  local localScale = Vector3.one
  local transform = self:View().transform
  local cfgStairTransform = cfg.StairTransform
  if cfgStairTransform ~= nil and 3 <= #cfgStairTransform then
    localPosition = Vector3(cfgStairTransform[1], cfgStairTransform[2], 0)
    localScale = Vector3(cfgStairTransform[3], cfgStairTransform[3], 1)
  end
  transform.localPosition = localPosition
  transform.localScale = localScale
  self._txtChapterValue.gameObject:SetActive(false)
end

function UISailingKvItem:SetSelected(isSelected)
  if self._selectedImage.gameObject.activeSelf ~= isSelected then
    self._selectedImage.gameObject:SetActive(isSelected)
  end
end

function UISailingKvItem:SetLocked(isLocked)
  if self._lockedImage.gameObject.activeSelf ~= isLocked then
    self._lockedImage.gameObject:SetActive(isLocked)
  end
end
