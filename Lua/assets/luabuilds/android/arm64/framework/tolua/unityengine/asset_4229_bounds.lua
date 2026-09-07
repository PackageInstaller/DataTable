local var_0_0 = rawget
local var_0_1 = setmetatable
local var_0_2 = type
local var_0_3 = Vector3
local var_0_5 = {
	center = Vector3.zero,
	extents = Vector3.zero
}
local var_0_6 = tolua.initget(var_0_5)

function var_0_5.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0(var_0_5, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_0(var_0_6, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_5.__call(arg_2_0, arg_2_1, arg_2_2)
	return var_0_1({
		center = arg_2_1,
		extents = arg_2_2 * 0.5
	}, var_0_5)
end

function var_0_5.New(arg_3_0, arg_3_1)
	return var_0_1({
		center = arg_3_0,
		extents = arg_3_1 * 0.5
	}, var_0_5)
end

function var_0_5:Get()
	return self.center, (self:GetSize())
end

function var_0_5:GetSize()
	return self.extents * 2
end

function var_0_5.SetSize(arg_6_0, arg_6_1)
	arg_6_0.extents = arg_6_1 * 0.5

	return
end

function var_0_5:GetMin()
	return self.center - self.extents
end

function var_0_5:SetMin(arg_8_1)
	self:SetMinMax(arg_8_1, self:GetMax())

	return
end

function var_0_5:GetMax()
	return self.center + self.extents
end

function var_0_5:SetMax(arg_10_1)
	self:SetMinMax(self:GetMin(), arg_10_1)

	return
end

function var_0_5:SetMinMax(arg_11_1, arg_11_2)
	self.extents = (arg_11_2 - arg_11_1) * 0.5
	self.center = arg_11_1 + self.extents

	return
end

function var_0_5:Encapsulate(arg_12_1)
	self:SetMinMax(var_0_3.Min(self:GetMin(), arg_12_1), var_0_3.Max(self:GetMax(), arg_12_1))

	return
end

function var_0_5:Expand(arg_13_1)
	if var_0_2(arg_13_1) == "number" then
		arg_13_1 = arg_13_1 * 0.5

		self.extents:Add(var_0_3.New(arg_13_1, arg_13_1, arg_13_1))
	else
		self.extents:Add(arg_13_1 * 0.5)
	end

	return
end

function var_0_5:Intersects(arg_14_1)
	local var_14_0 = self:GetMin()
	local var_14_1 = self:GetMax()
	local var_14_2 = arg_14_1:GetMin()
	local var_14_3 = arg_14_1:GetMax()

	return var_14_0.x <= var_14_3.x and var_14_1.x >= var_14_2.x and var_14_0.y <= var_14_3.y and var_14_1.y >= var_14_2.y and var_14_0.z <= var_14_3.z and var_14_1.z >= var_14_2.z
end

function var_0_5:Contains(arg_15_1)
	local var_15_0 = self:GetMin()
	local var_15_1 = self:GetMax()

	if arg_15_1.x < var_15_0.x or arg_15_1.y < var_15_0.y or arg_15_1.z < var_15_0.z or arg_15_1.x > var_15_1.x or arg_15_1.y > var_15_1.y or arg_15_1.z > var_15_1.z then
		return false
	end

	return true
end

function var_0_5:GetCenter()
	return self.center
end

function var_0_5:IntersectRay(arg_17_1)
	local var_17_0 = -Mathf.Infinity
	local var_17_1 = Mathf.Infinity
	local var_17_5 = self:GetCenter() - arg_17_1:GetOrigin()
	local var_17_6 = {
		var_17_5.x,
		var_17_5.y,
		var_17_5.z
	}
	local var_17_7 = {
		self.extents.x,
		self.extents.y,
		self.extents.z
	}
	local var_17_8 = arg_17_1:GetDirection()
	local var_17_9 = {
		var_17_8.x,
		var_17_8.y,
		var_17_8.z
	}

	for iter_17_0 = 1, 3 do
		if (var_17_6[iter_17_0] + var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0]) < (var_17_6[iter_17_0] - var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0]) then
			if var_17_0 < (var_17_6[iter_17_0] + var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0]) then
				var_17_0 = (var_17_6[iter_17_0] + var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0])
			end

			if (var_17_6[iter_17_0] - var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0]) < var_17_1 then
				var_17_1 = (var_17_6[iter_17_0] - var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0])
			end

			if var_17_1 < var_17_0 then
				return false
			end

			if var_17_1 < 0 then
				return false
			end
		else
			if var_17_0 < (var_17_6[iter_17_0] - var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0]) then
				var_17_0 = (var_17_6[iter_17_0] - var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0])
			end

			if (var_17_6[iter_17_0] + var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0]) < var_17_1 then
				var_17_1 = (var_17_6[iter_17_0] + var_17_7[iter_17_0]) * (1 / var_17_9[iter_17_0])
			end

			if var_17_1 < var_17_0 then
				return false
			end

			if var_17_1 < 0 then
				return false
			end
		end
	end

	return true, var_17_0
end

function var_0_5:ClosestPoint(arg_18_1)
	local var_18_0 = arg_18_1 - self:GetCenter()
	local var_18_1 = {
		var_18_0.x,
		var_18_0.y,
		var_18_0.z
	}
	local var_18_2 = {
		self.extents.x,
		self.extents.y,
		self.extents.z
	}
	local var_18_3 = 0

	for iter_18_0 = 1, 3 do
		if var_18_1[iter_18_0] < -var_18_2[iter_18_0] then
			var_18_3 = var_18_3 + (var_18_1[iter_18_0] + var_18_2[iter_18_0]) * (var_18_1[iter_18_0] + var_18_2[iter_18_0])
			var_18_1[iter_18_0] = -var_18_2[iter_18_0]
		elseif var_18_1[iter_18_0] > var_18_2[iter_18_0] then
			var_18_3 = var_18_3 + (var_18_1[iter_18_0] - var_18_2[iter_18_0]) * (var_18_1[iter_18_0] - var_18_2[iter_18_0])
			var_18_1[iter_18_0] = var_18_2[iter_18_0]
		end
	end

	if var_18_3 == 0 then
		return rkPoint, 0
	else
		outPoint = var_0_3(var_18_1[1], var_18_1[2], var_18_1[3]) + self:GetCenter()

		return outPoint, var_18_3
	end

	return
end

function var_0_5.Destroy(arg_19_0)
	arg_19_0.center = nil
	arg_19_0.size = nil

	return
end

function var_0_5:__tostring()
	return string.format("Center: %s, Extents %s", tostring(self.center), tostring(self.extents))
end

function var_0_5:__eq(arg_21_1)
	return self.center == arg_21_1.center and self.extents == arg_21_1.extents
end

var_0_6.size = var_0_5.GetSize
var_0_6.min = var_0_5.GetMin
var_0_6.max = var_0_5.GetMax
UnityEngine.Bounds = var_0_5

setmetatable(var_0_5, var_0_5)

return var_0_5
