math = var_0_10000

local var_0_0 = var_0_10000.floor
local var_0_1 = var_0_10000.abs

Mathf = var_0_10003
var_0_10003.Deg2Rad = var_0_10000.rad(1)
var_0_10003.Epsilon = 1.4013e-45
var_0_10003.Infinity = var_0_10000.huge
var_0_10003.NegativeInfinity = -var_0_10000.huge
var_0_10003.PI = var_0_10000.pi
var_0_10003.Rad2Deg = var_0_10000.deg(1)
var_0_10003.Abs = var_0_10000.abs
var_0_10003.Acos = var_0_10000.acos
var_0_10003.Asin = var_0_10000.asin
var_0_10003.Atan = var_0_10000.atan
var_0_10003.Atan2 = var_0_10000.atan2
var_0_10003.Ceil = var_0_10000.ceil
var_0_10003.Cos = var_0_10000.cos
var_0_10003.Exp = var_0_10000.exp
var_0_10003.Floor = var_0_10000.floor
var_0_10003.Log = var_0_10000.log
var_0_10003.Log10 = var_0_10000.log10
var_0_10003.Max = var_0_10000.max
var_0_10003.Min = var_0_10000.min
var_0_10003.Pow = var_0_10000.pow
var_0_10003.Sin = var_0_10000.sin
var_0_10003.Sqrt = var_0_10000.sqrt
var_0_10003.Tan = var_0_10000.tan
var_0_10003.Deg = var_0_10000.deg
var_0_10003.Rad = var_0_10000.rad
var_0_10003.Random = var_0_10000.random

function var_0_10003.Approximately(arg_1_0, arg_1_1)
	return var_0_1(arg_1_1 - arg_1_0) < var_0_10000.max(1e-06 * var_0_10000.max(var_0_1(arg_1_0), var_0_1(arg_1_1)), 1.121039e-44)
end

function var_0_10003.Clamp(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0 < arg_2_1 then
		arg_2_0 = arg_2_1
	elseif arg_2_2 < arg_2_0 then
		arg_2_0 = arg_2_2
	end

	return arg_2_0
end

function var_0_10003.Clamp01(arg_3_0)
	if arg_3_0 < 0 then
		return 0
	elseif arg_3_0 > 1 then
		return 1
	end

	return arg_3_0
end

function var_0_10003.DeltaAngle(arg_4_0, arg_4_1)
	local var_4_0

	if var_0_10003.Repeat(arg_4_1 - arg_4_0, 360) > 180 then
		var_4_0 = var_4_0 - 360
	end

	return var_4_0
end

function var_0_10003.Gamma(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = false

	if arg_5_0 < 0 then
		var_5_0 = true
	end

	if arg_5_1 < var_0_1(arg_5_0) then
		return not var_5_0 and var_4 or -var_4
	end

	local var_5_1 = var_0_10000.pow(var_4 / arg_5_1, arg_5_2) * arg_5_1

	return not var_5_0 and var_5_1 or -var_5_1
end

function var_0_10003.InverseLerp(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0 < arg_6_1 then
		if arg_6_2 < arg_6_0 then
			return 0
		end

		if arg_6_1 < arg_6_2 then
			return 1
		end

		return (arg_6_2 - arg_6_0) / (arg_6_1 - arg_6_0)
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

function var_0_10003.Lerp(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0 + (arg_7_1 - arg_7_0) * var_0_10003.Clamp01(arg_7_2)
end

function var_0_10003.LerpAngle(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	if var_0_10003.Repeat(arg_8_1 - arg_8_0, 360) > 180 then
		var_8_0 = var_8_0 - 360
	end

	return arg_8_0 + var_8_0 * var_0_10003.Clamp01(arg_8_2)
end

function var_0_10003.LerpUnclamped(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0 + (arg_9_1 - arg_9_0) * arg_9_2
end

function var_0_10003.MoveTowards(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 >= var_0_1(arg_10_1 - arg_10_0) then
		return arg_10_1
	end

	return arg_10_0 + var_0_10003.Sign(arg_10_1 - arg_10_0) * arg_10_2
end

function var_0_10003.MoveTowardsAngle(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1 = arg_11_0 + var_0_10003.DeltaAngle(arg_11_0, arg_11_1)

	return var_0_10003.MoveTowards(arg_11_0, arg_11_1, arg_11_2)
end

function var_0_10003.PingPong(arg_12_0, arg_12_1)
	arg_12_0 = var_0_10003.Repeat(arg_12_0, arg_12_1 * 2)

	return arg_12_1 - var_0_1(arg_12_0 - arg_12_1)
end

function var_0_10003.Repeat(arg_13_0, arg_13_1)
	return arg_13_0 - var_0_0(arg_13_0 / arg_13_1) * arg_13_1
end

function var_0_10003.Round(arg_14_0)
	return var_0_0(arg_14_0 + 0.5)
end

function var_0_10003.Sign(arg_15_0)
	arg_15_0 = arg_15_0 > 0 and 1 or arg_15_0 < 0 and -1 or 0

	return arg_15_0
end

function var_0_10003.SmoothDamp(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	arg_16_4 = arg_16_4 or var_0_10003.Infinity

	if not arg_16_5 then
		Time = var_1_10006
		arg_16_5 = var_1_10006.deltaTime
	end

	local var_16_0 = 1 / (1 + 2 / var_0_10003.Max(0.0001, arg_16_3) * arg_16_5 + 0.48 * var_7 * var_7 + 0.235 * var_7 * var_7 * var_7)
	local var_16_1 = arg_16_0 - arg_16_1
	local var_16_2 = arg_16_1
	local var_16_3 = arg_16_4 * arg_16_3

	arg_16_1 = arg_16_0 - var_0_10003.Clamp(var_16_1, -var_16_3, var_16_3)
	arg_16_2 = (arg_16_2 - var_6 * ((arg_16_2 + var_6 * var_9) * arg_16_5)) * var_16_0

	local var_16_4 = arg_16_1 + (var_9 + var_12) * var_16_0

	if arg_16_0 < var_16_2 == (var_16_2 < var_16_4) then
		arg_16_2 = (var_16_2 - var_16_2) / arg_16_5
	end

	return var_16_4, arg_16_2
end

function var_0_10003.SmoothDampAngle(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	if not arg_17_5 then
		Time = var_1_10006
		arg_17_5 = var_1_10006.deltaTime
	end

	arg_17_4 = arg_17_4 or var_0_10003.Infinity
	arg_17_1 = arg_17_0 + var_0_10003.DeltaAngle(arg_17_0, arg_17_1)

	return var_0_10003.SmoothDamp(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
end

function var_0_10003.SmoothStep(arg_18_0, arg_18_1, arg_18_2)
	return arg_18_1 * (-2 * var_0_10003.Clamp01(arg_18_2) * arg_18_2 * arg_18_2 + 3 * arg_18_2 * arg_18_2) + arg_18_0 * (1 - arg_18_2)
end

function var_0_10003.HorizontalAngle(arg_19_0)
	return var_0_10000.deg(var_0_10000.atan2(arg_19_0.x, arg_19_0.z))
end

function var_0_10003.IsNan(arg_20_0)
	return arg_20_0 ~= arg_20_0
end

function var_0_10003.MultiRandom(arg_21_0, arg_21_1)
	local var_21_0 = {}
	local var_21_1 = {}

	ipairs = var_1_10004

	for iter_21_0, iter_21_1 in var_1_10004(arg_21_0) do
		table = var_1_10009

		var_1_10009.insert(var_21_1, iter_21_0)
	end

	arg_21_1 = var_0_10000.min(#arg_21_0, arg_21_1)

	while arg_21_1 > 0 do
		local var_21_2 = var_0_10000.random(#var_21_1)

		table = var_21_3

		local var_21_3 = var_21_3.remove(var_21_1, var_21_2)

		table = var_6

		var_6.insert(var_21_0, arg_21_0[var_21_3])

		arg_21_1 = arg_21_1 - 1
	end

	return var_21_0
end

function var_0_10003.RandomFloat(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1 = arg_22_1 or 0
	arg_22_2 = arg_22_2 or 10000
	arg_22_1 = arg_22_1 * arg_22_2
	arg_22_0 = arg_22_0 * arg_22_2

	return var_0_10000.random(arg_22_1, arg_22_0) / arg_22_2
end

UnityEngine = var_4
var_4.Mathf = var_0_10003

return var_0_10003
