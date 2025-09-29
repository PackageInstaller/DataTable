-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleEnterPerformanceCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleEnterPerformanceCommand", package.seeall)

local BattleEnterPerformanceCommand = class("BattleEnterPerformanceCommand", BattleCommandBase)

function BattleEnterPerformanceCommand:parseClientCommand(cmdParser, mainEventNOList, attackerEntityId, victimEntityId, skillId, targetUnionIndex, isStrenthening)
	local cmd = BattleEnterPerformanceCommand:createInstance()

	cmd:setAttackerEntityId(attackerEntityId)
	cmd:setVictimEntityId(victimEntityId)
	cmd:setSkillId(skillId, isStrenthening)
	cmd:setTargetUnionIndex(targetUnionIndex)
	cmd:collectPreloadResPathList(mainEventNOList)
	cmdParser:addCommand(cmd)

	return cmd
end

function BattleEnterPerformanceCommand:onInit()
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = false
	self._targetUnionIndex = false
	self._preloadResPathList = {}
	self._isForceSolo = false
end

function BattleEnterPerformanceCommand:onClear()
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = false
	self._targetUnionIndex = false
	self._isForceSolo = false

	BattleTableUtil.clearTable(self._preloadResPathList)
end

function BattleEnterPerformanceCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local attacker = unitMgr:getUnit(self._attackerEntityId)
	local victim = unitMgr:getUnit(self._victimEntityId)
	local isFriendCamp = BattleCampRelationUtil.isSameOrFriendOfOperateCamp(attacker)
	local isHideUnrelated = SkillPerformanceCOUtil.isHideUnrelated(self._skillId, attacker.skill:getSkillStatus())
	local skillVSInfo = SkillVSInfo:createInstance()

	skillVSInfo:setAttacker(attacker)
	skillVSInfo:setVictim(victim)
	skillVSInfo:setSkillId(self._skillId, self._isStrenthening)
	skillVSInfo:setTargetUnionIndex(self._targetUnionIndex)
	skillVSInfo:setReversePosition(not isFriendCamp)
	skillVSInfo:setForceSolo(self._isForceSolo)
	skillVSInfo:setHideUnrelated(isHideUnrelated)
	skillVSInfo:setPreloadResPathList(self._preloadResPathList)
	SkillPerformanceMgr.instance:beginPerformance(skillVSInfo, self._onBeginPerformanceFinish, self)
	skillVSInfo:returnSelf()
end

function BattleEnterPerformanceCommand:_onBeginPerformanceFinish()
	self:finish(true)
end

function BattleEnterPerformanceCommand:toString()
	return string.format("[enter performace command attackerEntityId = %s,victimEntityId = %s, skillId = %s, targetUnionIndex = %s]", self._attackerEntityId, self._victimEntityId, self._skillId, self._targetUnionIndex)
end

function BattleEnterPerformanceCommand:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleEnterPerformanceCommand:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId

	return self
end

function BattleEnterPerformanceCommand:setSkillId(skillId, isStrenthening)
	self._skillId = skillId
	self._isStrenthening = isStrenthening

	return self
end

function BattleEnterPerformanceCommand:setTargetUnionIndex(targetUnionIndex)
	self._targetUnionIndex = targetUnionIndex

	return self
end

function BattleEnterPerformanceCommand:setIsForceSolo(isSolo)
	self._isForceSolo = isSolo
end

function BattleEnterPerformanceCommand:collectPreloadResPathList(mainEventNOList)
	if not mainEventNOList then
		return
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()

	for _, eventNO in ipairs(mainEventNOList) do
		local skillTriggeredEventNO = eventNO.skillTriggered
		local unit = unitMgr:getUnit(skillTriggeredEventNO.entity)
		local skillId = skillTriggeredEventNO.code
		local isCountered = unit.property:getEntityId() ~= self._attackerEntityId
		local victim = isCountered and unitMgr:getUnit(self._attackerEntityId) or unitMgr:getUnit(self._victimEntityId)
		local isStrengthen = skillTriggeredEventNO.strengthen
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

		if not ActiveSkillCOUtil.isNormal(skillCOWrapper, isStrengthen) and not self._isForceSolo and not SkillPerformanceCOUtil.isSoloPerformance(skillId, isStrengthen) then
			local animState = isCountered and SkillPerformanceConfig.instance:getCounteredSkillAnimState(skillId, isStrengthen) or SkillPerformanceConfig.instance:getMainSkillAnimState(skillId, isStrengthen)

			if not string.nilorempty(animState) then
				local timelineResPath = SkillPerformanceConfig.instance:getSkillPerformanceTimeline(animState, unit.property:getModelCode())

				table.insert(self._preloadResPathList, BattleSkillAssist.get3dEffectSkillUrl(timelineResPath, unit, victim, skillId, isStrengthen))
			end
		end
	end
end

return BattleEnterPerformanceCommand
