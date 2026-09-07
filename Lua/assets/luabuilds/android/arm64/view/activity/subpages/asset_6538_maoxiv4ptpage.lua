local MaoxiV4PtPage = class("MaoxiV4PtPage", import(".TemplatePage.PtTemplatePage"))

function MaoxiV4PtPage:OnFirstFlush()
	MaoxiV4PtPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

		return
	end, SFX_PANEL)

	return
end

return MaoxiV4PtPage
