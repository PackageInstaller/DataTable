class = var_0_10000

local var_0_0 = "Dorm3dBaseScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.GetDefaultSystemClasses()
	DormConst = var_1_10000

	return var_1_10000.GetDefaultSystemClasses()
end

function var_0_1.InitExtraSystem(arg_2_0, arg_2_1)
	if not arg_2_0.systemManager then
		ExtraSystemManager = var_2
		arg_2_0.systemManager = var_2.New(arg_2_0.event, arg_2_0)
	end

	arg_2_1 = arg_2_1 or arg_2_0.GetDefaultSystemClasses()
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1) do
		local var_2_0 = arg_2_0.systemManager

		var_7.Register(var_2_0, iter_2_1)
	end

	return
end

function var_0_1.RemoveExtraSystem(arg_3_0, arg_3_1)
	if not arg_3_0.systemManager then
		return
	end

	arg_3_1 = arg_3_1 or arg_3_0.GetDefaultSystemClasses()
	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_1) do
		local var_3_0 = arg_3_0.systemManager

		var_7.Remove(var_3_0, iter_3_1)
	end

	return
end

function var_0_1.GetExtraSystem(arg_4_0, arg_4_1)
	if not arg_4_0.systemManager then
		return nil
	end

	local var_4_0 = arg_4_0.systemManager

	return var_2.Get(var_4_0, arg_4_1)
end

function var_0_1.willExit(arg_5_0)
	arg_5_0:RemoveExtraSystem()

	if arg_5_0.systemManager then
		local var_5_0 = arg_5_0.systemManager

		var_1.Dispose(var_5_0)

		arg_5_0.systemManager = nil
	end

	return
end

return var_0_1
