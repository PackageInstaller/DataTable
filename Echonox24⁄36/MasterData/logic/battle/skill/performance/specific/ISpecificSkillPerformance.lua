-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/specific/ISpecificSkillPerformance.lua

module("logic.battle.skill.performance.specific.ISpecificSkillPerformance", package.seeall)

local ISpecificSkillPerformance = class("ISpecificSkillPerformance", AbstractGlobalReusable)

function ISpecificSkillPerformance:setVisible(visible)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

function ISpecificSkillPerformance:doPreprocessSkill(skillVSInfo, callback, callbackSelf)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

function ISpecificSkillPerformance:bindEntityAndSkill(entityId, skillId)
	self._ownerEntityId = entityId
	self._ownerSkillId = skillId
end

function ISpecificSkillPerformance:checkEntityAndSkill(entityId, skillId)
	return self._ownerEntityId == entityId and self._ownerSkillId == skillId
end

return ISpecificSkillPerformance
