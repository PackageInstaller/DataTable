local Mediator = class("Mediator", (import("..observer.Notifier")))

function Mediator:Ctor(arg_1_1, arg_1_2)
	local var_1_0

	if not arg_1_1 then
		::label_1_0::

		var_1_0 = self.__cname or Mediator.NAME
	end

	self.mediatorName = var_1_0
	self.viewComponent = arg_1_2

	return
end

Mediator.NAME = "Mediator"

function Mediator:getMediatorName()
	return self.mediatorName
end

function Mediator:setViewComponent(arg_3_1)
	self.viewComponent = arg_3_1

	return
end

function Mediator:getViewComponent()
	return self.viewComponent
end

function Mediator:listNotificationInterests()
	return {}
end

function Mediator:handleNotification(arg_6_1)
	return
end

function Mediator:onRegister()
	return
end

function Mediator:onRemove()
	return
end

return Mediator
