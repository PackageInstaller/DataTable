-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/impl/DummyLevelBattleFlow.lua

module("logic.battle.battleflow.impl.DummyLevelBattleFlow", package.seeall)

local DummyLevelBattleFlow = class("DummyLevelBattleFlow", LevelBattleFlowBase)

function DummyLevelBattleFlow:_registerComponents()
	DummyLevelBattleFlow.super._registerComponents(self)
	self:_removeComponent("starConditionNotify")
end

function DummyLevelBattleFlow:handleEnterBattle()
	SceneFace.instance:exitScene()
	ViewMgr.instance:close(ViewName.MainUIView)
	ViewMgr.instance:close(ViewName.HackToolView)

	BattleTestUtil.isTest = true
end

function DummyLevelBattleFlow:handleExitBattleFinish()
	ViewMgr.instance:open(ViewName.HackToolView)
	ViewMgr.instance:open(ViewName.MainUIView)
	SceneFace.instance:enterRoomScene(true, true)
end

function DummyLevelBattleFlow:buildBattleFieldInfo(battleInfoNO)
	BattleTestUtil.TestBattleLevelCode = 0

	return DummyLevelBattleFlow.super.buildBattleFieldInfo(self, battleInfoNO)
end

function DummyLevelBattleFlow:createBeforeStartBattleWork()
	return false
end

function DummyLevelBattleFlow:createCalculateWork()
	return false
end

function DummyLevelBattleFlow:isSupportRestart()
	return true
end

function DummyLevelBattleFlow:userRequestRestart(restartType)
	self:restart(restartType)
end

function DummyLevelBattleFlow:sendRestartRequest()
	BattleTestUtil.TestBattleLevelCode = self._battleLevelCode

	BattleTestUtil.requestDummyBattleLevel(self._battleLevelCode)
end

return DummyLevelBattleFlow
