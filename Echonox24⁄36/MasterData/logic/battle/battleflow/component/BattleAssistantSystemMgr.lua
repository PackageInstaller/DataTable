-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleAssistantSystemMgr.lua

module("logic.battle.battleflow.component.BattleAssistantSystemMgr", package.seeall)

local BattleAssistantSystemMgr = class("BattleAssistantSystemMgr", IBattleFlowComp)

function BattleAssistantSystemMgr:onStart()
	self:_setEvent(true)
end

function BattleAssistantSystemMgr:onPreClear()
	BattleTestUtil.isTest = false

	SkillPerformanceMgr.instance:interrupt()
	SkillPerformanceVolumeMgr.instance:clear()
	SkilStrengthenCutInMgr.instance:clear()
end

function BattleAssistantSystemMgr:onClear(isRestart)
	self:_setEvent(false)
end

function BattleAssistantSystemMgr:onUndoReset()
	SkillPerformanceMgr.instance:interrupt()
end

function BattleAssistantSystemMgr:onResourceLoaded()
	SkillPerformanceMgr.instance:init()
	SkillPerformanceVolumeMgr.instance:init()
	SkilStrengthenCutInMgr.instance:init()
	BattleCalculateMgr.instance:setBattleReturnJumpData(false)
end

function BattleAssistantSystemMgr:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.APPLICATION_QUIT, self._onHandleOnApplicationQuit, self)
	else
		GlobalDispatcher:removeEventListener(EventType.APPLICATION_QUIT, self._onHandleOnApplicationQuit, self)
	end
end

function BattleAssistantSystemMgr:startAssistantSystems()
	BattleLog.init()
	BattleReusablePoolMgr.instance:init()
end

function BattleAssistantSystemMgr:clearAfterExit()
	BattleCalculateModel.instance:clear()
	BattleReusablePoolMgr.instance:clear()
	BattleLog.clear()
end

function BattleAssistantSystemMgr:_onHandleOnApplicationQuit()
	BattleLog.clear()
end

return BattleAssistantSystemMgr
