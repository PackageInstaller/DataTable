local var_0_0 = {}

pg = var_0_10001
var_0_0.p = var_0_10001.gameset.air_dominance_p.key_value
pg = var_1
var_0_0.q = var_1.gameset.air_dominance_q.key_value
pg = var_1
var_0_0.s = var_1.gameset.air_dominance_s.key_value
pg = var_1
var_0_0.t = var_1.gameset.air_dominance_t.key_value
pg = var_1
var_0_0.r = var_1.gameset.air_dominance_r.key_value
pg = var_1
var_0_0.a = var_1.gameset.air_dominance_a.key_value
pg = var_1
var_0_0.x = var_1.gameset.air_dominance_x.key_value
pg = var_1
var_0_0.y = var_1.gameset.air_dominance_y.key_value

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.getAircraftCount(var_1_0)
	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.getEquipmentProperties(var_1_2)

	defaultValue = var_1_0

	local var_1_4 = arg_1_0:getProperties(arg_1_1)

	AttributeType = var_1_10007

	local var_1_5 = var_1_0(var_1_4[var_1_10007.Air], 0)

	defaultValue = var_1_2
	EquipType = var_7

	local var_1_6 = var_1_2(var_1_1[var_7.FighterAircraft], 0) * var_0_0.p

	defaultValue = var_6
	EquipType = var_8

	local var_1_7 = var_1_6 + var_6(var_1_1[var_8.TorpedoAircraft], 0) * var_0_0.q

	defaultValue = var_6
	EquipType = var_8

	local var_1_8 = var_1_7 + var_6(var_1_1[var_8.BomberAircraft], 0) * var_0_0.s

	defaultValue = var_6
	EquipType = var_8

	local var_1_9 = var_1_5 * (var_1_8 + var_6(var_1_1[var_8.SeaPlane], 0) * var_0_0.t) * (0.8 + arg_1_0.level * var_0_0.r / 100) / 100

	defaultValue = var_5
	AttributeType = var_7

	return var_1_9 + var_5(var_1_3[var_7.AirDominate], 0)
end

local var_0_2 = calcAirDominanceValue

local function var_0_3(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1 = arg_2_1 * (var_0_0.a / (arg_2_2 + var_0_0.a))

	if arg_2_0 == 0 then
		if arg_2_1 <= var_0_0.x then
			return 0
		elseif arg_2_1 <= var_0_0.y then
			return 2
		else
			return 1
		end
	elseif arg_2_0 <= var_0_0.x then
		if arg_2_1 == 0 then
			return 0
		elseif arg_2_1 <= var_0_0.x then
			return 0
		elseif arg_2_1 <= var_0_0.y then
			if arg_2_0 <= arg_2_1 * 0.75 then
				return 2
			elseif arg_2_0 <= arg_2_1 * 1.3 then
				return 3
			else
				return 4
			end
		elseif arg_2_0 <= arg_2_1 * 0.5 then
			return 1
		elseif arg_2_0 <= arg_2_1 * 0.75 then
			return 2
		elseif arg_2_0 <= arg_2_1 * 1.3 then
			return 3
		else
			return 4
		end
	elseif arg_2_0 <= var_0_0.y then
		if arg_2_1 == 0 then
			return 4
		elseif arg_2_1 <= var_0_0.y then
			if arg_2_0 <= arg_2_1 * 0.75 then
				return 2
			elseif arg_2_0 <= arg_2_1 * 1.3 then
				return 3
			else
				return 4
			end
		elseif arg_2_0 <= arg_2_1 * 0.5 then
			return 1
		elseif arg_2_0 <= arg_2_1 * 0.75 then
			return 2
		elseif arg_2_0 <= arg_2_1 * 1.3 then
			return 3
		else
			return 4
		end
	elseif arg_2_1 == 0 then
		return 5
	elseif arg_2_0 <= arg_2_1 * 0.5 then
		return 1
	elseif arg_2_0 <= arg_2_1 * 0.75 then
		return 2
	elseif arg_2_0 <= arg_2_1 * 1.3 then
		return 3
	elseif arg_2_0 <= arg_2_1 * 2 then
		return 4
	else
		return 5
	end

	return
end

local var_0_4 = calcAirDominanceStatus

local function var_0_5(arg_3_0, arg_3_1)
	Vector3 = var_1_10002

	local var_3_0 = var_1_10002(arg_3_0, arg_3_1, 0)

	Vector3 = var_1_10003

	local var_3_1 = var_1_10003.up

	Vector2 = var_4

	local var_3_2 = var_4.Angle(var_3_0, var_3_1)

	Vector3 = var_5

	return var_5.Cross(var_3_0, var_3_1).z > 0 and var_3_2 or -var_3_2
end

local var_0_6 = calcPositionAngle

local function var_0_7(arg_4_0, arg_4_1, arg_4_2)
	assert = var_1_10003

	var_1_10003(arg_4_2 < arg_4_1 * arg_4_1 * arg_4_0 / 2, "x is unreal")

	math = var_1_10003

	local var_4_0 = arg_4_0 * var_1_10003.sqrt(arg_4_1 / 2)
	local var_4_1 = 0
	local var_4_2 = var_4_0 * var_4_0
	local var_4_3

	::label_4_0::

	local var_4_4 = var_4_2 - var_4_1

	if 0.01 < var_4_4 then
		repeat
			local var_4_5 = (var_4_1 + var_4_2) / 2

			math = var_7

			local var_4_6 = var_7.sqrt(var_4_5)

			math = var_8

			if var_4_0 > var_4_6 + var_8.sqrt(var_4_5 + arg_4_2) then
				var_4_1 = var_4_5
			else
				var_4_2 = var_4_5
			end

			goto label_4_0
		until true
	end

	return var_4_1
end

local var_0_8 = DOAParabolaCalc

local function var_0_9(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or function(arg_6_0, arg_6_1)
		return arg_6_0 <= arg_6_1
	end

	local var_5_0 = {}

	;(function(arg_7_0, arg_7_1)
		if arg_7_1 <= arg_7_0 then
			return
		end

		math = var_2_10002

		local var_7_0 = var_2_10002.floor((arg_7_0 + arg_7_1) / 2)

		var_0(arg_7_0, var_7_0)
		var_0(var_7_0 + 1, arg_7_1)

		local var_7_1 = arg_7_0
		local var_7_2 = var_7_0 + 1

		while var_7_1 <= var_7_0 and var_7_2 <= arg_7_1 do
			if arg_5_1(arg_5_0[var_7_1], arg_5_0[var_7_2]) then
				var_5_0[var_7_1 + var_7_2 - var_7_0 - 1] = arg_5_0[var_7_1]
				var_7_1 = var_7_1 + 1
			else
				var_5_0[var_7_1 + var_7_2 - var_7_0 - 1] = arg_5_0[var_7_2]
				var_7_2 = var_7_2 + 1
			end
		end

		while var_7_1 <= var_7_0 do
			var_5_0[var_7_1 + var_7_2 - var_7_0 - 1] = arg_5_0[var_7_1]
			var_7_1 = var_7_1 + 1
		end

		while var_7_2 <= arg_7_1 do
			var_5_0[var_7_1 + var_7_2 - var_7_0 - 1] = arg_5_0[var_7_2]
			var_7_2 = var_7_2 + 1
		end

		for iter_7_0 = arg_7_0, arg_7_1 do
			arg_5_0[iter_7_0] = var_5_0[iter_7_0]
		end

		return
	end)(1, #arg_5_0)

	return
end

local var_0_10 = mergeSort

local function var_0_11(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = false
	local var_8_1
	local var_8_2

	if (arg_8_3.y - arg_8_2.y) * (arg_8_1.x - arg_8_0.x) - (arg_8_3.x - arg_8_2.x) * (arg_8_1.y - arg_8_0.y) ~= 0 then
		var_8_1 = ((arg_8_3.x - arg_8_2.x) * (arg_8_0.y - arg_8_2.y) - (arg_8_3.y - arg_8_2.y) * (arg_8_0.x - arg_8_2.x)) / var_7
		var_8_2 = ((arg_8_1.x - arg_8_0.x) * (arg_8_0.y - arg_8_2.y) - (arg_8_1.y - arg_8_0.y) * (arg_8_0.x - arg_8_2.x)) / var_7

		if var_8_1 >= 0 and var_8_1 <= 1 and var_8_2 >= 0 and var_8_2 <= 1 then
			var_8_0 = true
		end
	end

	return var_8_0, var_8_1, var_8_2
end

local var_0_12 = LineLine

local function var_0_13(arg_9_0, arg_9_1)
	local var_9_0 = {
		0
	}
	local var_9_1 = 0

	while arg_9_1 > 0 do
		var_9_0[var_9_1 + 1] = arg_9_1 % arg_9_0

		if var_9_0[var_9_1] < 10 then
			string = var_4
			var_9_0[var_9_1] = var_4.format("%c", var_9_0[var_9_1] + 48)
		else
			string = var_4
			var_9_0[var_9_1] = var_4.format("%c", var_9_0[var_9_1] + 55)
		end

		math = var_4
		arg_9_1 = var_4.floor(arg_9_1 / arg_9_0)
	end

	local var_9_2 = 1

	math = var_1_10005

	for iter_9_0 = var_9_2, var_1_10005.floor(#var_9_0 / 2) do
		var_9_0[iter_9_0], var_9_0[#var_9_0 - iter_9_0 + 1] = var_9_0[#var_9_0 - iter_9_0 + 1], var_9_0[iter_9_0]
	end

	table = var_9_2

	return var_9_2.concat(var_9_0)
end

local var_0_14 = ConversionBase
local var_0_15 = {}
local var_0_16 = base64
local var_0_17 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

base64 = var_0_10002

function var_0_10002.enc(arg_10_0)
	local var_10_0 = arg_10_0:gsub(".", function(arg_11_0)
		local var_11_0 = ""
		local var_11_1 = arg_11_0:byte()

		for iter_11_0 = 8, 1, -1 do
			var_11_0 = var_11_0 .. (var_11_1 % 2^iter_11_0 - var_11_1 % 2^(iter_11_0 - 1) > 0 and "1" or "0")
		end

		return var_11_0
	end) .. "0000"

	return var_1.gsub(var_10_0, "%d%d%d?%d?%d?%d?", function(arg_12_0)
		if #arg_12_0 < 6 then
			return ""
		end

		local var_12_0 = 0

		for iter_12_0 = 1, 6 do
			local var_12_1

			if arg_12_0:sub(iter_12_0, iter_12_0) ~= "1" or not 2^(6 - iter_12_0) then
				var_12_1 = 0
			end

			var_12_0 = var_12_0 + var_12_1
		end

		local var_12_2 = var_0_17

		return var_2.sub(var_12_2, var_12_0 + 1, var_12_0 + 1)
	end) .. ({
		"",
		"==",
		"="
	})[#arg_10_0 % 3 + 1]
end

base64 = var_0_10002

function var_0_10002.dec(arg_13_0)
	string = var_1_10001

	local var_13_0 = var_1_10001.gsub(arg_13_0, "[^" .. var_0_17 .. "=]", "")
	local var_13_1 = arg_13_0.gsub(var_13_0, ".", function(arg_14_0)
		if arg_14_0 == "=" then
			return ""
		end

		local var_14_0 = ""
		local var_14_1 = var_0_17
		local var_14_2 = var_2.find(var_14_1, arg_14_0) - 1

		for iter_14_0 = 6, 1, -1 do
			var_14_0 = var_14_0 .. (var_14_2 % 2^iter_14_0 - var_14_2 % 2^(iter_14_0 - 1) > 0 and "1" or "0")
		end

		return var_14_0
	end)

	return (var_1.gsub(var_13_1, "%d%d%d?%d?%d?%d?%d?%d?", function(arg_15_0)
		if #arg_15_0 ~= 8 then
			return ""
		end

		local var_15_0 = 0

		for iter_15_0 = 1, 8 do
			local var_15_1

			if arg_15_0:sub(iter_15_0, iter_15_0) ~= "1" or not 2^(8 - iter_15_0) then
				var_15_1 = 0
			end

			var_15_0 = var_15_0 + var_15_1
		end

		string = var_2

		return var_2.char(var_15_0)
	end))
end

return
