local IslandGameLimitMediator = class("IslandGameLimitMediator", import("..base.ContextMediator"))

function IslandGameLimitMediator:register()
	return
end

function IslandGameLimitMediator:listNotificationInterests()
	return {}
end

function IslandGameLimitMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return IslandGameLimitMediator
