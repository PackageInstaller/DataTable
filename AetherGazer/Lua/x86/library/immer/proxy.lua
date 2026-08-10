local var_0_0 = require("library/immer/utils")
local var_0_1 = {}
local var_0_2 = {}

function var_0_2.produceImpl(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1

	var_0_1 = {}

	local var_1_1 = var_0_2.createProxy(nil, arg_1_0)
	local var_1_2 = arg_1_1(var_1_1)

	var_0_0.each(var_0_1, function(arg_2_0, arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.proxy) do
			if iter_2_0 ~= var_0_0.PROXY_STATE then
				error("Do not use table.insert or rawset directly on draft properties.")
			end
		end

		arg_2_1.finalizing = true
	end)

	local var_1_3

	if var_1_2 ~= nil and var_1_2 ~= var_1_1 then
		if var_1_1[var_0_0.PROXY_STATE].modified then
			error("An immer producer returned a new value *and* modified its draft. Either return a new value *or* modify the draft.")
		end

		var_1_3 = var_0_2.finalize(var_1_2)
	else
		var_0_2.markChangedSweep()

		var_1_3 = var_0_2.finalize(var_1_1)
	end

	var_0_0.each(var_0_1, function(arg_3_0, arg_3_1)
		arg_3_1.finished = true
	end)

	var_0_1 = var_1_0

	return var_1_3
end

function var_0_2.createProxy(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = var_0_2.createState(arg_4_0, var_4_0, arg_4_1)

	var_4_0[var_0_0.PROXY_STATE] = var_4_1

	setmetatable(var_4_0, {
		__index = function(arg_5_0, arg_5_1)
			return var_0_2.get(var_4_1, arg_5_1)
		end,
		__newindex = function(arg_6_0, arg_6_1, arg_6_2)
			var_0_2.set(var_4_1, arg_6_1, arg_6_2)
		end
	})
	table.insert(var_0_1, var_4_1)

	return var_4_0
end

function var_0_2.createState(arg_7_0, arg_7_1, arg_7_2)
	return {
		finalized = false,
		finished = false,
		hasCopy = false,
		modified = false,
		finalizing = false,
		assigned = {},
		parent = arg_7_0,
		base = arg_7_2,
		proxy = arg_7_1
	}
end

function var_0_2.get(arg_8_0, arg_8_1)
	var_0_2.assertUnfinished(arg_8_0)

	local var_8_0 = var_0_2.source(arg_8_0)[arg_8_1]

	if not arg_8_0.finalizing and var_8_0 == arg_8_0.base[arg_8_1] and var_0_0.isProxyable(var_8_0) then
		var_0_2.prepareCopy(arg_8_0)

		arg_8_0.copy[arg_8_1] = var_0_2.createProxy(arg_8_0, var_8_0)

		return arg_8_0.copy[arg_8_1]
	end

	return var_8_0
end

function var_0_2.set(arg_9_0, arg_9_1, arg_9_2)
	var_0_2.assertUnfinished(arg_9_0)

	arg_9_0.assigned[arg_9_1] = true

	if not arg_9_0.modified then
		if var_0_2.source(arg_9_0)[arg_9_1] == arg_9_2 then
			return
		end

		var_0_2.markChanged(arg_9_0)
		var_0_2.prepareCopy(arg_9_0)
	end

	arg_9_0.copy[arg_9_1] = arg_9_2
end

function var_0_2.source(arg_10_0)
	if arg_10_0.hasCopy then
		return arg_10_0.copy
	else
		return arg_10_0.base
	end
end

function var_0_2.assertUnfinished(arg_11_0)
	if arg_11_0.finished then
		error("Cannot use a proxy that has been revoke. Did you pass an object from inside an immer function to an async process?")
	end
end

function var_0_2.assertProxy(arg_12_0)
	if not var_0_0.isProxy(arg_12_0) then
		error("base should be a proxy object")
	end
end

function var_0_2.prepareModified(arg_13_0)
	if not arg_13_0.modified then
		var_0_2.markChanged(arg_13_0)
		var_0_2.prepareCopy(arg_13_0)
	end
end

function var_0_2.prepareCopy(arg_14_0)
	if arg_14_0.hasCopy then
		return
	end

	arg_14_0.hasCopy = true
	arg_14_0.copy = var_0_0.shallowCopy(arg_14_0.base)
end

function var_0_2.insert(arg_15_0, ...)
	if var_0_0.isProxy(arg_15_0) then
		local var_15_0 = arg_15_0[var_0_0.PROXY_STATE]

		var_0_2.prepareModified(var_15_0)

		return table.insert(var_15_0.copy, ...)
	else
		return table.insert(arg_15_0, ...)
	end
end

function var_0_2.remove(arg_16_0, ...)
	if var_0_0.isProxy(arg_16_0) then
		local var_16_0 = arg_16_0[var_0_0.PROXY_STATE]

		var_0_2.prepareModified(var_16_0)

		return table.remove(var_16_0.copy, ...)
	else
		return table.remove(arg_16_0, ...)
	end
end

function var_0_2.getn(arg_17_0, ...)
	if var_0_0.isProxy(arg_17_0) then
		local var_17_0 = arg_17_0[var_0_0.PROXY_STATE]

		return table.getn(var_0_2.source(var_17_0), ...)
	else
		return table.getn(arg_17_0, ...)
	end
end

function var_0_2.ipairs(arg_18_0)
	if var_0_0.isProxy(arg_18_0) then
		local var_18_0 = arg_18_0[var_0_0.PROXY_STATE]

		do return function(arg_19_0, arg_19_1)
			arg_19_1 = arg_19_1 + 1

			if arg_19_0[arg_19_1] then
				return arg_19_1, var_0_2.get(var_18_0, arg_19_1)
			end
		end, var_0_2.source(var_18_0), 0 end
		return
	end

	return ipairs(arg_18_0)
end

function var_0_2.pairs(arg_20_0)
	if var_0_0.isProxy(arg_20_0) then
		local var_20_0 = arg_20_0[var_0_0.PROXY_STATE]

		do return function(arg_21_0, arg_21_1)
			local var_21_0, var_21_1 = next(arg_21_0, arg_21_1)

			if var_21_1 then
				return var_21_0, var_0_2.get(var_20_0, var_21_0)
			end
		end, var_0_2.source(var_20_0), nil end
		return
	end

	return pairs(arg_20_0)
end

function var_0_2.markChanged(arg_22_0)
	if not arg_22_0.modified then
		arg_22_0.modified = true

		if arg_22_0.parent then
			var_0_2.markChanged(arg_22_0.parent)
		end
	end
end

function var_0_2.markChangedSweep()
	for iter_23_0 = #var_0_1, 1, -1 do
		local var_23_0 = var_0_1[iter_23_0]

		if not var_23_0.modified and var_0_2.hasTableChanges(var_23_0) then
			var_0_2.markChanged(var_23_0)
		end
	end
end

function var_0_2.hasTableChanges(arg_24_0)
	local var_24_0 = arg_24_0.base
	local var_24_1 = var_0_2.source(arg_24_0)
	local var_24_2 = 0
	local var_24_3 = 0

	for iter_24_0, iter_24_1 in pairs(var_24_1) do
		if var_24_0[iter_24_0] == nil then
			return true
		end

		var_24_3 = var_24_3 + 1
	end

	for iter_24_2, iter_24_3 in pairs(var_24_0) do
		var_24_2 = var_24_2 + 1
	end

	return var_24_2 ~= var_24_3
end

function var_0_2.finalize(arg_25_0)
	if var_0_0.isProxy(arg_25_0) then
		local var_25_0 = arg_25_0[var_0_0.PROXY_STATE]

		if var_25_0.modified then
			if var_25_0.finalized then
				return var_25_0.copy
			end

			var_25_0.finalized = true

			return var_0_2.finalizeTable(var_25_0.copy, var_25_0)
		else
			return var_25_0.base
		end
	end

	var_0_2.finalizeNonProxiedTable(arg_25_0)

	return arg_25_0
end

function var_0_2.finalizeTable(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.base

	var_0_0.each(arg_26_0, function(arg_27_0, arg_27_1)
		if arg_27_1 ~= var_26_0[arg_27_0] then
			arg_26_0[arg_27_0] = var_0_2.finalize(arg_27_1)
		end
	end)

	return arg_26_0
end

function var_0_2.finalizeNonProxiedTable(arg_28_0)
	if not var_0_0.isProxyable(arg_28_0) then
		return
	end

	var_0_0.each(arg_28_0, function(arg_29_0, arg_29_1)
		if var_0_0.isProxy(arg_29_1) then
			arg_28_0[arg_29_0] = var_0_2.finalize(arg_29_1)
		else
			var_0_2.finalizeNonProxiedTable(arg_29_1)
		end
	end)
end

return var_0_2
