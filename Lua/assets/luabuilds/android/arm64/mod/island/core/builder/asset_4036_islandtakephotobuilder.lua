local IslandTakePhotoBuilder = class("IslandTakePhotoBuilder", import(".IslandGenericBuilder"))

function IslandTakePhotoBuilder:GetModule(arg_1_1, arg_1_2)
	if arg_1_2.id == 2 then
		return IslandTakePhotoUnit.New(arg_1_1, arg_1_2)
	else
		return IslandThirdTakePhotoUnit.New(arg_1_1, arg_1_2)
	end

	return
end

function IslandTakePhotoBuilder:SetTag(arg_2_1)
	arg_2_1.tag = IslandConst.TAG_NPC

	return
end

function IslandTakePhotoBuilder:AddComponents(arg_3_1, arg_3_2)
	arg_3_1:GetComponent(typeof(WorldObjectItem)).isPlayer = false

	local var_3_0 = GetOrAddComponent(arg_3_1, typeof(CharacterController))

	var_3_0.slopeLimit = 50
	var_3_0.stepOffset = 0.3
	var_3_0.stepOffset = 0.08
	var_3_0.minMoveDistance = 0

	if arg_3_2.id == 2 then
		var_3_0.height = 1.76
		var_3_0.stepOffset = 0.4
	else
		var_3_0.height = 0.1
		var_3_0.stepOffset = 0.01
	end

	var_3_0.center = Vector3(0, 0.96, 0)

	return
end

return IslandTakePhotoBuilder
