local var_0_0 = class("ChallengeRogueTeamOverStatisticsSummarySuitSkillItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.suitSkillID_ = arg_1_3
	arg_1_0.cnt_ = arg_1_4

	arg_1_0:RefreshUI()
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

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = RogueTeamItemCfg[arg_4_0.suitSkillID_].camp[1]

	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetCampIcon(var_4_0))
	arg_4_0.numText_.text = string.format("%d", arg_4_0.cnt_)

	SetActive(arg_4_0.gameObject_, true)
end

return var_0_0
