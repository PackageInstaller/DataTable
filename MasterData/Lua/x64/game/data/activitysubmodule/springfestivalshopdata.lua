local var_0_0 = singletonClass("SpringFestivalShopData")

function var_0_0:InitData(arg_1_1)
	self.pointActivityId_ = arg_1_1.activity_id
	self.totalPoint_ = arg_1_1.point
	self.receivedReward_ = arg_1_1.reward_list

	self:CheckHasReardNotReceive()
end

function var_0_0:CheckHasReardNotReceive()
	local var_2_0 = 0

	for iter_2_0 = 1, 8 do
		if self.totalPoint_ >= ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[self.pointActivityId_][iter_2_0]].need and not self:GetIsReceivedReward(ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[self.pointActivityId_][iter_2_0]].id) then
			var_2_0 = 1

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_SPRING_FESTIVAL_SHOP, var_2_0)
end

function var_0_0:RefreshData(arg_3_1)
	self.pointActivityId_ = arg_3_1.activity_id
	self.totalPoint_ = arg_3_1.point

	self:CheckHasReardNotReceive()
	manager.notify:Invoke(SPRING_FESTIVAL_SHOP_UPDATE)
end

function var_0_0:RefreshRewardData(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		table.insert(self.receivedReward_, iter_4_1)
	end

	manager.notify:Invoke(SPRING_FESTIVAL_SHOP_UPDATE)
	self:CheckHasReardNotReceive()
end

function var_0_0:GetPointActivityId()
	return self.pointActivityId_
end

function var_0_0:GetTotalPoint()
	return self.totalPoint_
end

function var_0_0:GetIsReceivedReward(arg_7_1)
	return table.indexof(self.receivedReward_, arg_7_1)
end

return var_0_0
