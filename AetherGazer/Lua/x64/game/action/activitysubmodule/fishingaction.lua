local var_0_0 = {}
local var_0_1 = false

manager.notify:RegistListener(RARE_FISH_CHANGE, function(arg_1_0)
	var_0_0.CheckGroupRewardRedPoint()
end)

function var_0_0.CheckReceiveRedPoint()
	local var_2_0 = #FishingData:GetFishReceiveInfo() > 0

	manager.redPoint:setTip(RedPointConst.FISHING_RECEIVE_REWARD, var_2_0 and 1 or 0)
end

function var_0_0.CheckScoreRewardRedPoint()
	local var_3_0
	local var_3_1 = FishingData:GetActivityData()

	if var_3_1 then
		var_3_0 = var_3_1.score
	end

	local var_3_2 = false

	for iter_3_0, iter_3_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_FISHING]) do
		local var_3_3 = ActivityPointRewardCfg[iter_3_1]

		if var_3_0 >= var_3_3.need then
			local var_3_4 = FishingData:GetActivityData().received_award_list

			if table.indexof(var_3_4, var_3_3.id) then
				-- block empty
			else
				var_3_2 = true

				break
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.FISHING_SCORE_REWARD, var_3_2 and 1 or 0)
end

function var_0_0.CheckGroupRewardRedPoint()
	local var_4_0 = false

	for iter_4_0, iter_4_1 in ipairs(ActivitySummerFishGroupCfg.all) do
		local var_4_1 = true
		local var_4_2 = ActivitySummerFishGroupCfg[iter_4_1]

		for iter_4_2, iter_4_3 in ipairs(var_4_2.group[1]) do
			local var_4_3
			local var_4_4 = FishingData:GetActivityData().fish_infos[iter_4_3]

			if not (var_4_4 and var_4_4.num > 0 and true or false) then
				var_4_1 = false

				break
			end
		end

		local var_4_5 = FishingData:GetActivityData().received_constitute_list

		if table.indexof(var_4_5, var_4_2.id) then
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
	local var_6_1
	local var_6_2
	local var_6_3 = 0
	local var_6_4 = FishingData:GetActivityData()

	if var_6_4 then
		local var_6_5 = var_6_4.score
	end

	local var_6_6 = FishingData:GetActivityData().received_award_list
	local var_6_7 = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_FISHING]
	local var_6_8 = #var_6_6 < #var_6_7
	local var_6_9 = #FishingData:GetActivityData().received_constitute_list < #ActivitySummerFishGroupCfg.all

	if var_6_0 ~= nil and var_6_0 > manager.time:GetServerTime() then
		manager.redPoint:setTip(RedPointConst.FISHING_NOT_FINISH, 0)
	elseif var_6_9 or var_6_8 then
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
	local var_9_0 = {
		info = {
			score = arg_9_1,
			treasure = arg_9_2
		},
		activity_id = arg_9_0
	}

	manager.net:SendWithLoadingNew(60002, var_9_0, 60003, function(arg_10_0, arg_10_1)
		if isSuccess(arg_10_0.result) then
			local var_10_0 = arg_10_0.result_score
			local var_10_1 = arg_10_0.fish_info

			FishingData:OnFishingResult(var_10_0, var_10_1, arg_10_1.info.treasure)
			var_0_0.CheckScoreRewardRedPoint()

			if arg_9_3 ~= nil then
				arg_9_3(var_10_0, var_10_1)
			end
		else
			ShowTips(GetTips(arg_10_0.result))
		end
	end)
end

function var_0_0.UpdateRequest(arg_11_0, arg_11_1)
	local var_11_0 = {
		request_info = arg_11_1,
		activity_id = arg_11_0
	}

	manager.net:SendWithLoadingNew(60004, var_11_0, 60005, var_0_0.OnUpdateRequestCallback)
end

function var_0_0.OnUpdateRequestCallback(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		FishingData:UpdateRequest(arg_12_1.request_info)
	else
		ShowTips(GetTips(arg_12_0.result))
	end
end

function var_0_0.GetReceiveInfo(arg_13_0, arg_13_1)
	local var_13_0 = {
		activity_id = arg_13_0
	}

	manager.net:SendWithLoadingNew(60006, var_13_0, 60007, function(arg_14_0, arg_14_1)
		if isSuccess(arg_14_0.result) then
			local var_14_0 = arg_14_0.fish_receive

			FishingData:OnReceiveInfoGet(var_14_0)
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
	local var_15_0 = {
		activity_id = arg_15_0,
		sender_id = arg_15_1,
		timestamp = arg_15_2
	}

	manager.net:SendWithLoadingNew(60008, var_15_0, 60009, var_0_0.OnGetFriendsFishCallback)
end

function var_0_0.OnGetFriendsFishCallback(arg_16_0, arg_16_1)
	if isSuccess(arg_16_0.result) then
		FishingData:OnReceiveFriendsFish(arg_16_1.sender_id, arg_16_1.timestamp, arg_16_0.fish_info)
		var_0_0.CheckReceiveRedPoint()
		ShowTips("FISHING_RECEIVE_SUCCESS")
	else
		ShowTips(arg_16_0.result)
	end
end

function var_0_0.GiveRareFish(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = {
		activity_id = arg_17_0,
		fish_id = arg_17_1,
		receiver_id = arg_17_2
	}

	manager.net:SendWithLoadingNew(60010, var_17_0, 60011, function(arg_18_0, arg_18_1)
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
	local var_19_0 = {
		activity_id = arg_19_0,
		award_id = arg_19_1
	}

	manager.net:SendWithLoadingNew(60012, var_19_0, 60013, var_0_0.OnGetBonusCallback)
end

function var_0_0.OnGetBonusCallback(arg_20_0, arg_20_1)
	if isSuccess(arg_20_0.result) then
		FishingData:OnGetScoreReward(arg_20_1.award_id)
		var_0_0.CheckScoreRewardRedPoint()
		getReward2(mergeReward2(arg_20_0.reward_list))
	else
		ShowTips(GetTips(arg_20_0.result))
	end
end

function var_0_0.GetConstituteFishBonus(arg_21_0, arg_21_1)
	local var_21_0 = {
		activity_id = arg_21_0,
		constitute_id = arg_21_1
	}

	manager.net:SendWithLoadingNew(60014, var_21_0, 60015, var_0_0.OnConstituteFishCallback)
end

function var_0_0.OnConstituteFishCallback(arg_22_0, arg_22_1)
	if isSuccess(arg_22_0.result) then
		FishingData:OnGetGroupReward(arg_22_1.constitute_id)
		var_0_0.CheckGroupRewardRedPoint()
		getReward(formatRewardCfgList(ActivitySummerFishGroupCfg[arg_22_1.constitute_id].reward_item_list))
	else
		ShowTips(GetTips(arg_22_0.result))
	end
end

function var_0_0.GetFriendNeedFish(arg_23_0, arg_23_1)
	local var_23_0 = {
		activity_id = arg_23_0
	}

	manager.net:SendWithLoadingNew(60016, var_23_0, 60017, function(arg_24_0, arg_24_1)
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
	local var_25_0 = {
		activity_id = arg_25_0,
		goods_id = arg_25_1,
		num = arg_25_2
	}

	manager.net:SendWithLoadingNew(60018, var_25_0, 60019, var_0_0.OnFishingBuyFishCallback)
end

function var_0_0.OnFishingBuyFishCallback(arg_26_0, arg_26_1)
	if isSuccess(arg_26_0.result) then
		ShowTips("TRANSACTION_SUCCESS")
		FishingData:OnBuySuccess(arg_26_1.goods_id, arg_26_1.num, arg_26_0.info[1])
		manager.notify:Invoke(FISHING_BUY_SUCCESS, arg_26_1.goods_id)
	else
		ShowTips(arg_26_0.result)
	end
end

return var_0_0
