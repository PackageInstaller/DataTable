local var_0_0 = singletonClass("ActivityPushBoxData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0.SetCakeData(arg_2_0, arg_2_1)
	var_0_1[arg_2_1.activity_id] = {
		activityID = arg_2_1.activity_id,
		cakeID = arg_2_1.cake_id,
		sign = arg_2_1.sign
	}
end

function var_0_0.SetActivityData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.finish_mission or {}

	var_0_2[arg_3_1.activity_id] = {
		activityID = arg_3_1.activity_id,
		fatigue = arg_3_1.value,
		hadRefresh = arg_3_1.refresh_times,
		battleList = arg_3_1.battle_order_list,
		pushBoxFinishList = var_3_0,
		pushBoxList = {},
		pushBoxLockList = {},
		emptyIndexList = {}
	}
end

function var_0_0:ReBuild(arg_4_1)
	if not var_0_2[arg_4_1] then
		return
	end

	local var_4_0 = var_0_2[arg_4_1].pushBoxFinishList or {}
	local var_4_1 = self:GetEmptyList(arg_4_1, var_4_0)
	local var_4_2, var_4_3 = self:GetReadyAndLockList(arg_4_1, var_4_0)

	var_0_2[arg_4_1].pushBoxList = var_4_2
	var_0_2[arg_4_1].pushBoxLockList = var_4_3
	var_0_2[arg_4_1].emptyIndexList = var_4_1
end

function var_0_0:GetEmptyList(arg_5_1, arg_5_2)
	local var_5_0 = self:GetIndexMap(arg_5_1)
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		var_5_1[iter_5_1] = true
	end

	local var_5_2 = {}

	for iter_5_2, iter_5_3 in ipairs(ActivityCelebrationOrderCfg.get_id_list_by_main_activity[arg_5_1]) do
		if ActivityCelebrationOrderCfg[iter_5_3].type == 2 and self:FindEndIndex(iter_5_3, var_5_1, var_5_0) then
			table.insert(var_5_2, iter_5_3)
		end
	end

	return var_5_2
end

function var_0_0.FindEndIndex(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_2[arg_6_1] then
		return false
	end

	local var_6_0 = arg_6_3[arg_6_1]

	if not arg_6_3[arg_6_1] then
		return true
	end

	if arg_6_2[var_6_0] then
		return false
	end

	if ActivityData:GetActivityData(ActivityCelebrationOrderCfg[var_6_0].activity_id):IsActivitying() then
		return false
	else
		return true
	end
end

function var_0_0.GetIndexMap(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(ActivityCelebrationOrderCfg.get_id_list_by_main_activity[arg_7_1]) do
		if ActivityCelebrationOrderCfg[iter_7_1].type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
			var_7_0[ActivityCelebrationOrderCfg[iter_7_1].pre_id] = iter_7_1
		end
	end

	return var_7_0
end

function var_0_0.GetReadyAndLockList(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
		var_8_2[iter_8_1] = true
	end

	for iter_8_2, iter_8_3 in ipairs(ActivityCelebrationOrderCfg.get_id_list_by_main_activity[arg_8_1]) do
		if ActivityCelebrationOrderCfg[iter_8_3].type == PushBoxConst.EVENT_TYPE.PUSH_BOX and not var_8_2[iter_8_3] then
			if ActivityData:GetActivityData(ActivityCelebrationOrderCfg[iter_8_3].activity_id):IsActivitying() then
				if var_8_2[ActivityCelebrationOrderCfg[iter_8_3].pre_id] or ActivityCelebrationOrderCfg[iter_8_3].pre_id == 0 then
					table.insert(var_8_0, iter_8_3)
				else
					table.insert(var_8_1, iter_8_3)
				end
			end
		end
	end

	return var_8_0, var_8_1
end

function var_0_0:FinishPushBox(arg_9_1, arg_9_2)
	table.insert(var_0_2[arg_9_1].pushBoxFinishList, arg_9_2)
	table.remove(var_0_2[arg_9_1].pushBoxList, table.indexof(var_0_2[arg_9_1].pushBoxList, arg_9_2))

	local var_9_1 = self:GetIndexMap(arg_9_1)[arg_9_2]

	if not var_9_1 then
		table.insert(var_0_2[arg_9_1].emptyIndexList, arg_9_2)
	elseif not ActivityData:GetActivityData(ActivityCelebrationOrderCfg[var_9_1].activity_id):IsActivitying() then
		table.insert(var_0_2[arg_9_1].emptyIndexList, arg_9_2)
	else
		table.insert(var_0_2[arg_9_1].pushBoxList, var_9_1)
	end
end

function var_0_0.GetCurIndex(arg_10_0, arg_10_1)
	if var_0_1[arg_10_1] then
		return (ActivityCelebrationCakeCfg[var_0_1[arg_10_1].cakeID] or nil) and (ActivityCelebrationCakeCfg[var_0_1[arg_10_1].cakeID].level or 0)
	end

	return 0
end

function var_0_0.GetFatigue(arg_11_0, arg_11_1)
	if var_0_2[arg_11_1] then
		return var_0_2[arg_11_1].fatigue
	end

	return 0
end

function var_0_0.ModifyFatigue(arg_12_0, arg_12_1, arg_12_2)
	if var_0_2[arg_12_1] then
		var_0_2[arg_12_1].fatigue = var_0_2[arg_12_1].fatigue + arg_12_2
	end
end

function var_0_0.GetMapEventList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	table.insertto(var_13_0, var_0_2[arg_13_1].battleList)
	table.insertto(var_13_0, var_0_2[arg_13_1].pushBoxList)

	return var_13_0
end

function var_0_0.GetPushBoxEmptyList(arg_14_0, arg_14_1)
	return var_0_2[arg_14_1].emptyIndexList
end

function var_0_0.GetFinishList(arg_15_0, arg_15_1)
	return var_0_2[arg_15_1].pushBoxFinishList
end

function var_0_0.GetRefreshTime(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(GameSetting.activity_push_box_refresh_time.value) do
		if iter_16_1[1] == arg_16_1 then
			return iter_16_1[2] - var_0_2[arg_16_1].hadRefresh
		end
	end
end

function var_0_0.IsHadMade(arg_17_0, arg_17_1)
	return var_0_1[arg_17_1] and var_0_1[arg_17_1].sign == 1 or false
end

function var_0_0.GetNextID(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(ActivityCelebrationOrderCfg.get_id_list_by_main_activity[arg_18_1]) do
		if ActivityCelebrationOrderCfg[iter_18_1].type == PushBoxConst.EVENT_TYPE.PUSH_BOX and ActivityCelebrationOrderCfg[iter_18_1].pre_id == arg_18_2 then
			return iter_18_1
		end
	end

	return 0
end

return var_0_0
