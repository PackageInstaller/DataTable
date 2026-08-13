ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001
var_0.EventListener = var_0_10001("EventListener")
var_0.EventListener.__name = "EventListener"

function var_0.EventListener.AttachEventListener(arg_1_0)
	var_0.EventListener.New(arg_1_0)

	return
end

function var_0.EventListener.DetachEventListener(arg_2_0)
	if arg_2_0._eventListener_ == nil then
		return
	end

	local var_2_0 = arg_2_0._eventListener_

	var_1._Destory_(var_2_0)

	arg_2_0._eventListener_ = nil

	return
end

function var_0.EventListener.Ctor(arg_3_0, arg_3_1)
	arg_3_0._target_ = arg_3_1
	arg_3_0._target_._eventListener_ = arg_3_0
	arg_3_0._routeMap_ = {}

	return
end

function var_0.EventListener._Destory_(arg_4_0)
	arg_4_0._routeMap_ = nil
	arg_4_0._target_ = nil

	return
end

function var_0.EventListener._AddRoute_(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0._routeMap_[arg_5_1] == nil then
		arg_5_0._routeMap_[arg_5_1] = {}
	end

	arg_5_0._routeMap_[arg_5_1][arg_5_2] = arg_5_3

	return
end

function var_0.EventListener._RemoveRoute_(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._routeMap_[arg_6_1][arg_6_2] = nil

	return
end

function var_0.EventListener._Handle_(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._target_

	arg_7_0._routeMap_[arg_7_1.ID][arg_7_1.Dispatcher](var_7_0, arg_7_1)

	return
end

return
