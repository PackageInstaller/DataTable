class = var_0_10000

local var_0_0 = "IslandFollowerUnitVO"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	defaultValue = var_1_10007
	arg_1_0.randomizer = var_1_10007(arg_1_6, false)
	arg_1_0.shipId = arg_1_1

	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = {
		behaviourTree = "Island/NodeCanvas/Npc/FollowNpc",
		id = arg_1_2,
		name = "FollowNpc" .. arg_1_2
	}

	IslandConst = var_10
	var_1_2.type = var_10.UNIT_TYPE_FOLLOWER
	var_1_2.modelId = arg_1_3
	var_1_2.position = {
		arg_1_4.x,
		arg_1_4.y,
		arg_1_4.z
	}
	var_1_2.rotation = {
		arg_1_5.x,
		arg_1_5.y,
		arg_1_5.z
	}
	var_1_2.scale = {
		1,
		1,
		1
	}

	var_1_0(var_1_1, var_1_2)

	return
end

function var_0_1.IsSameShip(arg_2_0, arg_2_1)
	return arg_2_0.shipId == arg_2_1
end

function var_0_1.GetShipId(arg_3_0)
	return arg_3_0.shipId
end

function var_0_1.IsRandomizer(arg_4_0)
	return arg_4_0.randomizer
end

function var_0_1.ActiveRandomizer(arg_5_0)
	arg_5_0.randomizer = true

	return
end

return var_0_1
