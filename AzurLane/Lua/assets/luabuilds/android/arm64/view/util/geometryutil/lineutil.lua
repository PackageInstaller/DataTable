local var_0_0 = {}
local var_0_1 = import(".SegmentUtil")

var_0_0.GetVerticalCrossPoint, var_0_0.TwoPointToCommon = function(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0(arg_2_0, arg_2_1)
	local var_2_1 = (var_2_0.b * (var_2_0.b * arg_2_2.x - var_2_0.a * arg_2_2.y) - var_2_0.a * var_2_0.c) / (var_2_0.a * var_2_0.a + var_2_0.b * var_2_0.b)
	local var_2_2 = var_0_1.IsZero(var_2_0.b) and (var_2_0.x * var_2_1 + var_2_0.c) / -var_2_0.b or arg_2_0.y

	return Vector2(var_2_1, var_2_2)
end, function(arg_1_0, arg_1_1)
	return {
		a = -(arg_1_1 - arg_1_0).y,
		b = (arg_1_1 - arg_1_0).x,
		c = arg_1_0.x * (arg_1_1 - arg_1_0).y - arg_1_0.y * (arg_1_1 - arg_1_0).x
	}
end

return {}
