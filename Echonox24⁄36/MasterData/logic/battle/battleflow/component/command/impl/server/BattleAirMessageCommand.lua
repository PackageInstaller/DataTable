-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleAirMessageCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleAirMessageCommand", package.seeall)

local BattleAirMessageCommand = class("BattleAirMessageCommand", BattleCommandBase)

function BattleAirMessageCommand:parseServerCommand(cmdParser, airMessageNOList)
	for i, airMessageNO in ipairs(airMessageNOList) do
		local cmd = BattleAirMessageCommand:createInstance()

		cmd:setTriggerType(airMessageNO.type)
		cmd:setMsgContent(airMessageNO.msg)
		cmd:setUnionIndex(airMessageNO.pos.x, airMessageNO.pos.z)
		cmdParser:addCommand(cmd)
	end
end

function BattleAirMessageCommand:setTriggerType(type)
	self._triggerType = type
end

function BattleAirMessageCommand:setMsgContent(msg)
	self._msgMO = LeaveMsgMO.New(msg)
end

function BattleAirMessageCommand:setUnionIndex(x, z)
	self._unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)
end

function BattleAirMessageCommand:onInit()
	self:onClear()
end

function BattleAirMessageCommand:onClear()
	self._triggerType = false
	self._msgMO = false
	self._unionIndex = false
end

function BattleAirMessageCommand:execute(battleFlow, runningContext)
	if not OOPUtil.isInstanceOf(battleFlow, AirLevelBattleFlow) then
		self:finish(true)

		return
	end

	if self._triggerType == GameEnum.AirStudioMsgTimeUseTypeEnum.Hero then
		local unit = battleFlow.unitMgr:getUnitOnUnionIndex(self._unionIndex)

		if unit and unit:getUnitType() == BattleEnum.UnitType.Person then
			battleFlow.messageMgr:addMessageUnit(self._msgMO, unit)
			self:finish(true)

			return
		end
	else
		local unit = battleFlow.buildingMgr:getMessageUnitOnUnionIndex(self._unionIndex)

		if unit then
			battleFlow.messageMgr:addMessageUnit(self._msgMO, unit)
			self:finish(true)

			return
		end
	end

	battleFlow.messageMgr:addMessageUnit(self._msgMO, nil, self._unionIndex)
	self:finish(true)
end

function BattleAirMessageCommand:toString()
	return string.format("[BattleAirMessageCommand type = %s, unionIndex = %s]", self._triggerType, self._unionIndex)
end

return BattleAirMessageCommand
