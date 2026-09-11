local var_0_0 = singletonClass("ActivityWorldBossData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0.InitWorldBossData(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.got_total_damage_reward_list) do
		table.insert(var_2_0, iter_2_1)
	end

	local var_2_1 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.clear_index_list) do
		table.insert(var_2_1, iter_2_3)
	end

	var_0_1[arg_2_1.activity_id] = {
		activity_id = arg_2_1.activity_id,
		left_health_point = arg_2_1.left_health_point,
		affix = {
			arg_2_1.affix.id,
			arg_2_1.affix.level,
			arg_2_1.affix.object
		},
		got_total_damage_reward_list = var_2_0,
		got_coin_num = arg_2_1.got_coin_num,
		clear_index_list = var_2_1
	}
end

function var_0_0.InitWorldBossSocre(arg_3_0, arg_3_1)
	var_0_2[arg_3_1.activity_id] = arg_3_1.score
end

function var_0_0.GetHealthRewardState(arg_4_0, arg_4_1, arg_4_2)
	if not var_0_1[arg_4_1] then
		return 0
	end

	if table.indexof(var_0_1[arg_4_1].got_total_damage_reward_list, arg_4_2) then
		return 2
	end

	if ActivityWorldBossCfg[arg_4_1].health_reward_list[arg_4_2][1] >= var_0_1[arg_4_1].left_health_point then
		return 1
	end

	return 0
end

function var_0_0.SetHealthRewarded(arg_5_0, arg_5_1, arg_5_2)
	if not var_0_1[arg_5_1] then
		return
	end

	table.insert(var_0_1[arg_5_1].got_total_damage_reward_list, arg_5_2)
end

function var_0_0.GetMaxCoinNum(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(ActivityCfg[arg_6_1].sub_activity_list) do
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
	if not var_0_1[arg_11_1] then
		return 0
	end

	local var_11_0 = ActivityWorldBossCfg[arg_11_1]
	local var_11_1

	for iter_11_0, iter_11_1 in ipairs(ActivityWorldBossCfg[arg_11_1].health_stage) do
		if var_0_1[arg_11_1].left_health_point <= iter_11_1[1] and (not var_11_1 or iter_11_1[1] < var_11_1[1]) then
			var_11_1 = iter_11_1
		end
	end

	if nil == 1 then
		if not table.indexof(var_0_1[arg_11_1].clear_index_list, nil) then
			return var_11_0.story_stage_id[1] or var_11_1[2]
		else
			return var_11_1[2]
		end
	else
		local var_11_4 = table.indexof(var_0_1[arg_11_1].clear_index_list, 1)
		local var_11_5 = table.indexof(var_0_1[arg_11_1].clear_index_list, 2)

		if table.indexof(var_0_1[arg_11_1].clear_index_list, 3) then
			return var_11_1[2]
		elseif not var_11_4 and not var_11_5 then
			return var_11_0.story_stage_id[3] or var_11_1[2]
		elseif not var_11_5 then
			return var_11_0.story_stage_id[2] or var_11_1[2]
		else
			return var_11_1[2]
		end
	end
end

function var_0_0.GetBossScore(arg_12_0, arg_12_1)
	return var_0_2[arg_12_1] or 0
end

return var_0_0
