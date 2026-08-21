ys = ys or {}
ys.Battle.BattleBuffLockHealth = class("BattleBuffLockHealth", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffLockHealth.__name = "BattleBuffLockHealth"

local var_0_0 = ys.Battle.BattleBuffLockHealth

function ys.Battle.BattleBuffLockHealth.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffLockHealth.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._rate = arg_2_0._tempData.arg_list.rate
	arg_2_0._threshold = arg_2_0._tempData.arg_list.value

	return
end

function ys.Battle.BattleBuffLockHealth.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._rate then
		arg_3_0._threshold = math.floor(arg_3_1:GetMaxHP() * arg_3_0._rate)
	end

	return
end

function ys.Battle.BattleBuffLockHealth.onTrigger(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_1:GetCurrentHP()

	if var_4_0 <= arg_4_0._threshold then
		arg_4_3.damage = 0
	elseif var_4_0 - arg_4_3.damage < arg_4_0._threshold then
		arg_4_3.damage = var_4_0 - arg_4_0._threshold
	end

	return
end

return
