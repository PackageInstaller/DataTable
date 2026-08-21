local var_0_0 = {}
local var_0_1 = {
	[ActivityConst.ACTIVITY_USE_DUNDUN] = "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_DundunUI/ShashwatUI_3_6_DundunMainUI",
	[ActivityConst.ACTIVITY_USE_DUNDUN_4_5] = "Widget/Version/V4_5_Horus/V4_5_Horus_DundunUI/V4_5_Horus_DundunMainUI"
}

function var_0_0.GetUINameKey(arg_1_0)
	return var_0_1[arg_1_0] or ""
end

return var_0_0
