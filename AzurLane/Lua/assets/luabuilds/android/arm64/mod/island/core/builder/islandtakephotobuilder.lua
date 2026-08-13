class = var_0_10000

local var_0_0 = "IslandTakePhotoBuilder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandGenericBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2.id == 2 then
		IslandTakePhotoUnit = var_3

		return var_3.New(arg_1_1, arg_1_2)
	else
		IslandThirdTakePhotoUnit = var_3

		return var_3.New(arg_1_1, arg_1_2)
	end

	return
end

function var_0_1.SetTag(arg_2_0, arg_2_1)
	IslandConst = var_1_10002
	arg_2_1.tag = var_1_10002.TAG_NPC

	return
end

function var_0_1.AddComponents(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.GetComponent

	typeof = var_1_10006
	WorldObjectItem = var_1_10008
	var_3_1(var_3_0, var_1_10006(var_1_10008)).isPlayer = false
	GetOrAddComponent = var_4

	local var_3_2 = arg_3_1

	typeof = var_1_10007
	CharacterController = var_1_10009

	local var_3_3 = var_4(var_3_2, var_1_10007(var_1_10009))

	var_3_3.slopeLimit = 50
	var_3_3.stepOffset = 0.3
	var_3_3.stepOffset = 0.08
	var_3_3.minMoveDistance = 0

	if arg_3_2.id == 2 then
		var_3_3.height = 1.76
		var_3_3.stepOffset = 0.4
	else
		var_3_3.height = 0.1
		var_3_3.stepOffset = 0.01
	end

	Vector3 = var_5
	var_3_3.center = var_5(0, 0.96, 0)

	return
end

return var_0_1
