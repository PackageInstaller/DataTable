local var_0_0 = class("ShipAtlasLive2dBtn", import("....PlayerVitae.btns.PlayerVitaeLive2dBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.event = arg_1_3
	arg_1_0.value = arg_1_4

	return
end

function var_0_0.emit(arg_2_0, ...)
	arg_2_0.event:emit(...)

	return
end

function var_0_0.GetDefaultValue(arg_3_0)
	return arg_3_0.value
end

function var_0_0.OnSwitch(arg_4_0, arg_4_1)
	return true
end

function var_0_0.OnSwitchDone(arg_5_0)
	arg_5_0:emit(SkinAtlasPreviewPage.ON_L2D_SWITCH_DONE, arg_5_0.flag)

	return
end

return var_0_0
