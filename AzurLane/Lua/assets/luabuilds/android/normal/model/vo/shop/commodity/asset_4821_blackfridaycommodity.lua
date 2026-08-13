class = var_0_10000

local var_0_0 = "BlackFridayCommodity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewServerCommodity"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.blackfriday_shop_template
end

function var_0_1.GetResType(arg_2_0)
	return arg_2_0:getConfig("resource_type")
end

function var_0_1.GetDiscount(arg_3_0)
	return arg_3_0:getConfig("discount")
end

function var_0_1.GetSalesPrice(arg_4_0)
	return arg_4_0:getConfig("resource_num") - arg_4_0:getConfig("discount")
end

function var_0_1.GetOffPercent(arg_5_0)
	math = var_1_10001

	return var_1_10001.modf(arg_5_0:getConfig("discount") / arg_5_0:getConfig("resource_num") * 100)
end

function var_0_1.GetConsume(arg_6_0)
	Drop = var_1_10001

	return var_1_10001.New({
		type = arg_6_0:getConfig("resource_category"),
		id = arg_6_0:getConfig("resource_type"),
		count = arg_6_0:GetSalesPrice()
	})
end

return var_0_1
