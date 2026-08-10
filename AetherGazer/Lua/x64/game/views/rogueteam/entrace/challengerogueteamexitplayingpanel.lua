local var_0_0 = class("ChallengeRogueTeamExitPlayingPanel", ReduxView)

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
	arg_3_0:AddBtnListener(arg_3_0.exitBtn_, nil, function()
		if not ChallengeRogueTeamData:IsFinishGuide() then
			ShowTips("ROGUE_TEAM_FINISH_GUIDE_THEN_OPEN")

			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ROGUE_TEAM_EXIT_PLAYING_DESC"),
			OkCallback = function()
				ChallengeRogueTeamAction.RequestGameResult(function()
					ChallengeRogueTeamAction.UpdateHistoryData()
					JumpTools.OpenPageByJump("challengeRogueTeamOverStatistics")
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	if ChallengeRogueTeamData:GetSelectDifficultyID(var_8_0) == 0 then
		return
	end

	local var_8_1 = ChallengeRogueTeamData:GetLastDifficultyID(var_8_0)
	local var_8_2 = RogueTeamDifficultyCfg[var_8_1]

	arg_8_0.difficultyText_.text = NumberTools.IntToRomam(table.keyof(RogueTeamDifficultyCfg.get_id_list_by_template_id[var_8_2.template_id], var_8_1))
	arg_8_0.floorText_.text = ChallengeRogueTeamTools.GetFloorName()
end

return var_0_0
