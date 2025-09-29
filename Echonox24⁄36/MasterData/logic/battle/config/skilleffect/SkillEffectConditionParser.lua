-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/skilleffect/SkillEffectConditionParser.lua

module("logic.battle.config.skilleffect.SkillEffectConditionParser", package.seeall)

local SkillEffectConditionParser = class("SkillEffectConditionParser")
local programmingParser = {}

function SkillEffectConditionParser:ctor()
	self._buffCodes = {}
end

function SkillEffectConditionParser:clear()
	BattleTableUtil.clearTable(self._buffCodes)
end

function SkillEffectConditionParser:getBuffCodes()
	return self._buffCodes
end

function SkillEffectConditionParser:parseParams(condition)
	local conditionCode = condition.code
	local conditionCO = ActiveSkillConfig.instance:getSkillEffectConditionCO(conditionCode)
	local programmingArray = string.split(conditionCO.programming, ActiveSkillCOUtil.DELIMITER02)
	local programmingKey = programmingArray[1]
	local parseFunction = programmingParser[programmingKey]

	if parseFunction then
		parseFunction(self, programmingArray, condition)
	end
end

function programmingParser:ByBuff(programmingArray, condition)
	table.insert(self._buffCodes, condition.buffId)
end

return SkillEffectConditionParser
