local var_0_0 = singletonClass("SpringFestivalShopData")

function var_0_0.InitData(arg_1_0, arg_1_1)
	arg_1_0.pointActivityId_ = arg_1_1.activity_id
	arg_1_0.totalPoint_ = arg_1_1.point
	arg_1_0.receivedReward_ = arg_1_1.reward_list

	arg_1_0:CheckHasReardNotReceive()
end

function var_0_0.CheckHasReardNotReceive(arg_2_0)
	local var_2_0 = 0
	local var_2_1 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_2_0.pointActivityId_]

	for iter_2_0 = 1, 8 do
		local var_2_2 = ActivityPointRewardCfg[var_2_1[iter_2_0]]

		if arg_2_0.totalPoint_ >= var_2_2.need and not arg_2_0:GetIsReceivedReward(var_2_2.id) then
			var_2_0 = 1

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_SPRING_FESTIVAL_SHOP, var_2_0)
end

function var_0_0.RefreshData(arg_3_0, arg_3_1)
	arg_3_0.pointActivityId_ = arg_3_1.activity_id
	arg_3_0.totalPoint_ = arg_3_1.point

	arg_3_0:CheckHasReardNotReceive()
	manager.notify:Invoke(SPRING_FESTIVAL_SHOP_UPDATE)
end

function var_0_0.RefreshRewardData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		table.insert(arg_4_0.receivedReward_, iter_4_1)
	end

	manager.notify:Invoke(SPRING_FESTIVAL_SHOP_UPDATE)
	arg_4_0:CheckHasReardNotReceive()
end

function var_0_0.GetPointActivityId(arg_5_0)
	return arg_5_0.pointActivityId_
end

function var_0_0.GetTotalPoint(arg_6_0)
	return arg_6_0.totalPoint_
end

function var_0_0.GetIsReceivedReward(arg_7_0, arg_7_1)
	return table.indexof(arg_7_0.receivedReward_, arg_7_1)
end

return var_0_0
