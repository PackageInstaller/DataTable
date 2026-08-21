local var_0_0 = class("ChallengeRogueTeamScoreData")

function var_0_0.ExportMethod(arg_1_0)
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

function var_0_0.Init(arg_2_0)
	arg_2_0.rewardList_ = {}
	arg_2_0.passScore_ = {}
end

function var_0_0.GetScoreActivityIDByTemple(arg_3_0, arg_3_1)
	local var_3_0 = RogueTeamCfg[arg_3_1]

	if var_3_0 then
		local var_3_1 = ActivityCfg[var_3_0.activity_id] and ActivityCfg[var_3_0.activity_id].sub_activity_list

		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			if ActivityCfg[iter_3_1].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_SCORE then
				return iter_3_1
			end
		end
	end

	return nil
end

function var_0_0.GetScoreIDListByActivityID(arg_4_0, arg_4_1)
	return ActivityPointRewardCfg.get_id_list_by_activity_id[arg_4_1] or {}
end

function var_0_0.SetRewardedScoreList(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.rewardList_[arg_5_1] then
		arg_5_0.rewardList_[arg_5_1] = {}
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		if not table.indexof(arg_5_0.rewardList_[arg_5_1], iter_5_1) then
			table.insert(arg_5_0.rewardList_[arg_5_1], iter_5_1)
		end
	end

	arg_5_0:UpdateRedPoint(arg_5_1)
end

function var_0_0.GetRewardedScoreList(arg_6_0, arg_6_1)
	return arg_6_0.rewardList_[arg_6_1] or {}
end

function var_0_0.GetUnCompleteIndex(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetScoreIDListByActivityID(arg_7_2)
	local var_7_1 = arg_7_0:GetRewardedScoreList(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if var_7_1 and not table.indexof(var_7_1, iter_7_1) then
			return iter_7_0
		end
	end

	return #var_7_0
end

function var_0_0.SetPassScore(arg_8_0, arg_8_1)
	arg_8_0:UpdateRedPoint(arg_8_1)
end

function var_0_0.UpdateRedPoint(arg_9_0, arg_9_1)
	local var_9_0 = ChallengeRogueTeamTools.GetPointActivityID(arg_9_1)

	ActivityPointAction.UpdateActivityRedPoint(var_9_0)
end

function var_0_0.SetLastScoreId(arg_10_0, arg_10_1)
	arg_10_0.lastScoreID_ = arg_10_1 or 0
end

function var_0_0.GetLastScoreId(arg_11_0)
	return arg_11_0.lastScoreID_
end

return var_0_0
