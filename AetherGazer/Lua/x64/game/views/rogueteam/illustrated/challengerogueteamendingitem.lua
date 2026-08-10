local var_0_0 = class("ChallengeRogueTeamEndingItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockController_ = arg_1_0.controller_:GetController("lock")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.passCount == 0 then
			ShowTips("CHALLENGE_ROGUE_TEAM_ENDING_LOCK")
		else
			JumpTools.OpenPageByJump("challengeRogueTeamIllustratedEndingPop", {
				id = arg_3_0.id_,
				index = arg_3_0.index_
			})
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.id_ = arg_5_2
	arg_5_0.cfg_ = RogueTeamEndingCfg[arg_5_0.id_]
	arg_5_0.titleText_.text = arg_5_0.cfg_.story_name
	arg_5_0.numText_.text = arg_5_0.index_ >= 10 and arg_5_0.index_ or "0" .. arg_5_0.index_
	arg_5_0.image_.sprite = pureGetSpriteWithoutAtlas(arg_5_0.cfg_.image)
	arg_5_0.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()
	arg_5_0.passCount = ChallengeRogueTeamData:GetHistoryEndingPassCnt(arg_5_0.templateID_, arg_5_0.id_)

	arg_5_0.lockController_:SetSelectedState(tostring(arg_5_0.passCount == 0))
end

return var_0_0
