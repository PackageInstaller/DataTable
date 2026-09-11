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

function var_0_0:InitCakeData(arg_2_1)
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.give_list) do
		local var_2_2 = MoonDelegateDataTemplate.New(iter_2_1)

		var_2_2.isCompleted = true
		var_2_0[#var_2_0 + 1] = var_2_2
		var_2_1[var_2_2.uid] = var_2_1[var_2_2.uid] or {}
		var_2_1[var_2_2.uid][var_2_2.delegateID] = var_2_2
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0.timestamp > arg_3_1.timestamp
	end)

	self.submitedDelegateList_[arg_2_1.activity_id] = var_2_0
	self.submitedDelegateDic_[arg_2_1.activity_id] = var_2_1
	self.needSortSubmit_[arg_2_1.activity_id] = false

	local var_2_3 = {}
	local var_2_4

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.entrust_list) do
		local var_2_5 = MoonDelegateDataTemplate.New(iter_2_3)

		var_2_3[var_2_5.delegateID] = var_2_5

		if var_2_5.isCompleted == false or var_2_5.isReceived == false then
			var_2_4 = var_2_5
		end
	end

	self.ownDelegateDic_[arg_2_1.activity_id] = var_2_3
	self.ownRunningDelegate_[arg_2_1.activity_id] = var_2_4
	self.todaySubmitDelegateTimes_[arg_2_1.activity_id] = arg_2_1.today_present_num
	self.todayDispatchDelegateTimes_[arg_2_1.activity_id] = arg_2_1.today_entrust_num
	self.unlockCakeDic_[arg_2_1.activity_id] = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.moon_cakes_collect_list) do
		self.unlockCakeDic_[arg_2_1.activity_id][iter_2_5] = true
	end

	self.receivedCakeGroupDic_[arg_2_1.activity_id] = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.moon_cakes_collect_reward_list) do
		self.receivedCakeGroupDic_[arg_2_1.activity_id][iter_2_7] = true
	end

	self:UpdateSubmitDelegateUserInfo(arg_2_1.activity_id)
	self:UpdateOwnDelegateUserInfo(arg_2_1.activity_id)
end

function var_0_0:UpdateSubmitDelegateUserInfo(arg_4_1)
	local var_4_0 = self:GetSubmitedDelegateList(arg_4_1)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1.uid ~= "0" then
			var_4_1[#var_4_1 + 1] = iter_4_1.uid
		end
	end

	if #var_4_1 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = var_4_1
		}, 32037, function(arg_5_0, arg_5_1)
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

function var_0_0:UpdateOwnDelegateUserInfo(arg_6_1)
	local var_6_0 = self.ownDelegateDic_[arg_6_1]
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs(self.ownDelegateDic_[arg_6_1]) do
		if iter_6_1.submiter_uid ~= "0" then
			var_6_1[#var_6_1 + 1] = iter_6_1.submiter_uid
		end
	end

	if #var_6_1 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = var_6_1
		}, 32037, function(arg_7_0, arg_7_1)
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

function var_0_0:UpdateOwnDelegate(arg_8_1)
	local var_8_0 = arg_8_1.entrust.entrust_id

	if self.ownDelegateDic_[arg_8_1.activity_id][arg_8_1.entrust.entrust_id] then
		self.ownDelegateDic_[arg_8_1.activity_id][var_8_0]:UpdateData(arg_8_1.entrust)
	else
		local var_8_1 = MoonDelegateDataTemplate.New(arg_8_1.entrust)

		self.ownDelegateDic_[arg_8_1.activity_id][var_8_0] = var_8_1
		self.ownRunningDelegate_[arg_8_1.activity_id] = var_8_1
	end

	local var_8_2 = {}
	local var_8_3 = self.ownDelegateDic_[arg_8_1.activity_id][var_8_0]

	if self.ownDelegateDic_[arg_8_1.activity_id][var_8_0].submiter_uid ~= "0" then
		var_8_2[#var_8_2 + 1] = self.ownDelegateDic_[arg_8_1.activity_id][var_8_0].submiter_uid
	end

	if #var_8_2 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = var_8_2
		}, 32037, function(arg_9_0, arg_9_1)
			if not isSuccess(arg_9_0.result) then
				ShowTips(arg_9_0.result)

				return
			end

			var_8_3:UpdateUserInfo(arg_9_0.user_brief_list[1])
		end)
	end
end

function var_0_0:CancelDelegate(arg_10_1, arg_10_2)
	if self.ownDelegateDic_[arg_10_1][arg_10_2] then
		self.ownDelegateDic_[arg_10_1][arg_10_2] = nil

		if self.ownRunningDelegate_[arg_10_1].delegateID == arg_10_2 then
			self.ownRunningDelegate_[arg_10_1] = nil
		end
	end
end

function var_0_0:GetOwnSubmitedDelegateList(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.ownDelegateDic_[arg_11_1]) do
		if iter_11_1 ~= self.ownRunningDelegate_[arg_11_1] then
			var_11_0[#var_11_0 + 1] = iter_11_1
		end
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0.timestamp > arg_12_1.timestamp
	end)

	return var_11_0
end

function var_0_0:GetOwnRunningDelegate(arg_13_1)
	return self.ownRunningDelegate_[arg_13_1] or {}
end

function var_0_0:GetOwnDelegateData(arg_14_1, arg_14_2)
	return self.ownDelegateDic_[arg_14_1][arg_14_2] or {}
end

function var_0_0:ReceivedDelegateReward(arg_15_1, arg_15_2)
	self.ownDelegateDic_[arg_15_1][arg_15_2].isReceived = true

	if self.ownDelegateDic_[arg_15_1][arg_15_2].delegateID == self.ownRunningDelegate_[arg_15_1].delegateID then
		self.ownRunningDelegate_[arg_15_1] = nil
	end

	self.todayDispatchDelegateTimes_[arg_15_1] = self.todayDispatchDelegateTimes_[arg_15_1] + 1

	self:SetUnlockCake(arg_15_1, self.ownDelegateDic_[arg_15_1][arg_15_2].targetID)
end

function var_0_0:SubmitDelegate(arg_16_1, arg_16_2, arg_16_3)
	self.recommendDelegateDic_[arg_16_1][arg_16_2][arg_16_3].isCompleted = true

	table.insert(self.submitedDelegateList_[arg_16_1], self.recommendDelegateDic_[arg_16_1][arg_16_2][arg_16_3])

	self.needSortSubmit_[arg_16_1] = true
	self.submitedDelegateDic_[arg_16_1][arg_16_2] = self.submitedDelegateDic_[arg_16_1][arg_16_2] or {}
	self.submitedDelegateDic_[arg_16_1][arg_16_2][arg_16_3] = true
	self.todaySubmitDelegateTimes_[arg_16_1] = self.todaySubmitDelegateTimes_[arg_16_1] + 1
end

function var_0_0:GetSubmitedDelegateList(arg_17_1)
	if self.needSortSubmit_[arg_17_1] then
		self.needSortSubmit_[arg_17_1] = false

		table.sort(self.submitedDelegateList_[arg_17_1], function(arg_18_0, arg_18_1)
			return arg_18_0.timestamp > arg_18_1.timestamp
		end)
	end

	return self.submitedDelegateList_[arg_17_1] or {}
end

function var_0_0:SetRecommendDelegate(arg_19_1, arg_19_2)
	local var_19_0 = self.recommendDelegateDic_[arg_19_1] or {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_2) do
		var_19_1[iter_19_1.user_id] = var_19_1[iter_19_1.user_id] or {}

		if var_19_0[iter_19_1.user_id] and var_19_0[iter_19_1.user_id][iter_19_1.entrust_id] then
			var_19_1[iter_19_1.user_id][iter_19_1.entrust_id] = var_19_0[iter_19_1.user_id][iter_19_1.entrust_id]

			var_19_1[iter_19_1.user_id][iter_19_1.entrust_id]:UpdateData(iter_19_1)
		else
			var_19_1[iter_19_1.user_id][iter_19_1.entrust_id] = MoonDelegateDataTemplate.New(iter_19_1)
		end
	end

	self.recommendDelegateDic_[arg_19_1] = var_19_1

	self:UpdateRecommendDelegateUserInfo(arg_19_1)
end

function var_0_0:UpdateRecommendDelegateUserInfo(arg_20_1)
	local var_20_0 = self:GetSortRecommendDelegateList(arg_20_1)
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1.uid ~= "0" then
			var_20_1[#var_20_1 + 1] = iter_20_1.uid
		end
	end

	if #var_20_1 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = var_20_1
		}, 32037, function(arg_21_0, arg_21_1)
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

function var_0_0:GetRecommendDelegateDic(arg_22_1)
	return self.recommendDelegateDic_[arg_22_1]
end

function var_0_0:GetSortRecommendDelegateList(arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.recommendDelegateDic_[arg_23_1]) do
		for iter_23_2, iter_23_3 in pairs(iter_23_1) do
			var_23_0[#var_23_0 + 1] = iter_23_3
		end
	end

	return var_23_0
end

function var_0_0:GetLastRefreshDelegateTime(arg_24_1)
	return self.lastRefreshDelegateTime_[arg_24_1] or 0
end

function var_0_0:SetLastRefreshDelegateTime(arg_25_1, arg_25_2)
	self.lastRefreshDelegateTime_[arg_25_1] = arg_25_2
end

function var_0_0:GetReceivedGroupDic(arg_26_1)
	return self.receivedCakeGroupDic_[arg_26_1]
end

function var_0_0:SetReceivedGroup(arg_27_1, arg_27_2)
	self.receivedCakeGroupDic_[arg_27_1][arg_27_2] = true
end

function var_0_0:GetUnlockCakeDic(arg_28_1)
	return self.unlockCakeDic_[arg_28_1]
end

function var_0_0:SetUnlockCake(arg_29_1, arg_29_2)
	self.unlockCakeDic_[arg_29_1][arg_29_2] = true
end

function var_0_0:GetTodayDisptachTimes(arg_30_1)
	return self.todayDispatchDelegateTimes_[arg_30_1]
end

function var_0_0:GetTodaySubmitTimes(arg_31_1)
	return self.todaySubmitDelegateTimes_[arg_31_1]
end

function var_0_0:SetSelectMakeFillingBtn(arg_32_1)
	if not manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, arg_32_1)) then
		return
	end

	self.selectedMakeFillingBtn_[arg_32_1] = true
end

function var_0_0:GetSelectMakeFillingBtn(arg_33_1)
	return self.selectedMakeFillingBtn_[arg_33_1]
end

function var_0_0:SetSelectMakeCakeBtn(arg_34_1)
	if not manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, arg_34_1)) then
		return
	end

	self.selectedMakeCakeBtn_[arg_34_1] = true
end

function var_0_0:GetSelectMakeCakeBtn(arg_35_1)
	return self.selectedMakeCakeBtn_[arg_35_1]
end

function var_0_0:SetSelectDelegateDispatchBtn(arg_36_1)
	if not manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, arg_36_1)) then
		return
	end

	self.selectedDelegateDispatchBtn_[arg_36_1] = true
end

function var_0_0:GetSelectDelegateDispatchBtn(arg_37_1)
	return self.selectedDelegateDispatchBtn_[arg_37_1]
end

function var_0_0:InitPartyData(arg_38_1)
	self.todayVisitTimes_[arg_38_1.activity_id] = arg_38_1.visit_reward_num
	self.todayVisitedDic_[arg_38_1.activity_id] = {}

	for iter_38_0, iter_38_1 in ipairs(arg_38_1.visit_list) do
		self.todayVisitedDic_[arg_38_1.activity_id][iter_38_1] = true
		self.todayVisitTimes_[arg_38_1.activity_id] = self.todayVisitTimes_[arg_38_1.activity_id] + 1
	end

	self.todayVisitRewardTimes_[arg_38_1.activity_id] = arg_38_1.visit_reward_num
	self.partyData_[arg_38_1.activity_id] = MoonPartyDataTemplate.New(arg_38_1.banquet)

	local var_38_0 = {}
	local var_38_1 = {}

	for iter_38_2, iter_38_3 in ipairs(arg_38_1.friend_list) do
		local var_38_2 = MoonPartyUserDataTemplate.New(iter_38_3)

		var_38_0[var_38_2.uid] = var_38_2
		var_38_1[#var_38_1 + 1] = var_38_2
	end

	self.allPartyDic_[arg_38_1.activity_id] = var_38_0
	self.friendPartyList_[arg_38_1.activity_id] = var_38_1
	self.isRefreshedRecommend_ = self.isRefreshedRecommend_ or {}
	self.isRefreshedRecommend_[arg_38_1.activity_id] = false

	self:UpdatePartyUserInfo(arg_38_1.activity_id)
end

function var_0_0:UpdatePartyUserInfo(arg_39_1)
	local var_39_0 = self.allPartyDic_[arg_39_1]
	local var_39_1 = {}

	for iter_39_0, iter_39_1 in pairs(self.allPartyDic_[arg_39_1]) do
		var_39_1[#var_39_1 + 1] = iter_39_1.uid
	end

	if #var_39_1 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = var_39_1
		}, 32037, function(arg_40_0, arg_40_1)
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

function var_0_0:ResetPartyData(arg_41_1)
	self.todayVisitTimes_[arg_41_1.activity_id] = 0
	self.todayVisitRewardTimes_[arg_41_1.activity_id] = 0

	self.partyData_[arg_41_1.activity_id]:Reset()

	self.allPartyDic_[arg_41_1.activity_id] = {}
	self.isRefreshedRecommend_[arg_41_1.activity_id] = false
	self.refreshRecommendPartyTime_[arg_41_1.activity_id] = 0
end

function var_0_0:UpdateRecommendParty(arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_2) do
		local var_42_1

		if not self.allPartyDic_[arg_42_1][iter_42_1.user_id] then
			var_42_1 = MoonPartyUserDataTemplate.New(iter_42_1)
			self.allPartyDic_[arg_42_1][iter_42_1.user_id] = var_42_1
		else
			var_42_1 = self.allPartyDic_[arg_42_1][iter_42_1.user_id]

			self.allPartyDic_[arg_42_1][iter_42_1.user_id]:UpdateData(iter_42_1)
		end

		var_42_0[#var_42_0 + 1] = var_42_1
	end

	self.recommendPartyList_[arg_42_1] = var_42_0
	self.refreshRecommendPartyTime_[arg_42_1] = arg_42_3 + 1
	self.isRefreshedRecommend_[arg_42_1] = true

	self:UpdatePartyUserInfo(arg_42_1)
end

function var_0_0:OpenParty(arg_43_1, arg_43_2)
	self.partyData_[arg_43_1].partyType = arg_43_2
	self.partyData_[arg_43_1].isOpened = true
	self.partyData_[arg_43_1].visitNum = 0
	self.partyData_[arg_43_1].closeTime = manager.time:GetNextFreshTime()
end

function var_0_0:GetOwnPartyData(arg_44_1)
	return self.partyData_[arg_44_1]
end

function var_0_0:GetSortedFriendPartyList(arg_45_1)
	return self.friendPartyList_[arg_45_1] or {}
end

function var_0_0:GetSortedRecommendPartyList(arg_46_1)
	return self.recommendPartyList_[arg_46_1] or {}
end

function var_0_0:GetRefreshRecommendPartyTime(arg_47_1)
	return self.refreshRecommendPartyTime_[arg_47_1] or 0
end

function var_0_0:SaveVisitPartyData(arg_48_1, arg_48_2, arg_48_3)
	self.tempPartyDataDic_[arg_48_1] = MoonPartyDataTemplate.New(arg_48_2)

	if not self.todayVisitedDic_[arg_48_1][arg_48_3] then
		self.todayVisitedDic_[arg_48_1][arg_48_3] = true

		if not self:GetVisitPartyOwnerData(arg_48_1, arg_48_3).isVisited then
			self.todayVisitTimes_[arg_48_1] = self.todayVisitTimes_[arg_48_1] + 1
		end
	end
end

function var_0_0:GetVisitPartyData(arg_49_1)
	return self.tempPartyDataDic_[arg_49_1] or {}
end

function var_0_0:SaveVisitPartyOwnerData(arg_50_1, arg_50_2)
	local var_50_0

	if self.allPartyDic_[arg_50_1][arg_50_2.user_id] then
		var_50_0 = self.allPartyDic_[arg_50_1][arg_50_2.user_id]

		self.allPartyDic_[arg_50_1][arg_50_2.user_id]:UpdateData(arg_50_2)
	else
		var_50_0 = MoonPartyUserDataTemplate.New(arg_50_2)
		self.allPartyDic_[arg_50_1][arg_50_2.user_id] = var_50_0
	end

	self.tempVisitIndexList_[arg_50_1] = nil

	manager.net:SendWithLoadingNew(32036, {
		user_id_list = {
			var_50_0.uid
		}
	}, 32037, function(arg_51_0, arg_51_1)
		if not isSuccess(arg_51_0.result) then
			ShowTips(arg_51_0.result)

			return
		end

		var_50_0:UpdateUserInfo(arg_51_0.user_brief_list[1])
	end)
end

function var_0_0:GetVisitPartyOwnerData(arg_52_1, arg_52_2)
	return self.allPartyDic_[arg_52_1][arg_52_2]
end

function var_0_0:SetTempVisitIndex(arg_53_1, arg_53_2, arg_53_3)
	self.tempVisitIndexList_[arg_53_1] = self.tempVisitIndexList_[arg_53_1] or {}
	self.tempVisitIndexList_[arg_53_1].type = arg_53_2
	self.tempVisitIndexList_[arg_53_1].index = arg_53_3

	if arg_53_2 == MoonCakeConst.VISIT_TYPE.ALL then
		local var_53_1 = MoonCakeData:GetSortedRecommendPartyList(arg_53_1)
	elseif arg_53_2 == MoonCakeConst.VISIT_TYPE.FRIEND then
		local var_53_2 = MoonCakeData:GetSortedFriendPartyList(arg_53_1)
	end
end

function var_0_0:GetTempVisitIndex(arg_54_1)
	return self.tempVisitIndexList_[arg_54_1]
end

function var_0_0:ReceivedVisitReward(arg_55_1, arg_55_2)
	self:GetVisitPartyOwnerData(arg_55_1, arg_55_2).isVisited = true
	self.todayVisitRewardTimes_[arg_55_1] = self.todayVisitRewardTimes_[arg_55_1] + 1
end

function var_0_0:GetTodayVisitTimes(arg_56_1)
	return self.todayVisitTimes_[arg_56_1] or 0
end

function var_0_0:GetTodayVisitRewardTimes(arg_57_1)
	return self.todayVisitRewardTimes_[arg_57_1] or 0
end

function var_0_0:IsRefreshedRecommend(arg_58_1)
	return self.isRefreshedRecommend_[arg_58_1]
end

function var_0_0.SetLastShareTimestamp(arg_59_0)
	arg_59_0.lastShareTimestamp_ = manager.time:GetServerTime() + 1
end

function var_0_0:GetLastShareTimestamp()
	return self.lastShareTimestamp_ or 0
end

return var_0_0
