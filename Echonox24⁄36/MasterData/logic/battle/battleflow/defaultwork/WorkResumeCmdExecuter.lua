-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkResumeCmdExecuter.lua

module("logic.battle.battleflow.defaultwork.WorkResumeCmdExecuter", package.seeall)

local WorkResumeCmdExecuter = class("WorkResumeCmdExecuter", WorkBase)

function WorkResumeCmdExecuter:onEnter(context)
	if BattleLog.enableLog then
		BattleLog.log("WorkResumeCmdExecuter resume CmdExecuter")
	end

	BattleMgr.instance:internalPause(false)
	self:onDone(WorkResult.Succeed)
end

return WorkResumeCmdExecuter
