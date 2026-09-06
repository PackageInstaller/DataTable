-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/resource/objectpool/FifoCache.lua

module("framework.resource.objectpool.FifoCache", package.seeall)

local FifoCache = class("FifoCache")

function FifoCache:ctor(capacity)
	self._capacity = capacity
	self._objectList = {}
	self._objectDict = {}
	self._valueKeyDict = {}
end

function FifoCache:getCount()
	return #self._objectList
end

function FifoCache:hasObject(key)
	local obj = self._objectDict[key]

	return obj ~= nil
end

function FifoCache:fetchObject(key)
	local obj = self._objectDict[key]

	if obj then
		self._objectDict[key] = nil

		table.removebyvalue(self._objectList, obj)

		self._valueKeyDict[obj] = nil
	end

	return obj
end

function FifoCache:fetchAll()
	self._objectList = {}
	self._objectDict = {}
	self._valueKeyDict = {}

	return self._objectList
end

function FifoCache:putObject(key, obj)
	local overflowObj
	local alreadyObj = self._objectDict[key]

	if not alreadyObj then
		self._objectDict[key] = obj
		self._valueKeyDict[obj] = key

		table.insert(self._objectList, obj)

		local len = #self._objectList

		if len > self._capacity then
			overflowObj = self._objectList[1]

			local overflowKey = self._valueKeyDict[self._objectList[1]]

			self._valueKeyDict[overflowObj] = nil
			self._objectDict[overflowKey] = nil

			table.remove(self._objectList, 1)
		end
	end

	return overflowObj
end

return FifoCache
