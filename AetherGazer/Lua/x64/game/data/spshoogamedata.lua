local var_0_0 = singletonClass("SpShooGameData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityID = 0
	arg_1_0.activityData = {}
	arg_1_0.isInitRed = false
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	if not arg_2_0.activityData[arg_2_1.activity_id] then
		arg_2_0.activityData[arg_2_1.activity_id] = {}
	end

	arg_2_0.activityData[arg_2_1.activity_id] = {
		today_coin = arg_2_1.today_coin,
		today_chip = arg_2_1.today_chip
	}

	arg_2_0:UpdateRedPoint(arg_2_1.activity_id)
end

function var_0_0.UpdateStage(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1.activity_id then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2 or {}) do
			if iter_3_1.id == SpKaliConst.ItemConst.coinID1 then
				arg_3_0.activityData[arg_3_1.activity_id].today_coin = arg_3_0.activityData[arg_3_1.activity_id].today_coin + iter_3_1.num
			elseif iter_3_1.id == SpKaliConst.ItemConst.coinID2 then
				arg_3_0.activityData[arg_3_1.activity_id].today_chip = arg_3_0.activityData[arg_3_1.activity_id].today_chip + iter_3_1.num
			end
		end
	end
end

function var_0_0.GetActivityData(arg_4_0, arg_4_1)
	return arg_4_0.activityData[arg_4_1]
end

function var_0_0.UpdateRedPoint(arg_5_0, arg_5_1)
	local var_5_0 = ActivityKaliGameStageCfg.all
	local var_5_1 = ActivityCfg.get_id_list_by_sub_activity_list[arg_5_1] and ActivityCfg.get_id_list_by_sub_activity_list[arg_5_1][1] or 0

	if var_5_1 ~= 0 then
		local var_5_2 = ActivityTools.GetRedPointKey(arg_5_1) .. arg_5_1
		local var_5_3, var_5_4 = SpKaliTool.GetShootReward1NowAndMax(arg_5_1)
		local var_5_5, var_5_6 = SpKaliTool.GetShootReward2NowAndMax(arg_5_1)
		local var_5_7 = ShopTools.CheckShopSoldOut(ShopConst.SHOP_ID.SP_KALI_CHALLENGE_1)

		if var_5_3 < var_5_4 and not var_5_7 then
			manager.redPoint:setTip(var_5_2, 1)
		else
			manager.redPoint:setTip(var_5_2, 0)
		end

		local var_5_8 = ActivityTools.GetRedPointKey(var_5_1) .. var_5_1

		if not arg_5_0.isInitRed then
			manager.redPoint:addGroup(var_5_8, {
				var_5_2
			})
		end
	end

	arg_5_0.isInitRed = true
end

return var_0_0
