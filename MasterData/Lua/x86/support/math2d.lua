local var_0_0 = {}
local var_0_1 = math.sqrt
local var_0_2 = math.atan2
local var_0_3 = math.cos
local var_0_4 = math.sin
local var_0_5 = math.pi / 180
local var_0_6 = 180 / math.pi

function var_0_0.dist(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	return var_0_1((arg_1_2 - arg_1_0) * (arg_1_2 - arg_1_0) + (arg_1_3 - arg_1_1) * (arg_1_3 - arg_1_1))
end

function var_0_0.radians4point(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	return var_0_2(arg_2_1 - arg_2_3, arg_2_2 - arg_2_0)
end

function var_0_0.pointAtCircle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return arg_3_0 + var_0_3(arg_3_2) * arg_3_3, arg_3_1 - var_0_4(arg_3_2) * arg_3_3
end

function var_0_0.pointAtLineToPoint(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	local var_4_0 = arg_4_5 - arg_4_3
	local var_4_1 = ((arg_4_0 - arg_4_2) * (arg_4_4 - arg_4_2) + (arg_4_1 - arg_4_3) * (arg_4_5 - arg_4_3)) / ((arg_4_4 - arg_4_2) * (arg_4_4 - arg_4_2) + var_4_0 * var_4_0)

	if ((arg_4_0 - arg_4_2) * (arg_4_4 - arg_4_2) + (arg_4_1 - arg_4_3) * (arg_4_5 - arg_4_3)) / ((arg_4_4 - arg_4_2) * (arg_4_4 - arg_4_2) + var_4_0 * var_4_0) > 1 then
		var_4_1 = 1
	elseif var_4_1 < 0 then
		var_4_1 = 0
	end

	return arg_4_2 + var_4_1 * (arg_4_4 - arg_4_2), arg_4_3 + var_4_1 * var_4_0
end

function var_0_0.degrees2radians(arg_5_0)
	return arg_5_0 * var_0_5
end

function var_0_0.radians2degrees(arg_6_0)
	return arg_6_0 * var_0_6
end

function var_0_0.rotateCoord(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = math.cos(arg_7_2)
	local var_7_1 = math.sin(arg_7_2)

	return var_7_0 * arg_7_0 + var_7_1 * arg_7_1, -1 * var_7_1 * arg_7_0 + var_7_0 * arg_7_1
end

function var_0_0.rotateZCoord(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = math.cos(arg_8_2)
	local var_8_1 = math.sin(arg_8_2)

	return var_8_0 * arg_8_0 - var_8_1 * arg_8_1, var_8_1 * arg_8_0 + var_8_0 * arg_8_1
end

function var_0_0.rotatePoint(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = math.cos(arg_9_4)
	local var_9_1 = math.sin(arg_9_4)

	return var_9_0 * (arg_9_0 - arg_9_2) + var_9_1 * (arg_9_1 - arg_9_3) + arg_9_2, var_9_1 + (arg_9_0 - arg_9_2) * -1 + var_9_0 * (arg_9_1 - arg_9_3) + arg_9_3
end

function var_0_0.twoCircleIntersect(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_3 = 0
	local var_10_4 = 0
	local var_10_5 = 0
	local var_10_6 = 0

	if not lk.FloatEqual(arg_10_1, arg_10_4) then
		local var_10_8 = arg_10_0 * arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) - arg_10_2 * arg_10_2

		if -2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))) * (-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) - 4 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))) * var_10_8 > 0 then
			var_10_3 = (-(-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) + var_0_1(-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))) * (-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) - 4 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))) * var_10_8)) / (2 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))))
			var_10_4 = (-(-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) - var_0_1(-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))) * (-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) - 4 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))) * var_10_8)) / (2 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))))
			var_10_5 = (arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * var_10_3
			var_10_6 = (arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * var_10_4
		elseif -2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))) * (-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) - 4 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))) * var_10_8 == 0 then
			var_10_3 = -(-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) / (2 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))))
			var_10_5 = (arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * (-(-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) / (2 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))))
			var_10_4 = -(-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) / (2 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4))))
			var_10_6 = (arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * (-(-2 * (arg_10_0 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_1 * arg_10_1 - arg_10_4 * arg_10_4 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_1 - arg_10_4)) - arg_10_1) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))) / (2 * (1 + (arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4) * ((arg_10_0 - arg_10_3) / (arg_10_1 - arg_10_4)))))
		else
			return {}
		end
	elseif not lk.FloatEqual(arg_10_0, arg_10_3) then
		var_10_3 = (arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_0 - arg_10_3))
		var_10_4 = (arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_0 - arg_10_3))

		local var_10_9 = arg_10_1 * arg_10_1 - arg_10_2 * arg_10_2 + ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_0 - arg_10_3)) - arg_10_0) * ((arg_10_0 * arg_10_0 - arg_10_3 * arg_10_3 + arg_10_5 * arg_10_5 - arg_10_2 * arg_10_2) / (2 * (arg_10_0 - arg_10_3)) - arg_10_0)

		if -2 * arg_10_1 * (-2 * arg_10_1) - 4 * 1 * var_10_9 > 0 then
			var_10_5 = (-(-2 * arg_10_1) + var_0_1(-2 * arg_10_1 * (-2 * arg_10_1) - 4 * 1 * var_10_9)) / (2 * 1)
			var_10_6 = (-(-2 * arg_10_1) - var_0_1(-2 * arg_10_1 * (-2 * arg_10_1) - 4 * 1 * var_10_9)) / (2 * 1)
		elseif -2 * arg_10_1 * (-2 * arg_10_1) - 4 * 1 * var_10_9 == 0 then
			var_10_5 = -(-2 * arg_10_1) / (2 * 1)
			var_10_6 = -(-2 * arg_10_1) / (2 * 1)
		else
			return {}
		end
	else
		return {}
	end

	return {
		{
			var_10_3,
			var_10_5
		},
		{
			var_10_4,
			var_10_6
		}
	}
end

function var_0_0.LineAndCircleIntersect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if (2 * arg_11_2 - 2 * arg_11_0 * (arg_11_1 - arg_11_3)) * (2 * arg_11_2 - 2 * arg_11_0 * (arg_11_1 - arg_11_3)) - 4 * (1 + arg_11_0 * arg_11_0) * (arg_11_2 * arg_11_2 + (arg_11_1 - arg_11_3) * (arg_11_1 - arg_11_3) - arg_11_4 * arg_11_4) < 0 then
		return {}
	end

	local var_11_4 = math.sqrt((2 * arg_11_2 - 2 * arg_11_0 * (arg_11_1 - arg_11_3)) * (2 * arg_11_2 - 2 * arg_11_0 * (arg_11_1 - arg_11_3)) - 4 * (1 + arg_11_0 * arg_11_0) * (arg_11_2 * arg_11_2 + (arg_11_1 - arg_11_3) * (arg_11_1 - arg_11_3) - arg_11_4 * arg_11_4))

	return {
		{
			(2 * arg_11_2 - 2 * arg_11_0 * (arg_11_1 - arg_11_3) + var_11_4) / (2 * (1 + arg_11_0 * arg_11_0)),
			arg_11_0 * ((2 * arg_11_2 - 2 * arg_11_0 * (arg_11_1 - arg_11_3) + var_11_4) / (2 * (1 + arg_11_0 * arg_11_0))) + arg_11_1
		},
		{
			(2 * arg_11_2 - 2 * arg_11_0 * (arg_11_1 - arg_11_3) - var_11_4) / (2 * (1 + arg_11_0 * arg_11_0)),
			arg_11_0 * ((2 * arg_11_2 - 2 * arg_11_0 * (arg_11_1 - arg_11_3) - var_11_4) / (2 * (1 + arg_11_0 * arg_11_0))) + arg_11_1
		}
	}
end

function var_0_0.point2lineDist(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	return math.abs((arg_12_2 * arg_12_0 - arg_12_1 + arg_12_3) / math.sqrt(arg_12_2 * 2 + 1))
end

return var_0_0
