class = var_0_10000

local var_0_0 = "LotteryMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_LAUNCH = "LotteryMediator:ON_LAUNCH"
var_0_1.ON_SWITCH = "LotteryMediator:ON_SWITCH"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0:bind(var_0_1.ON_LAUNCH, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = var_1_0

		if not var_5.getActivityById(var_2_0, arg_2_1) or var_5:isEnd() then
			return
		end

		local var_2_1 = arg_1_0
		local var_2_2 = var_6.sendNotification

		GAME = var_2_10009

		var_2_2(var_2_1, var_2_10009.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_2_1,
			arg1 = arg_2_3,
			arg2 = arg_2_2,
			isAwardMerge = arg_2_4
		})

		return
	end)

	local var_1_1 = arg_1_0

	arg_1_0.bind(var_1_1, var_0_1.ON_SWITCH, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = var_1_0

		if not var_3.getActivityById(var_3_0, arg_3_1) or var_3:isEnd() then
			return
		end

		local var_3_1 = arg_1_0
		local var_3_2 = var_4.sendNotification

		GAME = var_2_10007

		var_3_2(var_3_1, var_2_10007.ACTIVITY_OPERATION, {
			cmd = 2,
			arg2 = 0,
			activity_id = arg_3_1,
			arg1 = arg_3_2
		})

		return
	end)

	local var_1_2 = arg_1_0.contextData.activityId
	local var_1_3 = var_1_0:getActivityById(var_1_2)

	getProxy = var_1_1
	PlayerProxy = var_6

	local var_1_4 = var_1_1(var_6)
	local var_1_5 = arg_1_0.viewComponent

	var_5.setActivity(var_1_5, var_1_3)

	local var_1_6 = arg_1_0.viewComponent

	var_5.setPlayerVO(var_1_6, var_1_4:getData())

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	ActivityProxy = var_1_10002
	var_4_0[1] = var_1_10002.ACTIVITY_UPDATED
	PlayerProxy = var_2
	var_4_0[2] = var_2.UPDATED
	ActivityProxy = var_2
	var_4_0[3] = var_2.ACTIVITY_LOTTERY_SHOW_AWARDS

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1
	local var_5_3 = arg_5_1.getBody(var_5_2)

	ActivityProxy = var_5_0

	local var_5_4

	if var_5_1 == var_5_0.ACTIVITY_UPDATED then
		var_5_4 = var_5_3:getConfig("type")
		ActivityConst = var_5_2

		if var_5_4 == var_5_2.ACTIVITY_TYPE_LOTTERY then
			local var_5_5 = arg_5_0.viewComponent

			var_5_4.onActivityUpdated(var_5_5, var_5_3)
		end
	else
		PlayerProxy = var_5_4

		if var_5_1 == var_5_4.UPDATED then
			local var_5_6 = arg_5_0.viewComponent

			var_4.setPlayerVO(var_5_6, var_5_3)
		else
			ActivityProxy = var_4

			if var_5_1 == var_4.ACTIVITY_LOTTERY_SHOW_AWARDS then
				local var_5_7 = arg_5_0.viewComponent
				local var_5_8 = var_4.emit

				BaseUI = var_1_10007

				var_5_8(var_5_7, var_1_10007.ON_ACHIEVE, var_5_3.awards, var_5_3.callback)
			end
		end
	end

	return
end

return var_0_1
