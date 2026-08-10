local var_0_0 = singletonClass("ActivityPushBoxData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0.SetCakeData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	var_0_1[var_2_0] = {
		activityID = var_2_0,
		cakeID = arg_2_1.cake_id,
		sign = arg_2_1.sign
	}
end

function var_0_0.SetActivityData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_id
	local var_3_1 = arg_3_1.finish_mission or {}

	var_0_2[var_3_0] = {
		activityID = var_3_0,
		fatigue = arg_3_1.value,
		hadRefresh = arg_3_1.refresh_times,
		battleList = arg_3_1.battle_order_list,
		pushBoxFinishList = var_3_1,
		pushBoxList = {},
		pushBoxLockList = {},
		emptyIndexList = {}
	}
end

function var_0_0.ReBuild(arg_4_0, arg_4_1)
	local var_4_0 = var_0_2[arg_4_1]

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0.pushBoxFinishList or {}
	local var_4_2 = arg_4_0:GetEmptyList(arg_4_1, var_4_1)
	local var_4_3, var_4_4 = arg_4_0:GetReadyAndLockList(arg_4_1, var_4_1)

	var_4_0.pushBoxList = var_4_3
	var_4_0.pushBoxLockList = var_4_4
	var_4_0.emptyIndexList = var_4_2
end

function var_0_0.GetEmptyList(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetIndexMap(arg_5_1)
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		var_5_1[iter_5_1] = true
	end

	local var_5_2 = ActivityCelebrationOrderCfg.get_id_list_by_main_activity[arg_5_1]
	local var_5_3 = {}

	for iter_5_2, iter_5_3 in ipairs(var_5_2) do
		if ActivityCelebrationOrderCfg[iter_5_3].type == 2 and arg_5_0:FindEndIndex(iter_5_3, var_5_1, var_5_0) then
			table.insert(var_5_3, iter_5_3)
		end
	end

	return var_5_3
end

function var_0_0.FindEndIndex(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_2[arg_6_1] then
		return false
	end

	local var_6_0 = arg_6_3[arg_6_1]

	if not var_6_0 then
		return true
	end

	if arg_6_2[var_6_0] then
		return false
	end

	local var_6_1 = ActivityCelebrationOrderCfg[var_6_0].activity_id

	if ActivityData:GetActivityData(var_6_1):IsActivitying() then
		return false
	else
		return true
	end
end

function var_0_0.GetIndexMap(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = ActivityCelebrationOrderCfg.get_id_list_by_main_activity[arg_7_1]

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = ActivityCelebrationOrderCfg[iter_7_1]

		if var_7_2.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
			var_7_0[var_7_2.pre_id] = iter_7_1
		end
	end

	return var_7_0
end

function var_0_0.GetReadyAndLockList(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ActivityCelebrationOrderCfg.get_id_list_by_main_activity[arg_8_1]
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
		local var_8_4 = ActivityCelebrationOrderCfg[iter_8_1]

		var_8_3[iter_8_1] = true
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		local var_8_5 = ActivityCelebrationOrderCfg[iter_8_3]

		if var_8_5.type == PushBoxConst.EVENT_TYPE.PUSH_BOX and not var_8_3[iter_8_3] then
			local var_8_6 = var_8_5.activity_id

			if ActivityData:GetActivityData(var_8_6):IsActivitying() then
				local var_8_7 = var_8_5.pre_id

				if var_8_3[var_8_7] or var_8_7 == 0 then
					table.insert(var_8_1, iter_8_3)
				else
					table.insert(var_8_2, iter_8_3)
				end
			end
		end
	end

	return var_8_1, var_8_2
end

function var_0_0.FinishPushBox(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = var_0_2[arg_9_1]
	local var_9_1 = var_9_0.pushBoxFinishList
	local var_9_2 = var_9_0.pushBoxLockList
	local var_9_3 = var_9_0.pushBoxList

	table.insert(var_9_1, arg_9_2)
	table.remove(var_9_3, table.indexof(var_9_3, arg_9_2))

	local var_9_4 = arg_9_0:GetIndexMap(arg_9_1)
	local var_9_5 = var_9_0.emptyIndexList
	local var_9_6 = var_9_4[arg_9_2]

	if not var_9_6 then
		table.insert(var_9_5, arg_9_2)
	else
		local var_9_7 = ActivityCelebrationOrderCfg[var_9_6].activity_id

		if not ActivityData:GetActivityData(var_9_7):IsActivitying() then
			table.insert(var_9_5, arg_9_2)
		else
			table.insert(var_9_3, var_9_6)
		end
	end
end

function var_0_0.GetCurIndex(arg_10_0, arg_10_1)
	if var_0_1[arg_10_1] then
		local var_10_0 = var_0_1[arg_10_1].cakeID
		local var_10_1 = ActivityCelebrationCakeCfg[var_10_0]

		return var_10_1 and var_10_1.level or 0
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
	local var_13_1 = var_0_2[arg_13_1].battleList
	local var_13_2 = var_0_2[arg_13_1].pushBoxList

	table.insertto(var_13_0, var_13_1)
	table.insertto(var_13_0, var_13_2)

	return var_13_0
end

function var_0_0.GetPushBoxEmptyList(arg_14_0, arg_14_1)
	return var_0_2[arg_14_1].emptyIndexList
end

function var_0_0.GetFinishList(arg_15_0, arg_15_1)
	return var_0_2[arg_15_1].pushBoxFinishList
end

function var_0_0.GetRefreshTime(arg_16_0, arg_16_1)
	local var_16_0 = GameSetting.activity_push_box_refresh_time.value

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1[1] == arg_16_1 then
			return iter_16_1[2] - var_0_2[arg_16_1].hadRefresh
		end
	end
end

function var_0_0.IsHadMade(arg_17_0, arg_17_1)
	return var_0_1[arg_17_1] and var_0_1[arg_17_1].sign == 1 or false
end

function var_0_0.GetNextID(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = ActivityCelebrationOrderCfg.get_id_list_by_main_activity[arg_18_1]

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_1 = ActivityCelebrationOrderCfg[iter_18_1]

		if var_18_1.type == PushBoxConst.EVENT_TYPE.PUSH_BOX and var_18_1.pre_id == arg_18_2 then
			return iter_18_1
		end
	end

	return 0
end

return var_0_0
