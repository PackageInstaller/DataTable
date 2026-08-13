class = var_0_10000

local var_0_0 = var_0_10000("Model")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	if var_0_0.instanceMap[arg_1_1] then
		error = var_2

		var_2(var_0_0.MULTITON_MSG)
	end

	arg_1_0.multitonKey = arg_1_1
	var_0_0.instanceMap[arg_1_1] = arg_1_0
	arg_1_0.proxyMap = {}

	arg_1_0:initializeModel()

	return
end

function var_0_0.initializeModel(arg_2_0)
	return
end

function var_0_0.getInstance(arg_3_0)
	if arg_3_0 == nil then
		return nil
	end

	if var_0_0.instanceMap[arg_3_0] == nil then
		return var_0_0.New(arg_3_0)
	else
		return var_0_0.instanceMap[arg_3_0]
	end

	return
end

function var_0_0.registerProxy(arg_4_0, arg_4_1)
	arg_4_1:initializeNotifier(arg_4_0.multitonKey)

	arg_4_0.proxyMap[arg_4_1:getProxyName()] = arg_4_1

	arg_4_1:onRegister()

	return
end

function var_0_0.retrieveProxy(arg_5_0, arg_5_1)
	return arg_5_0.proxyMap[arg_5_1]
end

function var_0_0.hasProxy(arg_6_0, arg_6_1)
	return arg_6_0.proxyMap[arg_6_1] ~= nil
end

function var_0_0.removeProxy(arg_7_0, arg_7_1)
	if arg_7_0.proxyMap[arg_7_1] ~= nil then
		arg_7_0.proxyMap[arg_7_1] = nil

		var_2:onRemove()
	end

	return var_2
end

function var_0_0.removeModel(arg_8_0)
	var_0_0.instanceMap[arg_8_0] = nil

	return
end

var_0_0.instanceMap = {}
var_0_0.MULTITON_MSG = "Model instance for this Multiton key already constructed!"

return var_0_0
