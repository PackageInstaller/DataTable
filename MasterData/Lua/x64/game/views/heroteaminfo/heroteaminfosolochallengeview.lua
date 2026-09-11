local HeroTeamInfoSoloChallengeView = class("HeroTeamInfoSoloChallengeView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function HeroTeamInfoSoloChallengeView:GetHeroTeam()
	local var_1_0 = ReserveTools.GetReserveTemplate(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, self.params_.stageID):GetContDataTemplateById(self.params_.reserveParams.contID)

	self.heroTeam_, self.heroTrialList_ = var_1_0:GetSummaryHeroList()
	self.lockStateList_ = {
		false,
		false,
		false
	}
	self.lockHeroList_ = var_1_0:GetLockHeroList(self.params_.activityID, self.params_.reserveParams.customData.difficultyIndex)
end

function HeroTeamInfoSoloChallengeView:HeadRenderer(arg_2_1, arg_2_2)
	HeroTeamInfoSoloChallengeView.super.HeadRenderer(self, arg_2_1, arg_2_2)

	local var_2_0, var_2_1, var_2_2 = self:IsInTeam(self.heroDataList_[arg_2_1].id, self.heroDataList_[arg_2_1].trialID)
	local var_2_3 = table.keyof(self.lockHeroList_, self.heroDataList_[arg_2_1].id) ~= nil or table.keyof(self.lockHeroList_, self.heroDataList_[arg_2_1].trialID) ~= nil

	if var_2_3 == false then
		arg_2_2:SetSoloChallengeIndex(var_2_2)
	else
		arg_2_2:SetSoloChallengeIndex(-1)
	end

	arg_2_2:SetHeroLock(var_2_3)
	arg_2_2:SetInTeamFlag(false)
end

function HeroTeamInfoSoloChallengeView:TryToChangeTeam(arg_3_1, arg_3_2)
	self:ChangeTeam(arg_3_1, arg_3_2)
end

function HeroTeamInfoSoloChallengeView:ChangeTeam(arg_4_1, arg_4_2)
	ReserveTools.GetReserveTemplateByReserveType((ReserveTools.GetReserveType(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, self.params_.stageID))):GetContDataTemplateById(self.params_.reserveParams.contID):SetSummaryHeroList(arg_4_1, arg_4_2)
	ReserveAction.SaveSoloChallengeContData(self.params_.activityID, self.params_.reserveParams.customData.difficultyIndex, function()
		self:OnChangeTeamSuccess()
	end)
end

return HeroTeamInfoSoloChallengeView
