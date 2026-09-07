local ChargeItemBoxMediator = class("ChargeItemBoxMediator", import("...base.ContextMediator"))

function ChargeItemBoxMediator:register()
	return
end

function ChargeItemBoxMediator:listNotificationInterests()
	return {}
end

function ChargeItemBoxMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return ChargeItemBoxMediator
