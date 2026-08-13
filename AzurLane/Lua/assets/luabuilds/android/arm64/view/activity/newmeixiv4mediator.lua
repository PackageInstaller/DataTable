class = var_0_10000

local var_0_0 = "NewMeixiV4Mediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_TASK_GO = "ON_TASK_GO"
var_0_1.ON_TASK_SUBMIT = "ON_TASK_SUBMIT"
var_0_1.GO_STORY = "GO_STORY"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SUBMIT_TASK, arg_3_1.id)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.GO_STORY, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_4_1(var_4_0, var_4_2, var_2_10006.WORLD_COLLECTION, {
			memoryGroup = arg_4_1
		})

		return
	end)

	getProxy = var_1
	PlayerProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_2.setPlayer(var_1_2, var_1_1:getData())

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	ActivityProxy = var_1_10002
	var_5_0[1] = var_1_10002.ACTIVITY_UPDATED
	PlayerProxy = var_2
	var_5_0[2] = var_2.UPDATED
	GAME = var_2
	var_5_0[3] = var_2.SUBMIT_TASK_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.getBody(var_6_2)

	ActivityProxy = var_6_0

	local var_6_4

	if var_6_1 == var_6_0.ACTIVITY_UPDATED then
		var_6_4 = var_6_3.id
		ActivityConst = var_6_2

		if var_6_4 == var_6_2.NEWMEIXIV4_SKIRMISH_ID then
			local var_6_5 = arg_6_0.viewComponent

			var_6_4.onUpdateTask(var_6_5)
		end
	else
		PlayerProxy = var_6_4

		if var_6_1 == var_6_4.UPDATED then
			local var_6_6 = arg_6_0.viewComponent

			var_4.onUpdateRes(var_6_6, var_6_3)
		else
			GAME = var_4

			if var_6_1 == var_4.SUBMIT_TASK_DONE then
				local var_6_7 = arg_6_0.viewComponent
				local var_6_8 = var_4.emit

				BaseUI = var_1_10007

				var_6_8(var_6_7, var_1_10007.ON_ACHIEVE, var_6_3, function()
					local var_7_0 = arg_6_0.viewComponent

					var_0.onUpdateTask(var_7_0)

					return
				end)
			end
		end
	end

	return
end

return var_0_1
