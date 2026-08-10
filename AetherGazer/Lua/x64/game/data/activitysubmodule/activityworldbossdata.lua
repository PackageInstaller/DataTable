local var_0_0 = singletonClass("ActivityWorldBossData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0.InitWorldBossData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id
	local var_2_1 = arg_2_1.affix
	local var_2_2 = {
		var_2_1.id,
		var_2_1.level,
		var_2_1.object
	}
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.got_total_damage_reward_list) do
		table.insert(var_2_3, iter_2_1)
	end

	local var_2_4 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.clear_index_list) do
		table.insert(var_2_4, iter_2_3)
	end

	var_0_1[var_2_0] = {
		activity_id = var_2_0,
		left_health_point = arg_2_1.left_health_point,
		affix = var_2_2,
		got_total_damage_reward_list = var_2_3,
		got_coin_num = arg_2_1.got_coin_num,
		clear_index_list = var_2_4
	}
end

function var_0_0.InitWorldBossSocre(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_id
	local var_3_1 = arg_3_1.score

	var_0_2[var_3_0] = var_3_1
end

function var_0_0.GetHealthRewardState(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_1[arg_4_1]

	if not var_4_0 then
		return 0
	end

	if table.indexof(var_4_0.got_total_damage_reward_list, arg_4_2) then
		return 2
	end

	if ActivityWorldBossCfg[arg_4_1].health_reward_list[arg_4_2][1] >= var_4_0.left_health_point then
		return 1
	end

	return 0
end

function var_0_0.SetHealthRewarded(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_1[arg_5_1]

	if not var_5_0 then
		return
	end

	table.insert(var_5_0.got_total_damage_reward_list, arg_5_2)
end

function var_0_0.GetMaxCoinNum(arg_6_0, arg_6_1)
	local var_6_0 = ActivityCfg[arg_6_1]

	for iter_6_0, iter_6_1 in ipairs(var_6_0.sub_activity_list) do
		if ActivityData:GetActivityIsOpen(iter_6_1) then
			return ActivityWorldBossPhaseCfg[iter_6_1].coin_limit
		end
	end

	return 0
end

function var_0_0.GetCointCount(arg_7_0, arg_7_1)
	if var_0_1[arg_7_1] then
		return var_0_1[arg_7_1].got_coin_num
	else
		return 0
	end
end

function var_0_0.UpdateCoinCount(arg_8_0, arg_8_1, arg_8_2)
	if var_0_1[arg_8_1] then
		var_0_1[arg_8_1].got_coin_num = var_0_1[arg_8_1].got_coin_num + arg_8_2
	end
end

function var_0_0.GetLeftHealthPoint(arg_9_0, arg_9_1)
	if var_0_1[arg_9_1] then
		return var_0_1[arg_9_1].left_health_point
	else
		return 0
	end
end

function var_0_0.GetAffix(arg_10_0, arg_10_1)
	if var_0_1[arg_10_1] then
		return var_0_1[arg_10_1].affix
	else
		return nil
	end
end

function var_0_0.GetStageId(arg_11_0, arg_11_1)
	local var_11_0 = var_0_1[arg_11_1]

	if not var_11_0 then
		return 0
	end

	local var_11_1 = ActivityWorldBossCfg[arg_11_1]
	local var_11_2 = var_11_0.left_health_point
	local var_11_3 = var_11_0.clear_index_list
	local var_11_4
	local var_11_5

	for iter_11_0, iter_11_1 in ipairs(var_11_1.health_stage) do
		local var_11_6 = iter_11_1[1]

		if var_11_2 <= var_11_6 and (not var_11_4 or var_11_6 < var_11_4[1]) then
			var_11_4 = iter_11_1
			var_11_5 = iter_11_0
		end
	end

	local var_11_7 = var_11_4[2]

	if var_11_5 == 1 then
		if not table.indexof(var_11_3, var_11_5) then
			return var_11_1.story_stage_id[1] or var_11_7
		else
			return var_11_7
		end
	else
		local var_11_8 = table.indexof(var_11_3, 1)
		local var_11_9 = table.indexof(var_11_3, 2)

		if table.indexof(var_11_3, 3) then
			return var_11_7
		elseif not var_11_8 and not var_11_9 then
			return var_11_1.story_stage_id[3] or var_11_7
		elseif not var_11_9 then
			return var_11_1.story_stage_id[2] or var_11_7
		else
			return var_11_7
		end
	end
end

function var_0_0.GetBossScore(arg_12_0, arg_12_1)
	return var_0_2[arg_12_1] or 0
end

return var_0_0
