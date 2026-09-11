local ChallengeRogueTeamScoreData = class("ChallengeRogueTeamScoreData")

function ChallengeRogueTeamScoreData:ExportMethod()
	return {
		"GetScoreActivityIDByTemple",
		"GetScoreIDListByActivityID",
		"GetUnCompleteIndex",
		"SetRewardedScoreList",
		"GetRewardedScoreList",
		"SetLastScoreId",
		"GetLastScoreId"
	}
end

function ChallengeRogueTeamScoreData:Init()
	self.rewardList_ = {}
	self.passScore_ = {}
end

function ChallengeRogueTeamScoreData:GetScoreActivityIDByTemple(arg_3_1)
	if RogueTeamCfg[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(ActivityCfg[RogueTeamCfg[arg_3_1].activity_id] and ActivityCfg[RogueTeamCfg[arg_3_1].activity_id].sub_activity_list) do
			if ActivityCfg[iter_3_1].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_SCORE then
				return iter_3_1
			end
		end
	end

	return nil
end

function ChallengeRogueTeamScoreData:GetScoreIDListByActivityID(arg_4_1)
	return ActivityPointRewardCfg.get_id_list_by_activity_id[arg_4_1] or {}
end

function ChallengeRogueTeamScoreData:SetRewardedScoreList(arg_5_1, arg_5_2)
	self.rewardList_[arg_5_1] = self.rewardList_[arg_5_1] or {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		if not table.indexof(self.rewardList_[arg_5_1], iter_5_1) then
			table.insert(self.rewardList_[arg_5_1], iter_5_1)
		end
	end

	self:UpdateRedPoint(arg_5_1)
end

function ChallengeRogueTeamScoreData:GetRewardedScoreList(arg_6_1)
	return self.rewardList_[arg_6_1] or {}
end

function ChallengeRogueTeamScoreData:GetUnCompleteIndex(arg_7_1, arg_7_2)
	local var_7_0 = self:GetScoreIDListByActivityID(arg_7_2)
	local var_7_1 = self:GetRewardedScoreList(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if var_7_1 and not table.indexof(var_7_1, iter_7_1) then
			return iter_7_0
		end
	end

	return #var_7_0
end

function ChallengeRogueTeamScoreData:SetPassScore(arg_8_1)
	self:UpdateRedPoint(arg_8_1)
end

function ChallengeRogueTeamScoreData:UpdateRedPoint(arg_9_1)
	ActivityPointAction.UpdateActivityRedPoint((ChallengeRogueTeamTools.GetPointActivityID(arg_9_1)))
end

function ChallengeRogueTeamScoreData:SetLastScoreId(arg_10_1)
	self.lastScoreID_ = arg_10_1 or 0
end

function ChallengeRogueTeamScoreData:GetLastScoreId()
	return self.lastScoreID_
end

return ChallengeRogueTeamScoreData
