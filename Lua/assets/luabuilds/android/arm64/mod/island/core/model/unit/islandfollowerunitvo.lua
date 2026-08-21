local var_0_0 = class("IslandFollowerUnitVO", import(".IslandUnitVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.randomizer = defaultValue(arg_1_6, false)
	arg_1_0.shipId = arg_1_1

	var_0_0.super.Ctor(arg_1_0, {
		behaviourTree = "Island/NodeCanvas/Npc/FollowNpc",
		id = arg_1_2,
		name = "FollowNpc" .. arg_1_2,
		type = IslandConst.UNIT_TYPE_FOLLOWER,
		modelId = arg_1_3,
		position = {
			arg_1_4.x,
			arg_1_4.y,
			arg_1_4.z
		},
		rotation = {
			arg_1_5.x,
			arg_1_5.y,
			arg_1_5.z
		},
		scale = {
			1,
			1,
			1
		}
	})

	return
end

function var_0_0.IsSameShip(arg_2_0, arg_2_1)
	return arg_2_0.shipId == arg_2_1
end

function var_0_0.GetShipId(arg_3_0)
	return arg_3_0.shipId
end

function var_0_0.IsRandomizer(arg_4_0)
	return arg_4_0.randomizer
end

function var_0_0.ActiveRandomizer(arg_5_0)
	arg_5_0.randomizer = true

	return
end

return var_0_0
