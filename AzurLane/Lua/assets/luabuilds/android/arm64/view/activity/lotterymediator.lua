local var_0_0 = class("LotteryMediator", import("..base.ContextMediator"))

var_0_0.ON_LAUNCH = "LotteryMediator:ON_LAUNCH"
var_0_0.ON_SWITCH = "LotteryMediator:ON_SWITCH"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(ActivityProxy)

	arg_1_0:bind(var_0_0.ON_LAUNCH, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = var_1_0:getActivityById(arg_2_1)

		if not var_2_0 or var_2_0:isEnd() then
			return
		end

		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_2_1,
			arg1 = arg_2_3,
			arg2 = arg_2_2,
			isAwardMerge = arg_2_4
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SWITCH, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = var_1_0:getActivityById(arg_3_1)

		if not var_3_0 or var_3_0:isEnd() then
			return
		end

		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			arg2 = 0,
			activity_id = arg_3_1,
			arg1 = arg_3_2
		})

		return
	end)
	arg_1_0.viewComponent:setActivity((getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.activityId)))
	arg_1_0.viewComponent:setPlayerVO(getProxy(PlayerProxy):getData())

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED,
		ActivityProxy.ACTIVITY_LOTTERY_SHOW_AWARDS
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_LOTTERY then
			arg_5_0.viewComponent:onActivityUpdated(var_5_1)
		end
	elseif var_5_0 == PlayerProxy.UPDATED then
		arg_5_0.viewComponent:setPlayerVO(var_5_1)
	elseif var_5_0 == ActivityProxy.ACTIVITY_LOTTERY_SHOW_AWARDS then
		arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, var_5_1.callback)
	end

	return
end

return var_0_0
