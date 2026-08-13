rawget = var_0_10000
setmetatable = var_0_10001

local var_0_0 = {
	ALL = 31,
	Collider = 1,
	Point = 4,
	Transform = 16,
	Rigidbody = 8,
	Normal = 2
}

RaycastBits = RaycastBits

local var_0_1 = {}

tolua = var_0_10004

local var_0_2 = var_0_10004.initget(var_0_1)

function var_0_1.__index(arg_1_0, arg_1_1)
	if var_0_10000(var_0_1, arg_1_1) == nil and var_0_10000(var_0_2, arg_1_1) ~= nil then
		return var_2(arg_1_0)
	end

	return var_2
end

function var_0_1.New(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = {
		collider = arg_2_0,
		distance = arg_2_1,
		normal = arg_2_2,
		point = arg_2_3,
		rigidbody = arg_2_4,
		transform = arg_2_5
	}

	var_0_10001(var_2_0, var_0_1)

	return var_2_0
end

function var_0_1.Init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	arg_3_0.collider = arg_3_1
	arg_3_0.distance = arg_3_2
	arg_3_0.normal = arg_3_3
	arg_3_0.point = arg_3_4
	arg_3_0.rigidbody = arg_3_5
	arg_3_0.transform = arg_3_6

	return
end

function var_0_1.Get(arg_4_0)
	return arg_4_0.collider, arg_4_0.distance, arg_4_0.normal, arg_4_0.point, arg_4_0.rigidbody, arg_4_0.transform
end

function var_0_1.Destroy(arg_5_0)
	arg_5_0.collider = nil
	arg_5_0.rigidbody = nil
	arg_5_0.transform = nil

	return
end

function var_0_1.GetMask(...)
	local var_6_0 = {
		...
	}
	local var_6_1 = 0

	for iter_6_0 = 1, #var_6_0 do
		local var_6_2

		if not var_0[var_6_0[iter_6_0]] then
			var_6_2 = 0
		end

		if var_6_2 ~= 0 then
			var_6_1 = var_6_1 + var_6_2
		end
	end

	if var_6_1 == 0 then
		var_6_1 = var_0.all
	end

	return var_6_1
end

UnityEngine = var_5
var_5.RaycastHit = var_0_1

var_0_10001(var_0_1, var_0_1)

return var_0_1
