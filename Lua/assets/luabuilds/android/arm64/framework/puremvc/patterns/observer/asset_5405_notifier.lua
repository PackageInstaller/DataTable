local Facade = import("..facade.Facade")
local Notifier = class("Notifier")

function Notifier:Ctor()
	return
end

function Notifier:sendNotification(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = self:getFacade()

	if var_2_0 ~= nil then
		var_2_0:sendNotification(arg_2_1, arg_2_2, arg_2_3)
	end

	return
end

function Notifier:initializeNotifier(arg_3_1)
	self.multitonKey = arg_3_1
	self.facade = self:getFacade()

	return
end

function Notifier:getFacade()
	if self.multitonKey == nil then
		error(Notifier.MULTITON_MSG)
	end

	return Facade.getInstance(self.multitonKey)
end

Notifier.MULTITON_MSG = "multitonKey for this Notifier not yet initialized!"

return Notifier
