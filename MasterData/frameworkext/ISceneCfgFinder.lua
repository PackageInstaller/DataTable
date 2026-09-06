-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/config/ISceneCfgFinder.lua

module("frameworkext.scene.config.ISceneCfgFinder", package.seeall)

local ISceneCfgFinder = class("ISceneCfgFinder")

function ISceneCfgFinder:findBounds(zoneId)
	return 0, 0, 0, 0
end

function ISceneCfgFinder:findZoneNeighbors(zoneId)
	return
end

function ISceneCfgFinder:findSceneZones(sceneId)
	return
end

function ISceneCfgFinder:findTerrainResUrl(zoneId)
	return nil
end

return ISceneCfgFinder
