-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleMultiRoundAoeUpdateCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleMultiRoundAoeUpdateCommand", package.seeall)

local BattleMultiRoundAoeUpdateCommand = class("BattleMultiRoundAoeUpdateCommand", BattleCommandBase)

function BattleMultiRoundAoeUpdateCommand:parseServerCommand(cmdParser, eventNO)
	local cmd = BattleMultiRoundAoeUpdateCommand:createInstance()

	cmd:setEnitityId(eventNO.aoe.entity)
	cmd:setAoeShape(eventNO.aoe.shape[1])
	cmd:setSkillId(eventNO.aoe.skill)
	cmd:seAoeId(eventNO.aoe.id)
	cmdParser:addCommand(cmd)
end

function BattleMultiRoundAoeUpdateCommand:onInit()
	self._entityId = 0
	self._shapeWithRoot = false
	self._skillId = 0
	self._aoeId = 0
end

function BattleMultiRoundAoeUpdateCommand:onClear()
	self._campId = 0
	self._shapeWithRoot = false
	self._skillId = 0
	self._aoeId = 0
end

function BattleMultiRoundAoeUpdateCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if unit then
		unit.skillAreaWarning:updateSkillArea(self._aoeId, self._shapeWithRoot)
	end

	self:finish(true)
end

function BattleMultiRoundAoeUpdateCommand:toString()
	return string.format("[user cancel ready command campId = %s]", self._campId)
end

function BattleMultiRoundAoeUpdateCommand:setEnitityId(entityId)
	self._entityId = entityId

	return self
end

function BattleMultiRoundAoeUpdateCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

function BattleMultiRoundAoeUpdateCommand:seAoeId(aoeId)
	self._aoeId = aoeId

	return self
end

function BattleMultiRoundAoeUpdateCommand:setAoeShape(shapeWithRoot)
	self._shapeWithRoot = shapeWithRoot

	return self
end

return BattleMultiRoundAoeUpdateCommand
