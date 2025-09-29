-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/pool/BattleReusablePoolMgr.lua

module("logic.battle.pool.BattleReusablePoolMgr", package.seeall)

local BattleReusablePoolMgr = class("BattleReusablePoolMgr")

function BattleReusablePoolMgr:ctor()
	self._gameObjectPools = {}
	self._reusableGroup = ReusablePoolGroup.New()
end

function BattleReusablePoolMgr:init()
	return
end

function BattleReusablePoolMgr:clear()
	self._reusableGroup:clear()

	for _, v in pairs(self._gameObjectPools) do
		v:returnSelf()
	end

	BattleTableUtil.clearTable(self._gameObjectPools)
end

function BattleReusablePoolMgr:toString()
	return self._reusableGroup:toString()
end

function BattleReusablePoolMgr:fetchReusableObject(reusableClass, ...)
	return self._reusableGroup:fetchObject(reusableClass, ...)
end

function BattleReusablePoolMgr:returnReusableObject(obj)
	self._reusableGroup:returnObject(obj)
end

function BattleReusablePoolMgr:fetchGameObjectInstance(url, goParent)
	local gameObjectPool = self._gameObjectPools[url]

	if not gameObjectPool then
		local resMgr = BattleMgr.instance:getResourceMgr()
		local prefab = resMgr:getPrefab(url)

		gameObjectPool = GameObjectPool:createInstance(prefab, BattleConst.ObjPoolCapacityDefault)
		self._gameObjectPools[url] = gameObjectPool
	end

	return gameObjectPool:fetchInstance(goParent)
end

function BattleReusablePoolMgr:returnGameObjectInstance(url, gameObject)
	local gameObjectPool = self._gameObjectPools[url]

	if not gameObjectPool then
		goutil.destroy(gameObject)

		return
	end

	gameObjectPool:returnInstance(gameObject)
end

BattleReusablePoolMgr.instance = BattleReusablePoolMgr.New()

return BattleReusablePoolMgr
