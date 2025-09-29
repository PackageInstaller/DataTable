-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/property/state/BattleState_SnipingMO.lua

module("logic.battle.unit.comp.property.state.BattleState_SnipingMO", package.seeall)

local BattleState_SnipingMO = class("BattleState_SnipingMO", AbstractGlobalReusable)

function BattleState_SnipingMO:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function BattleState_SnipingMO:ctor()
	self._victimEntityId = 0
end

function BattleState_SnipingMO:reset()
	self._victimEntityId = 0
end

function BattleState_SnipingMO:destroy()
	self:reset()
end

function BattleState_SnipingMO:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId
end

function BattleState_SnipingMO:getVictimEntityId()
	return self._victimEntityId
end

return BattleState_SnipingMO
