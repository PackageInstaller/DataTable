local var_0_0 = import(".View")
local var_0_1 = import("..patterns.observer.Observer")
local var_0_2 = class("Controller")

function var_0_2.Ctor(arg_1_0, arg_1_1)
	if var_0_2.instanceMap[arg_1_1] ~= nil then
		error(var_0_2.MULTITON_MSG)
	end

	arg_1_0.multitonKey = arg_1_1
	var_0_2.instanceMap[arg_1_0.multitonKey] = arg_1_0
	arg_1_0.commandMap = {}

	arg_1_0:initializeController()

	return
end

function var_0_2.initializeController(arg_2_0)
	arg_2_0.view = var_0_0.getInstance(arg_2_0.multitonKey)

	return
end

function var_0_2.getInstance(arg_3_0)
	if arg_3_0 == nil then
		return nil
	end

	if var_0_2.instanceMap[arg_3_0] == nil then
		return var_0_2.New(arg_3_0)
	else
		return var_0_2.instanceMap[arg_3_0]
	end

	return
end

function var_0_2.executeCommand(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.commandMap[arg_4_1:getName()]

	if var_4_0 == nil then
		return
	end

	local var_4_1 = var_4_0.New()

	var_4_1:initializeNotifier(arg_4_0.multitonKey)
	var_4_1:execute(arg_4_1)

	return
end

function var_0_2.registerCommand(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.commandMap[arg_5_1] == nil then
		arg_5_0.view:registerObserver(arg_5_1, var_0_1.New(arg_5_0.executeCommand, arg_5_0))
	end

	arg_5_0.commandMap[arg_5_1] = arg_5_2

	return
end

function var_0_2.hasCommand(arg_6_0, arg_6_1)
	return arg_6_0.commandMap[arg_6_1] ~= nil
end

function var_0_2.removeCommand(arg_7_0, arg_7_1)
	if arg_7_0:hasCommand(arg_7_1) then
		arg_7_0.view:removeObserver(arg_7_1, arg_7_0)

		arg_7_0.commandMap[arg_7_1] = nil
	end

	return
end

function var_0_2.removeController(arg_8_0)
	var_0_2.instanceMap[arg_8_0] = nil

	return
end

var_0_2.instanceMap = {}
var_0_2.MULTITON_MSG = "controller key for this Multiton key already constructed"

return var_0_2
