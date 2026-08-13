class = var_0_10000

local var_0_0 = var_0_10000("BaseEventLogic")

require = var_0_10001

local var_0_1 = var_0_10001("Framework.notify.event")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.eventCounter = 1
	arg_1_0.eventStore = {}
	arg_1_0.event = arg_1_1 or var_0_1.New()
	arg_1_0.tweenIdList = {}

	return
end

function var_0_0.bind(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.event

	var_3.connect(var_2_0, arg_2_1, arg_2_2)

	local var_2_1 = arg_2_0.eventCounter

	arg_2_0.eventStore[var_2_1] = {
		event = arg_2_1,
		callback = arg_2_2
	}
	arg_2_0.eventCounter = arg_2_0.eventCounter + 1

	return var_2_1
end

function var_0_0.emit(arg_3_0, ...)
	if arg_3_0.event then
		local var_3_0 = arg_3_0.event

		var_1.emit(var_3_0, ...)
	end

	return
end

function var_0_0.disconnect(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.eventStore[arg_4_1]

	assert = var_1_10003

	var_1_10003(var_4_0, arg_4_1)

	if var_4_0 then
		local var_4_1 = arg_4_0.event

		var_3.disconnect(var_4_1, var_4_0.event, var_4_0.callback)

		arg_4_0.eventStore[arg_4_1] = nil
	end

	return
end

function var_0_0.disposeEvent(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.eventStore) do
		local var_5_0 = arg_5_0.event

		var_6.disconnect(var_5_0, iter_5_1.event, iter_5_1.callback)
	end

	arg_5_0.eventStore = {}

	return
end

function var_0_0.managedTween(arg_6_0, arg_6_1, arg_6_2, ...)
	local var_6_0 = arg_6_1(...)
	local var_6_1 = var_3.setOnComplete

	System = var_1_10007

	var_6_1(var_6_0, var_1_10007.Action(function()
		table = var_2_10000

		var_2_10000.removebyvalue(arg_6_0.tweenIdList, var_0.uniqueId)

		if arg_6_2 then
			arg_6_2()
		end

		return
	end))

	arg_6_0.tweenIdList[#arg_6_0.tweenIdList + 1] = var_3.uniqueId

	return var_3
end

function var_0_0.cleanManagedTween(arg_8_0, arg_8_1)
	defaultValue = var_1_10002
	arg_8_1 = var_1_10002(arg_8_1, false)
	ipairs = var_2

	for iter_8_0, iter_8_1 in var_2(arg_8_0.tweenIdList) do
		LeanTween = var_1_10007

		if var_1_10007.isTweening(iter_8_1) then
			LeanTween = var_1_10007

			var_1_10007.cancel(iter_8_1, arg_8_1)
		end
	end

	arg_8_0.tweenIdList = {}

	return
end

function var_0_0.pauseManagedTween(arg_9_0)
	ipairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.tweenIdList) do
		LeanTween = var_1_10006

		if var_1_10006.isTweening(iter_9_1) then
			LeanTween = var_1_10006

			var_1_10006.pause(iter_9_1)
		end
	end

	return
end

function var_0_0.resumeManagedTween(arg_10_0)
	ipairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.tweenIdList) do
		LeanTween = var_1_10006

		if var_1_10006.isTweening(iter_10_1) then
			LeanTween = var_1_10006

			var_1_10006.resume(iter_10_1)
		end
	end

	return
end

function var_0_0.AddLeanTween(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1()

	assert = var_1_10003

	var_1_10003(var_11_0)

	arg_11_0.tweenIdList[#arg_11_0.tweenIdList + 1] = var_11_0.uniqueId

	return
end

return var_0_0
