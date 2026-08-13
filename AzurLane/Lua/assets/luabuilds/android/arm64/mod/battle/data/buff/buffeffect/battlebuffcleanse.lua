ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffCleanse", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffCleanse = var_0_1
var_0_1.__name = "BattleBuffCleanse"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._buffIDList = arg_2_0._tempData.arg_list.buff_id_list
	arg_2_0._check_target = arg_2_0._tempData.arg_list.check_target

	local var_2_0

	if not arg_2_0._tempData.arg_list.minTargetNumber then
		var_2_0 = 0
	end

	arg_2_0._minTargetNumber = var_2_0

	local var_2_1

	if not arg_2_0._tempData.arg_list.maxTargetNumber then
		var_2_1 = 10000
	end

	arg_2_0._maxTargetNumber = var_2_1

	return
end

function var_0_1.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	var_0_1.super.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)

	if arg_3_0._check_target then
		if #arg_3_0:getTargetList(arg_3_1, arg_3_0._check_target, arg_3_0._tempData.arg_list, arg_3_3) >= arg_3_0._minTargetNumber and var_5 <= arg_3_0._maxTargetNumber then
			ipairs = var_6

			for iter_3_0, iter_3_1 in var_6(arg_3_0._buffIDList) do
				arg_3_1:RemoveBuff(iter_3_1)
			end
		end
	else
		ipairs = var_4

		for iter_3_2, iter_3_3 in var_4(arg_3_0._buffIDList) do
			arg_3_1:RemoveBuff(iter_3_3)
		end
	end

	return
end

return
