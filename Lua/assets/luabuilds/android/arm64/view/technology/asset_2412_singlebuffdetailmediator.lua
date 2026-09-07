local SingleBuffDetailMediator = class("SingleBuffDetailMediator", import("..base.ContextMediator"))

function SingleBuffDetailMediator:register()
	return
end

function SingleBuffDetailMediator:listNotificationInterests()
	return {}
end

function SingleBuffDetailMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return SingleBuffDetailMediator
