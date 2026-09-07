local U410VictoryPtPage = class("U410VictoryPtPage", import(".TemplatePage.PtTemplatePage"))

function U410VictoryPtPage:OnFirstFlush()
	U410VictoryPtPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

return U410VictoryPtPage
