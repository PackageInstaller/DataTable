rawget = var_0_10000
setmetatable = var_0_10001
Vector3 = var_0_10002

local var_0_0 = {
	direction = var_0_10002.zero,
	origin = var_0_10002.zero
}

tolua = var_4

local var_0_1 = var_4.initget(var_0_0)

function var_0_0.__index(arg_1_0, arg_1_1)
	if var_0_10000(var_0_0, arg_1_1) == nil and var_0_10000(var_0_1, arg_1_1) ~= nil then
		return var_2(arg_1_0)
	end

	return var_2
end

function var_0_0.__call(arg_2_0, arg_2_1, arg_2_2)
	return var_0_0.New(arg_2_1, arg_2_2)
end

function var_0_0.New(arg_3_0, arg_3_1)
	local var_3_0 = {
		direction = arg_3_0:Normalize(),
		origin = arg_3_1
	}

	var_0_10001(var_3_0, var_0_0)

	return var_3_0
end

function var_0_0.GetPoint(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.direction * arg_4_1

	var_2.Add(var_4_0, arg_4_0.origin)

	return var_2
end

function var_0_0.Get(arg_5_0)
	local var_5_0 = arg_5_0.origin
	local var_5_1 = arg_5_0.direction

	return var_5_0.x, var_5_0.y, var_5_0.z, var_5_1.x, var_5_1.y, var_5_1.z
end

function var_0_0.__tostring(arg_6_0)
	string = var_1_10001

	return var_1_10001.format("Origin:(%f,%f,%f),Dir:(%f,%f, %f)", arg_6_0.origin.x, arg_6_0.origin.y, arg_6_0.origin.z, arg_6_0.direction.x, arg_6_0.direction.y, arg_6_0.direction.z)
end

UnityEngine = var_5
var_5.Ray = var_0_0

var_0_10001(var_0_0, var_0_0)

return var_0_0
