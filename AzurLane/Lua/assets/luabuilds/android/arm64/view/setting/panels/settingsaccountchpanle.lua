local var_0_0 = class("SettingsAccountCHPanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsAccountCH"
end

function var_0_0.GetTitle(arg_2_0)
	return "注销账户"
end

function var_0_0.GetTitleEn(arg_3_0)
	return "/ Account Deactivation"
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, findTF(arg_4_0._tf, "delete"), function()
		pg.SdkMgr.GetInstance():DeleteAccount()

		return
	end, SFX_PANEL)

	return
end

return var_0_0
