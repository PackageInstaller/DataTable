local var_0_0 = {}

manager.net:Bind(52025, function(arg_1_0)
	HeroRaceCollectData:InitData(arg_1_0)
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, function(arg_2_0)
	HeroRaceCollectData:NewHeroUnlock(arg_2_0)
end)

function var_0_0.ReceiveTaskReward(arg_3_0)
	local var_3_0 = {
		collect_info_list = arg_3_0
	}

	manager.net:SendWithLoadingNew(52022, var_3_0, 52023, var_0_0.OnGetRewardCallback)
end

function var_0_0.OnGetRewardCallback(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		local var_4_0 = mergeReward(arg_4_0.item_list)

		getReward(var_4_0)
		HeroRaceCollectData:SetTasksReceived(arg_4_1.collect_info_list)
		manager.notify:Invoke(RACE_COLLECT_REWARD_GET, arg_4_1.collect_info_list)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.ReceiveOneTaskReward(arg_5_0, arg_5_1)
	local var_5_0 = {
		{
			race_type = arg_5_0,
			cnt_list = {
				arg_5_1
			}
		}
	}

	var_0_0.ReceiveTaskReward(var_5_0)
end

function var_0_0.ReceiveAllTasksReward()
	local var_6_0 = HeroRaceCollectData:GetAllCanReceiveTasks()

	var_0_0.ReceiveTaskReward(var_6_0)
end

return var_0_0
