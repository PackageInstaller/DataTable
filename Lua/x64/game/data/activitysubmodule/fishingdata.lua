local var_0_0 = singletonClass("FishingData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Reset(arg_1_0)
	var_0_1 = {}
	var_0_1.fish_infos = {}
	var_0_1.request_infos = {}
	var_0_1.received_award_list = {}
	var_0_1.received_constitute_list = {}
	var_0_1.send_present_list = {}
	var_0_1.score = 0
	var_0_2 = {}
	var_0_3 = {}
end

function var_0_0.InitFromServer(arg_2_0, arg_2_1)
	var_0_1.score = arg_2_1.score
	var_0_1.today_total_score = arg_2_1.today_total_score
	var_0_1.today_treasure_num = arg_2_1.today_treasure_num
	var_0_1.send_present_list = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.send_present_list) do
		var_0_1.send_present_list[iter_2_1.id] = iter_2_1.num
	end

	var_0_1.fish_infos = {}
	var_0_1.request_infos = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.fish_info) do
		local var_2_0 = {
			id = iter_2_3.id,
			num = iter_2_3.num,
			len = iter_2_3.length
		}

		var_0_1.fish_infos[iter_2_3.id] = var_2_0
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.request_info) do
		table.insert(var_0_1.request_infos, iter_2_5)
	end

	var_0_1.received_award_list = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.received_award_list) do
		table.insert(var_0_1.received_award_list, iter_2_7)
	end

	var_0_1.received_constitute_list = {}

	for iter_2_8, iter_2_9 in ipairs(arg_2_1.received_constitute_list) do
		table.insert(var_0_1.received_constitute_list, iter_2_9)
	end

	manager.notify:Invoke(RARE_FISH_CHANGE, 0)
end

function var_0_0.OnFishingResult(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	var_0_1.today_total_score = var_0_1.today_total_score + arg_3_1
	var_0_1.score = var_0_1.score + arg_3_1
	var_0_1.today_treasure_num = math.min(var_0_1.today_treasure_num + arg_3_3, GameSetting.activity_fishing_fish_max.value[1])

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		local var_3_0 = {
			id = iter_3_1.id,
			num = iter_3_1.num,
			len = iter_3_1.length
		}

		var_0_1.fish_infos[iter_3_1.id] = var_3_0
	end

	manager.notify:Invoke(RARE_FISH_CHANGE, 0)
end

function var_0_0.UpdateRequest(arg_4_0, arg_4_1)
	var_0_1.request_infos = arg_4_1

	manager.notify:Invoke(FISHING_REQUEST_CHANGE, {})
end

function var_0_0.OnReceiveInfoGet(arg_5_0, arg_5_1)
	var_0_2 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = {
			timestamp = iter_5_1.timestamp,
			giver_id = iter_5_1.giver_id,
			giver_icon = iter_5_1.giver_icon,
			giver_nick = iter_5_1.giver_nick,
			fish_id = iter_5_1.fish_id
		}

		table.insert(var_0_2, var_5_0)
	end

	manager.notify:Invoke(RECEIVE_FISH_CHANGE, {})
end

function var_0_0.OnFriendRequestFishInfoGet(arg_6_0, arg_6_1)
	var_0_3 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = {
			friendId = iter_6_1.id
		}
		local var_6_1 = {}

		for iter_6_2, iter_6_3 in ipairs(iter_6_1.need_list) do
			table.insert(var_6_1, iter_6_3)
		end

		var_6_0.fishList = var_6_1

		table.insert(var_0_3, var_6_0)
	end

	manager.notify:Invoke(FRIENDS_REQUEST_FISH_INFO_CHANGE, {})
end

function var_0_0.OnReceiveFriendsFish(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	for iter_7_0, iter_7_1 in ipairs(var_0_2) do
		if iter_7_1.giver_id == arg_7_1 and iter_7_1.timestamp == arg_7_2 then
			table.remove(var_0_2, iter_7_0)

			break
		end
	end

	manager.notify:Invoke(RECEIVE_FISH_CHANGE, {})

	for iter_7_2, iter_7_3 in ipairs(arg_7_3) do
		local var_7_0 = {
			id = iter_7_3.id,
			num = iter_7_3.num,
			len = iter_7_3.length
		}

		var_0_1.fish_infos[iter_7_3.id] = var_7_0
	end

	manager.notify:Invoke(RARE_FISH_CHANGE, 0)
end

function var_0_0.OnGiveComplete(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:RemoveFish(arg_8_2, arg_8_3)

	if not var_0_1.send_present_list[arg_8_1] then
		var_0_1.send_present_list[arg_8_1] = 1
	else
		var_0_1.send_present_list[arg_8_1] = var_0_1.send_present_list[arg_8_1] + 1
	end

	manager.notify:Invoke(FRIENDS_REQUEST_FISH_INFO_CHANGE, {})
end

function var_0_0.RemoveFish(arg_9_0, arg_9_1, arg_9_2)
	var_0_1.fish_infos[arg_9_1].num = var_0_1.fish_infos[arg_9_1].num - arg_9_2

	manager.notify:Invoke(RARE_FISH_CHANGE, arg_9_1)
end

function var_0_0.OnGetGroupReward(arg_10_0, arg_10_1)
	local var_10_0 = ActivitySummerFishGroupCfg[arg_10_1].group[1]

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		var_0_1.fish_infos[iter_10_1].num = var_0_1.fish_infos[iter_10_1].num - 1
	end

	table.insert(var_0_1.received_constitute_list, arg_10_1)
	manager.notify:Invoke(RARE_FISH_CHANGE, fishId)
	manager.notify:Invoke(FISHING_GROUP_REWARD_CHANGE, {})
end

function var_0_0.OnGetScoreReward(arg_11_0, arg_11_1)
	table.insert(var_0_1.received_award_list, arg_11_1)
	manager.notify:Invoke(FISHING_SCORE_REWARD_CHANGE, {})
end

function var_0_0.OnBuySuccess(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_2 = arg_12_2 or 1

	if var_0_1.fish_infos[arg_12_1] then
		var_0_1.fish_infos[arg_12_1].num = var_0_1.fish_infos[arg_12_1].num + arg_12_2
		var_0_1.fish_infos[arg_12_1].len = arg_12_3.length
	else
		local var_12_0 = {
			id = arg_12_1,
			num = arg_12_2,
			len = arg_12_3.length
		}

		var_0_1.fish_infos[arg_12_1] = var_12_0
	end

	manager.notify:Invoke(RARE_FISH_CHANGE, arg_12_1)
end

function var_0_0.GetActivityData(arg_13_0)
	return var_0_1
end

function var_0_0.GetFish(arg_14_0, arg_14_1)
	return var_0_1.fish_infos[arg_14_1]
end

function var_0_0.GetFishReceiveInfo(arg_15_0)
	return var_0_2
end

function var_0_0.GetFriendRequestFishInfo(arg_16_0)
	return var_0_3
end

function var_0_0.IsFriendGiveMax(arg_17_0, arg_17_1)
	if (var_0_1.send_present_list[arg_17_1] or 0) >= GameSetting.activity_fishing_present_max.value[1] then
		return true
	end

	return false
end

function var_0_0.GetRareLabel(arg_18_0, arg_18_1)
	if arg_18_1 == 1 then
		return "B"
	end

	if arg_18_1 == 2 then
		return "A"
	end

	if arg_18_1 == 3 then
		return "S"
	end
end

return var_0_0
