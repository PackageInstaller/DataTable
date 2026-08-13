class = var_0_10000

local var_0_0 = "MsgboxMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	return {}
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == nil then
		-- block empty
	end

	return
end

function var_0_1.remove(arg_4_0)
	return
end

function var_0_1.ShowMsgBox(arg_5_0)
	LoadContextCommand = var_1_10001

	local var_5_0 = var_1_10001.LoadLayerOnTopContext

	Context = var_1_10002

	local var_5_1 = var_1_10002.New
	local var_5_2 = {}

	MsgboxMediator = var_1_10004
	var_5_2.mediator = var_1_10004
	MsgboxLayer = var_1_10004
	var_5_2.viewComponent = var_1_10004
	var_5_2.data = arg_5_0

	var_5_0(var_5_1(var_5_2))

	return
end

return var_0_1
