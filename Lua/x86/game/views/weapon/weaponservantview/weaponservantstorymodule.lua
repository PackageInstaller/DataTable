local var_0_0 = class("WeaponServantStoryModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.OnRenderModule(arg_3_0, arg_3_1)
	arg_3_0.storyText_.text = WeaponServantCfg[arg_3_1.servantData.id].story
end

return var_0_0
