class = var_0_10000

local var_0_0 = "SharedIslandOtherCardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.View.page.card.IslandOtherCardPage"))

function var_0_1.AddSubLayers(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.getCurrentContext(var_1_0)
	local var_1_2 = var_3.getContextByMediator

	SharedIslandMediator = var_1_10007

	local var_1_3 = var_1_2(var_1_1, var_1_10007)

	pg = var_1_0

	local var_1_4 = var_1_0.m02
	local var_1_5 = var_5.sendNotification

	GAME = var_1_10008

	var_1_5(var_1_4, var_1_10008.LOAD_LAYERS, {
		parentContext = var_1_3,
		context = arg_1_1
	})

	return
end

return var_0_1
