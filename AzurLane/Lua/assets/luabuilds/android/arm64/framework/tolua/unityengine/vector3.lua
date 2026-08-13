math = var_0_10000

local var_0_0 = var_0_10000.acos
local var_0_1 = var_0_10000.sqrt
local var_0_2 = var_0_10000.max
local var_0_3 = var_0_10000.min

Mathf = var_0_10005

local var_0_4 = var_0_10005.Clamp
local var_0_5 = var_0_10000.cos
local var_0_6 = var_0_10000.sin
local var_0_7 = var_0_10000.abs

Mathf = var_0_10009

local var_0_8 = var_0_10009.Sign

setmetatable = var_0_10010
rawset = var_0_10011
rawget = var_0_10012
type = var_0_10013

local var_0_9 = 57.295779513082
local var_0_10 = 0.017453292519943
local var_0_11 = {}

tolua = var_0_10017

local var_0_12 = var_0_10017.initget(var_0_11)

function var_0_11.__index(arg_1_0, arg_1_1)
	if var_0_10012(var_0_11, arg_1_1) == nil and var_0_10012(var_0_12, arg_1_1) ~= nil then
		return var_2(arg_1_0)
	end

	return var_2
end

function var_0_11.New(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {
		x = arg_2_0 or 0,
		y = arg_2_1 or 0,
		z = arg_2_2 or 0
	}

	var_0_10010(var_2_0, var_0_11)

	return var_2_0
end

local var_0_13 = var_0_11.New

function var_0_11.__call(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		x = arg_3_1 or 0,
		y = arg_3_2 or 0,
		z = arg_3_3 or 0
	}

	var_0_10010(var_3_0, var_0_11)

	return var_3_0
end

function var_0_11.Set(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.x = arg_4_1 or 0
	arg_4_0.y = arg_4_2 or 0
	arg_4_0.z = arg_4_3 or 0

	return
end

function var_0_11.Get(arg_5_0)
	return arg_5_0.x, arg_5_0.y, arg_5_0.z
end

function var_0_11.Clone(arg_6_0)
	return var_0_10010({
		x = arg_6_0.x,
		y = arg_6_0.y,
		z = arg_6_0.z
	}, var_0_11)
end

function var_0_11.Copy(arg_7_0, arg_7_1)
	arg_7_0.x = arg_7_1.x
	arg_7_0.y = arg_7_1.y
	arg_7_0.z = arg_7_1.z

	return arg_7_0
end

function var_0_11.Copy2(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_1.x = arg_8_0.x
		arg_8_1.y = arg_8_0.y
		arg_8_1.z = arg_8_0.z

		return arg_8_1
	else
		return var_0_13(arg_8_0.x, arg_8_0.y, arg_8_0.z)
	end

	return
end

function var_0_11.Distance(arg_9_0, arg_9_1)
	return var_0_1((arg_9_0.x - arg_9_1.x)^2 + (arg_9_0.y - arg_9_1.y)^2 + (arg_9_0.z - arg_9_1.z)^2)
end

function var_0_11.BattleDistance(arg_10_0, arg_10_1)
	return var_0_1((arg_10_0.x - arg_10_1.x)^2 + (arg_10_0.z - arg_10_1.z)^2)
end

function var_0_11.SqrDistance(arg_11_0, arg_11_1)
	return (arg_11_0.x - arg_11_1.x)^2 + (arg_11_0.y - arg_11_1.y)^2 + (arg_11_0.z - arg_11_1.z)^2
end

function var_0_11.Dot(arg_12_0, arg_12_1)
	return arg_12_0.x * arg_12_1.x + arg_12_0.y * arg_12_1.y + arg_12_0.z * arg_12_1.z
end

function var_0_11.Lerp(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2 = var_0_4(arg_13_2, 0, 1)

	return var_0_13(arg_13_0.x + (arg_13_1.x - arg_13_0.x) * arg_13_2, arg_13_0.y + (arg_13_1.y - arg_13_0.y) * arg_13_2, arg_13_0.z + (arg_13_1.z - arg_13_0.z) * arg_13_2)
end

function var_0_11.Magnitude(arg_14_0)
	return var_0_1(arg_14_0.x * arg_14_0.x + arg_14_0.y * arg_14_0.y + arg_14_0.z * arg_14_0.z)
end

function var_0_11.Max(arg_15_0, arg_15_1)
	return var_0_13(var_0_2(arg_15_0.x, arg_15_1.x), var_0_2(arg_15_0.y, arg_15_1.y), var_0_2(arg_15_0.z, arg_15_1.z))
end

function var_0_11.Min(arg_16_0, arg_16_1)
	return var_0_13(var_0_3(arg_16_0.x, arg_16_1.x), var_0_3(arg_16_0.y, arg_16_1.y), var_0_3(arg_16_0.z, arg_16_1.z))
end

function var_0_11.Normalize(arg_17_0)
	local var_17_0 = arg_17_0.x
	local var_17_1 = arg_17_0.y
	local var_17_2 = arg_17_0.z

	if var_0_1(var_17_0 * var_17_0 + var_17_1 * var_17_1 + var_17_2 * var_17_2) > 1e-05 then
		return var_0_10010({
			x = var_17_0 / var_4,
			y = var_17_1 / var_4,
			z = var_17_2 / var_4
		}, var_0_11)
	end

	return var_0_10010({
		z = 0,
		x = 0,
		y = 0
	}, var_0_11)
end

function var_0_11.SetNormalize(arg_18_0)
	if var_0_1(arg_18_0.x * arg_18_0.x + arg_18_0.y * arg_18_0.y + arg_18_0.z * arg_18_0.z) > 1e-05 then
		arg_18_0.x = arg_18_0.x / var_1
		arg_18_0.y = arg_18_0.y / var_1
		arg_18_0.z = arg_18_0.z / var_1
	else
		arg_18_0.x = 0
		arg_18_0.y = 0
		arg_18_0.z = 0
	end

	return arg_18_0
end

function var_0_11.SqrMagnitude(arg_19_0)
	return arg_19_0.x * arg_19_0.x + arg_19_0.y * arg_19_0.y + arg_19_0.z * arg_19_0.z
end

local var_0_14 = var_0_11.Dot

function var_0_11.Angle(arg_20_0, arg_20_1)
	return var_0_0(var_0_4(var_0_14(arg_20_0:Normalize(), arg_20_1:Normalize()), -1, 1)) * var_0_9
end

function var_0_11.ClampMagnitude(arg_21_0, arg_21_1)
	if arg_21_0:SqrMagnitude() > arg_21_1 * arg_21_1 then
		arg_21_0:SetNormalize()
		arg_21_0:Mul(arg_21_1)
	end

	return arg_21_0
end

function var_0_11.OrthoNormalize(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:SetNormalize()
	arg_22_1:Sub(arg_22_1:Project(arg_22_0))
	arg_22_1:SetNormalize()

	if arg_22_2 == nil then
		return arg_22_0, arg_22_1
	end

	arg_22_2:Sub(arg_22_2:Project(arg_22_0))
	arg_22_2:Sub(arg_22_2:Project(arg_22_1))
	arg_22_2:SetNormalize()

	return arg_22_0, arg_22_1, arg_22_2
end

function var_0_11.MoveTowards(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1 - arg_23_0

	if var_3.SqrMagnitude(var_23_0) > arg_23_2 * arg_23_2 then
		if var_0_1(var_4) > 1e-06 then
			var_3:Mul(arg_23_2 / var_6)
			var_3:Add(arg_23_0)

			return var_3
		else
			return arg_23_0:Clone()
		end
	end

	return arg_23_1:Clone()
end

local function var_0_15(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 - arg_24_0 > 0 then
		return arg_24_0 + var_0_3(var_3, arg_24_2)
	else
		return arg_24_0 - var_0_3(-var_3, arg_24_2)
	end

	return
end

local var_0_16 = ClampedMove
local var_0_17 = 0.7071067811865476

local function var_0_18(arg_25_0)
	local var_25_0 = var_0_13()

	if var_0_7(arg_25_0.z) > var_0_17 then
		local var_25_1 = arg_25_0.y * arg_25_0.y + arg_25_0.z * arg_25_0.z
		local var_25_2 = 1 / var_0_1(var_25_1)

		var_25_0.x = 0
		var_25_0.y = -arg_25_0.z * var_25_2
		var_25_0.z = arg_25_0.y * var_25_2
	else
		local var_25_3 = arg_25_0.x * arg_25_0.x + arg_25_0.y * arg_25_0.y
		local var_25_4 = 1 / var_0_1(var_25_3)

		var_25_0.x = -arg_25_0.y * var_25_4
		var_25_0.y = arg_25_0.x * var_25_4
		var_25_0.z = 0
	end

	return var_25_0
end

function var_0_11.RotateTowards(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0:Magnitude()
	local var_26_1 = arg_26_1:Magnitude()

	if var_26_0 > 1e-06 and var_26_1 > 1e-06 then
		local var_26_2 = arg_26_0 / var_26_0
		local var_26_3 = arg_26_1 / var_26_1

		if var_0_14(var_26_2, var_26_3) > 0.999999 then
			return var_0_11.MoveTowards(arg_26_0, arg_26_1, arg_26_3)
		elseif var_8 < -0.999999 then
			local var_26_4 = var_0_18(var_26_2)

			Quaternion = var_10

			local var_26_5 = var_10.AngleAxis(arg_26_2 * var_0_9, var_26_4)
			local var_26_6 = var_10.MulVec3(var_26_5, var_26_2)

			ClampedMove = var_12

			local var_26_7 = var_12(var_26_0, var_26_1, arg_26_3)

			var_26_6:Mul(var_26_7)

			return var_26_6
		else
			local var_26_8 = var_0_0(var_8)
			local var_26_9 = var_0_11.Cross(var_26_2, var_26_3)

			var_10.SetNormalize(var_26_9)

			Quaternion = var_11

			local var_26_10 = var_11.AngleAxis(var_0_3(arg_26_2, var_26_8) * var_0_9, var_10)
			local var_26_11 = var_11.MulVec3(var_26_10, var_26_2)

			ClampedMove = var_13

			local var_26_12 = var_13(var_26_0, var_26_1, arg_26_3)

			var_26_11:Mul(var_26_12)

			return var_26_11
		end
	end

	return var_0_11.MoveTowards(arg_26_0, arg_26_1, arg_26_3)
end

function var_0_11.SmoothDamp(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	Mathf = var_1_10004

	local var_27_0 = var_1_10004.Infinity

	Time = var_1_10005

	local var_27_1 = var_1_10005.deltaTime
	local var_27_2 = 1 / (1 + 2 / var_0_2(0.0001, arg_27_3) * var_27_1 + 0.48 * var_7 * var_7 + 0.235 * var_7 * var_7 * var_7)
	local var_27_3 = arg_27_1:Clone()
	local var_27_4 = var_27_0 * arg_27_3
	local var_27_5 = arg_27_0 - arg_27_1

	var_11.ClampMagnitude(var_27_5, var_27_4)

	arg_27_1 = arg_27_0 - var_11
	arg_27_2 = (arg_27_2 - (arg_27_2 + var_11 * var_6) * var_27_1 * var_6) * var_27_2

	local var_27_6 = arg_27_1 + (var_11 + var_12) * var_27_2

	if var_0_11.Dot(var_27_3 - arg_27_0, var_27_6 - var_27_3) > 0 then
		var_27_6 = var_27_3

		arg_27_2:Set(0, 0, 0)
	end

	return var_27_6, arg_27_2
end

function var_0_11.Scale(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.x * arg_28_1.x
	local var_28_1 = arg_28_0.y * arg_28_1.y
	local var_28_2 = arg_28_0.z * arg_28_1.z

	return var_0_13(var_28_0, var_28_1, var_28_2)
end

function var_0_11.Cross2(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.y * arg_29_1.z - var_2.z * arg_29_1.y
	local var_29_1 = var_2.z * arg_29_1.x - var_2.x * arg_29_1.z
	local var_29_2 = var_2.x * arg_29_1.y - var_2.y * arg_29_1.x

	arg_29_0.x, arg_29_0.y, arg_29_0.z = var_29_0, var_29_1, var_29_2

	return arg_29_0
end

function var_0_11.Cross(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.y * arg_30_1.z - arg_30_0.z * arg_30_1.y
	local var_30_1 = arg_30_0.z * arg_30_1.x - arg_30_0.x * arg_30_1.z
	local var_30_2 = arg_30_0.x * arg_30_1.y - arg_30_0.y * arg_30_1.x

	return var_0_13(var_30_0, var_30_1, var_30_2)
end

function var_0_11.Equals(arg_31_0, arg_31_1)
	return arg_31_0.x == arg_31_1.x and arg_31_0.y == arg_31_1.y and arg_31_0.z == arg_31_1.z
end

function var_0_11.EqualZero(arg_32_0)
	return arg_32_0.x * arg_32_0.x + arg_32_0.y * arg_32_0.y + arg_32_0.z * arg_32_0.z < 1e-10
end

function var_0_11.Reflect(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1 * (-2 * var_0_14(arg_33_1, arg_33_0))

	arg_33_1.Add(var_33_0, arg_33_0)

	return arg_33_1
end

function var_0_11.Project(arg_34_0, arg_34_1)
	if arg_34_1:SqrMagnitude() < 1.175494e-38 then
		return var_0_13(0, 0, 0)
	end

	local var_34_0 = var_0_14(arg_34_0, arg_34_1)
	local var_34_1 = arg_34_1:Clone()

	var_4.Mul(var_34_1, var_34_0 / var_2)

	return var_4
end

function var_0_11.ProjectOnPlane(arg_35_0, arg_35_1)
	local var_35_0 = var_0_11.Project(arg_35_0, arg_35_1)

	var_2.Mul(var_35_0, -1)
	var_2:Add(arg_35_0)

	return var_2
end

function var_0_11.Slerp(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0
	local var_36_1
	local var_36_2
	local var_36_3

	if arg_36_2 <= 0 then
		return arg_36_0:Clone()
	elseif arg_36_2 >= 1 then
		return arg_36_1:Clone()
	end

	local var_36_4 = arg_36_1:Clone()
	local var_36_5 = arg_36_0:Clone()
	local var_36_6 = arg_36_1:Magnitude()
	local var_36_7 = arg_36_0:Magnitude()

	var_36_4:Div(var_36_6)
	var_36_5:Div(var_36_7)

	local var_36_8 = (var_36_6 - var_36_7) * arg_36_2 + var_36_7

	if var_36_5.x * var_36_4.x + var_36_5.y * var_36_4.y + var_36_5.z * var_36_4.z > 0.999999 then
		var_36_2 = 1 - arg_36_2
		var_36_3 = arg_36_2
	elseif var_12 < -0.999999 then
		local var_36_9 = var_0_18(arg_36_0)

		Quaternion = var_14

		local var_36_10 = var_14.AngleAxis(180 * arg_36_2, var_36_9)
		local var_36_11 = var_14.MulVec3(var_36_10, arg_36_0)

		var_15.Mul(var_36_11, var_36_8)

		return var_15
	else
		local var_36_12 = var_0_0(var_12)
		local var_36_13 = var_0_6(var_36_12)

		var_36_2 = var_0_6((1 - arg_36_2) * var_36_12) / var_36_13
		var_36_3 = var_0_6(arg_36_2 * var_36_12) / var_36_13
	end

	var_36_5:Mul(var_36_2)
	var_36_4:Mul(var_36_3)
	var_36_4:Add(var_36_5)
	var_36_4:Mul(var_36_8)

	return var_36_4
end

function var_0_11.Mul(arg_37_0, arg_37_1)
	if var_0_10013(arg_37_1) == "number" then
		arg_37_0.x = arg_37_0.x * arg_37_1
		arg_37_0.y = arg_37_0.y * arg_37_1
		arg_37_0.z = arg_37_0.z * arg_37_1
	else
		arg_37_0:MulQuat(arg_37_1)
	end

	return arg_37_0
end

function var_0_11.Div(arg_38_0, arg_38_1)
	arg_38_0.x = arg_38_0.x / arg_38_1
	arg_38_0.y = arg_38_0.y / arg_38_1
	arg_38_0.z = arg_38_0.z / arg_38_1

	return arg_38_0
end

function var_0_11.Add(arg_39_0, arg_39_1)
	arg_39_0.x = arg_39_0.x + arg_39_1.x
	arg_39_0.y = arg_39_0.y + arg_39_1.y
	arg_39_0.z = arg_39_0.z + arg_39_1.z

	return arg_39_0
end

function var_0_11.Sub(arg_40_0, arg_40_1)
	arg_40_0.x = arg_40_0.x - arg_40_1.x
	arg_40_0.y = arg_40_0.y - arg_40_1.y
	arg_40_0.z = arg_40_0.z - arg_40_1.z

	return arg_40_0
end

function var_0_11.MulQuat(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1.x * 2
	local var_41_1 = arg_41_1.y * 2
	local var_41_2 = arg_41_1.z * 2
	local var_41_3 = arg_41_1.x * var_41_0
	local var_41_4 = arg_41_1.y * var_41_1
	local var_41_5 = arg_41_1.z * var_41_2
	local var_41_6 = arg_41_1.x * var_41_1
	local var_41_7 = arg_41_1.x * var_41_2
	local var_41_8 = arg_41_1.y * var_41_2
	local var_41_9 = arg_41_1.w * var_41_0
	local var_41_10 = arg_41_1.w * var_41_1
	local var_41_11 = arg_41_1.w * var_41_2
	local var_41_12 = (1 - (var_41_4 + var_41_5)) * arg_41_0.x + (var_41_6 - var_41_11) * arg_41_0.y + (var_41_7 + var_41_10) * arg_41_0.z
	local var_41_13 = (var_41_6 + var_41_11) * arg_41_0.x + (1 - (var_41_3 + var_41_5)) * arg_41_0.y + (var_41_8 - var_41_9) * arg_41_0.z
	local var_41_14 = (var_41_7 - var_41_10) * arg_41_0.x + (var_41_8 + var_41_9) * arg_41_0.y + (1 - (var_41_3 + var_41_4)) * arg_41_0.z

	arg_41_0:Set(var_41_12, var_41_13, var_41_14)

	return arg_41_0
end

function var_0_11.AngleAroundAxis(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0 = arg_42_0 - var_0_11.Project(arg_42_0, arg_42_2)
	arg_42_1 = arg_42_1 - var_0_11.Project(arg_42_1, arg_42_2)

	return var_0_11.Angle(arg_42_0, arg_42_1) * (var_0_11.Dot(arg_42_2, var_0_11.Cross(arg_42_0, arg_42_1)) < 0 and -1 or 1)
end

function var_0_11.__tostring(arg_43_0)
	return "[" .. arg_43_0.x .. "," .. arg_43_0.y .. "," .. arg_43_0.z .. "]"
end

function var_0_11.__div(arg_44_0, arg_44_1)
	return var_0_13(arg_44_0.x / arg_44_1, arg_44_0.y / arg_44_1, arg_44_0.z / arg_44_1)
end

function var_0_11.__mul(arg_45_0, arg_45_1)
	if var_0_10013(arg_45_1) == "number" then
		return var_0_13(arg_45_0.x * arg_45_1, arg_45_0.y * arg_45_1, arg_45_0.z * arg_45_1)
	else
		local var_45_0 = arg_45_0:Clone()

		var_2.MulQuat(var_45_0, arg_45_1)

		return var_2
	end

	return
end

function var_0_11.__add(arg_46_0, arg_46_1)
	return var_0_13(arg_46_0.x + arg_46_1.x, arg_46_0.y + arg_46_1.y, arg_46_0.z + arg_46_1.z)
end

function var_0_11.__sub(arg_47_0, arg_47_1)
	return var_0_13(arg_47_0.x - arg_47_1.x, arg_47_0.y - arg_47_1.y, arg_47_0.z - arg_47_1.z)
end

function var_0_11.__unm(arg_48_0)
	return var_0_13(-arg_48_0.x, -arg_48_0.y, -arg_48_0.z)
end

function var_0_11.__eq(arg_49_0, arg_49_1)
	return (arg_49_0.x - arg_49_1.x) * (arg_49_0.x - arg_49_1.x) + (arg_49_0.y - arg_49_1.y) * (arg_49_0.y - arg_49_1.y) + (arg_49_0.z - arg_49_1.z) * (arg_49_0.z - arg_49_1.z) < 1e-10
end

function var_0_12.up()
	return var_0_13(0, 1, 0)
end

function var_0_12.down()
	return var_0_13(0, -1, 0)
end

function var_0_12.right()
	return var_0_13(1, 0, 0)
end

function var_0_12.left()
	return var_0_13(-1, 0, 0)
end

function var_0_12.forward()
	return var_0_13(0, 0, 1)
end

function var_0_12.back()
	return var_0_13(0, 0, -1)
end

function var_0_12.zero()
	return var_0_13(0, 0, 0)
end

function var_0_12.one()
	return var_0_13(1, 1, 1)
end

var_0_12.magnitude = var_0_11.Magnitude
var_0_12.normalized = var_0_11.Normalize
var_0_12.sqrMagnitude = var_0_11.SqrMagnitude
UnityEngine = var_22
var_22.Vector3 = var_0_11

var_0_10010(var_0_11, var_0_11)

return var_0_11
