ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffUnstoppable", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffUnstoppable = var_0_1
var_0_1.__name = "BattleBuffUnstoppable"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.onAttach(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:ActiveUnstoppable(true)

	return
end

function var_0_1.onRemove(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:ActiveUnstoppable(false)

	return
end

return
