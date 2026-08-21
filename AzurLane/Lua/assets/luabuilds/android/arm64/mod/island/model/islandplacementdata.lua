local var_0_0 = class("IslandPlacementData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id

	local var_1_0 = arg_1_1.x or 0
	local var_1_1 = arg_1_1.y or 0

	arg_1_0.position = Vector2(var_1_0, var_1_1)
	arg_1_0.dir = arg_1_1.dir or 0

	return
end

function var_0_0.GetPosition(arg_2_0)
	return arg_2_0.position
end

function var_0_0.GetRotation(arg_3_0)
	return Vector3(0, arg_3_0.dir * 90, 0)
end

function var_0_0.IsSame(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return false
	end

	return arg_4_0.position.x == arg_4_1.position.x and arg_4_0.position.y == arg_4_1.position.y and arg_4_0.dir == arg_4_1.dir
end

return var_0_0
