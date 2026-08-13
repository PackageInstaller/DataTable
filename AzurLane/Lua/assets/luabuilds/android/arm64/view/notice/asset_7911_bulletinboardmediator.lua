class = var_0_10000

local var_0_0 = "BulletinBoardMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.SET_STOP_REMIND = "set_stop_remind"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ServerNoticeProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	var_1.setStopNewTip(var_1_0)

	local var_1_1 = var_1:getServerNotices(false)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setNotices(var_1_2, var_1_1)
	arg_1_0:bind(arg_1_0.SET_STOP_REMIND, function(arg_2_0, arg_2_1)
		getProxy = var_2_10002
		ServerNoticeProxy = var_2_10004

		local var_2_0 = var_2_10002(var_2_10004)

		var_2.setStopRemind(var_2_0, arg_2_1)

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

	return
end

return var_0_1
