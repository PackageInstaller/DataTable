-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/impl/BattleUnitBase.lua

module("logic.battle.unit.impl.BattleUnitBase", package.seeall)

local BattleUnitBase = class("BattleUnitBase", ReusableUnitBase)
local kOnInitFinishFuncName = "onInitFinish"
local kOnBeforeResetFuncName = "onBeforeReset"

function BattleUnitBase:getUnitType()
	return BattleEnum.UnitType.Unknown
end

function BattleUnitBase:isPerson()
	return false
end

function BattleUnitBase:setActive(isActive)
	goutil.setActive(self.go, isActive)
end

function BattleUnitBase:isActive()
	return self.go.activeSelf
end

function BattleUnitBase:dispatchCompInitFinish()
	self:_executeCompFunc(kOnInitFinishFuncName)
end

function BattleUnitBase:setTimeScale(timeScale)
	self:_executeCompFunc(BattleFunctionName.onUpdateTimeScale, timeScale)
end

function BattleUnitBase:returnSelf()
	self:_executeCompFunc(kOnBeforeResetFuncName)
	BattleUnitBase.super.returnSelf(self)
end

return BattleUnitBase
