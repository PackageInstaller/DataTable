-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/redo/BattleMultiRoundAoeRedoCommand.lua

module("logic.battle.battleflow.component.command.impl.redo.BattleMultiRoundAoeRedoCommand", package.seeall)

local BattleMultiRoundAoeRedoCommand = class("BattleMultiRoundAoeRedoCommand", BattleCommandBase)

function BattleMultiRoundAoeRedoCommand:parseServerRedoCommand(cmdParser, multiRoundAoeNO)
	local cmd = BattleMultiRoundAoeRedoCommand:createInstance()

	cmd:setEntityId(multiRoundAoeNO.entity)
	cmd:setSkillId(multiRoundAoeNO.skill)
	cmd:setSkillStatus(multiRoundAoeNO.strengthening and BattleEnum.SkillStatus.Strenthening or BattleEnum.SkillStatus.Normal)
	cmd:setTargetEntityId(multiRoundAoeNO.targetEntity)
	cmd:setTargetUnionIndex(BoardIndexConverter.cellNOToUnionIndex(multiRoundAoeNO.targetCell))
	cmd:setAOEId(multiRoundAoeNO.id)
	cmd:setShapeWithRoot(multiRoundAoeNO.shape[1])
	cmd:setMultiRoundHold(multiRoundAoeNO.MultiEntityHold)
	cmdParser:addCommand(cmd)
end

function BattleMultiRoundAoeRedoCommand:onInit()
	self._aoeId = false
	self._entityId = false
	self._skillId = false
	self._skillStatus = false
	self._targetEntityId = false
	self._targetUnionIndex = false
	self._shapeWithRoot = false
	self._holdEntityAndTimeline = {}
end

function BattleMultiRoundAoeRedoCommand:onClear()
	self._aoeId = false
	self._entityId = false
	self._skillId = false
	self._skillStatus = false
	self._targetEntityId = false
	self._targetUnionIndex = false
	self._shapeWithRoot = false

	BattleTableUtil.clearTable(self._holdEntityAndTimeline)
end

function BattleMultiRoundAoeRedoCommand:execute(battleFlow, runningContext)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._skillId)

	if ActiveSkillCOUtil.isReleaseTypeSniping(skillCOWrapper, status) then
		self:_processSnipingSkill()
	elseif ActiveSkillCOUtil.isSkillPurposeMultiRoundAOE(skillCOWrapper, status) then
		self:_processMultiRoundAOE()
	elseif BattleLog.enableError then
		BattleLog.error(string.format("unhandle type skillId = %s", skillId))
	end

	self:finish(true)
end

function BattleMultiRoundAoeRedoCommand:_processSnipingSkill()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)
	local targetUnit = unitMgr:getUnit(self._targetEntityId)
	local animState = BattleEnterSnipingPerformance:getSnipingAnimationName(self._entityId, self._skillId, UnitAnimState.Aim)

	unit.meshModelMover:mapBusinessAnimation(UnitAnimState.Idle, animState)
	unit.meshModelMover:mapBusinessAnimation(UnitAnimState.Idle2, animState)
	unit.meshModelMover:mapBusinessAnimation(UnitAnimState.React, animState)
	unit.meshModelMover:playIdle(true)

	local snipingDrawing = BattleMgr.instance:getSnipingDrawing()

	snipingDrawing:drawSniping(unit, targetUnit)
	BattleEnterSnipingPerformance:drawAOEArea(self._entityId, self._targetEntityId, self._skillId)
end

function BattleMultiRoundAoeRedoCommand:_processMultiRoundAOE()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)
	local targetUnit = unitMgr:getUnit(self._targetEntityId)
	local skillVSInfo = SkillVSInfo:createInstance()

	skillVSInfo:setAttacker(unit)
	skillVSInfo:setVictim(targetUnit)
	skillVSInfo:setSkillId(self._skillId)
	skillVSInfo:setTargetUnionIndex(self._targetUnionIndex)
	skillVSInfo:setMultiRoundHold(self._holdEntityAndTimeline)
	SkillPerformanceMgr.instance:doPreprocessSkill(skillVSInfo)
	skillVSInfo:returnSelf()

	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._skillId)
	local selectableTarget = skillCOWrapper:getSelectableTarget(self._skillStatus)

	if not targetUnit or selectableTarget == BattleEnum.SkillSelectableTarget.POSITION then
		unit.skillAreaWarning:showFixedSkillArea(self._aoeId, self._shapeWithRoot, self._skillId)
	else
		unit.skillAreaWarning:showFollowUnitSkillArea(self._aoeId, self._shapeWithRoot, self._skillId, targetUnit)
	end
end

function BattleMultiRoundAoeRedoCommand:toString()
	return string.format("[redo] [muti round aoe redo command entityId = %s, skillId = %s, skillStatus = %s, aoeId = %s, targetEntityId = %s targetUnionIndex = %s]", self._entityId, self._skillId, self._skillStatus, self._aoeId, self._targetEntityId, self._targetUnionIndex)
end

function BattleMultiRoundAoeRedoCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleMultiRoundAoeRedoCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

function BattleMultiRoundAoeRedoCommand:setSkillStatus(status)
	self._skillStatus = status

	return self
end

function BattleMultiRoundAoeRedoCommand:setTargetUnionIndex(targetUnionIndex)
	self._targetUnionIndex = targetUnionIndex

	return self
end

function BattleMultiRoundAoeRedoCommand:setTargetEntityId(targetEntityId)
	self._targetEntityId = targetEntityId

	return self
end

function BattleMultiRoundAoeRedoCommand:setAOEId(aoeId)
	self._aoeId = aoeId

	return self
end

function BattleMultiRoundAoeRedoCommand:setShapeWithRoot(shapeWithRoot)
	self._shapeWithRoot = shapeWithRoot

	return self
end

function BattleMultiRoundAoeRedoCommand:setMultiRoundHold(multiRoundHold)
	if multiRoundHold then
		for i, entityHoldNO in ipairs(multiRoundHold.entities) do
			self._holdEntityAndTimeline[entityHoldNO.entity] = entityHoldNO.effectTimeline
		end
	end
end

return BattleMultiRoundAoeRedoCommand
