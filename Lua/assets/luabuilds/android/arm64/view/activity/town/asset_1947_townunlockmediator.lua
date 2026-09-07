local TownUnlockMediator = class("TownUnlockMediator", import("view.base.ContextMediator"))

function TownUnlockMediator:register()
	return
end

function TownUnlockMediator:listNotificationInterests()
	return {}
end

function TownUnlockMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return TownUnlockMediator
