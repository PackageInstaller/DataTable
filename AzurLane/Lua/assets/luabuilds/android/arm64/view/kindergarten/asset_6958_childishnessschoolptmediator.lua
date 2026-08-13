class = var_0_10000

local var_0_0 = "ChildishnessSchoolPtMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.EVENT_PT_OPERATION = "event pt op"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EVENT_PT_OPERATION, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.ACT_NEW_PT, arg_2_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.ACT_NEW_PT_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 == var_4_0.ACT_NEW_PT_DONE then
		local var_4_3 = arg_4_0.viewComponent
		local var_4_4 = var_4.emit

		BaseUI = var_1_10007

		var_4_4(var_4_3, var_1_10007.ON_ACHIEVE, var_4_2.awards, var_4_2.callback)

		local var_4_5 = arg_4_0.viewComponent

		var_4.Show(var_4_5)
	end

	return
end

return var_0_1
