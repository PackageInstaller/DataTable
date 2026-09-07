local ChargeTecShipGiftSellMediator = class("ChargeTecShipGiftSellMediator", import("...base.ContextMediator"))

function ChargeTecShipGiftSellMediator:register()
	return
end

function ChargeTecShipGiftSellMediator:listNotificationInterests()
	return {}
end

function ChargeTecShipGiftSellMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return ChargeTecShipGiftSellMediator
