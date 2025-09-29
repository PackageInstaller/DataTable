-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkPauseCmdExecuter.lua

module("logic.battle.battleflow.defaultwork.WorkPauseCmdExecuter", package.seeall)

local WorkPauseCmdExecuter = class("WorkPauseCmdExecuter", WorkBase)

function WorkPauseCmdExecuter:onEnter(context)
	if BattleLog.enableLog then
		BattleLog.log("WorkPauseCmdExecuter pause CmdExecuter")
	end

	BattleMgr.instance:internalPause(true)
	self:onDone(WorkResult.Succeed)
end

return WorkPauseCmdExecuter
