local var_0_0 = class("SettingsAgreementCHTPanle", import(".SettingsAgreementPanle"))

function var_0_0.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf:Find("private")

	onButton(arg_1_0, var_1_0, function()
		pg.UserAgreementMgr.GetInstance():ShowChtPrivate()

		return
	end, SFX_PANEL)

	local var_1_1 = arg_1_0._tf:Find("licence")

	onButton(arg_1_0, var_1_1, function()
		pg.UserAgreementMgr.GetInstance():ShowChtLicence()

		return
	end, SFX_PANEL)
	setText(var_1_0:Find("Text"), i18n("setting_label_private"))
	setText(var_1_1:Find("Text"), i18n("setting_label_licence"))

	return
end

return var_0_0
