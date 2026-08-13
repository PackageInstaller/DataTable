class = var_0_10000

local var_0_0 = "PlayerSummaryInfoMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.GET_PLAYER_SUMMARY_INFO = "PlayerSummaryInfoMediator:GET_PLAYER_SUMMARY_INFO"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0:bind(var_0_1.GET_PLAYER_SUMMARY_INFO, function(arg_2_0)
		local var_2_0 = var_1_0
		local var_2_1 = var_1.getActivityByType

		ActivityConst = var_2_10004

		if var_2_1(var_2_0, var_2_10004.ACTIVITY_TYPE_SUMMARY) and not var_1:isEnd() then
			local var_2_2 = arg_1_0
			local var_2_3 = var_2.sendNotification

			GAME = var_2_10005

			var_2_3(var_2_2, var_2_10005.GET_PLAYER_SUMMARY_INFO, {
				activityId = var_1.id
			})
		end

		return
	end)

	local var_1_1 = var_1_0
	local var_1_2 = var_1_0.getActivityByType

	ActivityConst = var_5

	local var_1_3 = var_1_2(var_1_1, var_5.ACTIVITY_TYPE_SUMMARY)
	local var_1_4 = arg_1_0.viewComponent

	var_3.setActivity(var_1_4, var_1_3)

	getProxy = var_3
	PlayerProxy = var_1_4

	local var_1_5 = var_3(var_1_4)
	local var_1_6 = arg_1_0.viewComponent

	var_4.setPlayer(var_1_6, var_1_5:getData())

	local var_1_7 = var_1_5:getSummaryInfo()
	local var_1_8 = arg_1_0.viewComponent

	var_5.setSummaryInfo(var_1_8, var_1_7)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.GET_PLAYER_SUMMARY_INFO_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 == var_4_0.GET_PLAYER_SUMMARY_INFO_DONE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.setSummaryInfo(var_4_3, var_4_2)

		local var_4_4 = arg_4_0.viewComponent

		var_4.initSummaryInfo(var_4_4)
	end

	return
end

return var_0_1
