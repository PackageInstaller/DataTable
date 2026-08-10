local var_0_0 = class("EnterBattleRaceListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.iconImg_.sprite = HeroTools.GetRaceIcon(arg_2_1)
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
