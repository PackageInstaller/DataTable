-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleGroupEventCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleGroupEventCommand", package.seeall)

local BattleGroupEventCommand = class("BattleGroupEventCommand", BattleCommandBase)

function BattleGroupEventCommand:parseServerCommand(cmdParser, groupEventNO)
	local enitity2DamageEvent = BattleTableUtil.getTempList()
	local events = groupEventNO.events
	local firstDamageEventNO = false

	for _, event in ipairs(events) do
		if event:HasField("damaged") then
			local entityId = event.damaged.entity

			if not enitity2DamageEvent[entityId] then
				enitity2DamageEvent[entityId] = event.damaged
			else
				local DamagedEventNO = enitity2DamageEvent[entityId]

				DamagedEventNO.damageValue = DamagedEventNO.damageValue + event.damaged.damageValue
				DamagedEventNO.weakPointDamage = DamagedEventNO.weakPointDamage + event.damaged.weakPointDamage
				DamagedEventNO.hpDecrement = DamagedEventNO.hpDecrement + event.damaged.hpDecrement
				DamagedEventNO.hpDecrementOverflow = DamagedEventNO.hpDecrementOverflow + event.damaged.hpDecrementOverflow
			end

			if not firstDamageEventNO then
				firstDamageEventNO = event
			end
		else
			BattleCuredCommand:parseServerCommand(cmdParser, event.cured)
		end
	end

	if firstDamageEventNO then
		local sequence = BattleParallelCommand:createInstance()

		cmdParser:pushCmdContainer(sequence)

		for _, damaged in pairs(enitity2DamageEvent) do
			BattleDamagedCommand:parseServerCommand(cmdParser, damaged)
		end

		cmdParser:popCmdContainer()

		local damagedEventNO = firstDamageEventNO.damaged
		local cmd = BattleGroupEventCommand:createInstance()

		cmd:setSkillEntityId(damagedEventNO.skillEntity)
		cmd:setSkillId(damagedEventNO.skill)
		cmd:setCenterUnionIndex(BoardIndexConverter.cellNOToUnionIndex(groupEventNO.center))
		cmd:setDirection(groupEventNO.direction.x, groupEventNO.direction.z)
		cmd:setEffectCommand(sequence)
		cmdParser:addCommand(cmd)
	end

	BattleTableUtil.releaseTempList(enitity2DamageEvent)
end

function BattleGroupEventCommand:onInit()
	self._skillId = false
	self._centerUnionIndex = false
	self._direction = Coordinates:createInstance()
	self._effectCommand = false
	self._isTriggered = false
	self._remainTaskCount = false
end

function BattleGroupEventCommand:onClear()
	if self._effectCommand then
		self._effectCommand:safeInterrupt()

		self._effectCommand = false
	end

	self._skillId = false
	self._centerUnionIndex = false
	self._isTriggered = false
	self._remainTaskCount = false

	self._direction:setXZ(0, 0)
end

function BattleGroupEventCommand:execute(battleFlow, runningContext)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._skillId)
	local animType = skillCOWrapper and skillCOWrapper:getPerformanceAnimType(BattleEnum.SkillStatus.Normal)

	if animType ~= BattleEnum.AnimStateType.GroupHitEffectCode then
		self._isTriggered = false
		self._remainTaskCount = 1

		self:_onPlayTriggerEffects()

		return
	end

	self._isTriggered = false
	self._remainTaskCount = 1

	local hitEffectCode = skillCOWrapper:getSpecialAttackedCode(BattleEnum.SkillStatus.Normal)
	local effectPlayer = BattleMgr.instance:getEffectPlayer()
	local effectUnit = effectPlayer:playEffect(hitEffectCode, false, EffectTimelineUnit)
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local x, y, z = boardMgr:getCellPositionXYZ(self._centerUnionIndex)

	effectUnit.transform:setPositionXYZ(x, y, z)
	effectUnit.listener:setTimelineEventListener(self._playDividedHitBubble, self)
end

function BattleGroupEventCommand:toString()
	return string.format("[group event command skillEntityId = %s, skillId = %s, centerUnionIndex = %s, direction = (%s, %s)]", self._skillEntityId, self._skillId, self._centerUnionIndex, self._direction:getXZ())
end

function BattleGroupEventCommand:onCommandFinish(cmd, success)
	self._effectCommand = false

	self:_onTimelineTaskFinish()
end

function BattleGroupEventCommand:_playDividedHitBubble(eventName, weight)
	if eventName == BattleTimelineEventName.AttackPoint then
		self:_onPlayTriggerEffects()
	end
end

function BattleGroupEventCommand:_onPlayTriggerEffects()
	if not self._effectCommand then
		self:_onTimelineTaskFinish()

		return
	end

	if self._isTriggered then
		return
	end

	self._isTriggered = true

	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:executeCommand(self._effectCommand, self)
end

function BattleGroupEventCommand:_onTimelineTaskFinish()
	self._remainTaskCount = self._remainTaskCount - 1

	if self._remainTaskCount <= 0 then
		self:finish(true)
	end
end

function BattleGroupEventCommand:setSkillEntityId(skillEntityId)
	self._skillEntityId = skillEntityId

	return self
end

function BattleGroupEventCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

function BattleGroupEventCommand:setCenterUnionIndex(centerUnionIndex)
	self._centerUnionIndex = centerUnionIndex

	return self
end

function BattleGroupEventCommand:setDirection(x, z)
	self._direction:setXZ(x, z)

	return self
end

function BattleGroupEventCommand:setEffectCommand(effectCommand)
	self._effectCommand = effectCommand

	return self
end

return BattleGroupEventCommand
