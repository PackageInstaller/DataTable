local var_0_0 = class("ChallengeRogueTeamBagTreasureItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.rareController_ = arg_1_0.controller_:GetController("rare")
end

function var_0_0.AddListeners(arg_2_0)
	TerminologyTools.AddTerminologyHandler(arg_2_0, arg_2_0.descText_, nil, nil)
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_1
	arg_4_0.data_ = arg_4_2
	arg_4_0.cfg_ = RogueTeamItemCfg[arg_4_0.data_.id]
	arg_4_0.nameText_.text = GetI18NText(arg_4_0.cfg_.name)
	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_4_0.data_.id))
	arg_4_0.descText_.text = ChallengeRogueTeamTools.GetItemDesc(arg_4_0.data_.id, arg_4_0.data_.rare, arg_4_0.descText_.color)

	arg_4_0.rareController_:SetSelectedState(arg_4_0.data_.rare)
end

return var_0_0
