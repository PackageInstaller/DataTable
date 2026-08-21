local var_0_0 = class("TangramBaseNode")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.root_ = arg_2_1
	arg_2_0.blackboard_ = arg_2_2
	arg_2_0.manager_ = arg_2_3
end

function var_0_0.RunFunc(arg_3_0)
	arg_3_0.root_:SetNodeRunComplete()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.root_ = nil
	arg_4_0.blackboard_ = nil
	arg_4_0.manager_ = nil
end

return var_0_0
