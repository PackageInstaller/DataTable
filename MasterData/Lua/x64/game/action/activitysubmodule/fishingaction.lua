local var_0_0 = {}
local var_0_1 = false

manager.notify:RegistListener(RARE_FISH_CHANGE, function(arg_1_0)
	var_0_0.CheckGroupRewardRedPoint()
end)

function var_0_0.CheckReceiveRedPoint()
	manager.redPoint:setTip(RedPointConst.FISHING_RECEIVE_REWARD, #FishingData:GetFishReceiveInfo() > 0 and 1 or 0)
end

function var_0_0.CheckScoreRewardRedPoint()
	local var_3_0
	local var_3_1 = FishingData:GetActivityData()

	if var_3_1 then
		var_3_0 = var_3_1.score
	end

	local var_3_2 = false

	for iter_3_0, iter_3_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_FISHING]) do
		if var_3_0 < ActivityPointRewardCfg[iter_3_1].need or table.indexof(FishingData:GetActivityData().received_award_list, ActivityPointRewardCfg[iter_3_1].id) then
			-- block empty
		else
			var_3_2 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.FISHING_SCORE_REWARD, var_3_2 and 1 or 0)
end

function var_0_0.CheckGroupRewardRedPoint()
	local var_4_0 = false

	for iter_4_0, iter_4_1 in ipairs(ActivitySummerFishGroupCfg.all) do
		local var_4_1 = true

		for iter_4_2, iter_4_3 in ipairs(ActivitySummerFishGroupCfg[iter_4_1].group[1]) do
			local var_4_3 = FishingData:GetActivityData().fish_infos[iter_4_3]

			if not (var_4_3 and var_4_3.num > 0) then
				var_4_1 = false

				break
			end
		end

		if table.indexof(FishingData:GetActivityData().received_constitute_list, ActivitySummerFishGroupCfg[iter_4_1].id) then
			-- block empty
		elseif var_4_1 then
			var_4_0 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.FISHING_GROUP_REWARD, var_4_0 and 1 or 0)
end

function var_0_0.ReadUnFinishRedPoint()
	saveData("fishing", "unfinish", _G.gameTimer:GetNextDayFreshTime())
	var_0_0.CheckUnFinishRedPoint()
end

function var_0_0.CheckUnFinishRedPoint()
	local var_6_0 = getData("fishing", "unfinish")

	if FishingData:GetActivityData() then
		-- block empty
	end

	local var_6_6 = #FishingData:GetActivityData().received_award_list < #ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_FISHING]
	local var_6_7 = #FishingData:GetActivityData().received_constitute_list < #ActivitySummerFishGroupCfg.all

	if var_6_0 ~= nil and var_6_0 > manager.time:GetServerTime() then
		manager.redPoint:setTip(RedPointConst.FISHING_NOT_FINISH, 0)
	elseif var_6_7 or var_6_6 then
		manager.redPoint:setTip(RedPointConst.FISHING_NOT_FINISH, 1)
	else
		manager.redPoint:setTip(RedPointConst.FISHING_NOT_FINISH, 0)
	end
end

function var_0_0.Init()
	if var_0_1 then
		return
	end

	manager.redPoint:addGroup(RedPointConst.FISHING .. "_" .. ActivityConst.SUMMER_FISHING, {
		RedPointConst.FISHING_SCORE_REWARD,
		RedPointConst.FISHING_GROUP_REWARD,
		RedPointConst.FISHING_NOT_FINISH
	})
	manager.net:Bind(60001, function(arg_8_0)
		FishingData:Reset()
		FishingData:InitFromServer(arg_8_0.info)
		var_0_0.CheckScoreRewardRedPoint()
		var_0_0.CheckGroupRewardRedPoint()
		var_0_0.CheckUnFinishRedPoint()
	end)

	var_0_1 = true
end

function var_0_0.EndingFishing(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	manager.net:SendWithLoadingNew(60002, {
		info = {
			score = arg_9_1,
			treasure = arg_9_2
		},
		activity_id = arg_9_0
	}, 60003, function(arg_10_0, arg_10_1)
		if isSuccess(arg_10_0.result) then
			FishingData:OnFishingResult(arg_10_0.result_score, arg_10_0.fish_info, arg_10_1.info.treasure)
			var_0_0.CheckScoreRewardRedPoint()

			if arg_9_3 ~= nil then
				arg_9_3(arg_10_0.result_score, arg_10_0.fish_info)
			end
		else
			ShowTips(GetTips(arg_10_0.result))
		end
	end)
end

function var_0_0.UpdateRequest(arg_11_0, arg_11_1)
	manager.net:SendWithLoadingNew(60004, {
		request_info = arg_11_1,
		activity_id = arg_11_0
	}, 60005, var_0_0.OnUpdateRequestCallback)
end

function var_0_0:OnUpdateRequestCallback(arg_12_1)
	if isSuccess(self.result) then
		FishingData:UpdateRequest(arg_12_1.request_info)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.GetReceiveInfo(arg_13_0, arg_13_1)
	manager.net:SendWithLoadingNew(60006, {
		activity_id = arg_13_0
	}, 60007, function(arg_14_0, arg_14_1)
		if isSuccess(arg_14_0.result) then
			FishingData:OnReceiveInfoGet(arg_14_0.fish_receive)
			var_0_0.CheckReceiveRedPoint()

			if arg_13_1 ~= nil then
				arg_13_1()
			end
		else
			ShowTips(arg_14_0.result)
		end
	end)
end

function var_0_0.GetFriendsFish(arg_15_0, arg_15_1, arg_15_2)
	manager.net:SendWithLoadingNew(60008, {
		activity_id = arg_15_0,
		sender_id = arg_15_1,
		timestamp = arg_15_2
	}, 60009, var_0_0.OnGetFriendsFishCallback)
end

function var_0_0:OnGetFriendsFishCallback(arg_16_1)
	if isSuccess(self.result) then
		FishingData:OnReceiveFriendsFish(arg_16_1.sender_id, arg_16_1.timestamp, self.fish_info)
		var_0_0.CheckReceiveRedPoint()
		ShowTips("FISHING_RECEIVE_SUCCESS")
	else
		ShowTips(self.result)
	end
end

function var_0_0.GiveRareFish(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	manager.net:SendWithLoadingNew(60010, {
		activity_id = arg_17_0,
		fish_id = arg_17_1,
		receiver_id = arg_17_2
	}, 60011, function(arg_18_0, arg_18_1)
		if isSuccess(arg_18_0.result) then
			ShowTips("FISHING_GIVE_SUCCESS")
			FishingData:OnGiveComplete(arg_18_1.receiver_id, arg_18_1.fish_id, 1)

			if arg_17_3 ~= nil then
				arg_17_3()
			end
		else
			ShowTips(GetTips(arg_18_0.result))
		end
	end)
end

function var_0_0.GetBonus(arg_19_0, arg_19_1)
	manager.net:SendWithLoadingNew(60012, {
		activity_id = arg_19_0,
		award_id = arg_19_1
	}, 60013, var_0_0.OnGetBonusCallback)
end

function var_0_0:OnGetBonusCallback(arg_20_1)
	if isSuccess(self.result) then
		FishingData:OnGetScoreReward(arg_20_1.award_id)
		var_0_0.CheckScoreRewardRedPoint()
		getReward2(mergeReward2(self.reward_list))
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.GetConstituteFishBonus(arg_21_0, arg_21_1)
	manager.net:SendWithLoadingNew(60014, {
		activity_id = arg_21_0,
		constitute_id = arg_21_1
	}, 60015, var_0_0.OnConstituteFishCallback)
end

function var_0_0:OnConstituteFishCallback(arg_22_1)
	if isSuccess(self.result) then
		FishingData:OnGetGroupReward(arg_22_1.constitute_id)
		var_0_0.CheckGroupRewardRedPoint()
		getReward(formatRewardCfgList(ActivitySummerFishGroupCfg[arg_22_1.constitute_id].reward_item_list))
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.GetFriendNeedFish(arg_23_0, arg_23_1)
	manager.net:SendWithLoadingNew(60016, {
		activity_id = arg_23_0
	}, 60017, function(arg_24_0, arg_24_1)
		if isSuccess(arg_24_0.result) then
			FishingData:OnFriendRequestFishInfoGet(arg_24_0.friend_need_list)

			if arg_23_1 ~= nil then
				arg_23_1()
			end
		else
			ShowTips(arg_24_0.result)
		end
	end)
end

function var_0_0.FishingBuyFish(arg_25_0, arg_25_1, arg_25_2)
	manager.net:SendWithLoadingNew(60018, {
		activity_id = arg_25_0,
		goods_id = arg_25_1,
		num = arg_25_2
	}, 60019, var_0_0.OnFishingBuyFishCallback)
end

function var_0_0:OnFishingBuyFishCallback(arg_26_1)
	if isSuccess(self.result) then
		ShowTips("TRANSACTION_SUCCESS")
		FishingData:OnBuySuccess(arg_26_1.goods_id, arg_26_1.num, self.info[1])
		manager.notify:Invoke(FISHING_BUY_SUCCESS, arg_26_1.goods_id)
	else
		ShowTips(self.result)
	end
end

return var_0_0
