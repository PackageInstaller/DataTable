ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffLockHealth = var_0_10002("BattleBuffLockHealth", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffLockHealth.__name = "BattleBuffLockHealth"

local var_0_2 = var_0.Battle.BattleBuffLockHealth

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._rate = arg_2_0._tempData.arg_list.rate
	arg_2_0._threshold = arg_2_0._tempData.arg_list.value

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._rate then
		math = var_3
		arg_3_0._threshold = var_3.floor(arg_3_1:GetMaxHP() * arg_3_0._rate)
	end

	return
end

function var_0_2.onTrigger(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1:GetCurrentHP() <= arg_4_0._threshold then
		arg_4_3.damage = 0
	elseif var_4 - arg_4_3.damage < arg_4_0._threshold then
		arg_4_3.damage = var_4 - arg_4_0._threshold
	end

	return
end

return
