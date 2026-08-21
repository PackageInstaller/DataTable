local var_0_0 = class("SettingsAgreementPanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsAgreement"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_agreement")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / VIEW AGREEMENT"
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("private"), function()
		pg.SdkMgr.GetInstance():ShowPrivate()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0._tf:Find("licence"), function()
		pg.SdkMgr.GetInstance():ShowLicence()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdate(arg_7_0)
	return
end

return var_0_0
