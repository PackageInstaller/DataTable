local MemphisHalloweenPage = class("MemphisHalloweenPage", import(".TemplatePage.PtTemplatePage"))

function MemphisHalloweenPage:OnFirstFlush()
	MemphisHalloweenPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

return MemphisHalloweenPage
