-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/special/BattleUnitCompSpecialHandler_120129.lua

module("logic.battle.unit.comp.special.BattleUnitCompSpecialHandler_120129", package.seeall)

local M = class("BattleUnitCompSpecialHandler_120129", BattleUnitCompSpecialHandler_120128)

function M:handleDie(deadType, isSanityDeadth)
	local unit = self:_getBodyUnit()

	unit.specialHandler:handleLinkedUnitDie(false)
	self._unit.dieHandler:removeUnitFromScene()
end

function M:handleBorn()
	local unit = self:_getBodyUnit()

	unit.specialHandler:handleLinkedUnitBorn(false)
end

function M:_updateFollowRoot()
	local goInst = self._unit.meshModel:getInst()

	if not goInst then
		return
	end

	self._unit.uiFollow:setMainGameObject(goutil.findChild(goInst, "rhand"))
end

return M
