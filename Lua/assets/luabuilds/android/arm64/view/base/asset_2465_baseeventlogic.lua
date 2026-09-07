local BaseEventLogic = class("BaseEventLogic")
local event = require("Framework.notify.event")

function BaseEventLogic:Ctor(arg_1_1)
	self.eventCounter = 1
	self.eventStore = {}
	self.event = arg_1_1 or event.New()
	self.tweenIdList = {}

	return
end

function BaseEventLogic:bind(arg_2_1, arg_2_2)
	self.event:connect(arg_2_1, arg_2_2)

	self.eventStore[self.eventCounter] = {
		event = arg_2_1,
		callback = arg_2_2
	}
	self.eventCounter = self.eventCounter + 1

	return self.eventCounter
end

function BaseEventLogic:emit(...)
	if self.event then
		self.event:emit(...)
	end

	return
end

function BaseEventLogic:disconnect(arg_4_1)
	assert(self.eventStore[arg_4_1], arg_4_1)

	if self.eventStore[arg_4_1] then
		self.event:disconnect(self.eventStore[arg_4_1].event, self.eventStore[arg_4_1].callback)

		self.eventStore[arg_4_1] = nil
	end

	return
end

function BaseEventLogic:disposeEvent()
	for iter_5_0, iter_5_1 in pairs(self.eventStore) do
		self.event:disconnect(iter_5_1.event, iter_5_1.callback)
	end

	self.eventStore = {}

	return
end

function BaseEventLogic:managedTween(arg_6_1, arg_6_2, ...)
	local var_6_0 = arg_6_1(...)

	var_6_0:setOnComplete(System.Action(function()
		table.removebyvalue(self.tweenIdList, var_6_0.uniqueId)

		if arg_6_2 then
			arg_6_2()
		end

		return
	end))

	self.tweenIdList[#self.tweenIdList + 1] = var_6_0.uniqueId

	return var_6_0
end

function BaseEventLogic:cleanManagedTween(arg_8_1)
	arg_8_1 = defaultValue(arg_8_1, false)

	for iter_8_0, iter_8_1 in ipairs(self.tweenIdList) do
		if LeanTween.isTweening(iter_8_1) then
			LeanTween.cancel(iter_8_1, arg_8_1)
		end
	end

	self.tweenIdList = {}

	return
end

function BaseEventLogic:pauseManagedTween()
	for iter_9_0, iter_9_1 in ipairs(self.tweenIdList) do
		if LeanTween.isTweening(iter_9_1) then
			LeanTween.pause(iter_9_1)
		end
	end

	return
end

function BaseEventLogic:resumeManagedTween()
	for iter_10_0, iter_10_1 in ipairs(self.tweenIdList) do
		if LeanTween.isTweening(iter_10_1) then
			LeanTween.resume(iter_10_1)
		end
	end

	return
end

function BaseEventLogic:AddLeanTween(arg_11_1)
	local var_11_0 = arg_11_1()

	assert(var_11_0)

	self.tweenIdList[#self.tweenIdList + 1] = var_11_0.uniqueId

	return
end

return BaseEventLogic
