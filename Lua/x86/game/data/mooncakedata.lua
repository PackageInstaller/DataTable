require("game.data.MoonCakeDataTemplate")

local var_0_0 = singletonClass("MoonCakeData")

function var_0_0.Init(arg_1_0)
	arg_1_0.receivedCakeGroupDic_ = {}
	arg_1_0.unlockCakeDic_ = {}
	arg_1_0.recommendDelegateDic_ = {}
	arg_1_0.lastRefreshDelegateTime_ = {}
	arg_1_0.submitedDelegateList_ = {}
	arg_1_0.submitedDelegateDic_ = {}
	arg_1_0.needSortSubmit_ = {}
	arg_1_0.ownDelegateDic_ = {}
	arg_1_0.ownDelegateList_ = {}
	arg_1_0.ownRunningDelegate_ = {}
	arg_1_0.todaySubmitDelegateTimes_ = {}
	arg_1_0.todayDispatchDelegateTimes_ = {}
	arg_1_0.selectedMakeFillingBtn_ = {}
	arg_1_0.selectedMakeCakeBtn_ = {}
	arg_1_0.selectedDelegateDispatchBtn_ = {}
	arg_1_0.partyData_ = {}
	arg_1_0.todayVisitTimes_ = {}
	arg_1_0.todayVisitedDic_ = {}
	arg_1_0.todayVisitRewardTimes_ = {}
	arg_1_0.allPartyDic_ = {}
	arg_1_0.friendPartyList_ = {}
	arg_1_0.recommendPartyList_ = {}
	arg_1_0.refreshRecommendPartyTime_ = {}
	arg_1_0.tempVisitIndexList_ = {}
	arg_1_0.tempPartyDataDic_ = {}
	arg_1_0.lastShareTimestamp_ = 0
end

function var_0_0.InitCakeData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id
	local var_2_1 = {}
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.give_list) do
		local var_2_3 = MoonDelegateDataTemplate.New(iter_2_1)

		var_2_3.isCompleted = true
		var_2_1[#var_2_1 + 1] = var_2_3

		local var_2_4 = var_2_3.uid
		local var_2_5 = var_2_3.delegateID

		var_2_2[var_2_4] = var_2_2[var_2_4] or {}
		var_2_2[var_2_4][var_2_5] = var_2_3
	end

	table.sort(var_2_1, function(arg_3_0, arg_3_1)
		return arg_3_0.timestamp > arg_3_1.timestamp
	end)

	arg_2_0.submitedDelegateList_[var_2_0] = var_2_1
	arg_2_0.submitedDelegateDic_[var_2_0] = var_2_2
	arg_2_0.needSortSubmit_[var_2_0] = false

	local var_2_6 = {}
	local var_2_7

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.entrust_list) do
		local var_2_8 = MoonDelegateDataTemplate.New(iter_2_3)

		var_2_6[var_2_8.delegateID] = var_2_8

		if var_2_8.isCompleted == false or var_2_8.isReceived == false then
			var_2_7 = var_2_8
		end
	end

	arg_2_0.ownDelegateDic_[var_2_0] = var_2_6
	arg_2_0.ownRunningDelegate_[var_2_0] = var_2_7
	arg_2_0.todaySubmitDelegateTimes_[var_2_0] = arg_2_1.today_present_num
	arg_2_0.todayDispatchDelegateTimes_[var_2_0] = arg_2_1.today_entrust_num
	arg_2_0.unlockCakeDic_[var_2_0] = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.moon_cakes_collect_list) do
		arg_2_0.unlockCakeDic_[var_2_0][iter_2_5] = true
	end

	arg_2_0.receivedCakeGroupDic_[var_2_0] = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.moon_cakes_collect_reward_list) do
		arg_2_0.receivedCakeGroupDic_[var_2_0][iter_2_7] = true
	end

	arg_2_0:UpdateSubmitDelegateUserInfo(var_2_0)
	arg_2_0:UpdateOwnDelegateUserInfo(var_2_0)
end

function var_0_0.UpdateSubmitDelegateUserInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetSubmitedDelegateList(arg_4_1)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1.uid ~= "0" then
			var_4_1[#var_4_1 + 1] = iter_4_1.uid
		end
	end

	if #var_4_1 > 0 then
		local var_4_2 = {
			user_id_list = var_4_1
		}

		manager.net:SendWithLoadingNew(32036, var_4_2, 32037, function(arg_5_0, arg_5_1)
			if not isSuccess(arg_5_0.result) then
				ShowTips(arg_5_0.result)

				return
			end

			local var_5_0 = {}

			for iter_5_0, iter_5_1 in ipairs(arg_5_0.user_brief_list) do
				var_5_0[iter_5_1.user_id] = iter_5_1
			end

			for iter_5_2, iter_5_3 in ipairs(var_4_0) do
				iter_5_3:UpdateUserInfo(var_5_0[iter_5_3.uid])
			end
		end)
	end
end

function var_0_0.UpdateOwnDelegateUserInfo(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.ownDelegateDic_[arg_6_1]
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1.submiter_uid ~= "0" then
			var_6_1[#var_6_1 + 1] = iter_6_1.submiter_uid
		end
	end

	if #var_6_1 > 0 then
		local var_6_2 = {
			user_id_list = var_6_1
		}

		manager.net:SendWithLoadingNew(32036, var_6_2, 32037, function(arg_7_0, arg_7_1)
			if not isSuccess(arg_7_0.result) then
				ShowTips(arg_7_0.result)

				return
			end

			local var_7_0 = {}

			for iter_7_0, iter_7_1 in ipairs(arg_7_0.user_brief_list) do
				var_7_0[iter_7_1.user_id] = iter_7_1
			end

			for iter_7_2, iter_7_3 in pairs(var_6_0) do
				iter_7_3:UpdateUserInfo(var_7_0[iter_7_3.submiter_uid])
			end
		end)
	end
end

function var_0_0.UpdateOwnDelegate(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.activity_id
	local var_8_1 = arg_8_1.entrust
	local var_8_2 = var_8_1.entrust_id

	if arg_8_0.ownDelegateDic_[var_8_0][var_8_2] then
		arg_8_0.ownDelegateDic_[var_8_0][var_8_2]:UpdateData(var_8_1)
	else
		local var_8_3 = MoonDelegateDataTemplate.New(var_8_1)

		arg_8_0.ownDelegateDic_[var_8_0][var_8_2] = var_8_3
		arg_8_0.ownRunningDelegate_[var_8_0] = var_8_3
	end

	local var_8_4 = {}
	local var_8_5 = arg_8_0.ownDelegateDic_[var_8_0][var_8_2]

	if var_8_5.submiter_uid ~= "0" then
		var_8_4[#var_8_4 + 1] = var_8_5.submiter_uid
	end

	if #var_8_4 > 0 then
		local var_8_6 = {
			user_id_list = var_8_4
		}

		manager.net:SendWithLoadingNew(32036, var_8_6, 32037, function(arg_9_0, arg_9_1)
			if not isSuccess(arg_9_0.result) then
				ShowTips(arg_9_0.result)

				return
			end

			local var_9_0 = arg_9_0.user_brief_list[1]

			var_8_5:UpdateUserInfo(var_9_0)
		end)
	end
end

function var_0_0.CancelDelegate(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.ownDelegateDic_[arg_10_1][arg_10_2] then
		arg_10_0.ownDelegateDic_[arg_10_1][arg_10_2] = nil

		if arg_10_0.ownRunningDelegate_[arg_10_1].delegateID == arg_10_2 then
			arg_10_0.ownRunningDelegate_[arg_10_1] = nil
		end
	end
end

function var_0_0.GetOwnSubmitedDelegateList(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0.ownDelegateDic_[arg_11_1]) do
		if iter_11_1 ~= arg_11_0.ownRunningDelegate_[arg_11_1] then
			var_11_0[#var_11_0 + 1] = iter_11_1
		end
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0.timestamp > arg_12_1.timestamp
	end)

	return var_11_0
end

function var_0_0.GetOwnRunningDelegate(arg_13_0, arg_13_1)
	return arg_13_0.ownRunningDelegate_[arg_13_1] or {}
end

function var_0_0.GetOwnDelegateData(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0.ownDelegateDic_[arg_14_1][arg_14_2] or {}
end

function var_0_0.ReceivedDelegateReward(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.ownDelegateDic_[arg_15_1][arg_15_2]

	var_15_0.isReceived = true

	if var_15_0.delegateID == arg_15_0.ownRunningDelegate_[arg_15_1].delegateID then
		arg_15_0.ownRunningDelegate_[arg_15_1] = nil
	end

	arg_15_0.todayDispatchDelegateTimes_[arg_15_1] = arg_15_0.todayDispatchDelegateTimes_[arg_15_1] + 1

	local var_15_1 = var_15_0.targetID

	arg_15_0:SetUnlockCake(arg_15_1, var_15_1)
end

function var_0_0.SubmitDelegate(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0.recommendDelegateDic_[arg_16_1][arg_16_2][arg_16_3]

	var_16_0.isCompleted = true

	table.insert(arg_16_0.submitedDelegateList_[arg_16_1], var_16_0)

	arg_16_0.needSortSubmit_[arg_16_1] = true
	arg_16_0.submitedDelegateDic_[arg_16_1][arg_16_2] = arg_16_0.submitedDelegateDic_[arg_16_1][arg_16_2] or {}
	arg_16_0.submitedDelegateDic_[arg_16_1][arg_16_2][arg_16_3] = true
	arg_16_0.todaySubmitDelegateTimes_[arg_16_1] = arg_16_0.todaySubmitDelegateTimes_[arg_16_1] + 1
end

function var_0_0.GetSubmitedDelegateList(arg_17_0, arg_17_1)
	if arg_17_0.needSortSubmit_[arg_17_1] then
		arg_17_0.needSortSubmit_[arg_17_1] = false

		table.sort(arg_17_0.submitedDelegateList_[arg_17_1], function(arg_18_0, arg_18_1)
			return arg_18_0.timestamp > arg_18_1.timestamp
		end)
	end

	return arg_17_0.submitedDelegateList_[arg_17_1] or {}
end

function var_0_0.SetRecommendDelegate(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.recommendDelegateDic_[arg_19_1] or {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_2) do
		local var_19_2 = iter_19_1.user_id
		local var_19_3 = iter_19_1.entrust_id

		var_19_1[var_19_2] = var_19_1[var_19_2] or {}

		if var_19_0[var_19_2] and var_19_0[var_19_2][var_19_3] then
			var_19_1[var_19_2][var_19_3] = var_19_0[var_19_2][var_19_3]

			var_19_1[var_19_2][var_19_3]:UpdateData(iter_19_1)
		else
			var_19_1[var_19_2][var_19_3] = MoonDelegateDataTemplate.New(iter_19_1)
		end
	end

	arg_19_0.recommendDelegateDic_[arg_19_1] = var_19_1

	arg_19_0:UpdateRecommendDelegateUserInfo(arg_19_1)
end

function var_0_0.UpdateRecommendDelegateUserInfo(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:GetSortRecommendDelegateList(arg_20_1)
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1.uid ~= "0" then
			var_20_1[#var_20_1 + 1] = iter_20_1.uid
		end
	end

	if #var_20_1 > 0 then
		local var_20_2 = {
			user_id_list = var_20_1
		}

		manager.net:SendWithLoadingNew(32036, var_20_2, 32037, function(arg_21_0, arg_21_1)
			if not isSuccess(arg_21_0.result) then
				ShowTips(arg_21_0.result)

				return
			end

			local var_21_0 = {}

			for iter_21_0, iter_21_1 in ipairs(arg_21_0.user_brief_list) do
				var_21_0[iter_21_1.user_id] = iter_21_1
			end

			for iter_21_2, iter_21_3 in ipairs(var_20_0) do
				iter_21_3:UpdateUserInfo(var_21_0[iter_21_3.uid])
			end
		end)
	end
end

function var_0_0.GetRecommendDelegateDic(arg_22_0, arg_22_1)
	return arg_22_0.recommendDelegateDic_[arg_22_1]
end

function var_0_0.GetSortRecommendDelegateList(arg_23_0, arg_23_1)
	local var_23_0 = {}
	local var_23_1 = arg_23_0.recommendDelegateDic_[arg_23_1]

	for iter_23_0, iter_23_1 in pairs(var_23_1) do
		for iter_23_2, iter_23_3 in pairs(iter_23_1) do
			var_23_0[#var_23_0 + 1] = iter_23_3
		end
	end

	return var_23_0
end

function var_0_0.GetLastRefreshDelegateTime(arg_24_0, arg_24_1)
	return arg_24_0.lastRefreshDelegateTime_[arg_24_1] or 0
end

function var_0_0.SetLastRefreshDelegateTime(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.lastRefreshDelegateTime_[arg_25_1] = arg_25_2
end

function var_0_0.GetReceivedGroupDic(arg_26_0, arg_26_1)
	return arg_26_0.receivedCakeGroupDic_[arg_26_1]
end

function var_0_0.SetReceivedGroup(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.receivedCakeGroupDic_[arg_27_1][arg_27_2] = true
end

function var_0_0.GetUnlockCakeDic(arg_28_0, arg_28_1)
	return arg_28_0.unlockCakeDic_[arg_28_1]
end

function var_0_0.SetUnlockCake(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.unlockCakeDic_[arg_29_1][arg_29_2] = true
end

function var_0_0.GetTodayDisptachTimes(arg_30_0, arg_30_1)
	return arg_30_0.todayDispatchDelegateTimes_[arg_30_1]
end

function var_0_0.GetTodaySubmitTimes(arg_31_0, arg_31_1)
	return arg_31_0.todaySubmitDelegateTimes_[arg_31_1]
end

function var_0_0.SetSelectMakeFillingBtn(arg_32_0, arg_32_1)
	if not manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, arg_32_1)) then
		return
	end

	arg_32_0.selectedMakeFillingBtn_[arg_32_1] = true
end

function var_0_0.GetSelectMakeFillingBtn(arg_33_0, arg_33_1)
	return arg_33_0.selectedMakeFillingBtn_[arg_33_1]
end

function var_0_0.SetSelectMakeCakeBtn(arg_34_0, arg_34_1)
	if not manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, arg_34_1)) then
		return
	end

	arg_34_0.selectedMakeCakeBtn_[arg_34_1] = true
end

function var_0_0.GetSelectMakeCakeBtn(arg_35_0, arg_35_1)
	return arg_35_0.selectedMakeCakeBtn_[arg_35_1]
end

function var_0_0.SetSelectDelegateDispatchBtn(arg_36_0, arg_36_1)
	if not manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, arg_36_1)) then
		return
	end

	arg_36_0.selectedDelegateDispatchBtn_[arg_36_1] = true
end

function var_0_0.GetSelectDelegateDispatchBtn(arg_37_0, arg_37_1)
	return arg_37_0.selectedDelegateDispatchBtn_[arg_37_1]
end

function var_0_0.InitPartyData(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1.activity_id

	arg_38_0.todayVisitTimes_[var_38_0] = arg_38_1.visit_reward_num
	arg_38_0.todayVisitedDic_[var_38_0] = {}

	for iter_38_0, iter_38_1 in ipairs(arg_38_1.visit_list) do
		arg_38_0.todayVisitedDic_[var_38_0][iter_38_1] = true
		arg_38_0.todayVisitTimes_[var_38_0] = arg_38_0.todayVisitTimes_[var_38_0] + 1
	end

	arg_38_0.todayVisitRewardTimes_[var_38_0] = arg_38_1.visit_reward_num

	local var_38_1 = arg_38_1.banquet

	arg_38_0.partyData_[var_38_0] = MoonPartyDataTemplate.New(var_38_1)

	local var_38_2 = {}
	local var_38_3 = {}

	for iter_38_2, iter_38_3 in ipairs(arg_38_1.friend_list) do
		local var_38_4 = MoonPartyUserDataTemplate.New(iter_38_3)

		var_38_2[var_38_4.uid] = var_38_4
		var_38_3[#var_38_3 + 1] = var_38_4
	end

	arg_38_0.allPartyDic_[var_38_0] = var_38_2
	arg_38_0.friendPartyList_[var_38_0] = var_38_3
	arg_38_0.isRefreshedRecommend_ = arg_38_0.isRefreshedRecommend_ or {}
	arg_38_0.isRefreshedRecommend_[var_38_0] = false

	arg_38_0:UpdatePartyUserInfo(var_38_0)
end

function var_0_0.UpdatePartyUserInfo(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.allPartyDic_[arg_39_1]
	local var_39_1 = {}

	for iter_39_0, iter_39_1 in pairs(var_39_0) do
		var_39_1[#var_39_1 + 1] = iter_39_1.uid
	end

	if #var_39_1 > 0 then
		local var_39_2 = {
			user_id_list = var_39_1
		}

		manager.net:SendWithLoadingNew(32036, var_39_2, 32037, function(arg_40_0, arg_40_1)
			if not isSuccess(arg_40_0.result) then
				ShowTips(arg_40_0.result)

				return
			end

			local var_40_0 = {}

			for iter_40_0, iter_40_1 in ipairs(arg_40_0.user_brief_list) do
				var_40_0[iter_40_1.user_id] = iter_40_1
			end

			for iter_40_2, iter_40_3 in pairs(var_39_0) do
				iter_40_3:UpdateUserInfo(var_40_0[iter_40_3.uid])
			end
		end)
	end
end

function var_0_0.ResetPartyData(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1.activity_id

	arg_41_0.todayVisitTimes_[var_41_0] = 0
	arg_41_0.todayVisitRewardTimes_[var_41_0] = 0

	arg_41_0.partyData_[var_41_0]:Reset()

	arg_41_0.allPartyDic_[var_41_0] = {}
	arg_41_0.isRefreshedRecommend_[var_41_0] = false
	arg_41_0.refreshRecommendPartyTime_[var_41_0] = 0
end

function var_0_0.UpdateRecommendParty(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_2) do
		local var_42_1 = iter_42_1.user_id
		local var_42_2

		if not arg_42_0.allPartyDic_[arg_42_1][var_42_1] then
			var_42_2 = MoonPartyUserDataTemplate.New(iter_42_1)
			arg_42_0.allPartyDic_[arg_42_1][var_42_1] = var_42_2
		else
			var_42_2 = arg_42_0.allPartyDic_[arg_42_1][var_42_1]

			var_42_2:UpdateData(iter_42_1)
		end

		var_42_0[#var_42_0 + 1] = var_42_2
	end

	arg_42_0.recommendPartyList_[arg_42_1] = var_42_0
	arg_42_0.refreshRecommendPartyTime_[arg_42_1] = arg_42_3 + 1
	arg_42_0.isRefreshedRecommend_[arg_42_1] = true

	arg_42_0:UpdatePartyUserInfo(arg_42_1)
end

function var_0_0.OpenParty(arg_43_0, arg_43_1, arg_43_2)
	arg_43_0.partyData_[arg_43_1].partyType = arg_43_2
	arg_43_0.partyData_[arg_43_1].isOpened = true
	arg_43_0.partyData_[arg_43_1].visitNum = 0
	arg_43_0.partyData_[arg_43_1].closeTime = manager.time:GetNextFreshTime()
end

function var_0_0.GetOwnPartyData(arg_44_0, arg_44_1)
	return arg_44_0.partyData_[arg_44_1]
end

function var_0_0.GetSortedFriendPartyList(arg_45_0, arg_45_1)
	return arg_45_0.friendPartyList_[arg_45_1] or {}
end

function var_0_0.GetSortedRecommendPartyList(arg_46_0, arg_46_1)
	return arg_46_0.recommendPartyList_[arg_46_1] or {}
end

function var_0_0.GetRefreshRecommendPartyTime(arg_47_0, arg_47_1)
	return arg_47_0.refreshRecommendPartyTime_[arg_47_1] or 0
end

function var_0_0.SaveVisitPartyData(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = MoonPartyDataTemplate.New(arg_48_2)

	arg_48_0.tempPartyDataDic_[arg_48_1] = var_48_0

	if not arg_48_0.todayVisitedDic_[arg_48_1][arg_48_3] then
		arg_48_0.todayVisitedDic_[arg_48_1][arg_48_3] = true

		if not arg_48_0:GetVisitPartyOwnerData(arg_48_1, arg_48_3).isVisited then
			arg_48_0.todayVisitTimes_[arg_48_1] = arg_48_0.todayVisitTimes_[arg_48_1] + 1
		end
	end
end

function var_0_0.GetVisitPartyData(arg_49_0, arg_49_1)
	return arg_49_0.tempPartyDataDic_[arg_49_1] or {}
end

function var_0_0.SaveVisitPartyOwnerData(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_2.user_id
	local var_50_1

	if arg_50_0.allPartyDic_[arg_50_1][var_50_0] then
		var_50_1 = arg_50_0.allPartyDic_[arg_50_1][var_50_0]

		var_50_1:UpdateData(arg_50_2)
	else
		var_50_1 = MoonPartyUserDataTemplate.New(arg_50_2)
		arg_50_0.allPartyDic_[arg_50_1][var_50_0] = var_50_1
	end

	arg_50_0.tempVisitIndexList_[arg_50_1] = nil

	local var_50_2 = {
		var_50_1.uid
	}
	local var_50_3 = {
		user_id_list = var_50_2
	}

	manager.net:SendWithLoadingNew(32036, var_50_3, 32037, function(arg_51_0, arg_51_1)
		if not isSuccess(arg_51_0.result) then
			ShowTips(arg_51_0.result)

			return
		end

		local var_51_0 = arg_51_0.user_brief_list[1]

		var_50_1:UpdateUserInfo(var_51_0)
	end)
end

function var_0_0.GetVisitPartyOwnerData(arg_52_0, arg_52_1, arg_52_2)
	return arg_52_0.allPartyDic_[arg_52_1][arg_52_2]
end

function var_0_0.SetTempVisitIndex(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	arg_53_0.tempVisitIndexList_[arg_53_1] = arg_53_0.tempVisitIndexList_[arg_53_1] or {}
	arg_53_0.tempVisitIndexList_[arg_53_1].type = arg_53_2
	arg_53_0.tempVisitIndexList_[arg_53_1].index = arg_53_3

	local var_53_0 = {}

	if arg_53_2 == MoonCakeConst.VISIT_TYPE.ALL then
		local var_53_1 = MoonCakeData:GetSortedRecommendPartyList(arg_53_1)
	elseif arg_53_2 == MoonCakeConst.VISIT_TYPE.FRIEND then
		local var_53_2 = MoonCakeData:GetSortedFriendPartyList(arg_53_1)
	end
end

function var_0_0.GetTempVisitIndex(arg_54_0, arg_54_1)
	return arg_54_0.tempVisitIndexList_[arg_54_1]
end

function var_0_0.ReceivedVisitReward(arg_55_0, arg_55_1, arg_55_2)
	arg_55_0:GetVisitPartyOwnerData(arg_55_1, arg_55_2).isVisited = true
	arg_55_0.todayVisitRewardTimes_[arg_55_1] = arg_55_0.todayVisitRewardTimes_[arg_55_1] + 1
end

function var_0_0.GetTodayVisitTimes(arg_56_0, arg_56_1)
	return arg_56_0.todayVisitTimes_[arg_56_1] or 0
end

function var_0_0.GetTodayVisitRewardTimes(arg_57_0, arg_57_1)
	return arg_57_0.todayVisitRewardTimes_[arg_57_1] or 0
end

function var_0_0.IsRefreshedRecommend(arg_58_0, arg_58_1)
	return arg_58_0.isRefreshedRecommend_[arg_58_1]
end

function var_0_0.SetLastShareTimestamp(arg_59_0)
	arg_59_0.lastShareTimestamp_ = manager.time:GetServerTime() + 1
end

function var_0_0.GetLastShareTimestamp(arg_60_0)
	return arg_60_0.lastShareTimestamp_ or 0
end

return var_0_0
