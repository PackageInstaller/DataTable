ys = ys or {}

local EventDispatcher = class("EventDispatcher")

ys.EventDispatcher = EventDispatcher
EventDispatcher.__name = "EventDispatcher"
EventDispatcher.FUNC_NAME_REGISTER = "RegisterEventListener"
EventDispatcher.FUNC_NAME_UNREGISTER = "UnregisterEventListener"
EventDispatcher.FUNC_NAME_DISPATCH = "DispatchEvent"

function EventDispatcher:AttachEventDispatcher()
	EventDispatcher.New(self)

	return
end

function EventDispatcher:DetachEventDispatcher()
	if self._dispatcher_ == nil then
		return
	end

	self._dispatcher_:_Destory_()

	self._dispatcher_ = nil

	return
end

function EventDispatcher:Ctor(arg_3_1)
	self._target_ = arg_3_1

	self:_Init_()

	return
end

function EventDispatcher:_Init_()
	self._listenerMap_ = {}
	self._target_[EventDispatcher.FUNC_NAME_REGISTER] = EventDispatcher._RegisterEventListener_
	self._target_[EventDispatcher.FUNC_NAME_UNREGISTER] = EventDispatcher._UnregisterEventListener_
	self._target_[EventDispatcher.FUNC_NAME_DISPATCH] = EventDispatcher._DispatchEvent_
	self._target_._dispatcher_ = self

	return
end

function EventDispatcher:_Destory_()
	self._listenerMap_ = nil
	self._target_ = nil

	return
end

function EventDispatcher:_DispatchEvent_(arg_6_1)
	arg_6_1.Dispatcher = arg_6_1.Dispatcher or self._dispatcher_._target_

	if self._dispatcher_._listenerMap_[arg_6_1.ID] then
		for iter_6_0, iter_6_1 in ipairs(self._dispatcher_._listenerMap_[arg_6_1.ID]) do
			iter_6_1:_Handle_(arg_6_1)
		end
	end

	return
end

function EventDispatcher:_RegisterEventListener_(arg_7_1, arg_7_2, arg_7_3)
	assert(arg_7_1._eventListener_ ~= nil, "EventDispatcher ERROR" .. arg_7_1.__cname)

	if self._dispatcher_._listenerMap_[arg_7_2] == nil then
		self._dispatcher_._listenerMap_[arg_7_2] = {}
	end

	self._dispatcher_._listenerMap_[arg_7_2][#self._dispatcher_._listenerMap_[arg_7_2] + 1] = arg_7_1._eventListener_

	arg_7_1._eventListener_:_AddRoute_(arg_7_2, self, arg_7_3)

	return
end

function EventDispatcher:_UnregisterEventListener_(arg_8_1, arg_8_2)
	arg_8_1 = arg_8_1._eventListener_

	if self._dispatcher_._listenerMap_[arg_8_2] == nil then
		return
	end

	local var_8_0 = self._dispatcher_._listenerMap_[arg_8_2]

	arg_8_1:_RemoveRoute_(arg_8_2, self)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if iter_8_1 == arg_8_1 then
			for iter_8_2 = #var_8_0, 1, -1 do
				var_8_0[iter_8_2] = nil
			end

			var_8_0[#var_8_0] = nil

			break
		end
	end

	if #var_8_0 == 0 then
		self._dispatcher_._listenerMap_[arg_8_2] = nil
	end

	return
end

return
