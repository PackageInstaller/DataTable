local var_0_0 = class("IslandSystemNpcBuilder", import(".IslandCharUnitBuilder"))

function var_0_0.GetModule(arg_1_0, arg_1_1, arg_1_2)
	return IslandSystemNpcUnit.New(arg_1_1, arg_1_2)
end

function var_0_0.AddComponents(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.AddComponents(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = GetOrAddComponent(arg_2_1, typeof(CharacterController))

	var_2_0.slopeLimit = 50
	var_2_0.stepOffset = 0.3
	var_2_0.stepOffset = 0.08
	var_2_0.minMoveDistance = 0
	var_2_0.height = 1.76
	var_2_0.stepOffset = 0.4
	var_2_0.center = Vector3(0, 0.96, 0)

	GetOrAddComponent(arg_2_1, typeof(CharacterHandleController))

	return
end

return var_0_0
