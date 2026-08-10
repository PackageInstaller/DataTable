local var_0_0 = {}

manager.net:Bind(11065, function(arg_1_0)
	ParkourAction.UpdateCollect(arg_1_0)
	ParkourData:InitParkourCollectData(arg_1_0)
	ParkourAction.UpdateRedPoint(arg_1_0.activity_id)
end)
manager.net:Bind(11061, function(arg_2_0)
	ParkourData:InitParkourData(arg_2_0)
	ParkourAction.CheckEntrustRewardRedPoint(arg_2_0.activity_id)

	local var_2_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.PARKOUR] or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if not ParkourData:GetRead(iter_2_1) and table.indexof(ActivityCfg[iter_2_1].sub_activity_list, arg_2_0.activity_id) then
			ParkourAction.CheckPardourEntrustRedPoint(iter_2_1)
		end
	end
end)

function var_0_0.QueryParkourStarReward(arg_3_0, arg_3_1)
	manager.net:SendWithLoadingNew(11062, {
		activity_id = arg_3_0,
		treasure_id = arg_3_1
	}, 11063, var_0_0.OnParkourStarRewardCallBack)
end

function var_0_0.OnParkourStarRewardCallBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		local var_4_0 = arg_4_0.item_list

		getReward2(var_4_0)
		ParkourData:SetParkourEntrustReward(arg_4_1.activity_id, arg_4_1.treasure_id)
		ParkourAction.CheckEntrustRewardRedPoint(arg_4_1.activity_id)
		manager.notify:CallUpdateFunc(PARKOUR_REWARD)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.UpdateRedPoint(arg_5_0)
	ParkourAction.CheckPardourCollectRedPoint(arg_5_0)

	if not ParkourData:GetRead(arg_5_0) then
		ParkourAction.CheckPardourEntrustRedPoint(arg_5_0)
	end
end

function var_0_0.UpdateCollect(arg_6_0)
	local var_6_0 = arg_6_0.activity_id
	local var_6_1 = ParkourData:GetParkourCollectList()[var_6_0]

	if var_6_1 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.item_list) do
			local var_6_2 = {}

			if not table.indexof(var_6_1, iter_6_1) then
				table.insert(var_6_2, iter_6_1)
			end

			if #var_6_2 > 0 then
				local var_6_3 = ParkourData:GetCollectRedList(var_6_0)

				table.insertto(var_6_3, var_6_2)
				saveData("Parkour", tostring(var_6_0), var_6_3)
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, var_6_0), 1)
			end
		end
	end
end

function var_0_0.CheckPardourCollectRedPoint(arg_7_0)
	local var_7_0 = ActivityCfg[arg_7_0]

	if var_7_0 then
		local var_7_1 = ParkourData:GetCollectRedList(arg_7_0)
		local var_7_2 = var_7_0.sub_activity_list

		for iter_7_0, iter_7_1 in pairs(var_7_2) do
			local var_7_3 = ActivityParkourCfg[iter_7_1].specail_item

			if table.indexof(var_7_1, var_7_3) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, arg_7_0), 1)

				return
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, arg_7_0), 0)
end

function var_0_0.UpdateParkourRedPoint(arg_8_0, arg_8_1)
	local var_8_0 = ActivityCfg[arg_8_1].sub_activity_list

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		ParkourAction.CheckEntrustRewardRedPoint(iter_8_1)
	end
end

function var_0_0.CheckEntrustRewardRedPoint(arg_9_0)
	if not ActivityData:GetActivityIsOpen(arg_9_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, arg_9_0), 0)

		return
	end

	local var_9_0 = ParkourData:GetParkourEntrustData(arg_9_0)

	if var_9_0 then
		local var_9_1 = 4
		local var_9_2 = #var_9_0.stars

		if table.indexof(var_9_0.stars, var_9_1) then
			var_9_2 = var_9_2 - 1

			if not table.indexof(var_9_0.rewards, var_9_1) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, arg_9_0), 1)

				return
			end
		end

		for iter_9_0 = 1, var_9_2 do
			if not table.indexof(var_9_0.rewards, iter_9_0) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, arg_9_0), 1)

				return
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, arg_9_0), 0)
end

function var_0_0.CheckPardourEntrustRedPoint(arg_10_0)
	local var_10_0 = ActivityCfg[arg_10_0].sub_activity_list

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if ActivityData:GetActivityIsOpen(iter_10_1) and ParkourData:GetAllStarCount(iter_10_1) == 0 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST, arg_10_0), 1)

			return
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST, arg_10_0), 0)
end

function var_0_0.SetParkourRead(arg_11_0)
	if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST, arg_11_0)) == 1 then
		ParkourData:SetRead(arg_11_0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST, arg_11_0), 0)
	end
end

return var_0_0
