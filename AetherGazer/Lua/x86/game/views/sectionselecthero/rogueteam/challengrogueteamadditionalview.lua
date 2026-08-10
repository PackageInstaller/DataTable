local var_0_0 = import("game.views.sectionSelectHero.SectionAdditionalView")
local var_0_1 = class("ChallengRogueTeamAdditionalView", var_0_0)

function var_0_1.AddListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = arg_1_0.maxRaceID_,
			sameCamp = arg_1_0.sameCamp_
		})
	end)
	arg_1_0:AddBtnListener(arg_1_0.startBtn_, nil, function()
		if arg_1_0.sectionProxy_:GetHeroIDList()[1] == 0 then
			ShowTips("TEAM_ERROR_LEADER")

			return
		end

		manager.notify:Invoke(SECTION_CLICK_START_BATTLE)
	end)
	arg_1_0:AddBtnListener(arg_1_0.reservesBtn_, nil, function()
		if not arg_1_0.sectionProxy_.canChangeReserveProposal then
			return
		end

		arg_1_0:GotoReservesProposalUI()
	end)
end

function var_0_1.RefresgStageInfoActive(arg_5_0)
	arg_5_0.stageInfoActiveController_:SetSelectedState("false")
end

return var_0_1
