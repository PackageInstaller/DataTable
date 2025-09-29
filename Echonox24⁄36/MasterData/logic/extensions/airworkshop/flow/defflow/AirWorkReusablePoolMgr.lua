-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/AirWorkReusablePoolMgr.lua

module("logic.extensions.airworkshop.flow.defflow.AirWorkReusablePoolMgr", package.seeall)

local AirWorkReusablePoolMgr = class("AirWorkReusablePoolMgr")

function AirWorkReusablePoolMgr:ctor()
	self._gameObjectPools = {}
	self._reusableGroup = ReusablePoolGroup.New()
end

function AirWorkReusablePoolMgr:init()
	return
end

function AirWorkReusablePoolMgr:clear()
	self._reusableGroup:clear()

	for _, v in pairs(self._gameObjectPools) do
		v:returnSelf()
	end

	BattleTableUtil.clearTable(self._gameObjectPools)
end

function AirWorkReusablePoolMgr:toString()
	return self._reusableGroup:toString()
end

function AirWorkReusablePoolMgr:fetchReusableObject(reusableClass, ...)
	return self._reusableGroup:fetchObject(reusableClass, ...)
end

function AirWorkReusablePoolMgr:returnReusableObject(obj)
	self._reusableGroup:returnObject(obj)
end

function AirWorkReusablePoolMgr:fetchGameObjectInstance(url, goParent)
	local gameObjectPool = self._gameObjectPools[url]

	if not gameObjectPool then
		local resMgr = AirWorkShopDefMgr.instance:getResourceMgr()
		local prefab = resMgr:getPrefab(url)

		gameObjectPool = GameObjectPool:createInstance(prefab, BattleConst.ObjPoolCapacityDefault)
		self._gameObjectPools[url] = gameObjectPool
	end

	return gameObjectPool:fetchInstance(goParent)
end

function AirWorkReusablePoolMgr:returnGameObjectInstance(url, gameObject)
	local gameObjectPool = self._gameObjectPools[url]

	if not gameObjectPool then
		goutil.destroy(gameObject)

		return
	end

	gameObjectPool:returnInstance(gameObject)
end

AirWorkReusablePoolMgr.instance = AirWorkReusablePoolMgr.New()

return AirWorkReusablePoolMgr
