local var_0_0 = class("ChallengeRogueTeamPropertyPage", HeroPropertyPage)

function var_0_0.AddUIListener(arg_1_0)
	var_0_0.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.rougeBuffBtn, nil, function()
		JumpTools:OpenPageByJump("challengeRougeTeamBuffPopView")
	end)
end

function var_0_0.CheckLocked(arg_3_0)
	arg_3_0.lockController_:SetSelectedState("true")
end

return var_0_0
