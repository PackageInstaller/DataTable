local PathInPolygon = class("PathInPolygon")
local var_0_1 = {
	NO_DATA = 1,
	OK = 0,
	TO_INBLOCK = 5,
	FROM_NOT_INAREA = 2,
	FROM_INBLOCK = 4,
	TO_NOT_INAREA = 3
}
local var_0_2 = {
	MONSTER_W = 80,
	BOX_H = 75,
	MONSTER_OFF_X = 0,
	BOX_OFF_X = 0,
	BOX_W = 75,
	BOX_OFF_Y = -60,
	MONSTER_H = 60,
	MONSTER_OFF_Y = -20
}

function PathInPolygon:ctor(arg_1_1)
	self._params = arg_1_1
	self._areaData = self:_getAreaDataByPath(arg_1_1.areaPath or g.core.common.Path:getDungeonArea(arg_1_1.mapId))
end

function PathInPolygon:_getMonsterBlockList()
	if not self._params.monsterCfg then
		return {}
	end

	local var_2_0 = {}
	local var_2_1 = self._params.monsterCfg

	for iter_2_0 = 1, #self._params.monsterCfg do
		local var_2_2 = var_2_1[iter_2_0].isMonster
		local var_2_3, var_2_4

		if var_2_1[iter_2_0].isMonster then
			var_2_3 = var_0_2.MONSTER_OFF_X or var_0_2.BOX_OFF_X

			if var_2_2 then
				var_2_4 = var_0_2.MONSTER_OFF_Y or var_0_2.BOX_OFF_Y
			end
		end

		local var_2_5 = var_2_1[iter_2_0].pos.x + var_2_3
		local var_2_6 = self:fitPosY(var_2_1[iter_2_0].pos.y) + var_2_4
		local var_2_7, var_2_8, var_2_9

		if var_2_2 then
			var_2_7 = var_0_2.MONSTER_W or var_0_2.BOX_W

			if var_2_2 then
				var_2_8 = var_0_2.MONSTER_H

				if not var_0_2.MONSTER_H then
					var_2_8 = var_0_2.BOX_H
					var_2_9 = var_2_0
				end
			end
		end

		table.insert(var_2_0, {
			xMin = var_2_5 - var_2_7 / 2,
			xMax = var_2_5 + var_2_7 / 2,
			yMin = var_2_6 - var_2_8 / 2,
			yMax = var_2_6 + var_2_8 / 2
		})
	end

	return var_2_0
end

function PathInPolygon:_getAreaDataByPath(arg_3_1)
	if not cc.FileUtils:getInstance():isFileExist(arg_3_1) then
		return nil
	end

	local var_3_0 = json.decodeFile(arg_3_1)
	local var_3_1 = var_3_0.area or {}

	if #var_3_1 <= 2 then
		return nil
	end

	local var_3_2 = {}
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		table.insert(var_3_2, iter_3_1.x)
		table.insert(var_3_3, self:fitPosY(iter_3_1.y))
	end

	local var_3_4 = clone(var_3_2)

	table.sort(var_3_4, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	local var_3_5 = clone(var_3_3)

	table.sort(var_3_5, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	local var_3_6 = var_3_0.block or {}
	local var_3_7 = self:_getMonsterBlockList()

	for iter_3_2 = 1, #var_3_6 do
		table.insert(var_3_7, {
			xMin = var_3_6[iter_3_2].x - var_3_6[iter_3_2].w / 2,
			xMax = var_3_6[iter_3_2].x + var_3_6[iter_3_2].w / 2,
			yMin = var_3_6[iter_3_2].y - var_3_6[iter_3_2].h / 2,
			yMax = var_3_6[iter_3_2].y + var_3_6[iter_3_2].h / 2
		})
	end

	local var_3_8 = {}

	for iter_3_3 = 1, #var_3_7 do
		table.insert(var_3_8, {
			c = {
				x = var_3_7[iter_3_3].xMin,
				y = var_3_7[iter_3_3].yMin
			},
			d = {
				x = var_3_7[iter_3_3].xMax,
				y = var_3_7[iter_3_3].yMin
			}
		})
		table.insert(var_3_8, {
			c = {
				x = var_3_7[iter_3_3].xMin,
				y = var_3_7[iter_3_3].yMax
			},
			d = {
				x = var_3_7[iter_3_3].xMax,
				y = var_3_7[iter_3_3].yMax
			}
		})
		table.insert(var_3_8, {
			c = {
				x = var_3_7[iter_3_3].xMin,
				y = var_3_7[iter_3_3].yMin
			},
			d = {
				x = var_3_7[iter_3_3].xMin,
				y = var_3_7[iter_3_3].yMax
			}
		})
		table.insert(var_3_8, {
			c = {
				x = var_3_7[iter_3_3].xMax,
				y = var_3_7[iter_3_3].yMin
			},
			d = {
				x = var_3_7[iter_3_3].xMax,
				y = var_3_7[iter_3_3].yMax
			}
		})
	end

	return {
		xList = var_3_2,
		yList = var_3_3,
		minMaxList = {
			xMin = var_3_4[1],
			xMax = var_3_4[#var_3_2],
			yMin = var_3_5[1],
			yMax = var_3_5[#var_3_2]
		},
		blockList = var_3_7,
		blockLineList = var_3_8
	}
end

function PathInPolygon:getAreaData()
	return self._areaData
end

function PathInPolygon:checkPointInArea(arg_7_1, arg_7_2)
	if not self._areaData then
		return false
	end

	local var_7_0 = self._areaData.xList
	local var_7_1 = self._areaData.yList

	if arg_7_1 < self._areaData.minMaxList.xMin or arg_7_1 > self._areaData.minMaxList.xMax or arg_7_2 < self._areaData.minMaxList.yMin or arg_7_2 > self._areaData.minMaxList.yMax then
		return false
	end

	local var_7_2 = false
	local var_7_3 = #var_7_0

	for iter_7_0 = 1, #var_7_0 do
		local var_7_4 = iter_7_0 % var_7_3 + 1

		if arg_7_2 < var_7_1[iter_7_0] ~= (arg_7_2 < var_7_1[iter_7_0 % var_7_3 + 1]) and arg_7_1 < (var_7_0[var_7_4] - var_7_0[iter_7_0]) * (arg_7_2 - var_7_1[iter_7_0]) / (var_7_1[var_7_4] - var_7_1[iter_7_0]) + var_7_0[iter_7_0] then
			var_7_2 = not var_7_2
		end
	end

	return var_7_2
end

function PathInPolygon:checkPointInBlock(arg_8_1, arg_8_2)
	if not self._areaData or #self._areaData.blockList < 1 then
		return false
	end

	local var_8_0 = self._areaData.blockList

	for iter_8_0 = 1, #self._areaData.blockList do
		if arg_8_1 >= var_8_0[iter_8_0].xMin and arg_8_1 <= var_8_0[iter_8_0].xMax and arg_8_2 >= var_8_0[iter_8_0].yMin and arg_8_2 <= var_8_0[iter_8_0].yMax then
			return true
		end
	end

	return false
end

function PathInPolygon:getRoutesFromAreaData(arg_9_1, arg_9_2)
	if not self._areaData then
		return var_0_1.NO_DATA, nil
	end

	if not self:checkPointInArea(arg_9_1.x, arg_9_1.y) and self:getAreaPointIndex(arg_9_1) == 0 then
		local var_9_0 = self:getCrossList(arg_9_1, arg_9_2)

		if #var_9_0 > 0 then
			arg_9_1 = var_9_0[1]
		else
			return var_0_1.FROM_NOT_INAREA, nil
		end
	end

	if self:checkPointInBlock(arg_9_1.x, arg_9_1.y) then
		arg_9_1.x = arg_9_1.x - var_0_2.MONSTER_W
	end

	if not self:checkPointInArea(arg_9_2.x, arg_9_2.y) then
		local var_9_1 = self:getCrossList(arg_9_1, arg_9_2)

		if #var_9_1 > 0 then
			arg_9_2 = var_9_1[#var_9_1]
		else
			return var_0_1.TO_NOT_INAREA, nil
		end
	end

	if self:checkPointInBlock(arg_9_2.x, arg_9_2.y) then
		arg_9_2.x = arg_9_2.x - var_0_2.MONSTER_W
	end

	return var_0_1.OK, (self:getShortRouteList((self:calculateAllRouteList(arg_9_1, arg_9_2))))
end

function PathInPolygon:getShortRouteList(arg_10_1)
	for iter_10_0 = 1, #arg_10_1 - 2 do
		if not arg_10_1[iter_10_0].skip then
			if #self:getCrossList(arg_10_1[iter_10_0], arg_10_1[iter_10_0 + 2]) == 0 and self:checkMidPointInArea(arg_10_1[iter_10_0], arg_10_1[iter_10_0 + 2]) then
				arg_10_1[iter_10_0 + 1].skip = true
			end
		end
	end

	local var_10_0 = {}

	for iter_10_1 = 1, #arg_10_1 do
		if not arg_10_1[iter_10_1].skip then
			table.insert(var_10_0, arg_10_1[iter_10_1])
		end
	end

	if #var_10_0 == #arg_10_1 then
		return var_10_0
	else
		return self:getShortRouteList(var_10_0)
	end
end

function PathInPolygon:calculateAllRouteList(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_3 or {}

	if arg_11_1.x == arg_11_2.x and arg_11_1.y == arg_11_2.y then
		return var_11_0
	end

	table.insert(var_11_0, arg_11_1)

	local var_11_1 = self:getCrossList(arg_11_1, arg_11_2)

	if #var_11_1 == 0 then
		table.insert(var_11_0, arg_11_2)

		return var_11_0
	else
		local var_11_2 = var_11_1[1]
		local var_11_3 = 0
		local var_11_4 = 0
		local var_11_5 = 0

		if var_11_1[1].isArea then
			local var_11_6 = self:getAreaPointIndex(arg_11_1)

			if var_11_6 > 0 then
				var_11_5 = var_11_6
			else
				local var_11_7 = var_11_1[2]

				if var_11_1[2] and var_11_7.isArea then
					var_11_6 = var_11_7.c.i
				else
					dump("errrrrrrrrrrrrrrrrrrror")

					if arg_11_1.x == var_11_2.x and arg_11_1.y == var_11_2.y then
						-- block empty
					else
						table.insert(var_11_0, var_11_2)
					end

					return var_11_0
				end
			end

			var_11_3 = self:getTwoIndexMinLen(var_11_6, var_11_2.c.i)
			var_11_4 = self:getTwoIndexMinLen(var_11_6, var_11_2.d.i)
		elseif var_11_2.isBlock then
			var_11_3 = self:getTwoPointLength(arg_11_1, var_11_2.c)
			var_11_4 = self:getTwoPointLength(arg_11_1, var_11_2.d)
		end

		local var_11_8 = var_11_2

		var_11_8 = var_11_3 <= var_11_4 and var_11_2.c or var_11_2.d

		if var_11_5 > 0 then
			local var_11_9 = self._areaData.xList
			local var_11_10 = self._areaData.yList
			local var_11_11 = self:getTwoIndexMinLen(var_11_8.i, var_11_5) <= self:getTwoIndexMinLen(var_11_8.i, var_11_5 % #self._areaData.xList + 1) and var_11_5 or var_11_5 % #self._areaData.xList + 1
			local var_11_12 = {
				x = self._areaData.xList[var_11_11],
				y = self._areaData.yList[var_11_11]
			}

			if self:getTwoPointLength(arg_11_1, var_11_12) == 0 then
				var_11_11 = var_11_11 < var_11_8.i and var_11_11 + 1 or var_11_11 - 1
				var_11_12 = {
					x = var_11_9[var_11_11],
					y = var_11_10[var_11_11]
				}
			end

			var_11_8 = var_11_12
		end

		if #self:getCrossList(arg_11_1, var_11_8) == 0 then
			return self:calculateAllRouteList(var_11_8, arg_11_2, var_11_0)
		else
			local var_11_13 = self:calculateAllRouteList(arg_11_1, var_11_8)

			if #var_11_13 > 1 then
				for iter_11_0 = 2, #var_11_13 - 1 do
					table.insert(var_11_0, var_11_13[iter_11_0])
				end

				return self:calculateAllRouteList(var_11_13[#var_11_13], arg_11_2, var_11_0)
			else
				return var_11_0
			end
		end
	end
end

function PathInPolygon:getCrossList(arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0 = 1, #self._areaData.xList do
		local var_12_1, var_12_2 = self:isTwoLineHaveCrossPoint(arg_12_1, arg_12_2, {
			x = self._areaData.xList[iter_12_0],
			y = self._areaData.yList[iter_12_0],
			i = iter_12_0
		}, {
			x = self._areaData.xList[iter_12_0 % #self._areaData.xList + 1],
			y = self._areaData.yList[iter_12_0 % #self._areaData.xList + 1],
			i = iter_12_0 % #self._areaData.xList + 1
		})

		if var_12_1 then
			var_12_2.isArea = true

			table.insert(var_12_0, var_12_2)
		end
	end

	for iter_12_1 = 1, #self._areaData.blockLineList do
		local var_12_3, var_12_4 = self:isTwoLineHaveCrossPoint(arg_12_1, arg_12_2, self._areaData.blockLineList[iter_12_1].c, self._areaData.blockLineList[iter_12_1].d)

		if var_12_3 then
			var_12_4.isBlock = true

			table.insert(var_12_0, var_12_4)
		end
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		return arg_13_0.length < arg_13_1.length
	end)

	return var_12_0
end

function PathInPolygon:isTwoLineHaveCrossPoint(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if ((arg_14_1.x - arg_14_3.x) * (arg_14_2.y - arg_14_3.y) - (arg_14_1.y - arg_14_3.y) * (arg_14_2.x - arg_14_3.x)) * ((arg_14_1.x - arg_14_4.x) * (arg_14_2.y - arg_14_4.y) - (arg_14_1.y - arg_14_4.y) * (arg_14_2.x - arg_14_4.x)) >= 0 then
		return false, nil
	end

	local var_14_0 = (arg_14_3.x - arg_14_1.x) * (arg_14_4.y - arg_14_1.y) - (arg_14_3.y - arg_14_1.y) * (arg_14_4.x - arg_14_1.x)
	local var_14_1

	if ((arg_14_3.x - arg_14_1.x) * (arg_14_4.y - arg_14_1.y) - (arg_14_3.y - arg_14_1.y) * (arg_14_4.x - arg_14_1.x)) * ((arg_14_3.x - arg_14_1.x) * (arg_14_4.y - arg_14_1.y) - (arg_14_3.y - arg_14_1.y) * (arg_14_4.x - arg_14_1.x) + ((arg_14_1.x - arg_14_3.x) * (arg_14_2.y - arg_14_3.y) - (arg_14_1.y - arg_14_3.y) * (arg_14_2.x - arg_14_3.x)) - ((arg_14_1.x - arg_14_4.x) * (arg_14_2.y - arg_14_4.y) - (arg_14_1.y - arg_14_4.y) * (arg_14_2.x - arg_14_4.x))) >= 0 then
		do return false, nil end

		var_14_1 = {
			x = arg_14_1.x + var_14_0 / ((arg_14_1.x - arg_14_4.x) * (arg_14_2.y - arg_14_4.y) - (arg_14_1.y - arg_14_4.y) * (arg_14_2.x - arg_14_4.x) - ((arg_14_1.x - arg_14_3.x) * (arg_14_2.y - arg_14_3.y) - (arg_14_1.y - arg_14_3.y) * (arg_14_2.x - arg_14_3.x))) * (arg_14_2.x - arg_14_1.x)
		}
	end

	var_14_1.y = arg_14_1.y + var_14_0 / ((arg_14_1.x - arg_14_4.x) * (arg_14_2.y - arg_14_4.y) - (arg_14_1.y - arg_14_4.y) * (arg_14_2.x - arg_14_4.x) - ((arg_14_1.x - arg_14_3.x) * (arg_14_2.y - arg_14_3.y) - (arg_14_1.y - arg_14_3.y) * (arg_14_2.x - arg_14_3.x))) * (arg_14_2.y - arg_14_1.y)
	var_14_1.c = arg_14_3
	var_14_1.d = arg_14_4
	var_14_1.length = self:getPointRankLength(arg_14_1, var_14_1)

	return true, var_14_1
end

function PathInPolygon:getPointRankLength(arg_15_1, arg_15_2)
	return math.abs(arg_15_2.x - arg_15_1.x) + math.abs(arg_15_2.y - arg_15_1.y)
end

function PathInPolygon:getAreaPointIndex(arg_16_1)
	for iter_16_0 = 1, #self._areaData.xList do
		if (arg_16_1.x - self._areaData.xList[iter_16_0]) * (self._areaData.yList[iter_16_0 % #self._areaData.xList + 1] - self._areaData.yList[iter_16_0]) == (arg_16_1.y - self._areaData.yList[iter_16_0]) * (self._areaData.xList[iter_16_0 % #self._areaData.xList + 1] - self._areaData.xList[iter_16_0]) and math.min(self._areaData.xList[iter_16_0], self._areaData.xList[iter_16_0 % #self._areaData.xList + 1]) <= arg_16_1.x and arg_16_1.x <= math.max(self._areaData.xList[iter_16_0], self._areaData.xList[iter_16_0 % #self._areaData.xList + 1]) and math.min(self._areaData.yList[iter_16_0], self._areaData.yList[iter_16_0 % #self._areaData.xList + 1]) <= arg_16_1.y and arg_16_1.y <= math.max(self._areaData.yList[iter_16_0], self._areaData.yList[iter_16_0 % #self._areaData.xList + 1]) then
			return iter_16_0
		end
	end

	return 0
end

function PathInPolygon:getTwoPointLength(arg_17_1, arg_17_2)
	return math.sqrt((arg_17_1.x - arg_17_2.x) * (arg_17_1.x - arg_17_2.x) + (arg_17_1.y - arg_17_2.y) * (arg_17_1.y - arg_17_2.y))
end

function PathInPolygon:getTwoIndexMinLen(arg_18_1, arg_18_2)
	return math.min(math.abs(arg_18_1 - arg_18_2), #self._areaData.xList - math.abs(arg_18_1 - arg_18_2))
end

function PathInPolygon:checkMidPointInArea(arg_19_1, arg_19_2)
	local var_19_0 = {
		x = (arg_19_1.x + arg_19_2.x) / 2,
		y = (arg_19_1.y + arg_19_2.y) / 2
	}

	return self:checkPointInArea(var_19_0.x, var_19_0.y)
end

function PathInPolygon:fitPosY(arg_20_1)
	return arg_20_1 - (display.height - CC_DESIGN_RESOLUTION.height) / 2
end

function PathInPolygon:getPointToRayCross(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = {
		x = arg_21_2.x - arg_21_1.x,
		y = arg_21_2.y - arg_21_1.y
	}
	local var_21_1 = {
		x = arg_21_3.x - arg_21_1.x,
		y = arg_21_3.y - arg_21_1.y
	}

	if var_21_0.x * var_21_1.x + var_21_0.y * var_21_1.y < 0 then
		return false
	end

	local var_21_2 = self:getTwoPointLength(arg_21_1, arg_21_2)
	local var_21_3 = self:getTwoPointLength(arg_21_1, arg_21_3)
	local var_21_4 = var_21_3 * math.sqrt(1 - (var_21_0.x * var_21_1.x + var_21_0.y * var_21_1.y) / (var_21_2 * var_21_3) * ((var_21_0.x * var_21_1.x + var_21_0.y * var_21_1.y) / (var_21_2 * var_21_3)))
	local var_21_5, var_21_6

	if not arg_21_3.radius or var_21_4 >= arg_21_3.radius then
		do return false end

		var_21_5 = var_21_3 * ((var_21_0.x * var_21_1.x + var_21_0.y * var_21_1.y) / (var_21_2 * var_21_3)) - math.sqrt(arg_21_3.radius * arg_21_3.radius - var_21_4 * var_21_4)
		var_21_6 = {}
	end

	var_21_6.crossLen = var_21_3 * ((var_21_0.x * var_21_1.x + var_21_0.y * var_21_1.y) / (var_21_2 * var_21_3))
	var_21_6.crossPoint = {
		x = arg_21_1.x + var_21_0.x * var_21_5 / var_21_2,
		y = arg_21_1.y + var_21_0.y * var_21_5 / var_21_2
	}
	var_21_6.circlePoint = arg_21_3

	return true, var_21_6
end

function PathInPolygon:getLineToRayCross(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = {
		x = arg_22_2.x - arg_22_1.x,
		y = arg_22_2.y - arg_22_1.y
	}
	local var_22_1 = self:getTwoPointLength(arg_22_1, arg_22_2)

	arg_22_2 = {
		x = arg_22_1.x + var_22_0.x * 1.5 * display.width / var_22_1,
		y = arg_22_1.y + var_22_0.y * 1.5 * display.width / var_22_1
	}

	local var_22_2, var_22_3 = self:isTwoLineHaveCrossPoint(arg_22_1, arg_22_2, arg_22_3.from, arg_22_3.to)

	if var_22_2 then
		return true, {
			crossLen = self:getTwoPointLength(arg_22_1, var_22_3),
			crossPoint = var_22_3,
			line = arg_22_3
		}
	end

	return false
end

function PathInPolygon:getReflectToByCircle(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = {
		x = arg_23_1.x - arg_23_3.x,
		y = arg_23_1.y - arg_23_3.y
	}
	local var_23_1 = {
		x = arg_23_2.x - arg_23_3.x,
		y = arg_23_2.y - arg_23_3.y
	}
	local var_23_2 = self:getTwoPointLength(arg_23_3, arg_23_1)
	local var_23_3 = self:getTwoPointLength(arg_23_3, arg_23_2)
	local var_23_4 = {
		x = arg_23_3.x + var_23_1.x * (var_23_2 * ((var_23_0.x * var_23_1.x + var_23_0.y * var_23_1.y) / (var_23_2 * var_23_3))) / var_23_3,
		y = arg_23_3.y + var_23_1.y * (var_23_2 * ((var_23_0.x * var_23_1.x + var_23_0.y * var_23_1.y) / (var_23_2 * var_23_3))) / var_23_3
	}

	return arg_23_2, {
		x = 2 * var_23_4.x - arg_23_1.x,
		y = 2 * var_23_4.y - arg_23_1.y
	}
end

function PathInPolygon:getReflectToByLine(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = {
		x = arg_24_2.x - arg_24_3.from.x,
		y = arg_24_2.y - arg_24_3.from.y
	}

	return self:getReflectToByCircle(arg_24_1, arg_24_2, {
		x = arg_24_2.x + var_24_0.y,
		y = arg_24_2.y - var_24_0.x
	})
end

function PathInPolygon:getAngelByFromTo(arg_25_1, arg_25_2)
	return math.atan2(arg_25_2.y - arg_25_1.y, arg_25_2.x - arg_25_1.x) * 180 / math.pi
end

return PathInPolygon
