-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/SceneNotify.lua

module("frameworkext.scene.SceneNotify", package.seeall)

local SceneNotify = {}

SceneNotify.EnterZone = 1
SceneNotify.ExitZone = 2
SceneNotify.FirstZonesLoaded = 3
SceneNotify.ZoneLoaded = 4
SceneNotify.ZoneDestroyed = 5
SceneNotify.TargetMove = 11
SceneNotify.TargetArrive = 12

return SceneNotify
