class = var_0_10000

local var_0_0 = "IslandVirtualInteractUnitVO"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandInteractUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.super.Ctor(arg_1_0, arg_1_1)

	pg = var_2
	arg_1_0.config = var_2.island_interact_point[arg_1_0.modelId]
	arg_1_0.behaviourTree = arg_1_0.config.bt
	arg_1_0.slots = {}

	for iter_1_0 = 1, arg_1_0.config.slot_cnt do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_1_0 = arg_1_0.slots

		InteractSlot = var_1_10008

		var_1_10006(var_1_0, var_1_10008.New(iter_1_0, arg_1_0.id))
	end

	arg_1_0:InitTimlineInfo()

	return
end

function var_0_1.GetAssetPath(arg_2_0)
	return nil
end

function var_0_1.GetPlayerParentPath(arg_3_0, arg_3_1)
	if arg_3_0.config.player_parent_path == "" or arg_3_1 > #arg_3_0.config.player_parent_path then
		return nil
	end

	return arg_3_0.config.player_parent_path[arg_3_1]
end

return var_0_1
