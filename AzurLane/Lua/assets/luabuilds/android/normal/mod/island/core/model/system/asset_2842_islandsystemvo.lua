class = var_0_10000

local var_0_0 = var_0_10000("IslandSystemVO")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.name = arg_1_0.id
	arg_1_0.position = arg_1_0:GetPosition()
	arg_1_0.rotation = arg_1_0:GetRotation()

	return
end

function var_0_0.GetBehaviourTree(arg_2_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me!")

	return
end

function var_0_0.GetType(arg_3_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me!")

	return
end

function var_0_0.GetPosition(arg_4_0)
	Vector3 = var_1_10001

	return var_1_10001.zero
end

function var_0_0.GetRotation(arg_5_0)
	Vector3 = var_1_10001

	return var_1_10001.zero
end

return var_0_0
