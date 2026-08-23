local var_0_0 = math.round
local var_0_1 = g.core.config.outpost_attribute_info
local var_0_2 = {}
local var_0_3 = g.core.const.ConstMgr.outpostConst.MAP_TILE_WIDTH * 0.5
local var_0_4 = g.core.const.ConstMgr.outpostConst.MAP_TILE_HEIGHT * 0.5

function var_0_2.pixelToCoord(arg_1_0, arg_1_1)
	return var_0_0((arg_1_0 / var_0_3 + arg_1_1 / var_0_4) * 0.5), var_0_0((arg_1_1 / var_0_4 - arg_1_0 / var_0_3) * 0.5)
end

function var_0_2.coordToPixel(arg_2_0, arg_2_1)
	return (arg_2_0 - arg_2_1) * var_0_3, (arg_2_0 + arg_2_1) * var_0_4
end

function var_0_2.calcKnightFightValue(arg_3_0)
	local var_3_0 = 0
	local var_3_1 = {
		50,
		1000,
		1000
	}
	local var_3_2 = {
		11,
		12,
		13
	}
	local var_3_3 = {
		[204] = 200,
		[202] = 200,
		[104] = 200,
		[208] = 200,
		[101] = 200,
		[207] = 200,
		[102] = 200,
		[106] = 200,
		[201] = 200,
		[103] = 200,
		[105] = 200,
		[203] = 200
	}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		local var_3_4 = 0
		local var_3_5 = 0
		local var_3_6 = iter_3_1:getFinalAtkAttrs()

		for iter_3_2, iter_3_3 in pairs(var_3_1) do
			var_3_4 = var_3_4 + math.floor((var_3_6[iter_3_2] or 0) * (1 + (var_3_6[var_3_2[iter_3_2]] or 0) / 1000) * iter_3_3 / 1000)
		end

		for iter_3_4, iter_3_5 in pairs(var_3_3) do
			var_3_5 = var_3_5 + (var_3_6[iter_3_4] or 0) / 1000 * iter_3_5 / 1000
		end

		var_3_0 = var_3_0 + var_3_4 * (1 + var_3_5)
	end

	return math.floor(var_3_0)
end

function var_0_2.getAttr(arg_4_0, arg_4_1)
	local var_4_0 = var_0_1.get(arg_4_0)

	return {
		name = var_4_0.name,
		value = var_4_0.value_format == 1 and arg_4_1 or arg_4_1 / 1000 .. "%"
	}
end

local var_0_5 = 2147483648
local var_0_6 = 1073741824
local var_0_7 = 536870912

function var_0_2.parseTiledGidNoFirstGid(arg_5_0)
	local var_5_0, var_5_1, var_5_2, var_5_3

	if not arg_5_0 or arg_5_0 == 0 then
		do return 0, {
			h = false,
			v = false,
			d = false
		} end

		var_5_0 = bit.band(arg_5_0, var_0_6) ~= 0
		var_5_1 = bit.band(arg_5_0, var_0_7) ~= 0
		var_5_2 = bit.band(arg_5_0, 536870911)
		var_5_3 = {}
	end

	var_5_3.h = bit.band(arg_5_0, var_0_5) ~= 0
	var_5_3.v = var_5_0
	var_5_3.d = var_5_1

	return var_5_2, var_5_3
end

var_0_2.DIR_X = {
	[101] = cc.p(35, 0),
	[202] = cc.p(80, 15)
}

return var_0_2
