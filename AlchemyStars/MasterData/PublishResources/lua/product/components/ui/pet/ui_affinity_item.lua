_class("UIAffinityItem", UICustomWidget)

function UIAffinityItem:Constructor()
end

function UIAffinityItem:OnShow(uiParams)
  self._attName = self:GetUIComponent("UILocalizationText", "attName")
  self._attValue = self:GetUIComponent("UILocalizationText", "attValue")
end

function UIAffinityItem:SetData(attInfo)
  self._attName.text = StringTable.Get(attInfo.attType)
  self._attValue.text = "+" .. attInfo.attValue
end
