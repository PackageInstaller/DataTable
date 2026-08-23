local var_0_0 = g.core.const.ConstMgr.GveConst
local var_0_1 = {
	pixelToCoord = function(arg_1_0, arg_1_1)
		return math.round((arg_1_0 / (var_0_0.MAP_TILE_WIDTH / 2) + -arg_1_1 / (var_0_0.MAP_TILE_HEIGHT / 2)) / 2), math.round((-arg_1_1 / (var_0_0.MAP_TILE_HEIGHT / 2) - arg_1_0 / (var_0_0.MAP_TILE_WIDTH / 2)) / 2)
	end,
	coordToPixel = function(arg_2_0, arg_2_1)
		return (arg_2_0 - arg_2_1) * (var_0_0.MAP_TILE_WIDTH / 2), -(arg_2_0 + arg_2_1) * (var_0_0.MAP_TILE_HEIGHT / 2)
	end,
	coordToCompPos = function(arg_3_0, arg_3_1)
		return (arg_3_0 - arg_3_1) * (var_0_0.MAP_TILE_WIDTH / 2) + display.width / 2, -(-(arg_3_0 + arg_3_1) * (var_0_0.MAP_TILE_HEIGHT / 2)) + display.height / 2
	end,
	pointList = {
		["6_2"] = 2,
		["5_2"] = 2,
		["4_2"] = 2,
		["4_9"] = 2,
		["3_9"] = 2,
		["2_9"] = 2,
		["1_9"] = 2,
		["2_7"] = 2,
		["1_7"] = 2,
		["2_6"] = 2,
		["1_6"] = 2,
		["6_6"] = 2,
		["4_7"] = 2,
		["5_7"] = 2,
		["5_6"] = 2,
		["5_5"] = 2,
		["5_4"] = 2,
		["3_4"] = 2,
		["2_4"] = 2,
		["2_3"] = 2,
		["2_2"] = 2,
		["3_1"] = 2,
		["2_1"] = 2,
		["1_1"] = 2
	},
	minePointList = {
		["2_7"] = true,
		["2_1"] = true
	},
	tuanList = {},
	haveNearXYNum = function(self, arg_4_1, arg_4_2)
		return (self[arg_4_1 - 1 .. "_" .. arg_4_2] and 1 or 0) + (self[arg_4_1 + 1 .. "_" .. arg_4_2] and 1 or 0) + (self[arg_4_1 .. "_" .. arg_4_2 - 1] and 1 or 0) + (self[arg_4_1 .. "_" .. arg_4_2 + 1] and 1 or 0)
	end
}

function var_0_1.setPointColorType(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = false

	if var_0_1.minePointList[arg_5_1 .. "_" .. arg_5_2] then
		var_0_1.pointList[arg_5_1 .. "_" .. arg_5_2] = var_0_0.COLOR_TYPE.MINE
		var_5_0 = true
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0) do
		if var_0_1.pointList[iter_5_0] == var_0_0.COLOR_TYPE.MINE or var_0_1.pointList[iter_5_0] == var_0_0.COLOR_TYPE.OTHER_PASS then
			if var_0_1.minePointList[arg_5_1 .. "_" .. arg_5_2] then
				var_0_1.pointList[arg_5_1 .. "_" .. arg_5_2] = var_0_0.COLOR_TYPE.MINE or var_0_0.COLOR_TYPE.OTHER_PASS
			end

			break
		elseif var_5_0 then
			if var_0_1.minePointList[iter_5_0] then
				var_0_1.pointList[iter_5_0] = var_0_0.COLOR_TYPE.MINE or var_0_0.COLOR_TYPE.OTHER_PASS
			end
		else
			break
		end
	end
end

function var_0_1.restoreTuanList()
	var_0_1.tuanList = {}

	for iter_6_0, iter_6_1 in pairs(var_0_1.pointList) do
		local var_6_0 = string.split(iter_6_0, "_")

		var_0_1.addPoint(tonumber(var_6_0[1]), (tonumber(var_6_0[2])))
	end
end

function var_0_1.addPoint(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 or var_0_1.tuanList

	local var_7_0 = var_0_1.haveNearXYNum(var_0_1.pointList, arg_7_0, arg_7_1)
	local var_7_1 = {}

	for iter_7_0 = 1, #arg_7_2 do
		local var_7_2 = var_0_1.haveNearXYNum(arg_7_2[iter_7_0], arg_7_0, arg_7_1)

		if var_7_2 > 0 then
			if #var_7_1 == 0 then
				var_0_1.setPointColorType(arg_7_2[iter_7_0], arg_7_0, arg_7_1)

				arg_7_2[iter_7_0][arg_7_0 .. "_" .. arg_7_1] = true
			end

			table.insert(var_7_1, iter_7_0)

			var_7_0 = var_7_0 - var_7_2

			if var_7_0 <= 0 then
				break
			end
		end
	end

	if #var_7_1 == 0 then
		local var_7_3 = {
			[arg_7_0 .. "_" .. arg_7_1] = true
		}

		var_0_1.setPointColorType(var_7_3, arg_7_0, arg_7_1)
		table.insert(arg_7_2, var_7_3)
	elseif #var_7_1 > 1 then
		for iter_7_1 = #var_7_1, 2, -1 do
			for iter_7_2, iter_7_3 in pairs(arg_7_2[var_7_1[iter_7_1]]) do
				local var_7_4 = string.split(iter_7_2, "_")

				var_0_1.setPointColorType(arg_7_2[var_7_1[1]], tonumber(var_7_4[1]), (tonumber(var_7_4[2])))

				arg_7_2[var_7_1[1]][iter_7_2] = iter_7_3
			end

			table.remove(arg_7_2, var_7_1[iter_7_1])
		end
	end
end

function var_0_1.delPoint(arg_8_0, arg_8_1)
	local var_8_0 = 0

	for iter_8_0 = 1, #var_0_1.tuanList do
		if var_0_1.tuanList[iter_8_0][arg_8_0 .. "_" .. arg_8_1] then
			var_0_1.tuanList[iter_8_0][arg_8_0 .. "_" .. arg_8_1] = nil
			var_8_0 = iter_8_0

			break
		end
	end

	if var_8_0 == 0 then
		return
	end

	local var_8_1 = {}

	for iter_8_1, iter_8_2 in pairs(var_0_1.tuanList[var_8_0]) do
		local var_8_2 = string.split(iter_8_1, "_")

		if var_0_1.pointList[iter_8_1] then
			var_0_1.pointList[iter_8_1] = var_0_0.COLOR_TYPE.OTHER_NO_PASS
		end

		var_0_1.addPoint(tonumber(var_8_2[1]), tonumber(var_8_2[2]), var_8_1)
	end

	table.remove(var_0_1.tuanList, var_8_0)

	for iter_8_3 = 1, #var_8_1 do
		table.insert(var_0_1.tuanList, var_8_1[iter_8_3])
	end
end

return var_0_1
