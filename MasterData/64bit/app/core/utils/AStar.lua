local AStar = class("AStar")

function AStar:ctor()
	self.closedSet = {}
	self.openSet = {}
	self.cameFrom = {}
	self.fScore = {}
	self.gScore = {}
end

local function var_0_1(arg_2_0)
	return arg_2_0.x .. "_" .. arg_2_0.y
end

local function var_0_2(arg_3_0)
	local var_3_0 = string.split(arg_3_0, "_")

	return cc.p(tonumber(var_3_0[1]), (tonumber(var_3_0[2])))
end

function AStar:setCalcNeighborFunc(arg_4_1)
	assert(type(arg_4_1) == "function", "calcNeighborFunc must be a function")

	self._calcNeighborFunc = arg_4_1
end

function AStar:setCalcBlockFunc(arg_5_1)
	assert(type(arg_5_1) == "function", "setCalcBlockFunc must be a function")

	self._calcBlockFunc = arg_5_1
end

function AStar:setCalcDistFunc(arg_6_1)
	assert(type(arg_6_1) == "function", "calcDistFunc must be a table")

	self._calcDistFunc = arg_6_1
end

function AStar:setEstimateCostFunc(arg_7_1)
	assert(type(arg_7_1) == "function", "estimateCostFunc must be a table")

	self._estimateCostFunc = arg_7_1
end

function AStar:getPath2(arg_8_1, arg_8_2, arg_8_3)
	assert(self._calcNeighborFunc, "calcNeighbor function must be no nil")
	assert(self._calcDistFunc, "calcDist function must be no nil")

	arg_8_1 = var_0_1(arg_8_1)
	arg_8_2 = var_0_1(arg_8_2)
	self.closedSet = {}
	self.openSet = {}
	self.openSet[arg_8_1] = true
	self.cameFrom = {}
	self.gScore = {}
	self.gScore[arg_8_1] = 0
	self.fScore = {}
	self.fScore[arg_8_1] = 0

	if self._estimateCostFunc then
		self.fScore[arg_8_1] = self._estimateCostFunc(var_0_2(arg_8_1), var_0_2(arg_8_2))
	end

	arg_8_3 = arg_8_3 and math.max(arg_8_3, 1000)

	local var_8_0 = 0

	while next(self.openSet) and (not arg_8_3 or var_8_0 <= arg_8_3) do
		local var_8_1

		if self._estimateCostFunc then
			for iter_8_0, iter_8_1 in pairs(self.openSet) do
				if var_8_1 == nil then
					var_8_1 = iter_8_0
				elseif not self.fScore[var_8_1] or self.fScore[iter_8_0] and self.fScore[iter_8_0] < self.fScore[var_8_1] then
					var_8_1 = iter_8_0
				end
			end
		else
			var_8_1 = next(self.openSet)
		end

		if var_8_1 == arg_8_2 then
			return self:_reconstrunctPath(self.cameFrom, var_8_1)
		end

		var_8_0 = var_8_0 + 1
		self.openSet[var_8_1] = nil
		self.closedSet[var_8_1] = true

		local var_8_2 = self._calcNeighborFunc(var_0_2(var_8_1), var_0_2(arg_8_1), var_0_2(arg_8_2))

		if var_8_2 and next(var_8_2) then
			for iter_8_2, iter_8_3 in ipairs(var_8_2) do
				iter_8_3 = var_0_1(iter_8_3)

				if not self.closedSet[iter_8_3] then
					local var_8_3
					local var_8_4 = self._calcDistFunc(var_0_2(var_8_1), var_0_2(iter_8_3))

					if self.gScore[var_8_1] and var_8_4 then
						var_8_3 = self.gScore[var_8_1] + var_8_4
					end

					self.openSet[iter_8_3] = self.openSet[iter_8_3] or true

					if var_8_3 and (not self.gScore[iter_8_3] or var_8_3 < self.gScore[iter_8_3]) then
						self.cameFrom[iter_8_3] = var_8_1
						self.gScore[iter_8_3] = var_8_3

						if self._estimateCostFunc then
							local var_8_5 = self._estimateCostFunc(var_0_2(iter_8_3), var_0_2(arg_8_2))

							self.fScore[iter_8_3] = self.gScore[iter_8_3] and var_8_5 and self.gScore[iter_8_3] + var_8_5 or nil
						end
					end
				end
			end
		else
			-- block empty
		end
	end

	return nil
end

local BinaryHeap = require("app.core.utils.BinaryHeap")

function AStar:getPath(arg_9_1, arg_9_2, arg_9_3)
	assert(self._calcNeighborFunc, "calcNeighbor function must be no nil")
	assert(self._calcDistFunc, "calcDist function must be no nil")

	arg_9_1 = var_0_1(arg_9_1)
	arg_9_2 = var_0_1(arg_9_2)
	self.closedSet = {}
	self.gScore = {}
	self.gScore[arg_9_1] = 0
	self.fScore = {}
	self.fScore[arg_9_1] = 0

	if self._estimateCostFunc then
		self.fScore[arg_9_1] = self._estimateCostFunc(var_0_2(arg_9_1), var_0_2(arg_9_2))
	end

	self.cameFrom = {}

	local var_9_0 = BinaryHeap.new(self.fScore)

	var_9_0:push(arg_9_1)

	while var_9_0:size() > 0 do
		local var_9_1 = var_9_0:pop()

		if var_9_1 == arg_9_2 then
			return self:_reconstrunctPath(self.cameFrom, var_9_1)
		end

		self.closedSet[var_9_1] = true

		local var_9_2 = self._calcNeighborFunc(var_0_2(var_9_1), var_0_2(arg_9_1), var_0_2(arg_9_2))

		if var_9_2 and next(var_9_2) then
			for iter_9_0, iter_9_1 in ipairs(var_9_2) do
				iter_9_1 = var_0_1(iter_9_1)

				if not self.closedSet[iter_9_1] then
					local var_9_3
					local var_9_4 = self._calcDistFunc(var_0_2(var_9_1), var_0_2(iter_9_1))

					if self.gScore[var_9_1] and var_9_4 then
						var_9_3 = self.gScore[var_9_1] + var_9_4
					end

					if var_9_3 then
						if not self.gScore[iter_9_1] or var_9_3 < self.gScore[iter_9_1] then
							self.cameFrom[iter_9_1] = var_9_1
							self.gScore[iter_9_1] = var_9_3

							if self._estimateCostFunc then
								local var_9_5 = self._estimateCostFunc(var_0_2(iter_9_1), var_0_2(arg_9_2))

								self.fScore[iter_9_1] = self.gScore[iter_9_1] and var_9_5 and self.gScore[iter_9_1] + var_9_5 or nil
							end

							if not self.gScore[iter_9_1] then
								var_9_0:push(iter_9_1)
							else
								var_9_0:rescoreElement(iter_9_1)
							end
						end
					end
				end
			end
		else
			-- block empty
		end
	end

	return nil
end

function AStar:_reconstrunctPath(arg_10_1, arg_10_2)
	local var_10_0 = {
		var_0_2(arg_10_2)
	}

	while arg_10_1[arg_10_2] do
		arg_10_2 = arg_10_1[arg_10_2]

		table.insert(var_10_0, 1, var_0_2(arg_10_2))
	end

	return var_10_0
end

function AStar:getBlockPath(arg_11_1, arg_11_2)
	assert(self._calcBlockFunc, "calcNeighbor function must be no nil")
	assert(self._calcDistFunc, "calcDist function must be no nil")

	arg_11_1 = var_0_1(arg_11_1)
	arg_11_2 = var_0_1(arg_11_2)
	self.closedSet = {}
	self.openSet = {}
	self.openSet[arg_11_1] = true
	self.cameFrom = {}
	self.gScore = {}
	self.gScore[arg_11_1] = 0
	self.fScore = {}
	self.fScore[arg_11_1] = 0

	if self._estimateCostFunc then
		self.fScore[arg_11_1] = self._estimateCostFunc(var_0_2(arg_11_1), var_0_2(arg_11_2))
	end

	while next(self.openSet) do
		local var_11_0

		if self._estimateCostFunc then
			for iter_11_0, iter_11_1 in pairs(self.openSet) do
				if var_11_0 == nil then
					var_11_0 = iter_11_0
				elseif not self.fScore[var_11_0] or self.fScore[iter_11_0] and self.fScore[iter_11_0] < self.fScore[var_11_0] then
					var_11_0 = iter_11_0
				end
			end
		else
			var_11_0 = next(self.openSet)
		end

		if var_11_0 == arg_11_2 then
			return self:_reconstrunctPath(self.cameFrom, var_11_0)
		end

		self.openSet[var_11_0] = nil
		self.closedSet[var_11_0] = true

		local var_11_1 = self._calcBlockFunc(var_0_2(var_11_0), var_0_2(arg_11_1), var_0_2(arg_11_2))

		if var_11_1 and next(var_11_1) then
			for iter_11_2, iter_11_3 in ipairs(var_11_1) do
				iter_11_3 = var_0_1(iter_11_3)

				if not self.closedSet[iter_11_3] then
					local var_11_2
					local var_11_3 = self._calcDistFunc(var_0_2(var_11_0), var_0_2(iter_11_3))

					if self.gScore[var_11_0] and var_11_3 then
						var_11_2 = self.gScore[var_11_0] + var_11_3
					end

					self.openSet[iter_11_3] = self.openSet[iter_11_3] or true

					if var_11_2 and (not self.gScore[iter_11_3] or var_11_2 < self.gScore[iter_11_3]) then
						self.cameFrom[iter_11_3] = var_11_0
						self.gScore[iter_11_3] = var_11_2

						if self._estimateCostFunc then
							local var_11_4 = self._estimateCostFunc(var_0_2(iter_11_3), var_0_2(arg_11_2))

							self.fScore[iter_11_3] = self.gScore[iter_11_3] and var_11_4 and self.gScore[iter_11_3] + var_11_4 or nil
						end
					end
				end
			end
		else
			-- block empty
		end
	end
end

return AStar
