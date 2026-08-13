class = var_0_10000

local var_0_0 = "SiChuanOperaPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.LoginTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.dayText = var_1.Find(var_1_0, "AD/DayText")

	local var_1_1 = arg_1_0._tf

	arg_1_0.url = var_1.Find(var_1_1, "AD/url")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.url

	local function var_2_2()
		Application = var_2_10000

		local var_3_0 = var_2_10000.OpenURL
		local var_3_1 = arg_2_0.activity

		var_3_0(var_2.getConfig(var_3_1, "config_client"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	var_0_1.super.OnUpdateFlush(arg_4_0)

	setText = var_1

	local var_4_0 = arg_4_0.dayText

	string = var_1_10004

	var_1(var_4_0, var_1_10004.format("%02d", arg_4_0.nday))

	return
end

return var_0_1
