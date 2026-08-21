local var_0_0 = class("MaoxiV4PtPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

		return
	end, SFX_PANEL)

	return
end

return var_0_0
