class = var_0_10000

local var_0_0 = "IslandSeekGameSystemVO"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSystemVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.miniGameID = arg_1_1
	pg = var_3
	arg_1_0.miniGameConfig = var_3.island_minigame_template[arg_1_0.miniGameID]

	return
end

function var_0_1.GetBehaviourTree(arg_2_0)
	return arg_2_0.miniGameConfig.bt
end

function var_0_1.GetResultUIName(arg_3_0)
	return arg_3_0.miniGameConfig.result_ui
end

function var_0_1.GetInteractiveObjects(arg_4_0)
	local var_4_0 = {}

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.miniGameConfig.interactive_objects) do
		table = var_1_10007

		var_1_10007.insert(var_4_0, iter_4_1)
	end

	return var_4_0
end

function var_0_1.GetType(arg_5_0)
	IslandConst = var_1_10001

	return var_1_10001.SYSTEM_TYPE_SEEKGAME
end

return var_0_1
