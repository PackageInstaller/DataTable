-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/property/statehandler/BattleStateHandlerUtil.lua

module("logic.battle.unit.comp.property.statehandler.BattleStateHandlerUtil", package.seeall)

local BattleStateHandlerUtil = {}
local kHandlerTable = {
	[BattleEnum.State.STEPPABLE_AGAIN] = BattleStateHandler_SteppableAgain,
	[BattleEnum.State.SNIPING] = BattleStateHandler_Sniping
}

local function getStateHandler(stateName)
	return kHandlerTable[stateName] or false
end

function BattleStateHandlerUtil.handleStateAdded(stateName, unit, runningContext)
	local stateHandler = getStateHandler(stateName)

	if not stateHandler then
		return
	end

	stateHandler:handleStateAdded(unit, runningContext)
end

function BattleStateHandlerUtil.handleStateRemoved(stateName, unit, runningContext)
	local stateHandler = getStateHandler(stateName)

	if not stateHandler then
		return
	end

	stateHandler:handleStateRemoved(unit, runningContext)
end

return BattleStateHandlerUtil
