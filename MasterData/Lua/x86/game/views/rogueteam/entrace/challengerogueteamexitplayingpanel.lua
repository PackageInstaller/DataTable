local ChallengeRogueTeamExitPlayingPanel = class("ChallengeRogueTeamExitPlayingPanel", ReduxView)

function ChallengeRogueTeamExitPlayingPanel:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamExitPlayingPanel:Dispose()
	ChallengeRogueTeamExitPlayingPanel.super.Dispose(self)
end

function ChallengeRogueTeamExitPlayingPanel:AddListeners()
	self:AddBtnListener(self.exitBtn_, nil, function()
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

function ChallengeRogueTeamExitPlayingPanel:RefreshUI()
	local var_8_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	if ChallengeRogueTeamData:GetSelectDifficultyID(var_8_0) == 0 then
		return
	end

	local var_8_1 = ChallengeRogueTeamData:GetLastDifficultyID(var_8_0)

	self.difficultyText_.text = NumberTools.IntToRomam(table.keyof(RogueTeamDifficultyCfg.get_id_list_by_template_id[RogueTeamDifficultyCfg[var_8_1].template_id], var_8_1))
	self.floorText_.text = ChallengeRogueTeamTools.GetFloorName()
end

return ChallengeRogueTeamExitPlayingPanel
