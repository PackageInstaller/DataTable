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

	return
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

function var_0_15.Copy(arg_7_0, arg_7_1)
	arg_7_0.x = arg_7_1.x
	arg_7_0.y = arg_7_1.y
	arg_7_0.z = arg_7_1.z

	return arg_7_0
end

function var_0_15:Copy2(arg_8_1)
	if arg_8_1 then
		arg_8_1.x = self.x
		arg_8_1.y = self.y
		arg_8_1.z = self.z

		return arg_8_1
	else
		return var_0_17(self.x, self.y, self.z)
	end

	return
end

function var_0_15:Distance(arg_9_1)
	return var_0_1((self.x - arg_9_1.x)^2 + (self.y - arg_9_1.y)^2 + (self.z - arg_9_1.z)^2)
end

function var_0_15:BattleDistance(arg_10_1)
	return var_0_1((self.x - arg_10_1.x)^2 + (self.z - arg_10_1.z)^2)
end

function var_0_15:SqrDistance(arg_11_1)
	return (self.x - arg_11_1.x)^2 + (self.y - arg_11_1.y)^2 + (self.z - arg_11_1.z)^2
end

function var_0_15:Dot(arg_12_1)
	return self.x * arg_12_1.x + self.y * arg_12_1.y + self.z * arg_12_1.z
end

function var_0_15:Lerp(arg_13_1, arg_13_2)
	arg_13_2 = var_0_4(arg_13_2, 0, 1)

	return var_0_17(self.x + (arg_13_1.x - self.x) * arg_13_2, self.y + (arg_13_1.y - self.y) * arg_13_2, self.z + (arg_13_1.z - self.z) * arg_13_2)
end

function var_0_15:Magnitude()
	return var_0_1(self.x * self.x + self.y * self.y + self.z * self.z)
end

function var_0_15:Max(arg_15_1)
	return var_0_17(var_0_2(self.x, arg_15_1.x), var_0_2(self.y, arg_15_1.y), var_0_2(self.z, arg_15_1.z))
end

function var_0_15:Min(arg_16_1)
	return var_0_17(var_0_3(self.x, arg_16_1.x), var_0_3(self.y, arg_16_1.y), var_0_3(self.z, arg_16_1.z))
end

function var_0_15:Normalize()
	local var_17_0 = var_0_1(self.x * self.x + self.y * self.y + self.z * self.z)

	if var_17_0 > 1e-05 then
		return var_0_9({
			x = self.x / var_17_0,
			y = self.y / var_17_0,
			z = self.z / var_17_0
		}, var_0_15)
	end

	return var_0_9({
		z = 0,
		x = 0,
		y = 0
	}, var_0_15)
end

function var_0_15:SetNormalize()
	local var_18_0 = var_0_1(self.x * self.x + self.y * self.y + self.z * self.z)

	if var_18_0 > 1e-05 then
		self.x = self.x / var_18_0
		self.y = self.y / var_18_0
		self.z = self.z / var_18_0
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

function var_0_15:Angle(arg_20_1)
	return var_0_0(var_0_4(var_0_18(self:Normalize(), arg_20_1:Normalize()), -1, 1)) * var_0_13
end

function var_0_15:ClampMagnitude(arg_21_1)
	if self:SqrMagnitude() > arg_21_1 * arg_21_1 then
		self:SetNormalize()
		self:Mul(arg_21_1)
	end

	return self
end

function var_0_15:OrthoNormalize(arg_22_1, arg_22_2)
	self:SetNormalize()
	arg_22_1:Sub(arg_22_1:Project(self))
	arg_22_1:SetNormalize()

	if arg_22_2 == nil then
		return self, arg_22_1
	end

	arg_22_2:Sub(arg_22_2:Project(self))
	arg_22_2:Sub(arg_22_2:Project(arg_22_1))
	arg_22_2:SetNormalize()

	return self, arg_22_1, arg_22_2
end

function var_0_15:MoveTowards(arg_23_1, arg_23_2)
	local var_23_0 = (arg_23_1 - self):SqrMagnitude()

	if var_23_0 > arg_23_2 * arg_23_2 then
		local var_23_1 = var_0_1(var_23_0)

		if var_23_1 > 1e-06 then
			(arg_23_1 - self):Mul(arg_23_2 / var_23_1)
			;(arg_23_1 - self):Add(self)

			return arg_23_1 - self
		else
			return self:Clone()
		end
	end

	return arg_23_1:Clone()
end

function ClampedMove(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 - arg_24_0 > 0 then
		return arg_24_0 + var_0_3(arg_24_1 - arg_24_0, arg_24_2)
	else
		return arg_24_0 - var_0_3(-(arg_24_1 - arg_24_0), arg_24_2)
	end

	return
end

local var_0_19 = 0.7071067811865476

local function var_0_20(arg_25_0)
	local var_25_0 = var_0_17()

	if var_0_7(arg_25_0.z) > var_0_19 then
		local var_25_1 = 1 / var_0_1(arg_25_0.y * arg_25_0.y + arg_25_0.z * arg_25_0.z)

		var_25_0.x = 0
		var_25_0.y = -arg_25_0.z * var_25_1
		var_25_0.z = arg_25_0.y * var_25_1
	else
		local var_25_2 = 1 / var_0_1(arg_25_0.x * arg_25_0.x + arg_25_0.y * arg_25_0.y)

		var_25_0.x = -arg_25_0.y * var_25_2
		var_25_0.y = arg_25_0.x * var_25_2
		var_25_0.z = 0
	end

	return var_25_0
end

function var_0_15:RotateTowards(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = self:Magnitude()
	local var_26_1 = arg_26_1:Magnitude()

	if var_26_0 > 1e-06 and var_26_1 > 1e-06 then
		local var_26_2 = var_0_18(self / var_26_0, arg_26_1 / var_26_1)

		if var_26_2 > 0.999999 then
			return var_0_15.MoveTowards(self, arg_26_1, arg_26_3)
		elseif var_26_2 < -0.999999 then
			local var_26_3 = Quaternion.AngleAxis(arg_26_2 * var_0_13, (var_0_20(self / var_26_0))):MulVec3(self / var_26_0)

			var_26_3:Mul((ClampedMove(var_26_0, var_26_1, arg_26_3)))

			return var_26_3
		else
			local var_26_4 = var_0_0(var_26_2)
			local var_26_5 = var_0_15.Cross(self / var_26_0, arg_26_1 / var_26_1)

			var_26_5:SetNormalize()

			local var_26_6 = Quaternion.AngleAxis(var_0_3(arg_26_2, var_26_4) * var_0_13, var_26_5):MulVec3(self / var_26_0)

			var_26_6:Mul((ClampedMove(var_26_0, var_26_1, arg_26_3)))

			return var_26_6
		end
	end

	return var_0_15.MoveTowards(self, arg_26_1, arg_26_3)
end

function var_0_15.SmoothDamp(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_3 = var_0_2(0.0001, arg_27_3)

	local var_27_0 = 1 / (1 + 2 / arg_27_3 * Time.deltaTime + 0.48 * (2 / arg_27_3 * Time.deltaTime) * (2 / arg_27_3 * Time.deltaTime) + 0.235 * (2 / arg_27_3 * Time.deltaTime) * (2 / arg_27_3 * Time.deltaTime) * (2 / arg_27_3 * Time.deltaTime))
	local var_27_1 = arg_27_1:Clone()
	local var_27_2 = arg_27_0 - arg_27_1

	;(arg_27_0 - arg_27_1):ClampMagnitude(Mathf.Infinity * arg_27_3)

	arg_27_1 = arg_27_0 - var_27_2
	arg_27_2 = (arg_27_2 - (arg_27_2 + var_27_2 * (2 / arg_27_3)) * Time.deltaTime * (2 / arg_27_3)) * var_27_0

	local var_27_3 = arg_27_0 - var_27_2 + (var_27_2 + (arg_27_2 + var_27_2 * (2 / arg_27_3)) * Time.deltaTime) * var_27_0

	if var_0_15.Dot(var_27_1 - arg_27_0, arg_27_0 - var_27_2 + (var_27_2 + (arg_27_2 + var_27_2 * (2 / arg_27_3)) * Time.deltaTime) * var_27_0 - var_27_1) > 0 then
		var_27_3 = var_27_1

		arg_27_2:Set(0, 0, 0)
	end

	return var_27_3, arg_27_2
end

function var_0_15:Scale(arg_28_1)
	return var_0_17(self.x * arg_28_1.x, self.y * arg_28_1.y, self.z * arg_28_1.z)
end

function var_0_15:Cross2(arg_29_1)
	self.x, self.y, self.z = self.y * arg_29_1.z - self.z * arg_29_1.y, self.z * arg_29_1.x - self.x * arg_29_1.z, self.x * arg_29_1.y - self.y * arg_29_1.x

	return self
end

function var_0_15:Cross(arg_30_1)
	return var_0_17(self.y * arg_30_1.z - self.z * arg_30_1.y, self.z * arg_30_1.x - self.x * arg_30_1.z, self.x * arg_30_1.y - self.y * arg_30_1.x)
end

function var_0_15:Equals(arg_31_1)
	return self.x == arg_31_1.x and self.y == arg_31_1.y and self.z == arg_31_1.z
end

function var_0_15:EqualZero()
	return self.x * self.x + self.y * self.y + self.z * self.z < 1e-10
end

function var_0_15.Reflect(arg_33_0, arg_33_1)
	arg_33_1 = arg_33_1 * (-2 * var_0_18(arg_33_1, arg_33_0))

	arg_33_1:Add(arg_33_0)

	return arg_33_1
end

function var_0_15.Project(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:SqrMagnitude()
	local var_34_1

	if var_34_0 < 1.175494e-38 then
		do return var_0_17(0, 0, 0) end

		var_34_1 = arg_34_1:Clone()
	end

	var_34_1:Mul(var_0_18(arg_34_0, arg_34_1) / var_34_0)

	return var_34_1
end

function var_0_15.ProjectOnPlane(arg_35_0, arg_35_1)
	local var_35_0 = var_0_15.Project(arg_35_0, arg_35_1)

	var_35_0:Mul(-1)
	var_35_0:Add(arg_35_0)

	return var_35_0
end

function var_0_15:Slerp(arg_36_1, arg_36_2)
	local var_36_2
	local var_36_3

	if arg_36_2 <= 0 then
		return self:Clone()
	elseif arg_36_2 >= 1 then
		return arg_36_1:Clone()
	end

	local var_36_4 = arg_36_1:Clone()
	local var_36_5 = self:Clone()
	local var_36_6 = arg_36_1:Magnitude()
	local var_36_7 = self:Magnitude()

	var_36_4:Div(var_36_6)
	var_36_5:Div(var_36_7)

	local var_36_8 = (var_36_6 - var_36_7) * arg_36_2 + var_36_7

	if var_36_5.x * var_36_4.x + var_36_5.y * var_36_4.y + var_36_5.z * var_36_4.z > 0.999999 then
		var_36_2 = 1 - arg_36_2
		var_36_3 = arg_36_2
	elseif var_36_5.x * var_36_4.x + var_36_5.y * var_36_4.y + var_36_5.z * var_36_4.z < -0.999999 then
		local var_36_9 = Quaternion.AngleAxis(180 * arg_36_2, (var_0_20(self))):MulVec3(self)

		var_36_9:Mul(var_36_8)

		return var_36_9
	else
		local var_36_10 = var_0_0(var_36_5.x * var_36_4.x + var_36_5.y * var_36_4.y + var_36_5.z * var_36_4.z)
		local var_36_11 = var_0_6(var_36_10)

		var_36_2 = var_0_6((1 - arg_36_2) * var_36_10) / var_36_11
		var_36_3 = var_0_6(arg_36_2 * var_36_10) / var_36_11
	end

	var_36_5:Mul(var_36_2)
	var_36_4:Mul(var_36_3)
	var_36_4:Add(var_36_5)
	var_36_4:Mul(var_36_8)

	return var_36_4
end

function var_0_15:Mul(arg_37_1)
	if var_0_12(arg_37_1) == "number" then
		self.x = self.x * arg_37_1
		self.y = self.y * arg_37_1
		self.z = self.z * arg_37_1
	else
		self:MulQuat(arg_37_1)
	end

	return self
end

function var_0_15:Div(arg_38_1)
	self.x = self.x / arg_38_1
	self.y = self.y / arg_38_1
	self.z = self.z / arg_38_1

	return self
end

function var_0_15:Add(arg_39_1)
	self.x = self.x + arg_39_1.x
	self.y = self.y + arg_39_1.y
	self.z = self.z + arg_39_1.z

	return self
end

function var_0_15:Sub(arg_40_1)
	self.x = self.x - arg_40_1.x
	self.y = self.y - arg_40_1.y
	self.z = self.z - arg_40_1.z

	return self
end

function var_0_15:MulQuat(arg_41_1)
	self:Set((1 - (arg_41_1.y * (arg_41_1.y * 2) + arg_41_1.z * (arg_41_1.z * 2))) * self.x + (arg_41_1.x * (arg_41_1.y * 2) - arg_41_1.w * (arg_41_1.z * 2)) * self.y + (arg_41_1.x * (arg_41_1.z * 2) + arg_41_1.w * (arg_41_1.y * 2)) * self.z, (arg_41_1.x * (arg_41_1.y * 2) + arg_41_1.w * (arg_41_1.z * 2)) * self.x + (1 - (arg_41_1.x * (arg_41_1.x * 2) + arg_41_1.z * (arg_41_1.z * 2))) * self.y + (arg_41_1.y * (arg_41_1.z * 2) - arg_41_1.w * (arg_41_1.x * 2)) * self.z, (arg_41_1.x * (arg_41_1.z * 2) - arg_41_1.w * (arg_41_1.y * 2)) * self.x + (arg_41_1.y * (arg_41_1.z * 2) + arg_41_1.w * (arg_41_1.x * 2)) * self.y + (1 - (arg_41_1.x * (arg_41_1.x * 2) + arg_41_1.y * (arg_41_1.y * 2))) * self.z)

	return self
end

function var_0_15.AngleAroundAxis(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0 = arg_42_0 - var_0_15.Project(arg_42_0, arg_42_2)
	arg_42_1 = arg_42_1 - var_0_15.Project(arg_42_1, arg_42_2)

	return var_0_15.Angle(arg_42_0, arg_42_1) * (var_0_15.Dot(arg_42_2, var_0_15.Cross(arg_42_0, arg_42_1)) < 0 and -1 or 1)
end

function var_0_15:__tostring()
	return "[" .. self.x .. "," .. self.y .. "," .. self.z .. "]"
end

function var_0_15:__div(arg_44_1)
	return var_0_17(self.x / arg_44_1, self.y / arg_44_1, self.z / arg_44_1)
end

function var_0_15:__mul(arg_45_1)
	if var_0_12(arg_45_1) == "number" then
		return var_0_17(self.x * arg_45_1, self.y * arg_45_1, self.z * arg_45_1)
	else
		local var_45_0 = self:Clone()

		var_45_0:MulQuat(arg_45_1)

		return var_45_0
	end

	return
end

function var_0_15:__add(arg_46_1)
	return var_0_17(self.x + arg_46_1.x, self.y + arg_46_1.y, self.z + arg_46_1.z)
end

function var_0_15:__sub(arg_47_1)
	return var_0_17(self.x - arg_47_1.x, self.y - arg_47_1.y, self.z - arg_47_1.z)
end

function var_0_15:__unm()
	return var_0_17(-self.x, -self.y, -self.z)
end

function var_0_15:__eq(arg_49_1)
	return (self.x - arg_49_1.x) * (self.x - arg_49_1.x) + (self.y - arg_49_1.y) * (self.y - arg_49_1.y) + (self.z - arg_49_1.z) * (self.z - arg_49_1.z) < 1e-10
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
