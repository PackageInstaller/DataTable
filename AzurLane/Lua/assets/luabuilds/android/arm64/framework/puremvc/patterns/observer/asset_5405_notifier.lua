import = var_0_10000

local var_0_0 = var_0_10000("..facade.Facade")

class = var_0_10001

local var_0_1 = var_0_10001("Notifier")

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.sendNotification(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0:getFacade() ~= nil then
		var_4:sendNotification(arg_2_1, arg_2_2, arg_2_3)
	end

	return
end

function var_0_1.initializeNotifier(arg_3_0, arg_3_1)
	arg_3_0.multitonKey = arg_3_1
	arg_3_0.facade = arg_3_0:getFacade()

	return
end

function var_0_1.getFacade(arg_4_0)
	if arg_4_0.multitonKey == nil then
		error = var_1

		var_1(var_0_1.MULTITON_MSG)
	end

	return var_0_0.getInstance(arg_4_0.multitonKey)
end

var_0_1.MULTITON_MSG = "multitonKey for this Notifier not yet initialized!"

return var_0_1
