class = var_0_10000

local var_0_0 = "ExpeditionGameMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MiniHubMediator"))

function var_0_1.listNotificationInterests(arg_1_0)
	local var_1_0 = {}

	ActivityProxy = var_1_10002
	var_1_0[1] = var_1_10002.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_1_0[2] = var_2.ACTIVITY_SHOW_AWARDS
	GAME = var_2
	var_1_0[3] = var_2.BEGIN_STAGE_DONE
	table = var_2

	var_2.insertto(var_1_0, var_0_1.super.listNotificationInterests(arg_1_0))

	return var_1_0
end

function var_0_1.handleNotification(arg_2_0, arg_2_1)
	var_0_1.super.handleNotification(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.getName(var_2_0)
	local var_2_2 = arg_2_1:getBody()

	ActivityProxy = var_2_0

	if var_2_1 == var_2_0.ACTIVITY_UPDATED then
		local var_2_3 = arg_2_0.viewComponent

		var_4.activityUpdate(var_2_3)
	else
		ActivityProxy = var_4

		local var_2_5

		if var_2_1 == var_4.ACTIVITY_SHOW_AWARDS then
			local var_2_4 = arg_2_0.viewComponent

			var_2_5 = var_2_5.emit
			BaseUI = var_1_10007

			var_2_5(var_2_4, var_1_10007.ON_ACHIEVE, var_2_2.awards, var_2_2.callback)
		else
			GAME = var_2_5

			if var_2_1 == var_2_5.BEGIN_STAGE_DONE then
				local var_2_6 = arg_2_0
				local var_2_7 = arg_2_0.sendNotification

				GAME = var_1_10007

				local var_2_8 = var_1_10007.GO_SCENE

				SCENE = var_1_10008

				var_2_7(var_2_6, var_2_8, var_1_10008.COMBATLOAD, var_2_2)
			end
		end
	end

	return
end

return var_0_1
