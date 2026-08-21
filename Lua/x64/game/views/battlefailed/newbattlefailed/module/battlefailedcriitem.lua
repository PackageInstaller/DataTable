local var_0_0 = class("BattleFailedCriItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.OnRenderItem(arg_2_0, arg_2_1)
	arg_2_0.typeImg_.sprite = arg_2_1
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
