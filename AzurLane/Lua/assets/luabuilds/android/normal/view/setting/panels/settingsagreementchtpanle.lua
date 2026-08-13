class = var_0_10000

local var_0_0 = "SettingsAgreementCHTPanle"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsAgreementPanle"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_1.Find(var_1_0, "private")

	onButton = var_1_0

	local var_1_2 = arg_1_0
	local var_1_3 = var_1_1

	local function var_1_4()
		pg = var_2_10000

		local var_2_0 = var_2_10000.UserAgreementMgr.GetInstance()

		var_0.ShowChtPrivate(var_2_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_0(var_1_2, var_1_3, var_1_4, var_1_10006)

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_2.Find(var_1_5, "licence")

	onButton = var_1_5

	local var_1_7 = arg_1_0
	local var_1_8 = var_1_6

	local function var_1_9()
		pg = var_2_10000

		local var_3_0 = var_2_10000.UserAgreementMgr.GetInstance()

		var_0.ShowChtLicence(var_3_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_5(var_1_7, var_1_8, var_1_9, var_1_10007)

	setText = var_1_5

	local var_1_10 = var_1_1
	local var_1_11 = var_1_1.Find(var_1_10, "Text")

	i18n = var_1_10

	var_1_5(var_1_11, var_1_10("setting_label_private"))

	setText = var_1_5

	local var_1_12 = var_1_6
	local var_1_13 = var_1_6.Find(var_1_12, "Text")

	i18n = var_1_12

	var_1_5(var_1_13, var_1_12("setting_label_licence"))

	return
end

return var_0_1
