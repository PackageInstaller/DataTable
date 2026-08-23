local var_0_0 = math.huge
local KsAStar = class("KsAStar")

function KsAStar:ctor()
	self._allowDist = nil
end

function KsAStar:_resetData()
	self._quickDict = {}
	self._openDict = {}
	self._closeDict = {}
	self._trackDict = {}
	self._dictF = {}
	self._dictG = {}
	self._dictH = {}
end

function KsAStar:_quickUnified(arg_3_1)
	self._quickDict[arg_3_1.x * 10000 + arg_3_1.y] = arg_3_1

	return arg_3_1.x * 10000 + arg_3_1.y
end

function KsAStar:_quickCoord(arg_4_1)
	return self._quickDict[arg_4_1]
end

function KsAStar:_pushOpenList(arg_5_1, arg_5_2, arg_5_3)
	self._openDict[arg_5_1] = true

	if self._dictG[arg_5_1] == nil or arg_5_2 < self._dictG[arg_5_1] then
		self._dictG[arg_5_1] = arg_5_2
		self._dictF[arg_5_1] = arg_5_2 + self._dictH[arg_5_1]
		self._trackDict[arg_5_1] = arg_5_3
	end
end

function KsAStar:_popOpenList()
	local var_6_0

	for iter_6_0, iter_6_1 in pairs(self._openDict) do
		local var_6_1

		if var_0_0 > self._dictF[iter_6_0] then
			var_6_1 = self._dictF[iter_6_0]
			var_6_0 = iter_6_0
		end
	end

	if var_6_0 == nil then
		print("minUnify must exist!!!")

		return nil
	end

	self._openDict[var_6_0] = nil
	self._closeDict[var_6_0] = true

	return var_6_0
end

function KsAStar:_getTracePath(arg_7_1)
	local var_7_0 = {}

	table.insert(var_7_0, self:_quickCoord(arg_7_1))

	while self._trackDict[arg_7_1] do
		table.insert(var_7_0, 1, self:_quickCoord(self._trackDict[arg_7_1]))
	end

	return var_7_0
end

function KsAStar:_checkFinish(arg_8_1, arg_8_2)
	if self._allowDist == nil then
		return arg_8_1 == arg_8_2
	end

	local var_8_0 = self:_quickCoord(arg_8_1)
	local var_8_1 = self:_quickCoord(arg_8_2)

	return math.abs(var_8_0.x - var_8_1.x) + math.abs(var_8_0.y - var_8_1.y) <= self._allowDist
end

function KsAStar:_getNearestPath()
	local var_9_0 = var_0_0
	local var_9_1

	for iter_9_0, iter_9_1 in pairs(self._closeDict) do
		local var_9_2

		if self._dictH[iter_9_0] > 0 then
			if self._dictH[iter_9_0] < var_9_0 then
				var_9_0 = self._dictH[iter_9_0]
				var_9_1 = iter_9_0
			elseif self._dictH[iter_9_0] == var_9_0 and var_0_0 > self._dictF[iter_9_0] then
				var_9_2 = self._dictF[iter_9_0]
				var_9_1 = iter_9_0
			end
		end
	end

	if var_9_1 == nil then
		return nil
	end

	return self:_getTracePath(var_9_1)
end

local var_0_2 = {
	-1,
	0,
	1,
	0,
	0,
	-1,
	0,
	1,
	-1,
	-1,
	1,
	-1,
	-1,
	1,
	1,
	1
}

function KsAStar:_doCalcNeighbor(arg_10_1, arg_10_2)
	if arg_10_2.doCalcNeighborAStar then
		return arg_10_2:doCalcNeighborAStar(arg_10_1)
	end

	local var_10_0 = {}

	for iter_10_0 = 1, 16, 2 do
		local var_10_1 = cc.p(arg_10_1.x + var_0_2[iter_10_0], arg_10_1.y + var_0_2[iter_10_0 + 1])

		if arg_10_2:doCanMoveAStar(arg_10_1, var_10_1) then
			table.insert(var_10_0, var_10_1)
		end
	end

	return var_10_0
end

function KsAStar:_doCalcCost(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3.doCalcCostAStar then
		return arg_11_3:doCalcCostAStar(arg_11_1, arg_11_2)
	end

	local var_11_0 = arg_11_1.x - arg_11_2.x

	return math.sqrt(var_11_0 * var_11_0 + (arg_11_1.y - arg_11_2.y) * (arg_11_1.y - arg_11_2.y))
end

function KsAStar:_doCalcEstimate(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.doCalcEstimateAStar then
		return arg_12_3:doCalcEstimateAStar(arg_12_1, arg_12_2)
	end

	return math.abs(arg_12_1.x - arg_12_2.x) + math.abs(arg_12_1.y - arg_12_2.y)
end

function KsAStar:searchPath(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self:_resetData()

	local var_13_0 = self:_quickUnified(arg_13_1)
	local var_13_1 = self:_quickUnified(arg_13_2)

	self._dictH[var_13_0] = 0

	self:_pushOpenList(var_13_0, 0)

	local var_13_2 = 0

	while next(self._openDict) do
		if arg_13_4 ~= nil and var_13_2 > 50 then
			var_13_2 = 0

			arg_13_4:yield()
		end

		var_13_2 = var_13_2 + 1

		local var_13_3 = self:_popOpenList()

		if self:_checkFinish(var_13_3, var_13_1) then
			return self:_getTracePath(var_13_3)
		end

		local var_13_4 = self:_quickCoord(var_13_3)
		local var_13_5 = self:_doCalcNeighbor(var_13_4, arg_13_3)

		if var_13_5 == nil then
			print("neighborArr must exist!!!")

			return nil
		end

		for iter_13_0, iter_13_1 in ipairs(var_13_5) do
			local var_13_6 = self:_quickUnified(iter_13_1)

			if not self._closeDict[var_13_6] then
				local var_13_7

				if self._dictH[var_13_6] == nil then
					self._dictH[var_13_6] = self:_doCalcEstimate(iter_13_1, arg_13_2, arg_13_3)
					var_13_7 = var_13_6
				end

				self:_pushOpenList(var_13_6, self:_doCalcCost(var_13_4, iter_13_1, arg_13_3) + self._dictG[var_13_3], var_13_3)
			end
		end
	end

	return nil
end

function KsAStar:searchTalkPath(arg_14_1, arg_14_2, arg_14_3)
	self._allowDist = 1
	self._allowDist = nil

	return (self:searchPath(arg_14_1, arg_14_2, arg_14_3))
end

function KsAStar:searchNearPath(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = self:searchPath(arg_15_1, arg_15_2, arg_15_3, arg_15_4)

	if var_15_0 == nil then
		var_15_0 = self:_getNearestPath()
	end

	return var_15_0
end

local var_0_3 = {
	CreateAStar = function()
		return KsAStar.new()
	end
}

var_0_3.default = nil

function var_0_3.getDefault()
	if var_0_3.default == nil then
		var_0_3.default = var_0_3.CreateAStar()
	end

	return var_0_3.default
end

function var_0_3.searchPath(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_3 = arg_18_3 or var_0_3.getDefault()

	return arg_18_3:searchPath(arg_18_0, arg_18_1, arg_18_2)
end

function var_0_3.searchTalkPath(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_3 = arg_19_3 or var_0_3.getDefault()

	return (arg_19_3:searchTalkPath(arg_19_0, arg_19_1, arg_19_2))
end

function var_0_3.searchNearPath(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_3 = arg_20_3 or var_0_3.getDefault()

	return (arg_20_3:searchNearPath(arg_20_0, arg_20_1, arg_20_2))
end

return var_0_3
