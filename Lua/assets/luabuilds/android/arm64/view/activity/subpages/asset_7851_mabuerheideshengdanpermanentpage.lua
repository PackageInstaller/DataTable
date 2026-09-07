local MabuerheideshengdanPermanentPage = class("MabuerheideshengdanPermanentPage", import(".TemplatePage.PtTemplatePage"))

function MabuerheideshengdanPermanentPage:OnFirstFlush()
	MabuerheideshengdanPermanentPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

return MabuerheideshengdanPermanentPage
