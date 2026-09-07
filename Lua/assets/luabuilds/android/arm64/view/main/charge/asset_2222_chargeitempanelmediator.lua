local ChargeItemPanelMediator = class("ChargeItemPanelMediator", import("...base.ContextMediator"))

function ChargeItemPanelMediator:register()
	return
end

function ChargeItemPanelMediator:listNotificationInterests()
	return {}
end

function ChargeItemPanelMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return ChargeItemPanelMediator
