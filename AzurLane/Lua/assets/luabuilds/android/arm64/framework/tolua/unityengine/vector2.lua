local var_0_0 = math.sqrt
local var_0_1 = setmetatable
local var_0_2 = rawget
local var_0_3 = math.acos
local var_0_5 = {}
local var_0_6 = tolua.initget({})

;({}).__index = function(arg_1_0, arg_1_1)
	local var_1_0 = var_0_2(var_0_5, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_2(var_0_6, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end
;({}).__call = function(arg_2_0, arg_2_1, arg_2_2)
	return var_0_1({
		x = arg_2_1 or 0,
		y = arg_2_2 or 0
	}, var_0_5)
end
;({}).New = function(arg_3_0, arg_3_1)
	return var_0_1({
		x = arg_3_0 or 0,
		y = arg_3_1 or 0
	}, var_0_5)
end
;({}).Set = function(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.x = arg_4_1 or 0
	arg_4_0.y = arg_4_2 or 0

	return
end
;({}).Get = function(arg_5_0)
	return arg_5_0.x, arg_5_0.y
end
;({}).SqrMagnitude = function(arg_6_0)
	return arg_6_0.x * arg_6_0.x + arg_6_0.y * arg_6_0.y
end
;({}).Clone = function(arg_7_0)
	return var_0_1({
		x = arg_7_0.x,
		y = arg_7_0.y
	}, var_0_5)
end
;({}).Normalize = function(arg_8_0)
	local var_8_0 = arg_8_0.x
	local var_8_1 = arg_8_0.y
	local var_8_2 = var_0_0(var_8_0 * var_8_0 + var_8_1 * var_8_1)

	if var_8_2 > 1e-05 then
		var_8_0 = var_8_0 / var_8_2
		var_8_1 = var_8_1 / var_8_2
	else
		var_8_0 = 0
		var_8_1 = 0
	end

	return var_0_1({
		x = var_8_0,
		y = var_8_1
	}, var_0_5)
end
;({}).SetNormalize = function(arg_9_0)
	local var_9_0 = var_0_0(arg_9_0.x * arg_9_0.x + arg_9_0.y * arg_9_0.y)

	if var_9_0 > 1e-05 then
		arg_9_0.x = arg_9_0.x / var_9_0
		arg_9_0.y = arg_9_0.y / var_9_0
	else
		arg_9_0.x = 0
		arg_9_0.y = 0
	end

	return arg_9_0
end
;({}).Dot = function(arg_10_0, arg_10_1)
	return arg_10_0.x * arg_10_1.x + arg_10_0.y * arg_10_1.y
end
;({}).Angle = function(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.x
	local var_11_1 = arg_11_0.y
	local var_11_2 = var_0_0(var_11_0 * var_11_0 + var_11_1 * var_11_1)

	if var_11_2 > 1e-05 then
		var_11_0 = var_11_0 / var_11_2
		var_11_1 = var_11_1 / var_11_2

		goto label_11_0

		var_11_1 = 0
	end

	var_11_0 = 0

	::label_11_0::

	local var_11_3 = arg_11_1.x
	local var_11_4 = arg_11_1.y
	local var_11_5 = var_0_0(var_11_3 * var_11_3 + var_11_4 * var_11_4)

	if var_11_5 > 1e-05 then
		var_11_3 = var_11_3 / var_11_5
		var_11_4 = var_11_4 / var_11_5

		goto label_11_1

		var_11_4 = 0
	end

	var_11_3 = 0

	::label_11_1::

	local var_11_6 = var_11_0 * var_11_3 + var_11_1 * var_11_4

	if var_11_0 * var_11_3 + var_11_1 * var_11_4 < -1 then
		var_11_6 = -1
	elseif var_11_6 > 1 then
		var_11_6 = 1
	end

	return var_0_3(var_11_6) * 57.29578
end
;({}).Magnitude = function(arg_12_0)
	return var_0_0(arg_12_0.x * arg_12_0.x + arg_12_0.y * arg_12_0.y)
end
;({}).Reflect = function(arg_13_0, arg_13_1)
	return var_0_1({
		x = -2 * (arg_13_0.x * arg_13_1.x + arg_13_0.y * arg_13_1.y) * arg_13_1.x + arg_13_0.x,
		y = -2 * (arg_13_0.x * arg_13_1.x + arg_13_0.y * arg_13_1.y) * arg_13_1.y + arg_13_0.y
	}, var_0_5)
end
;({}).Distance = function(arg_14_0, arg_14_1)
	return var_0_0((arg_14_0.x - arg_14_1.x)^2 + (arg_14_0.y - arg_14_1.y)^2)
end
;({}).Lerp = function(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 < 0 then
		arg_15_2 = 0
	elseif arg_15_2 > 1 then
		arg_15_2 = 1
	end

	return var_0_1({
		x = arg_15_0.x + (arg_15_1.x - arg_15_0.x) * arg_15_2,
		y = arg_15_0.y + (arg_15_1.y - arg_15_0.y) * arg_15_2
	}, var_0_5)
end
;({}).LerpUnclamped = function(arg_16_0, arg_16_1, arg_16_2)
	return var_0_1({
		x = arg_16_0.x + (arg_16_1.x - arg_16_0.x) * arg_16_2,
		y = arg_16_0.y + (arg_16_1.y - arg_16_0.y) * arg_16_2
	}, var_0_5)
end
;({}).MoveTowards = function(arg_17_0, arg_17_1, arg_17_2)
	if (arg_17_1.x - arg_17_0.x) * (arg_17_1.x - arg_17_0.x) + (arg_17_1.y - arg_17_0.y) * (arg_17_1.y - arg_17_0.y) > arg_17_2 * arg_17_2 and (arg_17_1.x - arg_17_0.x) * (arg_17_1.x - arg_17_0.x) + (arg_17_1.y - arg_17_0.y) * (arg_17_1.y - arg_17_0.y) ~= 0 then
		local var_17_0 = arg_17_2 / var_0_0((arg_17_1.x - arg_17_0.x) * (arg_17_1.x - arg_17_0.x) + (arg_17_1.y - arg_17_0.y) * (arg_17_1.y - arg_17_0.y))

		return var_0_1({
			x = arg_17_0.x + (arg_17_1.x - arg_17_0.x) * var_17_0,
			y = arg_17_0.y + (arg_17_1.y - arg_17_0.y) * var_17_0
		}, var_0_5)
	end

	return var_0_1({
		x = arg_17_1.x,
		y = arg_17_1.y
	}, var_0_5)
end
;({}).ClampMagnitude = function(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.x
	local var_18_1 = arg_18_0.y

	if var_18_0 * var_18_0 + var_18_1 * var_18_1 > arg_18_1 * arg_18_1 then
		local var_18_2 = arg_18_1 / var_0_0(var_18_0 * var_18_0 + var_18_1 * var_18_1)

		var_18_0 = var_18_0 * var_18_2
		var_18_1 = var_18_1 * var_18_2

		return var_0_1({
			x = var_18_0,
			y = var_18_1
		}, var_0_5)
	end

	return var_0_1({
		x = var_18_0,
		y = var_18_1
	}, var_0_5)
end
;({}).SmoothDamp = function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	arg_19_5 = arg_19_5 or Time.deltaTime
	arg_19_4 = arg_19_4 or var_0.huge
	arg_19_3 = var_0.max(0.0001, arg_19_3)

	local var_19_0 = arg_19_0.x - arg_19_1.x
	local var_19_1 = arg_19_0.y - arg_19_1.y

	if var_19_0 * var_19_0 + var_19_1 * var_19_1 > arg_19_4 * arg_19_3 * (arg_19_4 * arg_19_3) then
		local var_19_2 = arg_19_4 * arg_19_3 / var_0_0(var_19_0 * var_19_0 + var_19_1 * var_19_1)

		var_19_0 = var_19_0 * var_19_2
		var_19_1 = var_19_1 * var_19_2
	end

	arg_19_2.x = (arg_19_2.x - 2 / arg_19_3 * ((arg_19_2.x + 2 / arg_19_3 * var_19_0) * arg_19_5)) * (1 / (1 + 2 / arg_19_3 * arg_19_5 + 0.48 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) + 0.235 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5)))
	arg_19_2.y = (arg_19_2.y - 2 / arg_19_3 * ((arg_19_2.y + 2 / arg_19_3 * var_19_1) * arg_19_5)) * (1 / (1 + 2 / arg_19_3 * arg_19_5 + 0.48 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) + 0.235 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5)))

	local var_19_3 = arg_19_0.x - var_19_0 + (var_19_0 + (arg_19_2.x + 2 / arg_19_3 * var_19_0) * arg_19_5) * (1 / (1 + 2 / arg_19_3 * arg_19_5 + 0.48 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) + 0.235 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5)))
	local var_19_4 = arg_19_0.y - var_19_1 + (var_19_1 + (arg_19_2.y + 2 / arg_19_3 * var_19_1) * arg_19_5) * (1 / (1 + 2 / arg_19_3 * arg_19_5 + 0.48 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) + 0.235 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5)))

	if (arg_19_1.x - arg_19_0.x) * (arg_19_0.x - var_19_0 + (var_19_0 + (arg_19_2.x + 2 / arg_19_3 * var_19_0) * arg_19_5) * (1 / (1 + 2 / arg_19_3 * arg_19_5 + 0.48 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) + 0.235 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5))) - arg_19_1.x) + (arg_19_1.y - arg_19_0.y) * (arg_19_0.y - var_19_1 + (var_19_1 + (arg_19_2.y + 2 / arg_19_3 * var_19_1) * arg_19_5) * (1 / (1 + 2 / arg_19_3 * arg_19_5 + 0.48 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) + 0.235 * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5) * (2 / arg_19_3 * arg_19_5))) - arg_19_1.y) > 0 then
		var_19_3 = arg_19_1.x
		var_19_4 = arg_19_1.y
		arg_19_2.x = 0
		arg_19_2.y = 0
	end

	return var_0_1({
		x = var_19_3,
		y = var_19_4
	}, var_0_5), arg_19_2
end
;({}).Max = function(arg_20_0, arg_20_1)
	return var_0_1({
		x = var_0.max(arg_20_0.x, arg_20_1.x),
		y = var_0.max(arg_20_0.y, arg_20_1.y)
	}, var_0_5)
end
;({}).Min = function(arg_21_0, arg_21_1)
	return var_0_1({
		x = var_0.min(arg_21_0.x, arg_21_1.x),
		y = var_0.min(arg_21_0.y, arg_21_1.y)
	}, var_0_5)
end
;({}).Scale = function(arg_22_0, arg_22_1)
	return var_0_1({
		x = arg_22_0.x * arg_22_1.x,
		y = arg_22_0.y * arg_22_1.y
	}, var_0_5)
end
;({}).Div = function(arg_23_0, arg_23_1)
	arg_23_0.x = arg_23_0.x / arg_23_1
	arg_23_0.y = arg_23_0.y / arg_23_1

	return arg_23_0
end
;({}).Mul = function(arg_24_0, arg_24_1)
	arg_24_0.x = arg_24_0.x * arg_24_1
	arg_24_0.y = arg_24_0.y * arg_24_1

	return arg_24_0
end
;({}).Add = function(arg_25_0, arg_25_1)
	arg_25_0.x = arg_25_0.x + arg_25_1.x
	arg_25_0.y = arg_25_0.y + arg_25_1.y

	return arg_25_0
end
;({}).Sub = function(arg_26_0, arg_26_1)
	arg_26_0.x = arg_26_0.x - arg_26_1.x
	arg_26_0.y = arg_26_0.y - arg_26_1.y

	return arg_26_0
end
;({}).__tostring = function(arg_27_0)
	return string.format("(%f,%f)", arg_27_0.x, arg_27_0.y)
end
;({}).__div = function(arg_28_0, arg_28_1)
	return var_0_1({
		x = arg_28_0.x / arg_28_1,
		y = arg_28_0.y / arg_28_1
	}, var_0_5)
end
;({}).__mul = function(arg_29_0, arg_29_1)
	if type(arg_29_1) == "number" then
		return var_0_1({
			x = arg_29_0.x * arg_29_1,
			y = arg_29_0.y * arg_29_1
		}, var_0_5)
	else
		return var_0_1({
			x = arg_29_0 * arg_29_1.x,
			y = arg_29_0 * arg_29_1.y
		}, var_0_5)
	end

	return
end
;({}).__add = function(arg_30_0, arg_30_1)
	return var_0_1({
		x = arg_30_0.x + arg_30_1.x,
		y = arg_30_0.y + arg_30_1.y
	}, var_0_5)
end
;({}).__sub = function(arg_31_0, arg_31_1)
	return var_0_1({
		x = arg_31_0.x - arg_31_1.x,
		y = arg_31_0.y - arg_31_1.y
	}, var_0_5)
end
;({}).__unm = function(arg_32_0)
	return var_0_1({
		x = -arg_32_0.x,
		y = -arg_32_0.y
	}, var_0_5)
end
;({}).__eq = function(arg_33_0, arg_33_1)
	return (arg_33_0.x - arg_33_1.x)^2 + (arg_33_0.y - arg_33_1.y)^2 < 9.999999e-11
end

function var_0_6.up()
	return var_0_1({
		x = 0,
		y = 1
	}, var_0_5)
end

function var_0_6.right()
	return var_0_1({
		x = 1,
		y = 0
	}, var_0_5)
end

function var_0_6.zero()
	return var_0_1({
		x = 0,
		y = 0
	}, var_0_5)
end

function var_0_6.one()
	return var_0_1({
		x = 1,
		y = 1
	}, var_0_5)
end

var_0_6.magnitude = ({}).Magnitude
var_0_6.normalized = ({}).Normalize
var_0_6.sqrMagnitude = ({}).SqrMagnitude
UnityEngine.Vector2 = {}

setmetatable({}, {})

return {}
