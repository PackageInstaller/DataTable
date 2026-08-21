local var_0_0 = class("IslandSystemVO")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.name = arg_1_0.id
	arg_1_0.position = arg_1_0:GetPosition()
	arg_1_0.rotation = arg_1_0:GetRotation()

	return
end

function var_0_0.GetBehaviourTree(arg_2_0)
	assert(false, "overwrite me!")

	return
end

function var_0_0.GetType(arg_3_0)
	assert(false, "overwrite me!")

	return
end

function var_0_0.GetPosition(arg_4_0)
	return Vector3.zero
end

function var_0_0.GetRotation(arg_5_0)
	return Vector3.zero
end

return var_0_0
