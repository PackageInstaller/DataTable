local var_0_0 = singletonClass("SpShooGameData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityID = 0
	arg_1_0.activityData = {}
	arg_1_0.isInitRed = false
end

function var_0_0:InitData(arg_2_1)
	self.activityData[arg_2_1.activity_id] = self.activityData[arg_2_1.activity_id] or {}
	self.activityData[arg_2_1.activity_id] = {
		today_coin = arg_2_1.today_coin,
		today_chip = arg_2_1.today_chip
	}

	self:UpdateRedPoint(arg_2_1.activity_id)
end

function var_0_0:UpdateStage(arg_3_1, arg_3_2)
	if arg_3_1.activity_id then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2 or {}) do
			if iter_3_1.id == SpKaliConst.ItemConst.coinID1 then
				self.activityData[arg_3_1.activity_id].today_coin = self.activityData[arg_3_1.activity_id].today_coin + iter_3_1.num
			elseif iter_3_1.id == SpKaliConst.ItemConst.coinID2 then
				self.activityData[arg_3_1.activity_id].today_chip = self.activityData[arg_3_1.activity_id].today_chip + iter_3_1.num
			end
		end
	end
end

function var_0_0:GetActivityData(arg_4_1)
	return self.activityData[arg_4_1]
end

function var_0_0:UpdateRedPoint(arg_5_1)
	if ActivityCfg.get_id_list_by_sub_activity_list[arg_5_1] then
		local var_5_1 = ActivityCfg.get_id_list_by_sub_activity_list[arg_5_1][1] or 0

		if var_5_1 ~= 0 then
			local var_5_2 = ActivityTools.GetRedPointKey(arg_5_1) .. arg_5_1
			local var_5_3, var_5_4 = SpKaliTool.GetShootReward1NowAndMax(arg_5_1)
			local var_5_5, var_5_6 = SpKaliTool.GetShootReward2NowAndMax(arg_5_1)

			if var_5_3 < var_5_4 and not ShopTools.CheckShopSoldOut(ShopConst.SHOP_ID.SP_KALI_CHALLENGE_1) then
				manager.redPoint:setTip(var_5_2, 1)
			else
				manager.redPoint:setTip(var_5_2, 0)
			end

			if not self.isInitRed then
				manager.redPoint:addGroup(ActivityTools.GetRedPointKey(var_5_1) .. var_5_1, {
					var_5_2
				})
			end
		end
	end

	self.isInitRed = true
end

return var_0_0
