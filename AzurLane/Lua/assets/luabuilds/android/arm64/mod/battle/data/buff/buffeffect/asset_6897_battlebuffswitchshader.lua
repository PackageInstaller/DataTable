ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffSwitchShader = var_0_10002("BattleBuffSwitchShader", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffSwitchShader.__name = "BattleBuffSwitchShader"

local var_0_2 = var_0.Battle.BattleBuffSwitchShader

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._shader = arg_2_0._tempData.arg_list.shader

	local var_2_0

	if not arg_2_0._tempData.arg_list.invisible then
		var_2_0 = 0.7
	end

	arg_2_0._invisible = var_2_0

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		invisible = arg_3_0._invisible
	}

	arg_3_1:SwitchShader(arg_3_0._shader, nil, var_3_0)

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_1:SwitchShader("COLORED_ALPHA")

	return
end

return
