local var_0_0 = class("ActivityExtraCommodity", import(".ActivityCommodity"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_shop_extra
end

function var_0_0.ShowMaintenanceTime(arg_2_0)
	return arg_2_0:getConfig("end_by_maintenance") == 1
end

function var_0_0.GetMaintenanceMonthAndDay(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("time")

	return var_3_0[2][1][2], var_3_0[2][1][3]
end

return var_0_0
