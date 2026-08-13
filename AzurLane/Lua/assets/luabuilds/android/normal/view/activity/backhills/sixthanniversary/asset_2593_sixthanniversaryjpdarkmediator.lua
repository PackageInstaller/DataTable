class = var_0_10000

local var_0_0 = "SixthAnniversaryJPDarkMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GO_SCENE = "GO_SCENE"
var_0_1.GO_SUBLAYER = "GO_SUBLAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_2_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_2_0:bind(var_0_1.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_2_0

		var_3.addSubLayers(var_4_0, arg_4_1, nil, arg_4_2)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	ActivityProxy = var_1_10002
	var_5_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_5_0[2] = var_2.SUBMIT_TASK_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	ActivityProxy = var_6_1

	local var_6_3

	if var_6_0 == var_6_1.ACTIVITY_UPDATED then
		var_6_3 = var_6_2.id
		ActivityConst = var_1_10005

		if var_6_3 == var_1_10005.MINIGAME_ZUMA then
			local var_6_4 = arg_6_0.viewComponent

			var_6_3.UpdateLevels(var_6_4)

			local var_6_5 = arg_6_0.viewComponent

			var_6_3.UpdateCount(var_6_5)
		end
	else
		GAME = var_6_3

		if var_6_0 == var_6_3.SUBMIT_TASK_DONE then
			local var_6_6 = arg_6_0.viewComponent

			var_4.UpdateTaskTip(var_6_6)
		end
	end

	return
end

return var_0_1
