local var_0_0 = class("MonopolyPtMediator", import("view.base.ContextMediator"))

var_0_0.ON_START = "MonopolyGame:ON_START"
var_0_0.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_0.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_0.ON_AWARD = "MonopolyGame:ON_AWARD"
var_0_0.MONOPOLY_OP_LAST = "MonopolyGame:MONOPOLY_OP_LAST"
var_0_0.ON_STOP = "MonopolyGame:MONOPOLY_ON_STOP"
var_0_0.AWARDS = {}

function var_0_0.register(arg_1_0)
	arg_1_0:bind(MonopolyPtMediator.ON_STOP, function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_1_0.viewComponent.autoFlag and #MonopolyPtMediator.AWARDS > 0 then
			arg_1_0:emit(BaseUI.ON_ACHIEVE, MonopolyPtMediator.AWARDS, arg_2_2)

			MonopolyPtMediator.AWARDS = {}
		end

		return
	end)
	arg_1_0:bind(MonopolyPtMediator.MONOPOLY_OP_LAST, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_LAST,
			callback = arg_3_2
		})

		return
	end)
	arg_1_0:bind(MonopolyPtMediator.ON_START, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(MonopolyPtMediator.ON_MOVE, function(arg_5_0, arg_5_1, arg_5_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_5_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_5_2
		})

		return
	end)
	arg_1_0:bind(MonopolyPtMediator.ON_TRIGGER, function(arg_6_0, arg_6_1, arg_6_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_6_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_6_2
		})

		return
	end)
	arg_1_0:bind(MonopolyPtMediator.ON_AWARD, function(arg_7_0)
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.REDPACKEY)

		return
	end)

	arg_1_0._configId = arg_1_0.contextData.configId
	arg_1_0._activityId = arg_1_0.contextData.activityId
	arg_1_0._activity = getProxy(ActivityProxy):getActivityById(arg_1_0._activityId)

	arg_1_0.viewComponent:firstUpdata(arg_1_0._activity)

	if not arg_1_0.viewComponent.autoFlag and #MonopolyPtMediator.AWARDS > 0 then
		arg_1_0:emit(BaseUI.ON_ACHIEVE, MonopolyPtMediator.AWARDS, function()
			return
		end)

		MonopolyPtMediator.AWARDS = {}
	end

	return
end

function var_0_0.getLeftRpCount()
	local var_9_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	return var_9_0.data2_list[1] - var_9_0.data2_list[2]
end

function var_0_0.onAward(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0 = 1, #arg_10_1 do
		table.insert(MonopolyPtMediator.AWARDS, arg_10_1[iter_10_0])
	end

	if arg_10_0.viewComponent.autoFlag then
		arg_10_0.viewComponent:addAwards(arg_10_1)

		if arg_10_2 then
			arg_10_2()
		end
	else
		arg_10_0:emit(BaseUI.ON_ACHIEVE, MonopolyPtMediator.AWARDS, arg_10_2)

		MonopolyPtMediator.AWARDS = {}
	end

	return
end

function var_0_0.listNotificationInterests(arg_11_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_ADDED,
		GAME.MONOPOLY_AWARD_DONE
	}
end

function var_0_0.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()
	local var_12_2 = arg_12_1:getType()

	if var_12_0 == ActivityProxy.ACTIVITY_UPDATED or var_12_0 == ActivityProxy.ACTIVITY_ADDED then
		arg_12_0:updateGameUI()
	elseif var_12_0 == GAME.MONOPOLY_AWARD_DONE then
		if arg_12_0._activity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_MONOPOLY and arg_12_0.viewComponent.onAward then
			arg_12_0.viewComponent:onAward(var_12_1.awards, var_12_1.callback)
		else
			arg_12_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_12_1.awards, var_12_1.callback)
		end
	end

	return
end

function var_0_0.updateGameUI(arg_13_0)
	if not arg_13_0._activityId then
		return
	end

	arg_13_0._activity = getProxy(ActivityProxy):getActivityById(arg_13_0._activityId)

	arg_13_0.viewComponent:updataActivity(arg_13_0._activity)

	return
end

function var_0_0.remove(arg_14_0)
	if arg_14_0.viewComponent then
		MonopolyPtMediator.AWARDS = {}
	end

	return
end

return var_0_0
