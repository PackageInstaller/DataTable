local var_0_0 = class("RogueTeamItemInfoSettingSuitSkillItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.descText_, nil, nil)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	local var_4_0 = RogueTeamItemCfg[arg_4_1]

	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_4_1))
	arg_4_0.nameText_.text = var_4_0.name
	arg_4_0.descText_.text = ChallengeRogueTeamTools.GetItemDesc(arg_4_1, nil, arg_4_0.descText_.color)
end

return var_0_0
