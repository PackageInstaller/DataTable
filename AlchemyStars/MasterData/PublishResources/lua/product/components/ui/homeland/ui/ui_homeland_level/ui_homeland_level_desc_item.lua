_class("UIHomelandLevelDescItem", UICustomWidget)
UIHomelandLevelDescItem = UIHomelandLevelDescItem

function UIHomelandLevelDescItem:Constructor()
end

function UIHomelandLevelDescItem:OnShow()
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
end

function UIHomelandLevelDescItem:Flush(desc)
  self.txt:SetText(desc)
end
