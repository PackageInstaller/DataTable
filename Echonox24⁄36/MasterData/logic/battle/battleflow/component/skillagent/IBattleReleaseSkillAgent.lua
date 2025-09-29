-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/skillagent/IBattleReleaseSkillAgent.lua

module("logic.battle.battleflow.component.skillagent.IBattleReleaseSkillAgent", package.seeall)

local IBattleReleaseSkillAgent = class("IBattleReleaseSkillAgent")

function IBattleReleaseSkillAgent:isValidSkillTarget(unit, targetUnionIndex, skillId)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

function IBattleReleaseSkillAgent:requestAttack(releaseSkillContext)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

function IBattleReleaseSkillAgent:requestForecast(releaseSkillContext)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

return IBattleReleaseSkillAgent
