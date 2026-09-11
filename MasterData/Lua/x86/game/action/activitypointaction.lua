local var_0_0 = {}

manager.notify:RegistListener(MATERIAL_MODIFY, function(arg_1_0)
	var_0_0.InitRedPoint(arg_1_0)
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_2_0)
	var_0_0.InitRedPoint(arg_2_0)
end)
manager.net:Bind(60105, function(arg_3_0)
	ActivityPointData:InitResidentScore(arg_3_0)
	SkuldSystemData:UpdateSkuldPointRewardRedPoint()
end)
manager.net:Bind(60107, function(arg_4_0)
	ActivityPointData:InitResidentCompletedData(arg_4_0)
	SkuldSystemData:UpdateSkuldPointRewardRedPoint()
end)

function var_0_0.ReceivePointReward(arg_5_0)
	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = arg_5_0
	}, 60055, var_0_0.OnReceivePointReward)
end

function var_0_0:OnReceivePointReward(arg_6_1)
	if isSuccess(self.result) then
		ActivityPointData:UpdateCompletedData(arg_6_1.point_reward_id_list)
		getReward2(mergeReward2(self.reward_list))
		var_0_0.UpdateActivityRedPointByRewardIdList(arg_6_1.point_reward_id_list)
		manager.notify:Invoke(RECEIVE_POINT_REWARD, {
			point_reward_id_list = arg_6_1.point_reward_id_list
		})
	else
		ShowTips(self.result)
	end
end

manager.net:Bind(85101, function(arg_7_0)
	ActivityPointData:InitData(arg_7_0)
end)

function var_0_0.SubmitPointReward(arg_8_0, arg_8_1)
	manager.net:SendWithLoadingNew(85102, {
		reward_id_list = arg_8_0
	}, 85103, function(arg_9_0)
		if isSuccess(arg_9_0.result) then
			ActivityPointData:UpdateCompletedData(arg_8_0)
			getReward(mergeReward(arg_9_0.item_list))
			var_0_0.UpdateActivityRedPointByRewardIdList(arg_8_0)
			arg_8_1(arg_9_0)
		else
			ShowTips(arg_9_0.result)
		end
	end)
end

function var_0_0.InitRedPoint()
	for iter_10_0, iter_10_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id) do
		var_0_0.UpdateActivityRedPoint(iter_10_0)
	end
end

function var_0_0.UpdateActivityRedPointByRewardIdList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		if ActivityPointRewardCfg[iter_11_1].activity_id ~= 0 then
			var_11_0[ActivityPointRewardCfg[iter_11_1].activity_id] = true
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_0) do
		var_0_0.UpdateActivityRedPoint(iter_11_2)
	end
end

function var_0_0.UpdateActivityRedPoint(arg_12_0)
	if ActivityTools.GetActivityStatus(arg_12_0) == ActivityConst.ACTIVITY_STATE.ACTIVING then
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_12_0]) do
			if ActivityPointRewardCfg[iter_12_1].need_item_id ~= 0 and not ActivityPointData:IsCompleteID(iter_12_1) and ActivityPointRewardCfg[iter_12_1].need <= ItemTools.getItemNum(ActivityPointRewardCfg[iter_12_1].need_item_id) then
				var_12_0 = 1

				break
			end

			if ActivityCfg[arg_12_0].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_SCORE then
				local var_12_1 = ChallengeRogueTeamTools.GetTeamplateIDByActivityID(arg_12_0)

				if not table.keyof(ChallengeRogueTeamData:GetRewardedScoreList(var_12_1), iter_12_1) and ActivityPointRewardCfg[iter_12_1].need <= ItemTools.getItemNum(RogueTeamCfg[var_12_1].point_item) then
					var_12_0 = 1

					break
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, arg_12_0), var_12_0)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, arg_12_0), 0)
	end
end

function var_0_0.UpdateRedPoint(arg_13_0)
	var_0_0.UpdateActivityRedPoint(ActivityPointRewardCfg[arg_13_0].activity_id)
end

manager.net:Bind(86011, function(arg_14_0)
	ActivityPointData:InitUseDunDunData(arg_14_0)
end)
manager.net:Bind(86037, function(arg_15_0)
	ActivityPointData:InitResidentCompletedData({
		reward_info_list = arg_15_0.reward_list
	})
	QWorldBookletTools.UpdateLevelRewardRedPoint(arg_15_0.point)
end)

function var_0_0.InitDunDunRedPointKey(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_16_0]) do
		table.insert(var_16_0, RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_16_1)
	end

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_USE_DUNDUN .. arg_16_0, var_16_0)
end

return var_0_0
