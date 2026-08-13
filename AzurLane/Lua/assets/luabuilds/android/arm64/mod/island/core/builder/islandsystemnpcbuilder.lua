class = var_0_10000

local var_0_0 = "IslandSystemNpcBuilder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCharUnitBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandSystemNpcUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.AddComponents(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.AddComponents(arg_2_0, arg_2_1, arg_2_2)

	GetOrAddComponent = var_3

	local var_2_0 = arg_2_1

	typeof = var_6
	CharacterController = var_1_10008

	local var_2_1 = var_3(var_2_0, var_6(var_1_10008))

	var_2_1.slopeLimit = 50
	var_2_1.stepOffset = 0.3
	var_2_1.stepOffset = 0.08
	var_2_1.minMoveDistance = 0
	var_2_1.height = 1.76
	var_2_1.stepOffset = 0.4
	Vector3 = var_4
	var_2_1.center = var_4(0, 0.96, 0)
	GetOrAddComponent = var_4

	local var_2_2 = arg_2_1

	typeof = var_7
	CharacterHandleController = var_1_10009

	var_4(var_2_2, var_7(var_1_10009))

	return
end

return var_0_1
