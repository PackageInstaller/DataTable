-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/path/PathFinderBase.lua

module("frameworkext.scene.path.PathFinderBase", package.seeall)

local PathFinderBase = class("PathFinderBase", SceneComponentBase)

function PathFinderBase:ctor(scene)
	PathFinderBase.super.ctor(self, scene)
end

return PathFinderBase
