-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattlePlayerStartedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattlePlayerStartedCommand", package.seeall)

local BattlePlayerStartedCommand = class("BattlePlayerStartedCommand", BattleCommandBase)

function BattlePlayerStartedCommand:parseServerCommand(cmdParser, eventFieldInt32)
	local cmd = BattlePlayerStartedCommand:createInstance()

	cmd:setCampId(eventFieldInt32)
	cmdParser:addCommand(cmd)
	cmdParser:addCommand(BattleDelayCommand:create(0))
end

function BattlePlayerStartedCommand:onInit()
	self._campId = 0
end

function BattlePlayerStartedCommand:onClear()
	self._campId = 0
end

function BattlePlayerStartedCommand:execute(battleFlow)
	local localLogic = battleFlow.localLogic
	local roundReport = battleFlow.roundReport

	localLogic:handlePlayerStarted(self._campId)
	roundReport:playPlayerStartedReport(self._campId, self._onReportFinish, self)
	BattleDispatcher:dispatchEvent(BattleEventType.OnPlayerStarted, self._campId)
end

function BattlePlayerStartedCommand:_onReportFinish()
	self:_checkMultiRoundState()
	self:finish(true)
end

function BattlePlayerStartedCommand:_checkMultiRoundState()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local units = unitMgr:getUnitsByCampId(self._campId)

	for _, unit in pairs(units) do
		local skillId = unit.skillAreaWarning:getSkillId()
		local skillMO = unit.skill:getActiveSkillById(skillId)

		if skillMO then
			if skillMO:isNormalSkill() and unit.property:isStateActive(BattleEnum.State.CANNOT_NORMAL_ATTACK) then
				unit.skillAreaWarning:clearSkillArea()
			elseif not skillMO:isNormalSkill() and unit.property:isStateActive(BattleEnum.State.SILENT) then
				unit.skillAreaWarning:clearSkillArea()
			end
		end
	end
end

function BattlePlayerStartedCommand:toString()
	return string.format("[player started command campId = %s]", self._campId)
end

function BattlePlayerStartedCommand:setCampId(campId)
	self._campId = campId

	return self
end

return BattlePlayerStartedCommand
