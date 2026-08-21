local var_0_0 = class("BlackFridayCommodity", import(".NewServerCommodity"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.blackfriday_shop_template
end

function var_0_0.GetResType(arg_2_0)
	return arg_2_0:getConfig("resource_type")
end

function var_0_0.GetDiscount(arg_3_0)
	return arg_3_0:getConfig("discount")
end

function var_0_0.GetSalesPrice(arg_4_0)
	return arg_4_0:getConfig("resource_num") - arg_4_0:getConfig("discount")
end

function var_0_0.GetOffPercent(arg_5_0)
	return math.modf(arg_5_0:getConfig("discount") / arg_5_0:getConfig("resource_num") * 100)
end

function var_0_0.GetConsume(arg_6_0)
	return Drop.New({
		type = arg_6_0:getConfig("resource_category"),
		id = arg_6_0:getConfig("resource_type"),
		count = arg_6_0:GetSalesPrice()
	})
end

return var_0_0
