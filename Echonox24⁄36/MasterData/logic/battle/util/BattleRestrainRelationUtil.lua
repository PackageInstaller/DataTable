-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleRestrainRelationUtil.lua

module("logic.battle.util.BattleRestrainRelationUtil", package.seeall)

local BattleRestrainRelationUtil = {}

function BattleRestrainRelationUtil.getRestrainRelation(unitA, unitB, skillId)
	if not BattleSkillAssist.isDamage(skillId, unitA.skill:getSkillStatus()) then
		return BattleEnum.Restrain.NONE, BattleEnum.Restrain.NONE
	end

	return BattleConfig.instance:getColorRestrainRelation(unitA.property:getColorType(), unitB.property:getColorType())
end

return BattleRestrainRelationUtil
