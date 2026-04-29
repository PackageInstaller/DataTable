_class("UIActivityNPlusSixBuildingSpine", UICustomWidget)
UIActivityNPlusSixBuildingSpine = UIActivityNPlusSixBuildingSpine

function UIActivityNPlusSixBuildingSpine:OnShow()
  self._tran = self:GetUIComponent("RectTransform", "Go")
  self._spineLoader = self:GetUIComponent("SpineLoader", "Spine")
end

function UIActivityNPlusSixBuildingSpine:Refresh(parent, cfg)
  self._tran.parent = parent
  self._tran.anchoredPosition = Vector2(cfg.Position[1], cfg.Position[2])
  self._spineLoader:LoadSpine(cfg.SpineName)
end

function UIActivityNPlusSixBuildingSpine:SetVisible(isVisible)
  local go = self:GetGameObject("Go")
  go:SetActive(isVisible)
end
