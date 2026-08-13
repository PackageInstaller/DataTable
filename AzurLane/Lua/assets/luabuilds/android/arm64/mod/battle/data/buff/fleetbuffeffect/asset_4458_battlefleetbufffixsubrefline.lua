ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleFleetBuffFixSubRefLine = var_0_10002("BattleFleetBuffFixSubRefLine", var_0.Battle.BattleFleetBuffEffect)
var_0.Battle.BattleFleetBuffFixSubRefLine.__name = "BattleFleetBuffFixSubRefLine"

local var_0_2 = var_0.Battle.BattleFleetBuffFixSubRefLine

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.onAttach(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:FixSubRefLine(arg_2_0._tempData.arg_list.line)

	return
end

function var_0_2.onRemove(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:FixSubRefLine()

	return
end

return
