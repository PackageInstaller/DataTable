local var_0_0 = class("Dorm3dBaseScene", import("view.base.BaseUI"))

function var_0_0.GetDefaultSystemClasses()
	return DormConst.GetDefaultSystemClasses()
end

function var_0_0.InitExtraSystem(arg_2_0, arg_2_1)
	arg_2_0.systemManager = arg_2_0.systemManager or ExtraSystemManager.New(arg_2_0.event, arg_2_0)
	arg_2_1 = arg_2_1 or arg_2_0.GetDefaultSystemClasses()

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0.systemManager:Register(iter_2_1)
	end

	return
end

function var_0_0.RemoveExtraSystem(arg_3_0, arg_3_1)
	if not arg_3_0.systemManager then
		return
	end

	arg_3_1 = arg_3_1 or arg_3_0.GetDefaultSystemClasses()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0.systemManager:Remove(iter_3_1)
	end

	return
end

function var_0_0.GetExtraSystem(arg_4_0, arg_4_1)
	if not arg_4_0.systemManager then
		return nil
	end

	return arg_4_0.systemManager:Get(arg_4_1)
end

function var_0_0.willExit(arg_5_0)
	arg_5_0:RemoveExtraSystem()

	if arg_5_0.systemManager then
		arg_5_0.systemManager:Dispose()

		arg_5_0.systemManager = nil
	end

	return
end

return var_0_0
