_class("UIActivityBattlePassN5IconText", UICustomWidget)
UIActivityBattlePassN5IconText = UIActivityBattlePassN5IconText

function UIActivityBattlePassN5IconText:_GetComponents()
  self._iconImg = self:GetUIComponent("RawImageLoader", "icon")
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
end

function UIActivityBattlePassN5IconText:SetData(index, url, titleId)
  self:_GetComponents()
  self._iconImg:LoadImage(url)
  self._txtTitle:SetText(StringTable.Get(titleId))
end

function UIActivityBattlePassN5IconText:OnShow(uiParams)
end

function UIActivityBattlePassN5IconText:OnHide()
end
