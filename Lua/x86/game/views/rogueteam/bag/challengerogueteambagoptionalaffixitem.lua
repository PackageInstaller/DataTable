local var_0_0 = class("ChallengeRogueTeamBagOptionalAffixItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = arg_1_0.stateCon_:GetController("state")
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.cfg_ = ActivityAffixPoolCfg[arg_4_2]
	arg_4_0.nameText_.text = arg_4_0.cfg_.name
	arg_4_0.descText_.text = getAffixDesc(arg_4_0.cfg_.affix)
	arg_4_0.iconImg_.sprite = getAffixSprite(arg_4_0.cfg_.affix)
	arg_4_0.numText_.text = arg_4_0.cfg_.point

	arg_4_0.stateController_:SetSelectedState(arg_4_0.cfg_.point > 0 and "red" or "blue")
end

return var_0_0
