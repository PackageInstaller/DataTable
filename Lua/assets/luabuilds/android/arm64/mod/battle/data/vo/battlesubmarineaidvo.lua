ys = ys or {}
ys.Battle.BattleSubmarineAidVO = class("BattleSubmarineAidVO", ys.Battle.BattlePlayerWeaponVO)
ys.Battle.BattleSubmarineAidVO.__name = "BattleSubmarineAidVO"

local var_0_0 = ys.Battle.BattleSubmarineAidVO

ys.Battle.BattleSubmarineAidVO.GCD = ys.Battle.BattleConfig.AirAssistCFG.GCD

function ys.Battle.BattleSubmarineAidVO.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0, var_0_0.GCD)

	return
end

function ys.Battle.BattleSubmarineAidVO.SetUseable(arg_2_0, arg_2_1)
	arg_2_0._useable = arg_2_1
	arg_2_0._current = arg_2_1 and 1 or 0
	arg_2_0._max = 1

	arg_2_0:DispatchOverLoadChange()
	arg_2_0:DispatchCountChange()

	return
end

function ys.Battle.BattleSubmarineAidVO.GetUseable(arg_3_0)
	return arg_3_0._useable
end

function ys.Battle.BattleSubmarineAidVO.IsOverLoad(arg_4_0)
	return arg_4_0._current < arg_4_0._max or arg_4_0._count < 1
end

function ys.Battle.BattleSubmarineAidVO.Cast(arg_5_0)
	arg_5_0._count = arg_5_0._count - 1

	arg_5_0:resetCurrent()
	arg_5_0:DispatchOverLoadChange()
	arg_5_0:DispatchCountChange()

	return
end

return
