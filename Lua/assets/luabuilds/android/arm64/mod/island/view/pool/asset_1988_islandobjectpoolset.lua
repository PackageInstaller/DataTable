local IslandObjectPoolSet = class("IslandObjectPoolSet", import(".IslandPoolBase"))

function IslandObjectPoolSet:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.root = arg_1_1
	self.pools = {}
	self.capacity = arg_1_2
	self.poolCapacity = arg_1_3
	self.loadingCallbacks = {}
	self.dequeueingCounts = {}
	self.poolUseIndex = 0

	return
end

function IslandObjectPoolSet:SetInstanceDestroyPreProcessor(arg_2_1)
	self.instanceDestroyPreProcessor = arg_2_1

	return
end

function IslandObjectPoolSet:CreatePool(arg_3_1, arg_3_2)
	local var_3_0 = IslandObjectPool.New(self.root, arg_3_1, arg_3_2, self.poolCapacity)

	var_3_0:SetInstanceDestroyPreProcessor(self.instanceDestroyPreProcessor)

	return var_3_0
end

function IslandObjectPoolSet:GetPool(arg_4_1, arg_4_2)
	local var_4_0 = self.pools[arg_4_1]

	if not self.pools[arg_4_1] then
		var_4_0 = self:CreatePool(arg_4_1, arg_4_2)
		self.pools[arg_4_1] = var_4_0
	end

	self:MarkPoolUsed(var_4_0)

	return var_4_0
end

function IslandObjectPoolSet:RawGetPool(arg_5_1)
	if not self.pools then
		return nil
	end

	return self.pools[arg_5_1]
end

function IslandObjectPoolSet:MarkPoolUsed(arg_6_1)
	if not arg_6_1 then
		return
	end

	self.poolUseIndex = self.poolUseIndex + 1
	arg_6_1.lastUseIndex = self.poolUseIndex

	return
end

function IslandObjectPoolSet:IsPoolBusy(arg_7_1)
	if arg_7_1:IsLoading() then
		return true
	end

	if self.loadingCallbacks[arg_7_1.key] and #self.loadingCallbacks[arg_7_1.key] > 0 then
		return true
	end

	return self.dequeueingCounts[arg_7_1.key] and self.dequeueingCounts[arg_7_1.key] > 0
end

function IslandObjectPoolSet:BeginDequeue(arg_8_1, arg_8_2)
	if arg_8_2 <= 0 then
		return
	end

	self.dequeueingCounts[arg_8_1.key] = (self.dequeueingCounts[arg_8_1.key] or 0) + arg_8_2

	return
end

function IslandObjectPoolSet:EndDequeue(arg_9_1)
	if not self.dequeueingCounts[arg_9_1.key] then
		return
	end

	self.dequeueingCounts[arg_9_1.key] = self.dequeueingCounts[arg_9_1.key] - 1

	if self.dequeueingCounts[arg_9_1.key] <= 0 then
		self.dequeueingCounts[arg_9_1.key] = nil
	end

	return
end

function IslandObjectPoolSet:GetObject(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = self:GetPool(arg_10_1, arg_10_2)

	self.loadingCallbacks[var_10_0.key] = self.loadingCallbacks[var_10_0.key] or {}

	table.insert(self.loadingCallbacks[var_10_0.key], arg_10_3)

	if var_10_0:IsLoading() then
		return
	end

	local var_10_1 = {}

	if not var_10_0:Isloaded() then
		table.insert(var_10_1, function(arg_11_0)
			var_10_0:Load(arg_11_0)

			return
		end)
	end

	seriesAsync(var_10_1, function()
		self:CheckOverFlow(var_10_0)

		local var_12_0 = {}
		local var_12_1 = Clone(self.loadingCallbacks[var_10_0.key])

		self.loadingCallbacks[var_10_0.key] = {}

		self:BeginDequeue(var_10_0, #var_12_1)

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			table.insert(var_12_0, function(arg_13_0)
				var_10_0:DequeueAsyn(function(arg_14_0)
					iter_12_1(arg_14_0)
					self:EndDequeue(var_10_0)
					arg_13_0()

					return
				end)

				return
			end)
		end

		parallelAsync(var_12_0, function()
			self:CheckOverFlow(var_10_0)

			return
		end)

		return
	end)

	return
end

function IslandObjectPoolSet:ReturnObject(arg_16_1, arg_16_2)
	local var_16_0 = self:RawGetPool(arg_16_1)

	if not var_16_0 then
		existCall(self.instanceDestroyPreProcessor, arg_16_2)
		Object.Destroy(arg_16_2)

		return
	end

	var_16_0:Enqueue(arg_16_2)
	self:CheckOverFlow()

	return
end

function IslandObjectPoolSet:CheckOverFlow(arg_17_1)
	if not self.pools or not self.capacity then
		return
	end

	local var_17_0 = table.getCount(self.pools)

	if var_17_0 > self.capacity then
		self:DeleteOverflowPools(var_17_0 - self.capacity, arg_17_1)
	end

	return
end

function IslandObjectPoolSet:DeleteOverflowPools(arg_18_1, arg_18_2)
	if arg_18_1 <= 0 then
		return
	end

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(self.pools) do
		if iter_18_1 ~= arg_18_2 and iter_18_1:CanDelete() and not self:IsPoolBusy(iter_18_1) then
			local var_18_2 = {
				key = iter_18_0,
				pool = iter_18_1
			}

			var_18_2.index = iter_18_1.lastUseIndex or 0

			table.insert(var_18_0, var_18_2)
		end
	end

	if #var_18_0 <= 0 then
		return
	end

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		if arg_19_0.index == arg_19_1.index then
			return tostring(arg_19_0.key) < tostring(arg_19_1.key)
		end

		return arg_19_0.index < arg_19_1.index
	end)

	for iter_18_2 = 1, math.min(arg_18_1, #var_18_0) do
		if self.pools[var_18_0[iter_18_2].key] and self.pools[var_18_0[iter_18_2].key] == var_18_0[iter_18_2].pool and self.pools[var_18_0[iter_18_2].key] ~= arg_18_2 and self.pools[var_18_0[iter_18_2].key]:CanDelete() and not self:IsPoolBusy(self.pools[var_18_0[iter_18_2].key]) then
			self.pools[var_18_0[iter_18_2].key]:Dispose()

			self.pools[var_18_0[iter_18_2].key] = nil
			self.loadingCallbacks[var_18_0[iter_18_2].key] = nil
			self.dequeueingCounts[var_18_0[iter_18_2].key] = nil
		end
	end

	return
end

function IslandObjectPoolSet:Clear()
	if not self.pools then
		return
	end

	for iter_20_0, iter_20_1 in pairs(self.pools) do
		iter_20_1:Clear()
	end

	self.pools = {}
	self.loadingCallbacks = {}
	self.dequeueingCounts = {}

	return
end

function IslandObjectPoolSet:Dispose()
	if not self.pools then
		return
	end

	for iter_21_0, iter_21_1 in pairs(self.pools) do
		iter_21_1:Dispose()
	end

	self.pools = nil
	self.loadingCallbacks = {}
	self.dequeueingCounts = {}

	return
end

return IslandObjectPoolSet
