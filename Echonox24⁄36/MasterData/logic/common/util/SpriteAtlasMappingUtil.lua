-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/SpriteAtlasMappingUtil.lua

module("logic.common.util.SpriteAtlasMappingUtil", package.seeall)

local SpriteAtlasMappingUtil = {}

function SpriteAtlasMappingUtil.mappingSpriteAtlas(view, atlasName)
	local mapping = SpriteAtlasMapping.Get(view.mainGO)
	local resPath = IconLoader.getSpriteAtlasUrl(atlasName)
	local resource = view:getRes(resPath)

	if resource then
		mapping:MappingSpriteAtlas(resource:GetAsset(nil, nil))
	end
end

return SpriteAtlasMappingUtil
