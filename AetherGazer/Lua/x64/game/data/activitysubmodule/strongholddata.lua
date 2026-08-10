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
	local var_2_0 = arg_2_1.activity_id
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.skill_list) do
		var_2_1[iter_2_1.id] = iter_2_1.level
	end

	local var_2_2 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.stronghold_manual) do
		var_2_2[iter_2_3.id] = iter_2_3.use_times
	end

	local var_2_3 = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.reward_id) do
		table.insert(var_2_3, iter_2_5)
	end

	local var_2_4 = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.exp_list) do
		var_2_4[iter_2_7.type] = iter_2_7.exp
	end

	var_0_1[var_2_0] = {
		increase_dir = var_2_1,
		atlas_dir = var_2_2,
		reward_list = var_2_3,
		exp_weekly_dir = var_2_4
	}
end

function var_0_0.InitStrongholdResultData(arg_3_0, arg_3_1)
	var_0_3 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.player_list) do
		local var_3_0 = tonumber(iter_3_1.user_id)

		var_0_3[var_3_0] = {}
		var_0_3[var_3_0].select_effect_num = iter_3_1.select_effect_num
	end

	local var_3_1 = arg_3_1.main_activity

	if var_0_1[var_3_1] then
		local var_3_2 = {}

		for iter_3_2, iter_3_3 in ipairs(arg_3_1.exp_list) do
			var_3_2[iter_3_3.type] = iter_3_3.exp
		end

		var_0_1[var_3_1].exp_weekly_dir = var_3_2
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
		local var_6_0 = var_0_1[arg_6_1].increase_dir

		var_6_0[arg_6_2] = (var_6_0[arg_6_2] or 0) + 1
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
		local var_8_1 = var_0_1[arg_8_1].increase_dir

		for iter_8_0, iter_8_1 in pairs(var_8_1) do
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
	local var_10_1 = arg_10_1.stronghold_info

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = iter_10_1.user_id
		local var_10_3 = {}

		for iter_10_2, iter_10_3 in ipairs(iter_10_1.skill_list) do
			local var_10_4 = iter_10_3.id
			local var_10_5 = iter_10_3.level

			table.insert(var_10_3, {
				id = var_10_4,
				level = var_10_5
			})
		end

		local var_10_6 = iter_10_1.skill_type_id

		var_10_0[var_10_2] = {
			increase_list = var_10_3,
			room_skill_type = var_10_6
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
		local var_11_1 = iter_11_1.room_skill_type

		if var_11_1 ~= 0 then
			if not var_11_0[var_11_1] then
				var_11_0[var_11_1] = 1
			else
				var_11_0[var_11_1] = var_11_0[var_11_1] + 1
			end
		end
	end

	return var_11_0
end

function var_0_0.GetSelfRoomSkillType(arg_12_0, arg_12_1)
	if not var_0_2 or arg_12_1 ~= var_0_2.room_id then
		return 0
	end

	local var_12_0 = PlayerData:GetPlayerInfo().userID

	return var_0_2.player_ext_list[var_12_0] and var_0_2.player_ext_list[var_12_0].room_skill_type or 0
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
	local var_14_2 = 1
	local var_14_3 = #var_14_1
	local var_14_4 = -1

	while var_14_2 <= var_14_3 do
		local var_14_5 = var_14_2 + math.floor((var_14_3 - var_14_2) / 2)

		if var_14_0 < ActivityStrongholdLevelCfg[var_14_1[var_14_5]].exp then
			var_14_3 = var_14_5 - 1
		else
			var_14_4 = var_14_5
			var_14_2 = var_14_5 + 1
		end
	end

	local var_14_6 = var_14_1[var_14_4]
	local var_14_7 = ActivityStrongholdLevelCfg[var_14_6]
	local var_14_8 = var_14_0 - var_14_7.exp

	return var_14_6, var_14_7.level, var_14_8, var_14_7.point
end

function var_0_0.GetStrongholdLevelAndIncreasePoint(arg_15_0, arg_15_1)
	local var_15_0 = 0

	for iter_15_0 = 1, 3 do
		local var_15_1, var_15_2, var_15_3, var_15_4 = arg_15_0:GetStrongholdLevel(iter_15_0)

		var_15_0 = var_15_0 + var_15_4
	end

	local var_15_5 = 0

	if var_0_1[arg_15_1] then
		local var_15_6 = var_0_1[arg_15_1].increase_dir

		for iter_15_1, iter_15_2 in pairs(var_15_6) do
			var_15_5 = var_15_5 + iter_15_2
		end
	end

	return var_15_5, var_15_0
end

function var_0_0.GetUsePoint(arg_16_0, arg_16_1)
	if not var_0_1[arg_16_1] then
		return 0
	end

	local var_16_0 = var_0_1[arg_16_1].increase_dir
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_2 = ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[iter_16_0]

		for iter_16_2, iter_16_3 in ipairs(var_16_2) do
			local var_16_3 = ActivityStrongholdIncreaseCfg[iter_16_3]

			if iter_16_1 >= var_16_3.skill_level then
				var_16_1 = var_16_1 + var_16_3.cost
			end
		end
	end

	return var_16_1
end

function var_0_0.GetRewardState(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = var_0_1[arg_17_1] and var_0_1[arg_17_1].reward_list or {}

	if table.indexof(var_17_0, arg_17_2) then
		return 2
	end

	local var_17_1 = ActivityStrongholdRewardCfg[arg_17_2]
	local var_17_2 = var_17_1.condition
	local var_17_3 = var_17_1.params[1]
	local var_17_4, var_17_5, var_17_6, var_17_7 = arg_17_0:GetStrongholdLevel(var_17_2)

	if var_17_3 <= var_17_5 then
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
	local var_20_0 = GameSetting["activity_stronghold_sequence_" .. arg_20_2]

	if var_20_0 then
		return var_20_0.value[1]
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
		if var_22_0[arg_22_2] then
			var_22_0[arg_22_2] = var_22_0[arg_22_2] + 1
		else
			var_22_0[arg_22_2] = 1
		end
	end
end

function var_0_0.GetRoomPlayerIncreaseRevive(arg_23_0, arg_23_1)
	local var_23_0 = PlayerData:GetPlayerInfo().userID
	local var_23_1 = arg_23_0:GetRoomPlayerIncreaseList(arg_23_1, var_23_0)
	local var_23_2 = 0

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		local var_23_3 = iter_23_1.id
		local var_23_4 = iter_23_1.level
		local var_23_5 = ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[var_23_3]

		for iter_23_2, iter_23_3 in ipairs(var_23_5) do
			local var_23_6 = ActivityStrongholdIncreaseCfg[iter_23_3]

			if var_23_4 == var_23_6.skill_level and var_23_6.effect_type == 2 then
				var_23_2 = var_23_2 + var_23_6.effect_params[1]
			end
		end
	end

	return var_23_2
end

function var_0_0.GetRoomAffixList(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:GetRoomSkillTypes(arg_24_1)
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		local var_24_2 = arg_24_0:GetSkillAffix(iter_24_0, iter_24_1)

		table.insert(var_24_1, var_24_2)
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_2) do
		local var_24_3 = BattleTools.GetAffixPlayerTargetByPos(iter_24_2)
		local var_24_4 = iter_24_3.playerID
		local var_24_5 = arg_24_0:GetRoomPlayerIncreaseList(arg_24_1, var_24_4)

		for iter_24_4, iter_24_5 in ipairs(var_24_5) do
			local var_24_6 = iter_24_5.id
			local var_24_7 = iter_24_5.level
			local var_24_8 = ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[var_24_6]

			for iter_24_6, iter_24_7 in ipairs(var_24_8) do
				local var_24_9 = ActivityStrongholdIncreaseCfg[iter_24_7]

				if var_24_7 == var_24_9.skill_level and var_24_9.effect_type == 1 then
					table.insert(var_24_1, {
						var_24_9.effect_params[1],
						var_24_9.effect_params[2],
						var_24_3
					})

					break
				end
			end
		end
	end

	return var_24_1
end

function var_0_0.GetSkillAffix(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = ActivityStrongholdBuffCfg.get_id_list_by_type[arg_25_1]

	for iter_25_0, iter_25_1 in ipairs(var_25_0 or {}) do
		local var_25_1 = ActivityStrongholdBuffCfg[iter_25_1]

		if arg_25_2 == var_25_1.equip_num then
			return var_25_1.affix
		end
	end

	return nil
end

function var_0_0.GetSkillLimitLv(arg_26_0)
	return 5
end

return var_0_0
