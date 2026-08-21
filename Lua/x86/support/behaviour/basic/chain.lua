local var_0_0 = import("..BehaviourBase")
local var_0_1 = class("Chain", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, "ChainBehaviour")

	arg_1_0.father_ = arg_1_1
	arg_1_0.children_ = {}
	arg_1_0.active_ = true
	arg_1_0.handleChainEventCallbackName_ = arg_1_2 or "HandleChainEvent"
end

function var_0_1.AddChainChild(arg_2_0, arg_2_1)
	table.insert(arg_2_0.children_, arg_2_1)
end

function var_0_1.RemoveChainChild(arg_3_0, arg_3_1)
	local var_3_0 = table.removebyvalue(arg_3_0.children_, arg_3_1)
end

function var_0_1.SetChainFather(arg_4_0, arg_4_1)
	arg_4_0.father_ = arg_4_1
end

function var_0_1.DispatchEventInChain(arg_5_0, arg_5_1)
	arg_5_1.stop_ = false

	function arg_5_1.stop(arg_6_0)
		arg_6_0.stop_ = true
	end

	arg_5_0:DoDispatchEventInChain(arg_5_1, {})
end

function var_0_1.DoDispatchEventInChain(arg_7_0, arg_7_1, arg_7_2)
	if table.indexof(arg_7_2, arg_7_0.target_) ~= false then
		return
	end

	table.insert(arg_7_2, arg_7_0.target_)

	if arg_7_0.active_ then
		arg_7_0.target_[arg_7_0.handleChainEventCallbackName_](arg_7_0.target_, arg_7_1)

		if arg_7_1.stop_ then
			return
		end
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.children_) do
		if table.indexof(arg_7_2, iter_7_1) == false then
			iter_7_1:DoDispatchEventInChain(arg_7_1, arg_7_2)

			if arg_7_1.stop_ then
				return
			end
		end
	end

	if arg_7_0.father_ and table.indexof(arg_7_2, arg_7_0.father_) == false then
		arg_7_0.father_:DoDispatchEventInChain(arg_7_1, arg_7_2)

		if arg_7_1.stop_ then
			return
		end
	end
end

function var_0_1.SetHandleChainActive(arg_8_0, arg_8_1)
	arg_8_0.active_ = arg_8_1
end

function var_0_1.OnBind_(arg_9_0)
	arg_9_0:ExportMethods_({
		"SetHandleChainActive",
		"AddChainChild",
		"RemoveChainChild",
		"SetChainFather",
		"DispatchEventInChain",
		"DoDispatchEventInChain"
	})

	if arg_9_0.father_ then
		arg_9_0.father_:AddChainChild(arg_9_0.target_)
	end

	arg_9_0.target_:BindMethod(arg_9_0, "Dispose", arg_9_0.Dispose)

	return arg_9_0.target_
end

function var_0_1.OnUnbind_(arg_10_0)
	arg_10_0:Dispose()
	arg_10_0.target_:UnbindMethod(arg_10_0, "Dispose")
end

function var_0_1.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.children_) do
		iter_11_1:SetChainFather(arg_11_0.father_)
		arg_11_0.father_:AddChainChild(iter_11_1)
	end

	arg_11_0.father_:RemoveChainChild(arg_11_0.target_)

	arg_11_0.father_ = nil
	arg_11_0.children_ = nil
end

return var_0_1
