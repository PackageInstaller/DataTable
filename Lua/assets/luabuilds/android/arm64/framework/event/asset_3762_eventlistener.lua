ys = ys or {}

local var_0_0 = ys

ys.EventListener = class("EventListener")
ys.EventListener.__name = "EventListener"

function ys.EventListener.AttachEventListener(arg_1_0)
	var_0_0.EventListener.New(arg_1_0)

	return
end

function ys.EventListener:DetachEventListener()
	if self._eventListener_ == nil then
		return
	end

	self._eventListener_:_Destory_()

	self._eventListener_ = nil

	return
end

function ys.EventListener:Ctor(arg_3_1)
	self._target_ = arg_3_1
	self._target_._eventListener_ = self
	self._routeMap_ = {}

	return
end

function ys.EventListener._Destory_(arg_4_0)
	arg_4_0._routeMap_ = nil
	arg_4_0._target_ = nil

	return
end

function ys.EventListener:_AddRoute_(arg_5_1, arg_5_2, arg_5_3)
	if self._routeMap_[arg_5_1] == nil then
		self._routeMap_[arg_5_1] = {}
	end

	self._routeMap_[arg_5_1][arg_5_2] = arg_5_3

	return
end

function ys.EventListener:_RemoveRoute_(arg_6_1, arg_6_2)
	self._routeMap_[arg_6_1][arg_6_2] = nil

	return
end

function ys.EventListener:_Handle_(arg_7_1)
	self._routeMap_[arg_7_1.ID][arg_7_1.Dispatcher](self._target_, arg_7_1)

	return
end

return
