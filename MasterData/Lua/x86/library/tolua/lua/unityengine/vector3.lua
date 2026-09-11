local var_0_0 = math.acos
local var_0_1 = math.sqrt
local var_0_2 = math.max
local var_0_3 = math.min
local var_0_4 = Mathf.Clamp
local var_0_6 = math.sin
local var_0_7 = math.abs
local var_0_9 = setmetatable
local var_0_11 = rawget
local var_0_12 = type
local var_0_13 = 57.295779513082
local var_0_15 = {}
local var_0_16 = tolua.initget(var_0_15)

function var_0_15.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_11(var_0_15, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_11(var_0_16, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_15.New(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {
		x = arg_2_0 or 0,
		y = arg_2_1 or 0,
		z = arg_2_2 or 0
	}

	var_0_9(var_2_0, var_0_15)

	return var_2_0
end

local var_0_17 = var_0_15.New

function var_0_15.__call(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		x = arg_3_1 or 0,
		y = arg_3_2 or 0,
		z = arg_3_3 or 0
	}

	var_0_9(var_3_0, var_0_15)

	return var_3_0
end

function var_0_15.Set(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.x = arg_4_1 or 0
	arg_4_0.y = arg_4_2 or 0
	arg_4_0.z = arg_4_3 or 0
end

function var_0_15:Get()
	return self.x, self.y, self.z
end

function var_0_15:Clone()
	return var_0_9({
		x = self.x,
		y = self.y,
		z = self.z
	}, var_0_15)
end

function var_0_15:Distance(arg_7_1)
	return var_0_1((self.x - arg_7_1.x)^2 + (self.y - arg_7_1.y)^2 + (self.z - arg_7_1.z)^2)
end

function var_0_15:Dot(arg_8_1)
	return self.x * arg_8_1.x + self.y * arg_8_1.y + self.z * arg_8_1.z
end

function var_0_15:Lerp(arg_9_1, arg_9_2)
	arg_9_2 = var_0_4(arg_9_2, 0, 1)

	return var_0_17(self.x + (arg_9_1.x - self.x) * arg_9_2, self.y + (arg_9_1.y - self.y) * arg_9_2, self.z + (arg_9_1.z - self.z) * arg_9_2)
end

function var_0_15:Magnitude()
	return var_0_1(self.x * self.x + self.y * self.y + self.z * self.z)
end

function var_0_15:Max(arg_11_1)
	return var_0_17(var_0_2(self.x, arg_11_1.x), var_0_2(self.y, arg_11_1.y), var_0_2(self.z, arg_11_1.z))
end

function var_0_15:Min(arg_12_1)
	return var_0_17(var_0_3(self.x, arg_12_1.x), var_0_3(self.y, arg_12_1.y), var_0_3(self.z, arg_12_1.z))
end

function var_0_15:Normalize()
	local var_13_0 = var_0_1(self.x * self.x + self.y * self.y + self.z * self.z)

	if var_13_0 > 1e-05 then
		return var_0_9({
			x = self.x / var_13_0,
			y = self.y / var_13_0,
			z = self.z / var_13_0
		}, var_0_15)
	end

	return var_0_9({
		z = 0,
		x = 0,
		y = 0
	}, var_0_15)
end

function var_0_15:SetNormalize()
	local var_14_0 = var_0_1(self.x * self.x + self.y * self.y + self.z * self.z)

	if var_14_0 > 1e-05 then
		self.x = self.x / var_14_0
		self.y = self.y / var_14_0
		self.z = self.z / var_14_0
	else
		self.x = 0
		self.y = 0
		self.z = 0
	end

	return self
end

function var_0_15:SqrMagnitude()
	return self.x * self.x + self.y * self.y + self.z * self.z
end

local var_0_18 = var_0_15.Dot

function var_0_15:Angle(arg_16_1)
	return var_0_0(var_0_4(var_0_18(self:Normalize(), arg_16_1:Normalize()), -1, 1)) * var_0_13
end

function var_0_15:ClampMagnitude(arg_17_1)
	if self:SqrMagnitude() > arg_17_1 * arg_17_1 then
		self:SetNormalize()
		self:Mul(arg_17_1)
	end

	return self
end

function var_0_15:OrthoNormalize(arg_18_1, arg_18_2)
	self:SetNormalize()
	arg_18_1:Sub(arg_18_1:Project(self))
	arg_18_1:SetNormalize()

	if arg_18_2 == nil then
		return self, arg_18_1
	end

	arg_18_2:Sub(arg_18_2:Project(self))
	arg_18_2:Sub(arg_18_2:Project(arg_18_1))
	arg_18_2:SetNormalize()

	return self, arg_18_1, arg_18_2
end

function var_0_15:MoveTowards(arg_19_1, arg_19_2)
	local var_19_0 = (arg_19_1 - self):SqrMagnitude()

	if var_19_0 > arg_19_2 * arg_19_2 then
		local var_19_1 = var_0_1(var_19_0)

		if var_19_1 > 1e-06 then
			(arg_19_1 - self):Mul(arg_19_2 / var_19_1)
			;(arg_19_1 - self):Add(self)

			return arg_19_1 - self
		else
			return self:Clone()
		end
	end

	return arg_19_1:Clone()
end

function ClampedMove(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 - arg_20_0 > 0 then
		return arg_20_0 + var_0_3(arg_20_1 - arg_20_0, arg_20_2)
	else
		return arg_20_0 - var_0_3(-(arg_20_1 - arg_20_0), arg_20_2)
	end
end

local var_0_19 = 0.7071067811865476

local function var_0_20(arg_21_0)
	local var_21_0 = var_0_17()

	if var_0_7(arg_21_0.z) > var_0_19 then
		local var_21_1 = 1 / var_0_1(arg_21_0.y * arg_21_0.y + arg_21_0.z * arg_21_0.z)

		var_21_0.x = 0
		var_21_0.y = -arg_21_0.z * var_21_1
		var_21_0.z = arg_21_0.y * var_21_1
	else
		local var_21_2 = 1 / var_0_1(arg_21_0.x * arg_21_0.x + arg_21_0.y * arg_21_0.y)

		var_21_0.x = -arg_21_0.y * var_21_2
		var_21_0.y = arg_21_0.x * var_21_2
		var_21_0.z = 0
	end

	return var_21_0
end

function var_0_15:RotateTowards(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = self:Magnitude()
	local var_22_1 = arg_22_1:Magnitude()

	if var_22_0 > 1e-06 and var_22_1 > 1e-06 then
		local var_22_2 = var_0_18(self / var_22_0, arg_22_1 / var_22_1)

		if var_22_2 > 0.999999 then
			return var_0_15.MoveTowards(self, arg_22_1, arg_22_3)
		elseif var_22_2 < -0.999999 then
			local var_22_3 = Quaternion.AngleAxis(arg_22_2 * var_0_13, (var_0_20(self / var_22_0))):MulVec3(self / var_22_0)

			var_22_3:Mul((ClampedMove(var_22_0, var_22_1, arg_22_3)))

			return var_22_3
		else
			local var_22_4 = var_0_0(var_22_2)
			local var_22_5 = var_0_15.Cross(self / var_22_0, arg_22_1 / var_22_1)

			var_22_5:SetNormalize()

			local var_22_6 = Quaternion.AngleAxis(var_0_3(arg_22_2, var_22_4) * var_0_13, var_22_5):MulVec3(self / var_22_0)

			var_22_6:Mul((ClampedMove(var_22_0, var_22_1, arg_22_3)))

			return var_22_6
		end
	end

	return var_0_15.MoveTowards(self, arg_22_1, arg_22_3)
end

function var_0_15.SmoothDamp(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_3 = var_0_2(0.0001, arg_23_3)

	local var_23_0 = 1 / (1 + 2 / arg_23_3 * Time.deltaTime + 0.48 * (2 / arg_23_3 * Time.deltaTime) * (2 / arg_23_3 * Time.deltaTime) + 0.235 * (2 / arg_23_3 * Time.deltaTime) * (2 / arg_23_3 * Time.deltaTime) * (2 / arg_23_3 * Time.deltaTime))
	local var_23_1 = arg_23_1:Clone()
	local var_23_2 = arg_23_0 - arg_23_1

	;(arg_23_0 - arg_23_1):ClampMagnitude(Mathf.Infinity * arg_23_3)

	arg_23_1 = arg_23_0 - var_23_2
	arg_23_2 = (arg_23_2 - (arg_23_2 + var_23_2 * (2 / arg_23_3)) * Time.deltaTime * (2 / arg_23_3)) * var_23_0

	local var_23_3 = arg_23_0 - var_23_2 + (var_23_2 + (arg_23_2 + var_23_2 * (2 / arg_23_3)) * Time.deltaTime) * var_23_0

	if var_0_15.Dot(var_23_1 - arg_23_0, arg_23_0 - var_23_2 + (var_23_2 + (arg_23_2 + var_23_2 * (2 / arg_23_3)) * Time.deltaTime) * var_23_0 - var_23_1) > 0 then
		var_23_3 = var_23_1

		arg_23_2:Set(0, 0, 0)
	end

	return var_23_3, arg_23_2
end

function var_0_15:Scale(arg_24_1)
	return var_0_17(self.x * arg_24_1.x, self.y * arg_24_1.y, self.z * arg_24_1.z)
end

function var_0_15:Cross(arg_25_1)
	return var_0_17(self.y * arg_25_1.z - self.z * arg_25_1.y, self.z * arg_25_1.x - self.x * arg_25_1.z, self.x * arg_25_1.y - self.y * arg_25_1.x)
end

function var_0_15:Equals(arg_26_1)
	return self.x == arg_26_1.x and self.y == arg_26_1.y and self.z == arg_26_1.z
end

function var_0_15.Reflect(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 * (-2 * var_0_18(arg_27_1, arg_27_0))

	arg_27_1:Add(arg_27_0)

	return arg_27_1
end

function var_0_15.Project(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1:SqrMagnitude()
	local var_28_1

	if var_28_0 < 1.175494e-38 then
		do return var_0_17(0, 0, 0) end

		var_28_1 = arg_28_1:Clone()
	end

	var_28_1:Mul(var_0_18(arg_28_0, arg_28_1) / var_28_0)

	return var_28_1
end

function var_0_15.ProjectOnPlane(arg_29_0, arg_29_1)
	local var_29_0 = var_0_15.Project(arg_29_0, arg_29_1)

	var_29_0:Mul(-1)
	var_29_0:Add(arg_29_0)

	return var_29_0
end

function var_0_15:Slerp(arg_30_1, arg_30_2)
	local var_30_2
	local var_30_3

	if arg_30_2 <= 0 then
		return self:Clone()
	elseif arg_30_2 >= 1 then
		return arg_30_1:Clone()
	end

	local var_30_4 = arg_30_1:Clone()
	local var_30_5 = self:Clone()
	local var_30_6 = arg_30_1:Magnitude()
	local var_30_7 = self:Magnitude()

	var_30_4:Div(var_30_6)
	var_30_5:Div(var_30_7)

	local var_30_8 = (var_30_6 - var_30_7) * arg_30_2 + var_30_7

	if var_30_5.x * var_30_4.x + var_30_5.y * var_30_4.y + var_30_5.z * var_30_4.z > 0.999999 then
		var_30_2 = 1 - arg_30_2
		var_30_3 = arg_30_2
	elseif var_30_5.x * var_30_4.x + var_30_5.y * var_30_4.y + var_30_5.z * var_30_4.z < -0.999999 then
		local var_30_9 = Quaternion.AngleAxis(180 * arg_30_2, (var_0_20(self))):MulVec3(self)

		var_30_9:Mul(var_30_8)

		return var_30_9
	else
		local var_30_10 = var_0_0(var_30_5.x * var_30_4.x + var_30_5.y * var_30_4.y + var_30_5.z * var_30_4.z)
		local var_30_11 = var_0_6(var_30_10)

		var_30_2 = var_0_6((1 - arg_30_2) * var_30_10) / var_30_11
		var_30_3 = var_0_6(arg_30_2 * var_30_10) / var_30_11
	end

	var_30_5:Mul(var_30_2)
	var_30_4:Mul(var_30_3)
	var_30_4:Add(var_30_5)
	var_30_4:Mul(var_30_8)

	return var_30_4
end

function var_0_15:Mul(arg_31_1)
	if var_0_12(arg_31_1) == "number" then
		self.x = self.x * arg_31_1
		self.y = self.y * arg_31_1
		self.z = self.z * arg_31_1
	else
		self:MulQuat(arg_31_1)
	end

	return self
end

function var_0_15:Div(arg_32_1)
	self.x = self.x / arg_32_1
	self.y = self.y / arg_32_1
	self.z = self.z / arg_32_1

	return self
end

function var_0_15:Add(arg_33_1)
	self.x = self.x + arg_33_1.x
	self.y = self.y + arg_33_1.y
	self.z = self.z + arg_33_1.z

	return self
end

function var_0_15:Sub(arg_34_1)
	self.x = self.x - arg_34_1.x
	self.y = self.y - arg_34_1.y
	self.z = self.z - arg_34_1.z

	return self
end

function var_0_15:MulQuat(arg_35_1)
	self:Set((1 - (arg_35_1.y * (arg_35_1.y * 2) + arg_35_1.z * (arg_35_1.z * 2))) * self.x + (arg_35_1.x * (arg_35_1.y * 2) - arg_35_1.w * (arg_35_1.z * 2)) * self.y + (arg_35_1.x * (arg_35_1.z * 2) + arg_35_1.w * (arg_35_1.y * 2)) * self.z, (arg_35_1.x * (arg_35_1.y * 2) + arg_35_1.w * (arg_35_1.z * 2)) * self.x + (1 - (arg_35_1.x * (arg_35_1.x * 2) + arg_35_1.z * (arg_35_1.z * 2))) * self.y + (arg_35_1.y * (arg_35_1.z * 2) - arg_35_1.w * (arg_35_1.x * 2)) * self.z, (arg_35_1.x * (arg_35_1.z * 2) - arg_35_1.w * (arg_35_1.y * 2)) * self.x + (arg_35_1.y * (arg_35_1.z * 2) + arg_35_1.w * (arg_35_1.x * 2)) * self.y + (1 - (arg_35_1.x * (arg_35_1.x * 2) + arg_35_1.y * (arg_35_1.y * 2))) * self.z)

	return self
end

function var_0_15.AngleAroundAxis(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0 = arg_36_0 - var_0_15.Project(arg_36_0, arg_36_2)
	arg_36_1 = arg_36_1 - var_0_15.Project(arg_36_1, arg_36_2)

	return var_0_15.Angle(arg_36_0, arg_36_1) * (var_0_15.Dot(arg_36_2, var_0_15.Cross(arg_36_0, arg_36_1)) < 0 and -1 or 1)
end

function var_0_15:__tostring()
	return "[" .. self.x .. "," .. self.y .. "," .. self.z .. "]"
end

function var_0_15:__div(arg_38_1)
	return var_0_17(self.x / arg_38_1, self.y / arg_38_1, self.z / arg_38_1)
end

function var_0_15:__mul(arg_39_1)
	if var_0_12(arg_39_1) == "number" then
		return var_0_17(self.x * arg_39_1, self.y * arg_39_1, self.z * arg_39_1)
	else
		local var_39_0 = self:Clone()

		var_39_0:MulQuat(arg_39_1)

		return var_39_0
	end
end

function var_0_15:__add(arg_40_1)
	return var_0_17(self.x + arg_40_1.x, self.y + arg_40_1.y, self.z + arg_40_1.z)
end

function var_0_15:__sub(arg_41_1)
	return var_0_17(self.x - arg_41_1.x, self.y - arg_41_1.y, self.z - arg_41_1.z)
end

function var_0_15:__unm()
	return var_0_17(-self.x, -self.y, -self.z)
end

function var_0_15.__eq(arg_43_0, arg_43_1)
	return (arg_43_0 - arg_43_1):SqrMagnitude() < 1e-10
end

function var_0_16.up()
	return var_0_17(0, 1, 0)
end

function var_0_16.down()
	return var_0_17(0, -1, 0)
end

function var_0_16.right()
	return var_0_17(1, 0, 0)
end

function var_0_16.left()
	return var_0_17(-1, 0, 0)
end

function var_0_16.forward()
	return var_0_17(0, 0, 1)
end

function var_0_16.back()
	return var_0_17(0, 0, -1)
end

function var_0_16.zero()
	return var_0_17(0, 0, 0)
end

function var_0_16.one()
	return var_0_17(1, 1, 1)
end

var_0_16.magnitude = var_0_15.Magnitude
var_0_16.normalized = var_0_15.Normalize
var_0_16.sqrMagnitude = var_0_15.SqrMagnitude
UnityEngine.Vector3 = var_0_15

setmetatable(var_0_15, var_0_15)

return var_0_15
