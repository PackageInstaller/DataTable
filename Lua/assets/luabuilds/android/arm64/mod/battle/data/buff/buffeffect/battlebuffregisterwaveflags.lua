ys = ys or {}

local var_0_0 = ys
local var_0_1 = class("BattleBuffRegisterWaveFlags", ys.Battle.BattleBuffEffect)

var_0_1.__name = "BattleBuffRegisterWaveFlags"
ys.Battle.BattleBuffRegisterWaveFlags = var_0_1

function var_0_1.SetArgs(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._flags = arg_1_0._tempData.arg_list.flags

	return
end

function var_0_1.onTrigger(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.onTrigger(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	local var_2_0 = var_0_0.Battle.BattleDataProxy.GetInstance()

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._flags) do
		var_2_0:AddWaveFlag(iter_2_1)
	end

	return
end

return
