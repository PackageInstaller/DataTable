class = var_0_10000

local var_0_0 = "IslandPreviewCore"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.IslandCore"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.furnitrueId = arg_1_4
	arg_1_0.lastExitPosition = arg_1_5

	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_1.GetViewAndController(arg_2_0, arg_2_1)
	AgoraPreviewController = var_1_10002

	local var_2_0 = var_1_10002.New(arg_2_0, arg_2_1, arg_2_0.furnitrueId, arg_2_0.lastExitPosition)
	local var_2_1 = var_2.GetAgora(var_2_0)

	AgoraPreview = var_2_0

	return var_2_0.New(arg_2_0, var_2_1), var_2
end

return var_0_1
