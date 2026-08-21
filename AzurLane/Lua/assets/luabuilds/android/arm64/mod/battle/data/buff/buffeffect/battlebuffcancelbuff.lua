ys = ys or {}

local var_0_0 = class("BattleBuffCancelBuff", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffCancelBuff = var_0_0
var_0_0.__name = "BattleBuffCancelBuff"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._buff_id = arg_2_0._tempData.arg_list.buff_id
	arg_2_0._count = arg_2_0._tempData.arg_list.count or 31
	arg_2_0._delay = arg_2_0._tempData.arg_list.delay

	return
end

function var_0_0.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	var_0_0.super.onTrigger(arg_3_0, arg_3_1, arg_3_2, attach)

	arg_3_0._count = arg_3_0._count - 1

	if arg_3_0._count <= 0 then
		arg_3_2:SetToCancel(arg_3_0._delay)
	end

	return
end

return
