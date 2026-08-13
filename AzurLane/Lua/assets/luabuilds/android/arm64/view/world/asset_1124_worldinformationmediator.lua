class = var_0_10000

local var_0_0 = "WorldInformationMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OnTriggerTask = "WorldInformationMediator.OnTriggerTask"
var_0_1.OnSubmitTask = "WorldInformationMediator.OnSubmitTask"
var_0_1.OnTaskGoto = "WorldInformationMediator.OnTaskGoto"
var_0_1.OnOpenDailyTaskPanel = "WorldInformationMediator.OnOpenDailyTaskPanel"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnTaskGoto, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		WorldMediator = var_2_10005

		var_2_1(var_2_0, var_2_10005.OnTriggerTaskGo, {
			taskId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnTriggerTask, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.WORLD_TRIGGER_TASK, {
			taskId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnSubmitTask, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.WORLD_SUMBMIT_TASK, {
			taskId = arg_4_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnOpenDailyTaskPanel, function(arg_5_0)
		nowWorld = var_2_10001

		local var_5_0 = var_2_10001()
		local var_5_1 = var_1.GetTaskProxy(var_5_0)

		var_1.checkDailyTask(var_5_1, function()
			local var_6_0 = arg_1_0
			local var_6_1 = var_0.addSubLayers

			Context = var_3_10003

			local var_6_2 = var_3_10003.New
			local var_6_3 = {}

			WorldDailyTaskMediator = var_3_10006
			var_6_3.mediator = var_3_10006
			WorldDailyTaskLayer = var_3_10006
			var_6_3.viewComponent = var_3_10006

			var_6_1(var_6_0, var_6_2(var_6_3))

			return
		end)

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.setWorldTaskProxy

	nowWorld = var_4

	local var_1_2 = var_4()

	var_1_1(var_1_0, var_4.GetTaskProxy(var_1_2))

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	WorldCollectionMediator = var_1_10002
	var_7_0[1] = var_1_10002.ON_MAP

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	WorldCollectionMediator = var_8_0

	if var_8_1 == var_8_0.ON_MAP then
		local var_8_3 = arg_8_0.viewComponent

		var_4.closeView(var_8_3)
	end

	return
end

return var_0_1
