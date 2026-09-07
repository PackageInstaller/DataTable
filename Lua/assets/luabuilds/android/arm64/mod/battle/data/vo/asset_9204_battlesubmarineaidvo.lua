ys = ys or {}
ys.Battle.BattleSubmarineAidVO = class("BattleSubmarineAidVO", ys.Battle.BattlePlayerWeaponVO)
ys.Battle.BattleSubmarineAidVO.__name = "BattleSubmarineAidVO"

local var_0_0 = ys.Battle.BattleSubmarineAidVO

ys.Battle.BattleSubmarineAidVO.GCD = ys.Battle.BattleConfig.AirAssistCFG.GCD

function ys.Battle.BattleSubmarineAidVO.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0, var_0_0.GCD)

	return
end

function ys.Battle.BattleSubmarineAidVO:SetUseable(arg_2_1)
	self._useable = arg_2_1
	self._current = arg_2_1 and 1 or 0
	self._max = 1

	self:DispatchOverLoadChange()
	self:DispatchCountChange()

	return
end

function ys.Battle.BattleSubmarineAidVO:GetUseable()
	return self._useable
end

function ys.Battle.BattleSubmarineAidVO:IsOverLoad()
	return self._current < self._max or self._count < 1
end

function ys.Battle.BattleSubmarineAidVO:Cast()
	self._count = self._count - 1

	self:resetCurrent()
	self:DispatchOverLoadChange()
	self:DispatchCountChange()

	return
end

return
