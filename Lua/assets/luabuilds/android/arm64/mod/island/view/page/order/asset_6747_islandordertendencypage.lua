local IslandOrderTendencyPage = class("IslandOrderTendencyPage", import("Mod.Island.View.page.msgbox.window.IslandCommonMsgboxWindow"))

function IslandOrderTendencyPage:getUIName()
	return "IslandOrderTendencyUI"
end

function IslandOrderTendencyPage:OnLoaded()
	IslandOrderTendencyPage.super.OnLoaded(self)

	self.toggles = {
		[IslandOrderSlot.TENDENCY_TYPE_COMMON] = self._tf:Find("toggle/1"),
		[IslandOrderSlot.TENDENCY_TYPE_EASY] = self._tf:Find("toggle/0"),
		[IslandOrderSlot.TENDENCY_TYPE_HARD] = self._tf:Find("toggle/2")
	}

	setText(self._tf:Find("toggle/0/Text"), i18n("island_order_difficulty_2"))
	setText(self._tf:Find("toggle/1/Text"), i18n("island_order_difficulty_1"))
	setText(self._tf:Find("toggle/2/Text"), i18n("island_order_difficulty_3"))

	return
end

function IslandOrderTendencyPage:OnInit()
	IslandOrderTendencyPage.super.OnInit(self)
	onButton(self, self.confirmBtn, function()
		if self.onYes then
			self.onYes(self.selectedIndex)
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandOrderTendencyPage:OnShow()
	IslandOrderTendencyPage.super.OnShow(self)

	self.selectedIndex = self.settings.selected or IslandOrderSlot.TENDENCY_TYPE_COMMON

	self:FlushToggles()

	return
end

function IslandOrderTendencyPage:OnHide()
	IslandOrderTendencyPage.super.OnHide(self)

	self.settings = nil

	return
end

function IslandOrderTendencyPage:FlushToggles()
	for iter_7_0, iter_7_1 in pairs(self.toggles) do
		onToggle(self, iter_7_1, function(arg_8_0)
			if arg_8_0 then
				self.selectedIndex = iter_7_0

				self:UpdateContent()
			end

			return
		end, SFX_PANEL)
	end

	triggerToggle(self.toggles[self.selectedIndex], true)

	return
end

function IslandOrderTendencyPage:UpdateContent()
	self.contentTxt.text = IslandOrderSlot.TENDENCY2TIP(self.selectedIndex)

	return
end

return IslandOrderTendencyPage
