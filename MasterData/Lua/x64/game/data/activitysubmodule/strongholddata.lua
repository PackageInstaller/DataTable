local var_0_0 = singletonClass("StrongholdData")
local var_0_1 = {}
local var_0_2
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = nil
	var_0_3 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.skill_list) do
		var_2_0[iter_2_1.id] = iter_2_1.level
	end

	local var_2_1 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.stronghold_manual) do
		var_2_1[iter_2_3.id] = iter_2_3.use_times
	end

	local var_2_2 = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.reward_id) do
		table.insert(var_2_2, iter_2_5)
	end

	local var_2_3 = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.exp_list) do
		var_2_3[iter_2_7.type] = iter_2_7.exp
	end

	var_0_1[arg_2_1.activity_id] = {
		increase_dir = var_2_0,
		atlas_dir = var_2_1,
		reward_list = var_2_2,
		exp_weekly_dir = var_2_3
	}
end

function var_0_0.InitStrongholdResultData(arg_3_0, arg_3_1)
	var_0_3 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.player_list) do
		local var_3_0 = tonumber(iter_3_1.user_id)

		var_0_3[var_3_0] = {}
		var_0_3[var_3_0].select_effect_num = iter_3_1.select_effect_num
	end

	if var_0_1[arg_3_1.main_activity] then
		local var_3_1 = {}

		for iter_3_2, iter_3_3 in ipairs(arg_3_1.exp_list) do
			var_3_1[iter_3_3.type] = iter_3_3.exp
		end

		var_0_1[arg_3_1.main_activity].exp_weekly_dir = var_3_1
	end
end

function var_0_0.GetStrongholdResultData(arg_4_0, arg_4_1)
	return var_0_3[arg_4_1]
end

function var_0_0.GetStrongholdResultMaxEffectNum(arg_5_0)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in pairs(var_0_3) do
		var_5_0 = math.max(var_5_0, iter_5_1.select_effect_num)
	end

	return var_5_0
end

function var_0_0.UpgradeIncreaseLevel(arg_6_0, arg_6_1, arg_6_2)
	if var_0_1[arg_6_1] then
		var_0_1[arg_6_1].increase_dir[arg_6_2] = (var_0_1[arg_6_1].increase_dir[arg_6_2] or 0) + 1
	end
end

function var_0_0.GetIncreaseLevel(arg_7_0, arg_7_1, arg_7_2)
	if var_0_1[arg_7_1] then
		return var_0_1[arg_7_1].increase_dir[arg_7_2] or 0
	end

	return 0
end

function var_0_0.GetAllIncreaseLevel(arg_8_0, arg_8_1)
	if var_0_1[arg_8_1] then
		local var_8_0 = 0

		for iter_8_0, iter_8_1 in pairs(var_0_1[arg_8_1].increase_dir) do
			var_8_0 = var_8_0 + iter_8_1
		end

		return var_8_0
	end

	return 0
end

function var_0_0.ClearRoomExt(arg_9_0)
	var_0_2 = nil
end

function var_0_0.InitRoomExt(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.stronghold_info) do
		local var_10_1 = {}

		for iter_10_2, iter_10_3 in ipairs(iter_10_1.skill_list) do
			table.insert(var_10_1, {
				id = iter_10_3.id,
				level = iter_10_3.level
			})
		end

		var_10_0[iter_10_1.user_id] = {
			increase_list = var_10_1,
			room_skill_type = iter_10_1.skill_type_id
		}
	end

	var_0_2 = {}
	var_0_2.room_id = arg_10_1.room_id
	var_0_2.player_ext_list = var_10_0
end

function var_0_0.GetRoomSkillTypes(arg_11_0, arg_11_1)
	if not var_0_2 or arg_11_1 ~= var_0_2.room_id then
		return {}
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(var_0_2.player_ext_list) do
		if iter_11_1.room_skill_type ~= 0 then
			var_11_0[iter_11_1.room_skill_type] = not var_11_0[iter_11_1.room_skill_type] and 1 or var_11_0[iter_11_1.room_skill_type] + 1
		end
	end

	return var_11_0
end

function var_0_0.GetSelfRoomSkillType(arg_12_0, arg_12_1)
	if not var_0_2 or arg_12_1 ~= var_0_2.room_id then
		return 0
	end

	local var_12_0 = PlayerData:GetPlayerInfo().userID

	return (var_0_2.player_ext_list[var_12_0] or nil) and (var_0_2.player_ext_list[var_12_0].room_skill_type or 0)
end

function var_0_0.GetRoomPlayerIncreaseList(arg_13_0, arg_13_1, arg_13_2)
	if not var_0_2 or arg_13_1 ~= var_0_2.room_id then
		return {}
	end

	return var_0_2.player_ext_list[arg_13_2].increase_list
end

function var_0_0.GetStrongholdLevel(arg_14_0, arg_14_1)
	local var_14_0 = 0

	if arg_14_1 == 1 then
		var_14_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_1)
	elseif arg_14_1 == 2 then
		var_14_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_2)
	elseif arg_14_1 == 3 then
		var_14_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_3)
	end

	local var_14_1 = ActivityStrongholdLevelCfg.get_id_list_by_type[arg_14_1]
	local var_14_2 = -1

	while 1 <= #ActivityStrongholdLevelCfg.get_id_list_by_type[arg_14_1] do
		local var_14_3 = 1 + math.floor((#ActivityStrongholdLevelCfg.get_id_list_by_type[arg_14_1] - 1) / 2)
		local var_14_4, var_14_5

		if var_14_0 < ActivityStrongholdLevelCfg[var_14_1[var_14_3]].exp then
			var_14_4 = var_14_3 - 1
		else
			var_14_2 = var_14_3
			var_14_5 = var_14_3 + 1
		end
	end

	return var_14_1[var_14_2], ActivityStrongholdLevelCfg[var_14_1[var_14_2]].level, var_14_0 - ActivityStrongholdLevelCfg[var_14_1[var_14_2]].exp, ActivityStrongholdLevelCfg[var_14_1[var_14_2]].point
end

function var_0_0:GetStrongholdLevelAndIncreasePoint(arg_15_1)
	local var_15_0 = 0

	for iter_15_0 = 1, 3 do
		local var_15_1, var_15_2, var_15_3, var_15_4 = self:GetStrongholdLevel(iter_15_0)

		var_15_0 = var_15_0 + var_15_4
	end

	local var_15_5 = 0

	if var_0_1[arg_15_1] then
		for iter_15_1, iter_15_2 in pairs(var_0_1[arg_15_1].increase_dir) do
			var_15_5 = var_15_5 + iter_15_2
		end
	end

	return var_15_5, var_15_0
end

function var_0_0.GetUsePoint(arg_16_0, arg_16_1)
	local var_16_0

	if not var_0_1[arg_16_1] then
		do return 0 end

		var_16_0 = 0
	end

	for iter_16_0, iter_16_1 in pairs(var_0_1[arg_16_1].increase_dir) do
		for iter_16_2, iter_16_3 in ipairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[iter_16_0]) do
			if iter_16_1 >= ActivityStrongholdIncreaseCfg[iter_16_3].skill_level then
				var_16_0 = var_16_0 + ActivityStrongholdIncreaseCfg[iter_16_3].cost
			end
		end
	end

	return var_16_0
end

function var_0_0:GetRewardState(arg_17_1, arg_17_2)
	if var_0_1[arg_17_1] then
		if table.indexof(var_0_1[arg_17_1].reward_list or {}, arg_17_2) then
			return 2
		end
	end

	local var_17_1 = ActivityStrongholdRewardCfg[arg_17_2].params[1]
	local var_17_2, var_17_3, var_17_4, var_17_5 = self:GetStrongholdLevel(ActivityStrongholdRewardCfg[arg_17_2].condition)

	if var_17_1 <= var_17_3 then
		return 0
	else
		return 1
	end
end

function var_0_0.UpdateReward(arg_18_0, arg_18_1, arg_18_2)
	if var_0_1[arg_18_1] then
		for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
			table.insert(var_0_1[arg_18_1].reward_list, iter_18_1)
		end
	end
end

function var_0_0.GetWeeklyExp(arg_19_0, arg_19_1, arg_19_2)
	if var_0_1[arg_19_1] then
		return var_0_1[arg_19_1].exp_weekly_dir[arg_19_2] or 0
	else
		return 0
	end
end

function var_0_0.GetWeeklyMaxExp(arg_20_0, arg_20_1, arg_20_2)
	if GameSetting["activity_stronghold_sequence_" .. arg_20_2] then
		return GameSetting["activity_stronghold_sequence_" .. arg_20_2].value[1]
	else
		return 1000
	end
end

function var_0_0.GetAtlasUseCount(arg_21_0, arg_21_1, arg_21_2)
	if var_0_1[arg_21_1] then
		return var_0_1[arg_21_1].atlas_dir[arg_21_2] or 0
	end

	return 0
end

function var_0_0.UpgradeAltas(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = var_0_1[arg_22_1] and var_0_1[arg_22_1].atlas_dir

	if var_22_0 then
		var_22_0[arg_22_2] = var_22_0[arg_22_2] and var_22_0[arg_22_2] + 1 or 1
	end
end

function var_0_0:GetRoomPlayerIncreaseRevive(arg_23_1)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in ipairs((self:GetRoomPlayerIncreaseList(arg_23_1, PlayerData:GetPlayerInfo().userID))) do
		for iter_23_2, iter_23_3 in ipairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[iter_23_1.id]) do
			if iter_23_1.level == ActivityStrongholdIncreaseCfg[iter_23_3].skill_level and ActivityStrongholdIncreaseCfg[iter_23_3].effect_type == 2 then
				var_23_0 = var_23_0 + ActivityStrongholdIncreaseCfg[iter_23_3].effect_params[1]
			end
		end
	end

	return var_23_0
end

function var_0_0:GetRoomAffixList(arg_24_1, arg_24_2)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs((self:GetRoomSkillTypes(arg_24_1))) do
		table.insert(var_24_0, (self:GetSkillAffix(iter_24_0, iter_24_1)))
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_2) do
		local var_24_1 = BattleTools.GetAffixPlayerTargetByPos(iter_24_2)

		for iter_24_4, iter_24_5 in ipairs((self:GetRoomPlayerIncreaseList(arg_24_1, iter_24_3.playerID))) do
			for iter_24_6, iter_24_7 in ipairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[iter_24_5.id]) do
				if iter_24_5.level == ActivityStrongholdIncreaseCfg[iter_24_7].skill_level and ActivityStrongholdIncreaseCfg[iter_24_7].effect_type == 1 then
					table.insert(var_24_0, {
						ActivityStrongholdIncreaseCfg[iter_24_7].effect_params[1],
						ActivityStrongholdIncreaseCfg[iter_24_7].effect_params[2],
						var_24_1
					})

					break
				end
			end
		end
	end

	return var_24_0
end

function var_0_0.GetSkillAffix(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in ipairs(ActivityStrongholdBuffCfg.get_id_list_by_type[arg_25_1] or {}) do
		if arg_25_2 == ActivityStrongholdBuffCfg[iter_25_1].equip_num then
			return ActivityStrongholdBuffCfg[iter_25_1].affix
		end
	end

	return nil
end

function var_0_0.GetSkillLimitLv(arg_26_0)
	return 5
end

return var_0_0
