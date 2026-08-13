class = var_0_10000

local var_0_0 = "ShipAtlasBgBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....PlayerVitae.btns.PlayerVitaeBGBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.event = arg_1_3
	arg_1_0.value = arg_1_4

	return
end

function var_0_1.emit(arg_2_0, ...)
	local var_2_0 = arg_2_0.event

	var_1.emit(var_2_0, ...)

	return
end

function var_0_1.GetDefaultValue(arg_3_0)
	return arg_3_0.value
end

function var_0_1.OnSwitch(arg_4_0, arg_4_1)
	return true
end

function var_0_1.OnSwitchDone(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.emit

	SkinAtlasPreviewPage = var_1_10004

	var_5_1(var_5_0, var_1_10004.ON_BG_SWITCH_DONE, arg_5_0.flag)

	return
end

return var_0_1
