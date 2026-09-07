local var_0_0 = math.sin
local var_0_1 = math.cos
local var_0_2 = math.acos
local var_0_3 = math.asin
local var_0_4 = math.sqrt
local var_0_5 = math.min
local var_0_8 = math.atan2
local var_0_9 = Mathf.Clamp
local var_0_10 = math.abs
local var_0_11 = setmetatable
local var_0_12 = getmetatable
local var_0_13 = rawget
local var_0_14 = rawset
local var_0_15 = Vector3
local var_0_16 = Mathf.Rad2Deg
local var_0_17 = 0.5 * Mathf.Deg2Rad
local var_0_18 = Vector3.forward
local var_0_19 = Vector3.up
local var_0_20 = {
	2,
	3,
	1
}
local var_0_21 = {}
local var_0_22 = tolua.initget(var_0_21)

function var_0_21.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_13(var_0_21, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_13(var_0_22, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_21:__newindex(arg_2_1, arg_2_2)
	if arg_2_1 == "eulerAngles" then
		self:SetEuler(arg_2_2)
	else
		var_0_14(self, arg_2_1, arg_2_2)
	end

	return
end

function var_0_21.New(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		x = arg_3_0 or 0,
		y = arg_3_1 or 0,
		z = arg_3_2 or 0,
		w = arg_3_3 or 0
	}

	var_0_11(var_3_0, var_0_21)

	return var_3_0
end

local var_0_23 = var_0_21.New

function var_0_21.__call(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = {
		x = arg_4_1 or 0,
		y = arg_4_2 or 0,
		z = arg_4_3 or 0,
		w = arg_4_4 or 0
	}

	var_0_11(var_4_0, var_0_21)

	return var_4_0
end

function var_0_21.Set(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.x = arg_5_1 or 0
	arg_5_0.y = arg_5_2 or 0
	arg_5_0.z = arg_5_3 or 0
	arg_5_0.w = arg_5_4 or 0

	return
end

function var_0_21:Clone()
	return var_0_23(self.x, self.y, self.z, self.w)
end

function var_0_21:Get()
	return self.x, self.y, self.z, self.w
end

function var_0_21:Dot(arg_8_1)
	return self.x * arg_8_1.x + self.y * arg_8_1.y + self.z * arg_8_1.z + self.w * arg_8_1.w
end

function var_0_21.Angle(arg_9_0, arg_9_1)
	local var_9_0 = var_0_21.Dot(arg_9_0, arg_9_1)

	if var_9_0 < 0 then
		var_9_0 = -var_9_0
	end

	return var_0_2(var_0_5(var_9_0, 1)) * 2 * 57.29578
end

function var_0_21.AngleAxis(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:Normalize()

	arg_10_0 = arg_10_0 * var_0_17

	local var_10_1 = var_0_0(arg_10_0)

	return var_0_23(var_10_0.x * var_10_1, var_10_0.y * var_10_1, var_10_0.z * var_10_1, (var_0_1(arg_10_0)))
end

function var_0_21:Equals(arg_11_1)
	return self.x == arg_11_1.x and self.y == arg_11_1.y and self.z == arg_11_1.z and self.w == arg_11_1.w
end

function var_0_21.Euler(arg_12_0, arg_12_1, arg_12_2)
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

	var_0_11(var_12_3, var_0_21)

	return var_12_3
end

function var_0_21.SetEuler(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
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

function var_0_21:Normalize()
	local var_14_0 = self:Clone()

	var_14_0:SetNormalize()

	return var_14_0
end

function var_0_21:SetNormalize()
	if self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w ~= 1 and self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w > 0 then
		local var_15_0 = 1 / var_0_4(self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w)

		self.x = self.x * var_15_0
		self.y = self.y * var_15_0
		self.z = self.z * var_15_0
		self.w = self.w * var_15_0
	end

	return
end

function var_0_21.FromToRotation(arg_16_0, arg_16_1)
	local var_16_0 = var_0_21.New()

	var_16_0:SetFromToRotation(arg_16_0, arg_16_1)

	return var_16_0
end

function var_0_21:SetFromToRotation1(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:Normalize()
	local var_17_1 = arg_17_2:Normalize()
	local var_17_2 = var_0_15.Dot(var_17_0, var_17_1)

	if var_17_2 > -0.999999 then
		local var_17_3 = var_0_4((1 + var_17_2) * 2)
		local var_17_4 = var_0_15.Cross(var_17_0, var_17_1) * (1 / var_17_3)

		self:Set(var_17_4.x, var_17_4.y, var_17_4.z, var_17_3 * 0.5)
	elseif var_17_2 > 0.999999 then
		return var_0_23(0, 0, 0, 1)
	else
		local var_17_5 = var_0_15.Cross(var_0_15.right, var_17_0)

		if var_17_5:SqrMagnitude() < 1e-06 then
			var_17_5 = var_0_15.Cross(var_0_15.forward, var_17_0)
		end

		self:Set(var_17_5.x, var_17_5.y, var_17_5.z, 0)

		return self
	end

	return self
end

local function var_0_24(arg_18_0, arg_18_1)
	if arg_18_0[1][1] + arg_18_0[2][2] + arg_18_0[3][3] > 0 then
		local var_18_0 = var_0_4(arg_18_0[1][1] + arg_18_0[2][2] + arg_18_0[3][3] + 1)

		arg_18_1.w = 0.5 * var_18_0
		arg_18_1.x = (arg_18_0[3][2] - arg_18_0[2][3]) * (0.5 / var_18_0)
		arg_18_1.y = (arg_18_0[1][3] - arg_18_0[3][1]) * (0.5 / var_18_0)
		arg_18_1.z = (arg_18_0[2][1] - arg_18_0[1][2]) * (0.5 / var_18_0)

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

		local var_18_3 = var_0_20[var_18_1]
		local var_18_4 = arg_18_0[var_18_1][var_18_1] - arg_18_0[var_0_20[var_18_1]][var_0_20[var_18_1]] - arg_18_0[var_0_20[var_0_20[var_18_1]]][var_0_20[var_0_20[var_18_1]]] + 1
		local var_18_5 = 0.5 / var_0_4(var_18_4)

		var_18_2[var_18_1] = var_18_5 * var_18_4
		var_18_2[var_18_3] = (arg_18_0[var_18_3][var_18_1] + arg_18_0[var_18_1][var_18_3]) * var_18_5
		var_18_2[var_0_20[var_0_20[var_18_1]]] = (arg_18_0[var_0_20[var_0_20[var_18_1]]][var_18_1] + arg_18_0[var_18_1][var_0_20[var_0_20[var_18_1]]]) * var_18_5

		arg_18_1:Set(var_18_2[1], var_18_2[2], var_18_2[3], (arg_18_0[var_0_20[var_0_20[var_18_1]]][var_18_3] - arg_18_0[var_18_3][var_0_20[var_0_20[var_18_1]]]) * var_18_5)
		arg_18_1:SetNormalize()
	end

	return
end

function var_0_21:SetFromToRotation(arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1:Normalize()
	arg_19_2 = arg_19_2:Normalize()

	local var_19_0 = var_0_15.Dot(arg_19_1, arg_19_2)

	if var_19_0 > 0.999999 then
		self:Set(0, 0, 0, 1)
	elseif var_19_0 < -0.999999 then
		local var_19_1 = {
			0,
			arg_19_1.z,
			arg_19_1.y
		}
		local var_19_2 = var_19_1[2] * var_19_1[2] + var_19_1[3] * var_19_1[3]

		if var_19_1[2] * var_19_1[2] + var_19_1[3] * var_19_1[3] < 1e-06 then
			var_19_1[1] = -arg_19_1.z
			var_19_1[2] = 0
			var_19_1[3] = arg_19_1.x
			var_19_2 = var_19_1[1] * var_19_1[1] + var_19_1[3] * var_19_1[3]
		end

		local var_19_3 = 1 / var_0_4(var_19_2)

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

		var_0_24({
			{
				-arg_19_1.x * arg_19_1.x + var_19_4[1] * var_19_4[1] + -var_19_1[1] * var_19_1[1],
				-arg_19_1.x * arg_19_1.y + var_19_4[1] * var_19_4[2] + -var_19_1[1] * var_19_1[2],
				-arg_19_1.x * arg_19_1.z + var_19_4[1] * var_19_4[3] + -var_19_1[1] * var_19_1[3]
			},
			{
				-arg_19_1.x * arg_19_1.y + var_19_4[1] * var_19_4[2] + -var_19_1[1] * var_19_1[2],
				-arg_19_1.y * arg_19_1.y + var_19_4[2] * var_19_4[2] + -var_19_1[2] * var_19_1[2],
				-arg_19_1.y * arg_19_1.z + var_19_4[2] * var_19_4[3] + -var_19_1[2] * var_19_1[3]
			},
			{
				-arg_19_1.x * arg_19_1.z + var_19_4[1] * var_19_4[3] + -var_19_1[1] * var_19_1[3],
				-arg_19_1.y * arg_19_1.z + var_19_4[2] * var_19_4[3] + -var_19_1[2] * var_19_1[3],
				-arg_19_1.z * arg_19_1.z + var_19_4[3] * var_19_4[3] + -var_19_1[3] * var_19_1[3]
			}
		}, self)
	else
		local var_19_5 = var_0_15.Cross(arg_19_1, arg_19_2)
		local var_19_6 = (1 - var_19_0) / var_0_15.Dot(var_19_5, var_19_5)

		var_0_24({
			{
				var_19_0 + var_19_6 * var_19_5.x * var_19_5.x,
				var_19_6 * var_19_5.x * var_19_5.y - var_19_5.z,
				var_19_6 * var_19_5.x * var_19_5.z + var_19_5.y
			},
			{
				var_19_6 * var_19_5.x * var_19_5.y + var_19_5.z,
				var_19_0 + var_19_6 * var_19_5.y * var_19_5.y,
				var_19_6 * var_19_5.z * var_19_5.y - var_19_5.x
			},
			{
				var_19_6 * var_19_5.x * var_19_5.z - var_19_5.y,
				var_19_6 * var_19_5.z * var_19_5.y + var_19_5.x,
				var_19_0 + var_19_6 * var_19_5.z * var_19_5.z
			}
		}, self)
	end

	return
end

function var_0_21:Inverse()
	local var_20_0 = var_0_21.New()

	var_20_0.x = -self.x
	var_20_0.y = -self.y
	var_20_0.z = -self.z
	var_20_0.w = self.w

	return var_20_0
end

function var_0_21:Lerp(arg_21_1, arg_21_2)
	arg_21_2 = var_0_9(arg_21_2, 0, 1)

	local var_21_0 = {
		w = 1,
		z = 0,
		x = 0,
		y = 0
	}

	if var_0_21.Dot(self, arg_21_1) < 0 then
		var_21_0.x = self.x + arg_21_2 * (-arg_21_1.x - self.x)
		var_21_0.y = self.y + arg_21_2 * (-arg_21_1.y - self.y)
		var_21_0.z = self.z + arg_21_2 * (-arg_21_1.z - self.z)
		var_21_0.w = self.w + arg_21_2 * (-arg_21_1.w - self.w)
	else
		var_21_0.x = self.x + (arg_21_1.x - self.x) * arg_21_2
		var_21_0.y = self.y + (arg_21_1.y - self.y) * arg_21_2
		var_21_0.z = self.z + (arg_21_1.z - self.z) * arg_21_2
		var_21_0.w = self.w + (arg_21_1.w - self.w) * arg_21_2
	end

	var_0_21.SetNormalize(var_21_0)
	var_0_11(var_21_0, var_0_21)

	return var_21_0
end

function var_0_21:LookRotation(arg_22_1)
	local var_22_0 = self:Magnitude()

	if var_22_0 < 1e-06 then
		error("error input forward to Quaternion.LookRotation" .. tostring(self))

		return nil
	end

	self = self / var_22_0
	arg_22_1 = arg_22_1 or var_0_19

	local var_22_1 = var_0_15.Cross(arg_22_1, self)

	var_22_1:SetNormalize()

	arg_22_1 = var_0_15.Cross(self, var_22_1)

	local var_22_2 = var_0_15.Cross(arg_22_1, self)

	if var_22_2.x + arg_22_1.y + self.z > 0 then
		local var_22_7 = 0.5 / var_0_4(var_22_2.x + arg_22_1.y + self.z + 1)
		local var_22_8 = var_0_23((arg_22_1.z - self.y) * var_22_7, (self.x - var_22_2.z) * var_22_7, (var_22_2.y - arg_22_1.x) * var_22_7, var_22_7 * (var_22_2.x + arg_22_1.y + self.z + 1))

		var_22_8:SetNormalize()

		return var_22_8
	else
		local var_22_9 = {
			{
				var_22_2.x,
				arg_22_1.x,
				self.x
			},
			{
				var_22_2.y,
				arg_22_1.y,
				self.y
			},
			{
				var_22_2.z,
				arg_22_1.z,
				self.z
			}
		}
		local var_22_10 = {
			0,
			0,
			0
		}
		local var_22_11 = 1

		if arg_22_1.y > var_22_2.x then
			var_22_11 = 2
		end

		if self.z > var_22_9[var_22_11][var_22_11] then
			var_22_11 = 3
		end

		local var_22_12 = var_0_20[var_22_11]
		local var_22_13 = var_22_9[var_22_11][var_22_11] - var_22_9[var_0_20[var_22_11]][var_0_20[var_22_11]] - var_22_9[var_0_20[var_0_20[var_22_11]]][var_0_20[var_0_20[var_22_11]]] + 1
		local var_22_14 = 0.5 / var_0_4(var_22_13)

		var_22_10[var_22_11] = var_22_14 * var_22_13
		var_22_10[var_22_12] = (var_22_9[var_22_12][var_22_11] + var_22_9[var_22_11][var_22_12]) * var_22_14
		var_22_10[var_0_20[var_0_20[var_22_11]]] = (var_22_9[var_0_20[var_0_20[var_22_11]]][var_22_11] + var_22_9[var_22_11][var_0_20[var_0_20[var_22_11]]]) * var_22_14

		local var_22_15 = var_0_23(var_22_10[1], var_22_10[2], var_22_10[3], (var_22_9[var_0_20[var_0_20[var_22_11]]][var_22_12] - var_22_9[var_22_12][var_0_20[var_0_20[var_22_11]]]) * var_22_14)

		var_22_15:SetNormalize()

		return var_22_15
	end

	return
end

function var_0_21.SetIdentity(arg_23_0)
	arg_23_0.x = 0
	arg_23_0.y = 0
	arg_23_0.z = 0
	arg_23_0.w = 1

	return
end

local function var_0_25(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.x * arg_24_1.x + arg_24_0.y * arg_24_1.y + arg_24_0.z * arg_24_1.z + arg_24_0.w * arg_24_1.w

	if arg_24_0.x * arg_24_1.x + arg_24_0.y * arg_24_1.y + arg_24_0.z * arg_24_1.z + arg_24_0.w * arg_24_1.w < 0 then
		var_24_0 = -var_24_0
		arg_24_1 = var_0_11({
			x = -arg_24_1.x,
			y = -arg_24_1.y,
			z = -arg_24_1.z,
			w = -arg_24_1.w
		}, var_0_21)
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

		var_0_11(arg_24_0, var_0_21)

		return arg_24_0
	else
		arg_24_0 = {
			x = arg_24_0.x + arg_24_2 * (arg_24_1.x - arg_24_0.x),
			y = arg_24_0.y + arg_24_2 * (arg_24_1.y - arg_24_0.y),
			z = arg_24_0.z + arg_24_2 * (arg_24_1.z - arg_24_0.z),
			w = arg_24_0.w + arg_24_2 * (arg_24_1.w - arg_24_0.w)
		}

		var_0_21.SetNormalize(arg_24_0)
		var_0_11(arg_24_0, var_0_21)

		return arg_24_0
	end

	return
end

function var_0_21.Slerp(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 < 0 then
		arg_25_2 = 0
	elseif arg_25_2 > 1 then
		arg_25_2 = 1
	end

	return var_0_25(arg_25_0, arg_25_1, arg_25_2)
end

function var_0_21.RotateTowards(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = var_0_21.Angle(arg_26_0, arg_26_1)

	if var_26_0 == 0 then
		return arg_26_1
	end

	return var_0_25(arg_26_0, arg_26_1, (var_0_5(1, arg_26_2 / var_26_0)))
end

local function var_0_26(arg_27_0, arg_27_1)
	return var_0_10(arg_27_0 - arg_27_1) < 1e-06
end

function var_0_21:ToAngleAxis()
	if var_0_26(2 * var_0_2(self.w), 0) then
		local var_28_2 = var_0_15.New(1, 0, 0)

		return
	end

	local var_28_3 = 1 / var_0_4(1 - var_0_4(self.w))
	local var_28_5 = var_0_15.New(self.x * var_28_3, self.y * var_28_3, self.z * var_28_3)
end

local var_0_27 = Mathf.PI * 0.5
local var_0_28 = 2 * Mathf.PI
local var_0_29 = -0.0001
local var_0_30 = 2 * Mathf.PI - 0.0001

local function var_0_31(arg_29_0)
	if arg_29_0.x < var_0_29 then
		arg_29_0.x = arg_29_0.x + var_0_28
	elseif arg_29_0.x > var_0_30 then
		arg_29_0.x = arg_29_0.x - var_0_28
	end

	if arg_29_0.y < var_0_29 then
		arg_29_0.y = arg_29_0.y + var_0_28
	elseif arg_29_0.y > var_0_30 then
		arg_29_0.y = arg_29_0.y - var_0_28
	end

	if arg_29_0.z < var_0_29 then
		arg_29_0.z = arg_29_0.z + var_0_28
	elseif arg_29_0.z > var_0_30 then
		arg_29_0.z = arg_29_0.z + var_0_28
	end

	return
end

function var_0_21:ToEulerAngles()
	if 2 * (self.y * self.z - self.w * self.x) < 0.999 then
		if 2 * (self.y * self.z - self.w * self.x) > -0.999 then
			local var_30_0 = var_0_15.New(-var_0_3(2 * (self.y * self.z - self.w * self.x)), var_0_8(2 * (self.x * self.z + self.w * self.y), 1 - 2 * (self.x * self.x + self.y * self.y)), var_0_8(2 * (self.x * self.y + self.w * self.z), 1 - 2 * (self.x * self.x + self.z * self.z)))

			var_0_31(var_30_0)
			var_30_0:Mul(var_0_16)

			return var_30_0
		else
			local var_30_1 = var_0_15.New(var_0_27, var_0_8(2 * (self.x * self.y - self.w * self.z), 1 - 2 * (self.y * self.y + self.z * self.z)), 0)

			var_0_31(var_30_1)
			var_30_1:Mul(var_0_16)

			return var_30_1
		end
	else
		local var_30_2 = var_0_15.New(-var_0_27, var_0_8(-2 * (self.x * self.y - self.w * self.z), 1 - 2 * (self.y * self.y + self.z * self.z)), 0)

		var_0_31(var_30_2)
		var_30_2:Mul(var_0_16)

		return var_30_2
	end

	return
end

function var_0_21:Forward()
	return self:MulVec3(var_0_18)
end

function var_0_21:MulVec3(arg_32_1)
	local var_32_0 = var_0_15.New()

	var_32_0.x = (1 - (self.y * (self.y * 2) + self.z * (self.z * 2))) * arg_32_1.x + (self.x * (self.y * 2) - self.w * (self.z * 2)) * arg_32_1.y + (self.x * (self.z * 2) + self.w * (self.y * 2)) * arg_32_1.z
	var_32_0.y = (self.x * (self.y * 2) + self.w * (self.z * 2)) * arg_32_1.x + (1 - (self.x * (self.x * 2) + self.z * (self.z * 2))) * arg_32_1.y + (self.y * (self.z * 2) - self.w * (self.x * 2)) * arg_32_1.z
	var_32_0.z = (self.x * (self.z * 2) - self.w * (self.y * 2)) * arg_32_1.x + (self.y * (self.z * 2) + self.w * (self.x * 2)) * arg_32_1.y + (1 - (self.x * (self.x * 2) + self.y * (self.y * 2))) * arg_32_1.z

	return var_32_0
end

function var_0_21:__mul(arg_33_1)
	if var_0_21 == var_0_12(arg_33_1) then
		return var_0_21.New(self.w * arg_33_1.x + self.x * arg_33_1.w + self.y * arg_33_1.z - self.z * arg_33_1.y, self.w * arg_33_1.y + self.y * arg_33_1.w + self.z * arg_33_1.x - self.x * arg_33_1.z, self.w * arg_33_1.z + self.z * arg_33_1.w + self.x * arg_33_1.y - self.y * arg_33_1.x, self.w * arg_33_1.w - self.x * arg_33_1.x - self.y * arg_33_1.y - self.z * arg_33_1.z)
	elseif var_0_15 == var_0_12(arg_33_1) then
		return self:MulVec3(arg_33_1)
	end

	return
end

function var_0_21:__unm()
	return var_0_21.New(-self.x, -self.y, -self.z, -self.w)
end

function var_0_21.__eq(arg_35_0, arg_35_1)
	return var_0_21.Dot(arg_35_0, arg_35_1) > 0.999999
end

function var_0_21:__tostring()
	return "[" .. self.x .. "," .. self.y .. "," .. self.z .. "," .. self.w .. "]"
end

function var_0_22.identity()
	return var_0_23(0, 0, 0, 1)
end

var_0_22.eulerAngles = var_0_21.ToEulerAngles
UnityEngine.Quaternion = var_0_21

setmetatable(var_0_21, var_0_21)

return var_0_21
