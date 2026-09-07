local IslandSystemNpcBuilder = class("IslandSystemNpcBuilder", import(".IslandCharUnitBuilder"))

function IslandSystemNpcBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandSystemNpcUnit.New(arg_1_1, arg_1_2)
end

function IslandSystemNpcBuilder:AddComponents(arg_2_1, arg_2_2)
	IslandSystemNpcBuilder.super.AddComponents(self, arg_2_1, arg_2_2)

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

return IslandSystemNpcBuilder
