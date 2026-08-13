ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleSubmarineAidVO = var_0_10003("BattleSubmarineAidVO", var_0.Battle.BattlePlayerWeaponVO)
var_0.Battle.BattleSubmarineAidVO.__name = "BattleSubmarineAidVO"

local var_0_3 = var_0.Battle.BattleSubmarineAidVO

var_0_3.GCD = var_0_1.AirAssistCFG.GCD

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0, var_0_3.GCD)

	return
end

function var_0_3.SetUseable(arg_2_0, arg_2_1)
	arg_2_0._useable = arg_2_1
	arg_2_0._current = arg_2_1 and 1 or 0
	arg_2_0._max = 1

	arg_2_0:DispatchOverLoadChange()
	arg_2_0:DispatchCountChange()

	return
end

function var_0_3.GetUseable(arg_3_0)
	return arg_3_0._useable
end

function var_0_3.IsOverLoad(arg_4_0)
	return arg_4_0._current < arg_4_0._max or arg_4_0._count < 1
end

function var_0_3.Cast(arg_5_0)
	arg_5_0._count = arg_5_0._count - 1

	arg_5_0:resetCurrent()
	arg_5_0:DispatchOverLoadChange()
	arg_5_0:DispatchCountChange()

	return
end

return
