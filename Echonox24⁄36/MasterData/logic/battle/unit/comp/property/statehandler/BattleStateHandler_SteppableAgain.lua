-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/property/statehandler/BattleStateHandler_SteppableAgain.lua

module("logic.battle.unit.comp.property.statehandler.BattleStateHandler_SteppableAgain", package.seeall)

local BattleStateHandler_SteppableAgain = class("BattleStateHandler_SteppableAgain", IBattleStateHandler)

function BattleStateHandler_SteppableAgain:handleStateAdded(unit, runningContext)
	unit.property:inactiveState(BattleEnum.State.STEPPED)
	unit.stateEffect:refreshStateEffect()

	local campOperator = BattleMgr.instance:getCampOperator()

	if campOperator:isOperatableUnit(unit) then
		unit.sign:setOperatableSignVisible(true)
		campOperator:setNextOperateEntityId(unit.property:getEntityId())
	end
end

function BattleStateHandler_SteppableAgain:handleStateRemoved(unit, runningContext)
	return
end

return BattleStateHandler_SteppableAgain
