class = var_0_10000

local var_0_0 = "BeachPacketMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.listNotificationInterests(arg_1_0)
	local var_1_0 = {}

	ActivityProxy = var_1_10002
	var_1_0[1] = var_1_10002.ACTIVITY_SHOW_RED_PACKET_AWARDS
	ActivityProxy = var_2
	var_1_0[2] = var_2.ACTIVITY_UPDATED

	return var_1_0
end

function var_0_1.handleNotification(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.getName(var_2_0)
	local var_2_2 = arg_2_1:getBody()

	ActivityProxy = var_2_0

	if var_2_1 == var_2_0.ACTIVITY_SHOW_RED_PACKET_AWARDS then
		local var_2_3 = arg_2_0.viewComponent

		var_4.playAni(var_2_3, function()
			local var_3_0 = arg_2_0.viewComponent
			local var_3_1 = var_0.emit

			BaseUI = var_2_10003

			var_3_1(var_3_0, var_2_10003.ON_ACHIEVE, var_2_2.awards, var_2_2.callback)

			return
		end)
	else
		ActivityProxy = var_4

		if var_2_1 == var_4.ACTIVITY_UPDATED and var_2_2.id == arg_2_0.viewComponent.activityID then
			local var_2_4 = arg_2_0.viewComponent

			var_4.onSubmitFinished(var_2_4)
		end
	end

	return
end

return var_0_1
