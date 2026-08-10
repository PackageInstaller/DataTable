local var_0_0 = math.sqrt
local var_0_1 = setmetatable
local var_0_2 = rawget
local var_0_3 = math
local var_0_4 = var_0_3.acos
local var_0_5 = var_0_3.max
local var_0_6 = {}
local var_0_7 = tolua.initget(var_0_6)

function var_0_6.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_2(var_0_6, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_2(var_0_7, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_6.__call(arg_2_0, arg_2_1, arg_2_2)
	return var_0_1({
		x = arg_2_1 or 0,
		y = arg_2_2 or 0
	}, var_0_6)
end

function var_0_6.New(arg_3_0, arg_3_1)
	return var_0_1({
		x = arg_3_0 or 0,
		y = arg_3_1 or 0
	}, var_0_6)
end

function var_0_6.Set(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.x = arg_4_1 or 0
	arg_4_0.y = arg_4_2 or 0
end

function var_0_6.Get(arg_5_0)
	return arg_5_0.x, arg_5_0.y
end

function var_0_6.SqrMagnitude(arg_6_0)
	return arg_6_0.x * arg_6_0.x + arg_6_0.y * arg_6_0.y
end

function var_0_6.Clone(arg_7_0)
	return var_0_1({
		x = arg_7_0.x,
		y = arg_7_0.y
	}, var_0_6)
end

function var_0_6.Normalize(arg_8_0)
	local var_8_0 = arg_8_0.x
	local var_8_1 = arg_8_0.y
	local var_8_2 = var_0_0(var_8_0 * var_8_0 + var_8_1 * var_8_1)

	if var_8_2 > 1e-05 then
		var_8_0 = var_8_0 / var_8_2
		var_8_1 = var_8_1 / var_8_2
	else
		var_8_0 = 0
		var_8_1 = 0
	end

	return var_0_1({
		x = var_8_0,
		y = var_8_1
	}, var_0_6)
end

function var_0_6.SetNormalize(arg_9_0)
	local var_9_0 = var_0_0(arg_9_0.x * arg_9_0.x + arg_9_0.y * arg_9_0.y)

	if var_9_0 > 1e-05 then
		arg_9_0.x = arg_9_0.x / var_9_0
		arg_9_0.y = arg_9_0.y / var_9_0
	else
		arg_9_0.x = 0
		arg_9_0.y = 0
	end

	return arg_9_0
end

function var_0_6.Dot(arg_10_0, arg_10_1)
	return arg_10_0.x * arg_10_1.x + arg_10_0.y * arg_10_1.y
end

function var_0_6.Angle(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.x
	local var_11_1 = arg_11_0.y
	local var_11_2 = var_0_0(var_11_0 * var_11_0 + var_11_1 * var_11_1)

	if var_11_2 > 1e-05 then
		var_11_0 = var_11_0 / var_11_2
		var_11_1 = var_11_1 / var_11_2
	else
		var_11_0, var_11_1 = 0, 0
	end

	local var_11_3 = arg_11_1.x
	local var_11_4 = arg_11_1.y
	local var_11_5 = var_0_0(var_11_3 * var_11_3 + var_11_4 * var_11_4)

	if var_11_5 > 1e-05 then
		var_11_3 = var_11_3 / var_11_5
		var_11_4 = var_11_4 / var_11_5
	else
		var_11_3, var_11_4 = 0, 0
	end

	local var_11_6 = var_11_0 * var_11_3 + var_11_1 * var_11_4

	if var_11_6 < -1 then
		var_11_6 = -1
	elseif var_11_6 > 1 then
		var_11_6 = 1
	end

	return var_0_4(var_11_6) * 57.29578
end

function var_0_6.Magnitude(arg_12_0)
	return var_0_0(arg_12_0.x * arg_12_0.x + arg_12_0.y * arg_12_0.y)
end

function var_0_6.Reflect(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.x
	local var_13_1 = arg_13_0.y
	local var_13_2 = arg_13_1.x
	local var_13_3 = arg_13_1.y
	local var_13_4 = -2 * (var_13_0 * var_13_2 + var_13_1 * var_13_3)

	return var_0_1({
		x = var_13_4 * var_13_2 + var_13_0,
		y = var_13_4 * var_13_3 + var_13_1
	}, var_0_6)
end

function var_0_6.Distance(arg_14_0, arg_14_1)
	return var_0_0((arg_14_0.x - arg_14_1.x)^2 + (arg_14_0.y - arg_14_1.y)^2)
end

function var_0_6.Lerp(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 < 0 then
		arg_15_2 = 0
	elseif arg_15_2 > 1 then
		arg_15_2 = 1
	end

	return var_0_1({
		x = arg_15_0.x + (arg_15_1.x - arg_15_0.x) * arg_15_2,
		y = arg_15_0.y + (arg_15_1.y - arg_15_0.y) * arg_15_2
	}, var_0_6)
end

function var_0_6.LerpUnclamped(arg_16_0, arg_16_1, arg_16_2)
	return var_0_1({
		x = arg_16_0.x + (arg_16_1.x - arg_16_0.x) * arg_16_2,
		y = arg_16_0.y + (arg_16_1.y - arg_16_0.y) * arg_16_2
	}, var_0_6)
end

function var_0_6.MoveTowards(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.x
	local var_17_1 = arg_17_0.y
	local var_17_2 = arg_17_1.x - var_17_0
	local var_17_3 = arg_17_1.y - var_17_1
	local var_17_4 = var_17_2 * var_17_2 + var_17_3 * var_17_3

	if var_17_4 > arg_17_2 * arg_17_2 and var_17_4 ~= 0 then
		local var_17_5 = arg_17_2 / var_0_0(var_17_4)

		return var_0_1({
			x = var_17_0 + var_17_2 * var_17_5,
			y = var_17_1 + var_17_3 * var_17_5
		}, var_0_6)
	end

	return var_0_1({
		x = arg_17_1.x,
		y = arg_17_1.y
	}, var_0_6)
end

function var_0_6.ClampMagnitude(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.x
	local var_18_1 = arg_18_0.y
	local var_18_2 = var_18_0 * var_18_0 + var_18_1 * var_18_1

	if var_18_2 > arg_18_1 * arg_18_1 then
		local var_18_3 = arg_18_1 / var_0_0(var_18_2)

		var_18_0 = var_18_0 * var_18_3
		var_18_1 = var_18_1 * var_18_3

		return var_0_1({
			x = var_18_0,
			y = var_18_1
		}, var_0_6)
	end

	return var_0_1({
		x = var_18_0,
		y = var_18_1
	}, var_0_6)
end

function var_0_6.SmoothDamp(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	arg_19_5 = arg_19_5 or Time.deltaTime
	arg_19_4 = arg_19_4 or var_0_3.huge
	arg_19_3 = var_0_3.max(0.0001, arg_19_3)

	local var_19_0 = 2 / arg_19_3
	local var_19_1 = var_19_0 * arg_19_5
	local var_19_2 = 1 / (1 + var_19_1 + 0.48 * var_19_1 * var_19_1 + 0.235 * var_19_1 * var_19_1 * var_19_1)
	local var_19_3 = arg_19_1.x
	local var_19_4 = arg_19_1.y
	local var_19_5 = arg_19_0.x
	local var_19_6 = arg_19_0.y
	local var_19_7 = var_19_5 - var_19_3
	local var_19_8 = var_19_6 - var_19_4
	local var_19_9 = var_19_7 * var_19_7 + var_19_8 * var_19_8
	local var_19_10 = arg_19_4 * arg_19_3

	if var_19_9 > var_19_10 * var_19_10 then
		local var_19_11 = var_19_10 / var_0_0(var_19_9)

		var_19_7 = var_19_7 * var_19_11
		var_19_8 = var_19_8 * var_19_11
	end

	local var_19_12 = arg_19_2.x
	local var_19_13 = arg_19_2.y
	local var_19_14 = (var_19_12 + var_19_0 * var_19_7) * arg_19_5
	local var_19_15 = (var_19_13 + var_19_0 * var_19_8) * arg_19_5

	arg_19_2.x = (var_19_12 - var_19_0 * var_19_14) * var_19_2
	arg_19_2.y = (var_19_13 - var_19_0 * var_19_15) * var_19_2

	local var_19_16 = var_19_5 - var_19_7 + (var_19_7 + var_19_14) * var_19_2
	local var_19_17 = var_19_6 - var_19_8 + (var_19_8 + var_19_15) * var_19_2

	if (var_19_3 - var_19_5) * (var_19_16 - var_19_3) + (var_19_4 - var_19_6) * (var_19_17 - var_19_4) > 0 then
		var_19_16 = var_19_3
		var_19_17 = var_19_4
		arg_19_2.x = 0
		arg_19_2.y = 0
	end

	return var_0_1({
		x = var_19_16,
		y = var_19_17
	}, var_0_6), arg_19_2
end

function var_0_6.Max(arg_20_0, arg_20_1)
	return var_0_1({
		x = var_0_3.max(arg_20_0.x, arg_20_1.x),
		y = var_0_3.max(arg_20_0.y, arg_20_1.y)
	}, var_0_6)
end

function var_0_6.Min(arg_21_0, arg_21_1)
	return var_0_1({
		x = var_0_3.min(arg_21_0.x, arg_21_1.x),
		y = var_0_3.min(arg_21_0.y, arg_21_1.y)
	}, var_0_6)
end

function var_0_6.Scale(arg_22_0, arg_22_1)
	return var_0_1({
		x = arg_22_0.x * arg_22_1.x,
		y = arg_22_0.y * arg_22_1.y
	}, var_0_6)
end

function var_0_6.Div(arg_23_0, arg_23_1)
	arg_23_0.x = arg_23_0.x / arg_23_1
	arg_23_0.y = arg_23_0.y / arg_23_1

	return arg_23_0
end

function var_0_6.Mul(arg_24_0, arg_24_1)
	arg_24_0.x = arg_24_0.x * arg_24_1
	arg_24_0.y = arg_24_0.y * arg_24_1

	return arg_24_0
end

function var_0_6.Add(arg_25_0, arg_25_1)
	arg_25_0.x = arg_25_0.x + arg_25_1.x
	arg_25_0.y = arg_25_0.y + arg_25_1.y

	return arg_25_0
end

function var_0_6.Sub(arg_26_0, arg_26_1)
	arg_26_0.x = arg_26_0.x - arg_26_1.x
	arg_26_0.y = arg_26_0.y - arg_26_1.y
end

function var_0_6.__tostring(arg_27_0)
	return string.format("(%f,%f)", arg_27_0.x, arg_27_0.y)
end

function var_0_6.__div(arg_28_0, arg_28_1)
	return var_0_1({
		x = arg_28_0.x / arg_28_1,
		y = arg_28_0.y / arg_28_1
	}, var_0_6)
end

function var_0_6.__mul(arg_29_0, arg_29_1)
	if type(arg_29_1) == "number" then
		return var_0_1({
			x = arg_29_0.x * arg_29_1,
			y = arg_29_0.y * arg_29_1
		}, var_0_6)
	else
		return var_0_1({
			x = arg_29_0 * arg_29_1.x,
			y = arg_29_0 * arg_29_1.y
		}, var_0_6)
	end
end

function var_0_6.__add(arg_30_0, arg_30_1)
	return var_0_1({
		x = arg_30_0.x + arg_30_1.x,
		y = arg_30_0.y + arg_30_1.y
	}, var_0_6)
end

function var_0_6.__sub(arg_31_0, arg_31_1)
	return var_0_1({
		x = arg_31_0.x - arg_31_1.x,
		y = arg_31_0.y - arg_31_1.y
	}, var_0_6)
end

function var_0_6.__unm(arg_32_0)
	return var_0_1({
		x = -arg_32_0.x,
		y = -arg_32_0.y
	}, var_0_6)
end

function var_0_6.__eq(arg_33_0, arg_33_1)
	return (arg_33_0.x - arg_33_1.x)^2 + (arg_33_0.y - arg_33_1.y)^2 < 9.999999e-11
end

function var_0_7.up()
	return var_0_1({
		x = 0,
		y = 1
	}, var_0_6)
end

function var_0_7.down()
	return var_0_1({
		x = 0,
		y = -1
	}, var_0_6)
end

function var_0_7.right()
	return var_0_1({
		x = 1,
		y = 0
	}, var_0_6)
end

function var_0_7.left()
	return var_0_1({
		x = -1,
		y = 0
	}, var_0_6)
end

function var_0_7.zero()
	return var_0_1({
		x = 0,
		y = 0
	}, var_0_6)
end

function var_0_7.one()
	return var_0_1({
		x = 1,
		y = 1
	}, var_0_6)
end

var_0_7.magnitude = var_0_6.Magnitude
var_0_7.normalized = var_0_6.Normalize
var_0_7.sqrMagnitude = var_0_6.SqrMagnitude
UnityEngine.Vector2 = var_0_6

var_0_1(var_0_6, var_0_6)

return var_0_6
