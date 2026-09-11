local var_0_0 = {}
local var_0_1 = {
	[ActivityConst.ACTIVITY_2_8_SURVIVE_SOLO] = "UI/VersionUI/IndiaUI_2_8/IndiaTationUI/IndiaDisorienTationUI"
}

function var_0_0.GetEnterUIName(arg_1_0)
	return var_0_1[arg_1_0]
end

local var_0_2 = {
	[ActivityConst.ACTIVITY_2_8_SURVIVE_SOLO] = "ACTIVITY_SOLO_SLAYER_DESC"
}

function var_0_0.GetGameHelpKey(arg_2_0)
	return var_0_2[arg_2_0] or ""
end

local var_0_3 = {
	[ActivityConst.ACTIVITY_2_8_SURVIVE_SOLO] = "UI/VersionUI/IndiaUI_2_8/IndiaTationUI/IndiaDisorienTationRewardUI"
}

function var_0_0.GetRewardPopView(arg_3_0)
	return var_0_3[arg_3_0]
end

return var_0_0
