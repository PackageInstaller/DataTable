local var_0_0 = class("IslandObjectPoolSet", import(".IslandPoolBase"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.root = arg_1_1
	arg_1_0.pools = {}
	arg_1_0.capacity = arg_1_2
	arg_1_0.poolCapacity = arg_1_3
	arg_1_0.loadingCallbacks = {}
	arg_1_0.dequeueingCounts = {}
	arg_1_0.poolUseIndex = 0

	return
end

function var_0_0.SetInstanceDestroyPreProcessor(arg_2_0, arg_2_1)
	arg_2_0.instanceDestroyPreProcessor = arg_2_1

	return
end

function var_0_0.CreatePool(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = IslandObjectPool.New(arg_3_0.root, arg_3_1, arg_3_2, arg_3_0.poolCapacity)

	var_3_0:SetInstanceDestroyPreProcessor(arg_3_0.instanceDestroyPreProcessor)

	return var_3_0
end

function var_0_0.GetPool(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.pools[arg_4_1]

	if not arg_4_0.pools[arg_4_1] then
		var_4_0 = arg_4_0:CreatePool(arg_4_1, arg_4_2)
		arg_4_0.pools[arg_4_1] = var_4_0
	end

	arg_4_0:MarkPoolUsed(var_4_0)

	return var_4_0
end

function var_0_0.RawGetPool(arg_5_0, arg_5_1)
	if not arg_5_0.pools then
		return nil
	end

	return arg_5_0.pools[arg_5_1]
end

function var_0_0.MarkPoolUsed(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	arg_6_0.poolUseIndex = arg_6_0.poolUseIndex + 1
	arg_6_1.lastUseIndex = arg_6_0.poolUseIndex

	return
end

function var_0_0.IsPoolBusy(arg_7_0, arg_7_1)
	if arg_7_1:IsLoading() then
		return true
	end

	if arg_7_0.loadingCallbacks[arg_7_1.key] and #arg_7_0.loadingCallbacks[arg_7_1.key] > 0 then
		return true
	end

	return arg_7_0.dequeueingCounts[arg_7_1.key] and arg_7_0.dequeueingCounts[arg_7_1.key] > 0
end

function var_0_0.BeginDequeue(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 <= 0 then
		return
	end

	local var_8_0 = arg_8_0.dequeueingCounts
	local var_8_1 = arg_8_0.dequeueingCounts[arg_8_1.key] or 0

	var_8_0[arg_8_1.key] = var_8_1 + arg_8_2

	return
end

function var_0_0.EndDequeue(arg_9_0, arg_9_1)
	if not arg_9_0.dequeueingCounts[arg_9_1.key] then
		return
	end

	arg_9_0.dequeueingCounts[arg_9_1.key] = arg_9_0.dequeueingCounts[arg_9_1.key] - 1

	if arg_9_0.dequeueingCounts[arg_9_1.key] <= 0 then
		arg_9_0.dequeueingCounts[arg_9_1.key] = nil
	end

	return
end

function var_0_0.GetObject(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:GetPool(arg_10_1, arg_10_2)

	arg_10_0.loadingCallbacks[var_10_0.key] = arg_10_0.loadingCallbacks[var_10_0.key] or {}

	table.insert(arg_10_0.loadingCallbacks[var_10_0.key], arg_10_3)

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
		arg_10_0:CheckOverFlow(var_10_0)

		local var_12_0 = Clone(arg_10_0.loadingCallbacks[var_10_0.key])

		arg_10_0.loadingCallbacks[var_10_0.key] = {}

		arg_10_0:BeginDequeue(var_10_0, #var_12_0)

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			table.insert({}, function(arg_13_0)
				var_10_0:DequeueAsyn(function(arg_14_0)
					iter_12_1(arg_14_0)
					arg_10_0:EndDequeue(var_10_0)
					arg_13_0()

					return
				end)

				return
			end)
		end

		parallelAsync({}, function()
			arg_10_0:CheckOverFlow(var_10_0)

			return
		end)

		return
	end)

	return
end

function var_0_0.ReturnObject(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:RawGetPool(arg_16_1)

	if not var_16_0 then
		existCall(arg_16_0.instanceDestroyPreProcessor, arg_16_2)
		Object.Destroy(arg_16_2)

		return
	end

	var_16_0:Enqueue(arg_16_2)
	arg_16_0:CheckOverFlow()

	return
end

function var_0_0.CheckOverFlow(arg_17_0, arg_17_1)
	if not arg_17_0.pools or not arg_17_0.capacity then
		return
	end

	local var_17_0 = table.getCount(arg_17_0.pools)

	if var_17_0 > arg_17_0.capacity then
		arg_17_0:DeleteOverflowPools(var_17_0 - arg_17_0.capacity, arg_17_1)
	end

	return
end

function var_0_0.DeleteOverflowPools(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 <= 0 then
		return
	end

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0.pools) do
		if iter_18_1 ~= arg_18_2 and iter_18_1:CanDelete() and not arg_18_0:IsPoolBusy(iter_18_1) then
			({
				key = iter_18_0,
				pool = iter_18_1
			}).index = iter_18_1.lastUseIndex or 0

			table.insert(var_18_0, {
				key = iter_18_0,
				pool = iter_18_1
			})
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
		if arg_18_0.pools[var_18_0[iter_18_2].key] and arg_18_0.pools[var_18_0[iter_18_2].key] == var_18_0[iter_18_2].pool and arg_18_0.pools[var_18_0[iter_18_2].key] ~= arg_18_2 and arg_18_0.pools[var_18_0[iter_18_2].key]:CanDelete() and not arg_18_0:IsPoolBusy(arg_18_0.pools[var_18_0[iter_18_2].key]) then
			arg_18_0.pools[var_18_0[iter_18_2].key]:Dispose()

			arg_18_0.pools[var_18_0[iter_18_2].key] = nil
			arg_18_0.loadingCallbacks[var_18_0[iter_18_2].key] = nil
			arg_18_0.dequeueingCounts[var_18_0[iter_18_2].key] = nil
		end
	end

	return
end

function var_0_0.Clear(arg_20_0)
	if not arg_20_0.pools then
		return
	end

	for iter_20_0, iter_20_1 in pairs(arg_20_0.pools) do
		iter_20_1:Clear()
	end

	arg_20_0.pools = {}
	arg_20_0.loadingCallbacks = {}
	arg_20_0.dequeueingCounts = {}

	return
end

function var_0_0.Dispose(arg_21_0)
	if not arg_21_0.pools then
		return
	end

	for iter_21_0, iter_21_1 in pairs(arg_21_0.pools) do
		iter_21_1:Dispose()
	end

	arg_21_0.pools = nil
	arg_21_0.loadingCallbacks = {}
	arg_21_0.dequeueingCounts = {}

	return
end

return var_0_0
