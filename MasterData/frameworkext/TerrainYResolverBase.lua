-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/height/TerrainYResolverBase.lua

module("frameworkext.scene.height.TerrainYResolverBase", package.seeall)

local TerrainYResolverBase = class("TerrainYResolverBase")

function TerrainYResolverBase:ctor()
	return
end

function TerrainYResolverBase:resolveY(x, z)
	return 0
end

return TerrainYResolverBase
