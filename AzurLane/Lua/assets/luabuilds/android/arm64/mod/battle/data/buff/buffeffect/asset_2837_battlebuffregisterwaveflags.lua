ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffRegisterWaveFlags", var_0.Battle.BattleBuffEffect)

var_0_1.__name = "BattleBuffRegisterWaveFlags"
var_0.Battle.BattleBuffRegisterWaveFlags = var_0_1

function var_0_1.SetArgs(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._flags = arg_1_0._tempData.arg_list.flags

	return
end

function var_0_1.onTrigger(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.onTrigger(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	local var_2_0 = var_0.Battle.BattleDataProxy.GetInstance()

	ipairs = var_1_10005

	for iter_2_0, iter_2_1 in var_1_10005(arg_2_0._flags) do
		var_2_0:AddWaveFlag(iter_2_1)
	end

	return
end

return
