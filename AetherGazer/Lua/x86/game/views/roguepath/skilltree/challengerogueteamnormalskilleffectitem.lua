local var_0_0 = class("ChallengeRogueTeamNormalSkillEffectItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.value_ = 0
	arg_4_0.skillTemp_ = arg_4_1
	arg_4_0.cfg_ = RogueTeamSkillTreeCfg[RogueTeamSkillTreeCfg.get_id_list_by_show_temp[arg_4_1][1]]
	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(arg_4_0.cfg_.icon)
	arg_4_0.name_.text = arg_4_0.cfg_.show_desc

	arg_4_0:Show(true)
end

function var_0_0.UpdateValue(arg_5_0, arg_5_1)
	arg_5_0.value_ = arg_5_0.value_ + arg_5_1
	arg_5_0.valueText_.text = arg_5_0.value_ .. (arg_5_0.cfg_.show_value[1] == 1 and "%" or "")
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

return var_0_0
