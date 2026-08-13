math = var_0_10000

local var_0_0 = var_0_10000.sin
local var_0_1 = var_0_10000.cos
local var_0_2 = var_0_10000.acos
local var_0_3 = var_0_10000.asin
local var_0_4 = var_0_10000.sqrt
local var_0_5 = var_0_10000.min
local var_0_6 = var_0_10000.max
local var_0_7 = var_0_10000.sign
local var_0_8 = var_0_10000.atan2

Mathf = var_0_10010

local var_0_9 = var_0_10010.Clamp
local var_0_10 = var_0_10000.abs

setmetatable = var_0_10012
getmetatable = var_0_10013
rawget = var_0_10014
rawset = var_0_10015
Vector3 = var_0_10016
Mathf = var_0_10017

local var_0_11 = var_0_10017.Rad2Deg

Mathf = var_0_10018

local var_0_12 = 0.5 * var_0_10018.Deg2Rad
local var_0_13 = var_0_10016.forward
local var_0_14 = var_0_10016.up
local var_0_15 = {
	2,
	3,
	1
}
local var_0_16 = {}

tolua = var_0_10023

local var_0_17 = var_0_10023.initget(var_0_16)

function var_0_16.__index(arg_1_0, arg_1_1)
	if var_0_10014(var_0_16, arg_1_1) == nil and var_0_10014(var_0_17, arg_1_1) ~= nil then
		return var_2(arg_1_0)
	end

	return var_2
end

function var_0_16.__newindex(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "eulerAngles" then
		arg_2_0:SetEuler(arg_2_2)
	else
		var_0_10015(arg_2_0, arg_2_1, arg_2_2)
	end

	return
end

function var_0_16.New(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		x = arg_3_0 or 0,
		y = arg_3_1 or 0,
		z = arg_3_2 or 0,
		w = arg_3_3 or 0
	}

	var_0_10012(var_3_0, var_0_16)

	return var_3_0
end

local var_0_18 = var_0_16.New

function var_0_16.__call(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = {
		x = arg_4_1 or 0,
		y = arg_4_2 or 0,
		z = arg_4_3 or 0,
		w = arg_4_4 or 0
	}

	var_0_10012(var_4_0, var_0_16)

	return var_4_0
end

function var_0_16.Set(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.x = arg_5_1 or 0
	arg_5_0.y = arg_5_2 or 0
	arg_5_0.z = arg_5_3 or 0
	arg_5_0.w = arg_5_4 or 0

	return
end

function var_0_16.Clone(arg_6_0)
	return var_0_18(arg_6_0.x, arg_6_0.y, arg_6_0.z, arg_6_0.w)
end

function var_0_16.Get(arg_7_0)
	return arg_7_0.x, arg_7_0.y, arg_7_0.z, arg_7_0.w
end

function var_0_16.Dot(arg_8_0, arg_8_1)
	return arg_8_0.x * arg_8_1.x + arg_8_0.y * arg_8_1.y + arg_8_0.z * arg_8_1.z + arg_8_0.w * arg_8_1.w
end

function var_0_16.Angle(arg_9_0, arg_9_1)
	local var_9_0

	if var_0_16.Dot(arg_9_0, arg_9_1) < 0 then
		var_9_0 = -var_9_0
	end

	return var_0_2(var_0_5(var_9_0, 1)) * 2 * 57.29578
end

function var_0_16.AngleAxis(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:Normalize()

	arg_10_0 = arg_10_0 * var_0_12

	local var_10_1 = var_0_0(arg_10_0)
	local var_10_2 = var_0_1(arg_10_0)
	local var_10_3 = var_10_0.x * var_10_1
	local var_10_4 = var_10_0.y * var_10_1
	local var_10_5 = var_10_0.z * var_10_1

	return var_0_18(var_10_3, var_10_4, var_10_5, var_10_2)
end

function var_0_16.Equals(arg_11_0, arg_11_1)
	return arg_11_0.x == arg_11_1.x and arg_11_0.y == arg_11_1.y and arg_11_0.z == arg_11_1.z and arg_11_0.w == arg_11_1.w
end

function var_0_16.Euler(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0 = arg_12_0 * 0.0087266462599716
	arg_12_1 = arg_12_1 * 0.0087266462599716
	arg_12_2 = arg_12_2 * 0.0087266462599716

	local var_12_0 = var_0_0(arg_12_0)

	arg_12_0 = var_0_1(arg_12_0)

	local var_12_1 = var_0_0(arg_12_1)

	arg_12_1 = var_0_1(arg_12_1)

	local var_12_2 = var_0_0(arg_12_2)

	arg_12_2 = var_0_1(arg_12_2)

	local var_12_3 = {
		x = arg_12_1 * var_12_0 * arg_12_2 + var_12_1 * arg_12_0 * var_12_2,
		y = var_12_1 * arg_12_0 * arg_12_2 - arg_12_1 * var_12_0 * var_12_2,
		z = arg_12_1 * arg_12_0 * var_12_2 - var_12_1 * var_12_0 * arg_12_2,
		w = arg_12_1 * arg_12_0 * arg_12_2 + var_12_1 * var_12_0 * var_12_2
	}

	var_0_10012(var_12_3, var_0_16)

	return var_12_3
end

function var_0_16.SetEuler(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 == nil and arg_13_3 == nil then
		arg_13_2 = arg_13_1.y
		arg_13_3 = arg_13_1.z
		arg_13_1 = arg_13_1.x
	end

	arg_13_1 = arg_13_1 * 0.0087266462599716
	arg_13_2 = arg_13_2 * 0.0087266462599716
	arg_13_3 = arg_13_3 * 0.0087266462599716

	local var_13_0 = var_0_0(arg_13_1)
	local var_13_1 = var_0_1(arg_13_1)
	local var_13_2 = var_0_0(arg_13_2)
	local var_13_3 = var_0_1(arg_13_2)
	local var_13_4 = var_0_0(arg_13_3)
	local var_13_5 = var_0_1(arg_13_3)

	arg_13_0.w = var_13_3 * var_13_1 * var_13_5 + var_13_2 * var_13_0 * var_13_4
	arg_13_0.x = var_13_3 * var_13_0 * var_13_5 + var_13_2 * var_13_1 * var_13_4
	arg_13_0.y = var_13_2 * var_13_1 * var_13_5 - var_13_3 * var_13_0 * var_13_4
	arg_13_0.z = var_13_3 * var_13_1 * var_13_4 - var_13_2 * var_13_0 * var_13_5

	return arg_13_0
end

function var_0_16.Normalize(arg_14_0)
	local var_14_0 = arg_14_0:Clone()

	var_1.SetNormalize(var_14_0)

	return var_1
end

function var_0_16.SetNormalize(arg_15_0)
	if arg_15_0.x * arg_15_0.x + arg_15_0.y * arg_15_0.y + arg_15_0.z * arg_15_0.z + arg_15_0.w * arg_15_0.w ~= 1 and var_1 > 0 then
		local var_15_0 = 1 / var_0_4(var_1)

		arg_15_0.x = arg_15_0.x * var_15_0
		arg_15_0.y = arg_15_0.y * var_15_0
		arg_15_0.z = arg_15_0.z * var_15_0
		arg_15_0.w = arg_15_0.w * var_15_0
	end

	return
end

function var_0_16.FromToRotation(arg_16_0, arg_16_1)
	local var_16_0 = var_0_16.New()

	var_2.SetFromToRotation(var_16_0, arg_16_0, arg_16_1)

	return var_2
end

function var_0_16.SetFromToRotation1(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:Normalize()
	local var_17_1 = arg_17_2:Normalize()

	if var_0_10016.Dot(var_17_0, var_17_1) > -0.999999 then
		local var_17_2 = 1 / var_0_4((1 + var_5) * 2)
		local var_17_3 = var_0_10016.Cross(var_17_0, var_17_1) * var_17_2

		arg_17_0:Set(var_17_3.x, var_17_3.y, var_17_3.z, var_6 * 0.5)
	elseif var_5 > 0.999999 then
		return var_0_18(0, 0, 0, 1)
	else
		local var_17_4 = var_0_10016.Cross(var_0_10016.right, var_17_0)
		local var_17_5

		if var_17_5.SqrMagnitude(var_17_4) < 1e-06 then
			var_17_5 = var_0_10016.Cross(var_0_10016.forward, var_17_0)
		end

		arg_17_0:Set(var_17_5.x, var_17_5.y, var_17_5.z, 0)

		return arg_17_0
	end

	return arg_17_0
end

local function var_0_19(arg_18_0, arg_18_1)
	if arg_18_0[1][1] + arg_18_0[2][2] + arg_18_0[3][3] > 0 then
		arg_18_1.w = 0.5 * var_0_4(var_2 + 1)

		local var_18_0 = 0.5 / var_3

		arg_18_1.x = (arg_18_0[3][2] - arg_18_0[2][3]) * var_18_0
		arg_18_1.y = (arg_18_0[1][3] - arg_18_0[3][1]) * var_18_0
		arg_18_1.z = (arg_18_0[2][1] - arg_18_0[1][2]) * var_18_0

		arg_18_1:SetNormalize()
	else
		local var_18_1 = 1
		local var_18_2 = {
			0,
			0,
			0
		}

		if arg_18_0[2][2] > arg_18_0[1][1] then
			var_18_1 = 2
		end

		if arg_18_0[3][3] > arg_18_0[var_18_1][var_18_1] then
			var_18_1 = 3
		end

		local var_18_3 = var_0_15[var_18_1]
		local var_18_4 = var_0_15[var_18_3]
		local var_18_5 = arg_18_0[var_18_1][var_18_1] - arg_18_0[var_18_3][var_18_3] - arg_18_0[var_18_4][var_18_4] + 1

		var_18_2[var_18_1] = 0.5 / var_0_4(var_18_5) * var_18_5

		local var_18_6 = (arg_18_0[var_18_4][var_18_3] - arg_18_0[var_18_3][var_18_4]) * var_8

		var_18_2[var_18_3] = (arg_18_0[var_18_3][var_18_1] + arg_18_0[var_18_1][var_18_3]) * var_8
		var_18_2[var_18_4] = (arg_18_0[var_18_4][var_18_1] + arg_18_0[var_18_1][var_18_4]) * var_8

		arg_18_1:Set(var_18_2[1], var_18_2[2], var_18_2[3], var_18_6)
		arg_18_1:SetNormalize()
	end

	return
end

function var_0_16.SetFromToRotation(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1:Normalize()
	arg_19_2 = arg_19_2:Normalize()

	if var_0_10016.Dot(arg_19_1, arg_19_2) > 0.999999 then
		arg_19_0:Set(0, 0, 0, 1)
	elseif var_3 < -0.999999 then
		local var_19_0

		if ({
			0,
			arg_19_1.z,
			arg_19_1.y
		})[2] * var_4[2] + var_4[3] * var_4[3] < 1e-06 then
			var_4[1] = -arg_19_1.z
			var_4[2] = 0
			var_4[3] = arg_19_1.x
			var_19_0 = var_4[1] * var_4[1] + var_4[3] * var_4[3]
		end

		local var_19_1 = 1 / var_0_4(var_19_0)

		var_4[1] = var_4[1] * var_19_1
		var_4[2] = var_4[2] * var_19_1
		var_4[3] = var_4[3] * var_19_1

		local var_19_2 = {
			0,
			0,
			0,
			[1] = var_4[2] * arg_19_1.z - var_4[3] * arg_19_1.y,
			[2] = var_4[3] * arg_19_1.x - var_4[1] * arg_19_1.z,
			[3] = var_4[1] * arg_19_1.y - var_4[2] * arg_19_1.x
		}
		local var_19_3 = -arg_19_1.x * arg_19_1.x
		local var_19_4 = -arg_19_1.y * arg_19_1.y
		local var_19_5 = -arg_19_1.z * arg_19_1.z
		local var_19_6 = -arg_19_1.x * arg_19_1.y
		local var_19_7 = -arg_19_1.x * arg_19_1.z
		local var_19_8 = -arg_19_1.y * arg_19_1.z
		local var_19_9 = var_19_2[1] * var_19_2[1]
		local var_19_10 = var_19_2[2] * var_19_2[2]
		local var_19_11 = var_19_2[3] * var_19_2[3]
		local var_19_12 = var_19_2[1] * var_19_2[2]
		local var_19_13 = var_19_2[1] * var_19_2[3]
		local var_19_14 = var_19_2[2] * var_19_2[3]
		local var_19_15 = -var_4[1] * var_4[1]
		local var_19_16 = -var_4[2] * var_4[2]
		local var_19_17 = -var_4[3] * var_4[3]
		local var_19_18 = -var_4[1] * var_4[2]
		local var_19_19 = -var_4[1] * var_4[3]
		local var_19_20 = -var_4[2] * var_4[3]
		local var_19_21 = {
			{
				var_19_3 + var_19_9 + var_19_15,
				var_19_6 + var_19_12 + var_19_18,
				var_19_7 + var_19_13 + var_19_19
			},
			{
				var_19_6 + var_19_12 + var_19_18,
				var_19_4 + var_19_10 + var_19_16,
				var_19_8 + var_19_14 + var_19_20
			},
			{
				var_19_7 + var_19_13 + var_19_19,
				var_19_8 + var_19_14 + var_19_20,
				var_19_5 + var_19_11 + var_19_17
			}
		}

		var_0_19(var_19_21, arg_19_0)
	else
		local var_19_22 = var_0_10016.Cross(arg_19_1, arg_19_2)
		local var_19_23 = (1 - var_3) / var_0_10016.Dot(var_19_22, var_19_22) * var_19_22.x
		local var_19_24 = var_5 * var_19_22.z
		local var_19_25 = var_19_23 * var_19_22.y
		local var_19_26 = var_19_23 * var_19_22.z
		local var_19_27 = var_19_24 * var_19_22.y
		local var_19_28 = {
			{
				var_3 + var_19_23 * var_19_22.x,
				var_19_25 - var_19_22.z,
				var_19_26 + var_19_22.y
			},
			{
				var_19_25 + var_19_22.z,
				var_3 + var_5 * var_19_22.y * var_19_22.y,
				var_19_27 - var_19_22.x
			},
			{
				var_19_26 - var_19_22.y,
				var_19_27 + var_19_22.x,
				var_3 + var_19_24 * var_19_22.z
			}
		}

		var_0_19(var_19_28, arg_19_0)
	end

	return
end

function var_0_16.Inverse(arg_20_0)
	local var_20_0 = var_0_16.New()

	var_20_0.x = -arg_20_0.x
	var_20_0.y = -arg_20_0.y
	var_20_0.z = -arg_20_0.z
	var_20_0.w = arg_20_0.w

	return var_20_0
end

function var_0_16.Lerp(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2 = var_0_9(arg_21_2, 0, 1)

	local var_21_0 = {
		w = 1,
		z = 0,
		x = 0,
		y = 0
	}

	if var_0_16.Dot(arg_21_0, arg_21_1) < 0 then
		var_21_0.x = arg_21_0.x + arg_21_2 * (-arg_21_1.x - arg_21_0.x)
		var_21_0.y = arg_21_0.y + arg_21_2 * (-arg_21_1.y - arg_21_0.y)
		var_21_0.z = arg_21_0.z + arg_21_2 * (-arg_21_1.z - arg_21_0.z)
		var_21_0.w = arg_21_0.w + arg_21_2 * (-arg_21_1.w - arg_21_0.w)
	else
		var_21_0.x = arg_21_0.x + (arg_21_1.x - arg_21_0.x) * arg_21_2
		var_21_0.y = arg_21_0.y + (arg_21_1.y - arg_21_0.y) * arg_21_2
		var_21_0.z = arg_21_0.z + (arg_21_1.z - arg_21_0.z) * arg_21_2
		var_21_0.w = arg_21_0.w + (arg_21_1.w - arg_21_0.w) * arg_21_2
	end

	var_0_16.SetNormalize(var_21_0)
	var_0_10012(var_21_0, var_0_16)

	return var_21_0
end

function var_0_16.LookRotation(arg_22_0, arg_22_1)
	if arg_22_0:Magnitude() < 1e-06 then
		error = var_3

		local var_22_0 = "error input forward to Quaternion.LookRotation"

		tostring = var_1_10006

		var_3(var_22_0 .. var_1_10006(arg_22_0))

		return nil
	end

	arg_22_0 = arg_22_0 / var_2
	arg_22_1 = arg_22_1 or var_0_14

	local var_22_1 = var_0_10016.Cross(arg_22_1, arg_22_0)

	var_3.SetNormalize(var_22_1)

	arg_22_1 = var_0_10016.Cross(arg_22_0, var_3)

	if var_0_10016.Cross(arg_22_1, arg_22_0).x + arg_22_1.y + arg_22_0.z > 0 then
		local var_22_2
		local var_22_3
		local var_22_4
		local var_22_5
		local var_22_6 = var_4 + 1
		local var_22_7 = 0.5 / var_0_4(var_22_6) * var_22_6
		local var_22_8 = (arg_22_1.z - arg_22_0.y) * var_9
		local var_22_9 = (arg_22_0.x - var_3.z) * var_9
		local var_22_10 = (var_3.y - arg_22_1.x) * var_9
		local var_22_11 = var_0_18(var_22_8, var_22_9, var_22_10, var_22_7)

		var_10.SetNormalize(var_22_11)

		return var_10
	else
		local var_22_12 = {
			{
				var_3.x,
				arg_22_1.x,
				arg_22_0.x
			},
			{
				var_3.y,
				arg_22_1.y,
				arg_22_0.y
			},
			{
				var_3.z,
				arg_22_1.z,
				arg_22_0.z
			}
		}
		local var_22_13 = {
			0,
			0,
			0
		}
		local var_22_14 = 1

		if arg_22_1.y > var_3.x then
			var_22_14 = 2
		end

		if arg_22_0.z > var_22_12[var_22_14][var_22_14] then
			var_22_14 = 3
		end

		local var_22_15 = var_0_15[var_22_14]
		local var_22_16 = var_0_15[var_22_15]
		local var_22_17 = var_22_12[var_22_14][var_22_14] - var_22_12[var_22_15][var_22_15] - var_22_12[var_22_16][var_22_16] + 1

		var_22_13[var_22_14] = 0.5 / var_0_4(var_22_17) * var_22_17

		local var_22_18 = (var_22_12[var_22_16][var_22_15] - var_22_12[var_22_15][var_22_16]) * var_11

		var_22_13[var_22_15] = (var_22_12[var_22_15][var_22_14] + var_22_12[var_22_14][var_22_15]) * var_11
		var_22_13[var_22_16] = (var_22_12[var_22_16][var_22_14] + var_22_12[var_22_14][var_22_16]) * var_11

		local var_22_19 = var_0_18(var_22_13[1], var_22_13[2], var_22_13[3], var_22_18)

		var_13.SetNormalize(var_22_19)

		return var_13
	end

	return
end

function var_0_16.SetIdentity(arg_23_0)
	arg_23_0.x = 0
	arg_23_0.y = 0
	arg_23_0.z = 0
	arg_23_0.w = 1

	return
end

local function var_0_20(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0

	if arg_24_0.x * arg_24_1.x + arg_24_0.y * arg_24_1.y + arg_24_0.z * arg_24_1.z + arg_24_0.w * arg_24_1.w < 0 then
		var_24_0 = -var_24_0
		arg_24_1 = var_0_10012({
			x = -arg_24_1.x,
			y = -arg_24_1.y,
			z = -arg_24_1.z,
			w = -arg_24_1.w
		}, var_0_16)
	end

	if var_24_0 < 0.95 then
		local var_24_1 = var_0_2(var_24_0)
		local var_24_2 = 1 / var_0_0(var_24_1)
		local var_24_3 = var_0_0((1 - arg_24_2) * var_24_1) * var_24_2
		local var_24_4 = var_0_0(arg_24_2 * var_24_1) * var_24_2

		arg_24_0 = {
			x = arg_24_0.x * var_24_3 + arg_24_1.x * var_24_4,
			y = arg_24_0.y * var_24_3 + arg_24_1.y * var_24_4,
			z = arg_24_0.z * var_24_3 + arg_24_1.z * var_24_4,
			w = arg_24_0.w * var_24_3 + arg_24_1.w * var_24_4
		}

		var_0_10012(arg_24_0, var_0_16)

		return arg_24_0
	else
		arg_24_0 = {
			x = arg_24_0.x + arg_24_2 * (arg_24_1.x - arg_24_0.x),
			y = arg_24_0.y + arg_24_2 * (arg_24_1.y - arg_24_0.y),
			z = arg_24_0.z + arg_24_2 * (arg_24_1.z - arg_24_0.z),
			w = arg_24_0.w + arg_24_2 * (arg_24_1.w - arg_24_0.w)
		}

		var_0_16.SetNormalize(arg_24_0)
		var_0_10012(arg_24_0, var_0_16)

		return arg_24_0
	end

	return
end

function var_0_16.Slerp(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 < 0 then
		arg_25_2 = 0
	elseif arg_25_2 > 1 then
		arg_25_2 = 1
	end

	return var_0_20(arg_25_0, arg_25_1, arg_25_2)
end

function var_0_16.RotateTowards(arg_26_0, arg_26_1, arg_26_2)
	if var_0_16.Angle(arg_26_0, arg_26_1) == 0 then
		return arg_26_1
	end

	local var_26_0 = var_0_5(1, arg_26_2 / var_3)

	return var_0_20(arg_26_0, arg_26_1, var_26_0)
end

local function var_0_21(arg_27_0, arg_27_1)
	return var_0_10(arg_27_0 - arg_27_1) < 1e-06
end

function var_0_16.ToAngleAxis(arg_28_0)
	local var_28_0 = 2 * var_0_2(arg_28_0.w)

	if var_0_21(var_28_0, 0) then
		local var_28_1 = var_28_0 * 57.29578
		local var_28_2 = var_0_10016.New(1, 0, 0)

		return
	end

	local var_28_3 = 1 / var_0_4(1 - var_0_4(arg_28_0.w))
	local var_28_4 = var_28_0 * 57.29578
	local var_28_5 = var_0_10016.New(arg_28_0.x * var_28_3, arg_28_0.y * var_28_3, arg_28_0.z * var_28_3)
end

Mathf = var_28

local var_0_22 = var_28.PI * 0.5
local var_0_23 = 2 * var_28
local var_0_24 = -0.0001
local var_0_25 = var_0_23 - 0.0001

local function var_0_26(arg_29_0)
	if arg_29_0.x < var_0_24 then
		arg_29_0.x = arg_29_0.x + var_0_23
	elseif arg_29_0.x > var_0_25 then
		arg_29_0.x = arg_29_0.x - var_0_23
	end

	if arg_29_0.y < var_0_24 then
		arg_29_0.y = arg_29_0.y + var_0_23
	elseif arg_29_0.y > var_0_25 then
		arg_29_0.y = arg_29_0.y - var_0_23
	end

	if arg_29_0.z < var_0_24 then
		arg_29_0.z = arg_29_0.z + var_0_23
	elseif arg_29_0.z > var_0_25 then
		arg_29_0.z = arg_29_0.z + var_0_23
	end

	return
end

function var_0_16.ToEulerAngles(arg_30_0)
	local var_30_0 = arg_30_0.x
	local var_30_1 = arg_30_0.y
	local var_30_2 = arg_30_0.z
	local var_30_3 = arg_30_0.w

	if 2 * (var_30_1 * var_30_2 - var_30_3 * var_30_0) < 0.999 then
		if var_5 > -0.999 then
			local var_30_4 = var_0_10016.New(-var_0_3(var_5), var_0_8(2 * (var_30_0 * var_30_2 + var_30_3 * var_30_1), 1 - 2 * (var_30_0 * var_30_0 + var_30_1 * var_30_1)), var_0_8(2 * (var_30_0 * var_30_1 + var_30_3 * var_30_2), 1 - 2 * (var_30_0 * var_30_0 + var_30_2 * var_30_2)))

			var_0_26(var_30_4)
			var_30_4:Mul(var_0_11)

			return var_30_4
		else
			local var_30_5 = var_0_10016.New(var_0_22, var_0_8(2 * (var_30_0 * var_30_1 - var_30_3 * var_30_2), 1 - 2 * (var_30_1 * var_30_1 + var_30_2 * var_30_2)), 0)

			var_0_26(var_30_5)
			var_30_5:Mul(var_0_11)

			return var_30_5
		end
	else
		local var_30_6 = var_0_10016.New(-var_0_22, var_0_8(-2 * (var_30_0 * var_30_1 - var_30_3 * var_30_2), 1 - 2 * (var_30_1 * var_30_1 + var_30_2 * var_30_2)), 0)

		var_0_26(var_30_6)
		var_30_6:Mul(var_0_11)

		return var_30_6
	end

	return
end

function var_0_16.Forward(arg_31_0)
	return arg_31_0:MulVec3(var_0_13)
end

function var_0_16.MulVec3(arg_32_0, arg_32_1)
	local var_32_0 = var_0_10016.New()
	local var_32_1 = arg_32_0.x * 2
	local var_32_2 = arg_32_0.y * 2
	local var_32_3 = arg_32_0.z * 2
	local var_32_4 = arg_32_0.x * var_32_1
	local var_32_5 = arg_32_0.y * var_32_2
	local var_32_6 = arg_32_0.z * var_32_3
	local var_32_7 = arg_32_0.x * var_32_2
	local var_32_8 = arg_32_0.x * var_32_3
	local var_32_9 = arg_32_0.y * var_32_3
	local var_32_10 = arg_32_0.w * var_32_1
	local var_32_11 = arg_32_0.w * var_32_2
	local var_32_12 = arg_32_0.w * var_32_3

	var_32_0.x = (1 - (var_32_5 + var_32_6)) * arg_32_1.x + (var_32_7 - var_32_12) * arg_32_1.y + (var_32_8 + var_32_11) * arg_32_1.z
	var_32_0.y = (var_32_7 + var_32_12) * arg_32_1.x + (1 - (var_32_4 + var_32_6)) * arg_32_1.y + (var_32_9 - var_32_10) * arg_32_1.z
	var_32_0.z = (var_32_8 - var_32_11) * arg_32_1.x + (var_32_9 + var_32_10) * arg_32_1.y + (1 - (var_32_4 + var_32_5)) * arg_32_1.z

	return var_32_0
end

function var_0_16.__mul(arg_33_0, arg_33_1)
	if var_0_16 == var_0_10013(arg_33_1) then
		return var_0_16.New(arg_33_0.w * arg_33_1.x + arg_33_0.x * arg_33_1.w + arg_33_0.y * arg_33_1.z - arg_33_0.z * arg_33_1.y, arg_33_0.w * arg_33_1.y + arg_33_0.y * arg_33_1.w + arg_33_0.z * arg_33_1.x - arg_33_0.x * arg_33_1.z, arg_33_0.w * arg_33_1.z + arg_33_0.z * arg_33_1.w + arg_33_0.x * arg_33_1.y - arg_33_0.y * arg_33_1.x, arg_33_0.w * arg_33_1.w - arg_33_0.x * arg_33_1.x - arg_33_0.y * arg_33_1.y - arg_33_0.z * arg_33_1.z)
	elseif var_0_10016 == var_0_10013(arg_33_1) then
		return arg_33_0:MulVec3(arg_33_1)
	end

	return
end

function var_0_16.__unm(arg_34_0)
	return var_0_16.New(-arg_34_0.x, -arg_34_0.y, -arg_34_0.z, -arg_34_0.w)
end

function var_0_16.__eq(arg_35_0, arg_35_1)
	return var_0_16.Dot(arg_35_0, arg_35_1) > 0.999999
end

function var_0_16.__tostring(arg_36_0)
	return "[" .. arg_36_0.x .. "," .. arg_36_0.y .. "," .. arg_36_0.z .. "," .. arg_36_0.w .. "]"
end

function var_0_17.identity()
	return var_0_18(0, 0, 0, 1)
end

var_0_17.eulerAngles = var_0_16.ToEulerAngles
UnityEngine = var_34
var_34.Quaternion = var_0_16

var_0_10012(var_0_16, var_0_16)

return var_0_16
