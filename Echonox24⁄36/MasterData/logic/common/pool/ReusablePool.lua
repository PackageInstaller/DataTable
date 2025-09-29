-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/ReusablePool.lua

module("logic.common.pool.ReusablePool", package.seeall)

local ReusablePool = class("ReusablePool")
local kDefaultCapacity = 10

function ReusablePool:ctor(reusableClass, capacity)
	self.name = string.format("reusable_pool_%s", reusableClass:getClassKey())
	self.capacity = capacity or kDefaultCapacity
	self._class = reusableClass
	self._cacheObjects = {}
	self._createdCount = 0
end

function ReusablePool:setCapacity(capacity)
	self.capacity = capacity
end

function ReusablePool:preparePool(prepareRatio, ...)
	local prepareCount = math.floor((prepareRatio or 0.2) * self.capacity)

	if prepareCount <= 0 then
		return
	end

	local cacheObjects = self._cacheObjects
	local count = #cacheObjects + 1
	local objCls = self._class

	for i = count, prepareCount do
		local obj = objCls:NewObject(...)

		table.insert(cacheObjects, obj)
	end
end

function ReusablePool:clear()
	local cacheObjects = self._cacheObjects

	for i, obj in pairs(cacheObjects) do
		obj:destroy()

		cacheObjects[i] = nil
	end

	self._createdCount = 0
end

function ReusablePool:fetchObject(...)
	local objCls = self._class
	local objects = self._cacheObjects

	if #objects < 1 then
		self._createdCount = self._createdCount + 1

		self:_checkCapacity()

		return objCls:NewObject(...)
	else
		self._createdCount = math.min(self.capacity, self._createdCount)

		local obj = table.remove(self._cacheObjects)

		obj:reuse(...)

		return obj
	end
end

function ReusablePool:returnObject(obj)
	if not self:_checkCacheObjects(obj) then
		return
	end

	local count = #self._cacheObjects
	local objCls = self._class

	if count >= self.capacity then
		obj:destroy()
	else
		obj:reset()
		table.insert(self._cacheObjects, obj)
	end
end

function ReusablePool:toString()
	local count = #self._cacheObjects
	local capacity = self.capacity

	return string.format("ReusablePool::%s, count = %s, capacity = %s, fill = %s", self.name, count, capacity, count / capacity)
end

function ReusablePool:_checkCacheObjects(obj)
	if enableErrorLog and table.indexof(self._cacheObjects, obj) then
		printError("already containers object", self.name, debug.traceback())

		return false
	end

	return true
end

function ReusablePool:_checkCapacity()
	if enableDebug and self._createdCount >= self.capacity then
		printWarn(string.format("Capacity of the ReusablePool is not adequate,name=%s,capacity=%s,instanceCount=%s", self.name, self.capacity, self._createdCount))
	end
end

return ReusablePool
