-- chunkname: @IQIGame\\UIExternalApi\\TerrainApi.lua

TerrainApi = BaseLangApi:Extend()

function TerrainApi:GetTerrainByType(type)
	local terrain = CfgTerrainTable[type]

	if terrain == nil then
		logError("Terrain表找不到id={0}的项", type)

		return
	end

	return terrain
end

function TerrainApi:GetLowestNotPassedLevelTips(level)
	return string.format(self:GetCfgText(2100000), level)
end

function TerrainApi:GetTipsImgPath(type)
	return UIGlobalApi.GetImagePath(TerrainApi:GetTerrainByType(type).TipsTerrainImg)
end

function TerrainApi:GetSmallImgPath(type)
	return UIGlobalApi.GetImagePath(TerrainApi:GetTerrainByType(type).SmallTerrainImg)
end

function TerrainApi:GetBuffIconUrl(iconName)
	return string.format(self:GetResUrl(1100028), iconName)
end
