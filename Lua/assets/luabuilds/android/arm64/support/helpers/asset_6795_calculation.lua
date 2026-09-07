local var_0_0 = {
	p = pg.gameset.air_dominance_p.key_value,
	q = pg.gameset.air_dominance_q.key_value,
	s = pg.gameset.air_dominance_s.key_value,
	t = pg.gameset.air_dominance_t.key_value,
	r = pg.gameset.air_dominance_r.key_value,
	a = pg.gameset.air_dominance_a.key_value,
	x = pg.gameset.air_dominance_x.key_value,
	y = pg.gameset.air_dominance_y.key_value
}

function calcAirDominanceValue(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:getAircraftCount()

	return defaultValue(arg_1_0:getProperties(arg_1_1)[AttributeType.Air], 0) * (defaultValue(var_1_0[EquipType.FighterAircraft], 0) * var_0_0.p + defaultValue(var_1_0[EquipType.TorpedoAircraft], 0) * var_0_0.q + defaultValue(var_1_0[EquipType.BomberAircraft], 0) * var_0_0.s + defaultValue(var_1_0[EquipType.SeaPlane], 0) * var_0_0.t) * (0.8 + arg_1_0.level * var_0_0.r / 100) / 100 + defaultValue(arg_1_0:getEquipmentProperties()[AttributeType.AirDominate], 0)
end

function calcAirDominanceStatus(arg_2_0, arg_2_1, arg_2_2)
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

function calcPositionAngle(arg_3_0, arg_3_1)
	local var_3_0 = Vector3(arg_3_0, arg_3_1, 0)
	local var_3_1 = Vector2.Angle(var_3_0, Vector3.up)

	return Vector3.Cross(var_3_0, Vector3.up).z > 0 and var_3_1 or -var_3_1
end

function DOAParabolaCalc(arg_4_0, arg_4_1, arg_4_2)
	assert(arg_4_2 < arg_4_1 * arg_4_1 * arg_4_0 / 2, "x is unreal")

	local var_4_0 = arg_4_0 * math.sqrt(arg_4_1 / 2)
	local var_4_1 = 0

	while var_4_0 * var_4_0 - var_4_1 > 0.01 do
		local var_4_3

		if var_4_0 > math.sqrt((var_4_1 + var_4_0 * var_4_0) / 2) + math.sqrt((var_4_1 + var_4_0 * var_4_0) / 2 + arg_4_2) then
			var_4_1 = (var_4_1 + var_4_0 * var_4_0) / 2
		else
			var_4_3 = (var_4_1 + var_4_0 * var_4_0) / 2
		end
	end

	return var_4_1
end

function mergeSort(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or function(arg_6_0, arg_6_1)
		return arg_6_0 <= arg_6_1
	end

	local var_5_0 = {}

	local function var_5_1(arg_7_0, arg_7_1)
		if arg_7_1 <= arg_7_0 then
			return
		end

		local var_7_0 = math.floor((arg_7_0 + arg_7_1) / 2)

		var_5_1(arg_7_0, var_7_0)
		var_5_1(var_7_0 + 1, arg_7_1)

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
	end

	var_5_1(1, #arg_5_0)

	return
end

function LineLine(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = false
	local var_8_1
	local var_8_2

	if (arg_8_3.y - arg_8_2.y) * (arg_8_1.x - arg_8_0.x) - (arg_8_3.x - arg_8_2.x) * (arg_8_1.y - arg_8_0.y) ~= 0 then
		var_8_1 = ((arg_8_3.x - arg_8_2.x) * (arg_8_0.y - arg_8_2.y) - (arg_8_3.y - arg_8_2.y) * (arg_8_0.x - arg_8_2.x)) / ((arg_8_3.y - arg_8_2.y) * (arg_8_1.x - arg_8_0.x) - (arg_8_3.x - arg_8_2.x) * (arg_8_1.y - arg_8_0.y))
		var_8_2 = ((arg_8_1.x - arg_8_0.x) * (arg_8_0.y - arg_8_2.y) - (arg_8_1.y - arg_8_0.y) * (arg_8_0.x - arg_8_2.x)) / ((arg_8_3.y - arg_8_2.y) * (arg_8_1.x - arg_8_0.x) - (arg_8_3.x - arg_8_2.x) * (arg_8_1.y - arg_8_0.y))

		if ((arg_8_3.x - arg_8_2.x) * (arg_8_0.y - arg_8_2.y) - (arg_8_3.y - arg_8_2.y) * (arg_8_0.x - arg_8_2.x)) / ((arg_8_3.y - arg_8_2.y) * (arg_8_1.x - arg_8_0.x) - (arg_8_3.x - arg_8_2.x) * (arg_8_1.y - arg_8_0.y)) >= 0 and var_8_1 <= 1 and var_8_2 >= 0 and var_8_2 <= 1 then
			var_8_0 = true
		end
	end

	return var_8_0, var_8_1, var_8_2
end

function ConversionBase(arg_9_0, arg_9_1)
	local var_9_0 = {
		0
	}
	local var_9_1 = 0

	while arg_9_1 > 0 do
		var_9_1 = var_9_1 + 1
		var_9_0[var_9_1] = arg_9_1 % arg_9_0
		var_9_0[var_9_1] = var_9_0[var_9_1] < 10 and string.format("%c", var_9_0[var_9_1] + 48) or string.format("%c", var_9_0[var_9_1] + 55)
		arg_9_1 = math.floor(arg_9_1 / arg_9_0)
	end

	for iter_9_0 = 1, math.floor(#var_9_0 / 2) do
		var_9_0[#var_9_0 - iter_9_0 + 1] = var_9_0[iter_9_0]
		var_9_0[iter_9_0] = var_9_0[#var_9_0 - iter_9_0 + 1]
	end

	return table.concat(var_9_0)
end

base64 = {}

local var_0_1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function base64:enc()
	return (self:gsub(".", function(arg_11_0)
		local var_11_0 = ""
		local var_11_1 = arg_11_0:byte()

		for iter_11_0 = 8, 1, -1 do
			var_11_0 = var_11_0 .. (var_11_1 % 2^iter_11_0 - var_11_1 % 2^(iter_11_0 - 1) > 0 and "1" or "0")
		end

		return var_11_0
	end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(arg_12_0)
		if #arg_12_0 < 6 then
			return ""
		end

		local var_12_0 = 0

		for iter_12_0 = 1, 6 do
			var_12_0 = var_12_0 + ((arg_12_0:sub(iter_12_0, iter_12_0) == "1" or nil) and (2^(6 - iter_12_0) or 0))
		end

		return var_0_1:sub(var_12_0 + 1, var_12_0 + 1)
	end) .. ({
		"",
		"==",
		"="
	})[#self % 3 + 1]
end

function base64:dec()
	self = string.gsub(self, "[^" .. var_0_1 .. "=]", "")

	return (self:gsub(".", function(arg_14_0)
		if arg_14_0 == "=" then
			return ""
		end

		local var_14_0 = ""
		local var_14_1 = var_0_1:find(arg_14_0) - 1

		for iter_14_0 = 6, 1, -1 do
			var_14_0 = var_14_0 .. (var_14_1 % 2^iter_14_0 - var_14_1 % 2^(iter_14_0 - 1) > 0 and "1" or "0")
		end

		return var_14_0
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(arg_15_0)
		if #arg_15_0 ~= 8 then
			return ""
		end

		local var_15_0 = 0

		for iter_15_0 = 1, 8 do
			var_15_0 = var_15_0 + ((arg_15_0:sub(iter_15_0, iter_15_0) == "1" or nil) and (2^(8 - iter_15_0) or 0))
		end

		return string.char(var_15_0)
	end))
end

return
