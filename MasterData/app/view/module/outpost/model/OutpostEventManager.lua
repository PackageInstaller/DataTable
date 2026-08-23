local OutpostEventManager = class("OutpostEventManager")
local var_0_1 = table
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_4 = ipairs
local var_0_5 = type

function OutpostEventManager:ctor()
	self._observerList = {}
	self._eventPair = {}
	self._removeEventCache = {}
	self._addEventCache = {}
	self._eventDispatchState = {}
	self._eventSortDirty = {}
end

function OutpostEventManager:clearEvent()
	self._observerList = {}
	self._eventPair = {}
	self._removeEventCache = {}
	self._addEventCache = {}
	self._eventDispatchState = {}
	self._eventSortDirty = {}
end

function OutpostEventManager:addEventListener(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	assert(var_0_5(arg_3_1) == "number", "Invalid event: " .. tostring(arg_3_1))
	assert(var_0_5(arg_3_2) == "function", "Invalid fun: " .. tostring(arg_3_2))
	assert(arg_3_3, "Invalid target: " .. tostring(arg_3_3))

	if not self:_findListener(arg_3_3, arg_3_1) then
		self:_addListener(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	end
end

function OutpostEventManager:removeListenerWithTarget(arg_4_1)
	assert(arg_4_1, "Invalid target: " .. tostring(arg_4_1))

	if self:_findListener(arg_4_1) then
		self:_removeListener(arg_4_1)
	end
end

function OutpostEventManager:removeListenerWithEvent(arg_5_1, arg_5_2)
	assert(var_0_5(arg_5_2) == "string", "Invalid event: " .. tostring(arg_5_2))
	assert(arg_5_1, "Invalid target: " .. tostring(arg_5_1))

	if self:_findListener(arg_5_1, arg_5_2) then
		self:_removeListener(arg_5_1, arg_5_2)
	end
end

function OutpostEventManager:dispatchEvent(arg_6_1, arg_6_2)
	self:_doDispatchEvent(arg_6_1, arg_6_2)
end

function OutpostEventManager:_findListener(arg_7_1, arg_7_2)
	if not arg_7_2 then
		return self._eventPair[arg_7_1] ~= nil
	end

	if self._observerList[arg_7_2] then
		for iter_7_0, iter_7_1 in var_0_4(self._observerList[arg_7_2]) do
			if iter_7_1[1] == arg_7_1 then
				return true
			end
		end
	end

	if self._addEventCache[arg_7_2] then
		for iter_7_2, iter_7_3 in var_0_4(self._addEventCache[arg_7_2]) do
			if iter_7_3[1] == arg_7_1 then
				return true
			end
		end
	end

	return false
end

function OutpostEventManager:_addListener(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = self._observerList[arg_8_1]

	if not self._observerList[arg_8_1] then
		var_8_0 = {}
		self._observerList[arg_8_1] = var_8_0
	end

	arg_8_4 = arg_8_4 or 0

	local var_8_1 = false

	if not self._eventDispatchState[arg_8_1] then
		for iter_8_0, iter_8_1 in var_0_4(var_8_0) do
			if arg_8_4 < iter_8_1[3] then
				var_8_1 = true

				var_0_2(var_8_0, iter_8_0, {
					arg_8_3,
					arg_8_2,
					arg_8_4
				})

				break
			end
		end
	else
		self._eventSortDirty[arg_8_1] = true
	end

	if not var_8_1 then
		if self._eventSortDirty[arg_8_1] then
			local var_8_2 = self._addEventCache[arg_8_1]

			if not self._addEventCache[arg_8_1] then
				var_8_2 = {}
				self._addEventCache[arg_8_1] = var_8_2
			end

			var_0_1.insert(var_8_2, {
				arg_8_3,
				arg_8_2,
				arg_8_4
			})
		else
			var_0_2(var_8_0, {
				arg_8_3,
				arg_8_2,
				arg_8_4
			})
		end
	end

	local var_8_3 = self._eventPair[arg_8_3]

	if not self._eventPair[arg_8_3] then
		var_8_3 = {}
		self._eventPair[arg_8_3] = var_8_3
	end

	var_0_2(var_8_3, arg_8_1)
end

function OutpostEventManager:_removeListener(arg_9_1, arg_9_2)
	if not arg_9_2 then
		if not self._eventPair[arg_9_1] then
			return
		end

		for iter_9_0, iter_9_1 in var_0_4(self._eventPair[arg_9_1]) do
			self:_removeListener(arg_9_1, iter_9_1)
		end

		self._eventPair[arg_9_1] = nil
	else
		local var_9_0 = self._observerList[arg_9_2]

		if self._observerList[arg_9_2] then
			if self._eventDispatchState[arg_9_2] then
				self:_addRemoveEventCache(arg_9_1, arg_9_2)

				return
			end

			for iter_9_2, iter_9_3 in var_0_4(var_9_0) do
				if iter_9_3[1] == arg_9_1 then
					var_0_3(var_9_0, iter_9_2)

					return
				end
			end
		end

		local var_9_1 = self._addEventCache[arg_9_2]

		if self._addEventCache[arg_9_2] then
			for iter_9_4, iter_9_5 in var_0_4(var_9_1) do
				if iter_9_5[1] == arg_9_1 then
					var_0_3(var_9_1, iter_9_4)

					return
				end
			end
		end
	end
end

function OutpostEventManager:_addRemoveEventCache(arg_10_1, arg_10_2)
	local var_10_0 = self._removeEventCache[arg_10_2]

	if not self._removeEventCache[arg_10_2] then
		var_10_0 = {}
		self._removeEventCache[arg_10_2] = var_10_0
	end

	var_0_2(var_10_0, arg_10_1)
end

function OutpostEventManager:_doRemoveEventCache(arg_11_1)
	if not self._removeEventCache[arg_11_1] then
		return
	end

	for iter_11_0, iter_11_1 in var_0_4(self._removeEventCache[arg_11_1]) do
		self:_removeListener(iter_11_1, arg_11_1)
	end

	self._removeEventCache[arg_11_1] = nil
end

function OutpostEventManager:_doDispatchEvent(arg_12_1, arg_12_2)
	if self._observerList[arg_12_1] == nil then
		return
	end

	self._eventDispatchState[arg_12_1] = true

	for iter_12_0, iter_12_1 in var_0_4(self._observerList[arg_12_1]) do
		iter_12_1[2](iter_12_1[1], arg_12_1, arg_12_2)
	end

	self._eventDispatchState[arg_12_1] = false

	self:_sortObserverListener(arg_12_1)
	self:_doRemoveEventCache(arg_12_1)
end

function OutpostEventManager:_sortObserverListener(arg_13_1)
	if self._eventSortDirty[arg_13_1] then
		self._eventSortDirty[arg_13_1] = false

		for iter_13_0, iter_13_1 in var_0_4(self._addEventCache[arg_13_1] or {}) do
			var_0_1.insert(self._observerList[arg_13_1], iter_13_1)
		end

		self._addEventCache[arg_13_1] = {}

		var_0_1.sort(self._observerList[arg_13_1], function(arg_14_0, arg_14_1)
			return arg_14_0[3] < arg_14_1[3]
		end)
	end
end

return OutpostEventManager
