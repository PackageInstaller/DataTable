local SculptureTipPage = class("SculptureTipPage", import("view.base.BaseSubView"))

function SculptureTipPage:getUIName()
	return "SculptureTipUI"
end

function SculptureTipPage:OnLoaded()
	self.tip = self._tf:Find("tip")

	return
end

function SculptureTipPage:OnInit()
	return
end

function SculptureTipPage:Show()
	SculptureTipPage.super.Show(self)
	setActive(self.tip, true)
	onDelayTick(function()
		self:Hide()

		return
	end, 2)

	return
end

function SculptureTipPage:Hide()
	SculptureTipPage.super.Hide(self)
	setActive(self.tip, false)

	return
end

function SculptureTipPage:OnDestroy()
	return
end

return SculptureTipPage
