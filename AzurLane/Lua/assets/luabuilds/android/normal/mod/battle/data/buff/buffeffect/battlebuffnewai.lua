ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffNewAI = var_0_10002("BattleBuffNewAI", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffNewAI.__name = "BattleBuffNewAI"

function var_0.Battle.BattleBuffNewAI.Ctor(arg_1_0, arg_1_1)
	var_0.Battle.BattleBuffNewAI.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0.Battle.BattleBuffNewAI.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._AIOnAttach = arg_2_0._tempData.arg_list.ai_onAttach
	arg_2_0._AIOnRemove = arg_2_0._tempData.arg_list.ai_onRemove

	return
end

function var_0.Battle.BattleBuffNewAI.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._AIOnAttach then
		arg_3_1:SetAI(arg_3_0._AIOnAttach)
	end

	return
end

function var_0.Battle.BattleBuffNewAI.onRemove(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._AIOnRemove then
		arg_4_1:SetAI(arg_4_0._AIOnRemove)
	end

	return
end

return
