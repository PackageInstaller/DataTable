class = var_0_10000

local var_0_0 = "WorkBenchItemDetailMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.SHOW_DETAIL = "SHOW_DETAIL"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_1_10004

	var_1_1(var_1_0, var_1_10004.WORKBENCH_ITEM_GO, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.viewComponent

		var_2.closeView(var_2_0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_2.sendNotification

		GAME = var_2_10005

		var_2_2(var_2_1, var_2_10005.WORKBENCH_ITEM_GO, arg_2_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == nil then
		-- block empty
	end

	return
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
