class = var_0_10000

local var_0_0 = "RedPacketMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	ActivityProxy = var_1_10002
	var_2_0[1] = var_1_10002.ACTIVITY_SHOW_RED_PACKET_AWARDS
	ActivityProxy = var_2
	var_2_0[2] = var_2.ACTIVITY_UPDATED

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getName(var_3_0)
	local var_3_2 = arg_3_1:getBody()

	ActivityProxy = var_3_0

	local var_3_4

	if var_3_1 == var_3_0.ACTIVITY_SHOW_RED_PACKET_AWARDS then
		local var_3_3 = arg_3_0.viewComponent

		var_3_4 = var_3_4.emit
		BaseUI = var_1_10007

		var_3_4(var_3_3, var_1_10007.ON_ACHIEVE, var_3_2.awards, var_3_2.callback)
	else
		ActivityProxy = var_3_4

		if var_3_1 == var_3_4.ACTIVITY_UPDATED and var_3_2.id == arg_3_0.viewComponent.activityID then
			local var_3_5 = arg_3_0.viewComponent

			var_4.onSubmitFinished(var_3_5)
		end
	end

	return
end

return var_0_1
