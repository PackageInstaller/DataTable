local var_0_0 = math
local var_0_1 = var_0_0.sin
local var_0_2 = var_0_0.cos
local var_0_3 = var_0_0.acos
local var_0_4 = var_0_0.asin
local var_0_5 = var_0_0.sqrt
local var_0_6 = var_0_0.min
local var_0_7 = var_0_0.max
local var_0_8 = var_0_0.sign
local var_0_9 = var_0_0.atan2
local var_0_10 = Mathf.Clamp
local var_0_11 = var_0_0.abs
local var_0_12 = setmetatable
local var_0_13 = getmetatable
local var_0_14 = rawget
local var_0_15 = rawset
local var_0_16 = Vector3
local var_0_17 = Mathf.Rad2Deg
local var_0_18 = 0.5 * Mathf.Deg2Rad
local var_0_19 = var_0_16.forward
local var_0_20 = var_0_16.up
local var_0_21 = {
	2,
	3,
	1
}
local var_0_22 = {}
local var_0_23 = tolua.initget(var_0_22)

function var_0_22.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_14(var_0_22, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_14(var_0_23, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_22.__newindex(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "eulerAngles" then
		arg_2_0:SetEuler(arg_2_2)
	else
		var_0_15(arg_2_0, arg_2_1, arg_2_2)
	end
end

function var_0_22.New(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		x = arg_3_0 or 0,
		y = arg_3_1 or 0,
		z = arg_3_2 or 0,
		w = arg_3_3 or 0
	}

	var_0_12(var_3_0, var_0_22)

	return var_3_0
end

local var_0_24 = var_0_22.New

function var_0_22.__call(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = {
		x = arg_4_1 or 0,
		y = arg_4_2 or 0,
		z = arg_4_3 or 0,
		w = arg_4_4 or 0
	}

	var_0_12(var_4_0, var_0_22)

	return var_4_0
end

function var_0_22.Set(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.x = arg_5_1 or 0
	arg_5_0.y = arg_5_2 or 0
	arg_5_0.z = arg_5_3 or 0
	arg_5_0.w = arg_5_4 or 0
end

function var_0_22.Clone(arg_6_0)
	return var_0_24(arg_6_0.x, arg_6_0.y, arg_6_0.z, arg_6_0.w)
end

function var_0_22.Get(arg_7_0)
	return arg_7_0.x, arg_7_0.y, arg_7_0.z, arg_7_0.w
end

function var_0_22.Dot(arg_8_0, arg_8_1)
	return arg_8_0.x * arg_8_1.x + arg_8_0.y * arg_8_1.y + arg_8_0.z * arg_8_1.z + arg_8_0.w * arg_8_1.w
end

function var_0_22.Angle(arg_9_0, arg_9_1)
	local var_9_0 = var_0_22.Dot(arg_9_0, arg_9_1)

	if var_9_0 < 0 then
		var_9_0 = -var_9_0
	end

	return var_0_3(var_0_6(var_9_0, 1)) * 2 * 57.29578
end

function var_0_22.AngleAxis(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:Normalize()

	arg_10_0 = arg_10_0 * var_0_18

	local var_10_1 = var_0_1(arg_10_0)
	local var_10_2 = var_0_2(arg_10_0)
	local var_10_3 = var_10_0.x * var_10_1
	local var_10_4 = var_10_0.y * var_10_1
	local var_10_5 = var_10_0.z * var_10_1

	return var_0_24(var_10_3, var_10_4, var_10_5, var_10_2)
end

function var_0_22.Equals(arg_11_0, arg_11_1)
	return arg_11_0.x == arg_11_1.x and arg_11_0.y == arg_11_1.y and arg_11_0.z == arg_11_1.z and arg_11_0.w == arg_11_1.w
end

function var_0_22.Euler(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == nil and arg_12_2 == nil then
		arg_12_1 = arg_12_0.y
		arg_12_2 = arg_12_0.z
		arg_12_0 = arg_12_0.x
	end

	arg_12_0 = arg_12_0 * 0.0087266462599716
	arg_12_1 = arg_12_1 * 0.0087266462599716
	arg_12_2 = arg_12_2 * 0.0087266462599716

	local var_12_0 = var_0_1(arg_12_0)

	arg_12_0 = var_0_2(arg_12_0)

	local var_12_1 = var_0_1(arg_12_1)

	arg_12_1 = var_0_2(arg_12_1)

	local var_12_2 = var_0_1(arg_12_2)

	arg_12_2 = var_0_2(arg_12_2)

	local var_12_3 = {
		x = arg_12_1 * var_12_0 * arg_12_2 + var_12_1 * arg_12_0 * var_12_2,
		y = var_12_1 * arg_12_0 * arg_12_2 - arg_12_1 * var_12_0 * var_12_2,
		z = arg_12_1 * arg_12_0 * var_12_2 - var_12_1 * var_12_0 * arg_12_2,
		w = arg_12_1 * arg_12_0 * arg_12_2 + var_12_1 * var_12_0 * var_12_2
	}

	var_0_12(var_12_3, var_0_22)

	return var_12_3
end

function var_0_22.SetEuler(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 == nil and arg_13_3 == nil then
		arg_13_2 = arg_13_1.y
		arg_13_3 = arg_13_1.z
		arg_13_1 = arg_13_1.x
	end

	arg_13_1 = arg_13_1 * 0.0087266462599716
	arg_13_2 = arg_13_2 * 0.0087266462599716
	arg_13_3 = arg_13_3 * 0.0087266462599716

	local var_13_0 = var_0_1(arg_13_1)
	local var_13_1 = var_0_2(arg_13_1)
	local var_13_2 = var_0_1(arg_13_2)
	local var_13_3 = var_0_2(arg_13_2)
	local var_13_4 = var_0_1(arg_13_3)
	local var_13_5 = var_0_2(arg_13_3)

	arg_13_0.w = var_13_3 * var_13_1 * var_13_5 + var_13_2 * var_13_0 * var_13_4
	arg_13_0.x = var_13_3 * var_13_0 * var_13_5 + var_13_2 * var_13_1 * var_13_4
	arg_13_0.y = var_13_2 * var_13_1 * var_13_5 - var_13_3 * var_13_0 * var_13_4
	arg_13_0.z = var_13_3 * var_13_1 * var_13_4 - var_13_2 * var_13_0 * var_13_5

	return arg_13_0
end

function var_0_22.Normalize(arg_14_0)
	local var_14_0 = arg_14_0:Clone()

	var_14_0:SetNormalize()

	return var_14_0
end

function var_0_22.SetNormalize(arg_15_0)
	local var_15_0 = arg_15_0.x * arg_15_0.x + arg_15_0.y * arg_15_0.y + arg_15_0.z * arg_15_0.z + arg_15_0.w * arg_15_0.w

	if var_15_0 ~= 1 and var_15_0 > 0 then
		local var_15_1 = 1 / var_0_5(var_15_0)

		arg_15_0.x = arg_15_0.x * var_15_1
		arg_15_0.y = arg_15_0.y * var_15_1
		arg_15_0.z = arg_15_0.z * var_15_1
		arg_15_0.w = arg_15_0.w * var_15_1
	end
end

function var_0_22.FromToRotation(arg_16_0, arg_16_1)
	local var_16_0 = var_0_22.New()

	var_16_0:SetFromToRotation(arg_16_0, arg_16_1)

	return var_16_0
end

function var_0_22.SetFromToRotation1(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:Normalize()
	local var_17_1 = arg_17_2:Normalize()
	local var_17_2 = var_0_16.Dot(var_17_0, var_17_1)

	if var_17_2 > -0.999999 then
		local var_17_3 = var_0_5((1 + var_17_2) * 2)
		local var_17_4 = 1 / var_17_3
		local var_17_5 = var_0_16.Cross(var_17_0, var_17_1) * var_17_4

		arg_17_0:Set(var_17_5.x, var_17_5.y, var_17_5.z, var_17_3 * 0.5)
	elseif var_17_2 > 0.999999 then
		return var_0_24(0, 0, 0, 1)
	else
		local var_17_6 = var_0_16.Cross(var_0_16.right, var_17_0)

		if var_17_6:SqrMagnitude() < 1e-06 then
			var_17_6 = var_0_16.Cross(var_0_16.forward, var_17_0)
		end

		arg_17_0:Set(var_17_6.x, var_17_6.y, var_17_6.z, 0)

		return arg_17_0
	end

	return arg_17_0
end

local function var_0_25(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0[1][1] + arg_18_0[2][2] + arg_18_0[3][3]

	if var_18_0 > 0 then
		local var_18_1 = var_0_5(var_18_0 + 1)

		arg_18_1.w = 0.5 * var_18_1

		local var_18_2 = 0.5 / var_18_1

		arg_18_1.x = (arg_18_0[3][2] - arg_18_0[2][3]) * var_18_2
		arg_18_1.y = (arg_18_0[1][3] - arg_18_0[3][1]) * var_18_2
		arg_18_1.z = (arg_18_0[2][1] - arg_18_0[1][2]) * var_18_2

		arg_18_1:SetNormalize()
	else
		local var_18_3 = 1
		local var_18_4 = {
			0,
			0,
			0
		}

		if arg_18_0[2][2] > arg_18_0[1][1] then
			var_18_3 = 2
		end

		if arg_18_0[3][3] > arg_18_0[var_18_3][var_18_3] then
			var_18_3 = 3
		end

		local var_18_5 = var_0_21[var_18_3]
		local var_18_6 = var_0_21[var_18_5]
		local var_18_7 = arg_18_0[var_18_3][var_18_3] - arg_18_0[var_18_5][var_18_5] - arg_18_0[var_18_6][var_18_6] + 1
		local var_18_8 = 0.5 / var_0_5(var_18_7)

		var_18_4[var_18_3] = var_18_8 * var_18_7

		local var_18_9 = (arg_18_0[var_18_6][var_18_5] - arg_18_0[var_18_5][var_18_6]) * var_18_8

		var_18_4[var_18_5] = (arg_18_0[var_18_5][var_18_3] + arg_18_0[var_18_3][var_18_5]) * var_18_8
		var_18_4[var_18_6] = (arg_18_0[var_18_6][var_18_3] + arg_18_0[var_18_3][var_18_6]) * var_18_8

		arg_18_1:Set(var_18_4[1], var_18_4[2], var_18_4[3], var_18_9)
		arg_18_1:SetNormalize()
	end
end

function var_0_22.SetFromToRotation(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1:Normalize()
	arg_19_2 = arg_19_2:Normalize()

	local var_19_0 = var_0_16.Dot(arg_19_1, arg_19_2)

	if var_19_0 > 0.999999 then
		arg_19_0:Set(0, 0, 0, 1)
	elseif var_19_0 < -0.999999 then
		local var_19_1 = {
			0,
			arg_19_1.z,
			arg_19_1.y
		}
		local var_19_2 = var_19_1[2] * var_19_1[2] + var_19_1[3] * var_19_1[3]

		if var_19_2 < 1e-06 then
			var_19_1[1] = -arg_19_1.z
			var_19_1[2] = 0
			var_19_1[3] = arg_19_1.x
			var_19_2 = var_19_1[1] * var_19_1[1] + var_19_1[3] * var_19_1[3]
		end

		local var_19_3 = 1 / var_0_5(var_19_2)

		var_19_1[1] = var_19_1[1] * var_19_3
		var_19_1[2] = var_19_1[2] * var_19_3
		var_19_1[3] = var_19_1[3] * var_19_3

		local var_19_4 = {
			0,
			0,
			0,
			[1] = var_19_1[2] * arg_19_1.z - var_19_1[3] * arg_19_1.y,
			[2] = var_19_1[3] * arg_19_1.x - var_19_1[1] * arg_19_1.z,
			[3] = var_19_1[1] * arg_19_1.y - var_19_1[2] * arg_19_1.x
		}
		local var_19_5 = -arg_19_1.x * arg_19_1.x
		local var_19_6 = -arg_19_1.y * arg_19_1.y
		local var_19_7 = -arg_19_1.z * arg_19_1.z
		local var_19_8 = -arg_19_1.x * arg_19_1.y
		local var_19_9 = -arg_19_1.x * arg_19_1.z
		local var_19_10 = -arg_19_1.y * arg_19_1.z
		local var_19_11 = var_19_4[1] * var_19_4[1]
		local var_19_12 = var_19_4[2] * var_19_4[2]
		local var_19_13 = var_19_4[3] * var_19_4[3]
		local var_19_14 = var_19_4[1] * var_19_4[2]
		local var_19_15 = var_19_4[1] * var_19_4[3]
		local var_19_16 = var_19_4[2] * var_19_4[3]
		local var_19_17 = -var_19_1[1] * var_19_1[1]
		local var_19_18 = -var_19_1[2] * var_19_1[2]
		local var_19_19 = -var_19_1[3] * var_19_1[3]
		local var_19_20 = -var_19_1[1] * var_19_1[2]
		local var_19_21 = -var_19_1[1] * var_19_1[3]
		local var_19_22 = -var_19_1[2] * var_19_1[3]
		local var_19_23 = {
			{
				var_19_5 + var_19_11 + var_19_17,
				var_19_8 + var_19_14 + var_19_20,
				var_19_9 + var_19_15 + var_19_21
			},
			{
				var_19_8 + var_19_14 + var_19_20,
				var_19_6 + var_19_12 + var_19_18,
				var_19_10 + var_19_16 + var_19_22
			},
			{
				var_19_9 + var_19_15 + var_19_21,
				var_19_10 + var_19_16 + var_19_22,
				var_19_7 + var_19_13 + var_19_19
			}
		}

		var_0_25(var_19_23, arg_19_0)
	else
		local var_19_24 = var_0_16.Cross(arg_19_1, arg_19_2)
		local var_19_25 = (1 - var_19_0) / var_0_16.Dot(var_19_24, var_19_24)
		local var_19_26 = var_19_25 * var_19_24.x
		local var_19_27 = var_19_25 * var_19_24.z
		local var_19_28 = var_19_26 * var_19_24.y
		local var_19_29 = var_19_26 * var_19_24.z
		local var_19_30 = var_19_27 * var_19_24.y
		local var_19_31 = {
			{
				var_19_0 + var_19_26 * var_19_24.x,
				var_19_28 - var_19_24.z,
				var_19_29 + var_19_24.y
			},
			{
				var_19_28 + var_19_24.z,
				var_19_0 + var_19_25 * var_19_24.y * var_19_24.y,
				var_19_30 - var_19_24.x
			},
			{
				var_19_29 - var_19_24.y,
				var_19_30 + var_19_24.x,
				var_19_0 + var_19_27 * var_19_24.z
			}
		}

		var_0_25(var_19_31, arg_19_0)
	end
end

function var_0_22.Inverse(arg_20_0)
	local var_20_0 = var_0_22.New()

	var_20_0.x = -arg_20_0.x
	var_20_0.y = -arg_20_0.y
	var_20_0.z = -arg_20_0.z
	var_20_0.w = arg_20_0.w

	return var_20_0
end

function var_0_22.Lerp(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2 = var_0_10(arg_21_2, 0, 1)

	local var_21_0 = {
		w = 1,
		z = 0,
		x = 0,
		y = 0
	}

	if var_0_22.Dot(arg_21_0, arg_21_1) < 0 then
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

	var_0_22.SetNormalize(var_21_0)
	var_0_12(var_21_0, var_0_22)

	return var_21_0
end

function var_0_22.LookRotation(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:Magnitude()

	if var_22_0 < 1e-06 then
		error("error input forward to Quaternion.LookRotation" .. tostring(arg_22_0))

		return nil
	end

	arg_22_0 = arg_22_0 / var_22_0
	arg_22_1 = arg_22_1 or var_0_20

	local var_22_1 = var_0_16.Cross(arg_22_1, arg_22_0)

	var_22_1:SetNormalize()

	arg_22_1 = var_0_16.Cross(arg_22_0, var_22_1)

	local var_22_2 = var_0_16.Cross(arg_22_1, arg_22_0)
	local var_22_3 = var_22_2.x + arg_22_1.y + arg_22_0.z

	if var_22_3 > 0 then
		local var_22_4
		local var_22_5
		local var_22_6
		local var_22_7
		local var_22_8 = var_22_3 + 1
		local var_22_9 = 0.5 / var_0_5(var_22_8)
		local var_22_10 = var_22_9 * var_22_8
		local var_22_11 = (arg_22_1.z - arg_22_0.y) * var_22_9
		local var_22_12 = (arg_22_0.x - var_22_2.z) * var_22_9
		local var_22_13 = (var_22_2.y - arg_22_1.x) * var_22_9
		local var_22_14 = var_0_24(var_22_11, var_22_12, var_22_13, var_22_10)

		var_22_14:SetNormalize()

		return var_22_14
	else
		local var_22_15 = {
			{
				var_22_2.x,
				arg_22_1.x,
				arg_22_0.x
			},
			{
				var_22_2.y,
				arg_22_1.y,
				arg_22_0.y
			},
			{
				var_22_2.z,
				arg_22_1.z,
				arg_22_0.z
			}
		}
		local var_22_16 = {
			0,
			0,
			0
		}
		local var_22_17 = 1

		if arg_22_1.y > var_22_2.x then
			var_22_17 = 2
		end

		if arg_22_0.z > var_22_15[var_22_17][var_22_17] then
			var_22_17 = 3
		end

		local var_22_18 = var_0_21[var_22_17]
		local var_22_19 = var_0_21[var_22_18]
		local var_22_20 = var_22_15[var_22_17][var_22_17] - var_22_15[var_22_18][var_22_18] - var_22_15[var_22_19][var_22_19] + 1
		local var_22_21 = 0.5 / var_0_5(var_22_20)

		var_22_16[var_22_17] = var_22_21 * var_22_20

		local var_22_22 = (var_22_15[var_22_19][var_22_18] - var_22_15[var_22_18][var_22_19]) * var_22_21

		var_22_16[var_22_18] = (var_22_15[var_22_18][var_22_17] + var_22_15[var_22_17][var_22_18]) * var_22_21
		var_22_16[var_22_19] = (var_22_15[var_22_19][var_22_17] + var_22_15[var_22_17][var_22_19]) * var_22_21

		local var_22_23 = var_0_24(var_22_16[1], var_22_16[2], var_22_16[3], var_22_22)

		var_22_23:SetNormalize()

		return var_22_23
	end
end

function var_0_22.SetIdentity(arg_23_0)
	arg_23_0.x = 0
	arg_23_0.y = 0
	arg_23_0.z = 0
	arg_23_0.w = 1
end

local function var_0_26(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.x * arg_24_1.x + arg_24_0.y * arg_24_1.y + arg_24_0.z * arg_24_1.z + arg_24_0.w * arg_24_1.w

	if var_24_0 < 0 then
		var_24_0 = -var_24_0
		arg_24_1 = var_0_12({
			x = -arg_24_1.x,
			y = -arg_24_1.y,
			z = -arg_24_1.z,
			w = -arg_24_1.w
		}, var_0_22)
	end

	if var_24_0 < 0.95 then
		local var_24_1 = var_0_3(var_24_0)
		local var_24_2 = 1 / var_0_1(var_24_1)
		local var_24_3 = var_0_1((1 - arg_24_2) * var_24_1) * var_24_2
		local var_24_4 = var_0_1(arg_24_2 * var_24_1) * var_24_2

		arg_24_0 = {
			x = arg_24_0.x * var_24_3 + arg_24_1.x * var_24_4,
			y = arg_24_0.y * var_24_3 + arg_24_1.y * var_24_4,
			z = arg_24_0.z * var_24_3 + arg_24_1.z * var_24_4,
			w = arg_24_0.w * var_24_3 + arg_24_1.w * var_24_4
		}

		var_0_12(arg_24_0, var_0_22)

		return arg_24_0
	else
		arg_24_0 = {
			x = arg_24_0.x + arg_24_2 * (arg_24_1.x - arg_24_0.x),
			y = arg_24_0.y + arg_24_2 * (arg_24_1.y - arg_24_0.y),
			z = arg_24_0.z + arg_24_2 * (arg_24_1.z - arg_24_0.z),
			w = arg_24_0.w + arg_24_2 * (arg_24_1.w - arg_24_0.w)
		}

		var_0_22.SetNormalize(arg_24_0)
		var_0_12(arg_24_0, var_0_22)

		return arg_24_0
	end
end

function var_0_22.Slerp(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 < 0 then
		arg_25_2 = 0
	elseif arg_25_2 > 1 then
		arg_25_2 = 1
	end

	return var_0_26(arg_25_0, arg_25_1, arg_25_2)
end

function var_0_22.RotateTowards(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = var_0_22.Angle(arg_26_0, arg_26_1)

	if var_26_0 == 0 then
		return arg_26_1
	end

	local var_26_1 = var_0_6(1, arg_26_2 / var_26_0)

	return var_0_26(arg_26_0, arg_26_1, var_26_1)
end

local function var_0_27(arg_27_0, arg_27_1)
	return var_0_11(arg_27_0 - arg_27_1) < 1e-06
end

function var_0_22.ToAngleAxis(arg_28_0)
	local var_28_0 = 2 * var_0_3(arg_28_0.w)

	if var_0_27(var_28_0, 0) then
		return var_28_0 * 57.29578, var_0_16.New(1, 0, 0)
	end

	local var_28_1 = 1 / var_0_5(1 - var_0_5(arg_28_0.w))

	return var_28_0 * 57.29578, var_0_16.New(arg_28_0.x * var_28_1, arg_28_0.y * var_28_1, arg_28_0.z * var_28_1)
end

local var_0_28 = Mathf.PI
local var_0_29 = var_0_28 * 0.5
local var_0_30 = 2 * var_0_28
local var_0_31 = -0.0001
local var_0_32 = var_0_30 - 0.0001

local function var_0_33(arg_29_0)
	if arg_29_0.x < var_0_31 then
		arg_29_0.x = arg_29_0.x + var_0_30
	elseif arg_29_0.x > var_0_32 then
		arg_29_0.x = arg_29_0.x - var_0_30
	end

	if arg_29_0.y < var_0_31 then
		arg_29_0.y = arg_29_0.y + var_0_30
	elseif arg_29_0.y > var_0_32 then
		arg_29_0.y = arg_29_0.y - var_0_30
	end

	if arg_29_0.z < var_0_31 then
		arg_29_0.z = arg_29_0.z + var_0_30
	elseif arg_29_0.z > var_0_32 then
		arg_29_0.z = arg_29_0.z + var_0_30
	end
end

function var_0_22.ToEulerAngles(arg_30_0)
	local var_30_0 = arg_30_0.x
	local var_30_1 = arg_30_0.y
	local var_30_2 = arg_30_0.z
	local var_30_3 = arg_30_0.w
	local var_30_4 = 2 * (var_30_1 * var_30_2 - var_30_3 * var_30_0)

	if var_30_4 < 0.999 then
		if var_30_4 > -0.999 then
			local var_30_5 = var_0_16.New(-var_0_4(var_30_4), var_0_9(2 * (var_30_0 * var_30_2 + var_30_3 * var_30_1), 1 - 2 * (var_30_0 * var_30_0 + var_30_1 * var_30_1)), var_0_9(2 * (var_30_0 * var_30_1 + var_30_3 * var_30_2), 1 - 2 * (var_30_0 * var_30_0 + var_30_2 * var_30_2)))

			var_0_33(var_30_5)
			var_30_5:Mul(var_0_17)

			return var_30_5
		else
			local var_30_6 = var_0_16.New(var_0_29, var_0_9(2 * (var_30_0 * var_30_1 - var_30_3 * var_30_2), 1 - 2 * (var_30_1 * var_30_1 + var_30_2 * var_30_2)), 0)

			var_0_33(var_30_6)
			var_30_6:Mul(var_0_17)

			return var_30_6
		end
	else
		local var_30_7 = var_0_16.New(-var_0_29, var_0_9(-2 * (var_30_0 * var_30_1 - var_30_3 * var_30_2), 1 - 2 * (var_30_1 * var_30_1 + var_30_2 * var_30_2)), 0)

		var_0_33(var_30_7)
		var_30_7:Mul(var_0_17)

		return var_30_7
	end
end

function var_0_22.Forward(arg_31_0)
	return arg_31_0:MulVec3(var_0_19)
end

function var_0_22.MulVec3(arg_32_0, arg_32_1)
	local var_32_0 = var_0_16.New()
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

function var_0_22.__mul(arg_33_0, arg_33_1)
	if var_0_22 == var_0_13(arg_33_1) then
		return var_0_22.New(arg_33_0.w * arg_33_1.x + arg_33_0.x * arg_33_1.w + arg_33_0.y * arg_33_1.z - arg_33_0.z * arg_33_1.y, arg_33_0.w * arg_33_1.y + arg_33_0.y * arg_33_1.w + arg_33_0.z * arg_33_1.x - arg_33_0.x * arg_33_1.z, arg_33_0.w * arg_33_1.z + arg_33_0.z * arg_33_1.w + arg_33_0.x * arg_33_1.y - arg_33_0.y * arg_33_1.x, arg_33_0.w * arg_33_1.w - arg_33_0.x * arg_33_1.x - arg_33_0.y * arg_33_1.y - arg_33_0.z * arg_33_1.z)
	elseif var_0_16 == var_0_13(arg_33_1) then
		return arg_33_0:MulVec3(arg_33_1)
	end
end

function var_0_22.__unm(arg_34_0)
	return var_0_22.New(-arg_34_0.x, -arg_34_0.y, -arg_34_0.z, -arg_34_0.w)
end

function var_0_22.__eq(arg_35_0, arg_35_1)
	return var_0_22.Dot(arg_35_0, arg_35_1) > 0.999999
end

function var_0_22.__tostring(arg_36_0)
	return "[" .. arg_36_0.x .. "," .. arg_36_0.y .. "," .. arg_36_0.z .. "," .. arg_36_0.w .. "]"
end

function var_0_23.identity()
	return var_0_24(0, 0, 0, 1)
end

var_0_23.eulerAngles = var_0_22.ToEulerAngles
UnityEngine.Quaternion = var_0_22

var_0_12(var_0_22, var_0_22)

return var_0_22
