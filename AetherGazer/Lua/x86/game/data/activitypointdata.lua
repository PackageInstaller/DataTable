local var_0_0 = singletonClass("ActivityPointData")

function var_0_0.Init(arg_1_0)
	arg_1_0.residentScoreDataDic_ = {}
	arg_1_0.completedIdDic_ = {}
	arg_1_0.activityUseDunDunDataList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.reward_list

	arg_2_0:UpdateCompletedData(var_2_0)
end

function var_0_0.UpdateCompletedData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0:AddPointRewardID(iter_3_1)
	end
end

function var_0_0.InitResidentScore(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.score_info_list

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = iter_4_1.key
		local var_4_2 = iter_4_1.score

		arg_4_0.residentScoreDataDic_[var_4_1] = var_4_2
	end
end

function var_0_0.InitResidentCompletedData(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.reward_info_list

	arg_5_0:UpdateCompletedData(var_5_0)
end

function var_0_0.GetResidentScore(arg_6_0, arg_6_1)
	return arg_6_0.residentScoreDataDic_[arg_6_1] or 0
end

function var_0_0.IsCompleteID(arg_7_0, arg_7_1)
	if not arg_7_0.completedIdDic_[arg_7_1] then
		return false
	end

	return arg_7_0.completedIdDic_[arg_7_1] == true
end

function var_0_0.AddPointRewardID(arg_8_0, arg_8_1)
	arg_8_0.completedIdDic_[arg_8_1] = true
end

function var_0_0.InitUseDunDunData(arg_9_0, arg_9_1)
	arg_9_0.activityUseDunDunDataList_ = {}
	arg_9_0.activityUseDunDunDataList_[arg_9_1.activity_id] = {
		point = arg_9_1.point,
		rewardIDList = cleanProtoTable(arg_9_1.reward_list)
	}

	arg_9_0:UpdateUseDunDunRedPoint(arg_9_1.activity_id)
end

function var_0_0.GetUseDunDunRewardIsGet(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.activityUseDunDunDataList_[arg_10_1] then
		if table.indexof(arg_10_0.activityUseDunDunDataList_[arg_10_1].rewardIDList, arg_10_2) then
			return true
		else
			return false
		end
	end
end

function var_0_0.GetCurDunDunPoint(arg_11_0, arg_11_1)
	if arg_11_0.activityUseDunDunDataList_[arg_11_1] then
		return arg_11_0.activityUseDunDunDataList_[arg_11_1].point
	else
		return 0
	end
end

function var_0_0.GetUseDunDunReward(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.activityUseDunDunDataList_[arg_12_1] and arg_12_0.activityUseDunDunDataList_[arg_12_1].rewardIDList then
		for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
			table.insert(arg_12_0.activityUseDunDunDataList_[arg_12_1].rewardIDList, iter_12_1)
		end
	else
		arg_12_0.activityUseDunDunDataList_[arg_12_1] = {
			point = 0,
			rewardIDList = {}
		}

		for iter_12_2, iter_12_3 in ipairs(arg_12_2) do
			table.insert(arg_12_0.activityUseDunDunDataList_[arg_12_1].rewardIDList, iter_12_3)
		end
	end

	arg_12_0:UpdateUseDunDunRedPoint(arg_12_1)
end

function var_0_0.UpdateUseDunDunRedPoint(arg_13_0, arg_13_1)
	local var_13_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_13_1]

	if ActivityData:GetActivityIsOpen(arg_13_1) then
		if arg_13_0.activityUseDunDunDataList_[arg_13_1] then
			for iter_13_0, iter_13_1 in pairs(var_13_0) do
				local var_13_1 = RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_13_1
				local var_13_2 = ActivityPointRewardCfg[iter_13_1]

				if arg_13_0.activityUseDunDunDataList_[arg_13_1].point >= var_13_2.need then
					if table.indexof(arg_13_0.activityUseDunDunDataList_[arg_13_1].rewardIDList, iter_13_1) then
						manager.redPoint:setTip(var_13_1, 0)
					else
						manager.redPoint:setTip(var_13_1, 1)
					end
				else
					manager.redPoint:setTip(var_13_1, 0)
				end
			end
		else
			for iter_13_2, iter_13_3 in pairs(var_13_0) do
				local var_13_3 = RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_13_3

				manager.redPoint:setTip(var_13_3, 0)
			end
		end
	else
		for iter_13_4, iter_13_5 in pairs(var_13_0) do
			local var_13_4 = RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_13_5

			manager.redPoint:setTip(var_13_4, 0)
		end
	end
end

return var_0_0
