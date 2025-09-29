-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/AdditionalTerrainCOUtil.lua

module("logic.battle.config.AdditionalTerrainCOUtil", package.seeall)

local AdditionalTerrainCOUtil = {}

function AdditionalTerrainCOUtil.isGroupTerrain(additionalTerrainCO)
	return additionalTerrainCO.isGroupTerrain ~= BattleEnum.AdditionalTerrainGroup.None
end

function AdditionalTerrainCOUtil.isDecorativeTerrain(additionalTerrainCO)
	return additionalTerrainCO.effect == 3
end

return AdditionalTerrainCOUtil
