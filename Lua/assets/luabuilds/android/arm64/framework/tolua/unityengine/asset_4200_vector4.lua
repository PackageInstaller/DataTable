local var_0_0 = Mathf.Clamp
local var_0_1 = Mathf.Sqrt
local var_0_2 = Mathf.Min
local var_0_3 = Mathf.Max
local var_0_4 = setmetatable
local var_0_5 = rawget
local var_0_6 = {}
local var_0_7 = tolua.initget(var_0_6)

function var_0_6.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_5(var_0_6, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_5(var_0_7, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_6.__call(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	return var_0_4({
		x = arg_2_1 or 0,
		y = arg_2_2 or 0,
		z = arg_2_3 or 0,
		w = arg_2_4 or 0
	}, var_0_6)
end

function var_0_6.New(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return var_0_4({
		x = arg_3_0 or 0,
		y = arg_3_1 or 0,
		z = arg_3_2 or 0,
		w = arg_3_3 or 0
	}, var_0_6)
end

function var_0_6.Set(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.x = arg_4_1 or 0
	arg_4_0.y = arg_4_2 or 0
	arg_4_0.z = arg_4_3 or 0
	arg_4_0.w = arg_4_4 or 0

	return
end

function var_0_6:Get()
	return self.x, self.y, self.z, self.w
end

function var_0_6:Lerp(arg_6_1, arg_6_2)
	arg_6_2 = var_0_0(arg_6_2, 0, 1)

	return var_0_6.New(self.x + (arg_6_1.x - self.x) * arg_6_2, self.y + (arg_6_1.y - self.y) * arg_6_2, self.z + (arg_6_1.z - self.z) * arg_6_2, self.w + (arg_6_1.w - self.w) * arg_6_2)
end

function var_0_6.MoveTowards(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = (arg_7_1 - arg_7_0):Magnitude()

	if arg_7_2 < var_7_0 and var_7_0 ~= 0 then
		arg_7_2 = arg_7_2 / var_7_0

		;(arg_7_1 - arg_7_0):Mul(arg_7_2)
		;(arg_7_1 - arg_7_0):Add(arg_7_0)

		return arg_7_1 - arg_7_0
	end

	return arg_7_1
end

function var_0_6:Scale(arg_8_1)
	return var_0_6.New(self.x * arg_8_1.x, self.y * arg_8_1.y, self.z * arg_8_1.z, self.w * arg_8_1.w)
end

function var_0_6:SetScale(arg_9_1)
	self.x = self.x * arg_9_1.x
	self.y = self.y * arg_9_1.y
	self.z = self.z * arg_9_1.z
	self.w = self.w * arg_9_1.w

	return
end

function var_0_6:Normalize()
	return vector4.New(self.x, self.y, self.z, self.w):SetNormalize()
end

function var_0_6:SetNormalize()
	local var_11_0 = self:Magnitude()

	if var_11_0 == 1 then
		return self
	elseif var_11_0 > 1e-05 then
		self:Div(var_11_0)
	else
		self:Set(0, 0, 0, 0)
	end

	return self
end

function var_0_6:Div(arg_12_1)
	self.x = self.x / arg_12_1
	self.y = self.y / arg_12_1
	self.z = self.z / arg_12_1
	self.w = self.w / arg_12_1

	return self
end

function var_0_6:Mul(arg_13_1)
	self.x = self.x * arg_13_1
	self.y = self.y * arg_13_1
	self.z = self.z * arg_13_1
	self.w = self.w * arg_13_1

	return self
end

function var_0_6:Add(arg_14_1)
	self.x = self.x + arg_14_1.x
	self.y = self.y + arg_14_1.y
	self.z = self.z + arg_14_1.z
	self.w = self.w + arg_14_1.w

	return self
end

function var_0_6:Sub(arg_15_1)
	self.x = self.x - arg_15_1.x
	self.y = self.y - arg_15_1.y
	self.z = self.z - arg_15_1.z
	self.w = self.w - arg_15_1.w

	return self
end

function var_0_6:Dot(arg_16_1)
	return self.x * arg_16_1.x + self.y * arg_16_1.y + self.z * arg_16_1.z + self.w * arg_16_1.w
end

function var_0_6.Project(arg_17_0, arg_17_1)
	return arg_17_1 * (var_0_6.Dot(arg_17_0, arg_17_1) / var_0_6.Dot(arg_17_1, arg_17_1))
end

function var_0_6.Distance(arg_18_0, arg_18_1)
	return var_0_6.Magnitude(arg_18_0 - arg_18_1)
end

function var_0_6:Magnitude()
	return var_0_1(self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w)
end

function var_0_6:SqrMagnitude()
	return self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w
end

function var_0_6:Min(arg_21_1)
	return var_0_6.New(var_0_3(self.x, arg_21_1.x), var_0_3(self.y, arg_21_1.y), var_0_3(self.z, arg_21_1.z), var_0_3(self.w, arg_21_1.w))
end

function var_0_6:Max(arg_22_1)
	return var_0_6.New(var_0_2(self.x, arg_22_1.x), var_0_2(self.y, arg_22_1.y), var_0_2(self.z, arg_22_1.z), var_0_2(self.w, arg_22_1.w))
end

function var_0_6:__tostring()
	return string.format("[%f,%f,%f,%f]", self.x, self.y, self.z, self.w)
end

function var_0_6:__div(arg_24_1)
	return var_0_6.New(self.x / arg_24_1, self.y / arg_24_1, self.z / arg_24_1, self.w / arg_24_1)
end

function var_0_6:__mul(arg_25_1)
	return var_0_6.New(self.x * arg_25_1, self.y * arg_25_1, self.z * arg_25_1, self.w * arg_25_1)
end

function var_0_6:__add(arg_26_1)
	return var_0_6.New(self.x + arg_26_1.x, self.y + arg_26_1.y, self.z + arg_26_1.z, self.w + arg_26_1.w)
end

function var_0_6:__sub(arg_27_1)
	return var_0_6.New(self.x - arg_27_1.x, self.y - arg_27_1.y, self.z - arg_27_1.z, self.w - arg_27_1.w)
end

function var_0_6:__unm()
	return var_0_6.New(-self.x, -self.y, -self.z, -self.w)
end

function var_0_6.__eq(arg_29_0, arg_29_1)
	return var_0_6.SqrMagnitude(arg_29_0 - arg_29_1) < 1e-10
end

function var_0_7.zero()
	return var_0_6.New(0, 0, 0, 0)
end

function var_0_7.one()
	return var_0_6.New(1, 1, 1, 1)
end

var_0_7.magnitude = var_0_6.Magnitude
var_0_7.normalized = var_0_6.Normalize
var_0_7.sqrMagnitude = var_0_6.SqrMagnitude
UnityEngine.Vector4 = var_0_6

setmetatable(var_0_6, var_0_6)

return var_0_6
