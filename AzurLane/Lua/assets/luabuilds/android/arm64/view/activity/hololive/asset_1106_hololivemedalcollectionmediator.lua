class = var_0_10000

local var_0_0 = "HololiveMedalCollectionMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_1.BindEvent(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.bind

	ActivityMediator = var_1_10004

	var_2_1(var_2_0, var_1_10004.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SUBMIT_TASK, arg_3_1.id)

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.bind

	ActivityMediator = var_4

	var_2_3(var_2_2, var_4.ON_TASK_GO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.MEMORYBOOK_UNLOCK_DONE
	ActivityProxy = var_2
	var_5_0[2] = var_2.ACTIVITY_SHOW_AWARDS
	GAME = var_2
	var_5_0[3] = var_2.SUBMIT_TASK_DONE
	ActivityProxy = var_2
	var_5_0[4] = var_2.ACTIVITY_OPERATION_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	GAME = var_6_0

	if var_6_1 == var_6_0.MEMORYBOOK_UNLOCK_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_4.UpdateView(var_6_3)
	else
		ActivityProxy = var_4

		if var_6_1 == var_4.ACTIVITY_SHOW_AWARDS then
			local var_6_4 = arg_6_0.viewComponent

			var_4.PlayStory(var_6_4, function()
				local var_7_0 = arg_6_0.viewComponent
				local var_7_1 = var_0.emit

				BaseUI = var_2_10003

				var_7_1(var_7_0, var_2_10003.ON_ACHIEVE, var_6_2.awards, var_6_2.callback)

				return
			end)
		else
			GAME = var_4

			local var_6_6

			if var_6_1 == var_4.SUBMIT_TASK_DONE then
				local var_6_5 = arg_6_0.viewComponent

				var_6_6 = var_6_6.emit
				BaseUI = var_1_10007

				var_6_6(var_6_5, var_1_10007.ON_ACHIEVE, var_6_2, function()
					local var_8_0 = arg_6_0.viewComponent

					var_0.UpdateView(var_8_0)

					return
				end)
			else
				ActivityProxy = var_6_6

				if var_6_1 == var_6_6.ACTIVITY_OPERATION_DONE then
					local var_6_7 = arg_6_0.viewComponent

					var_4.UpdateView(var_6_7)
				end
			end
		end
	end

	return
end

return var_0_1
