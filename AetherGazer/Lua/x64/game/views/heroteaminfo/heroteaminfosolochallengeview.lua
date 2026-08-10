local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("HeroTeamInfoSoloChallengeView", var_0_0)

function var_0_1.GetHeroTeam(arg_1_0)
	local var_1_0 = ReserveTools.GetReserveTemplate(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, arg_1_0.params_.stageID):GetContDataTemplateById(arg_1_0.params_.reserveParams.contID)

	arg_1_0.heroTeam_, arg_1_0.heroTrialList_ = var_1_0:GetSummaryHeroList()
	arg_1_0.lockStateList_ = {
		false,
		false,
		false
	}
	arg_1_0.lockHeroList_ = var_1_0:GetLockHeroList(arg_1_0.params_.activityID, arg_1_0.params_.reserveParams.customData.difficultyIndex)
end

function var_0_1.HeadRenderer(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.HeadRenderer(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = arg_2_0.heroDataList_[arg_2_1].id
	local var_2_1 = arg_2_0.heroDataList_[arg_2_1].trialID
	local var_2_2, var_2_3, var_2_4 = arg_2_0:IsInTeam(var_2_0, var_2_1)
	local var_2_5 = table.keyof(arg_2_0.lockHeroList_, var_2_0) ~= nil or table.keyof(arg_2_0.lockHeroList_, var_2_1) ~= nil

	if var_2_5 == false then
		arg_2_2:SetSoloChallengeIndex(var_2_4)
	else
		arg_2_2:SetSoloChallengeIndex(-1)
	end

	arg_2_2:SetHeroLock(var_2_5)
	arg_2_2:SetInTeamFlag(false)
end

function var_0_1.TryToChangeTeam(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:ChangeTeam(arg_3_1, arg_3_2)
end

function var_0_1.ChangeTeam(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ReserveTools.GetReserveType(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, arg_4_0.params_.stageID)

	ReserveTools.GetReserveTemplateByReserveType(var_4_0):GetContDataTemplateById(arg_4_0.params_.reserveParams.contID):SetSummaryHeroList(arg_4_1, arg_4_2)
	ReserveAction.SaveSoloChallengeContData(arg_4_0.params_.activityID, arg_4_0.params_.reserveParams.customData.difficultyIndex, function()
		arg_4_0:OnChangeTeamSuccess()
	end)
end

return var_0_1
