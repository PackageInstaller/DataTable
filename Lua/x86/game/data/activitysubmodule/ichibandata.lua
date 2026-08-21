local var_0_0 = singletonClass("IchiBanData")

function var_0_0.Init(arg_1_0)
	arg_1_0.ichiBanList = {}
	arg_1_0.uiSeqList_ = {}
	arg_1_0.uiRewardList_ = {}
	arg_1_0.levelRewardList_ = {}
end

function var_0_0.InitChiBanData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	arg_2_0.ichiBanList[var_2_0] = arg_2_0.ichiBanList[var_2_0] or {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.seq_list) do
		local var_2_1 = iter_2_1.level
		local var_2_2 = iter_2_1.seq

		arg_2_0:SetIchiBanData(var_2_0, var_2_1, var_2_2)
	end

	arg_2_0:SortData(var_2_0)
	IchiBanAction.UpdateRedPoint(var_2_0)
end

function var_0_0.SetIchiBanData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.ichiBanList[arg_3_1] = arg_3_0.ichiBanList[arg_3_1] or {}
	arg_3_0.ichiBanList[arg_3_1][arg_3_2] = arg_3_0.ichiBanList[arg_3_1][arg_3_2] or {}

	if not table.keyof(arg_3_0.ichiBanList[arg_3_1][arg_3_2], arg_3_3) then
		table.insert(arg_3_0.ichiBanList[arg_3_1][arg_3_2], arg_3_3)
	end
end

function var_0_0.SortData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.ichiBanList[arg_4_1]) do
		local var_4_0 = IchiBanTeaserCfg.get_id_list_by_activity_id[arg_4_1][iter_4_0]
		local var_4_1 = IchiBanTeaserCfg[var_4_0].reward

		table.sort(iter_4_1, function(arg_5_0, arg_5_1)
			local var_5_0 = var_4_1[arg_5_0]
			local var_5_1 = var_4_1[arg_5_1]

			return var_5_0[1] < var_5_1[1]
		end)
	end
end

function var_0_0.GetIchiBanData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	return arg_6_0:GetIchiBanDataList(arg_6_1, arg_6_2)[arg_6_3]
end

function var_0_0.GetIchiBanDataList(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.ichiBanList[arg_7_1] = arg_7_0.ichiBanList[arg_7_1] or {}
	arg_7_0.ichiBanList[arg_7_1][arg_7_2] = arg_7_0.ichiBanList[arg_7_1][arg_7_2] or {}

	return arg_7_0.ichiBanList[arg_7_1][arg_7_2]
end

function var_0_0.SetUIRaffleData(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_2.reward_list) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1.reward) do
			table.insert(var_8_1, {
				id = iter_8_3.id,
				num = iter_8_3.num
			})
		end

		table.insert(var_8_0, {
			level = iter_8_1.seq.level,
			seq = iter_8_1.seq.seq,
			reward = iter_8_1.reward
		})
	end

	local var_8_2 = mergeReward(var_8_1)

	arg_8_0.uiSeqList_[arg_8_1] = var_8_0
	arg_8_0.uiRewardList_[arg_8_1] = var_8_2
end

function var_0_0.GetUISeqList(arg_9_0, arg_9_1)
	return arg_9_0.uiSeqList_[arg_9_1] or {}
end

function var_0_0.GetUIRewardList(arg_10_0, arg_10_1)
	return arg_10_0.uiRewardList_[arg_10_1] or {}
end

function var_0_0.SetUILevelReward(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.levelRewardList_[arg_11_1] = arg_11_0.levelRewardList_[arg_11_1] or {}

	table.insert(arg_11_0.levelRewardList_[arg_11_1], arg_11_2)
end

function var_0_0.GetUILevelReward(arg_12_0, arg_12_1)
	return arg_12_0.levelRewardList_[arg_12_1]
end

function var_0_0.ClearUIData(arg_13_0, arg_13_1)
	arg_13_0.uiSeqList_[arg_13_1] = {}
	arg_13_0.uiRewardList_[arg_13_1] = {}
	arg_13_0.levelRewardList_[arg_13_1] = {}

	IchiBanAction.UpdateRedPoint(arg_13_1)
end

return var_0_0
