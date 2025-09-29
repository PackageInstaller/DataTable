-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/gameobject/GameObjectPool.lua

module("logic.common.pool.gameobject.GameObjectPool", package.seeall)

local GameObjectPool = class("GameObjectPool", AbstractGlobalReusable)
local kPoolRoot = PoolRootUtil.getScenePoolRoot()
local kDefaultCapacity = 10
local kDefaultPrepareRatio = 0.2

function GameObjectPool:NewObject(prefab, capacity)
	return self.New(prefab, capacity or kDefaultCapacity)
end

function GameObjectPool:ctor(prefab, capacity)
	self._prefab = false
	self._capacity = false
	self._goCacheList = {}

	self:reuse(prefab, capacity)
end

function GameObjectPool:reuse(prefab, capacity)
	self._prefab = prefab
	self._capacity = capacity
end

function GameObjectPool:reset()
	self._prefab = false
	self._capacity = false

	self:_clearCache()
end

function GameObjectPool:destroy()
	self:reset()
end

function GameObjectPool:preparePool(prepareRatio)
	local prepareCount = math.floor((prepareRatio or kDefaultPrepareRatio) * self._capacity)

	if prepareCount <= 0 then
		return
	end

	local goCacheList = self._goCacheList
	local count = #goCacheList + 1

	for i = count, prepareCount do
		local goInst = goutil.clone(self._prefab)

		goutil.addChildToParent(goInst, kPoolRoot)
		table.insert(goCacheList, goInst)
	end
end

function GameObjectPool:fetchInstance(goParent)
	local goInst

	if #self._goCacheList > 0 then
		goInst = table.remove(self._goCacheList)
	else
		goInst = goutil.clone(self._prefab)
	end

	goutil.addChildToParent(goInst, goParent)

	return goInst
end

function GameObjectPool:returnInstance(goInstance)
	if #self._goCacheList >= self._capacity then
		goutil.destroy(goInstance)

		return
	end

	table.insert(self._goCacheList, goInstance)
	goutil.addChildToParent(goInstance, kPoolRoot)
end

function GameObjectPool:_clearCache()
	for _, go in pairs(self._goCacheList) do
		goutil.destroy(go)
	end

	table.clear(self._goCacheList)
end

return GameObjectPool
