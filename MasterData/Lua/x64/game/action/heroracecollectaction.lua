local var_0_0 = {}

manager.net:Bind(52025, function(arg_1_0)
	HeroRaceCollectData:InitData(arg_1_0)
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, function(arg_2_0)
	HeroRaceCollectData:NewHeroUnlock(arg_2_0)
end)

function var_0_0.ReceiveTaskReward(arg_3_0)
	manager.net:SendWithLoadingNew(52022, {
		collect_info_list = arg_3_0
	}, 52023, var_0_0.OnGetRewardCallback)
end

function var_0_0:OnGetRewardCallback(arg_4_1)
	if isSuccess(self.result) then
		getReward((mergeReward(self.item_list)))
		HeroRaceCollectData:SetTasksReceived(arg_4_1.collect_info_list)
		manager.notify:Invoke(RACE_COLLECT_REWARD_GET, arg_4_1.collect_info_list)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ReceiveOneTaskReward(arg_5_0, arg_5_1)
	var_0_0.ReceiveTaskReward({
		{
			race_type = arg_5_0,
			cnt_list = {
				arg_5_1
			}
		}
	})
end

function var_0_0.ReceiveAllTasksReward()
	var_0_0.ReceiveTaskReward((HeroRaceCollectData:GetAllCanReceiveTasks()))
end

return var_0_0
