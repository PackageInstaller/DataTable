local var_0_0 = g.core.const.ConstMgr.PubgConst.map
local var_0_1 = {
	getKey = function(arg_1_0, arg_1_1)
		return bit.lshift(arg_1_0, 16) + arg_1_1
	end,
	getPos = function(arg_2_0)
		return bit.rshift(arg_2_0, 16), (bit.band(arg_2_0, 65535))
	end,
	keyInLevel = function(arg_3_0, arg_3_1, arg_3_2)
		return arg_3_1 < (arg_3_2[arg_3_0] or 0)
	end
}

function var_0_1.posInLevel(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	return var_0_1.keyInLevel(var_0_1.getKey(arg_4_0, arg_4_1), arg_4_2, arg_4_3)
end

function var_0_1.pixelToCoord(arg_5_0, arg_5_1)
	return math.round((arg_5_0 / (var_0_0.MAP_TILE_WIDTH / 2) + -arg_5_1 / (var_0_0.MAP_TILE_HEIGHT / 2)) / 2), math.round((-arg_5_1 / (var_0_0.MAP_TILE_HEIGHT / 2) - arg_5_0 / (var_0_0.MAP_TILE_WIDTH / 2)) / 2)
end

function var_0_1.coordToPixel(arg_6_0, arg_6_1)
	return (arg_6_0 - arg_6_1) * (var_0_0.MAP_TILE_WIDTH / 2), -(arg_6_0 + arg_6_1) * (var_0_0.MAP_TILE_HEIGHT / 2)
end

function var_0_1.coordToCompPos(arg_7_0, arg_7_1)
	return (arg_7_0 - arg_7_1) * (var_0_0.MAP_TILE_WIDTH / 2) + display.width / 2, -(-(arg_7_0 + arg_7_1) * (var_0_0.MAP_TILE_HEIGHT / 2)) + display.height / 2
end

function var_0_1.coordToPixel2(arg_8_0, arg_8_1)
	return (arg_8_0 - arg_8_1) * (var_0_0.MAP_TILE_WIDTH / 2), (arg_8_0 + arg_8_1) * (var_0_0.MAP_TILE_HEIGHT / 2)
end

return var_0_1
