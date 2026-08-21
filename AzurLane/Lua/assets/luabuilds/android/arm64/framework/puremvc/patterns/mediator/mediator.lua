local var_0_0 = class("Mediator", (import("..observer.Notifier")))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0

	if not arg_1_1 then
		::label_1_0::

		var_1_0 = arg_1_0.__cname or var_0_0.NAME
	end

	arg_1_0.mediatorName = var_1_0
	arg_1_0.viewComponent = arg_1_2

	return
end

var_0_0.NAME = "Mediator"

function var_0_0.getMediatorName(arg_2_0)
	return arg_2_0.mediatorName
end

function var_0_0.setViewComponent(arg_3_0, arg_3_1)
	arg_3_0.viewComponent = arg_3_1

	return
end

function var_0_0.getViewComponent(arg_4_0)
	return arg_4_0.viewComponent
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	return
end

function var_0_0.onRegister(arg_7_0)
	return
end

function var_0_0.onRemove(arg_8_0)
	return
end

return var_0_0
