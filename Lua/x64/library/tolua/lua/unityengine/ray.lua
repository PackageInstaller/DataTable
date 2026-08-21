local var_0_0 = rawget
local var_0_1 = setmetatable
local var_0_2 = Vector3
local var_0_3 = {
	direction = var_0_2.zero,
	origin = var_0_2.zero
}
local var_0_4 = tolua.initget(var_0_3)

function var_0_3.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0(var_0_3, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_0(var_0_4, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_3.__call(arg_2_0, arg_2_1, arg_2_2)
	return var_0_3.New(arg_2_1, arg_2_2)
end

function var_0_3.New(arg_3_0, arg_3_1)
	local var_3_0 = {
		direction = arg_3_0:Normalize(),
		origin = arg_3_1
	}

	var_0_1(var_3_0, var_0_3)

	return var_3_0
end

function var_0_3.GetPoint(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.direction * arg_4_1

	var_4_0:Add(arg_4_0.origin)

	return var_4_0
end

function var_0_3.Get(arg_5_0)
	local var_5_0 = arg_5_0.origin
	local var_5_1 = arg_5_0.direction

	return var_5_0.x, var_5_0.y, var_5_0.z, var_5_1.x, var_5_1.y, var_5_1.z
end

function var_0_3.__tostring(arg_6_0)
	return string.format("Origin:(%f,%f,%f),Dir:(%f,%f, %f)", arg_6_0.origin.x, arg_6_0.origin.y, arg_6_0.origin.z, arg_6_0.direction.x, arg_6_0.direction.y, arg_6_0.direction.z)
end

UnityEngine.Ray = var_0_3

var_0_1(var_0_3, var_0_3)

return var_0_3
