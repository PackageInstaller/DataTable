-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/zone/SceneZoneMgr.lua

module("frameworkext.scene.zone.SceneZoneMgr", package.seeall)

local SceneZoneMgr = class("SceneZoneMgr", SceneComponentBase)

function SceneZoneMgr:ctor(scene)
	SceneZoneMgr.super.ctor(self, scene)

	self._curZoneId = 0
	self._activeZones = nil
	self._firstZones = nil
	self._zoneCache = FifoCache.New(0)
	self._tempBounds = BoundingBox2D.New()
	self._curSceneId = 0
	self._tempEmpty = {}
end

function SceneZoneMgr:onInit()
	self._container = self._scene:getContainer()
	self._sceneCfgFinder = self._scene.cfgFinder
	self._unitFactory = self._scene.unitFactory
end

function SceneZoneMgr:getActiveZone(zoneId)
	return self._activeZones[zoneId]
end

function SceneZoneMgr:onEnterScene(sceneId, bornX, bornZ)
	self._activeZones = {}
	self._curSceneId = sceneId
	self._firstZones = {}

	local zoneId = self:_findZoneId(bornX, bornZ)

	if zoneId == 0 then
		printError("cannot find zone for pos=", bornX, bornZ)

		return
	end

	local neighborIds = self._sceneCfgFinder:findZoneNeighbors(zoneId)

	if not neighborIds then
		return
	end

	table.insert(self._firstZones, zoneId)
	table.insertto(self._firstZones, neighborIds)
end

function SceneZoneMgr:_testInZone(zoneId, x, z)
	if zoneId == 0 then
		return false
	end

	local tempZone = self._activeZones[zoneId]
	local zoneCO

	if not tempZone then
		local minx, minz, maxx, maxz = self._sceneCfgFinder:findBounds(zoneId)

		self._tempBounds:setBorders(minx, minz, maxx, maxz)

		if self._tempBounds:contains(x, z) then
			return true
		end
	elseif tempZone:contains(x, z) then
		return true
	end

	return false
end

function SceneZoneMgr:_findZoneId(x, z)
	if self._curZoneId > 0 then
		if self:_testInZone(self._curZoneId, x, z) then
			return self._curZoneId
		end

		local neighbors = self._sceneCfgFinder:findZoneNeighbors(self._curZoneId)
		local len = #neighbors

		for i = 1, len do
			if self:_testInZone(neighbors[i], x, z) then
				return neighbors[i]
			end
		end
	end

	local allZones = self._sceneCfgFinder:findSceneZones(self._curSceneId)

	len = #allZones

	for i = 1, len do
		if self:_testInZone(allZones[i], x, z) then
			return allZones[i]
		end
	end

	return 0
end

function SceneZoneMgr:onExitScene()
	if self._activeZones then
		for k, v in pairs(self._activeZones) do
			v:onExit()
			v:onDestroy()
		end

		self._activeZones = nil
	end

	local cachedZones = self._zoneCache:fetchAll()
	local cachedCount = #cachedZones

	for i = 1, cachedCount do
		cachedZones[i]:onDestroy()
	end

	self._firstZones = nil
	self._curZoneId = 0
	self._curSceneId = 0
end

function SceneZoneMgr:_getOrCreateZone(zoneId)
	local zone = self._zoneCache:fetchObject(zoneId)

	zone = zone or SceneZone.New(zoneId, self._container, self._sceneCfgFinder, self._onTerrainLoaded, self._onTerrainDestroyed, self)

	return zone
end

function SceneZoneMgr:onTargetPosUpdate(x, z)
	local zoneId = self:_findZoneId(x, z)

	if zoneId == 0 then
		printError("cannot find zone for pos=", x, z)

		return
	end

	if self._curZoneId == zoneId then
		-- block empty
	else
		local newNeighborIds = self._sceneCfgFinder:findZoneNeighbors(zoneId)

		newNeighborIds = newNeighborIds or self._tempEmpty

		table.insert(newNeighborIds, 1, zoneId)

		local toDeleteIds = {}

		for k, v in pairs(self._activeZones) do
			local index = table.indexof(newNeighborIds, k)

			if not index then
				table.insert(toDeleteIds, k)
			end
		end

		local len = #toDeleteIds
		local tempZoneId, tempZone

		for i = 1, len do
			tempZoneId = toDeleteIds[i]
			tempZone = self._activeZones[toDeleteIds[i]]

			self._activeZones[toDeleteIds[i]]:onExit()
			self:dispatch(SceneNotify.ExitZone, tempZoneId)

			self._activeZones[tempZoneId] = nil

			local overflowZone = self._zoneCache:putObject(tempZoneId, tempZone)

			if overflowZone then
				overflowZone:onDestroy()
			end
		end

		len = #newNeighborIds

		for i = 1, #newNeighborIds do
			tempZoneId = newNeighborIds[i]

			if not self._activeZones[newNeighborIds[i]] then
				tempZone = self:_getOrCreateZone(tempZoneId)
				self._activeZones[tempZoneId] = tempZone

				tempZone:onEnter()
				self:dispatch(SceneNotify.EnterZone, tempZoneId)
			end
		end

		table.remove(newNeighborIds, 1)

		self._curZoneId = zoneId
	end
end

function SceneZoneMgr:_onTerrainDestroyed(zoneId)
	self:dispatch(SceneNotify.ZoneDestroyed, zoneId)
end

function SceneZoneMgr:_onTerrainLoaded(zoneId, zoneGo)
	table.removebyvalue(self._firstZones, zoneId)
	self:dispatch(SceneNotify.ZoneLoaded, zoneId, zoneGo)

	if self._firstZones and #self._firstZones <= 0 then
		self:dispatch(SceneNotify.FirstZonesLoaded)
	end
end

return SceneZoneMgr
