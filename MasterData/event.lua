-- chunkname: @event.lua

local setmetatable = setmetatable
local xpcall = xpcall
local pcall = pcall
local assert = assert
local rawget = rawget
local error = error
local print = print
local maxn = table.maxn
local traceback = tolua.traceback
local ilist = ilist
local _xpcall = {}

function _xpcall:__call(...)
	if jit then
		if self.obj == nil then
			return xpcall(self.func, traceback, ...)
		else
			return xpcall(self.func, traceback, self.obj, ...)
		end
	else
		local args = {
			...
		}

		if self.obj == nil then
			local function func()
				self.func(unpack(args, 1, maxn(args)))
			end

			return xpcall(func, traceback)
		else
			local function func()
				self.func(self.obj, unpack(args, 1, maxn(args)))
			end

			return xpcall(func, traceback)
		end
	end
end

function _xpcall.__eq(lhs, rhs)
	return lhs.func == rhs.func and lhs.obj == rhs.obj
end

local function xfunctor(func, obj)
	return setmetatable({
		func = func,
		obj = obj
	}, _xpcall)
end

local _pcall = {}

function _pcall:__call(...)
	if self.obj == nil then
		return pcall(self.func, ...)
	else
		return pcall(self.func, self.obj, ...)
	end
end

function _pcall.__eq(lhs, rhs)
	return lhs.func == rhs.func and lhs.obj == rhs.obj
end

local function functor(func, obj)
	return setmetatable({
		func = func,
		obj = obj
	}, _pcall)
end

local _event = {}

_event.__index = _event

function _event:Add(func, obj)
	assert(func)

	if self.keepSafe then
		func = xfunctor(func, obj)
	else
		func = functor(func, obj)
	end

	if self.lock then
		local node = {
			_next = 0,
			removed = true,
			_prev = 0,
			value = func
		}

		table.insert(self.opList, function()
			self.list:pushnode(node)
		end)

		return node
	else
		return self.list:push(func)
	end
end

function _event:Remove(func, obj)
	for i, v in ilist(self.list) do
		if v.func == func and v.obj == obj then
			if self.lock then
				table.insert(self.opList, function()
					self.list:remove(i)
				end)
			else
				self.list:remove(i)
			end

			break
		end
	end
end

function _event:CreateListener(func, obj)
	if self.keepSafe then
		func = xfunctor(func, obj)
	else
		func = functor(func, obj)
	end

	return {
		_next = 0,
		removed = true,
		_prev = 0,
		value = func
	}
end

function _event:AddListener(handle)
	assert(handle)

	if self.lock then
		table.insert(self.opList, function()
			self.list:pushnode(handle)
		end)
	else
		self.list:pushnode(handle)
	end
end

function _event:RemoveListener(handle)
	assert(handle)

	if self.lock then
		table.insert(self.opList, function()
			self.list:remove(handle)
		end)
	else
		self.list:remove(handle)
	end
end

function _event:Count()
	return self.list.length
end

function _event:Clear()
	self.list:clear()

	self.opList = {}
	self.lock = false
	self.keepSafe = false
	self.current = nil
end

function _event:Dump()
	local count = 0

	for _, v in ilist(self.list) do
		if v.obj then
			print("update function:", v.func, "object name:", v.obj.name)
		else
			print("update function: ", v.func)
		end

		count = count + 1
	end

	print("all function is:", count)
end

function _event:__call(...)
	local _list = self.list

	self.lock = true

	local ilist = ilist

	for i, f in ilist(_list) do
		self.current = i

		local flag, msg = f(...)

		if not flag then
			_list:remove(i)

			self.lock = false

			error(msg)
		end
	end

	local opList = self.opList

	self.lock = false

	for i, op in ipairs(opList) do
		op()

		opList[i] = nil
	end
end

function event(name, safe)
	safe = safe or false

	return setmetatable({
		lock = false,
		name = name,
		keepSafe = safe,
		opList = {},
		list = list:new()
	}, _event)
end

UpdateBeat = event("Update", true)
LateUpdateBeat = event("LateUpdate", true)
FixedUpdateBeat = event("FixedUpdate", true)
CoUpdateBeat = event("CoUpdate")

local Time = Time
local UpdateBeat = UpdateBeat
local LateUpdateBeat = LateUpdateBeat
local FixedUpdateBeat = FixedUpdateBeat
local CoUpdateBeat = CoUpdateBeat

function Update(deltaTime, unscaledDeltaTime)
	Time:SetDeltaTime(deltaTime, unscaledDeltaTime)
	UpdateBeat()
end

function LateUpdate()
	LateUpdateBeat()
	CoUpdateBeat()
	Time:SetFrameCount()
end

function FixedUpdate(fixedDeltaTime)
	Time:SetFixedDelta(fixedDeltaTime)
	FixedUpdateBeat()
end

function PrintEvents()
	UpdateBeat:Dump()
	FixedUpdateBeat:Dump()
end
