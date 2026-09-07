local IslandAwardDisplay4SignGiftWindow = class("IslandAwardDisplay4SignGiftWindow", import(".IslandAwardDisplayWindow"))

function IslandAwardDisplay4SignGiftWindow:getUIName()
	return "IslandAwardDisplay4SignGiftUI"
end

function IslandAwardDisplay4SignGiftWindow:Show(arg_2_1)
	IslandAwardDisplay4SignGiftWindow.super.Show(self, arg_2_1)

	self.title.text = ""

	return
end

return IslandAwardDisplay4SignGiftWindow
