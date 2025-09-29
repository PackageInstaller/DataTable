-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/restart/WorkBattleSetupRestart.lua

module("logic.battle.battleflow.defaultwork.restart.WorkBattleSetupRestart", package.seeall)

local WorkBattleSetupRestart = class("WorkBattleSetupRestart", WorkBase)

function WorkBattleSetupRestart:onEnter(context)
	local snapshotInfo = BattleSnapshotInfo:createInstance()

	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleRestart, snapshotInfo)
	snapshotInfo:returnSelf()
	context.resMgr:cacheResources()
	context:internal_BeforeExit()
	context:internal_ClearForExit(true)
	self:onDone(WorkResult.Succeed)
end

function WorkBattleSetupRestart:onExit(isInterrupt)
	return
end

return WorkBattleSetupRestart
