local var_0_0 = rawget
local var_0_1 = setmetatable

RaycastBits = {
	ALL = 31,
	Collider = 1,
	Point = 4,
	Transform = 16,
	Rigidbody = 8,
	Normal = 2
}

local var_0_2 = RaycastBits
local var_0_3 = {}
local var_0_4 = tolua.initget({})

;({}).__index = function(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0(var_0_3, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_0(var_0_4, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end
;({}).New = function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	var_0_1({
		collider = arg_2_0,
		distance = arg_2_1,
		normal = arg_2_2,
		point = arg_2_3,
		rigidbody = arg_2_4,
		transform = arg_2_5
	}, var_0_3)

	return {
		collider = arg_2_0,
		distance = arg_2_1,
		normal = arg_2_2,
		point = arg_2_3,
		rigidbody = arg_2_4,
		transform = arg_2_5
	}
end
;({}).Init = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	arg_3_0.collider = arg_3_1
	arg_3_0.distance = arg_3_2
	arg_3_0.normal = arg_3_3
	arg_3_0.point = arg_3_4
	arg_3_0.rigidbody = arg_3_5
	arg_3_0.transform = arg_3_6

	return
end
;({}).Get = function(arg_4_0)
	return arg_4_0.collider, arg_4_0.distance, arg_4_0.normal, arg_4_0.point, arg_4_0.rigidbody, arg_4_0.transform
end
;({}).Destroy = function(arg_5_0)
	arg_5_0.collider = nil
	arg_5_0.rigidbody = nil
	arg_5_0.transform = nil

	return
end
;({}).GetMask = function(...)
	local var_6_0 = {
		...
	}
	local var_6_1 = 0

	for iter_6_0 = 1, #var_6_0 do
		local var_6_2 = var_0_2[var_6_0[iter_6_0]] or 0

		if var_6_2 ~= 0 then
			var_6_1 = var_6_1 + var_6_2
		end
	end

	if var_6_1 == 0 then
		var_6_1 = var_0_2.all
	end

	return var_6_1
end
UnityEngine.RaycastHit = {}

setmetatable({}, {})

return {}
