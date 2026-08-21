local var_0_0 = class("IslandVirtualInteractUnitVO", import(".IslandInteractUnitVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.config = pg.island_interact_point[arg_1_0.modelId]
	arg_1_0.behaviourTree = arg_1_0.config.bt
	arg_1_0.slots = {}

	for iter_1_0 = 1, arg_1_0.config.slot_cnt do
		table.insert(arg_1_0.slots, InteractSlot.New(iter_1_0, arg_1_0.id))
	end

	arg_1_0:InitTimlineInfo()

	return
end

function var_0_0.GetAssetPath(arg_2_0)
	return nil
end

function var_0_0.GetPlayerParentPath(arg_3_0, arg_3_1)
	if arg_3_0.config.player_parent_path == "" or arg_3_1 > #arg_3_0.config.player_parent_path then
		return nil
	end

	return arg_3_0.config.player_parent_path[arg_3_1]
end

return var_0_0
