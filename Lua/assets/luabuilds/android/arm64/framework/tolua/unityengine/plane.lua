local var_0_0 = setmetatable
local var_0_1 = Mathf
local var_0_2 = Vector3
local var_0_3 = {}

;({}).__index = function(arg_1_0, arg_1_1)
	return rawget(var_0_3, arg_1_1)
end
;({}).__call = function(arg_2_0, arg_2_1)
	return var_0_3.New(arg_2_1)
end
;({}).New = function(arg_3_0, arg_3_1)
	return var_0_0({
		normal = arg_3_0:Normalize(),
		distance = arg_3_1
	}, var_0_3)
end
;({}).Get = function(arg_4_0)
	return arg_4_0.normal, arg_4_0.distance
end
;({}).Raycast = function(arg_5_0, arg_5_1)
	local var_5_0 = var_0_2.Dot(arg_5_1.direction, arg_5_0.normal)
	local var_5_1 = -var_0_2.Dot(arg_5_1.origin, arg_5_0.normal) - arg_5_0.distance
	local var_5_2

	if var_0_1.Approximately(var_5_0, 0) then
		do return false, 0 end

		var_5_2 = var_5_1 / var_5_0 > 0
	end

	return var_5_2, var_5_1 / var_5_0
end
;({}).SetNormalAndPosition = function(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.normal = arg_6_1:Normalize()
	arg_6_0.distance = -var_0_2.Dot(arg_6_1, arg_6_2)

	return
end
;({}).Set3Points = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.normal = var_0_2.Normalize(var_0_2.Cross(arg_7_2 - arg_7_1, arg_7_3 - arg_7_1))
	arg_7_0.distance = -var_0_2.Dot(arg_7_0.normal, arg_7_1)

	return
end
;({}).GetDistanceToPoint = function(arg_8_0, arg_8_1)
	return var_0_2.Dot(arg_8_0.normal, arg_8_1) + arg_8_0.distance
end
;({}).GetSide = function(arg_9_0, arg_9_1)
	return var_0_2.Dot(arg_9_0.normal, arg_9_1) + arg_9_0.distance > 0
end
;({}).SameSide = function(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:GetDistanceToPoint(arg_10_1)
	local var_10_1 = arg_10_0:GetDistanceToPoint(arg_10_2)

	return var_10_0 > 0 and var_10_1 > 0 or var_10_0 <= 0 and var_10_1 <= 0
end
UnityEngine.Plane = {}

setmetatable({}, {})

return {}
