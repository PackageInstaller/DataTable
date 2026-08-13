ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffAddAircraftAttr = var_0_10002("BattleBuffAddAircraftAttr", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffAddAircraftAttr.__name = "BattleBuffAddAircraftAttr"

local var_0_2 = var_0.Battle.BattleBuffAddAircraftAttr

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._attr = arg_2_0._tempData.arg_list.attr
	arg_2_0._number = arg_2_0._tempData.arg_list.number
	arg_2_0._numberBase = arg_2_0._number

	return
end

function var_0_2.onStack(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._number = arg_3_0._numberBase * arg_3_2._stack

	return
end

function var_0_2.onAircraftCreate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0:equipIndexRequire(arg_4_3.equipIndex) then
		return
	end

	arg_4_0:calcAircraftAttr(arg_4_3.aircraft)

	return
end

function var_0_2.calcAircraftAttr(arg_5_0, arg_5_1)
	var_0.Battle.BattleAttr.Increase(arg_5_1, arg_5_0._attr, arg_5_0._number)

	return
end

return
