-- chunkname: @IQIGame\\UIExternalApi\\GameChapterApi.lua

GameChapterApi = BaseLangApi:Extend()

function GameChapterApi:GetMapImg(mapType)
	if mapType < 10 then
		return UIGlobalApi.GetImagePath(string.format("/Level/Map/Fight_Terrain_00%s.png", mapType))
	else
		return UIGlobalApi.GetImagePath(string.format("/Level/Map/Fight_Terrain_0%s.png", mapType))
	end
end

function GameChapterApi:GetMapTypeText(mapType)
	if mapType == Constant.MapType.TYPE_NORMAL then
		return self:GetCfgText(111003)
	elseif mapType == Constant.MapType.TYPE_VOLCANO then
		return self:GetCfgText(111004)
	elseif mapType == Constant.MapType.TYPE_SWAMP then
		return self:GetCfgText(111005)
	end
end

function GameChapterApi:GetSkillDescValue(str)
	return self:SkillValueColor(str, 2)
end
