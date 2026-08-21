local var_0_0 = class("ChallengeRogueTeamTreasureSkillItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetCampIcon(arg_4_1))

	local var_4_0 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_4_1 = RogueTeamCfg[var_4_0].item_temp

	arg_4_0.cntText_.text = #ChallengeRogueTeamData:TreasureGetListByCampList({
		arg_4_1
	})

	arg_4_0:Show(true)
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

return var_0_0
