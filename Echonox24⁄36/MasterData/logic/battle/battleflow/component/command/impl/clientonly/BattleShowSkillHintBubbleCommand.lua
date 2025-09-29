-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleShowSkillHintBubbleCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleShowSkillHintBubbleCommand", package.seeall)

local BattleShowSkillHintBubbleCommand = class("BattleShowSkillHintBubbleCommand", BattleCommandBase)

function BattleShowSkillHintBubbleCommand:create(entityId, skillId)
	local cmd = BattleShowSkillHintBubbleCommand:createInstance()

	cmd:setEntityId(entityId)
	cmd:setSkillId(skillId)

	return cmd
end

function BattleShowSkillHintBubbleCommand:onInit()
	self._entityId = false
	self._skillId = false
end

function BattleShowSkillHintBubbleCommand:onClear()
	self._entityId = false
	self._skillId = false
end

function BattleShowSkillHintBubbleCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)
	local bubbleSkillId = BattleUnitUtil.getPerformSkillId(unit, self._skillId)

	unit.bubble:showBubble(BattleEnum.BubbleType.SKILL_TRIGGER_HINT, bubbleSkillId, BattleConst.DelayOne)
	self:finish(true)
end

function BattleShowSkillHintBubbleCommand:toString()
	return string.format("[show skill hint bubble command entityId = %s, skillId = %s]", self._entityId, self._skillId)
end

function BattleShowSkillHintBubbleCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleShowSkillHintBubbleCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

return BattleShowSkillHintBubbleCommand
