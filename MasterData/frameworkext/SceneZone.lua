-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/zone/SceneZone.lua

module("frameworkext.scene.zone.SceneZone", package.seeall)

local SceneZone = class("SceneZone")

function SceneZone:ctor(id, container, sceneCfgFinder, loadedCallback, destroyedCallback, callbackObj)
	self.id = id
	self._sceneCfgFinder = sceneCfgFinder
	self._container = container
	self._res = nil
	self._inst = nil
	self._bounds = BoundingBox2D.New()

	local minx, minz, maxx, maxz = self._sceneCfgFinder:findBounds(id)

	self._bounds:setBorders(minx, minz, maxx, maxz)

	self._terrainResUrl = nil
	self._loadedCallback = loadedCallback
	self._destroyedCallback = destroyedCallback
	self._callbackObj = callbackObj
end

function SceneZone:contains(x, z)
	return self._bounds:contains(x, z)
end

function SceneZone:getZoneGo()
	return self._inst
end

function SceneZone:_onTerrainLoaded(res)
	if res.IsSuccess then
		self._res = res

		self._res:Retain()

		local prefab = res:GetMainAsset()

		self._inst = goutil.clone(prefab)

		goutil.addChildToParent(self._inst, self._container)

		if self._loadedCallback then
			self._loadedCallback(self._callbackObj, self.id, self._inst)
		end
	end
end

function SceneZone:onEnter()
	if not self._terrainResUrl then
		self._terrainResUrl = self._sceneCfgFinder:findTerrainResUrl(self.id)

		rescache:GetResource(self._terrainResUrl, self._onTerrainLoaded, self, ResType.AssetBunble, true)
	end
end

function SceneZone:onExit()
	return
end

function SceneZone:onDestroy()
	if self._res == nil then
		if self._terrainResUrl then
			rescache:RemoveListener(self._terrainResUrl, self._onTerrainLoaded, self)
		end
	else
		goutil.destroy(self._inst)

		self._inst = nil

		self._res:Release()

		self._res = nil

		if self._destroyedCallback then
			self._destroyedCallback(self._callbackObj, self.id)
		end
	end

	self._sceneCfgFinder = nil
	self._container = nil
	self._terrainResUrl = nil
end

return SceneZone
