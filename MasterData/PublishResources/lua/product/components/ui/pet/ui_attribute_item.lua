_class("UIAttributeItem", UICustomWidget)

function UIAttributeItem:Constructor()
end

function UIAttributeItem:OnShow(uiParams)
  self._nameText = self:GetUIComponent("Text", "attName")
  self._nameEnglishText = self:GetUIComponent("Text", "attEnglishName")
  self._attValue = self:GetUIComponent("Text", "attValue")
end

function UIAttributeItem:SetData(itemInfo, index)
  self._attValue.text = itemInfo.attValue
  self._nameText.text = StringTable.Get(itemInfo.attType)
  self._nameEnglishText.text = StringTable.Get(itemInfo.englishName)
end
