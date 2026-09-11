local ReversePacmanRouteGraph = class("ReversePacmanRouteGraph")
local var_0_1 = {
	ReversePacmanConst.DIR.UP,
	ReversePacmanConst.DIR.RIGHT,
	ReversePacmanConst.DIR.DOWN,
	ReversePacmanConst.DIR.LEFT
}

local function var_0_2(arg_1_0, arg_1_1)
	return arg_1_0 .. "_" .. arg_1_1
end

local function var_0_3(arg_2_0)
	if arg_2_0 == ReversePacmanConst.DIR.UP then
		return ReversePacmanConst.DIR.DOWN
	end

	if arg_2_0 == ReversePacmanConst.DIR.RIGHT then
		return ReversePacmanConst.DIR.LEFT
	end

	if arg_2_0 == ReversePacmanConst.DIR.DOWN then
		return ReversePacmanConst.DIR.UP
	end

	if arg_2_0 == ReversePacmanConst.DIR.LEFT then
		return ReversePacmanConst.DIR.RIGHT
	end

	return nil
end

function ReversePacmanRouteGraph:Ctor()
	self.nodes = {}
	self.nodeByPos = {}

	return
end

function ReversePacmanRouteGraph:Build(arg_4_1)
	self.nodes = {}
	self.nodeByPos = {}
	self.blockedNodeIds = {}
	self._distCache = {}
	self._distCacheOrder = {}
	self.map = arg_4_1
	self.grid = arg_4_1.grid or {}
	self.width = arg_4_1.width or 0
	self.height = arg_4_1.height or 0
	self.cellSize = ReversePacmanConst.GRID_SIZE
	self.mapSize = {
		x = self.width * self.cellSize.x,
		y = self.height * self.cellSize.y
	}

	local var_4_0 = 0

	for iter_4_0 = 1, self.height do
		for iter_4_1 = 1, self.width do
			if self.grid[iter_4_0] then
				local var_4_1 = self.grid[iter_4_0][iter_4_1] or ReversePacmanConst.GRID.BLOCK

				if var_4_1 ~= ReversePacmanConst.GRID.BLOCK then
					var_4_0 = var_4_0 + 1

					local var_4_2 = {
						degree = 0,
						id = var_4_0,
						x = iter_4_1,
						y = iter_4_0,
						cell = var_4_1,
						neighbors = {},
						dirs = {},
						pos = self:GetLocalPosInMap(iter_4_1, iter_4_0),
						tag = ReversePacmanConst.TAG.ISOLATED
					}

					self.nodes[var_4_0] = var_4_2
					self.nodeByPos[var_0_2(iter_4_1, iter_4_0)] = var_4_2
				end
			end
		end
	end

	for iter_4_2, iter_4_3 in ipairs(self.nodes) do
		self:_RebuildNodeAdjacency(iter_4_3)
	end

	return self
end

function ReversePacmanRouteGraph:_RebuildNodeAdjacency(arg_5_1)
	arg_5_1.neighbors = {}
	arg_5_1.dirs = {}

	if not self.blockedNodeIds[arg_5_1.id] then
		for iter_5_0, iter_5_1 in ipairs(var_0_1) do
			local var_5_0 = self.nodeByPos[var_0_2(arg_5_1.x + ReversePacmanConst.DIR_VECTORS[iter_5_1].x, arg_5_1.y + ReversePacmanConst.DIR_VECTORS[iter_5_1].y)]

			if var_5_0 and not self.blockedNodeIds[var_5_0.id] then
				arg_5_1.neighbors[#arg_5_1.neighbors + 1] = var_5_0.id
				arg_5_1.dirs[var_5_0.id] = iter_5_1
			end
		end
	end

	arg_5_1.degree = #arg_5_1.neighbors
	arg_5_1.tag = self:ResolveTag(arg_5_1)

	return
end

function ReversePacmanRouteGraph:_RefreshTopology()
	for iter_6_0, iter_6_1 in ipairs(self.nodes) do
		self:_RebuildNodeAdjacency(iter_6_1)
	end

	return
end

function ReversePacmanRouteGraph:ResolveTag(arg_7_1)
	local var_7_0 = arg_7_1.degree or 0

	if var_7_0 <= 0 then
		return ReversePacmanConst.TAG.ISOLATED
	end

	if var_7_0 == 1 then
		return ReversePacmanConst.TAG.DEAD_END
	end

	if var_7_0 == 2 then
		if arg_7_1.dirs[arg_7_1.neighbors[1]] and arg_7_1.dirs[arg_7_1.neighbors[2]] and var_0_3(arg_7_1.dirs[arg_7_1.neighbors[1]]) == arg_7_1.dirs[arg_7_1.neighbors[2]] then
			return ReversePacmanConst.TAG.CORRIDOR
		end

		return ReversePacmanConst.TAG.CORNER
	end

	return ReversePacmanConst.TAG.JUNCTION
end

function ReversePacmanRouteGraph:AddBlockNode(arg_8_1, arg_8_2)
	local var_8_0 = self:GetNodeByPos(arg_8_1, arg_8_2)

	if var_8_0 then
		self.blockedNodeIds[var_8_0.id] = true

		self:_RefreshTopology()

		self._distCache = {}
		self._distCacheOrder = {}
	end

	return
end

function ReversePacmanRouteGraph:RemoveBlockNode(arg_9_1, arg_9_2)
	local var_9_0 = self:GetNodeByPos(arg_9_1, arg_9_2)

	if var_9_0 then
		self.blockedNodeIds[var_9_0.id] = nil

		self:_RefreshTopology()

		self._distCache = {}
		self._distCacheOrder = {}
	end

	return
end

function ReversePacmanRouteGraph:IsBuffBlock(arg_10_1, arg_10_2)
	local var_10_0 = self:GetNodeByPos(arg_10_1, arg_10_2)

	return var_10_0 ~= nil and self.blockedNodeIds[var_10_0.id] == true
end

function ReversePacmanRouteGraph:IsBuffBlockById(arg_11_1)
	return arg_11_1 ~= nil and self.blockedNodeIds[arg_11_1] == true
end

function ReversePacmanRouteGraph:GetNodeById(arg_12_1)
	return self.nodes[arg_12_1]
end

function ReversePacmanRouteGraph:GetMapSize()
	return self.mapSize
end

function ReversePacmanRouteGraph:GetCellSize()
	return self.cellSize
end

function ReversePacmanRouteGraph:GetNodeByPos(arg_15_1, arg_15_2)
	return self.nodeByPos[var_0_2(arg_15_1, arg_15_2)]
end

function ReversePacmanRouteGraph:GetNeighbors(arg_16_1)
	if not self.nodes[arg_16_1] then
		return {}
	end

	return self.nodes[arg_16_1].neighbors
end

function ReversePacmanRouteGraph:GetDirection(arg_17_1, arg_17_2)
	if not self.nodes[arg_17_1] then
		return nil
	end

	return self.nodes[arg_17_1].dirs[arg_17_2]
end

function ReversePacmanRouteGraph:GetDistanceField(arg_18_1)
	self._distCache = self._distCache or {}
	self._distCacheOrder = self._distCacheOrder or {}

	if self._distCache[arg_18_1] then
		for iter_18_0, iter_18_1 in ipairs(self._distCacheOrder) do
			if iter_18_1 == arg_18_1 then
				table.remove(self._distCacheOrder, iter_18_0)

				break
			end
		end

		self._distCacheOrder[#self._distCacheOrder + 1] = arg_18_1

		return self._distCache[arg_18_1]
	end

	local var_18_0 = {}

	if not self.nodes[arg_18_1] then
		return var_18_0
	end

	var_18_0[arg_18_1] = 0

	local var_18_1 = {
		arg_18_1
	}
	local var_18_2 = 1

	while var_18_1[var_18_2] do
		var_18_2 = var_18_2 + 1

		for iter_18_2, iter_18_3 in ipairs(self.nodes[var_18_1[var_18_2]].neighbors) do
			if var_18_0[iter_18_3] == nil then
				var_18_0[iter_18_3] = var_18_0[var_18_1[var_18_2]] + 1
				var_18_1[#var_18_1 + 1] = iter_18_3
			end
		end
	end

	self._distCache[arg_18_1] = var_18_0
	self._distCacheOrder[#self._distCacheOrder + 1] = arg_18_1

	if 64 < #self._distCacheOrder then
		local var_18_3 = table.remove(self._distCacheOrder, 1)

		if var_18_3 then
			self._distCache[var_18_3] = nil
		end
	end

	return var_18_0
end

function ReversePacmanRouteGraph:GetDistanceById(arg_19_1, arg_19_2)
	if not arg_19_1 or not arg_19_2 then
		return nil
	end

	return self:GetDistanceField(arg_19_2)[arg_19_1]
end

function ReversePacmanRouteGraph:IsReachable(arg_20_1, arg_20_2)
	return self:GetDistanceById(arg_20_1, arg_20_2) ~= nil
end

function ReversePacmanRouteGraph:FindPath(arg_21_1, arg_21_2)
	if arg_21_1 == arg_21_2 then
		return {
			arg_21_1
		}
	end

	if not self.nodes[arg_21_1] or not self.nodes[arg_21_2] then
		return nil
	end

	local var_21_0 = {
		arg_21_1
	}
	local var_21_1 = 1
	local var_21_2 = {
		[arg_21_1] = true
	}
	local var_21_3 = {}

	while var_21_0[var_21_1] do
		var_21_1 = var_21_1 + 1

		for iter_21_0, iter_21_1 in ipairs(self.nodes[var_21_0[var_21_1]].neighbors) do
			if not var_21_2[iter_21_1] then
				var_21_2[iter_21_1] = true
				var_21_3[iter_21_1] = var_21_0[var_21_1]

				if iter_21_1 == arg_21_2 then
					local var_21_4 = 0
					local var_21_5 = arg_21_2

					while var_21_5 do
						var_21_4 = var_21_4 + 1

						if var_21_5 == arg_21_1 then
							break
						end

						var_21_5 = var_21_3[var_21_5]
					end

					local var_21_6 = {}
					local var_21_7 = arg_21_2

					for iter_21_2 = var_21_4, 1, -1 do
						var_21_6[iter_21_2] = var_21_7
						var_21_7 = var_21_3[var_21_7]
					end

					return var_21_6
				end

				var_21_0[#var_21_0 + 1] = iter_21_1
			end
		end
	end

	return nil
end

function ReversePacmanRouteGraph:GetManhattanDisById(arg_22_1, arg_22_2)
	return self:GetManhattanDisByNode(self.nodes[arg_22_1], self.nodes[arg_22_2])
end

function ReversePacmanRouteGraph:GetManhattanDisByNode(arg_23_1, arg_23_2)
	return math.abs(arg_23_1.x - arg_23_2.x) + math.abs(arg_23_1.y - arg_23_2.y)
end

function ReversePacmanRouteGraph:IsWalkable(arg_24_1, arg_24_2)
	return self:GetNodeByPos(arg_24_1, arg_24_2) ~= nil
end

function ReversePacmanRouteGraph:GetLocalPosInMap(arg_25_1, arg_25_2)
	return {
		x = (arg_25_1 - 1) * self.cellSize.x - self.mapSize.x / 2 + self.cellSize.x / 2,
		y = self.mapSize.y / 2 - (arg_25_2 - 1) * self.cellSize.y - self.cellSize.y / 2
	}
end

function ReversePacmanRouteGraph:GetNodeIdByLocalPos(arg_26_1)
	local var_26_0 = math.floor((arg_26_1.x + self.mapSize.x / 2) / self.cellSize.x) + 1
	local var_26_1 = math.floor((self.mapSize.y / 2 - arg_26_1.y) / self.cellSize.y) + 1

	if var_26_0 < 1 or var_26_0 > self.width or var_26_1 < 1 or var_26_1 > self.height then
		return nil
	end

	local var_26_2 = self.nodeByPos[var_0_2(var_26_0, var_26_1)]

	return (var_26_2 or nil) and (var_26_2.id or nil)
end

function ReversePacmanRouteGraph:GetCellByLocalPos(arg_27_1)
	local var_27_0 = math.floor((arg_27_1.x + self.mapSize.x / 2) / self.cellSize.x) + 1
	local var_27_1 = math.floor((self.mapSize.y / 2 - arg_27_1.y) / self.cellSize.y) + 1

	if var_27_0 < 1 or var_27_0 > self.width or var_27_1 < 1 or var_27_1 > self.height then
		return nil
	end

	return {
		x = var_27_0,
		y = var_27_1
	}
end

return ReversePacmanRouteGraph
