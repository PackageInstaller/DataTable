ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001
var_0.EventDispatcher = var_0_10001("EventDispatcher")
var_1.__name = "EventDispatcher"
var_1.FUNC_NAME_REGISTER = "RegisterEventListener"
var_1.FUNC_NAME_UNREGISTER = "UnregisterEventListener"
var_1.FUNC_NAME_DISPATCH = "DispatchEvent"

function var_1.AttachEventDispatcher(arg_1_0)
	var_0.New(arg_1_0)

	return
end

function var_1.DetachEventDispatcher(arg_2_0)
	if arg_2_0._dispatcher_ == nil then
		return
	end

	local var_2_0 = arg_2_0._dispatcher_

	var_1._Destory_(var_2_0)

	arg_2_0._dispatcher_ = nil

	return
end

function var_1.Ctor(arg_3_0, arg_3_1)
	arg_3_0._target_ = arg_3_1

	arg_3_0:_Init_()

	return
end

function var_1._Init_(arg_4_0)
	arg_4_0._listenerMap_ = {}
	arg_4_0._target_[var_0.FUNC_NAME_REGISTER] = var_0._RegisterEventListener_
	arg_4_0._target_[var_0.FUNC_NAME_UNREGISTER] = var_0._UnregisterEventListener_
	arg_4_0._target_[var_0.FUNC_NAME_DISPATCH] = var_0._DispatchEvent_
	arg_4_0._target_._dispatcher_ = arg_4_0

	return
end

function var_1._Destory_(arg_5_0)
	arg_5_0._listenerMap_ = nil
	arg_5_0._target_ = nil

	return
end

function var_1._DispatchEvent_(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._dispatcher_
	local var_6_1

	if not arg_6_1.Dispatcher then
		var_6_1 = var_6_0._target_
	end

	arg_6_1.Dispatcher = var_6_1

	local var_6_2 = arg_6_1.ID

	if var_6_0._listenerMap_[var_6_2] then
		ipairs = var_1_10005

		for iter_6_0, iter_6_1 in var_1_10005(var_4) do
			iter_6_1:_Handle_(arg_6_1)
		end
	end

	return
end

function var_1._RegisterEventListener_(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0._dispatcher_

	assert = var_1_10005

	var_1_10005(arg_7_1._eventListener_ ~= nil, "EventDispatcher ERROR" .. arg_7_1.__cname)

	if var_7_0._listenerMap_[arg_7_2] == nil then
		var_7_0._listenerMap_[arg_7_2] = {}
	end

	var_5[#var_7_0._listenerMap_[arg_7_2] + 1] = arg_7_1._eventListener_

	local var_7_1 = arg_7_1._eventListener_

	var_6._AddRoute_(var_7_1, arg_7_2, arg_7_0, arg_7_3)

	return
end

function var_1._UnregisterEventListener_(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._dispatcher_

	arg_8_1 = arg_8_1._eventListener_

	if var_8_0._listenerMap_[arg_8_2] == nil then
		return
	end

	local var_8_1 = var_8_0._listenerMap_[arg_8_2]

	arg_8_1:_RemoveRoute_(arg_8_2, arg_8_0)

	ipairs = var_5

	for iter_8_0, iter_8_1 in var_5(var_8_1) do
		if iter_8_1 == arg_8_1 then
			local var_8_2 = iter_8_0

			for iter_8_2 = #var_8_1, 1, -1 do
				var_8_1[iter_8_2] = nil
			end

			var_8_1[#var_8_1] = nil

			break
		end
	end

	if #var_8_1 == 0 then
		var_8_0._listenerMap_[arg_8_2] = nil
	end

	return
end

return
