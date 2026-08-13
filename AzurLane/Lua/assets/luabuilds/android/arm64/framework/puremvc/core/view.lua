import = var_0_10000

local var_0_0 = var_0_10000("..patterns.observer.Observer")

class = var_0_10001

local var_0_1 = var_0_10001("View")

function var_0_1.Ctor(arg_1_0, arg_1_1)
	if var_0_1.instanceMap[arg_1_1] ~= nil then
		error = var_2

		var_2(var_0_1.MULTITON_MSG)
	end

	arg_1_0.multitonKey = arg_1_1
	var_0_1.instanceMap[arg_1_0.multitonKey] = arg_1_0
	arg_1_0.mediatorMap = {}
	arg_1_0.observerMap = {}

	arg_1_0:initializeView()

	return
end

function var_0_1.initializeView(arg_2_0)
	return
end

function var_0_1.getInstance(arg_3_0)
	if arg_3_0 == nil then
		return nil
	end

	if var_0_1.instanceMap[arg_3_0] == nil then
		return var_0_1.New(arg_3_0)
	else
		return var_0_1.instanceMap[arg_3_0]
	end

	return
end

function var_0_1.registerObserver(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.observerMap[arg_4_1] ~= nil then
		table = var_3

		var_3.insert(arg_4_0.observerMap[arg_4_1], arg_4_2)
	else
		arg_4_0.observerMap[arg_4_1] = {
			arg_4_2
		}
	end

	return
end

function var_0_1.notifyObservers(arg_5_0, arg_5_1)
	if arg_5_0.observerMap[arg_5_1:getName()] ~= nil then
		table = var_3

		local var_5_0 = var_3.shallowCopy(var_2)

		pairs = var_1_10004

		for iter_5_0, iter_5_1 in var_1_10004(var_5_0) do
			table = var_1_10009

			if var_1_10009.contains(var_2, iter_5_1) then
				iter_5_1:notifyObserver(arg_5_1)
			end
		end

		local var_5_1
	end

	return
end

function var_0_1.removeObserver(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.observerMap[arg_6_1]

	pairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(var_6_0) do
		if iter_6_1:compareNotifyContext(arg_6_2) then
			table = var_9

			var_9.remove(var_6_0, iter_6_0)

			break
		end
	end

	if #var_6_0 == 0 then
		arg_6_0.observerMap[arg_6_1] = nil
	end

	return
end

function var_0_1.registerMediator(arg_7_0, arg_7_1)
	if arg_7_0.mediatorMap[arg_7_1:getMediatorName()] ~= nil then
		return
	end

	arg_7_1:initializeNotifier(arg_7_0.multitonKey)

	arg_7_0.mediatorMap[arg_7_1:getMediatorName()] = arg_7_1

	local var_7_0 = #arg_7_1:listNotificationInterests()

	if 0 < var_7_0 then
		local var_7_1 = var_0_0.New(arg_7_1.handleNotification, arg_7_1)

		pairs = var_4

		for iter_7_0, iter_7_1 in var_4(var_2) do
			arg_7_0:registerObserver(iter_7_1, var_7_1)
		end
	end

	arg_7_1:onRegister()

	return
end

function var_0_1.retrieveMediator(arg_8_0, arg_8_1)
	return arg_8_0.mediatorMap[arg_8_1]
end

function var_0_1.removeMediator(arg_9_0, arg_9_1)
	if arg_9_0.mediatorMap[arg_9_1] ~= nil then
		local var_9_0 = var_2:listNotificationInterests()

		pairs = var_1_10004

		for iter_9_0, iter_9_1 in var_1_10004(var_9_0) do
			arg_9_0:removeObserver(iter_9_1, var_2)
		end

		arg_9_0.mediatorMap[arg_9_1] = nil

		var_2:onRemove()
	end

	return var_2
end

function var_0_1.hasMediator(arg_10_0, arg_10_1)
	return arg_10_0.mediatorMap[arg_10_1] ~= nil
end

function var_0_1.removeView(arg_11_0)
	var_0_1.instanceMap[arg_11_0] = nil

	return
end

var_0_1.instanceMap = {}
var_0_1.MULTITON_MSG = "View instance for this Multiton key already constructed!"

return var_0_1
