-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/gameobjectcache/GameObjectCache.lua

module("logic.common.gameobjectcache.GameObjectCache", package.seeall)

local GameObjectCache = class("GameObjectCache")
local kDefaultCapacity = 10

function GameObjectCache:ctor()
	self._cacheUnitTable = {}
end

function GameObjectCache:bindUrl(url, capacity)
	local cacheUnit = self._cacheUnitTable[url]

	if cacheUnit then
		cacheUnit:retain()

		return
	end

	cacheUnit = GameObjectCacheUnit:createInstance()

	cacheUnit:retain()
	cacheUnit:bindUrl(url)
	cacheUnit:setCapacity(capacity or kDefaultCapacity)

	self._cacheUnitTable[url] = cacheUnit
end

function GameObjectCache:unbindUrl(url)
	local cacheUnit = self:_getCacheUnit(url)

	if not cacheUnit then
		return
	end

	cacheUnit:release()
end

function GameObjectCache:loadGameObject(url, callback, callbackSelf)
	local cacheUnit = self:_getCacheUnit(url)

	if not cacheUnit then
		return
	end

	cacheUnit:loadInst(callback, callbackSelf)
end

function GameObjectCache:cancelLoadGameObject(url, callback, callbackSelf)
	local cacheUnit = self:_getCacheUnit(url)

	if not cacheUnit then
		return
	end

	cacheUnit:cancelLoadInst(callback, callbackSelf)
end

function GameObjectCache:releaseGameObject(url, gameObject)
	local cacheUnit = self:_getCacheUnit(url)

	if not cacheUnit then
		goutil.destroy(gameObject)

		return
	end

	cacheUnit:returnInst(gameObject)
end

function GameObjectCache:internalUnbindUrl(url)
	local cacheUnit = self:_getCacheUnit(url)

	if not cacheUnit then
		return
	end

	cacheUnit:returnSelf()

	self._cacheUnitTable[url] = false
end

function GameObjectCache:_getCacheUnit(url)
	local cacheUnit = self._cacheUnitTable[url]

	if not cacheUnit then
		if enableErrorLog then
			printError("GameObjectCache::need to bind url first!", url)
		end

		return false
	end

	return cacheUnit
end

GameObjectCache.instance = GameObjectCache.New()

return GameObjectCache
