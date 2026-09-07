function uuid()
	return string.gsub("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx", "[xy]", function(arg_2_0)
		return string.format("%x", arg_2_0 == "x" and math.random(0, 15) or math.random(8, 11))
	end)
end

function map(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	return (arg_3_0 - arg_3_1) / (arg_3_2 - arg_3_1) * (arg_3_4 - arg_3_3) + arg_3_3
end

function shuffle(arg_4_0)
	for iter_4_0 = #arg_4_0, 2, -1 do
		local var_4_0 = math.random(iter_4_0)

		arg_4_0[var_4_0], arg_4_0[iter_4_0] = arg_4_0[iter_4_0], arg_4_0[var_4_0]
	end

	return
end

local var_0_0 = math.floor
local var_0_1 = math.abs

function math.round(arg_5_0)
	return var_0_0(arg_5_0 + 0.5)
end

function math.sign(arg_6_0)
	arg_6_0 = arg_6_0 > 0 and 1 or arg_6_0 < 0 and -1 or 0

	return arg_6_0
end

function math.clamp(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0 < arg_7_1 then
		arg_7_0 = arg_7_1
	elseif arg_7_2 < arg_7_0 then
		arg_7_0 = arg_7_2
	end

	return arg_7_0
end

local var_0_2 = math.clamp

function math.lerp(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0 + (arg_8_1 - arg_8_0) * var_0_2(arg_8_2, 0, 1)
end

function math.Repeat(arg_9_0, arg_9_1)
	return arg_9_0 - var_0_0(arg_9_0 / arg_9_1) * arg_9_1
end

function math.LerpAngle(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = math.Repeat(arg_10_1 - arg_10_0, 360)

	if var_10_0 > 180 then
		var_10_0 = var_10_0 - 360
	end

	return arg_10_0 + var_10_0 * var_0_2(arg_10_2, 0, 1)
end

function math.MoveTowards(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 >= var_0_1(arg_11_1 - arg_11_0) then
		return arg_11_1
	end

	return arg_11_0 + math.sign(arg_11_1 - arg_11_0) * arg_11_2
end

function math.DeltaAngle(arg_12_0, arg_12_1)
	local var_12_0 = math.Repeat(arg_12_1 - arg_12_0, 360)

	if var_12_0 > 180 then
		var_12_0 = var_12_0 - 360
	end

	return var_12_0
end

function math.MoveTowardsAngle(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1 = arg_13_0 + math.DeltaAngle(arg_13_0, arg_13_1)

	return math.MoveTowards(arg_13_0, arg_13_1, arg_13_2)
end

function math.Approximately(arg_14_0, arg_14_1)
	return var_0_1(arg_14_1 - arg_14_0) < math.max(1e-06 * math.max(var_0_1(arg_14_0), var_0_1(arg_14_1)), 1.121039e-44)
end

function math.InverseLerp(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0 < arg_15_1 then
		if arg_15_2 < arg_15_0 then
			return 0
		end

		if arg_15_1 < arg_15_2 then
			return 1
		end

		arg_15_2 = arg_15_2 - arg_15_0
		arg_15_2 = arg_15_2 / (arg_15_1 - arg_15_0)

		return arg_15_2
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

function math.PingPong(arg_16_0, arg_16_1)
	arg_16_0 = math.Repeat(arg_16_0, arg_16_1 * 2)

	return arg_16_1 - var_0_1(arg_16_0 - arg_16_1)
end

math.deg2Rad = math.pi / 180
math.rad2Deg = 180 / math.pi
math.epsilon = 1.401298e-45

function math.Random(arg_17_0, arg_17_1)
	return math.random() * (arg_17_1 - arg_17_0) + arg_17_0
end

function math.isnan(arg_18_0)
	return arg_18_0 ~= arg_18_0
end

local var_0_3 = math.pi
local var_0_4 = 2 * math.pi
local var_0_5 = math.pi / 2

function math.sin16(arg_19_0)
	if arg_19_0 < 0 or arg_19_0 >= var_0_4 then
		arg_19_0 = arg_19_0 - var_0_0(arg_19_0 / var_0_4) * var_0_4
	end

	if arg_19_0 < var_0_3 then
		if arg_19_0 > var_0_5 then
			arg_19_0 = var_0_3 - arg_19_0
		end
	else
		arg_19_0 = arg_19_0 > var_0_3 + var_0_5 and arg_19_0 - var_0_4 or var_0_3 - arg_19_0
	end

	return arg_19_0 * (((((-2.39e-08 * (arg_19_0 * arg_19_0) + 2.7526e-06) * (arg_19_0 * arg_19_0) - 0.000198409) * (arg_19_0 * arg_19_0) + 0.0083333315) * (arg_19_0 * arg_19_0) - 0.1666666664) * (arg_19_0 * arg_19_0) + 1)
end

function math.atan16(arg_20_0)
	if var_0_1(arg_20_0) > 1 then
		arg_20_0 = 1 / arg_20_0

		if FLOATSIGNBITSET(arg_20_0) then
			return -((((((((0.0028662257 * (arg_20_0 * arg_20_0) - 0.0161657367) * (arg_20_0 * arg_20_0) + 0.0429096138) * (arg_20_0 * arg_20_0) - 0.07528964) * (arg_20_0 * arg_20_0) + 0.1065626393) * (arg_20_0 * arg_20_0) - 0.1420889944) * (arg_20_0 * arg_20_0) + 0.1999355085) * (arg_20_0 * arg_20_0) - 0.3333314528) * (arg_20_0 * arg_20_0) + 1) * arg_20_0 - var_0_5
		else
			return -((((((((0.0028662257 * (arg_20_0 * arg_20_0) - 0.0161657367) * (arg_20_0 * arg_20_0) + 0.0429096138) * (arg_20_0 * arg_20_0) - 0.07528964) * (arg_20_0 * arg_20_0) + 0.1065626393) * (arg_20_0 * arg_20_0) - 0.1420889944) * (arg_20_0 * arg_20_0) + 0.1999355085) * (arg_20_0 * arg_20_0) - 0.3333314528) * (arg_20_0 * arg_20_0) + 1) * arg_20_0 + var_0_5
		end
	else
		return ((((((((0.0028662257 * (arg_20_0 * arg_20_0) - 0.0161657367) * (arg_20_0 * arg_20_0) + 0.0429096138) * (arg_20_0 * arg_20_0) - 0.07528964) * (arg_20_0 * arg_20_0) + 0.1065626393) * (arg_20_0 * arg_20_0) - 0.1420889944) * (arg_20_0 * arg_20_0) + 0.1999355085) * (arg_20_0 * arg_20_0) - 0.3333314528) * (arg_20_0 * arg_20_0) + 1) * arg_20_0
	end

	return
end

function getExpPercent(arg_21_0, arg_21_1, arg_21_2)
	return (arg_21_0 - arg_21_1) / (arg_21_2 - arg_21_1) / 100
end

function intProperties(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0) do
		arg_22_0[iter_22_0] = calcFloor(iter_22_1)
	end

	return arg_22_0
end

function defaultValue(arg_23_0, arg_23_1)
	if arg_23_0 == nil then
		return arg_23_1
	else
		return arg_23_0
	end

	return
end

function calcFloor(arg_24_0)
	return math.floor(arg_24_0 + 1e-09)
end

function getCompareFuncByPunctuation(arg_25_0)
	local var_25_0 = math.compareFuncList or {
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

	math.compareFuncList = var_25_0

	return var_25_0[arg_25_0]
end

function getArithmeticFuncByOperator(arg_34_0)
	local var_34_0 = math.arithmeticFuncList or {
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

	math.arithmeticFuncList = var_34_0

	return var_34_0[arg_34_0]
end

return
