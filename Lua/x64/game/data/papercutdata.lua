local var_0_0 = singletonClass("PaperCutData")

function var_0_0.Init(arg_1_0)
	arg_1_0.scoreList_ = {}
	arg_1_0.receivedList_ = {}
	arg_1_0.playedList_ = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	arg_2_0.scoreList_[var_2_0] = arg_2_1.score

	local var_2_1 = arg_2_1.got_reward_list

	arg_2_0.receivedList_[var_2_0] = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		table.insert(arg_2_0.receivedList_[var_2_0], iter_2_1)
	end

	arg_2_0.playedList_[var_2_0] = arg_2_1.is_play

	arg_2_0:RefreshSelectRedPoint(var_2_0)
	arg_2_0:RefreshRewardRedPoint(var_2_0)
end

function var_0_0.GetPlayedList(arg_3_0, arg_3_1)
	return arg_3_0.playedList_[arg_3_1] or false
end

function var_0_0.GetScore(arg_4_0, arg_4_1)
	return arg_4_0.scoreList_[arg_4_1] or 0
end

function var_0_0.SetScore(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.scoreList_[arg_5_1] == nil then
		arg_5_0.scoreList_[arg_5_1] = arg_5_2
	else
		arg_5_0.scoreList_[arg_5_1] = arg_5_2 < arg_5_0.scoreList_[arg_5_1] and arg_5_0.scoreList_[arg_5_1] or arg_5_2
	end

	arg_5_0.playedList_[arg_5_1] = true

	arg_5_0:RefreshSelectRedPoint(arg_5_1)
	arg_5_0:RefreshRewardRedPoint(arg_5_1)
end

function var_0_0.GetReceivedList(arg_6_0, arg_6_1)
	return arg_6_0.receivedList_[arg_6_1] or {}
end

function var_0_0.SetReceivedList(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.receivedList_[arg_7_1] = arg_7_0.receivedList_[arg_7_1] or {}

	if table.keyof(arg_7_0.receivedList_[arg_7_1], arg_7_2) == nil then
		table.insert(arg_7_0.receivedList_[arg_7_1], arg_7_2)
	end

	arg_7_0:RefreshRewardRedPoint(arg_7_1)
end

function var_0_0.GetRewardList(arg_8_0, arg_8_1)
	local var_8_0 = ActivityCfg[arg_8_1].sub_activity_list
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = {}
	local var_8_4 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_5 = ActivityPointRewardCfg.get_id_list_by_activity_id[iter_8_1]
		local var_8_6 = arg_8_0:GetScore(iter_8_1)
		local var_8_7 = arg_8_0:GetReceivedList(iter_8_1)

		for iter_8_2, iter_8_3 in ipairs(var_8_5) do
			if var_8_6 < ActivityPointRewardCfg[iter_8_3].need then
				var_8_2[#var_8_2 + 1] = iter_8_3
			elseif table.keyof(var_8_7, iter_8_3) == nil then
				var_8_3[#var_8_3 + 1] = iter_8_3
			else
				var_8_4[#var_8_4 + 1] = iter_8_3
			end
		end
	end

	table.insertto(var_8_1, var_8_3)
	table.insertto(var_8_1, var_8_2)
	table.insertto(var_8_1, var_8_4)

	return var_8_1
end

function var_0_0.SetSelectActivityID(arg_9_0, arg_9_1)
	local var_9_0 = PaperCutCfg[arg_9_1].main_activity_id

	manager.redPoint:setTip(string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, var_9_0, arg_9_1), 0)
end

function var_0_0.RefreshSelectRedPoint(arg_10_0, arg_10_1)
	local var_10_0 = PaperCutCfg[arg_10_1].main_activity_id
	local var_10_1 = arg_10_0.playedList_[arg_10_1] == true and 0 or 1

	manager.redPoint:setTip(string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, var_10_0, arg_10_1), var_10_1)
end

function var_0_0.RefreshRewardRedPoint(arg_11_0, arg_11_1)
	local var_11_0 = 0
	local var_11_1 = PaperCutCfg[arg_11_1].main_activity_id
	local var_11_2 = arg_11_0:GetScore(arg_11_1)
	local var_11_3 = PaperCutCfg[arg_11_1]

	if var_11_3 then
		local var_11_4 = var_11_3.task_id

		var_11_0 = var_11_2 >= ActivityPointRewardCfg[var_11_4].need and table.keyof(arg_11_0.receivedList_[arg_11_1], var_11_4) == nil and 1 or 0
	end

	manager.redPoint:setTip(string.format("%s_%s_%s_Reward", RedPointConst.PAPER_CUT, var_11_1, arg_11_1), var_11_0)
end

function var_0_0.GetLastContentPosX(arg_12_0, arg_12_1)
	return getData(string.format("PaperCut_%d", arg_12_1), "contentPosX")
end

function var_0_0.SetLastContentPosX(arg_13_0, arg_13_1, arg_13_2)
	saveData(string.format("PaperCut_%d", arg_13_1), "contentPosX", arg_13_2)
end

return var_0_0
