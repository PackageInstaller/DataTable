-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/flow/PrefaceBattleWorkStartBattle.lua

module("logic.extensions.preface.flow.PrefaceBattleWorkStartBattle", package.seeall)

local M = class("PrefaceBattleWorkStartBattle", WorkBase)

function M:onEnter(context)
	self.context = context

	local dungeonCode = context.model:getDungeonCode()

	BattleDispatcher:addEventListener(BattleEventType.OnBattleExitFinish, self._onBattleFinish, self)
	DungeonAgent.instance:sendStartDungeonRequest(dungeonCode, 1, false, BattleEnum.GamePlayType.NORMAL)
	DungeonModel.instance:setLastEnterDungeonCode(dungeonCode)
end

function M:onExit(isInterrupt)
	BattleDispatcher:removeEventListener(BattleEventType.OnBattleExitFinish, self._onBattleFinish, self)
end

function M:_onBattleFinish(e, snapshotInfo)
	self.context.model:setBattleIsWin(snapshotInfo:isWin())

	if snapshotInfo:isWin() then
		DungeonModel.instance:deleteLocalStorageEnterDungeon(self.context.model:getDungeonCode())
	end

	BattleDispatcher:removeEventListener(BattleEventType.OnBattleExitFinish, self._onBattleFinish, self)
	self:onDone(WorkResult.Succeed)
end

return M
