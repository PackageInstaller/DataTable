class = var_0_10000

local var_0_0 = "IslandCheaterTavernPlayerBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCharUnitBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandCheaterTavernPlayerUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.SetTag(arg_2_0, arg_2_1)
	IslandConst = var_1_10002
	arg_2_1.tag = var_1_10002.TAG_NPC

	return
end

function var_0_1.AddComponents(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.AddComponents(arg_3_0, arg_3_1, arg_3_2)

	GetOrAddComponent = var_3

	local var_3_0 = arg_3_1

	typeof = var_5
	CharacterController = var_6

	local var_3_1 = var_3(var_3_0, var_5(var_6))

	var_3_1.slopeLimit = 50
	var_3_1.stepOffset = 0.3
	var_3_1.stepOffset = 0.08
	var_3_1.minMoveDistance = 0
	var_3_1.height = 1.76
	var_3_1.stepOffset = 0.4
	Vector3 = var_4
	var_3_1.center = var_4(0, 0.96, 0)
	pg = var_4

	if var_4.island_unit_character[arg_3_2.modelId].CollisionParam ~= "" then
		Vector3 = var_5
		var_3_1.center = var_5(0, var_4.CollisionParam[1], 0)
		var_3_1.radius = var_4.CollisionParam[2]
		var_3_1.height = var_4.CollisionParam[3]
	end

	GetOrAddComponent = var_5

	local var_3_2 = arg_3_1

	typeof = var_7
	CharacterHandleController = var_1_10008

	var_5(var_3_2, var_7(var_1_10008))

	return
end

return var_0_1
