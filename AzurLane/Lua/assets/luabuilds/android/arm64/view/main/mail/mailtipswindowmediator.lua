class = var_0_10000

local var_0_0 = "MailTipsWindowMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	return {}
end

function var_0_1.remove(arg_3_0)
	if arg_3_0.contextData.onClose then
		arg_3_0.contextData.onClose()
	end

	return
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_1
