local var_0_0 = class("ChallengeRogueTeamSelectedItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.statusController_ = arg_1_0.itemCon_:GetController("status")
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.RefreshData(arg_3_0, arg_3_1)
	local var_3_0 = ActivityAffixPoolCfg[arg_3_1]

	arg_3_0.iconImg_.sprite = getAffixSprite(var_3_0.affix)
	arg_3_0.numText_.text = var_3_0.point

	arg_3_0.statusController_:SetSelectedState(var_3_0.point > 0 and "red" or blue)
end

return var_0_0
