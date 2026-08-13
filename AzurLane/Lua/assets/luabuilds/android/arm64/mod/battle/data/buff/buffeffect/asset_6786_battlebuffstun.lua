ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffStun = var_0_10002("BattleBuffStun", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffStun.__name = "BattleBuffStun"

local var_0_2 = var_0.Battle.BattleBuffStun

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0._tempData.arg_list

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:onTrigger(arg_3_1, arg_3_2)

	return
end

function var_0_2.onUpdate(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:onTrigger(arg_4_1, arg_4_2)

	return
end

function var_0_2.onTrigger(arg_5_0, arg_5_1, arg_5_2)
	var_0_2.super.onTrigger(arg_5_0, arg_5_1, arg_5_2)
	var_0.Battle.BattleAttr.Stun(arg_5_1)
	arg_5_1:UpdateMoveLimit()

	return
end

function var_0_2.onRemove(arg_6_0, arg_6_1, arg_6_2)
	var_0.Battle.BattleAttr.CancelStun(arg_6_1)
	arg_6_1:UpdateMoveLimit()

	return
end

return
