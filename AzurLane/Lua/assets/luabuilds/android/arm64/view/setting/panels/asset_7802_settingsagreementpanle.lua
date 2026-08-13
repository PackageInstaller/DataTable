class = var_0_10000

local var_0_0 = "SettingsAgreementPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsAgreement"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_agreement")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / VIEW AGREEMENT"
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "private")

	local function var_4_3()
		pg = var_2_10000

		local var_5_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.ShowPrivate(var_5_0)

		return
	end

	SFX_PANEL = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_4.Find(var_4_5, "licence")

	local function var_4_7()
		pg = var_2_10000

		local var_6_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.ShowLicence(var_6_0)

		return
	end

	SFX_PANEL = var_4_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_4_5)

	return
end

function var_0_1.OnUpdate(arg_7_0)
	return
end

return var_0_1
