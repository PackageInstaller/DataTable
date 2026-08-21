_class("UIBossHPEliteItem", UICustomWidget)
UIBossHPEliteItem = UIBossHPEliteItem

function UIBossHPEliteItem:Constructor()
end

function UIBossHPEliteItem:OnShow()
  self._text = self:GetUIComponent("UILocalizationText", "text")
end

function UIBossHPEliteItem:OnHide()
end

function UIBossHPEliteItem:OnSetData(eliteKey)
  self._text.text = StringTable.Get(eliteKey)
end

function UIBossHPEliteItem:OnGetTextWidth()
  return self._text.preferredWidth
end
