local var_0_0 = import("..BehaviourBase")
local var_0_1 = class("EventProtocol", var_0_0)

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0, "EventProtocol")

	arg_1_0.listeners_ = {}
	arg_1_0.nextListenerHandleIndex_ = 0
end

function var_0_1.AddEventListener(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0.listeners_[arg_2_1] == nil then
		arg_2_0.listeners_[arg_2_1] = {}
	end

	local var_2_0 = arg_2_2

	arg_2_0.listeners_[arg_2_1][var_2_0] = {
		arg_2_2,
		arg_2_3
	}

	return var_2_0
end

function var_0_1.AddEventListenerShare(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0.listeners_[arg_3_1] == nil then
		arg_3_0.listeners_[arg_3_1] = {}
	end

	arg_3_0.nextListenerHandleIndex_ = arg_3_0.nextListenerHandleIndex_ + 1

	local var_3_0 = tostring(arg_3_0.nextListenerHandleIndex_)

	arg_3_0.listeners_[arg_3_1][var_3_0] = {
		arg_3_2,
		arg_3_3
	}

	return var_3_0
end

function var_0_1.DispatchEvent(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.name or arg_4_1.GetName and arg_4_1:GetName()

	if arg_4_0.listeners_[var_4_0] == nil then
		return
	end

	arg_4_1.emitter = arg_4_0.target_

	for iter_4_0, iter_4_1 in pairs(arg_4_0.listeners_[var_4_0]) do
		iter_4_1[1](arg_4_1)
	end

	return arg_4_0.target_
end

function var_0_1.RemoveEventListener(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.listeners_) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			if iter_5_2 == arg_5_1 then
				iter_5_1[iter_5_2] = nil

				return arg_5_0.target_
			end
		end
	end

	return arg_5_0.target_
end

function var_0_1.RemoveEventListenersByTag(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.listeners_) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if iter_6_3[2] == arg_6_1 then
				iter_6_1[iter_6_2] = nil
			end
		end
	end

	return arg_6_0.target_
end

function var_0_1.RemoveEventListenersByEventAndTag(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.listeners_[arg_7_1]

	if not var_7_0 then
		return arg_7_0.target_
	end

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1[2] == arg_7_2 then
			var_7_0[iter_7_0] = nil
		end
	end

	return arg_7_0.target_
end

function var_0_1.RemoveEventListenersByEvent(arg_8_0, arg_8_1)
	arg_8_0.listeners_[arg_8_1] = nil

	return arg_8_0.target_
end

function var_0_1.RemoveAllEventListeners(arg_9_0)
	arg_9_0.listeners_ = {}

	return arg_9_0.target_
end

function var_0_1.HasEventListener(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.listeners_[arg_10_1]

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		return true
	end

	return false
end

function var_0_1.DumpAllEventListeners(arg_11_0)
	printInfo("---- EventProtocol:dumpAllEventListeners() ----")

	for iter_11_0, iter_11_1 in pairs(arg_11_0.listeners_) do
		printInfo("-- event: %s", iter_11_0)

		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			printInfo("--     listener: %s, handle: %s", tostring(iter_11_3[1]), tostring(iter_11_2))
		end
	end

	return arg_11_0.target_
end

function var_0_1.OnBind_(arg_12_0)
	arg_12_0:ExportMethods_({
		"AddEventListener",
		"AddEventListenerShare",
		"DispatchEvent",
		"RemoveEventListener",
		"RemoveEventListenersByTag",
		"RemoveEventListenersByEvent",
		"RemoveEventListenersByEventAndTag",
		"RemoveAllEventListeners",
		"HasEventListener",
		"DumpAllEventListeners"
	})

	return arg_12_0.target_
end

function var_0_1.OnUnbind_(arg_13_0)
	return
end

return var_0_1
