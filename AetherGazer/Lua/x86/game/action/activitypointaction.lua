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
	local var_5_0 = {
		point_reward_id_list = arg_5_0
	}

	manager.net:SendWithLoadingNew(60054, var_5_0, 60055, var_0_0.OnReceivePointReward)
end

function var_0_0.OnReceivePointReward(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		ActivityPointData:UpdateCompletedData(arg_6_1.point_reward_id_list)
		getReward2(mergeReward2(arg_6_0.reward_list))
		var_0_0.UpdateActivityRedPointByRewardIdList(arg_6_1.point_reward_id_list)
		manager.notify:Invoke(RECEIVE_POINT_REWARD, {
			point_reward_id_list = arg_6_1.point_reward_id_list
		})
	else
		ShowTips(arg_6_0.result)
	end
end

manager.net:Bind(85101, function(arg_7_0)
	ActivityPointData:InitData(arg_7_0)
end)

function var_0_0.SubmitPointReward(arg_8_0, arg_8_1)
	local var_8_0 = {
		reward_id_list = arg_8_0
	}

	manager.net:SendWithLoadingNew(85102, var_8_0, 85103, function(arg_9_0)
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
		local var_11_1 = ActivityPointRewardCfg[iter_11_1].activity_id

		if var_11_1 ~= 0 then
			var_11_0[var_11_1] = true
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_0) do
		var_0_0.UpdateActivityRedPoint(iter_11_2)
	end
end

function var_0_0.UpdateActivityRedPoint(arg_12_0)
	if ActivityTools.GetActivityStatus(arg_12_0) == ActivityConst.ACTIVITY_STATE.ACTIVING then
		local var_12_0 = 0
		local var_12_1 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_12_0]

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			local var_12_2 = ActivityPointRewardCfg[iter_12_1]

			if var_12_2.need_item_id ~= 0 and not ActivityPointData:IsCompleteID(iter_12_1) and var_12_2.need <= ItemTools.getItemNum(var_12_2.need_item_id) then
				var_12_0 = 1

				break
			end

			if ActivityCfg[arg_12_0].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_SCORE then
				local var_12_3 = ChallengeRogueTeamTools.GetTeamplateIDByActivityID(arg_12_0)
				local var_12_4 = ChallengeRogueTeamData:GetRewardedScoreList(var_12_3)

				if not table.keyof(var_12_4, iter_12_1) and var_12_2.need <= ItemTools.getItemNum(RogueTeamCfg[var_12_3].point_item) then
					var_12_0 = 1

					break
				end
			end
		end

		local var_12_5 = string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, arg_12_0)

		manager.redPoint:setTip(var_12_5, var_12_0)
	else
		local var_12_6 = string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, arg_12_0)

		manager.redPoint:setTip(var_12_6, 0)
	end
end

function var_0_0.UpdateRedPoint(arg_13_0)
	local var_13_0 = ActivityPointRewardCfg[arg_13_0].activity_id

	var_0_0.UpdateActivityRedPoint(var_13_0)
end

manager.net:Bind(86011, function(arg_14_0)
	ActivityPointData:InitUseDunDunData(arg_14_0)
end)
manager.net:Bind(86037, function(arg_15_0)
	local var_15_0 = {
		reward_info_list = arg_15_0.reward_list
	}

	ActivityPointData:InitResidentCompletedData(var_15_0)
	QWorldBookletTools.UpdateLevelRewardRedPoint(arg_15_0.point)
end)

function var_0_0.InitDunDunRedPointKey(arg_16_0)
	local var_16_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_16_0]
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_2 = RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_16_1

		table.insert(var_16_1, var_16_2)
	end

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_USE_DUNDUN .. arg_16_0, var_16_1)
end

return var_0_0
