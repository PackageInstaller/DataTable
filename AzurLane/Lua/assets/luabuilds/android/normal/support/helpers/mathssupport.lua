local function var_0_0()
	local var_1_0 = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"

	string = var_1_10001

	return var_1_10001.gsub(var_1_0, "[xy]", function(arg_2_0)
		if arg_2_0 == "x" then
			math = var_2_10001

			if not var_2_10001.random(0, 15) then
				math = var_2_10001
				var_2_10001 = var_2_10001.random(8, 11)
			end

			string = var_2_10002

			return var_2_10002.format("%x", var_2_10001)
		end
	end)
end

local var_0_1 = uuid

local function var_0_2(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	return (arg_3_0 - arg_3_1) / (arg_3_2 - arg_3_1) * (arg_3_4 - arg_3_3) + arg_3_3
end

local var_0_3 = map

local function var_0_4(arg_4_0)
	for iter_4_0 = #arg_4_0, 2, -1 do
		math = var_1_10005
		var_1_10005 = var_1_10005.random(iter_4_0)
		arg_4_0[var_1_10005], arg_4_0[iter_4_0] = arg_4_0[iter_4_0], arg_4_0[var_1_10005]
	end

	return
end

math = shuffle

local var_0_5 = var_0.floor

math = var_0_10001

local var_0_6 = var_0_10001.abs

math = var_0_10002

function var_0_10002.round(arg_5_0)
	return var_0_5(arg_5_0 + 0.5)
end

math = var_0_10002

function var_0_10002.sign(arg_6_0)
	arg_6_0 = arg_6_0 > 0 and 1 or arg_6_0 < 0 and -1 or 0

	return arg_6_0
end

math = var_0_10002

function var_0_10002.clamp(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0 < arg_7_1 then
		arg_7_0 = arg_7_1
	elseif arg_7_2 < arg_7_0 then
		arg_7_0 = arg_7_2
	end

	return arg_7_0
end

math = var_0_10002

local var_0_7 = var_0_10002.clamp

math = var_3

function var_3.lerp(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0 + (arg_8_1 - arg_8_0) * var_0_7(arg_8_2, 0, 1)
end

math = var_3

function var_3.Repeat(arg_9_0, arg_9_1)
	return arg_9_0 - var_0_5(arg_9_0 / arg_9_1) * arg_9_1
end

math = var_3

function var_3.LerpAngle(arg_10_0, arg_10_1, arg_10_2)
	math = var_1_10003

	local var_10_0

	if var_1_10003.Repeat(arg_10_1 - arg_10_0, 360) > 180 then
		var_10_0 = var_10_0 - 360
	end

	return arg_10_0 + var_10_0 * var_0_7(arg_10_2, 0, 1)
end

math = var_3

function var_3.MoveTowards(arg_11_0, arg_11_1, arg_11_2)
	if var_0_6(arg_11_1 - arg_11_0) <= arg_11_2 then
		return arg_11_1
	end

	math = var_3

	return arg_11_0 + var_3.sign(arg_11_1 - arg_11_0) * arg_11_2
end

math = var_3

function var_3.DeltaAngle(arg_12_0, arg_12_1)
	math = var_1_10002

	local var_12_0

	if var_1_10002.Repeat(arg_12_1 - arg_12_0, 360) > 180 then
		var_12_0 = var_12_0 - 360
	end

	return var_12_0
end

math = var_3

function var_3.MoveTowardsAngle(arg_13_0, arg_13_1, arg_13_2)
	math = var_1_10003
	arg_13_1 = arg_13_0 + var_1_10003.DeltaAngle(arg_13_0, arg_13_1)
	math = var_3

	return var_3.MoveTowards(arg_13_0, arg_13_1, arg_13_2)
end

math = var_3

function var_3.Approximately(arg_14_0, arg_14_1)
	local var_14_0 = var_0_6(arg_14_1 - arg_14_0)

	math = var_3

	local var_14_1 = var_3.max

	math = var_1_10004

	return var_14_0 < var_14_1(1e-06 * var_1_10004.max(var_0_6(arg_14_0), var_0_6(arg_14_1)), 1.121039e-44)
end

math = var_3

function var_3.InverseLerp(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0 < arg_15_1 then
		if arg_15_2 < arg_15_0 then
			return 0
		end

		if arg_15_1 < arg_15_2 then
			return 1
		end

		return (arg_15_2 - arg_15_0) / (arg_15_1 - arg_15_0)
	end

	if arg_15_0 <= arg_15_1 then
		return 0
	end

	if arg_15_2 < arg_15_1 then
		return 1
	end

	if arg_15_0 < arg_15_2 then
		return 0
	end

	return 1 - (arg_15_2 - arg_15_1) / (arg_15_0 - arg_15_1)
end

math = var_3

function var_3.PingPong(arg_16_0, arg_16_1)
	math = var_1_10002
	arg_16_0 = var_1_10002.Repeat(arg_16_0, arg_16_1 * 2)

	return arg_16_1 - var_0_6(arg_16_0 - arg_16_1)
end

math = var_3
math = var_4
var_3.deg2Rad = var_4.pi / 180
math = var_3
math = var_4
var_3.rad2Deg = 180 / var_4.pi
math = var_3
var_3.epsilon = 1.401298e-45
math = var_3

function var_3.Random(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 - arg_17_0

	math = var_1_10003

	return var_1_10003.random() * var_17_0 + arg_17_0
end

math = var_3

function var_3.isnan(arg_18_0)
	return arg_18_0 ~= arg_18_0
end

math = var_3

local var_0_8 = var_3.pi

math = var_4

local var_0_9 = 2 * var_4.pi

math = var_0_10005

local var_0_10 = var_0_10005.pi / 2

math = var_0_10006

function var_0_10006.sin16(arg_19_0)
	local var_19_0

	if arg_19_0 < 0 or arg_19_0 >= var_0_9 then
		arg_19_0 = arg_19_0 - var_0_5(arg_19_0 / var_0_9) * var_0_9
	end

	if arg_19_0 < var_0_8 then
		if arg_19_0 > var_0_10 then
			arg_19_0 = var_0_8 - arg_19_0
		end
	elseif arg_19_0 > var_0_8 + var_0_10 then
		arg_19_0 = arg_19_0 - var_0_9
	else
		arg_19_0 = var_0_8 - arg_19_0
	end

	return arg_19_0 * (((((-2.39e-08 * (arg_19_0 * arg_19_0) + 2.7526e-06) * var_1 - 0.000198409) * var_1 + 0.0083333315) * var_1 - 0.1666666664) * var_1 + 1)
end

math = var_0_10006

function var_0_10006.atan16(arg_20_0)
	local var_20_0

	if var_0_6(arg_20_0) > 1 then
		local var_20_1 = -((((((((0.0028662257 * (arg_20_0 * (1 / arg_20_0)) - 0.0161657367) * var_1 + 0.0429096138) * var_1 - 0.07528964) * var_1 + 0.1065626393) * var_1 - 0.1420889944) * var_1 + 0.1999355085) * var_1 - 0.3333314528) * var_1 + 1) * arg_20_0

		FLOATSIGNBITSET = var_2

		if var_2(arg_20_0) then
			return var_20_1 - var_0_10
		else
			return var_20_1 + var_0_10
		end
	else
		return ((((((((0.0028662257 * (arg_20_0 * arg_20_0) - 0.0161657367) * var_1 + 0.0429096138) * var_1 - 0.07528964) * var_1 + 0.1065626393) * var_1 - 0.1420889944) * var_1 + 0.1999355085) * var_1 - 0.3333314528) * var_1 + 1) * arg_20_0
	end

	return
end

local function var_0_11(arg_21_0, arg_21_1, arg_21_2)
	return (arg_21_0 - arg_21_1) / (arg_21_2 - arg_21_1) / 100
end

local var_0_12 = getExpPercent

local function var_0_13(arg_22_0)
	pairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0) do
		calcFloor = var_1_10006
		arg_22_0[iter_22_0] = var_1_10006(iter_22_1)
	end

	return arg_22_0
end

local var_0_14 = intProperties

local function var_0_15(arg_23_0, arg_23_1)
	if arg_23_0 == nil then
		return arg_23_1
	else
		return arg_23_0
	end

	return
end

local var_0_16 = defaultValue

local function var_0_17(arg_24_0)
	math = var_1_10001

	return var_1_10001.floor(arg_24_0 + 1e-09)
end

local var_0_18 = calcFloor

local function var_0_19(arg_25_0)
	math = var_1_10001

	local var_25_0

	if not var_1_10001.compareFuncList then
		var_25_0 = {
			["="] = function(arg_26_0, arg_26_1)
				return arg_26_0 == arg_26_1
			end,
			["=="] = function(arg_27_0, arg_27_1)
				return arg_27_0 == arg_27_1
			end,
			[">="] = function(arg_28_0, arg_28_1)
				return arg_28_1 <= arg_28_0
			end,
			["<="] = function(arg_29_0, arg_29_1)
				return arg_29_0 <= arg_29_1
			end,
			[">"] = function(arg_30_0, arg_30_1)
				return arg_30_1 < arg_30_0
			end,
			["<"] = function(arg_31_0, arg_31_1)
				return arg_31_0 < arg_31_1
			end,
			["!="] = function(arg_32_0, arg_32_1)
				return arg_32_0 ~= arg_32_1
			end,
			["~="] = function(arg_33_0, arg_33_1)
				return arg_33_0 ~= arg_33_1
			end
		}
	end

	math = var_1_10002
	var_1_10002.compareFuncList = var_25_0

	return var_25_0[arg_25_0]
end

local var_0_20 = getCompareFuncByPunctuation

local function var_0_21(arg_34_0)
	math = var_1_10001

	local var_34_0

	if not var_1_10001.arithmeticFuncList then
		var_34_0 = {
			["+"] = function(arg_35_0, arg_35_1)
				return arg_35_0 + arg_35_1
			end,
			["-"] = function(arg_36_0, arg_36_1)
				return arg_36_0 - arg_36_1
			end,
			["*"] = function(arg_37_0, arg_37_1)
				return arg_37_0 * arg_37_1
			end,
			["/"] = function(arg_38_0, arg_38_1)
				return arg_38_0 / arg_38_1
			end
		}
	end

	math = var_1_10002
	var_1_10002.arithmeticFuncList = var_34_0

	return var_34_0[arg_34_0]
end

local var_0_22 = getArithmeticFuncByOperator

return
