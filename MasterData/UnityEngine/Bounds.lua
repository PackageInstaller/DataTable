local var_0_0 = rawget
local var_0_1 = setmetatable
local var_0_2 = type
local var_0_3 = Vector3
local var_0_4 = var_0_3.zero
local var_0_5 = {
	center = var_0_3.zero,
	extents = var_0_3.zero
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

function var_0_5.Get(arg_4_0)
	local var_4_0 = arg_4_0:GetSize()

	return arg_4_0.center, var_4_0
end

function var_0_5.GetSize(arg_5_0)
	return arg_5_0.extents * 2
end

function var_0_5.SetSize(arg_6_0, arg_6_1)
	arg_6_0.extents = arg_6_1 * 0.5
end

function var_0_5.GetMin(arg_7_0)
	return arg_7_0.center - arg_7_0.extents
end

function var_0_5.SetMin(arg_8_0, arg_8_1)
	arg_8_0:SetMinMax(arg_8_1, arg_8_0:GetMax())
end

function var_0_5.GetMax(arg_9_0)
	return arg_9_0.center + arg_9_0.extents
end

function var_0_5.SetMax(arg_10_0, arg_10_1)
	arg_10_0:SetMinMax(arg_10_0:GetMin(), arg_10_1)
end

function var_0_5.SetMinMax(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.extents = (arg_11_2 - arg_11_1) * 0.5
	arg_11_0.center = arg_11_1 + arg_11_0.extents
end

function var_0_5.Encapsulate(arg_12_0, arg_12_1)
	arg_12_0:SetMinMax(var_0_3.Min(arg_12_0:GetMin(), arg_12_1), var_0_3.Max(arg_12_0:GetMax(), arg_12_1))
end

function var_0_5.Expand(arg_13_0, arg_13_1)
	if var_0_2(arg_13_1) == "number" then
		arg_13_1 = arg_13_1 * 0.5

		arg_13_0.extents:Add(var_0_3.New(arg_13_1, arg_13_1, arg_13_1))
	else
		arg_13_0.extents:Add(arg_13_1 * 0.5)
	end
end

function var_0_5.Intersects(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetMin()
	local var_14_1 = arg_14_0:GetMax()
	local var_14_2 = arg_14_1:GetMin()
	local var_14_3 = arg_14_1:GetMax()

	return var_14_0.x <= var_14_3.x and var_14_1.x >= var_14_2.x and var_14_0.y <= var_14_3.y and var_14_1.y >= var_14_2.y and var_14_0.z <= var_14_3.z and var_14_1.z >= var_14_2.z
end

function var_0_5.Contains(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetMin()
	local var_15_1 = arg_15_0:GetMax()

	if arg_15_1.x < var_15_0.x or arg_15_1.y < var_15_0.y or arg_15_1.z < var_15_0.z or arg_15_1.x > var_15_1.x or arg_15_1.y > var_15_1.y or arg_15_1.z > var_15_1.z then
		return false
	end

	return true
end

function var_0_5.IntersectRay(arg_16_0, arg_16_1)
	local var_16_0 = -Mathf.Infinity
	local var_16_1 = Mathf.Infinity
	local var_16_2
	local var_16_3
	local var_16_4
	local var_16_5 = arg_16_0:GetCenter() - arg_16_1:GetOrigin()
	local var_16_6 = {
		var_16_5.x,
		var_16_5.y,
		var_16_5.z
	}
	local var_16_7 = arg_16_0.extents
	local var_16_8 = {
		var_16_7.x,
		var_16_7.y,
		var_16_7.z
	}
	local var_16_9 = arg_16_1:GetDirection()
	local var_16_10 = {
		var_16_9.x,
		var_16_9.y,
		var_16_9.z
	}

	for iter_16_0 = 1, 3 do
		local var_16_11 = 1 / var_16_10[iter_16_0]
		local var_16_12 = (var_16_6[iter_16_0] + var_16_8[iter_16_0]) * var_16_11
		local var_16_13 = (var_16_6[iter_16_0] - var_16_8[iter_16_0]) * var_16_11

		if var_16_12 < var_16_13 then
			if var_16_0 < var_16_12 then
				var_16_0 = var_16_12
			end

			if var_16_13 < var_16_1 then
				var_16_1 = var_16_13
			end

			if var_16_1 < var_16_0 then
				return false
			end

			if var_16_1 < 0 then
				return false
			end
		else
			if var_16_0 < var_16_13 then
				var_16_0 = var_16_13
			end

			if var_16_12 < var_16_1 then
				var_16_1 = var_16_12
			end

			if var_16_1 < var_16_0 then
				return false
			end

			if var_16_1 < 0 then
				return false
			end
		end
	end

	return true, var_16_0
end

function var_0_5.ClosestPoint(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 - arg_17_0:GetCenter()
	local var_17_1 = {
		var_17_0.x,
		var_17_0.y,
		var_17_0.z
	}
	local var_17_2 = arg_17_0.extents
	local var_17_3 = {
		var_17_2.x,
		var_17_2.y,
		var_17_2.z
	}
	local var_17_4 = 0
	local var_17_5

	for iter_17_0 = 1, 3 do
		if var_17_1[iter_17_0] < -var_17_3[iter_17_0] then
			local var_17_6 = var_17_1[iter_17_0] + var_17_3[iter_17_0]

			var_17_4 = var_17_4 + var_17_6 * var_17_6
			var_17_1[iter_17_0] = -var_17_3[iter_17_0]
		elseif var_17_1[iter_17_0] > var_17_3[iter_17_0] then
			local var_17_7 = var_17_1[iter_17_0] - var_17_3[iter_17_0]

			var_17_4 = var_17_4 + var_17_7 * var_17_7
			var_17_1[iter_17_0] = var_17_3[iter_17_0]
		end
	end

	if var_17_4 == 0 then
		return arg_17_1, 0
	else
		outPoint = var_17_1 + arg_17_0:GetCenter()

		return outPoint, var_17_4
	end
end

function var_0_5.Destroy(arg_18_0)
	arg_18_0.center = nil
	arg_18_0.size = nil
end

function var_0_5.__tostring(arg_19_0)
	return string.format("Center: %s, Extents %s", tostring(arg_19_0.center), tostring(arg_19_0.extents))
end

function var_0_5.__eq(arg_20_0, arg_20_1)
	return arg_20_0.center == arg_20_1.center and arg_20_0.extents == arg_20_1.extents
end

var_0_6.size = var_0_5.GetSize
var_0_6.min = var_0_5.GetMin
var_0_6.max = var_0_5.GetMax
UnityEngine.Bounds = var_0_5

var_0_1(var_0_5, var_0_5)

return var_0_5
