local var_0_0 = math
local var_0_1 = var_0_0.floor
local var_0_2 = var_0_0.abs
local var_0_3 = Mathf

var_0_3.Deg2Rad = var_0_0.rad(1)
var_0_3.Epsilon = 1.4013e-45
var_0_3.Infinity = var_0_0.huge
var_0_3.NegativeInfinity = -var_0_0.huge
var_0_3.PI = var_0_0.pi
var_0_3.Rad2Deg = var_0_0.deg(1)
var_0_3.Abs = var_0_0.abs
var_0_3.Acos = var_0_0.acos
var_0_3.Asin = var_0_0.asin
var_0_3.Atan = var_0_0.atan
var_0_3.Atan2 = var_0_0.atan2
var_0_3.Ceil = var_0_0.ceil
var_0_3.Cos = var_0_0.cos
var_0_3.Exp = var_0_0.exp
var_0_3.Floor = var_0_0.floor
var_0_3.Log = var_0_0.log
var_0_3.Log10 = var_0_0.log10
var_0_3.Max = var_0_0.max
var_0_3.Min = var_0_0.min
var_0_3.Pow = var_0_0.pow
var_0_3.Sin = var_0_0.sin
var_0_3.Sqrt = var_0_0.sqrt
var_0_3.Tan = var_0_0.tan
var_0_3.Deg = var_0_0.deg
var_0_3.Rad = var_0_0.rad
var_0_3.Random = var_0_0.random

function var_0_3.Approximately(arg_1_0, arg_1_1)
	return var_0_2(arg_1_1 - arg_1_0) < var_0_0.max(1e-06 * var_0_0.max(var_0_2(arg_1_0), var_0_2(arg_1_1)), 1.121039e-44)
end

function var_0_3.Clamp(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0 < arg_2_1 then
		arg_2_0 = arg_2_1
	elseif arg_2_2 < arg_2_0 then
		arg_2_0 = arg_2_2
	end

	return arg_2_0
end

function var_0_3.Clamp01(arg_3_0)
	if arg_3_0 < 0 then
		return 0
	elseif arg_3_0 > 1 then
		return 1
	end

	return arg_3_0
end

function var_0_3.DeltaAngle(arg_4_0, arg_4_1)
	local var_4_0 = var_0_3.Repeat(arg_4_1 - arg_4_0, 360)

	if var_4_0 > 180 then
		var_4_0 = var_4_0 - 360
	end

	return var_4_0
end

function var_0_3.Gamma(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = false

	if arg_5_0 < 0 then
		var_5_0 = true
	end

	local var_5_1 = var_0_2(arg_5_0)

	if arg_5_1 < var_5_1 then
		return not var_5_0 and var_5_1 or -var_5_1
	end

	local var_5_2 = var_0_0.pow(var_5_1 / arg_5_1, arg_5_2) * arg_5_1

	return not var_5_0 and var_5_2 or -var_5_2
end

function var_0_3.InverseLerp(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0 < arg_6_1 then
		if arg_6_2 < arg_6_0 then
			return 0
		end

		if arg_6_1 < arg_6_2 then
			return 1
		end

		arg_6_2 = arg_6_2 - arg_6_0
		arg_6_2 = arg_6_2 / (arg_6_1 - arg_6_0)

		return arg_6_2
	end

	if arg_6_0 <= arg_6_1 then
		return 0
	end

	if arg_6_2 < arg_6_1 then
		return 1
	end

	if arg_6_0 < arg_6_2 then
		return 0
	end

	return 1 - (arg_6_2 - arg_6_1) / (arg_6_0 - arg_6_1)
end

function var_0_3.Lerp(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0 + (arg_7_1 - arg_7_0) * var_0_3.Clamp01(arg_7_2)
end

function var_0_3.LerpAngle(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_3.Repeat(arg_8_1 - arg_8_0, 360)

	if var_8_0 > 180 then
		var_8_0 = var_8_0 - 360
	end

	return arg_8_0 + var_8_0 * var_0_3.Clamp01(arg_8_2)
end

function var_0_3.LerpUnclamped(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0 + (arg_9_1 - arg_9_0) * arg_9_2
end

function var_0_3.MoveTowards(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 >= var_0_2(arg_10_1 - arg_10_0) then
		return arg_10_1
	end

	return arg_10_0 + var_0_3.Sign(arg_10_1 - arg_10_0) * arg_10_2
end

function var_0_3.MoveTowardsAngle(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1 = arg_11_0 + var_0_3.DeltaAngle(arg_11_0, arg_11_1)

	return var_0_3.MoveTowards(arg_11_0, arg_11_1, arg_11_2)
end

function var_0_3.PingPong(arg_12_0, arg_12_1)
	arg_12_0 = var_0_3.Repeat(arg_12_0, arg_12_1 * 2)

	return arg_12_1 - var_0_2(arg_12_0 - arg_12_1)
end

function var_0_3.Repeat(arg_13_0, arg_13_1)
	return arg_13_0 - var_0_1(arg_13_0 / arg_13_1) * arg_13_1
end

function var_0_3.Round(arg_14_0)
	return var_0_1(arg_14_0 + 0.5)
end

function var_0_3.Sign(arg_15_0)
	arg_15_0 = arg_15_0 > 0 and 1 or arg_15_0 < 0 and -1 or 0

	return arg_15_0
end

function var_0_3.SmoothDamp(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	arg_16_4 = arg_16_4 or var_0_3.Infinity
	arg_16_5 = arg_16_5 or Time.deltaTime
	arg_16_3 = var_0_3.Max(0.0001, arg_16_3)

	local var_16_0 = 2 / arg_16_3
	local var_16_1 = var_16_0 * arg_16_5
	local var_16_2 = 1 / (1 + var_16_1 + 0.48 * var_16_1 * var_16_1 + 0.235 * var_16_1 * var_16_1 * var_16_1)
	local var_16_3 = arg_16_0 - arg_16_1
	local var_16_4 = arg_16_1
	local var_16_5 = arg_16_4 * arg_16_3
	local var_16_6 = var_0_3.Clamp(var_16_3, -var_16_5, var_16_5)

	arg_16_1 = arg_16_0 - var_16_6

	local var_16_7 = (arg_16_2 + var_16_0 * var_16_6) * arg_16_5

	arg_16_2 = (arg_16_2 - var_16_0 * var_16_7) * var_16_2

	local var_16_8 = arg_16_1 + (var_16_6 + var_16_7) * var_16_2

	if arg_16_0 < var_16_4 == (var_16_4 < var_16_8) then
		var_16_8 = var_16_4
		arg_16_2 = (var_16_8 - var_16_4) / arg_16_5
	end

	return var_16_8, arg_16_2
end

function var_0_3.SmoothDampAngle(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	arg_17_5 = arg_17_5 or Time.deltaTime
	arg_17_4 = arg_17_4 or var_0_3.Infinity
	arg_17_1 = arg_17_0 + var_0_3.DeltaAngle(arg_17_0, arg_17_1)

	return var_0_3.SmoothDamp(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
end

function var_0_3.SmoothStep(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2 = var_0_3.Clamp01(arg_18_2)
	arg_18_2 = -2 * arg_18_2 * arg_18_2 * arg_18_2 + 3 * arg_18_2 * arg_18_2

	return arg_18_1 * arg_18_2 + arg_18_0 * (1 - arg_18_2)
end

function var_0_3.HorizontalAngle(arg_19_0)
	return var_0_0.deg(var_0_0.atan2(arg_19_0.x, arg_19_0.z))
end

function var_0_3.IsNan(arg_20_0)
	return arg_20_0 ~= arg_20_0
end

UnityEngine.Mathf = var_0_3

return var_0_3
