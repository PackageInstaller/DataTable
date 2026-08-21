local var_0_0 = class("IslandSeekGameSystemVO", import(".IslandSystemVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.miniGameID = arg_1_1
	arg_1_0.miniGameConfig = pg.island_minigame_template[arg_1_0.miniGameID]

	return
end

function var_0_0.GetBehaviourTree(arg_2_0)
	return arg_2_0.miniGameConfig.bt
end

function var_0_0.GetResultUIName(arg_3_0)
	return arg_3_0.miniGameConfig.result_ui
end

function var_0_0.GetInteractiveObjects(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.miniGameConfig.interactive_objects) do
		table.insert({}, iter_4_1)
	end

	return {}
end

function var_0_0.GetType(arg_5_0)
	return IslandConst.SYSTEM_TYPE_SEEKGAME
end

return var_0_0
