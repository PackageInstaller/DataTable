local var_0_0 = {}

manager.net:Bind(65201, function(arg_1_0)
	DormLinkGameData:InitLevelInfo(arg_1_0)
end)

function var_0_0.ClearanceLevel(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0, var_2_1 = DormLinkGameTools:ChecklevelUnLock(arg_2_1)

	if var_2_0 then
		local var_2_2 = DormLinkGameData:GetLastPoint()
		local var_2_3 = arg_2_2.gameTime
		local var_2_4 = {}

		if arg_2_2.useItemList then
			for iter_2_0, iter_2_1 in pairs(arg_2_2.useItemList) do
				local var_2_5 = {
					id = iter_2_0,
					num = iter_2_1
				}

				table.insert(var_2_4, var_2_5)
			end
		end

		manager.net:SendWithLoadingNew(65210, {
			id = arg_2_1,
			point = var_2_2,
			remain_time = var_2_3,
			item_list = var_2_4
		}, 65211, var_0_0.ClearanceLevelCallBack)
	else
		if var_2_1 == DormLinkGameConst.LevelLockType.stop then
			ShowTips("TIME_OVER")
		end

		DormLinkGameData:FailedClear()
	end
end

function var_0_0.ClearanceLevelCallBack(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		DormLinkGameData:SuccessClear(arg_3_1)
	else
		ShowTips(arg_3_0.result)
		DormLinkGameData:FailedClear()
	end
end

function var_0_0.GetLevelAward(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(65212, {
		reward_id = arg_4_1
	}, 65213, var_0_0.GetLevelAwardCallBack)
end

function var_0_0.GetMultiplyLevelAward(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(65214, {
		reward_id = arg_5_1
	}, 65215, var_0_0.GetMultiplyLevelAwardCallBack)
end

function var_0_0.GetLevelAwardCallBack(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		DormLinkGameData:SetRewardInfo(arg_6_1.reward_id, true)
		getReward(mergeReward(arg_6_0.reward_list))
		manager.notify:Invoke(DORM_LINK_REFRESH_LEVEL_AWARD)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.GetMultiplyLevelAwardCallBack(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.reward_id) do
			DormLinkGameData:SetRewardInfo(iter_7_1, true)
		end

		getReward(mergeReward(arg_7_0.reward_list))
		manager.notify:Invoke(DORM_LINK_REFRESH_LEVEL_AWARD)
	else
		ShowTips(arg_7_0.result)
	end
end

manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_8_0)
	if ActivityTools.GetActivityType(arg_8_0) == ActivityTemplateConst.LIANLIANKAN_LEVEL then
		DormLinkGameData:UpdateLevelActivityCompleteRedPoint(arg_8_0)
	end
end)

return var_0_0
