local var_0_0 = class("MetaRepairItem", import("..BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.ship_meta_repair
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
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

function var_0_0.getItemId(arg_3_0)
	return arg_3_0.itemId
end

function var_0_0.getTotalCnt(arg_4_0)
	return arg_4_0.totalCnt or 0
end

function var_0_0.getRepairExp(arg_5_0)
	return arg_5_0.repairExp
end

function var_0_0.getAdditionValue(arg_6_0)
	return arg_6_0.addition.value
end

return var_0_0
