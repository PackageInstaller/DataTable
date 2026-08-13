class = var_0_10000

local var_0_0 = "AnniversaryIslandSpringTaskSubmitWindowMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	AnniversaryIslandSpringTask2023Mediator = var_1_10003

	var_1_1(var_1_0, var_1_10003.SUBMIT_TASK, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		AnniversaryIslandSpringTask2023Mediator = var_2_10003

		var_2_1(var_2_0, var_2_10003.SUBMIT_TASK, arg_1_0.contextData.task)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	WorkBenchItemDetailMediator = var_3

	var_1_3(var_1_2, var_3.SHOW_DETAIL, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		WorkBenchItemDetailMediator = var_2_10006
		var_3_3.mediator = var_2_10006
		WorkBenchItemDetailLayer = var_2_10006
		var_3_3.viewComponent = var_2_10006
		var_3_3.data = {
			material = arg_3_1
		}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GAME = var_5_1

	if var_5_0 == var_5_1.SUBMIT_ACTIVITY_TASK_DONE then
		local var_5_3 = arg_5_0.viewComponent

		var_4.closeView(var_5_3)
	end

	return
end

function var_0_1.remove(arg_6_0)
	return
end

return var_0_1
