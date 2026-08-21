local var_0_0 = class("MallStaffMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.ACTIVITY_MALL_OP_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.ACTIVITY_MALL_OP_DONE then
		arg_3_0.viewComponent:UpdateData()
		arg_3_0.viewComponent:UpdateView()
	end

	return
end

return var_0_0
