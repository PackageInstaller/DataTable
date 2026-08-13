class = var_0_10000

local var_0_0 = "MemoryBookMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_UNLOCK = "MemoryBookMediator:ON_UNLOCK"
var_0_1.EVENT_OPERATION = "MemoryBookMediator:EVENT_OPERATION"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_UNLOCK, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.MEMORYBOOK_UNLOCK, {
			id = arg_2_1,
			actId = arg_2_2
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.EVENT_OPERATION, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_PUZZLA)
	local var_1_4 = arg_1_0.viewComponent

	var_3.setActivity(var_1_4, var_1_3)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.MEMORYBOOK_UNLOCK_DONE
	ActivityProxy = var_2
	var_4_0[2] = var_2.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_4_0[3] = var_2.ACTIVITY_SHOW_AWARDS

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GAME = var_5_1

	if var_5_0 == var_5_1.MEMORYBOOK_UNLOCK_DONE then
		var_1_10005 = arg_5_0.viewComponent

		var_4.updateMemorys(var_1_10005)
	else
		ActivityProxy = var_4

		if var_5_0 == var_4.ACTIVITY_UPDATED then
			if var_5_2.id == arg_5_0.viewComponent.activity.id then
				var_1_10006 = arg_5_0.viewComponent

				var_1_10005.setActivity(var_1_10006, var_4)

				var_1_10006 = arg_5_0.viewComponent

				var_1_10005.updateProgress(var_1_10006)
			end
		else
			ActivityProxy = var_4

			if var_5_0 == var_4.ACTIVITY_SHOW_AWARDS then
				getProxy = var_4
				ContextProxy = var_1_10005

				local var_5_3 = var_4(var_1_10005)
				local var_5_4 = var_4.getCurrentContext(var_5_3).mediator

				ActivityMediator = var_1_10006

				if var_5_4 == var_1_10006 then
					return
				end

				local var_5_5 = arg_5_0.viewComponent
				local var_5_6 = var_5.emit

				BaseUI = var_1_10007

				var_5_6(var_5_5, var_1_10007.ON_ACHIEVE, var_5_2.awards, var_5_2.callback)
			end
		end
	end

	return
end

return var_0_1
