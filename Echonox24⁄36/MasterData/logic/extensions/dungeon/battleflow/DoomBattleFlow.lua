-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/DoomBattleFlow.lua

module("logic.extensions.dungeon.battleflow.DoomBattleFlow", package.seeall)

local DoomBattleFlow = class("DoomBattleFlow", DungeonBattleFlowBase)

function DoomBattleFlow:onInit()
	DoomBattleFlow.super.onInit(self)

	self._isTest = false
end

function DoomBattleFlow:_registerComponents()
	DoomBattleFlow.super._registerComponents(self)
	self:_removeComponent("roundReport")
	self:_addComponent("doomLogic", DoomFlowCompLogic)
	self:_addComponent("roundReport", DoomFlowCompRoundReport)
end

function DoomBattleFlow:isSupportRestart()
	return true
end

function DoomBattleFlow:handleEnterBattle()
	DoomBattleFlow.super.handleEnterBattle(self)

	local netEventMgr = self.netEventMgr

	netEventMgr:setCommandClass(BattleCmdUtil.cmd_skillTriggered, DoomBattleSkillTriggeredCommand)

	if self._isTest then
		SceneFace.instance:exitScene()
		ViewMgr.instance:close(ViewName.MainUIView)
		ViewMgr.instance:close(ViewName.HackToolView)

		BattleTestUtil.isTest = true
	end
end

function DoomBattleFlow:createCalculateWork()
	if self._isTest then
		return false
	else
		return DoomBattleFlow.super.createCalculateWork(self)
	end
end

function DoomBattleFlow:createBeforeEndBattleWork()
	if self._isTest then
		return false
	else
		return DoomBattleFlow.super.createBeforeEndBattleWork(self)
	end
end

function DoomBattleFlow:buildBattleFieldInfo(battleInfoNO)
	if BattleTestUtil.TestBattleLevelCode > 0 then
		self._isTest = true
		self._passId = BattleTestUtil.TestBattleLevelCode
		self._battleLevelCode = BattleTestUtil.TestBattleLevelCode
		BattleTestUtil.TestBattleLevelCode = 0

		return BattleNOConverter:convert(battleInfoNO)
	else
		self._isTest = false

		return DoomBattleFlow.super.buildBattleFieldInfo(self, battleInfoNO)
	end
end

function DoomBattleFlow:handleExitBattleFinish()
	if self._isTest then
		ViewMgr.instance:open(ViewName.HackToolView)
		ViewMgr.instance:open(ViewName.MainUIView)
		SceneFace.instance:enterRoomScene(true, true)
	else
		DoomBattleFlow.super.handleExitBattleFinish(self)
	end
end

return DoomBattleFlow
