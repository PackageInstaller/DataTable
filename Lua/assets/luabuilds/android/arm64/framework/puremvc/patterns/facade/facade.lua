local var_0_0 = import("...core.Controller")
local var_0_1 = import("...core.Model")
local var_0_2 = import("...core.View")
local var_0_3 = import("..observer.Notification")
local var_0_4 = class("Facade")

function var_0_4.Ctor(arg_1_0, arg_1_1)
	if var_0_4.instanceMap[arg_1_1] ~= nil then
		error(var_0_4.MULTITON_MSG)
	end

	arg_1_0:initializeNotifier(arg_1_1)

	var_0_4.instanceMap[arg_1_1] = arg_1_0

	arg_1_0:initializeFacade()

	return
end

function var_0_4.initializeFacade(arg_2_0)
	arg_2_0:initializeModel()
	arg_2_0:initializeController()
	arg_2_0:initializeView()

	return
end

function var_0_4.getInstance(arg_3_0)
	if arg_3_0 == nil then
		return nil
	end

	if var_0_4.instanceMap[arg_3_0] == nil then
		var_0_4.instanceMap[arg_3_0] = var_0_4.New(arg_3_0)
	end

	return var_0_4.instanceMap[arg_3_0]
end

function var_0_4.initializeController(arg_4_0)
	if arg_4_0.controller ~= nil then
		return
	end

	arg_4_0.controller = var_0_0.getInstance(arg_4_0.multitonKey)

	return
end

function var_0_4.initializeModel(arg_5_0)
	if arg_5_0.model ~= nil then
		return
	end

	arg_5_0.model = var_0_1.getInstance(arg_5_0.multitonKey)

	return
end

function var_0_4.initializeView(arg_6_0)
	if arg_6_0.view ~= nil then
		return
	end

	arg_6_0.view = var_0_2.getInstance(arg_6_0.multitonKey)

	return
end

function var_0_4.registerCommand(arg_7_0, arg_7_1, arg_7_2)
	assert(arg_7_2)
	arg_7_0.controller:registerCommand(arg_7_1, arg_7_2)

	return
end

function var_0_4.removeCommand(arg_8_0, arg_8_1)
	arg_8_0.controller:removeCommand(arg_8_1)

	return
end

function var_0_4.hasCommand(arg_9_0, arg_9_1)
	return arg_9_0.controller:hasCommand(arg_9_1)
end

function var_0_4.registerProxy(arg_10_0, arg_10_1)
	arg_10_0.model:registerProxy(arg_10_1)

	return
end

function var_0_4.retrieveProxy(arg_11_0, arg_11_1)
	return arg_11_0.model:retrieveProxy(arg_11_1)
end

function var_0_4.removeProxy(arg_12_0, arg_12_1)
	local var_12_0

	if arg_12_0.model ~= nil then
		var_12_0 = arg_12_0.model:removeProxy(arg_12_1)
	end

	return var_12_0
end

function var_0_4.hasProxy(arg_13_0, arg_13_1)
	return arg_13_0.model:hasProxy(arg_13_1)
end

function var_0_4.registerMediator(arg_14_0, arg_14_1)
	if arg_14_0.view ~= nil then
		arg_14_0.view:registerMediator(arg_14_1)
	end

	return
end

function var_0_4.retrieveMediator(arg_15_0, arg_15_1)
	return arg_15_0.view:retrieveMediator(arg_15_1)
end

function var_0_4.removeMediator(arg_16_0, arg_16_1)
	local var_16_0

	if arg_16_0.view ~= nil then
		var_16_0 = arg_16_0.view:removeMediator(arg_16_1)
	end

	return var_16_0
end

function var_0_4.hasMediator(arg_17_0, arg_17_1)
	return arg_17_0.view:hasMediator(arg_17_1)
end

function var_0_4.sendNotification(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0:notifyObservers(var_0_3.New(arg_18_1, arg_18_2, arg_18_3))

	return
end

function var_0_4.notifyObservers(arg_19_0, arg_19_1)
	if arg_19_0.view ~= nil then
		arg_19_0.view:notifyObservers(arg_19_1)
	end

	return
end

function var_0_4.initializeNotifier(arg_20_0, arg_20_1)
	arg_20_0.multitonKey = arg_20_1

	return
end

function var_0_4.hasCore(arg_21_0)
	return var_0_4.instanceMap[arg_21_0] ~= nil
end

function var_0_4.removeCore(arg_22_0)
	if var_0_4.instanceMap[arg_22_0] == nil then
		return
	end

	var_0_1.removeModel(arg_22_0)
	var_0_2.removeView(arg_22_0)
	var_0_0.removeController(arg_22_0)

	var_0_4.instanceMap[arg_22_0] = nil

	return
end

var_0_4.instanceMap = {}
var_0_4.MULTITON_MSG = "Facade instance for this Multiton key already constructed!"

return var_0_4
