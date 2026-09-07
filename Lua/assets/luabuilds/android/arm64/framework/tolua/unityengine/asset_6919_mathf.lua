local var_0_0 = math
local var_0_1 = math.floor
local var_0_2 = math.abs
local var_0_3 = Mathf

Mathf.Deg2Rad = math.rad(1)
Mathf.Epsilon = 1.4013e-45
Mathf.Infinity = math.huge
Mathf.NegativeInfinity = -math.huge
Mathf.PI = math.pi
Mathf.Rad2Deg = math.deg(1)
Mathf.Abs = math.abs
Mathf.Acos = math.acos
Mathf.Asin = math.asin
Mathf.Atan = math.atan
Mathf.Atan2 = math.atan2
Mathf.Ceil = math.ceil
Mathf.Cos = math.cos
Mathf.Exp = math.exp
Mathf.Floor = math.floor
Mathf.Log = math.log
Mathf.Log10 = math.log10
Mathf.Max = math.max
Mathf.Min = math.min
Mathf.Pow = math.pow
Mathf.Sin = math.sin
Mathf.Sqrt = math.sqrt
Mathf.Tan = math.tan
Mathf.Deg = math.deg
Mathf.Rad = math.rad
Mathf.Random = math.random

function Mathf.Approximately(arg_1_0, arg_1_1)
	return var_0_2(arg_1_1 - arg_1_0) < var_0_0.max(1e-06 * var_0_0.max(var_0_2(arg_1_0), var_0_2(arg_1_1)), 1.121039e-44)
end

function Mathf.Clamp(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0 < arg_2_1 then
		arg_2_0 = arg_2_1
	elseif arg_2_2 < arg_2_0 then
		arg_2_0 = arg_2_2
	end

	return arg_2_0
end

function Mathf.Clamp01(arg_3_0)
	if arg_3_0 < 0 then
		return 0
	elseif arg_3_0 > 1 then
		return 1
	end

	return arg_3_0
end

function Mathf.DeltaAngle(arg_4_0, arg_4_1)
	local var_4_0 = var_0_3.Repeat(arg_4_1 - arg_4_0, 360)

	if var_4_0 > 180 then
		var_4_0 = var_4_0 - 360
	end

	return var_4_0
end

function Mathf.Gamma(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0 < 0
	local var_5_1 = var_0_2(arg_5_0)

	if arg_5_1 < var_5_1 then
		return not var_5_0 and var_5_1 or -var_5_1
	end

	local var_5_2 = var_0_0.pow(var_5_1 / arg_5_1, arg_5_2) * arg_5_1

	return not var_5_0 and var_5_2 or -var_5_2
end

function Mathf.InverseLerp(arg_6_0, arg_6_1, arg_6_2)
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

function Mathf.Lerp(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0 + (arg_7_1 - arg_7_0) * var_0_3.Clamp01(arg_7_2)
end

function Mathf.LerpAngle(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_3.Repeat(arg_8_1 - arg_8_0, 360)

	if var_8_0 > 180 then
		var_8_0 = var_8_0 - 360
	end

	return arg_8_0 + var_8_0 * var_0_3.Clamp01(arg_8_2)
end

function Mathf.LerpUnclamped(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0 + (arg_9_1 - arg_9_0) * arg_9_2
end

function Mathf.MoveTowards(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 >= var_0_2(arg_10_1 - arg_10_0) then
		return arg_10_1
	end

	return arg_10_0 + var_0_3.Sign(arg_10_1 - arg_10_0) * arg_10_2
end

function Mathf.MoveTowardsAngle(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1 = arg_11_0 + var_0_3.DeltaAngle(arg_11_0, arg_11_1)

	return var_0_3.MoveTowards(arg_11_0, arg_11_1, arg_11_2)
end

function Mathf.PingPong(arg_12_0, arg_12_1)
	arg_12_0 = var_0_3.Repeat(arg_12_0, arg_12_1 * 2)

	return arg_12_1 - var_0_2(arg_12_0 - arg_12_1)
end

function Mathf.Repeat(arg_13_0, arg_13_1)
	return arg_13_0 - var_0_1(arg_13_0 / arg_13_1) * arg_13_1
end

function Mathf.Round(arg_14_0)
	return var_0_1(arg_14_0 + 0.5)
end

function Mathf.Sign(arg_15_0)
	arg_15_0 = arg_15_0 > 0 and 1 or arg_15_0 < 0 and -1 or 0

	return arg_15_0
end

function Mathf.SmoothDamp(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	arg_16_4 = arg_16_4 or var_0_3.Infinity
	arg_16_5 = arg_16_5 or Time.deltaTime
	arg_16_3 = var_0_3.Max(0.0001, arg_16_3)

	local var_16_0 = 1 / (1 + 2 / arg_16_3 * arg_16_5 + 0.48 * (2 / arg_16_3 * arg_16_5) * (2 / arg_16_3 * arg_16_5) + 0.235 * (2 / arg_16_3 * arg_16_5) * (2 / arg_16_3 * arg_16_5) * (2 / arg_16_3 * arg_16_5))
	local var_16_1 = arg_16_1
	local var_16_2 = var_0_3.Clamp(arg_16_0 - arg_16_1, -(arg_16_4 * arg_16_3), arg_16_4 * arg_16_3)

	arg_16_1 = arg_16_0 - var_16_2
	arg_16_2 = (arg_16_2 - 2 / arg_16_3 * ((arg_16_2 + 2 / arg_16_3 * var_16_2) * arg_16_5)) * var_16_0

	local var_16_3 = arg_16_0 - var_16_2 + (var_16_2 + (arg_16_2 + 2 / arg_16_3 * var_16_2) * arg_16_5) * var_16_0

	if arg_16_0 < arg_16_1 == (arg_16_1 < arg_16_0 - var_16_2 + (var_16_2 + (arg_16_2 + 2 / arg_16_3 * var_16_2) * arg_16_5) * var_16_0) then
		var_16_3 = var_16_1
		arg_16_2 = (var_16_1 - var_16_1) / arg_16_5
	end

	return var_16_3, arg_16_2
end

function Mathf.SmoothDampAngle(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	arg_17_5 = arg_17_5 or Time.deltaTime
	arg_17_4 = arg_17_4 or var_0_3.Infinity
	arg_17_1 = arg_17_0 + var_0_3.DeltaAngle(arg_17_0, arg_17_1)

	return var_0_3.SmoothDamp(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
end

function Mathf.SmoothStep(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2 = var_0_3.Clamp01(arg_18_2)
	arg_18_2 = -2 * arg_18_2 * arg_18_2 * arg_18_2 + 3 * arg_18_2 * arg_18_2

	return arg_18_1 * arg_18_2 + arg_18_0 * (1 - arg_18_2)
end

function Mathf:HorizontalAngle()
	return var_0_0.deg(var_0_0.atan2(self.x, self.z))
end

function Mathf.IsNan(arg_20_0)
	return arg_20_0 ~= arg_20_0
end

function Mathf:MultiRandom(arg_21_1)
	local var_21_0 = {}
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs(self) do
		table.insert(var_21_1, iter_21_0)
	end

	arg_21_1 = var_0_0.min(#self, arg_21_1)

	while arg_21_1 > 0 do
		table.insert(var_21_0, self[table.remove(var_21_1, (var_0_0.random(#var_21_1)))])

		arg_21_1 = arg_21_1 - 1
	end

	return var_21_0
end

function Mathf.RandomFloat(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1 = arg_22_1 or 0
	arg_22_2 = arg_22_2 or 10000
	arg_22_1 = arg_22_1 * arg_22_2
	arg_22_0 = arg_22_0 * arg_22_2

	return var_0_0.random(arg_22_1, arg_22_0) / arg_22_2
end

UnityEngine.Mathf = Mathf

return Mathf
