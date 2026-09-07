local var_0_0 = setmetatable
local var_0_1 = xpcall
local var_0_2 = pcall
local var_0_3 = assert
local var_0_5 = error
local var_0_6 = print
local var_0_7 = tolua.traceback
local var_0_8 = ilist
local var_0_9 = {
	__call = function(self, ...)
		if jit then
			if self.obj == nil then
				return var_0_1(self.func, var_0_7, ...)
			else
				return var_0_1(self.func, var_0_7, self.obj, ...)
			end
		else
			local var_1_0 = packEx(...)

			if self.obj == nil then
				return var_0_1(function()
					self.func(unpackEx(var_1_0))

					return
				end, var_0_7)
			else
				return var_0_1(function()
					self.func(self.obj, unpackEx(var_1_0))

					return
				end, var_0_7)
			end
		end

		return
	end,
	__eq = function(self, arg_4_1)
		return self.func == arg_4_1.func and self.obj == arg_4_1.obj
	end
}

local function var_0_10(arg_5_0, arg_5_1)
	return var_0_0({
		func = arg_5_0,
		obj = arg_5_1
	}, var_0_9)
end

local var_0_11 = {
	__call = function(self, ...)
		if self.obj == nil then
			return var_0_2(self.func, ...)
		else
			return var_0_2(self.func, self.obj, ...)
		end

		return
	end,
	__eq = function(self, arg_7_1)
		return self.func == arg_7_1.func and self.obj == arg_7_1.obj
	end
}

local function var_0_12(arg_8_0, arg_8_1)
	return var_0_0({
		func = arg_8_0,
		obj = arg_8_1
	}, var_0_11)
end

local var_0_13 = {}

var_0_13.__index = var_0_13

function var_0_13:Add(arg_9_1, arg_9_2)
	var_0_3(arg_9_1)

	arg_9_1 = self.keepSafe and var_0_10(arg_9_1, arg_9_2) or var_0_12(arg_9_1, arg_9_2)

	if self.lock then
		local var_9_0 = {
			_next = 0,
			removed = true,
			_prev = 0,
			value = arg_9_1
		}

		table.insert(self.opList, function()
			self.list:pushnode(var_9_0)

			return
		end)

		return var_9_0
	else
		return self.list:push(arg_9_1)
	end

	return
end

function var_0_13:Remove(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in var_0_8(self.list) do
		if iter_11_1.func == arg_11_1 and iter_11_1.obj == arg_11_2 then
			if self.lock then
				table.insert(self.opList, function()
					self.list:remove(iter_11_0)

					return
				end)
			else
				self.list:remove(iter_11_0)
			end

			break
		end
	end

	return
end

function var_0_13:CreateListener(arg_13_1, arg_13_2)
	arg_13_1 = self.keepSafe and var_0_10(arg_13_1, arg_13_2) or var_0_12(arg_13_1, arg_13_2)

	return {
		_next = 0,
		removed = true,
		_prev = 0,
		value = arg_13_1
	}
end

function var_0_13:AddListener(arg_14_1)
	var_0_3(arg_14_1)

	if self.lock then
		table.insert(self.opList, function()
			self.list:pushnode(arg_14_1)

			return
		end)
	else
		self.list:pushnode(arg_14_1)
	end

	return
end

function var_0_13:RemoveListener(arg_16_1)
	var_0_3(arg_16_1)

	if self.lock then
		table.insert(self.opList, function()
			self.list:remove(arg_16_1)

			return
		end)
	else
		self.list:remove(arg_16_1)
	end

	return
end

function var_0_13:Count()
	return self.list.length
end

function var_0_13:Clear()
	self.list:clear()

	self.opList = {}
	self.lock = false
	self.keepSafe = false
	self.current = nil

	return
end

function var_0_13:Dump()
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in var_0_8(self.list) do
		if iter_20_1.obj then
			var_0_6("update function:", iter_20_1.func, "object name:", iter_20_1.obj.name)
		else
			var_0_6("update function: ", iter_20_1.func)
		end

		var_20_0 = var_20_0 + 1
	end

	var_0_6("all function is:", var_20_0)

	return
end

function var_0_13:__call(...)
	self.lock = true

	for iter_21_0, iter_21_1 in var_0_8(self.list) do
		self.current = iter_21_0

		local var_21_0, var_21_1 = iter_21_1(...)

		if not var_21_0 then
			self.list:remove(iter_21_0)

			self.lock = false

			var_0_5(var_21_1)
		end
	end

	self.lock = false

	for iter_21_2, iter_21_3 in ipairs(self.opList) do
		iter_21_3()

		self.opList[iter_21_2] = nil
	end

	return
end

function event(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or false

	return var_0_0({
		lock = false,
		name = arg_22_0,
		keepSafe = arg_22_1,
		opList = {},
		list = list:new()
	}, var_0_13)
end

UpdateBeat = event("Update", true)
LateUpdateBeat = event("LateUpdate", true)
FixedUpdateBeat = event("FixedUpdate", true)
CoUpdateBeat = event("CoUpdate")

local var_0_14 = Time
local var_0_15 = UpdateBeat
local var_0_16 = LateUpdateBeat
local var_0_17 = FixedUpdateBeat
local var_0_18 = CoUpdateBeat

function Update(arg_23_0, arg_23_1)
	var_0_14:SetDeltaTime(arg_23_0, arg_23_1)
	var_0_15()

	return
end

function LateUpdate()
	var_0_16()
	var_0_18()
	var_0_14:SetFrameCount()

	return
end

function FixedUpdate(arg_25_0)
	var_0_14:SetFixedDelta(arg_25_0)
	var_0_17()

	return
end

function PrintEvents()
	var_0_15:Dump()
	var_0_17:Dump()

	return
end

return
