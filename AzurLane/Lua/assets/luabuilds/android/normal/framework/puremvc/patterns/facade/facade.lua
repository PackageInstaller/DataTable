import = var_0_10000

local var_0_0 = var_0_10000("...core.Controller")

import = var_1

local var_0_1 = var_1("...core.Model")

import = var_2

local var_0_2 = var_2("...core.View")

import = var_3

local var_0_3 = var_3("..observer.Notification")

class = var_4

local var_0_4 = var_4("Facade")

function var_0_4.Ctor(arg_1_0, arg_1_1)
	if var_0_4.instanceMap[arg_1_1] ~= nil then
		error = var_2

		var_2(var_0_4.MULTITON_MSG)
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
	assert = var_1_10003

	var_1_10003(arg_7_2)

	local var_7_0 = arg_7_0.controller

	var_3.registerCommand(var_7_0, arg_7_1, arg_7_2)

	return
end

function var_0_4.removeCommand(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.controller

	var_2.removeCommand(var_8_0, arg_8_1)

	return
end

function var_0_4.hasCommand(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.controller

	return var_2.hasCommand(var_9_0, arg_9_1)
end

function var_0_4.registerProxy(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.model

	var_2.registerProxy(var_10_0, arg_10_1)

	return
end

function var_0_4.retrieveProxy(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.model

	return var_2.retrieveProxy(var_11_0, arg_11_1)
end

function var_0_4.removeProxy(arg_12_0, arg_12_1)
	local var_12_0

	if arg_12_0.model ~= nil then
		local var_12_1 = arg_12_0.model

		var_12_0 = var_3.removeProxy(var_12_1, arg_12_1)
	end

	return var_12_0
end

function var_0_4.hasProxy(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.model

	return var_2.hasProxy(var_13_0, arg_13_1)
end

function var_0_4.registerMediator(arg_14_0, arg_14_1)
	if arg_14_0.view ~= nil then
		local var_14_0 = arg_14_0.view

		var_2.registerMediator(var_14_0, arg_14_1)
	end

	return
end

function var_0_4.retrieveMediator(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.view

	return var_2.retrieveMediator(var_15_0, arg_15_1)
end

function var_0_4.removeMediator(arg_16_0, arg_16_1)
	local var_16_0

	if arg_16_0.view ~= nil then
		local var_16_1 = arg_16_0.view

		var_16_0 = var_3.removeMediator(var_16_1, arg_16_1)
	end

	return var_16_0
end

function var_0_4.hasMediator(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.view

	return var_2.hasMediator(var_17_0, arg_17_1)
end

function var_0_4.sendNotification(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0:notifyObservers(var_0_3.New(arg_18_1, arg_18_2, arg_18_3))

	return
end

function var_0_4.notifyObservers(arg_19_0, arg_19_1)
	if arg_19_0.view ~= nil then
		local var_19_0 = arg_19_0.view

		var_2.notifyObservers(var_19_0, arg_19_1)
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
