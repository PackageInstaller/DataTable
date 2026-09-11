local var_0_0 = {}

manager.net:Bind(11103, function(arg_1_0)
	var_0_0.InitRedPointKey(arg_1_0)
	SpringFestivalShopData:InitData(arg_1_0)
end)
manager.net:Bind(11105, function(arg_2_0)
	SpringFestivalShopData:RefreshData(arg_2_0)
end)

function var_0_0:InitRedPointKey()
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(self.activity_id) .. self.activity_id, {
		RedPointConst.ACTIVITY_SPRING_FESTIVAL_SHOP
	})
end

function var_0_0.ReceivePointReward(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}

	table.insert(var_4_0, {
		reward_id = arg_4_0,
		index_list = {
			arg_4_1
		}
	})
	manager.net:SendWithLoadingNew(60056, {
		reward_list = var_4_0
	}, 60057, var_0_0.OnReceivePointReward)
end

function var_0_0:OnReceivePointReward(arg_5_1)
	if isSuccess(self.result) then
		getReward2(mergeReward2(self.reward_list))
		manager.notify:CallUpdateFunc(ON_CHOOSE_SPRING_FESTIVAL_FESITEM, self, arg_5_1)
		SpringFestivalShopData:RefreshRewardData({
			arg_5_1.reward_list[1].reward_id
		})
	else
		ShowTips(self.result)
	end
end

return var_0_0
