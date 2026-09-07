local ChargeJPUserAgreeMediator = class("ChargeJPUserAgreeMediator", import("...base.ContextMediator"))

function ChargeJPUserAgreeMediator:register()
	return
end

function ChargeJPUserAgreeMediator:listNotificationInterests()
	return {}
end

function ChargeJPUserAgreeMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return ChargeJPUserAgreeMediator
