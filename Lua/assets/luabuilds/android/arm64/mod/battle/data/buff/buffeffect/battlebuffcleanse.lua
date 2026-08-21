ys = ys or {}

local var_0_0 = class("BattleBuffCleanse", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffCleanse = var_0_0
var_0_0.__name = "BattleBuffCleanse"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._buffIDList = arg_2_0._tempData.arg_list.buff_id_list
	arg_2_0._check_target = arg_2_0._tempData.arg_list.check_target
	arg_2_0._minTargetNumber = arg_2_0._tempData.arg_list.minTargetNumber or 0
	arg_2_0._maxTargetNumber = arg_2_0._tempData.arg_list.maxTargetNumber or 10000

	return
end

function var_0_0.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	var_0_0.super.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)

	if arg_3_0._check_target then
		local var_3_0 = #arg_3_0:getTargetList(arg_3_1, arg_3_0._check_target, arg_3_0._tempData.arg_list, arg_3_3)

		if var_3_0 >= arg_3_0._minTargetNumber and var_3_0 <= arg_3_0._maxTargetNumber then
			for iter_3_0, iter_3_1 in ipairs(arg_3_0._buffIDList) do
				arg_3_1:RemoveBuff(iter_3_1)
			end
		end
	else
		for iter_3_2, iter_3_3 in ipairs(arg_3_0._buffIDList) do
			arg_3_1:RemoveBuff(iter_3_3)
		end
	end

	return
end

return
