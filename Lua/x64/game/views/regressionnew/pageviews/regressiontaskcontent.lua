local var_0_0 = class("RegressionTaskContent", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:BindCfgUI()
	arg_2_0:InitNode()
end

function var_0_0.InitNode(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.RefreshTime(arg_5_0, arg_5_1)
	return
end

function var_0_0.RefreshUI(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
