_class("UIAircraftPreconditionItem", UICustomWidget)
UIAircraftPreconditionItem = UIAircraftPreconditionItem

function UIAircraftPreconditionItem:OnShow(uiParams)
  self:InitWidget()
end

function UIAircraftPreconditionItem:InitWidget()
  self.textLevelCount = self:GetUIComponent("UILocalizationText", "TextLevelCount")
  self.textRoomName = self:GetUIComponent("UILocalizationText", "TextRoomName")
  self.textRoomCount = self:GetUIComponent("UILocalizationText", "TextRoomCount")
end

function UIAircraftPreconditionItem:SetData(_levelCount, _name, _count)
  self.textLevelCount.text = _levelCount
  self.textRoomName.text = _name
  self.textRoomCount.text = "(" .. _count .. ")"
end
