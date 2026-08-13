rawget = var_0_10000
setmetatable = var_0_10001
type = var_0_10002
Mathf = var_0_10003

local var_0_0 = {}

tolua = var_0_10005

local var_0_1 = var_0_10005.initget(var_0_0)

function var_0_0.__index(arg_1_0, arg_1_1)
	if var_0_10000(var_0_0, arg_1_1) == nil and var_0_10000(var_0_1, arg_1_1) ~= nil then
		return var_2(arg_1_0)
	end

	return var_2
end

function var_0_0.__call(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	return var_0_10001({
		r = arg_2_1 or 0,
		g = arg_2_2 or 0,
		b = arg_2_3 or 0,
		a = arg_2_4 or 1
	}, var_0_0)
end

function var_0_0.New(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return var_0_10001({
		r = arg_3_0 or 0,
		g = arg_3_1 or 0,
		b = arg_3_2 or 0,
		a = arg_3_3 or 1
	}, var_0_0)
end

function var_0_0.Set(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.r = arg_4_1
	arg_4_0.g = arg_4_2
	arg_4_0.b = arg_4_3
	arg_4_0.a = arg_4_4 or 1

	return
end

function var_0_0.Get(arg_5_0)
	return arg_5_0.r, arg_5_0.g, arg_5_0.b, arg_5_0.a
end

function var_0_0.Equals(arg_6_0, arg_6_1)
	return arg_6_0.r == arg_6_1.r and arg_6_0.g == arg_6_1.g and arg_6_0.b == arg_6_1.b and arg_6_0.a == arg_6_1.a
end

function var_0_0.Lerp(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = var_0_10003.Clamp01(arg_7_2)

	return var_0_0.New(arg_7_0.r + arg_7_2 * (arg_7_1.r - arg_7_0.r), arg_7_0.g + arg_7_2 * (arg_7_1.g - arg_7_0.g), arg_7_0.b + arg_7_2 * (arg_7_1.b - arg_7_0.b), arg_7_0.a + arg_7_2 * (arg_7_1.a - arg_7_0.a))
end

function var_0_0.LerpUnclamped(arg_8_0, arg_8_1, arg_8_2)
	return var_0_0.New(arg_8_0.r + arg_8_2 * (arg_8_1.r - arg_8_0.r), arg_8_0.g + arg_8_2 * (arg_8_1.g - arg_8_0.g), arg_8_0.b + arg_8_2 * (arg_8_1.b - arg_8_0.b), arg_8_0.a + arg_8_2 * (arg_8_1.a - arg_8_0.a))
end

function var_0_0.HSVToRGB(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 then
		-- block empty
	end

	arg_9_3 = true

	local var_9_0 = var_0_0.New(1, 1, 1, 1)

	if arg_9_1 == 0 then
		var_9_0.r = arg_9_2
		var_9_0.g = arg_9_2
		var_9_0.b = arg_9_2

		return var_9_0
	end

	if arg_9_2 == 0 then
		var_9_0.r = 0
		var_9_0.g = 0
		var_9_0.b = 0

		return var_9_0
	end

	var_9_0.r = 0
	var_9_0.g = 0
	var_9_0.b = 0

	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_2
	local var_9_3 = arg_9_0 * 6 - var_0_10003.Floor(var_7)
	local var_9_4 = var_9_2 * (1 - var_9_1)
	local var_9_5 = var_9_2 * (1 - var_9_1 * var_9_3)
	local var_9_6 = var_9_2 * (1 - var_9_1 * (1 - var_9_3))

	if var_8 + 1 == 0 then
		var_9_0.r = var_9_2
		var_9_0.g = var_9_4
		var_9_0.b = var_9_5
	elseif var_14 == 1 then
		var_9_0.r = var_9_2
		var_9_0.g = var_9_6
		var_9_0.b = var_9_4
	elseif var_14 == 2 then
		var_9_0.r = var_9_5
		var_9_0.g = var_9_2
		var_9_0.b = var_9_4
	elseif var_14 == 3 then
		var_9_0.r = var_9_4
		var_9_0.g = var_9_2
		var_9_0.b = var_9_6
	elseif var_14 == 4 then
		var_9_0.r = var_9_4
		var_9_0.g = var_9_5
		var_9_0.b = var_9_2
	elseif var_14 == 5 then
		var_9_0.r = var_9_6
		var_9_0.g = var_9_4
		var_9_0.b = var_9_2
	elseif var_14 == 6 then
		var_9_0.r = var_9_2
		var_9_0.g = var_9_4
		var_9_0.b = var_9_5
	elseif var_14 == 7 then
		var_9_0.r = var_9_2
		var_9_0.g = var_9_6
		var_9_0.b = var_9_4
	end

	if not arg_9_3 then
		var_9_0.r = var_0_10003.Clamp(var_9_0.r, 0, 1)
		var_9_0.g = var_0_10003.Clamp(var_9_0.g, 0, 1)
		var_9_0.b = var_0_10003.Clamp(var_9_0.b, 0, 1)
	end

	return var_9_0
end

local function var_0_2(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 ~= 0 then
		local var_10_0 = 0

		if arg_10_3 < arg_10_2 then
			var_10_0 = arg_10_3
		else
			var_10_0 = arg_10_2
		end

		local var_10_1 = var_4 - var_10_0
		local var_10_2 = 0
		local var_10_3 = 0

		if var_10_1 ~= 0 then
			var_10_3 = var_10_1 / var_4
			var_10_2 = arg_10_0 + (arg_10_2 - arg_10_3) / var_10_1
		else
			var_10_3 = 0
			var_10_2 = arg_10_0 + (arg_10_2 - arg_10_3)
		end

		local var_10_4

		if var_10_2 / 6 < 0 then
			var_10_4 = var_10_4 + 1
		end

		return var_10_4, var_10_3, var_4
	end

	return 0, 0, var_4
end

function var_0_0.RGBToHSV(arg_11_0)
	if arg_11_0.b > arg_11_0.g and arg_11_0.b > arg_11_0.r then
		return var_0_2(4, arg_11_0.b, arg_11_0.r, arg_11_0.g)
	elseif arg_11_0.g > arg_11_0.r then
		return var_0_2(2, arg_11_0.g, arg_11_0.b, arg_11_0.r)
	else
		return var_0_2(0, arg_11_0.r, arg_11_0.g, arg_11_0.b)
	end

	return
end

function var_0_0.GrayScale(arg_12_0)
	return 0.299 * arg_12_0.r + 0.587 * arg_12_0.g + 0.114 * arg_12_0.b
end

function var_0_0.NewHex(arg_13_0)
	string = var_1_10001

	if var_1_10001.sub(arg_13_0, 1, 1) == "#" then
		string = var_1
		arg_13_0 = var_1.sub(arg_13_0, 2)
	end

	string = var_1
	arg_13_0 = var_1.upper(arg_13_0)

	local var_13_0 = {}

	for iter_13_0 = 1, 4 do
		if iter_13_0 + iter_13_0 > #arg_13_0 then
			var_13_0[iter_13_0] = 1
		else
			tonumber = var_6
			string = var_1_10008
			var_13_0[iter_13_0] = var_6(var_1_10008.sub(arg_13_0, iter_13_0 + iter_13_0 - 1, iter_13_0 + iter_13_0), 16) / 255
		end
	end

	local var_13_1 = var_0_0.New

	unpack = var_4

	return var_13_1(var_4(var_13_0))
end

function var_0_0.ToHex(arg_14_0, arg_14_1)
	if arg_14_1 then
		string = var_1_10002

		if not var_1_10002.format("%.2X%.2X%.2X%.2X", arg_14_0.r * 255, arg_14_0.g * 255, arg_14_0.b * 255, arg_14_0.a * 255) then
			string = var_1_10002
			var_1_10002 = var_1_10002.format("%.2X%.2X%.2X", arg_14_0.r * 255, arg_14_0.g * 255, arg_14_0.b * 255)
		end

		return var_1_10002
	end
end

function var_0_0.__tostring(arg_15_0)
	string = var_1_10001

	return var_1_10001.format("RGBA(%f,%f,%f,%f)", arg_15_0.r, arg_15_0.g, arg_15_0.b, arg_15_0.a)
end

function var_0_0.__add(arg_16_0, arg_16_1)
	return var_0_0.New(arg_16_0.r + arg_16_1.r, arg_16_0.g + arg_16_1.g, arg_16_0.b + arg_16_1.b, arg_16_0.a + arg_16_1.a)
end

function var_0_0.__sub(arg_17_0, arg_17_1)
	return var_0_0.New(arg_17_0.r - arg_17_1.r, arg_17_0.g - arg_17_1.g, arg_17_0.b - arg_17_1.b, arg_17_0.a - arg_17_1.a)
end

function var_0_0.__mul(arg_18_0, arg_18_1)
	if var_0_10002(arg_18_1) == "number" then
		return var_0_0.New(arg_18_0.r * arg_18_1, arg_18_0.g * arg_18_1, arg_18_0.b * arg_18_1, arg_18_0.a * arg_18_1)
	else
		getmetatable = var_2

		if var_2(arg_18_1) == var_0_0 then
			return var_0_0.New(arg_18_0.r * arg_18_1.r, arg_18_0.g * arg_18_1.g, arg_18_0.b * arg_18_1.b, arg_18_0.a * arg_18_1.a)
		end
	end

	return
end

function var_0_0.__div(arg_19_0, arg_19_1)
	return var_0_0.New(arg_19_0.r / arg_19_1, arg_19_0.g / arg_19_1, arg_19_0.b / arg_19_1, arg_19_0.a / arg_19_1)
end

function var_0_0.__eq(arg_20_0, arg_20_1)
	return arg_20_0.r == arg_20_1.r and arg_20_0.g == arg_20_1.g and arg_20_0.b == arg_20_1.b and arg_20_0.a == arg_20_1.a
end

function var_0_1.red()
	return var_0_0.New(1, 0, 0, 1)
end

function var_0_1.green()
	return var_0_0.New(0, 1, 0, 1)
end

function var_0_1.blue()
	return var_0_0.New(0, 0, 1, 1)
end

function var_0_1.white()
	return var_0_0.New(1, 1, 1, 1)
end

function var_0_1.black()
	return var_0_0.New(0, 0, 0, 1)
end

function var_0_1.yellow()
	return var_0_0.New(1, 0.9215686, 0.01568628, 1)
end

function var_0_1.cyan()
	return var_0_0.New(0, 1, 1, 1)
end

function var_0_1.magenta()
	return var_0_0.New(1, 0, 1, 1)
end

function var_0_1.gray()
	return var_0_0.New(0.5, 0.5, 0.5, 1)
end

function var_0_1.clear()
	return var_0_0.New(0, 0, 0, 0)
end

function var_0_1.buttonDisabled()
	return var_0_0.New(0.7843137254901961, 0.7843137254901961, 0.7843137254901961, 0.5)
end

function var_0_1.ReisalinGold()
	return var_0_0.New(1, 0.90196, 0.50196, 1)
end

function var_0_1.gamma(arg_33_0)
	return var_0_0.New(var_0_10003.LinearToGammaSpace(arg_33_0.r), var_0_10003.LinearToGammaSpace(arg_33_0.g), var_0_10003.LinearToGammaSpace(arg_33_0.b), arg_33_0.a)
end

function var_0_1.linear(arg_34_0)
	return var_0_0.New(var_0_10003.GammaToLinearSpace(arg_34_0.r), var_0_10003.GammaToLinearSpace(arg_34_0.g), var_0_10003.GammaToLinearSpace(arg_34_0.b), arg_34_0.a)
end

function var_0_1.maxColorComponent(arg_35_0)
	return var_0_10003.Max(var_0_10003.Max(arg_35_0.r, arg_35_0.g), arg_35_0.b)
end

var_0_1.grayscale = var_0_0.GrayScale
UnityEngine = var_7
var_7.Color = var_0_0

var_0_10001(var_0_0, var_0_0)

return var_0_0
