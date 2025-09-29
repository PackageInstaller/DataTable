-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/ReusablePoolGroup.lua

module("logic.common.pool.ReusablePoolGroup", package.seeall)

local ReusablePoolGroup = class("ReusablePoolGroup")

function ReusablePoolGroup:ctor()
	self._objPools = {}
end

function ReusablePoolGroup:clear()
	for _, v in pairs(self._objPools) do
		v:clear()
	end

	table.clear(self._objPools)
end

function ReusablePoolGroup:fetchObject(reusableClass, ...)
	local pool = self:_getOrCreatePool(reusableClass)

	return pool:fetchObject(...)
end

function ReusablePoolGroup:returnObject(obj)
	local poolKey = obj:getClassKey()
	local pool = self._objPools[poolKey]

	if not pool then
		obj:destroy()

		return
	end

	return pool:returnObject(obj)
end

function ReusablePoolGroup:preparePool(reusableClass, prepareRatio, ...)
	local pool = self:_getOrCreatePool(reusableClass)

	pool:preparePool(prepareRatio, ...)
end

function ReusablePoolGroup:clearPool(reusableClass)
	local poolKey = reusableClass:getClassKey()
	local pool = self._objPools[poolKey]

	if not pool then
		return
	end

	pool:clear()
end

function ReusablePoolGroup:toString()
	local sb = StringBuffer.New()

	for _, pool in pairs(self._objPools) do
		sb:append(pool:toString()):appendLine()
	end

	return sb:toString()
end

function ReusablePoolGroup:_getOrCreatePool(reusableClass)
	local poolKey = reusableClass:getClassKey()
	local pool = self._objPools[poolKey]

	if not pool then
		local capacity = reusableClass:getCapacity()

		pool = ReusablePool.New(reusableClass, capacity)
		self._objPools[poolKey] = pool
	end

	return pool
end

return ReusablePoolGroup
