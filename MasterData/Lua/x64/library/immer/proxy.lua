local utils = require("library/immer/utils")
local var_0_1 = {}
local var_0_2 = {}

function var_0_2.produceImpl(arg_1_0, arg_1_1)
	var_0_1 = {}

	local var_1_0 = var_0_2.createProxy(nil, arg_1_0)
	local var_1_1 = arg_1_1(var_1_0)

	utils.each(var_0_1, function(arg_2_0, arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.proxy) do
			if iter_2_0 ~= utils.PROXY_STATE then
				error("Do not use table.insert or rawset directly on draft properties.")
			end
		end

		arg_2_1.finalizing = true
	end)

	local var_1_2

	if var_1_1 ~= nil and var_1_1 ~= var_1_0 then
		if var_1_0[utils.PROXY_STATE].modified then
			error("An immer producer returned a new value *and* modified its draft. Either return a new value *or* modify the draft.")
		end

		var_1_2 = var_0_2.finalize(var_1_1)
	else
		var_0_2.markChangedSweep()

		var_1_2 = var_0_2.finalize(var_1_0)
	end

	utils.each(var_0_1, function(arg_3_0, arg_3_1)
		arg_3_1.finished = true
	end)

	var_0_1 = var_0_1

	return var_1_2
end

function var_0_2.createProxy(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = var_0_2.createState(arg_4_0, var_4_0, arg_4_1)

	var_4_0[utils.PROXY_STATE] = var_4_1

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

function var_0_2:get(arg_8_1)
	var_0_2.assertUnfinished(self)

	local var_8_0 = var_0_2.source(self)[arg_8_1]

	if not self.finalizing and var_8_0 == self.base[arg_8_1] and utils.isProxyable(var_8_0) then
		var_0_2.prepareCopy(self)

		self.copy[arg_8_1] = var_0_2.createProxy(self, var_8_0)

		return self.copy[arg_8_1]
	end

	return var_8_0
end

function var_0_2:set(arg_9_1, arg_9_2)
	var_0_2.assertUnfinished(self)

	self.assigned[arg_9_1] = true

	if not self.modified then
		if var_0_2.source(self)[arg_9_1] == arg_9_2 then
			return
		end

		var_0_2.markChanged(self)
		var_0_2.prepareCopy(self)
	end

	self.copy[arg_9_1] = arg_9_2
end

function var_0_2:source()
	if self.hasCopy then
		return self.copy
	else
		return self.base
	end
end

function var_0_2:assertUnfinished()
	if self.finished then
		error("Cannot use a proxy that has been revoke. Did you pass an object from inside an immer function to an async process?")
	end
end

function var_0_2.assertProxy(arg_12_0)
	if not utils.isProxy(arg_12_0) then
		error("base should be a proxy object")
	end
end

function var_0_2:prepareModified()
	if not self.modified then
		var_0_2.markChanged(self)
		var_0_2.prepareCopy(self)
	end
end

function var_0_2:prepareCopy()
	if self.hasCopy then
		return
	end

	self.hasCopy = true
	self.copy = utils.shallowCopy(self.base)
end

function var_0_2:insert(...)
	if utils.isProxy(self) then
		var_0_2.prepareModified(self[utils.PROXY_STATE])

		return table.insert(self[utils.PROXY_STATE].copy, ...)
	else
		return table.insert(self, ...)
	end
end

function var_0_2:remove(...)
	if utils.isProxy(self) then
		var_0_2.prepareModified(self[utils.PROXY_STATE])

		return table.remove(self[utils.PROXY_STATE].copy, ...)
	else
		return table.remove(self, ...)
	end
end

function var_0_2:getn(...)
	if utils.isProxy(self) then
		return table.getn(var_0_2.source(self[utils.PROXY_STATE]), ...)
	else
		return table.getn(self, ...)
	end
end

function var_0_2:ipairs()
	if utils.isProxy(self) then
		local var_18_0 = self[utils.PROXY_STATE]

		do return function(arg_19_0, arg_19_1)
			arg_19_1 = arg_19_1 + 1

			if arg_19_0[arg_19_1] then
				return arg_19_1, var_0_2.get(var_18_0, arg_19_1)
			end
		end, var_0_2.source(self[utils.PROXY_STATE]), 0 end
		return
	end

	return ipairs(self)
end

function var_0_2:pairs()
	if utils.isProxy(self) then
		local var_20_0 = self[utils.PROXY_STATE]

		do return function(arg_21_0, arg_21_1)
			local var_21_0, var_21_1 = next(arg_21_0, arg_21_1)

			if var_21_1 then
				return var_21_0, var_0_2.get(var_20_0, var_21_0)
			end
		end, var_0_2.source(self[utils.PROXY_STATE]), nil end
		return
	end

	return pairs(self)
end

function var_0_2:markChanged()
	if not self.modified then
		self.modified = true

		if self.parent then
			var_0_2.markChanged(self.parent)
		end
	end
end

function var_0_2.markChangedSweep()
	for iter_23_0 = #var_0_1, 1, -1 do
		if not var_0_1[iter_23_0].modified and var_0_2.hasTableChanges(var_0_1[iter_23_0]) then
			var_0_2.markChanged(var_0_1[iter_23_0])
		end
	end
end

function var_0_2:hasTableChanges()
	local var_24_0 = 0
	local var_24_1 = 0

	for iter_24_0, iter_24_1 in pairs((var_0_2.source(self))) do
		if self.base[iter_24_0] == nil then
			return true
		end

		var_24_1 = var_24_1 + 1
	end

	for iter_24_2, iter_24_3 in pairs(self.base) do
		var_24_0 = var_24_0 + 1
	end

	return var_24_0 ~= var_24_1
end

function var_0_2:finalize()
	if utils.isProxy(self) then
		if self[utils.PROXY_STATE].modified then
			if self[utils.PROXY_STATE].finalized then
				return self[utils.PROXY_STATE].copy
			end

			self[utils.PROXY_STATE].finalized = true

			return var_0_2.finalizeTable(self[utils.PROXY_STATE].copy, self[utils.PROXY_STATE])
		else
			return self[utils.PROXY_STATE].base
		end
	end

	var_0_2.finalizeNonProxiedTable(self)

	return self
end

function var_0_2.finalizeTable(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.base

	utils.each(arg_26_0, function(arg_27_0, arg_27_1)
		if arg_27_1 ~= var_26_0[arg_27_0] then
			arg_26_0[arg_27_0] = var_0_2.finalize(arg_27_1)
		end
	end)

	return arg_26_0
end

function var_0_2.finalizeNonProxiedTable(arg_28_0)
	if not utils.isProxyable(arg_28_0) then
		return
	end

	utils.each(arg_28_0, function(arg_29_0, arg_29_1)
		if utils.isProxy(arg_29_1) then
			arg_28_0[arg_29_0] = var_0_2.finalize(arg_29_1)
		else
			var_0_2.finalizeNonProxiedTable(arg_29_1)
		end
	end)
end

return var_0_2
