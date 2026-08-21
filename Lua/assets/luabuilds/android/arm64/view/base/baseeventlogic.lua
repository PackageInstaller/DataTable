local var_0_0 = class("BaseEventLogic")
local var_0_1 = require("Framework.notify.event")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.eventCounter = 1
	arg_1_0.eventStore = {}
	arg_1_0.event = arg_1_1 or var_0_1.New()
	arg_1_0.tweenIdList = {}

	return
end

function var_0_0.bind(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.event:connect(arg_2_1, arg_2_2)

	arg_2_0.eventStore[arg_2_0.eventCounter] = {
		event = arg_2_1,
		callback = arg_2_2
	}
	arg_2_0.eventCounter = arg_2_0.eventCounter + 1

	return arg_2_0.eventCounter
end

function var_0_0.emit(arg_3_0, ...)
	if arg_3_0.event then
		arg_3_0.event:emit(...)
	end

	return
end

function var_0_0.disconnect(arg_4_0, arg_4_1)
	assert(arg_4_0.eventStore[arg_4_1], arg_4_1)

	if arg_4_0.eventStore[arg_4_1] then
		arg_4_0.event:disconnect(arg_4_0.eventStore[arg_4_1].event, arg_4_0.eventStore[arg_4_1].callback)

		arg_4_0.eventStore[arg_4_1] = nil
	end

	return
end

function var_0_0.disposeEvent(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.eventStore) do
		arg_5_0.event:disconnect(iter_5_1.event, iter_5_1.callback)
	end

	arg_5_0.eventStore = {}

	return
end

function var_0_0.managedTween(arg_6_0, arg_6_1, arg_6_2, ...)
	local var_6_0 = arg_6_1(...)

	var_6_0:setOnComplete(System.Action(function()
		table.removebyvalue(arg_6_0.tweenIdList, var_6_0.uniqueId)

		if arg_6_2 then
			arg_6_2()
		end

		return
	end))

	arg_6_0.tweenIdList[#arg_6_0.tweenIdList + 1] = var_6_0.uniqueId

	return var_6_0
end

function var_0_0.cleanManagedTween(arg_8_0, arg_8_1)
	arg_8_1 = defaultValue(arg_8_1, false)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.tweenIdList) do
		if LeanTween.isTweening(iter_8_1) then
			LeanTween.cancel(iter_8_1, arg_8_1)
		end
	end

	arg_8_0.tweenIdList = {}

	return
end

function var_0_0.pauseManagedTween(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.tweenIdList) do
		if LeanTween.isTweening(iter_9_1) then
			LeanTween.pause(iter_9_1)
		end
	end

	return
end

function var_0_0.resumeManagedTween(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.tweenIdList) do
		if LeanTween.isTweening(iter_10_1) then
			LeanTween.resume(iter_10_1)
		end
	end

	return
end

function var_0_0.AddLeanTween(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1()

	assert(var_11_0)

	arg_11_0.tweenIdList[#arg_11_0.tweenIdList + 1] = var_11_0.uniqueId

	return
end

return var_0_0
