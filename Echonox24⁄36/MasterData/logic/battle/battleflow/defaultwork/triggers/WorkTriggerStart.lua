-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/triggers/WorkTriggerStart.lua

module("logic.battle.battleflow.defaultwork.triggers.WorkTriggerStart", package.seeall)

local WorkTriggerStart = class("WorkTriggerStart", WorkBase)

function WorkTriggerStart:onEnter(context)
	context:handleBattleStart()
	self:onDone(WorkResult.Succeed)
end

function WorkTriggerStart:onExit(isInterrupt)
	return
end

return WorkTriggerStart
