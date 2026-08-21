ys = ys or {}

local var_0_0 = ys

ys.EventListener = class("EventListener")
ys.EventListener.__name = "EventListener"

function ys.EventListener.AttachEventListener(arg_1_0)
	var_0_0.EventListener.New(arg_1_0)

	return
end

function ys.EventListener.DetachEventListener(arg_2_0)
	if arg_2_0._eventListener_ == nil then
		return
	end

	arg_2_0._eventListener_:_Destory_()

	arg_2_0._eventListener_ = nil

	return
end

function ys.EventListener.Ctor(arg_3_0, arg_3_1)
	arg_3_0._target_ = arg_3_1
	arg_3_0._target_._eventListener_ = arg_3_0
	arg_3_0._routeMap_ = {}

	return
end

function ys.EventListener._Destory_(arg_4_0)
	arg_4_0._routeMap_ = nil
	arg_4_0._target_ = nil

	return
end

function ys.EventListener._AddRoute_(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0._routeMap_[arg_5_1] == nil then
		arg_5_0._routeMap_[arg_5_1] = {}
	end

	arg_5_0._routeMap_[arg_5_1][arg_5_2] = arg_5_3

	return
end

function ys.EventListener._RemoveRoute_(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._routeMap_[arg_6_1][arg_6_2] = nil

	return
end

function ys.EventListener._Handle_(arg_7_0, arg_7_1)
	arg_7_0._routeMap_[arg_7_1.ID][arg_7_1.Dispatcher](arg_7_0._target_, arg_7_1)

	return
end

return
