local var_0_0 = class("BuffDescriptionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.levelCon_ = ControllerUtil.GetController(arg_3_0.transform_, "level")
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.affix_ = arg_6_1
	arg_6_0.title_.text = GetI18NText(AffixTypeCfg[arg_6_0.affix_[1]].name)

	arg_6_0.levelCon_:SetSelectedState(arg_6_0.affix_[2])

	arg_6_0.desc_.text = GetI18NText(getAffixDesc(arg_6_0.affix_))
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
