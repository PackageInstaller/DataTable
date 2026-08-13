class = var_0_10000

local var_0_0 = "BuildingUpgradeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ACTIVITY_OPERATION = "ACTIVITY_OPERATION"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.BindEvent(var_1_0)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_1_3 = var_1_2(var_1_1, var_1_10004.ACTIVITY_TYPE_BUILDING_BUFF)

	assert = var_1_10002

	var_1_10002(var_1_3, "Building Activity Not Found")

	local var_1_4 = arg_1_0.viewComponent

	var_2.UpdateActivity(var_1_4, var_1_3)

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.ACTIVITY_OPERATION, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	ActivityProxy = var_1_10002
	var_4_0[1] = var_1_10002.ACTIVITY_UPDATED

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1
	local var_5_3 = arg_5_1.getBody(var_5_2)

	ActivityProxy = var_5_0

	if var_5_1 == var_5_0.ACTIVITY_UPDATED then
		local var_5_4 = var_5_3:getConfig("type")

		ActivityConst = var_5_2

		if var_5_4 == var_5_2.ACTIVITY_TYPE_BUILDING_BUFF then
			local var_5_5 = arg_5_0.viewComponent

			var_4.UpdateActivity(var_5_5, var_5_3)

			local var_5_6 = arg_5_0.viewComponent

			var_4.Set(var_5_6, var_5_3)
		end
	end

	return
end

return var_0_1
