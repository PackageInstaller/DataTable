class = var_0_10000

local var_0_0 = "SettingsServicePanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsServiceCH"
end

function var_0_1.GetTitle(arg_2_0)
	return "客服"
end

function var_0_1.GetTitleEn(arg_3_0)
	return "/ Service"
end

function var_0_1.OnInit(arg_4_0)
	findTF = var_1_10001
	arg_4_0.serviceBtn = var_1_10001(arg_4_0._tf, "delete")
	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.serviceBtn

	local function var_4_2()
		pg = var_2_10000

		local var_5_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.Service(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	return
end

function var_0_1.OnUpdate(arg_6_0)
	return
end

return var_0_1
