local IslandShipStatusBox = class("IslandShipStatusBox", import(".IslandShipStatusPage"))

function IslandShipStatusBox:getUIName()
	return "IslandShipStatusBox"
end

function IslandShipStatusBox:OnLoaded()
	IslandShipStatusBox.super.OnLoaded(self)

	self.hideBtn = self._tf:Find("close")

	return
end

function IslandShipStatusBox:OnInit()
	IslandShipStatusBox.super.OnInit(self)
	onButton(self, self.hideBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandShipStatusBox:OnShow(...)
	IslandShipStatusBox.super.OnShow(self, ...)
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})

	return
end

function IslandShipStatusBox:OnHide()
	IslandShipStatusBox.super.OnHide(self)
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandShipStatusBox:OnDisable()
	self:OnHide()

	return
end

return IslandShipStatusBox
