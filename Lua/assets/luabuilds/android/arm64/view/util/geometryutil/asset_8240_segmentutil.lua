local var_0_0 = {}
local var_0_1 = 1e-06

local function var_0_2(arg_1_0)
	return arg_1_0 >= -var_0_1 and arg_1_0 <= var_0_1
end

local function var_0_3(arg_2_0)
	if var_0_0.IsZero(arg_2_0) then
		return 0
	else
		return arg_2_0
	end

	return
end

local function var_0_4(arg_3_0)
	if arg_3_0 < -var_0_1 then
		return -1
	elseif arg_3_0 <= var_0_1 then
		return 0
	else
		return 1
	end

	return
end

local function var_0_5(arg_4_0, arg_4_1)
	local var_4_0 = Vector2.Min(arg_4_0, arg_4_1)
	local var_4_1 = Vector2.Max(arg_4_0, arg_4_1)
end

local function var_0_6(arg_5_0, arg_5_1)
	return arg_5_0.x * arg_5_1.y - arg_5_0.y * arg_5_1.x
end

local function var_0_7(arg_6_0, arg_6_1)
	return arg_6_0.x * arg_6_1.x + arg_6_0.y * arg_6_1.y
end

local function var_0_8(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return var_0_3(var_0_6(arg_7_1 - arg_7_0, (arg_7_3 or nil) and (arg_7_3 - arg_7_2 or arg_7_2 - arg_7_0)))
end

local function var_0_9(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	return var_0_3(var_0_7(arg_8_1 - arg_8_0, (arg_8_3 or nil) and (arg_8_3 - arg_8_2 or arg_8_2 - arg_8_0)))
end

local function var_0_10(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = var_0_8(arg_11_0, arg_11_2, arg_11_1)
	local var_11_1 = var_0_8(arg_11_0, arg_11_1, arg_11_3)
	local var_11_2 = var_0_4(var_11_0) == 0 and var_0_4(var_11_1)

	if var_11_0 * var_11_1 < -var_0_1 then
		return false
	end

	return var_0_8(arg_11_2, arg_11_3, arg_11_0) * var_0_8(arg_11_2, arg_11_1, arg_11_3) >= -var_0_1, var_11_2
end

var_0_0.IsZero = var_0_2
var_0_0.DistinguishZero = var_0_3
var_0_0.Sign = var_0_4
var_0_0.GetRect = var_0_5
var_0_0.VectorCross = var_0_8
var_0_0.VectorDot = var_0_9

function var_0_0.IsRectCross(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0, var_9_1 = var_0_5(arg_9_0, arg_9_1)
	local var_9_2, var_9_3 = var_0_5(arg_9_2, arg_9_3)

	return var_9_0.x <= var_9_3.x and var_9_2.x <= var_9_1.x and var_9_0.y <= var_9_3.y and var_9_2.y <= var_9_1.y
end

function var_0_0:GetCrossPoint(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0, var_14_1 = var_0_10(self, arg_14_1, arg_14_2, arg_14_3)

	if not var_14_0 then
		return false
	end

	local var_14_2 = arg_14_1.x - self.x

	if var_0_2((arg_14_1.x - self.x) * (arg_14_3.y - arg_14_2.y) - (arg_14_1.y - self.y) * (arg_14_3.x - arg_14_2.x)) then
		return false
	end

	local var_14_4 = Vector2((-(arg_14_3.x - arg_14_2.x) * (self.x * arg_14_1.y - self.y * arg_14_1.x) - -var_14_2 * (arg_14_2.x * arg_14_3.y - arg_14_2.y * arg_14_3.x)) / ((arg_14_1.x - self.x) * (arg_14_3.y - arg_14_2.y) - (arg_14_1.y - self.y) * (arg_14_3.x - arg_14_2.x)), (-(arg_14_3.y - arg_14_2.y) * (self.x * arg_14_1.y - self.y * arg_14_1.x) - -(arg_14_1.y - self.y) * (arg_14_2.x * arg_14_3.y - arg_14_2.y * arg_14_3.x)) / ((arg_14_1.x - self.x) * (arg_14_3.y - arg_14_2.y) - (arg_14_1.y - self.y) * (arg_14_3.x - arg_14_2.x)))
end

function var_0_0:IntersectLineandSegament(arg_10_1, arg_10_2, arg_10_3)
	if var_0_2(arg_10_1.x - self.x) then
		return var_0_4(arg_10_2.x - self.x) * var_0_4(self.x - arg_10_3.x) >= 0
	end

	return var_0_4((arg_10_1.y - self.y) / (arg_10_1.x - self.x) * arg_10_2.x + (arg_10_1.y - (arg_10_1.y - self.y) / (arg_10_1.x - self.x) * arg_10_1.x) - arg_10_2.y) * var_0_4((arg_10_1.y - self.y) / (arg_10_1.x - self.x) * arg_10_3.x + (arg_10_1.y - (arg_10_1.y - self.y) / (arg_10_1.x - self.x) * arg_10_1.x) - arg_10_3.y) <= 0
end

var_0_0.IsSegamentTouch = var_0_10

function var_0_0.IsSegamentCross(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = var_0_8(arg_12_0, arg_12_2, arg_12_1)

	if var_12_0 * var_0_8(arg_12_0, arg_12_1, arg_12_3) <= var_0_1 then
		return false
	end

	local var_12_1 = var_0_8(arg_12_2, arg_12_3, arg_12_0) * var_0_8(arg_12_2, arg_12_1, arg_12_3) > var_0_1
	local var_12_2 = var_0_4(var_12_0)
end

function var_0_0.IsSegamentParallel(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	return var_0_2(var_0_8(arg_13_0, arg_13_1, arg_13_2, arg_13_3)), var_0_9(arg_13_1, arg_13_0, arg_13_2, arg_13_3) <= var_0_1
end

return var_0_0
