ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffCancelBuff", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffCancelBuff = var_0_1
var_0_1.__name = "BattleBuffCancelBuff"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._buff_id = arg_2_0._tempData.arg_list.buff_id

	local var_2_0

	if not arg_2_0._tempData.arg_list.count then
		var_2_0 = 31
	end

	arg_2_0._count = var_2_0
	arg_2_0._delay = arg_2_0._tempData.arg_list.delay

	return
end

function var_0_1.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = var_0_1.super.onTrigger
	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_1
	local var_3_3 = arg_3_2

	attach = var_1_10009

	var_3_0(var_3_1, var_3_2, var_3_3, var_1_10009)

	arg_3_0._count = arg_3_0._count - 1

	if arg_3_0._count <= 0 then
		arg_3_2:SetToCancel(arg_3_0._delay)
	end

	return
end

return
