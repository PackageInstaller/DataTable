-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/resource/objectpool/ObjectPool.lua

module("framework.resource.objectpool.ObjectPool", package.seeall)

local ObjectPool = class("ObjectPool")

function ObjectPool:ctor(capacity, createFunc, disposeFunc, resetFunc)
	self._capacity = capacity or 0
	self._objects = {}
	self._createFunc = createFunc
	self._disposeFunc = disposeFunc
	self._resetFunc = resetFunc
	self._createdCount = 0
	self._disposedCount = 0
end

function ObjectPool:setCapacity(capacity)
	self._capacity = capacity
end

function ObjectPool:getObjectCount()
	return #self._objects
end

function ObjectPool:getCreatedCount()
	return self._createdCount
end

function ObjectPool:getDisposedCount()
	return self._disposedCount
end

function ObjectPool:fetchObject()
	local count = #self._objects
	local obj

	return count < 1 and self:_createNewObject() or table.remove(self._objects)
end

function ObjectPool:returnObject(obj)
	local count = #self._objects

	self:_resetObject(obj)

	if count >= self._capacity then
		self:_disposeObject(obj)
	else
		table.insert(self._objects, obj)
	end
end

function ObjectPool:_createNewObject()
	local obj

	if self._createFunc ~= nil then
		obj = self._createFunc()
		self._createdCount = self._createdCount + 1
	end

	return obj
end

function ObjectPool:_disposeObject(obj)
	if self._disposeFunc ~= nil then
		self._disposeFunc(obj)
	end

	self._disposedCount = self._disposedCount + 1
end

function ObjectPool:_resetObject(obj)
	if self._resetFunc ~= nil then
		self._resetFunc(obj)
	end
end

function ObjectPool:clear()
	local count = #self._objects

	if count > 0 then
		local obj

		for i = 1, count do
			self:_disposeObject(self._objects[i])

			self._objects[i] = nil
		end
	end
end

return ObjectPool
