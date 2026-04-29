_class("UIActivityBattlePassIconText", UICustomWidget)
UIActivityBattlePassIconText = UIActivityBattlePassIconText

function UIActivityBattlePassIconText:_GetComponents()
  self._iconImg = self:GetUIComponent("RawImageLoader", "icon")
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
end

function UIActivityBattlePassIconText:SetData(index, url, titleId)
  self:_GetComponents()
  self._iconImg:LoadImage(url)
  self._txtTitle:SetText(StringTable.Get(titleId))
end

function UIActivityBattlePassIconText:OnShow(uiParams)
end

function UIActivityBattlePassIconText:OnHide()
end
