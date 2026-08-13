class = var_0_10000

local var_0_0 = "IdolMedalCollectionMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_1.BindEvent(arg_2_0)
	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.MEMORYBOOK_UNLOCK_DONE
	ActivityProxy = var_2
	var_3_0[2] = var_2.ACTIVITY_SHOW_AWARDS
	ActivityProxy = var_2
	var_3_0[3] = var_2.ACTIVITY_UPDATED

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1
	local var_4_3 = arg_4_1.getBody(var_4_2)

	GAME = var_4_0

	if var_4_1 == var_4_0.MEMORYBOOK_UNLOCK_DONE then
		var_1_10006 = arg_4_0.viewComponent

		var_4.updateAfterSubmit(var_1_10006, var_4_3)
	else
		ActivityProxy = var_4

		local var_4_4

		if var_4_1 == var_4.ACTIVITY_UPDATED then
			var_1_10006 = var_4_3
			var_4_4 = var_4_3.getConfig(var_1_10006, "type")
			ActivityConst = var_4_2

			if var_4_4 == var_4_2.ACTIVITY_TYPE_PUZZLA then
				var_1_10006 = arg_4_0.viewComponent

				var_4_4.UpdateActivity(var_1_10006)
			end
		else
			ActivityProxy = var_4_4

			if var_4_1 == var_4_4.ACTIVITY_SHOW_AWARDS then
				getProxy = var_4
				ContextProxy = var_1_10006

				local var_4_5 = var_4(var_1_10006)
				local var_4_6 = var_4.getContextByMediator

				ActivityMediator = var_1_10007

				local var_4_7 = var_4_6(var_4_5, var_1_10007)
				local var_4_8 = arg_4_0.viewComponent
				local var_4_9 = var_5.emit

				BaseUI = var_1_10008

				var_4_9(var_4_8, var_1_10008.ON_ACHIEVE, var_4_3.awards, var_4_3.callback)
			end
		end
	end

	return
end

return var_0_1
