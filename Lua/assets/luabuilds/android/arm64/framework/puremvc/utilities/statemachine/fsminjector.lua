local var_0_0 = class("FSMInjector", (import("...patterns.observer.Notifier")))
local var_0_1 = import(".StateMachine")
local var_0_2 = import(".State")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.fsm = arg_1_1

	return
end

function var_0_0.inject(arg_2_0)
	local var_2_0 = var_0_1.New()

	for iter_2_0, iter_2_1 in ipairs((arg_2_0:getStates())) do
		var_2_0:registerState(iter_2_1, arg_2_0:isInitial(iter_2_1.name))
	end

	arg_2_0.facade:registerMediator(var_2_0)

	return
end

function var_0_0.getStates(arg_3_0)
	if arg_3_0.stateList == nil then
		arg_3_0.stateList = {}

		local var_3_0 = arg_3_0.fsm.state or {}

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			table.insert(arg_3_0.stateList, (arg_3_0:createState(iter_3_1)))
		end
	end

	return arg_3_0.stateList
end

function var_0_0.createState(arg_4_0, arg_4_1)
	local var_4_0 = var_0_2.New(arg_4_1["@name"], arg_4_1["@entering"], arg_4_1["@exiting"], arg_4_1["@changed"])
	local var_4_1 = arg_4_1.transition or {}

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		var_4_0:defineTrans(iter_4_1["@action"], iter_4_1["@target"])
	end

	return var_4_0
end

function var_0_0.isInitial(arg_5_0, arg_5_1)
	return arg_5_1 == arg_5_0.fsm["@initial"]
end

return var_0_0
