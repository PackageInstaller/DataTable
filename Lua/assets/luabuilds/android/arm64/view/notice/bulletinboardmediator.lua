local var_0_0 = class("BulletinBoardMediator", import("..base.ContextMediator"))

var_0_0.SET_STOP_REMIND = "set_stop_remind"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(ServerNoticeProxy)

	var_1_0:setStopNewTip()
	arg_1_0.viewComponent:setNotices((var_1_0:getServerNotices(false)))
	arg_1_0:bind(arg_1_0.SET_STOP_REMIND, function(arg_2_0, arg_2_1)
		getProxy(ServerNoticeProxy):setStopRemind(arg_2_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_0
