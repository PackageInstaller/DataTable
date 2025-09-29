-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/prefabpool/AbstractPrefabPoolFactory.lua

module("logic.common.pool.prefabpool.AbstractPrefabPoolFactory", package.seeall)

local M = class("AbstractPrefabPoolFactory")
local kDefaultPoolName = "NormalPool"
local kInitDespawnCount = 1
local kSpawnMaxLimit = 0
local kAutoDespawnTime = 0
local kDespawnMaxLimit = 0
local kTidyDespawnTime = 0
local kTidyDespawnMinCount = 0
local kTidyCount = 0

function M:ctor()
	self._useDefaultConfig = true
end

function M:isSameResource(url)
	if not self._resLoader then
		return false
	end

	return self._resLoader:isSameResource(url)
end

function M:loadAsset(path, loadedCallback, loadedHandler, poolName)
	self._loadedCallback = loadedCallback
	self._loadedHandler = loadedHandler
	poolName = poolName or kDefaultPoolName
	self._poolName = poolName
	self._resPath = path

	local spawnPool = SpaceX.PoolManager.Instance:GetSpawnPool(poolName)

	self._spawnPool = spawnPool

	if not self._loadedAsset then
		local resLoader = SingleResLoader.New()

		resLoader:load(path, self.onAssetLoad, self)

		self._resLoader = resLoader
	elseif self._loadedCallback then
		self._loadedCallback(self._loadedHandler)
	end
end

function M:onAssetLoad(res)
	if res.IsSuccess then
		if self._useDefaultConfig then
			self:initPool(res:GetMainAsset(), res.ResPath)
		end

		self._loadedAsset = true

		if self._loadedCallback then
			self._loadedCallback(self._loadedHandler, res)
		end
	elseif self._loadedCallback then
		self._loadedCallback(self._loadedHandler, nil)
	end
end

function M:initPool(prefab, resPath, initDespawnCount, spawnMaxLimit, autoDespawnTime, despawnMaxLimit, tidyDespawnTime, tidyDespawnMinCount, tidyCount)
	local prefabPool = self._spawnPool:GetPrefabPoolByResPath(resPath)

	if not prefab.transform then
		return
	end

	if not prefabPool then
		initDespawnCount = initDespawnCount or kInitDespawnCount
		spawnMaxLimit = spawnMaxLimit or kSpawnMaxLimit
		autoDespawnTime = autoDespawnTime or kAutoDespawnTime
		despawnMaxLimit = despawnMaxLimit or kDespawnMaxLimit
		tidyDespawnTime = tidyDespawnTime or kTidyDespawnTime
		tidyDespawnMinCount = tidyDespawnMinCount or kTidyDespawnMinCount
		tidyCount = tidyCount or kTidyCount

		self._spawnPool:AddPrefabParam(prefab.transform, resPath, initDespawnCount, spawnMaxLimit, autoDespawnTime, despawnMaxLimit, tidyDespawnTime, tidyDespawnMinCount, tidyCount)
	end

	self._prefabPool = self._spawnPool:GetPrefabPoolByResPath(resPath)

	if not self._addCallback then
		if self._prefabPool then
			self._prefabPool:AddSpawnCallback(function(transform)
				self:onSpawn(transform)
			end)
		end

		if self._prefabPool then
			self._prefabPool:AddDespawnCallback(function(transform)
				self:onDespawn(transform)
			end)
		end

		self._addCallback = true
	end
end

function M:spawn(resPath)
	resPath = resPath or self._resPath

	return self._spawnPool:Spawn(resPath)
end

function M:setOnSpawn(onSpawnCallback)
	self._onSpawnCallback = onSpawnCallback
end

function M:setOnDespawn(onDespawnCallback)
	self._onDespawnCallback = onDespawnCallback
end

function M:onSpawn(transform)
	if self._onSpawnCallback then
		self._onSpawnCallback(transform)
	end
end

function M:deSpawn(transform)
	self._spawnPool:Despawn(transform)
end

function M:setOnDespawn(onDespawnCallback)
	self._onDespawnCallback = onDespawnCallback
end

function M:onDespawn(transform)
	if self._onDespawnCallback then
		self._onDespawnCallback(transform)
	end
end

return M
