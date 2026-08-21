local var_0_0 = class("ActivityAttributeArenaTagItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	local var_4_0 = ActivityAttributeArenaCfg[arg_4_1]

	if var_4_0 then
		arg_4_0.m_tag.sprite = HeroTools.GetSkillAttributeIcon(var_4_0.attribute)
	end
end

return var_0_0
