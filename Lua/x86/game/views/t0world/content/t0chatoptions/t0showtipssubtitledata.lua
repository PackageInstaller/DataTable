local var_0_0 = import("game.views.t0World.Content.T0ChatOptions.T0SubtitleData")
local var_0_1 = class("T0ShowTipsSubtitleData", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, 0, "", 0, 999)

	arg_1_0.showTipsKey = arg_1_1
end

function var_0_1.GetContent(arg_2_0)
	return GetTips(arg_2_0.showTipsKey)
end

function var_0_1.GetKey(arg_3_0)
	return GetTips("T0_WORLD_HORUS_TIPS_16")
end

return var_0_1
