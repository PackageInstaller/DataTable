-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/ISkillAttackPointHandler.lua

module("logic.battle.skill.attackpoint.ISkillAttackPointHandler", package.seeall)

local ISkillAttackPointHandler = class("ISkillAttackPointHandler")

function ISkillAttackPointHandler:build(context)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

function ISkillAttackPointHandler:clear(context)
	return
end

function ISkillAttackPointHandler:handleAttackPoint(context, weight)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

function ISkillAttackPointHandler:toString()
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

function ISkillAttackPointHandler:collectEntityIds(entityIdList)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

function ISkillAttackPointHandler:collectRefEntityIds(entityIdList)
	return
end

function ISkillAttackPointHandler:handleLastAttackPoint(context)
	return
end

return ISkillAttackPointHandler
