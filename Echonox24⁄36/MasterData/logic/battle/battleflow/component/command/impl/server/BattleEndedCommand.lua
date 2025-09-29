-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleEndedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleEndedCommand", package.seeall)

local BattleEndedCommand = class("BattleEndedCommand", BattleTimingCommandBase)

function BattleEndedCommand:parseServerCommand(cmdParser, battleEndedEventNO)
	local cmd = BattleEndedCommand:createInstance()

	cmd:setWinnerCampIds(battleEndedEventNO.winner)
	cmd:setLoserCampIds(battleEndedEventNO.loser)
	cmd:setRealEnd(battleEndedEventNO.realEnd)
	cmdParser:addCommand(cmd)
end

function BattleEndedCommand:onInit()
	self._winnerCampIds = false
	self._loserCampIds = false
	self._isRealEnd = false
end

function BattleEndedCommand:onClear()
	self._winnerCampIds = false
	self._loserCampIds = false
	self._isRealEnd = false

	BattleDispatcher:removeEventListener(BattleEventType.OnBattleDeadAnimDone, self._onDeadAnimDone, self)
end

function BattleEndedCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr

	if not unitMgr:isDeadPerformanceEmpty() then
		self:startTimer(BattleConst.DelayThree)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleDeadAnimDone, self._onDeadAnimDone, self)
	else
		self:_execute(battleFlow)
	end
end

function BattleEndedCommand:_onTimerDone()
	if self:isDestroyed() then
		return
	end
end

function BattleEndedCommand:_onDeadAnimDone()
	if self:isDestroyed() then
		return
	end

	BattleDispatcher:removeEventListener(BattleEventType.OnBattleDeadAnimDone, self._onDeadAnimDone, self)
	self:startTimer(0)
end

function BattleEndedCommand:_internalOnTimerDone()
	if self:isDestroyed() then
		return
	end

	self:_execute(BattleMgr.instance:getActiveBattleFlow())
end

function BattleEndedCommand:_execute(battleFlow)
	local model = battleFlow.model
	local resultMO = model:getResultMO()

	resultMO:setWinnerCampIds(self._winnerCampIds)
	resultMO:setLoserCampIds(self._loserCampIds)
	resultMO:setRealEnd(self._isRealEnd)
	BattleBossPropertyFacade.instance:setUnit(false)

	if resultMO:isRealEnd() then
		local isWin = model:isWin()

		BattleDispatcher:dispatchEvent(BattleEventType.OnBattleFinish, isWin)
	else
		battleFlow.model:setAiMode(BattleExtension_pb.AiMode.NONE)
		battleFlow.settingModel:setAutoBattle(false)
		BattleDispatcher:dispatchEvent(BattleEventType.OnBattleNotCompleteFinish)
	end

	self:finish(true)
end

function BattleEndedCommand:toString()
	return string.format("[battle end command winnerCampIds = %s,loserCampIds = %s, realEnd = %s]", BattleTableUtil.arrayToString(self._winnerCampIds), BattleTableUtil.arrayToString(self._loserCampIds), self._isRealEnd)
end

function BattleEndedCommand:setWinnerCampIds(campIds)
	self._winnerCampIds = self._winnerCampIds or {}

	table.insertto(self._winnerCampIds, campIds)

	return self
end

function BattleEndedCommand:setLoserCampIds(campIds)
	self._loserCampIds = self._loserCampIds or {}

	table.insertto(self._loserCampIds, campIds)

	return self
end

function BattleEndedCommand:setRealEnd(realEnd)
	self._isRealEnd = realEnd

	return self
end

return BattleEndedCommand
