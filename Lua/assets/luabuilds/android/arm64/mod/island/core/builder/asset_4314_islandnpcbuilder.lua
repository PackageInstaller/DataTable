local IslandNpcBuilder = class("IslandNpcBuilder", import(".IslandCharUnitBuilder"))

function IslandNpcBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandNpcUnit.New(arg_1_1, arg_1_2)
end

function IslandNpcBuilder:SetTag(arg_2_1)
	arg_2_1.tag = IslandConst.TAG_NPC

	return
end

function IslandNpcBuilder:AddComponents(arg_3_1, arg_3_2)
	IslandNpcBuilder.super.AddComponents(self, arg_3_1, arg_3_2)

	local var_3_0 = GetOrAddComponent(arg_3_1, typeof(CharacterController))

	var_3_0.slopeLimit = 50
	var_3_0.stepOffset = 0.3
	var_3_0.stepOffset = 0.08
	var_3_0.minMoveDistance = 0
	var_3_0.height = 1.76
	var_3_0.stepOffset = 0.4
	var_3_0.center = Vector3(0, 0.96, 0)

	if pg.island_unit_character[arg_3_2.modelId].CollisionParam ~= "" then
		var_3_0.center = Vector3(0, pg.island_unit_character[arg_3_2.modelId].CollisionParam[1], 0)
		var_3_0.radius = pg.island_unit_character[arg_3_2.modelId].CollisionParam[2]
		var_3_0.height = pg.island_unit_character[arg_3_2.modelId].CollisionParam[3]
	end

	GetOrAddComponent(arg_3_1, typeof(CharacterHandleController))

	return
end

return IslandNpcBuilder
