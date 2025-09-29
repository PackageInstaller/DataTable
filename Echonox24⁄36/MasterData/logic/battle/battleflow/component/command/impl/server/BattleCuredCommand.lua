-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleCuredCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleCuredCommand", package.seeall)

local BattleCuredCommand = class("BattleCuredCommand", BattleCommandBase)

function BattleCuredCommand:parseServerCommand(cmdParser, curedEventNO)
	local cmd = BattleCuredCommand:createInstance()

	cmd:setAttackerEntityId(curedEventNO.releaser)
	cmd:setVictimEntityId(curedEventNO.entity)
	cmd:setSkillId(curedEventNO.skill)
	cmd:setCure(curedEventNO.value)
	cmd:setHpIncrement(curedEventNO.hpIncrement)
	cmdParser:addCommand(cmd)
	cmdParser:addCommand(BattleDelayCommand:create(BattleConst.DelayOne))
end

function BattleCuredCommand:onInit()
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = 0
	self._cure = 0
	self._hpIncrement = 0
end

function BattleCuredCommand:onClear()
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = 0
	self._cure = 0
	self._hpIncrement = 0
end

function BattleCuredCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local victim = unitMgr:getUnit(self._victimEntityId)

	if not victim then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("cannot find victim[%s]", self._victimEntityId))
		end

		self:finish(true)

		return
	end

	victim.effectPlayer:playUniqueEffect(BattleConst.CURE)
	victim.bubble:showBubble(BattleEnum.BubbleType.NORMAL_RECOVERY, self._cure, BattleConst.DelayOne)

	local hpCurrent = victim.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP)

	victim.property:setAttribute(BattleExtension_pb.Attribute.CURRENT_HP, hpCurrent + self._hpIncrement)
	victim:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_general_cure)
	BattleCuredCommand:dispatchCuredEvent(self._attackerEntityId, self._victimEntityId, self._cure)
	self:finish(true)
end

function BattleCuredCommand:dispatchCuredEvent(attackerEntityId, victimEntityId, cure)
	BattleDispatcher:dispatchEvent(BattleEventType.OnCured, attackerEntityId, victimEntityId, cure)
end

function BattleCuredCommand:toString()
	return string.format("[cure command attacker = %s,victim = %s,hpIncrement = %s, cure = %s,skillId = %s]", self._attackerEntityId, self._victimEntityId, self._hpIncrement, self._cure, self._skillId)
end

function BattleCuredCommand:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleCuredCommand:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId

	return self
end

function BattleCuredCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

function BattleCuredCommand:setCure(cure)
	self._cure = cure

	return self
end

function BattleCuredCommand:setHpIncrement(hpIncrement)
	self._hpIncrement = hpIncrement

	return self
end

return BattleCuredCommand
