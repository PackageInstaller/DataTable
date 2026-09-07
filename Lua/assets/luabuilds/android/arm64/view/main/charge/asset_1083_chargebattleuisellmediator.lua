local ChargeBattleUISellMediator = class("ChargeBattleUISellMediator", import("...base.ContextMediator"))

function ChargeBattleUISellMediator:register()
	return
end

function ChargeBattleUISellMediator:listNotificationInterests()
	return {}
end

function ChargeBattleUISellMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return ChargeBattleUISellMediator
