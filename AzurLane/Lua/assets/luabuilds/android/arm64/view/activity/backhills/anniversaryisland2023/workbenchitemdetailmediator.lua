local var_0_0 = class("WorkBenchItemDetailMediator", import("view.base.ContextMediator"))

var_0_0.SHOW_DETAIL = "SHOW_DETAIL"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(GAME.WORKBENCH_ITEM_GO, function(arg_2_0, arg_2_1)
		arg_1_0.viewComponent:closeView()
		arg_1_0:sendNotification(GAME.WORKBENCH_ITEM_GO, arg_2_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == nil then
		-- block empty
	end

	return
end

function var_0_0.remove(arg_5_0)
	return
end

return var_0_0
