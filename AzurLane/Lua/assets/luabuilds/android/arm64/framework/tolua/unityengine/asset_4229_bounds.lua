rawget = var_0_10000
setmetatable = var_0_10001
type = var_0_10002
Vector3 = var_0_10003

local var_0_0 = var_0_10003.zero
local var_0_1 = {
	center = var_0_10003.zero,
	extents = var_0_10003.zero
}

tolua = var_6

local var_0_2 = var_6.initget(var_0_1)

function var_0_1.__index(arg_1_0, arg_1_1)
	if var_0_10000(var_0_1, arg_1_1) == nil and var_0_10000(var_0_2, arg_1_1) ~= nil then
		return var_2(arg_1_0)
	end

	return var_2
end

function var_0_1.__call(arg_2_0, arg_2_1, arg_2_2)
	return var_0_10001({
		center = arg_2_1,
		extents = arg_2_2 * 0.5
	}, var_0_1)
end

function var_0_1.New(arg_3_0, arg_3_1)
	return var_0_10001({
		center = arg_3_0,
		extents = arg_3_1 * 0.5
	}, var_0_1)
end

function var_0_1.Get(arg_4_0)
	local var_4_0 = arg_4_0:GetSize()

	return arg_4_0.center, var_4_0
end

function var_0_1.GetSize(arg_5_0)
	return arg_5_0.extents * 2
end

function var_0_1.SetSize(arg_6_0, arg_6_1)
	arg_6_0.extents = arg_6_1 * 0.5

	return
end

function var_0_1.GetMin(arg_7_0)
	return arg_7_0.center - arg_7_0.extents
end

function var_0_1.SetMin(arg_8_0, arg_8_1)
	arg_8_0:SetMinMax(arg_8_1, arg_8_0:GetMax())

	return
end

function var_0_1.GetMax(arg_9_0)
	return arg_9_0.center + arg_9_0.extents
end

function var_0_1.SetMax(arg_10_0, arg_10_1)
	arg_10_0:SetMinMax(arg_10_0:GetMin(), arg_10_1)

	return
end

function var_0_1.SetMinMax(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.extents = (arg_11_2 - arg_11_1) * 0.5
	arg_11_0.center = arg_11_1 + arg_11_0.extents

	return
end

function var_0_1.Encapsulate(arg_12_0, arg_12_1)
	arg_12_0:SetMinMax(var_0_10003.Min(arg_12_0:GetMin(), arg_12_1), var_0_10003.Max(arg_12_0:GetMax(), arg_12_1))

	return
end

function var_0_1.Expand(arg_13_0, arg_13_1)
	if var_0_10002(arg_13_1) == "number" then
		arg_13_1 = arg_13_1 * 0.5

		local var_13_0 = arg_13_0.extents

		var_2.Add(var_13_0, var_0_10003.New(arg_13_1, arg_13_1, arg_13_1))
	else
		local var_13_1 = arg_13_0.extents

		var_2.Add(var_13_1, arg_13_1 * 0.5)
	end

	return
end

function var_0_1.Intersects(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetMin()
	local var_14_1 = arg_14_0:GetMax()
	local var_14_2 = arg_14_1:GetMin()
	local var_14_3 = arg_14_1:GetMax()

	return var_14_0.x <= var_14_3.x and var_14_1.x >= var_14_2.x and var_14_0.y <= var_14_3.y and var_14_1.y >= var_14_2.y and var_14_0.z <= var_14_3.z and var_14_1.z >= var_14_2.z
end

function var_0_1.Contains(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetMin()
	local var_15_1 = arg_15_0:GetMax()

	if arg_15_1.x < var_15_0.x or arg_15_1.y < var_15_0.y or arg_15_1.z < var_15_0.z or arg_15_1.x > var_15_1.x or arg_15_1.y > var_15_1.y or arg_15_1.z > var_15_1.z then
		return false
	end

	return true
end

function var_0_1.GetCenter(arg_16_0)
	return arg_16_0.center
end

function var_0_1.IntersectRay(arg_17_0, arg_17_1)
	Mathf = var_1_10002

	local var_17_0 = -var_1_10002.Infinity

	Mathf = var_1_10003

	local var_17_1 = var_1_10003.Infinity
	local var_17_2
	local var_17_3
	local var_17_4
	local var_17_5 = arg_17_0:GetCenter() - arg_17_1:GetOrigin()
	local var_17_6 = {
		var_17_5.x,
		var_17_5.y,
		var_17_5.z
	}
	local var_17_7 = arg_17_0.extents
	local var_17_8 = {
		var_17_7.x,
		var_17_7.y,
		var_17_7.z
	}
	local var_17_9 = arg_17_1:GetDirection()
	local var_17_10 = {
		var_17_9.x,
		var_17_9.y,
		var_17_9.z
	}

	for iter_17_0 = 1, 3 do
		local var_17_11 = 1 / var_17_10[iter_17_0]

		if (var_17_6[iter_17_0] + var_17_8[iter_17_0]) * var_17_11 < (var_17_6[iter_17_0] - var_17_8[iter_17_0]) * var_17_11 then
			if var_17_0 < var_4 then
				var_17_0 = var_4
			end

			if var_5 < var_17_1 then
				var_17_1 = var_5
			end

			if var_17_1 < var_17_0 then
				return false
			end

			if var_17_1 < 0 then
				return false
			end
		else
			if var_17_0 < var_5 then
				var_17_0 = var_5
			end

			if var_4 < var_17_1 then
				var_17_1 = var_4
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

function var_0_1.ClosestPoint(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 - arg_18_0:GetCenter()
	local var_18_1 = {
		var_18_0.x,
		var_18_0.y,
		var_18_0.z
	}
	local var_18_2 = arg_18_0.extents
	local var_18_3 = {
		var_18_2.x,
		var_18_2.y,
		var_18_2.z
	}
	local var_18_4 = 0
	local var_18_5

	for iter_18_0 = 1, 3 do
		if var_18_1[iter_18_0] < -var_18_3[iter_18_0] then
			var_18_4 = var_18_4 + var_7 * (var_18_1[iter_18_0] + var_18_3[iter_18_0])
			var_18_1[iter_18_0] = -var_18_3[iter_18_0]
		elseif var_18_1[iter_18_0] > var_18_3[iter_18_0] then
			var_18_4 = var_18_4 + var_7 * (var_18_1[iter_18_0] - var_18_3[iter_18_0])
			var_18_1[iter_18_0] = var_18_3[iter_18_0]
		end
	end

	if var_18_4 == 0 then
		rkPoint = var_8

		return var_8, 0
	else
		local var_18_6 = var_0_10003(var_18_1[1], var_18_1[2], var_18_1[3]) + arg_18_0:GetCenter()

		outPoint = outPoint

		return var_8, var_18_4
	end

	return
end

function var_0_1.Destroy(arg_19_0)
	arg_19_0.center = nil
	arg_19_0.size = nil

	return
end

function var_0_1.__tostring(arg_20_0)
	string = var_1_10001

	local var_20_0 = var_1_10001.format
	local var_20_1 = "Center: %s, Extents %s"

	tostring = var_1_10004

	local var_20_2 = var_1_10004(arg_20_0.center)

	tostring = var_1_10005

	return var_20_0(var_20_1, var_20_2, var_1_10005(arg_20_0.extents))
end

function var_0_1.__eq(arg_21_0, arg_21_1)
	return arg_21_0.center == arg_21_1.center and arg_21_0.extents == arg_21_1.extents
end

var_0_2.size = var_0_1.GetSize
var_0_2.min = var_0_1.GetMin
var_0_2.max = var_0_1.GetMax
UnityEngine = var_7
var_7.Bounds = var_0_1

var_0_10001(var_0_1, var_0_1)

return var_0_1
