Mathf = var_0_10000

local var_0_0 = var_0_10000.Clamp

Mathf = var_0_10001

local var_0_1 = var_0_10001.Sqrt

Mathf = var_0_10002

local var_0_2 = var_0_10002.Min

Mathf = var_0_10003

local var_0_3 = var_0_10003.Max

setmetatable = var_0_10004
rawget = var_0_10005

local var_0_4 = {}

tolua = var_0_10007

local var_0_5 = var_0_10007.initget(var_0_4)

function var_0_4.__index(arg_1_0, arg_1_1)
	if var_0_10005(var_0_4, arg_1_1) == nil and var_0_10005(var_0_5, arg_1_1) ~= nil then
		return var_2(arg_1_0)
	end

	return var_2
end

function var_0_4.__call(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	return var_0_10004({
		x = arg_2_1 or 0,
		y = arg_2_2 or 0,
		z = arg_2_3 or 0,
		w = arg_2_4 or 0
	}, var_0_4)
end

function var_0_4.New(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return var_0_10004({
		x = arg_3_0 or 0,
		y = arg_3_1 or 0,
		z = arg_3_2 or 0,
		w = arg_3_3 or 0
	}, var_0_4)
end

function var_0_4.Set(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.x = arg_4_1 or 0
	arg_4_0.y = arg_4_2 or 0
	arg_4_0.z = arg_4_3 or 0
	arg_4_0.w = arg_4_4 or 0

	return
end

function var_0_4.Get(arg_5_0)
	return arg_5_0.x, arg_5_0.y, arg_5_0.z, arg_5_0.w
end

function var_0_4.Lerp(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = var_0_0(arg_6_2, 0, 1)

	return var_0_4.New(arg_6_0.x + (arg_6_1.x - arg_6_0.x) * arg_6_2, arg_6_0.y + (arg_6_1.y - arg_6_0.y) * arg_6_2, arg_6_0.z + (arg_6_1.z - arg_6_0.z) * arg_6_2, arg_6_0.w + (arg_6_1.w - arg_6_0.w) * arg_6_2)
end

function var_0_4.MoveTowards(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1 - arg_7_0

	if arg_7_2 < var_3.Magnitude(var_7_0) and var_4 ~= 0 then
		arg_7_2 = arg_7_2 / var_4

		var_3:Mul(arg_7_2)
		var_3:Add(arg_7_0)

		return var_3
	end

	return arg_7_1
end

function var_0_4.Scale(arg_8_0, arg_8_1)
	return var_0_4.New(arg_8_0.x * arg_8_1.x, arg_8_0.y * arg_8_1.y, arg_8_0.z * arg_8_1.z, arg_8_0.w * arg_8_1.w)
end

function var_0_4.SetScale(arg_9_0, arg_9_1)
	arg_9_0.x = arg_9_0.x * arg_9_1.x
	arg_9_0.y = arg_9_0.y * arg_9_1.y
	arg_9_0.z = arg_9_0.z * arg_9_1.z
	arg_9_0.w = arg_9_0.w * arg_9_1.w

	return
end

function var_0_4.Normalize(arg_10_0)
	vector4 = var_1_10001

	local var_10_0 = var_1_10001.New(arg_10_0.x, arg_10_0.y, arg_10_0.z, arg_10_0.w)

	return var_1.SetNormalize(var_10_0)
end

function var_0_4.SetNormalize(arg_11_0)
	if arg_11_0:Magnitude() == 1 then
		return arg_11_0
	elseif var_1 > 1e-05 then
		arg_11_0:Div(var_1)
	else
		arg_11_0:Set(0, 0, 0, 0)
	end

	return arg_11_0
end

function var_0_4.Div(arg_12_0, arg_12_1)
	arg_12_0.x = arg_12_0.x / arg_12_1
	arg_12_0.y = arg_12_0.y / arg_12_1
	arg_12_0.z = arg_12_0.z / arg_12_1
	arg_12_0.w = arg_12_0.w / arg_12_1

	return arg_12_0
end

function var_0_4.Mul(arg_13_0, arg_13_1)
	arg_13_0.x = arg_13_0.x * arg_13_1
	arg_13_0.y = arg_13_0.y * arg_13_1
	arg_13_0.z = arg_13_0.z * arg_13_1
	arg_13_0.w = arg_13_0.w * arg_13_1

	return arg_13_0
end

function var_0_4.Add(arg_14_0, arg_14_1)
	arg_14_0.x = arg_14_0.x + arg_14_1.x
	arg_14_0.y = arg_14_0.y + arg_14_1.y
	arg_14_0.z = arg_14_0.z + arg_14_1.z
	arg_14_0.w = arg_14_0.w + arg_14_1.w

	return arg_14_0
end

function var_0_4.Sub(arg_15_0, arg_15_1)
	arg_15_0.x = arg_15_0.x - arg_15_1.x
	arg_15_0.y = arg_15_0.y - arg_15_1.y
	arg_15_0.z = arg_15_0.z - arg_15_1.z
	arg_15_0.w = arg_15_0.w - arg_15_1.w

	return arg_15_0
end

function var_0_4.Dot(arg_16_0, arg_16_1)
	return arg_16_0.x * arg_16_1.x + arg_16_0.y * arg_16_1.y + arg_16_0.z * arg_16_1.z + arg_16_0.w * arg_16_1.w
end

function var_0_4.Project(arg_17_0, arg_17_1)
	return arg_17_1 * (var_0_4.Dot(arg_17_0, arg_17_1) / var_0_4.Dot(arg_17_1, arg_17_1))
end

function var_0_4.Distance(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0 - arg_18_1

	return var_0_4.Magnitude(var_18_0)
end

function var_0_4.Magnitude(arg_19_0)
	return var_0_1(arg_19_0.x * arg_19_0.x + arg_19_0.y * arg_19_0.y + arg_19_0.z * arg_19_0.z + arg_19_0.w * arg_19_0.w)
end

function var_0_4.SqrMagnitude(arg_20_0)
	return arg_20_0.x * arg_20_0.x + arg_20_0.y * arg_20_0.y + arg_20_0.z * arg_20_0.z + arg_20_0.w * arg_20_0.w
end

function var_0_4.Min(arg_21_0, arg_21_1)
	return var_0_4.New(var_0_3(arg_21_0.x, arg_21_1.x), var_0_3(arg_21_0.y, arg_21_1.y), var_0_3(arg_21_0.z, arg_21_1.z), var_0_3(arg_21_0.w, arg_21_1.w))
end

function var_0_4.Max(arg_22_0, arg_22_1)
	return var_0_4.New(var_0_2(arg_22_0.x, arg_22_1.x), var_0_2(arg_22_0.y, arg_22_1.y), var_0_2(arg_22_0.z, arg_22_1.z), var_0_2(arg_22_0.w, arg_22_1.w))
end

function var_0_4.__tostring(arg_23_0)
	string = var_1_10001

	return var_1_10001.format("[%f,%f,%f,%f]", arg_23_0.x, arg_23_0.y, arg_23_0.z, arg_23_0.w)
end

function var_0_4.__div(arg_24_0, arg_24_1)
	return var_0_4.New(arg_24_0.x / arg_24_1, arg_24_0.y / arg_24_1, arg_24_0.z / arg_24_1, arg_24_0.w / arg_24_1)
end

function var_0_4.__mul(arg_25_0, arg_25_1)
	return var_0_4.New(arg_25_0.x * arg_25_1, arg_25_0.y * arg_25_1, arg_25_0.z * arg_25_1, arg_25_0.w * arg_25_1)
end

function var_0_4.__add(arg_26_0, arg_26_1)
	return var_0_4.New(arg_26_0.x + arg_26_1.x, arg_26_0.y + arg_26_1.y, arg_26_0.z + arg_26_1.z, arg_26_0.w + arg_26_1.w)
end

function var_0_4.__sub(arg_27_0, arg_27_1)
	return var_0_4.New(arg_27_0.x - arg_27_1.x, arg_27_0.y - arg_27_1.y, arg_27_0.z - arg_27_1.z, arg_27_0.w - arg_27_1.w)
end

function var_0_4.__unm(arg_28_0)
	return var_0_4.New(-arg_28_0.x, -arg_28_0.y, -arg_28_0.z, -arg_28_0.w)
end

function var_0_4.__eq(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0 - arg_29_1

	return var_0_4.SqrMagnitude(var_29_0) < 1e-10
end

function var_0_5.zero()
	return var_0_4.New(0, 0, 0, 0)
end

function var_0_5.one()
	return var_0_4.New(1, 1, 1, 1)
end

var_0_5.magnitude = var_0_4.Magnitude
var_0_5.normalized = var_0_4.Normalize
var_0_5.sqrMagnitude = var_0_4.SqrMagnitude
UnityEngine = var_8
var_8.Vector4 = var_0_4

var_0_10004(var_0_4, var_0_4)

return var_0_4
