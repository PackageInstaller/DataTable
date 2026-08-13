class = var_0_10000

local var_0_0 = "IslandObjectPoolSet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandPoolBase"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.root = arg_1_1
	arg_1_0.pools = {}
	arg_1_0.capacity = arg_1_2
	arg_1_0.poolCapacity = arg_1_3
	arg_1_0.loadingCallbacks = {}
	arg_1_0.dequeueingCounts = {}
	arg_1_0.poolUseIndex = 0

	return
end

function var_0_1.SetInstanceDestroyPreProcessor(arg_2_0, arg_2_1)
	arg_2_0.instanceDestroyPreProcessor = arg_2_1

	return
end

function var_0_1.CreatePool(arg_3_0, arg_3_1, arg_3_2)
	IslandObjectPool = var_1_10003

	local var_3_0 = var_1_10003.New(arg_3_0.root, arg_3_1, arg_3_2, arg_3_0.poolCapacity)

	var_3.SetInstanceDestroyPreProcessor(var_3_0, arg_3_0.instanceDestroyPreProcessor)

	return var_3
end

function var_0_1.GetPool(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0

	if not arg_4_0.pools[arg_4_1] then
		var_4_0 = arg_4_0:CreatePool(arg_4_1, arg_4_2)
		arg_4_0.pools[arg_4_1] = var_4_0
	end

	arg_4_0:MarkPoolUsed(var_4_0)

	return var_4_0
end

function var_0_1.RawGetPool(arg_5_0, arg_5_1)
	if not arg_5_0.pools then
		return nil
	end

	return arg_5_0.pools[arg_5_1]
end

function var_0_1.MarkPoolUsed(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	arg_6_0.poolUseIndex = arg_6_0.poolUseIndex + 1
	arg_6_1.lastUseIndex = arg_6_0.poolUseIndex

	return
end

function var_0_1.IsPoolBusy(arg_7_0, arg_7_1)
	if arg_7_1:IsLoading() then
		return true
	end

	if arg_7_0.loadingCallbacks[arg_7_1.key] and #arg_7_0.loadingCallbacks[arg_7_1.key] > 0 then
		return true
	end

	local var_7_0

	if arg_7_0.dequeueingCounts[arg_7_1.key] then
		var_7_0 = arg_7_0.dequeueingCounts[arg_7_1.key] > 0
	end

	return var_7_0
end

function var_0_1.BeginDequeue(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 <= 0 then
		return
	end

	local var_8_0 = arg_8_0.dequeueingCounts
	local var_8_1 = arg_8_1.key
	local var_8_2

	if not arg_8_0.dequeueingCounts[arg_8_1.key] then
		var_8_2 = 0
	end

	var_8_0[var_8_1] = var_8_2 + arg_8_2

	return
end

function var_0_1.EndDequeue(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.key

	if not arg_9_0.dequeueingCounts[var_9_0] then
		return
	end

	arg_9_0.dequeueingCounts[var_9_0] = arg_9_0.dequeueingCounts[var_9_0] - 1

	if arg_9_0.dequeueingCounts[var_9_0] <= 0 then
		arg_9_0.dequeueingCounts[var_9_0] = nil
	end

	return
end

function var_0_1.GetObject(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:GetPool(arg_10_1, arg_10_2)
	local var_10_1

	if not arg_10_0.loadingCallbacks[var_10_0.key] then
		var_10_1 = arg_10_0.loadingCallbacks
		var_10_1[var_10_0.key] = {}
	end

	table = var_10_1

	var_10_1.insert(arg_10_0.loadingCallbacks[var_10_0.key], arg_10_3)

	if var_10_0:IsLoading() then
		return
	end

	local var_10_2 = {}

	if not var_10_0:Isloaded() then
		table = var_6

		var_6.insert(var_10_2, function(arg_11_0)
			local var_11_0 = var_10_0

			var_1.Load(var_11_0, arg_11_0)

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_10_2, function()
		local var_12_0 = arg_10_0

		var_0.CheckOverFlow(var_12_0, var_10_0)

		local var_12_1 = {}

		Clone = var_2_10001

		local var_12_2 = var_2_10001(arg_10_0.loadingCallbacks[var_10_0.key])

		arg_10_0.loadingCallbacks[var_10_0.key] = {}

		local var_12_3 = arg_10_0

		var_2.BeginDequeue(var_12_3, var_10_0, #var_12_2)

		ipairs = var_2

		for iter_12_0, iter_12_1 in var_2(var_12_2) do
			table = var_2_10007

			var_2_10007.insert(var_12_1, function(arg_13_0)
				local var_13_0 = var_10_0

				var_1.DequeueAsyn(var_13_0, function(arg_14_0)
					iter_12_1(arg_14_0)

					local var_14_0 = arg_10_0

					var_1.EndDequeue(var_14_0, var_10_0)
					arg_13_0()

					return
				end)

				return
			end)
		end

		parallelAsync = var_2

		var_2(var_12_1, function()
			local var_15_0 = arg_10_0

			var_0.CheckOverFlow(var_15_0, var_10_0)

			return
		end)

		return
	end)

	return
end

function var_0_1.ReturnObject(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0:RawGetPool(arg_16_1) then
		existCall = var_1_10004

		var_1_10004(arg_16_0.instanceDestroyPreProcessor, arg_16_2)

		Object = var_1_10004

		var_1_10004.Destroy(arg_16_2)

		return
	end

	var_3:Enqueue(arg_16_2)
	arg_16_0:CheckOverFlow()

	return
end

function var_0_1.CheckOverFlow(arg_17_0, arg_17_1)
	if not arg_17_0.pools or not arg_17_0.capacity then
		return
	end

	table = var_2

	if var_2.getCount(arg_17_0.pools) > arg_17_0.capacity then
		arg_17_0:DeleteOverflowPools(var_2 - arg_17_0.capacity, arg_17_1)
	end

	return
end

function var_0_1.DeleteOverflowPools(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 <= 0 then
		return
	end

	local var_18_0 = {}

	pairs = var_1_10004

	for iter_18_0, iter_18_1 in var_1_10004(arg_18_0.pools) do
		if iter_18_1 ~= arg_18_2 and iter_18_1:CanDelete() and not arg_18_0:IsPoolBusy(iter_18_1) then
			table = var_9

			local var_18_1 = var_9.insert
			local var_18_2 = var_18_0
			local var_18_3 = {
				key = iter_18_0,
				pool = iter_18_1
			}
			local var_18_4

			if not iter_18_1.lastUseIndex then
				var_18_4 = 0
			end

			var_18_3.index = var_18_4

			var_18_1(var_18_2, var_18_3)
		end
	end

	if #var_18_0 <= 0 then
		return
	end

	table = var_4

	var_4.sort(var_18_0, function(arg_19_0, arg_19_1)
		if arg_19_0.index == arg_19_1.index then
			tostring = var_2

			local var_19_0 = var_2(arg_19_0.key)

			tostring = var_3

			return var_19_0 < var_3(arg_19_1.key)
		end

		return arg_19_0.index < arg_19_1.index
	end)

	math = var_4

	local var_18_5 = var_4.min(arg_18_1, #var_18_0)

	for iter_18_2 = 1, var_18_5 do
		local var_18_6 = var_18_0[iter_18_2].key

		if arg_18_0.pools[var_18_6] and var_10 == var_18_0[iter_18_2].pool and var_10 ~= arg_18_2 and var_10:CanDelete() and not arg_18_0:IsPoolBusy(var_10) then
			var_10:Dispose()

			arg_18_0.pools[var_18_6] = nil
			arg_18_0.loadingCallbacks[var_18_6] = nil
			arg_18_0.dequeueingCounts[var_18_6] = nil
		end
	end

	return
end

function var_0_1.Clear(arg_20_0)
	if not arg_20_0.pools then
		return
	end

	pairs = var_1

	for iter_20_0, iter_20_1 in var_1(arg_20_0.pools) do
		iter_20_1:Clear()
	end

	arg_20_0.pools = {}
	arg_20_0.loadingCallbacks = {}
	arg_20_0.dequeueingCounts = {}

	return
end

function var_0_1.Dispose(arg_21_0)
	if not arg_21_0.pools then
		return
	end

	pairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0.pools) do
		iter_21_1:Dispose()
	end

	arg_21_0.pools = nil
	arg_21_0.loadingCallbacks = {}
	arg_21_0.dequeueingCounts = {}

	return
end

return var_0_1
