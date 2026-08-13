class = var_0_10000

local var_0_0 = "MetaRepairItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.ship_meta_repair
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.itemId = arg_2_0:getConfig("item_id")
	arg_2_0.totalCnt = arg_2_0:getConfig("item_num")
	arg_2_0.repairExp = arg_2_0:getConfig("repair_exp")

	local var_2_0 = arg_2_0:getConfig("effect_attr")

	arg_2_0.addition = {
		attr = var_2_0[1],
		value = var_2_0[2]
	}

	return
end

function var_0_1.getItemId(arg_3_0)
	return arg_3_0.itemId
end

function var_0_1.getTotalCnt(arg_4_0)
	local var_4_0

	if not arg_4_0.totalCnt then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_1.getRepairExp(arg_5_0)
	return arg_5_0.repairExp
end

function var_0_1.getAdditionValue(arg_6_0)
	return arg_6_0.addition.value
end

return var_0_1
