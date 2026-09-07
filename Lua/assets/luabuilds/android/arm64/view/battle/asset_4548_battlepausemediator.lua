local BattlePauseMediator = class("BattlePauseMediator", import("..base.ContextMediator"))

function BattlePauseMediator:register()
	return
end

function BattlePauseMediator:listNotificationInterests()
	return {}
end

function BattlePauseMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return BattlePauseMediator
