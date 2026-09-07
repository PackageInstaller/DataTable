local ActivityExtraCommodity = class("ActivityExtraCommodity", import(".ActivityCommodity"))

function ActivityExtraCommodity:bindConfigTable()
	return pg.activity_shop_extra
end

function ActivityExtraCommodity:ShowMaintenanceTime()
	return self:getConfig("end_by_maintenance") == 1
end

function ActivityExtraCommodity:GetMaintenanceMonthAndDay()
	local var_3_0 = self:getConfig("time")

	return var_3_0[2][1][2], var_3_0[2][1][3]
end

return ActivityExtraCommodity
