module("framework.pathfinding.astar.AstarPathFinder", package.seeall)

local var_0_0 = class("AstarPathFinder")

var_0_0.HV_COST = 1
var_0_0.DIAGONAL_COST = math.sqrt(2)
var_0_0.DX = {
	-1,
	0,
	1,
	1,
	1,
	0,
	-1,
	-1
}
var_0_0.DY = {
	-1,
	-1,
	-1,
	0,
	1,
	1,
	1,
	0
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._mapData = MapData.New()
	arg_1_0._cacheStarNode = {}
	arg_1_0._canWalkIncline = true
end

function var_0_0.setMapData(arg_2_0, arg_2_1)
	arg_2_0._mapData = arg_2_1 or MapData.New()
end

function var_0_0.setCanWalkIncline(arg_3_0, arg_3_1)
	arg_3_0._canWalkIncline = arg_3_1
end

function var_0_0.clearMapData(arg_4_0)
	arg_4_0._mapData:clear()
end

function var_0_0.isWalkable(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0._mapData:isWalkable(arg_5_1, arg_5_2)
end

function var_0_0.setCanWalkable(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._mapData:setCanWalkable(arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0._isDirectWalkable(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_3 - arg_7_1
	local var_7_1 = arg_7_4 - arg_7_2

	if not arg_7_0._canWalkIncline and math.abs(var_7_0) >= 1 and math.abs(var_7_1) >= 1 then
		return false
	end

	local var_7_2 = 1
	local var_7_3 = math.sqrt(var_7_1 * var_7_1 + var_7_0 * var_7_0)
	local var_7_4 = 0

	while var_7_4 < var_7_3 + var_7_2 do
		local var_7_5 = var_7_4 / var_7_3
		local var_7_6 = arg_7_1 + math.round(var_7_0 * var_7_5)
		local var_7_7 = arg_7_2 + math.round(var_7_1 * var_7_5)

		if not arg_7_0:isWalkable(var_7_6, var_7_7) then
			return false
		end

		var_7_4 = var_7_4 + var_7_2
	end

	return true
end

function var_0_0._optimizePath(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = #arg_8_3
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_2
	local var_8_3 = {}

	for iter_8_0 = 2, var_8_0 do
		if not arg_8_0:_isDirectWalkable(var_8_1, var_8_2, arg_8_3[iter_8_0].x, arg_8_3[iter_8_0].y) then
			var_8_3[iter_8_0 - 1] = true
			var_8_1 = arg_8_3[iter_8_0 - 1].x
			var_8_2 = arg_8_3[iter_8_0 - 1].y
		end
	end

	var_8_3[var_8_0] = true

	for iter_8_1 = var_8_0, 1, -1 do
		if not var_8_3[iter_8_1] then
			table.remove(arg_8_3, iter_8_1)
		end
	end
end

function var_0_0._getNearestWalkbaleGridInLine(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = 0
	local var_9_1 = 0

	if arg_9_0:isWalkable(arg_9_3, arg_9_4) then
		var_9_0 = arg_9_3
		var_9_1 = arg_9_4

		return true, var_9_0, var_9_1
	end

	local var_9_2 = arg_9_1 - arg_9_3
	local var_9_3 = arg_9_2 - arg_9_4
	local var_9_4 = 1
	local var_9_5 = math.sqrt(var_9_3 * var_9_3 + var_9_2 * var_9_2)
	local var_9_6 = 1

	while var_9_6 < var_9_5 + var_9_4 do
		local var_9_7 = var_9_6 / var_9_5
		local var_9_8 = arg_9_3 + math.round(var_9_2 * var_9_7)
		local var_9_9 = arg_9_4 + math.round(var_9_3 * var_9_7)

		if arg_9_0:isWalkable(var_9_8, var_9_9) then
			var_9_0 = var_9_8
			var_9_1 = var_9_9

			return true, var_9_0, var_9_1
		end

		var_9_6 = var_9_6 + var_9_4
	end

	return false, var_9_0, var_9_1
end

function var_0_0._getPathInTargetRange(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = #arg_10_1

	if arg_10_2 < var_10_0 then
		if arg_10_2 > 0 then
			for iter_10_0 = arg_10_2, 1, -1 do
				table.remove(arg_10_1, #arg_10_1)
			end
		end
	else
		for iter_10_1 = var_10_0, 1, -1 do
			table.remove(arg_10_1, iter_10_1)
		end
	end
end

function var_0_0.findPath(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	arg_11_7 = arg_11_7 or 0

	if arg_11_1 == arg_11_3 and arg_11_2 == arg_11_4 then
		return false, {}
	end

	local var_11_0, var_11_1, var_11_2 = arg_11_0:_getNearestWalkbaleGridInLine(arg_11_1, arg_11_2, arg_11_3, arg_11_4)

	if not var_11_0 then
		return false, {}
	end

	local var_11_3, var_11_4 = arg_11_0:_realFind(arg_11_1, arg_11_2, var_11_1, var_11_2, arg_11_6)

	if var_11_3 then
		if var_11_1 ~= arg_11_3 or var_11_2 ~= arg_11_4 then
			arg_11_7 = arg_11_7 - math.max(math.abs(var_11_1 - arg_11_3), math.abs(var_11_2 - arg_11_4))
			arg_11_7 = math.max(0, arg_11_7)
		end

		arg_11_0:_getPathInTargetRange(var_11_4, arg_11_7)

		if arg_11_5 == true then
			arg_11_0:_optimizePath(arg_11_1, arg_11_2, var_11_4)
		end
	end

	return var_11_3, var_11_4
end

function var_0_0._getOrCreateNode(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._cacheStarNode[arg_12_1] == nil then
		arg_12_0._cacheStarNode[arg_12_1] = {}
	end

	if arg_12_0._cacheStarNode[arg_12_1][arg_12_2] then
		return arg_12_0._cacheStarNode[arg_12_1][arg_12_2]
	end

	local var_12_0 = AStarPathNode.New(arg_12_1, arg_12_2)

	arg_12_0._cacheStarNode[arg_12_1][arg_12_2] = var_12_0

	return var_12_0
end

function var_0_0._realFind(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local function var_13_0(arg_14_0, arg_14_1)
		return arg_14_0.f < arg_14_1.f
	end

	local var_13_1 = UHeap.New(var_13_0)
	local var_13_2 = {}
	local var_13_3 = arg_13_0:_getOrCreateNode(arg_13_1, arg_13_2)
	local var_13_4 = arg_13_0:_getOrCreateNode(arg_13_3, arg_13_4)
	local var_13_5 = var_13_3

	var_13_5.g = 0

	while var_13_5 ~= var_13_4 do
		for iter_13_0 = 1, 8 do
			repeat
				local var_13_6 = var_13_5.gridX + arg_13_0.DX[iter_13_0]
				local var_13_7 = var_13_5.gridY + arg_13_0.DY[iter_13_0]

				if not arg_13_0:isWalkable(var_13_6, var_13_7) then
					break
				end

				if arg_13_0.DX[iter_13_0] ~= 0 and arg_13_0.DY[iter_13_0] ~= 0 and (not arg_13_0:isWalkable(var_13_6, var_13_5.gridY) or not arg_13_0:isWalkable(var_13_5.gridX, var_13_7) or arg_13_5 == true) then
					break
				end

				local var_13_8 = arg_13_0:_getOrCreateNode(var_13_6, var_13_7)
				local var_13_9 = 0

				if math.abs(arg_13_0.DX[iter_13_0]) == math.abs(arg_13_0.DY[iter_13_0]) then
					var_13_9 = var_13_5.g + arg_13_0.DIAGONAL_COST
				else
					var_13_9 = var_13_5.g + arg_13_0.HV_COST
				end

				local var_13_10 = var_13_6 - arg_13_3
				local var_13_11 = var_13_7 - arg_13_4
				local var_13_12 = var_13_9 + math.sqrt(var_13_10 * var_13_10 + var_13_11 * var_13_11) * 2

				if var_13_1:contains(var_13_8) or var_13_2[var_13_8.gridX] and var_13_2[var_13_8.gridX][var_13_8.gridY] then
					if var_13_12 < var_13_8.f then
						var_13_8.g = var_13_9
						var_13_8.f = var_13_12
						var_13_8.parent = var_13_5
					end

					break
				end

				var_13_8.g = var_13_9
				var_13_8.f = var_13_12
				var_13_8.parent = var_13_5

				var_13_1:push(var_13_8)
			until true
		end

		if var_13_2[var_13_5.gridX] == nil then
			var_13_2[var_13_5.gridX] = {}
		end

		var_13_2[var_13_5.gridX][var_13_5.gridY] = true

		if var_13_1:empty() then
			print(string.format("Cannot find a path! (%s, %s) --> (%s, %s)...", arg_13_1, arg_13_2, arg_13_3, arg_13_4))

			arg_13_0._cacheStarNode = {}

			return false, {}
		end

		var_13_5 = var_13_1:top()

		var_13_1:pop()
	end

	local var_13_13 = {}

	while var_13_5 ~= var_13_3 do
		local var_13_14 = Vector2.New(var_13_5.gridX, var_13_5.gridY)

		table.insert(var_13_13, var_13_14)

		var_13_5 = var_13_5.parent
	end

	local var_13_15 = {}

	for iter_13_1 = #var_13_13, 1, -1 do
		table.insert(var_13_15, var_13_13[iter_13_1])
	end

	arg_13_0._cacheStarNode = {}

	return true, var_13_15
end

return var_0_0
