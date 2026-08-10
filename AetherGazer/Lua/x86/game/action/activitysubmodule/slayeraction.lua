local var_0_0 = {}

manager.net:Bind(11043, function(arg_1_0)
	SlayerData:InitSlayerData(arg_1_0)
	SlayerAction.UpdateRedPoint(arg_1_0.slayer.activity_id)
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_2_0)
	local var_2_0 = ActivityTools.GetActivityType(arg_2_0)

	if var_2_0 == ActivityTemplateConst.SLAYER then
		SlayerAction.UpdateRedPoint(arg_2_0)
	elseif var_2_0 == ActivityTemplateConst.SLAYER_REGION then
		local var_2_1 = ActivityTools.GetMainActivityId(arg_2_0)

		if var_2_1 ~= nil then
			SlayerAction.UpdateRedPoint(var_2_1)
		end
	end
end)

function var_0_0.QueryPointReward(arg_3_0, arg_3_1)
	manager.net:SendWithLoadingNew(11044, {
		activity_id = arg_3_0,
		point_reward_id = arg_3_1
	}, 11045, var_0_0.PointRewardCallBack)
end

function var_0_0.PointRewardCallBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		SlayerData:SetReceivedReward(arg_4_1.activity_id, arg_4_1.point_reward_id)

		local var_4_0 = arg_4_0.item_list

		getReward2(var_4_0)
		manager.notify:CallUpdateFunc(SLAYER_REWARD)
		SlayerAction.CheckSlayerRewardRedPoint(arg_4_1.activity_id)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.UpdateRedPoint(arg_5_0)
	if not ActivityData:GetActivityIsOpen(arg_5_0) then
		local var_5_0 = ActivityCfg[arg_5_0].sub_activity_list

		if #var_5_0 > 0 then
			for iter_5_0, iter_5_1 in ipairs(var_5_0) do
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLAYER_REGIONS_SELECT, iter_5_1), 0)
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLAYER_REGIONS_REWARD, iter_5_1), 0)
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLYAER_REWARD, arg_5_0), 0)

		return
	end

	SlayerAction.CheckSlayerRewardRedPoint(arg_5_0)
	SlayerAction.CheckSlayerRegionRedPoint(arg_5_0)
end

function var_0_0.CheckSlayerRegionRedPoint(arg_6_0)
	local var_6_0 = ActivityCfg[arg_6_0].sub_activity_list

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if not SlayerData:GetRead(iter_6_1) then
			if ActivityData:GetActivityIsOpen(iter_6_1) and SlayerData:GetPoint(arg_6_0, iter_6_1) == 0 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLAYER_REGIONS_SELECT, iter_6_1), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLAYER_REGIONS_SELECT, iter_6_1), 0)
			end
		end
	end
end

function var_0_0.CheckSlayerRewardRedPoint(arg_7_0)
	local var_7_0 = ActivityCfg[arg_7_0].sub_activity_list
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_2 = SlayerData:GetPoint(arg_7_0, iter_7_1)

		if var_7_2 > 0 then
			local var_7_3 = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[iter_7_1]
			local var_7_4 = 0

			for iter_7_2, iter_7_3 in ipairs(var_7_3) do
				if not SlayerData:GetReceivedReward(arg_7_0, iter_7_3) and var_7_2 >= ActivitySlayerPointRewardCfg[iter_7_3].need then
					var_7_1 = 1
					var_7_4 = 1

					break
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLAYER_REGIONS_REWARD, iter_7_1), var_7_4)
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLYAER_REWARD, arg_7_0), var_7_1)
end

function var_0_0.SetSlayerRead(arg_8_0)
	if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.SLAYER_REGIONS_SELECT, arg_8_0)) == 1 then
		SlayerData:SetRead(arg_8_0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLAYER_REGIONS_SELECT, arg_8_0), 0)
	end
end

function var_0_0.GetSlayerRewardState(arg_9_0, arg_9_1)
	local var_9_0 = SlayerData:GetPoint(arg_9_0, arg_9_1)

	if var_9_0 > 0 then
		local var_9_1 = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[arg_9_1]

		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			if not SlayerData:GetReceivedReward(arg_9_0, iter_9_1) and var_9_0 >= ActivitySlayerPointRewardCfg[iter_9_1].need then
				return true
			end
		end

		return false
	end

	return false
end

return var_0_0
