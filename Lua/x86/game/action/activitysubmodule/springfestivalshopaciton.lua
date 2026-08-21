local var_0_0 = {}

manager.net:Bind(11103, function(arg_1_0)
	var_0_0.InitRedPointKey(arg_1_0)
	SpringFestivalShopData:InitData(arg_1_0)
end)
manager.net:Bind(11105, function(arg_2_0)
	SpringFestivalShopData:RefreshData(arg_2_0)
end)

function var_0_0.InitRedPointKey(arg_3_0)
	local var_3_0 = arg_3_0.activity_id
	local var_3_1 = ActivityTools.GetRedPointKey(var_3_0) .. var_3_0

	manager.redPoint:addGroup(var_3_1, {
		RedPointConst.ACTIVITY_SPRING_FESTIVAL_SHOP
	})
end

function var_0_0.ReceivePointReward(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		reward_id = arg_4_0,
		index_list = {
			arg_4_1
		}
	}
	local var_4_1 = {}

	table.insert(var_4_1, var_4_0)

	local var_4_2 = {
		reward_list = var_4_1
	}

	manager.net:SendWithLoadingNew(60056, var_4_2, 60057, var_0_0.OnReceivePointReward)
end

function var_0_0.OnReceivePointReward(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		getReward2(mergeReward2(arg_5_0.reward_list))
		manager.notify:CallUpdateFunc(ON_CHOOSE_SPRING_FESTIVAL_FESITEM, arg_5_0, arg_5_1)

		local var_5_0 = arg_5_1.reward_list[1].reward_id
		local var_5_1 = {
			var_5_0
		}

		SpringFestivalShopData:RefreshRewardData(var_5_1)
	else
		ShowTips(arg_5_0.result)
	end
end

return var_0_0
