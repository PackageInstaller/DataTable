-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleConfigUtil.lua

module("logic.battle.util.BattleConfigUtil", package.seeall)

local BattleConfigUtil = {}
local kMaxTerrainCode = 9999
local kMaxCharacterCode = 9999999

function BattleConfigUtil.isCharacterCode(entityCode)
	return entityCode > kMaxTerrainCode and entityCode < kMaxCharacterCode
end

function BattleConfigUtil.isMonsterCode(entityCode)
	return entityCode > kMaxCharacterCode
end

function BattleConfigUtil.isAdditionalTerrainCode(entityCode)
	return entityCode < kMaxTerrainCode
end

function BattleConfigUtil.getEntityConfig(entityCode, entityType)
	if entityType == BattleEnum.EntityType.Summon then
		return CharacterConfig.instance:getSummonMonsterCO(entityCode)
	elseif BattleConfigUtil.isCharacterCode(entityCode) then
		return CharacterConfig.instance:getCfgInfoByID(entityCode)
	elseif BattleConfigUtil.isAdditionalTerrainCode(entityCode) then
		return TerrainConfig.instance:getAdditionalTerrainCO(entityCode)
	else
		return MonsterConfig.instance:getMonsterCO(entityCode)
	end
end

return BattleConfigUtil
