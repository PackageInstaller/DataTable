_class("UIBattlePassCN1IconText", UICustomWidget)
UIBattlePassCN1IconText = UIBattlePassCN1IconText

function UIBattlePassCN1IconText:_GetComponents()
  self._iconImg = self:GetUIComponent("RawImageLoader", "icon")
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
end

function UIBattlePassCN1IconText:SetData(index, url, titleId)
  self:_GetComponents()
  self._iconImg:LoadImage(url)
  self._txtTitle:SetText(StringTable.Get(titleId))
end
