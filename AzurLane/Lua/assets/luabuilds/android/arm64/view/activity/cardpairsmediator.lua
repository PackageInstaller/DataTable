class = var_0_10000

local var_0_0 = "CardPairsMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.EVENT_OPERATION = "event operation"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EVENT_OPERATION, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.ACTIVITY_OPERATION, arg_2_1)

		return
	end)
	arg_1_0:setActivityData()
	arg_1_0:setPlayerData()

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	ActivityProxy = var_1_10002
	var_3_0[1] = var_1_10002.ACTIVITY_UPDATED
	PlayerProxy = var_2
	var_3_0[2] = var_2.UPDATED
	ActivityProxy = var_2
	var_3_0[3] = var_2.ACTIVITY_SHOW_AWARDS
	ActivityProxy = var_2
	var_3_0[4] = var_2.ACTIVITY_OPERATION_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	ActivityProxy = var_4_0

	if var_4_1 == var_4_0.ACTIVITY_UPDATED then
		local var_4_3 = arg_4_0.viewComponent

		var_4.setActivityData(var_4_3, var_4_2)
	else
		PlayerProxy = var_4

		if var_4_1 == var_4.UPDATED then
			local var_4_4 = arg_4_0.viewComponent

			var_4.setPlayerData(var_4_4, var_4_2)
		else
			ActivityProxy = var_4

			local var_4_6

			if var_4_1 == var_4.ACTIVITY_SHOW_AWARDS then
				local var_4_5 = arg_4_0.viewComponent

				var_4_6 = var_4_6.emit
				BaseUI = var_1_10007

				var_4_6(var_4_5, var_1_10007.ON_ACHIEVE, var_4_2.awards, var_4_2.callback)
			else
				ActivityProxy = var_4_6

				if var_4_1 == var_4_6.ACTIVITY_OPERATION_DONE then
					local var_4_7 = arg_4_0.viewComponent

					var_4.checkActivityEnd(var_4_7)
				end
			end
		end
	end

	return
end

function var_0_1.setPlayerData(arg_5_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.getData(var_5_0)
	local var_5_2 = arg_5_0.viewComponent

	var_3.setPlayerData(var_5_2, var_5_1)

	return
end

function var_0_1.setActivityData(arg_6_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getActivityByType

	ActivityConst = var_1_10005

	local var_6_2 = var_6_1(var_6_0, var_1_10005.ACTIVITY_TYPE_CARD_PAIRS)
	local var_6_3 = arg_6_0.viewComponent

	var_3.setActivityData(var_6_3, var_6_2)

	return
end

return var_0_1
