local IslandAutoCollectAwardDisplayWindow = class("IslandAutoCollectAwardDisplayWindow", import(".IslandAwardDisplayWindow"))

function IslandAutoCollectAwardDisplayWindow:getUIName()
	return "IslandAutoCollectAwardDisplayUI"
end

function IslandAutoCollectAwardDisplayWindow:OnInit()
	self.textTF = self._tf:Find("frame/Board/Top/text/text")

	setActive(self.textTF, false)

	return
end

return IslandAutoCollectAwardDisplayWindow
