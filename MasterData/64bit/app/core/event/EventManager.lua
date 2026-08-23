local EventManager = class("EventManager")
local var_0_1 = table
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_5 = ipairs
local var_0_6 = type
local var_0_7 = cc.Director:getInstance():getScheduler()

function EventManager:ctor()
	self._observerList = {}
	self._asyncEvent = {}
	self._eventPair = {}
	self._removeEventCache = {}
	self._addEventCache = {}
	self._eventDispatchState = {}
	self._eventSortDirty = {}
	self._updateEntryID = var_0_7:scheduleScriptFunc(function()
		if #self._asyncEvent == 0 then
			return
		end

		self._asyncEvent = {}

		for iter_2_0, iter_2_1 in var_0_5(self._asyncEvent) do
			self:_doDispatchEvent(iter_2_1.id, unpack(iter_2_1.args))
		end
	end, 0, false)
end

function EventManager:clearEvent()
	self._observerList = {}
	self._asyncEvent = {}
	self._eventPair = {}
	self._removeEventCache = {}
	self._addEventCache = {}
	self._eventDispatchState = {}
	self._eventSortDirty = {}
end

function EventManager:addEventListener(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	assert(var_0_6(arg_4_1) == "string", "Invalid event: " .. tostring(arg_4_1))
	assert(var_0_6(arg_4_2) == "function", "Invalid fun: " .. tostring(arg_4_2))
	assert(arg_4_3, "Invalid target: " .. tostring(arg_4_3))

	if not self:_findListener(arg_4_3, arg_4_1) then
		self:_addListener(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	end
end

function EventManager:removeListenerWithTarget(arg_5_1)
	assert(arg_5_1, "Invalid target: " .. tostring(arg_5_1))

	if self:_findListener(arg_5_1) then
		self:_removeListener(arg_5_1)
	end
end

function EventManager:removeListenerWithEvent(arg_6_1, arg_6_2)
	assert(var_0_6(arg_6_2) == "string", "Invalid event: " .. tostring(arg_6_2))
	assert(arg_6_1, "Invalid target: " .. tostring(arg_6_1))

	if self:_findListener(arg_6_1, arg_6_2) then
		self:_removeListener(arg_6_1, arg_6_2)
	end
end

function EventManager:dispatchEvent(arg_7_1, arg_7_2)
	assert(var_0_6(arg_7_1) == "string", "Invalid event: " .. tostring(arg_7_1))

	if not arg_7_2 then
		self:_doDispatchEvent(arg_7_1, ...)
	else
		self:_addAsyncEvent(arg_7_1, ...)
	end
end

function EventManager:_findListener(arg_8_1, arg_8_2)
	if not arg_8_2 then
		return self._eventPair[arg_8_1] ~= nil
	end

	if self._observerList[arg_8_2] then
		for iter_8_0, iter_8_1 in var_0_5(self._observerList[arg_8_2]) do
			if iter_8_1[1] == arg_8_1 then
				return true
			end
		end
	end

	if self._addEventCache[arg_8_2] then
		for iter_8_2, iter_8_3 in var_0_5(self._addEventCache[arg_8_2]) do
			if iter_8_3[1] == arg_8_1 then
				return true
			end
		end
	end

	return false
end

function EventManager:_addListener(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = self._observerList[arg_9_1]

	if not self._observerList[arg_9_1] then
		var_9_0 = {}
		self._observerList[arg_9_1] = var_9_0
	end

	arg_9_4 = arg_9_4 or 0

	local var_9_1 = false

	if not self._eventDispatchState[arg_9_1] then
		for iter_9_0, iter_9_1 in var_0_5(var_9_0) do
			if arg_9_4 < iter_9_1[3] then
				var_9_1 = true

				var_0_2(var_9_0, iter_9_0, {
					arg_9_3,
					arg_9_2,
					arg_9_4
				})

				break
			end
		end
	else
		self._eventSortDirty[arg_9_1] = true
	end

	if not var_9_1 then
		if self._eventSortDirty[arg_9_1] then
			local var_9_2 = self._addEventCache[arg_9_1]

			if not self._addEventCache[arg_9_1] then
				var_9_2 = {}
				self._addEventCache[arg_9_1] = var_9_2
			end

			var_0_1.insert(var_9_2, {
				arg_9_3,
				arg_9_2,
				arg_9_4
			})
		else
			var_0_2(var_9_0, {
				arg_9_3,
				arg_9_2,
				arg_9_4
			})
		end
	end

	local var_9_3 = self._eventPair[arg_9_3]

	if not self._eventPair[arg_9_3] then
		var_9_3 = {}
		self._eventPair[arg_9_3] = var_9_3
	end

	var_0_2(var_9_3, arg_9_1)
end

function EventManager:_removeListener(arg_10_1, arg_10_2)
	if not arg_10_2 then
		if not self._eventPair[arg_10_1] then
			return
		end

		for iter_10_0, iter_10_1 in var_0_5(self._eventPair[arg_10_1]) do
			self:_removeListener(arg_10_1, iter_10_1)
		end

		self._eventPair[arg_10_1] = nil
	else
		local var_10_0 = self._observerList[arg_10_2]

		if self._observerList[arg_10_2] then
			if self._eventDispatchState[arg_10_2] then
				self:_addRemoveEventCache(arg_10_1, arg_10_2)

				return
			end

			for iter_10_2, iter_10_3 in var_0_5(var_10_0) do
				if iter_10_3[1] == arg_10_1 then
					var_0_3(var_10_0, iter_10_2)

					return
				end
			end
		end

		local var_10_1 = self._addEventCache[arg_10_2]

		if self._addEventCache[arg_10_2] then
			for iter_10_4, iter_10_5 in var_0_5(var_10_1) do
				if iter_10_5[1] == arg_10_1 then
					var_0_3(var_10_1, iter_10_4)

					return
				end
			end
		end
	end
end

function EventManager:_addRemoveEventCache(arg_11_1, arg_11_2)
	local var_11_0 = self._removeEventCache[arg_11_2]

	if not self._removeEventCache[arg_11_2] then
		var_11_0 = {}
		self._removeEventCache[arg_11_2] = var_11_0
	end

	var_0_2(var_11_0, arg_11_1)
end

function EventManager:_doRemoveEventCache(arg_12_1)
	if not self._removeEventCache[arg_12_1] then
		return
	end

	for iter_12_0, iter_12_1 in var_0_5(self._removeEventCache[arg_12_1]) do
		self:_removeListener(iter_12_1, arg_12_1)
	end

	self._removeEventCache[arg_12_1] = nil
end

function EventManager:_doDispatchEvent(arg_13_1)
	local var_13_0 = self._observerList[arg_13_1]

	if self._observerList[arg_13_1] == nil then
		return
	end

	self._eventDispatchState[arg_13_1] = true

	local var_13_1 = true
	local var_13_2
	local var_13_3 = DEVELOP_UTILS_SUPPORT and function(arg_14_0)
		return string.format("LUA ERROR: %s\n-----------------------------%s\n", tostring(arg_14_0), debug.traceback("", 2))
	end or function(arg_15_0)
		return tostring(arg_15_0)
	end

	for iter_13_0, iter_13_1 in var_0_5(var_13_0) do
		local var_13_4 = iter_13_1[1]
		local var_13_5 = iter_13_1[2]
		local var_13_6 = {
			...
		}

		var_13_1, var_13_2 = xpcall(function()
			var_13_5(var_13_4, arg_13_1, unpack(var_13_6))
		end, var_13_3)

		if not var_13_1 then
			break
		end
	end

	self._eventDispatchState[arg_13_1] = false

	if not var_13_1 then
		g.core.log:error(var_13_2)
		require("app.view.module.debug.pop.ErrorMessagePop").popErrorWin(var_13_2)
	end

	self:_sortObserverListener(arg_13_1)
	self:_doRemoveEventCache(arg_13_1)
end

function EventManager:_addAsyncEvent(arg_17_1)
	var_0_2(self._asyncEvent, {
		id = arg_17_1,
		args = {
			...
		}
	})
end

function EventManager:_sortObserverListener(arg_18_1)
	if self._eventSortDirty[arg_18_1] then
		self._eventSortDirty[arg_18_1] = false

		for iter_18_0, iter_18_1 in var_0_5(self._addEventCache[arg_18_1] or {}) do
			var_0_1.insert(self._observerList[arg_18_1], iter_18_1)
		end

		self._addEventCache[arg_18_1] = {}

		var_0_1.sort(self._observerList[arg_18_1], function(arg_19_0, arg_19_1)
			return arg_19_0[3] < arg_19_1[3]
		end)
	end
end

return EventManager
