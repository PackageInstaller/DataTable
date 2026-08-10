local var_0_0 = class("CoreVerificationChallengeRecommendAttributeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	arg_5_0.icon_.sprite = HeroTools.GetSkillAttributeIcon(arg_5_1)
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	arg_6_0.gameObject_:SetActive(arg_6_1)
end

return var_0_0
