class = var_0_10000

local var_0_0 = "SettingsAccountCHPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsAccountCH"
end

function var_0_1.GetTitle(arg_2_0)
	return "注销账户"
end

function var_0_1.GetTitleEn(arg_3_0)
	return "/ Account Deactivation"
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0

	findTF = var_1_10004

	local var_4_1 = var_1_10004(arg_4_0._tf, "delete")

	local function var_4_2()
		pg = var_2_10000

		local var_5_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.DeleteAccount(var_5_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_4_0, var_4_1, var_4_2, var_6)

	return
end

return var_0_1
