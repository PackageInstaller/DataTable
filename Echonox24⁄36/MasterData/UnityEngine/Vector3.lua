local var_0_0 = math
local var_0_1 = var_0_0.acos
local var_0_2 = var_0_0.sqrt
local var_0_3 = var_0_0.max
local var_0_4 = var_0_0.min
local var_0_5 = Mathf.Clamp
local var_0_6 = var_0_0.cos
local var_0_7 = var_0_0.sin
local var_0_8 = var_0_0.abs
local var_0_9 = Mathf.Sign
local var_0_10 = setmetatable
local var_0_11 = rawset
local var_0_12 = rawget
local var_0_13 = type
local var_0_14 = 57.295779513082
local var_0_15 = 0.017453292519943
local var_0_16 = {}
local var_0_17 = tolua.initget(var_0_16)

function var_0_16.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_12(var_0_16, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_12(var_0_17, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_16.New(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {
		x = arg_2_0 or 0,
		y = arg_2_1 or 0,
		z = arg_2_2 or 0
	}

	var_0_10(var_2_0, var_0_16)

	return var_2_0
end

local var_0_18 = var_0_16.New

function var_0_16.__call(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		x = arg_3_1 or 0,
		y = arg_3_2 or 0,
		z = arg_3_3 or 0
	}

	var_0_10(var_3_0, var_0_16)

	return var_3_0
end

function var_0_16.Set(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.x = arg_4_1 or 0
	arg_4_0.y = arg_4_2 or 0
	arg_4_0.z = arg_4_3 or 0
end

function var_0_16.Get(arg_5_0)
	return arg_5_0.x, arg_5_0.y, arg_5_0.z
end

function var_0_16.Clone(arg_6_0)
	return var_0_10({
		x = arg_6_0.x,
		y = arg_6_0.y,
		z = arg_6_0.z
	}, var_0_16)
end

function var_0_16.Distance(arg_7_0, arg_7_1)
	return var_0_2((arg_7_0.x - arg_7_1.x)^2 + (arg_7_0.y - arg_7_1.y)^2 + (arg_7_0.z - arg_7_1.z)^2)
end

function var_0_16.Dot(arg_8_0, arg_8_1)
	return arg_8_0.x * arg_8_1.x + arg_8_0.y * arg_8_1.y + arg_8_0.z * arg_8_1.z
end

function var_0_16.Lerp(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = var_0_5(arg_9_2, 0, 1)

	return var_0_18(arg_9_0.x + (arg_9_1.x - arg_9_0.x) * arg_9_2, arg_9_0.y + (arg_9_1.y - arg_9_0.y) * arg_9_2, arg_9_0.z + (arg_9_1.z - arg_9_0.z) * arg_9_2)
end

function var_0_16.Magnitude(arg_10_0)
	return var_0_2(arg_10_0.x * arg_10_0.x + arg_10_0.y * arg_10_0.y + arg_10_0.z * arg_10_0.z)
end

function var_0_16.Max(arg_11_0, arg_11_1)
	return var_0_18(var_0_3(arg_11_0.x, arg_11_1.x), var_0_3(arg_11_0.y, arg_11_1.y), var_0_3(arg_11_0.z, arg_11_1.z))
end

function var_0_16.Min(arg_12_0, arg_12_1)
	return var_0_18(var_0_4(arg_12_0.x, arg_12_1.x), var_0_4(arg_12_0.y, arg_12_1.y), var_0_4(arg_12_0.z, arg_12_1.z))
end

function var_0_16.Normalize(arg_13_0)
	local var_13_0 = arg_13_0.x
	local var_13_1 = arg_13_0.y
	local var_13_2 = arg_13_0.z
	local var_13_3 = var_0_2(var_13_0 * var_13_0 + var_13_1 * var_13_1 + var_13_2 * var_13_2)

	if var_13_3 > 1e-05 then
		return var_0_10({
			x = var_13_0 / var_13_3,
			y = var_13_1 / var_13_3,
			z = var_13_2 / var_13_3
		}, var_0_16)
	end

	return var_0_10({
		z = 0,
		x = 0,
		y = 0
	}, var_0_16)
end

function var_0_16.SetNormalize(arg_14_0)
	local var_14_0 = var_0_2(arg_14_0.x * arg_14_0.x + arg_14_0.y * arg_14_0.y + arg_14_0.z * arg_14_0.z)

	if var_14_0 > 1e-05 then
		arg_14_0.x = arg_14_0.x / var_14_0
		arg_14_0.y = arg_14_0.y / var_14_0
		arg_14_0.z = arg_14_0.z / var_14_0
	else
		arg_14_0.x = 0
		arg_14_0.y = 0
		arg_14_0.z = 0
	end

	return arg_14_0
end

function var_0_16.SqrMagnitude(arg_15_0)
	return arg_15_0.x * arg_15_0.x + arg_15_0.y * arg_15_0.y + arg_15_0.z * arg_15_0.z
end

local var_0_19 = var_0_16.Dot

function var_0_16.Angle(arg_16_0, arg_16_1)
	return var_0_1(var_0_5(var_0_19(arg_16_0:Normalize(), arg_16_1:Normalize()), -1, 1)) * var_0_14
end

function var_0_16.ClampMagnitude(arg_17_0, arg_17_1)
	if arg_17_0:SqrMagnitude() > arg_17_1 * arg_17_1 then
		arg_17_0:SetNormalize()
		arg_17_0:Mul(arg_17_1)
	end

	return arg_17_0
end

function var_0_16.OrthoNormalize(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:SetNormalize()
	arg_18_1:Sub(arg_18_1:Project(arg_18_0))
	arg_18_1:SetNormalize()

	if arg_18_2 == nil then
		return arg_18_0, arg_18_1
	end

	arg_18_2:Sub(arg_18_2:Project(arg_18_0))
	arg_18_2:Sub(arg_18_2:Project(arg_18_1))
	arg_18_2:SetNormalize()

	return arg_18_0, arg_18_1, arg_18_2
end

function var_0_16.MoveTowards(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1 - arg_19_0
	local var_19_1 = var_19_0:SqrMagnitude()

	if var_19_1 > arg_19_2 * arg_19_2 then
		local var_19_2 = var_0_2(var_19_1)

		if var_19_2 > 1e-06 then
			var_19_0:Mul(arg_19_2 / var_19_2)
			var_19_0:Add(arg_19_0)

			return var_19_0
		else
			return arg_19_0:Clone()
		end
	end

	return arg_19_1:Clone()
end

function ClampedMove(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1 - arg_20_0

	if var_20_0 > 0 then
		return arg_20_0 + var_0_4(var_20_0, arg_20_2)
	else
		return arg_20_0 - var_0_4(-var_20_0, arg_20_2)
	end
end

local var_0_20 = 0.7071067811865476

local function var_0_21(arg_21_0)
	local var_21_0 = var_0_18()

	if var_0_8(arg_21_0.z) > var_0_20 then
		local var_21_1 = arg_21_0.y * arg_21_0.y + arg_21_0.z * arg_21_0.z
		local var_21_2 = 1 / var_0_2(var_21_1)

		var_21_0.x = 0
		var_21_0.y = -arg_21_0.z * var_21_2
		var_21_0.z = arg_21_0.y * var_21_2
	else
		local var_21_3 = arg_21_0.x * arg_21_0.x + arg_21_0.y * arg_21_0.y
		local var_21_4 = 1 / var_0_2(var_21_3)

		var_21_0.x = -arg_21_0.y * var_21_4
		var_21_0.y = arg_21_0.x * var_21_4
		var_21_0.z = 0
	end

	return var_21_0
end

function var_0_16.RotateTowards(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0:Magnitude()
	local var_22_1 = arg_22_1:Magnitude()

	if var_22_0 > 1e-06 and var_22_1 > 1e-06 then
		local var_22_2 = arg_22_0 / var_22_0
		local var_22_3 = arg_22_1 / var_22_1
		local var_22_4 = var_0_19(var_22_2, var_22_3)

		if var_22_4 > 0.999999 then
			return var_0_16.MoveTowards(arg_22_0, arg_22_1, arg_22_3)
		elseif var_22_4 < -0.999999 then
			local var_22_5 = var_0_21(var_22_2)
			local var_22_6 = Quaternion.AngleAxis(arg_22_2 * var_0_14, var_22_5):MulVec3(var_22_2)
			local var_22_7 = ClampedMove(var_22_0, var_22_1, arg_22_3)

			var_22_6:Mul(var_22_7)

			return var_22_6
		else
			local var_22_8 = var_0_1(var_22_4)
			local var_22_9 = var_0_16.Cross(var_22_2, var_22_3)

			var_22_9:SetNormalize()

			local var_22_10 = Quaternion.AngleAxis(var_0_4(arg_22_2, var_22_8) * var_0_14, var_22_9):MulVec3(var_22_2)
			local var_22_11 = ClampedMove(var_22_0, var_22_1, arg_22_3)

			var_22_10:Mul(var_22_11)

			return var_22_10
		end
	end

	return var_0_16.MoveTowards(arg_22_0, arg_22_1, arg_22_3)
end

function var_0_16.SmoothDamp(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = Mathf.Infinity
	local var_23_1 = Time.deltaTime

	arg_23_3 = var_0_3(0.0001, arg_23_3)

	local var_23_2 = 2 / arg_23_3
	local var_23_3 = var_23_2 * var_23_1
	local var_23_4 = 1 / (1 + var_23_3 + 0.48 * var_23_3 * var_23_3 + 0.235 * var_23_3 * var_23_3 * var_23_3)
	local var_23_5 = arg_23_1:Clone()
	local var_23_6 = var_23_0 * arg_23_3
	local var_23_7 = arg_23_0 - arg_23_1

	var_23_7:ClampMagnitude(var_23_6)

	arg_23_1 = arg_23_0 - var_23_7

	local var_23_8 = (arg_23_2 + var_23_7 * var_23_2) * var_23_1

	arg_23_2 = (arg_23_2 - var_23_8 * var_23_2) * var_23_4

	local var_23_9 = arg_23_1 + (var_23_7 + var_23_8) * var_23_4

	if var_0_16.Dot(var_23_5 - arg_23_0, var_23_9 - var_23_5) > 0 then
		var_23_9 = var_23_5

		arg_23_2:Set(0, 0, 0)
	end

	return var_23_9, arg_23_2
end

function var_0_16.Scale(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.x * arg_24_1.x
	local var_24_1 = arg_24_0.y * arg_24_1.y
	local var_24_2 = arg_24_0.z * arg_24_1.z

	return var_0_18(var_24_0, var_24_1, var_24_2)
end

function var_0_16.Cross(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.y * arg_25_1.z - arg_25_0.z * arg_25_1.y
	local var_25_1 = arg_25_0.z * arg_25_1.x - arg_25_0.x * arg_25_1.z
	local var_25_2 = arg_25_0.x * arg_25_1.y - arg_25_0.y * arg_25_1.x

	return var_0_18(var_25_0, var_25_1, var_25_2)
end

function var_0_16.Equals(arg_26_0, arg_26_1)
	return arg_26_0.x == arg_26_1.x and arg_26_0.y == arg_26_1.y and arg_26_0.z == arg_26_1.z
end

function var_0_16.Reflect(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 * (-2 * var_0_19(arg_27_1, arg_27_0))

	arg_27_1:Add(arg_27_0)

	return arg_27_1
end

function var_0_16.Project(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1:SqrMagnitude()

	if var_28_0 < 1.175494e-38 then
		return var_0_18(0, 0, 0)
	end

	local var_28_1 = var_0_19(arg_28_0, arg_28_1)
	local var_28_2 = arg_28_1:Clone()

	var_28_2:Mul(var_28_1 / var_28_0)

	return var_28_2
end

function var_0_16.ProjectOnPlane(arg_29_0, arg_29_1)
	local var_29_0 = var_0_16.Project(arg_29_0, arg_29_1)

	var_29_0:Mul(-1)
	var_29_0:Add(arg_29_0)

	return var_29_0
end

function var_0_16.Slerp(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0
	local var_30_1
	local var_30_2
	local var_30_3

	if arg_30_2 <= 0 then
		return arg_30_0:Clone()
	elseif arg_30_2 >= 1 then
		return arg_30_1:Clone()
	end

	local var_30_4 = arg_30_1:Clone()
	local var_30_5 = arg_30_0:Clone()
	local var_30_6 = arg_30_1:Magnitude()
	local var_30_7 = arg_30_0:Magnitude()

	var_30_4:Div(var_30_6)
	var_30_5:Div(var_30_7)

	local var_30_8 = (var_30_6 - var_30_7) * arg_30_2 + var_30_7
	local var_30_9 = var_30_5.x * var_30_4.x + var_30_5.y * var_30_4.y + var_30_5.z * var_30_4.z

	if var_30_9 > 0.999999 then
		var_30_2 = 1 - arg_30_2
		var_30_3 = arg_30_2
	elseif var_30_9 < -0.999999 then
		local var_30_10 = var_0_21(arg_30_0)
		local var_30_11 = Quaternion.AngleAxis(180 * arg_30_2, var_30_10):MulVec3(arg_30_0)

		var_30_11:Mul(var_30_8)

		return var_30_11
	else
		local var_30_12 = var_0_1(var_30_9)
		local var_30_13 = var_0_7(var_30_12)

		var_30_2 = var_0_7((1 - arg_30_2) * var_30_12) / var_30_13
		var_30_3 = var_0_7(arg_30_2 * var_30_12) / var_30_13
	end

	var_30_5:Mul(var_30_2)
	var_30_4:Mul(var_30_3)
	var_30_4:Add(var_30_5)
	var_30_4:Mul(var_30_8)

	return var_30_4
end

function var_0_16.Mul(arg_31_0, arg_31_1)
	if var_0_13(arg_31_1) == "number" then
		arg_31_0.x = arg_31_0.x * arg_31_1
		arg_31_0.y = arg_31_0.y * arg_31_1
		arg_31_0.z = arg_31_0.z * arg_31_1
	else
		arg_31_0:MulQuat(arg_31_1)
	end

	return arg_31_0
end

function var_0_16.Div(arg_32_0, arg_32_1)
	arg_32_0.x = arg_32_0.x / arg_32_1
	arg_32_0.y = arg_32_0.y / arg_32_1
	arg_32_0.z = arg_32_0.z / arg_32_1

	return arg_32_0
end

function var_0_16.Add(arg_33_0, arg_33_1)
	arg_33_0.x = arg_33_0.x + arg_33_1.x
	arg_33_0.y = arg_33_0.y + arg_33_1.y
	arg_33_0.z = arg_33_0.z + arg_33_1.z

	return arg_33_0
end

function var_0_16.Sub(arg_34_0, arg_34_1)
	arg_34_0.x = arg_34_0.x - arg_34_1.x
	arg_34_0.y = arg_34_0.y - arg_34_1.y
	arg_34_0.z = arg_34_0.z - arg_34_1.z

	return arg_34_0
end

function var_0_16.MulQuat(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1.x * 2
	local var_35_1 = arg_35_1.y * 2
	local var_35_2 = arg_35_1.z * 2
	local var_35_3 = arg_35_1.x * var_35_0
	local var_35_4 = arg_35_1.y * var_35_1
	local var_35_5 = arg_35_1.z * var_35_2
	local var_35_6 = arg_35_1.x * var_35_1
	local var_35_7 = arg_35_1.x * var_35_2
	local var_35_8 = arg_35_1.y * var_35_2
	local var_35_9 = arg_35_1.w * var_35_0
	local var_35_10 = arg_35_1.w * var_35_1
	local var_35_11 = arg_35_1.w * var_35_2
	local var_35_12 = (1 - (var_35_4 + var_35_5)) * arg_35_0.x + (var_35_6 - var_35_11) * arg_35_0.y + (var_35_7 + var_35_10) * arg_35_0.z
	local var_35_13 = (var_35_6 + var_35_11) * arg_35_0.x + (1 - (var_35_3 + var_35_5)) * arg_35_0.y + (var_35_8 - var_35_9) * arg_35_0.z
	local var_35_14 = (var_35_7 - var_35_10) * arg_35_0.x + (var_35_8 + var_35_9) * arg_35_0.y + (1 - (var_35_3 + var_35_4)) * arg_35_0.z

	arg_35_0:Set(var_35_12, var_35_13, var_35_14)

	return arg_35_0
end

function var_0_16.AngleAroundAxis(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0 = arg_36_0 - var_0_16.Project(arg_36_0, arg_36_2)
	arg_36_1 = arg_36_1 - var_0_16.Project(arg_36_1, arg_36_2)

	return var_0_16.Angle(arg_36_0, arg_36_1) * (var_0_16.Dot(arg_36_2, var_0_16.Cross(arg_36_0, arg_36_1)) < 0 and -1 or 1)
end

function var_0_16.__tostring(arg_37_0)
	return "[" .. arg_37_0.x .. "," .. arg_37_0.y .. "," .. arg_37_0.z .. "]"
end

function var_0_16.__div(arg_38_0, arg_38_1)
	return var_0_18(arg_38_0.x / arg_38_1, arg_38_0.y / arg_38_1, arg_38_0.z / arg_38_1)
end

function var_0_16.__mul(arg_39_0, arg_39_1)
	if var_0_13(arg_39_1) == "number" then
		return var_0_18(arg_39_0.x * arg_39_1, arg_39_0.y * arg_39_1, arg_39_0.z * arg_39_1)
	else
		local var_39_0 = arg_39_0:Clone()

		var_39_0:MulQuat(arg_39_1)

		return var_39_0
	end
end

function var_0_16.__add(arg_40_0, arg_40_1)
	return var_0_18(arg_40_0.x + arg_40_1.x, arg_40_0.y + arg_40_1.y, arg_40_0.z + arg_40_1.z)
end

function var_0_16.__sub(arg_41_0, arg_41_1)
	return var_0_18(arg_41_0.x - arg_41_1.x, arg_41_0.y - arg_41_1.y, arg_41_0.z - arg_41_1.z)
end

function var_0_16.__unm(arg_42_0)
	return var_0_18(-arg_42_0.x, -arg_42_0.y, -arg_42_0.z)
end

function var_0_16.__eq(arg_43_0, arg_43_1)
	return (arg_43_0 - arg_43_1):SqrMagnitude() < 1e-10
end

function var_0_17.up()
	return var_0_18(0, 1, 0)
end

function var_0_17.down()
	return var_0_18(0, -1, 0)
end

function var_0_17.right()
	return var_0_18(1, 0, 0)
end

function var_0_17.left()
	return var_0_18(-1, 0, 0)
end

function var_0_17.forward()
	return var_0_18(0, 0, 1)
end

function var_0_17.back()
	return var_0_18(0, 0, -1)
end

function var_0_17.zero()
	return var_0_18(0, 0, 0)
end

function var_0_17.one()
	return var_0_18(1, 1, 1)
end

var_0_17.magnitude = var_0_16.Magnitude
var_0_17.normalized = var_0_16.Normalize
var_0_17.sqrMagnitude = var_0_16.SqrMagnitude
UnityEngine.Vector3 = var_0_16

var_0_10(var_0_16, var_0_16)

return var_0_16
