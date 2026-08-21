local var_0_0 = {
	GetDistance = function(arg_1_0, arg_1_1)
		local var_1_0 = (arg_1_0.x - arg_1_1.x) * (arg_1_0.x - arg_1_1.x) + (arg_1_0.y - arg_1_1.y) * (arg_1_0.y - arg_1_1.y)

		return math.sqrt(var_1_0)
	end,
	GetMidpoint = function(arg_2_0, arg_2_1)
		return (arg_2_0 + arg_2_1) / 2
	end
}

function var_0_0.GetAngle(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0.GetDistance(arg_3_0, arg_3_1)

	if var_3_0 == 0 then
		return 0
	end

	if arg_3_0.x - arg_3_1.x < 0 then
		return math.asin((arg_3_0.y - arg_3_1.y) / var_3_0) / math.pi * -180
	else
		return math.asin((arg_3_0.y - arg_3_1.y) / var_3_0) / math.pi * 180 + 180
	end
end

return var_0_0
