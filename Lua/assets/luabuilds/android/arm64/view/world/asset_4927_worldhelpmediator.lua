local WorldHelpMediator = class("WorldHelpMediator", import("view.base.ContextMediator"))

function WorldHelpMediator:register()
	return
end

function WorldHelpMediator:listNotificationInterests()
	return {}
end

function WorldHelpMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return WorldHelpMediator
