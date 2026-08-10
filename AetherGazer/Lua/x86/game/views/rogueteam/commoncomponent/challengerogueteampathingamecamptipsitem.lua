local var_0_0 = class("ChallengeRogueTeamPathInGameCampTipsItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListener()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		local var_4_0, var_4_1 = ChallengeRogueTeamTools:GetAllSuitSkillIDList()

		JumpTools.OpenPageByJump("/challengeRogueTeamBag", {
			leftTabIndex = 2,
			tabIndex = table.indexof(var_4_1, arg_3_0.campID_),
			campId = arg_3_0.campID_
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.templateID_ = ChallengeRogueTeamData:GetActiveTemplateID()

	local var_5_0 = RogueTeamCfg[arg_5_0.templateID_].item_temp

	arg_5_0.campID_ = arg_5_1
	arg_5_0.count_ = arg_5_2
	arg_5_0.itemTemp_ = RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp
	arg_5_0.campSkillID_ = ChallengeRogueTeamData:GetCampUltimateByCamp(arg_5_0.itemTemp_, arg_5_0.campID_)

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.campImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetCampIcon(arg_6_0.campID_))

	for iter_6_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		local var_6_0 = arg_6_0["item" .. iter_6_0 .. "_"]

		SetActive(var_6_0, iter_6_0 <= arg_6_0.count_)
	end

	arg_6_0.starSlider_.fillAmount = math.max(arg_6_0.count_ - 1, 0) / 5
end

return var_0_0
