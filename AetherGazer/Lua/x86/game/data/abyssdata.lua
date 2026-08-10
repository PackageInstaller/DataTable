local var_0_0 = singletonClass("AbyssData")
local var_0_1
local var_0_2
local var_0_3

function var_0_0.Init(arg_1_0)
	var_0_1 = {
		refresh_timestamp = 0,
		layer_reset_time = 0,
		history_max_layer = 1,
		stage_reset_time = 0,
		is_back = false,
		activity_id = 142021,
		last_version_max_unlock_layer = 1,
		got_layer_reward_list = {},
		layer_info_dic = {}
	}
	var_0_2 = {}
	var_0_3 = 1
end

function var_0_0.InitFromServer(arg_2_0, arg_2_1)
	var_0_1 = {
		is_back = arg_2_1.is_back,
		history_max_layer = arg_2_1.history_max_layer,
		layer_reset_time = arg_2_1.layer_reset_time,
		stage_reset_time = arg_2_1.stage_reset_time,
		refresh_timestamp = arg_2_1.refresh_timestamp,
		last_version_max_unlock_layer = arg_2_1.last_version_max_unlock_layer,
		got_layer_reward_list = {},
		layer_info_dic = {},
		activity_id = arg_2_1.activity_id
	}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.got_layer_reward_list) do
		table.insert(var_0_1.got_layer_reward_list, iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.layer_info_list) do
		local var_2_0 = arg_2_0:DecodeServerLayerInfo(iter_2_3)

		var_0_1.layer_info_dic[iter_2_3.layer_id] = var_2_0
	end
end

function var_0_0.GetRefreshTimestamp(arg_3_0)
	return var_0_1.refresh_timestamp
end

function var_0_0.DecodeServerLayerInfo(arg_4_0, arg_4_1)
	local var_4_0 = {
		layer_id = arg_4_1.layer_id,
		stage_info_list = {},
		stage_info_dic = {},
		boss_stage_info_list = {},
		boss_stage_info_dic = {}
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.stage_info_list) do
		local var_4_1 = {
			stage_id = iter_4_1.stage_id,
			is_completed = iter_4_1.is_completed
		}

		table.insert(var_4_0.stage_info_list, var_4_1)

		var_4_0.stage_info_dic[iter_4_1.stage_id] = var_4_1
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.boss_stage_info_list) do
		local var_4_2 = {
			stage_id = iter_4_3.stage_id,
			is_completed = iter_4_3.is_completed,
			score = iter_4_3.score,
			phase = iter_4_3.phase,
			boss_hp_rate = iter_4_3.boss_hp_rate
		}

		table.insert(var_4_0.boss_stage_info_list, var_4_2)

		var_4_0.boss_stage_info_dic[iter_4_3.stage_id] = var_4_2
	end

	return var_4_0
end

function var_0_0.UpdateResetTime(arg_5_0, arg_5_1)
	var_0_1.layer_reset_time = arg_5_1.layer_reset_time
	var_0_1.stage_reset_time = arg_5_1.stage_reset_time
end

function var_0_0.UpdateBossInfo(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.boss_stage_info
	local var_6_1 = var_0_1.layer_info_dic[arg_6_1.layer].boss_stage_info_dic[var_6_0.stage_id]

	var_6_1.score = var_6_0.score
	var_6_1.phase = var_6_0.phase
	var_6_1.boss_hp_rate = var_6_0.boss_hp_rate
	var_6_1.is_completed = var_6_0.is_completed
end

function var_0_0.CompleteNormalStage(arg_7_0, arg_7_1, arg_7_2)
	var_0_1.layer_info_dic[arg_7_1].stage_info_dic[arg_7_2].is_completed = true
end

function var_0_0.UpdateLayerUnlock(arg_8_0, arg_8_1)
	var_0_1.history_max_layer = arg_8_1.history_max_layer

	local var_8_0 = arg_8_0:DecodeServerLayerInfo(arg_8_1.layer_info)

	var_0_1.layer_info_dic[var_8_0.layer_id] = var_8_0
end

function var_0_0.GetStageData(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = var_0_1.layer_info_dic[arg_9_1]

	if not var_9_0 then
		return nil
	end

	local var_9_1 = AbyssData:GetAbyssCfg(arg_9_1).stage_list[arg_9_2]

	if var_9_1[1] == 3 then
		if var_9_0.boss_stage_info_dic[var_9_1[2]] ~= nil then
			return var_9_0.boss_stage_info_dic[var_9_1[2]]
		end
	elseif var_9_0.stage_info_dic[var_9_1[2]] ~= nil then
		return var_9_0.stage_info_dic[var_9_1[2]]
	end

	return nil
end

function var_0_0.IsLayerBonusGet(arg_10_0, arg_10_1)
	if table.indexof(var_0_1.got_layer_reward_list, arg_10_1) then
		return true
	end

	return false
end

function var_0_0.IsLayerComplete(arg_11_0, arg_11_1)
	local var_11_0 = var_0_1.layer_info_dic[arg_11_1]

	if not var_11_0 then
		return false
	end

	local var_11_1 = AbyssData:GetAbyssCfg(arg_11_1).stage_list
	local var_11_2 = 0
	local var_11_3 = var_11_0.stage_info_list or {}

	for iter_11_0, iter_11_1 in pairs(var_11_3) do
		if iter_11_1.is_completed then
			var_11_2 = var_11_2 + 1
		end
	end

	local var_11_4 = var_11_0.boss_stage_info_list or {}

	for iter_11_2, iter_11_3 in pairs(var_11_4) do
		if iter_11_3.is_completed then
			var_11_2 = var_11_2 + 1
		end
	end

	return var_11_2 >= #var_11_1
end

function var_0_0.GetFirstLockLayer(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(AbyssData:GetCurrentIdList()) do
		local var_12_0 = AbyssCfg[iter_12_1].level

		if not arg_12_0:IsLayerUnlock(var_12_0) then
			return var_12_0
		end
	end

	return 1
end

function var_0_0.IsLayerChallenging(arg_13_0, arg_13_1)
	local var_13_0 = var_0_1.layer_info_dic[arg_13_1]

	if not var_13_0 then
		return false
	end

	local var_13_1 = var_13_0.stage_info_list or {}

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if iter_13_1.is_completed then
			return true
		end
	end

	local var_13_2 = var_13_0.boss_stage_info_list or {}

	for iter_13_2, iter_13_3 in ipairs(var_13_2) do
		if iter_13_3.is_completed then
			return true
		else
			return #AbyssTools.GetStageBanHeroList(arg_13_1, arg_13_0:GetStageIndex(arg_13_1, iter_13_3.stage_id)) > 0
		end
	end

	return false
end

function var_0_0.IsLayerUnlock(arg_14_0, arg_14_1)
	if arg_14_1 == 1 then
		return true
	end

	if var_0_1.last_version_max_unlock_layer > 1 and arg_14_1 <= var_0_1.last_version_max_unlock_layer then
		return true
	end

	if var_0_1.layer_info_dic[arg_14_1] ~= nil then
		return true
	end

	return false
end

function var_0_0.GetLayerStatus(arg_15_0, arg_15_1)
	if arg_15_0:IsLayerComplete(arg_15_1) then
		return 3
	end

	if arg_15_0:IsLayerChallenging(arg_15_1) then
		return 2
	end

	if arg_15_0:IsLayerUnlock(arg_15_1) then
		return 1
	end

	return 0
end

function var_0_0.GetStageScore(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = var_0_1.layer_info_dic[arg_16_1]

	if not var_16_0 then
		return 0
	end

	local var_16_1 = AbyssData:GetAbyssCfg(arg_16_1).stage_list[arg_16_2]
	local var_16_2 = var_16_1[2]

	if var_16_1[1] == 3 then
		local var_16_3 = var_16_0.boss_stage_info_dic[var_16_2]

		if not var_16_3 then
			return 0
		end

		return var_16_3.score or 0
	else
		local var_16_4 = var_16_0.stage_info_dic[var_16_2]

		if not var_16_4 then
			return 0
		end

		local var_16_5

		if var_16_4.is_completed then
			var_16_5 = var_16_1[3]
		else
			var_16_5 = 0
		end

		return var_16_5
	end
end

function var_0_0.GetLayerScore(arg_17_0, arg_17_1)
	local var_17_0 = AbyssData:GetAbyssCfg(arg_17_1)
	local var_17_1 = 0

	for iter_17_0, iter_17_1 in ipairs(var_17_0.stage_list) do
		var_17_1 = var_17_1 + arg_17_0:GetStageScore(arg_17_1, iter_17_0)
	end

	return var_17_1
end

function var_0_0.GetCurrentLayer(arg_18_0)
	for iter_18_0 = #AbyssData:GetCurrentIdList(), 1, -1 do
		local var_18_0 = AbyssData:GetCurrentIdList()[iter_18_0]
		local var_18_1 = AbyssCfg[var_18_0].level

		if arg_18_0:IsLayerUnlock(var_18_1) then
			return var_18_1
		end
	end

	return 1
end

function var_0_0.GetLayerResetTime(arg_19_0)
	return var_0_1.layer_reset_time
end

function var_0_0.GetLayerResetLimit(arg_20_0)
	return GameSetting.abyss_layer_reset_time.value[1]
end

function var_0_0.GetStageResetTime(arg_21_0)
	return var_0_1.stage_reset_time
end

function var_0_0.GetStageResetLimit(arg_22_0)
	return GameSetting.abyss_stage_reset_time.value[1]
end

function var_0_0.GetAbyssUnlockLevel(arg_23_0)
	return GameSetting.abyss_unlock_level.value[1]
end

function var_0_0.IsHeroInAbandonList(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = table.indexof(arg_24_2, arg_24_1)

	if var_24_0 then
		return arg_24_2[var_24_0]
	end

	return 0
end

function var_0_0.IsHeroInLockList(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = table.indexof(arg_25_2, arg_25_1)

	if var_25_0 then
		return arg_25_2[var_25_0]
	end

	return 0
end

function var_0_0.GetCanFightHeroList(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = HeroData:GetHeroList()

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		if iter_26_1.unlock == 1 then
			table.insert(var_26_0, iter_26_1.id)
		end
	end

	return var_26_0
end

function var_0_0.SetHeroTeam(arg_27_0, arg_27_1, arg_27_2)
	var_0_2[arg_27_1] = arg_27_2
end

function var_0_0.GetCachedHero(arg_28_0, arg_28_1)
	local var_28_0 = var_0_2[arg_28_1] or {}

	return {
		var_28_0[1] or 0,
		var_28_0[2] or 0,
		var_28_0[3] or 0
	}
end

function var_0_0.GetMaxLayer(arg_29_0)
	return var_0_1.history_max_layer
end

function var_0_0.GetCanGetLayers(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(AbyssData:GetCurrentIdList()) do
		local var_30_1 = AbyssCfg[iter_30_1].level

		if arg_30_0:GetBonusStatus(var_30_1) == 1 then
			table.insert(var_30_0, var_30_1)
		end
	end

	return var_30_0
end

function var_0_0.GetBonusStatus(arg_31_0, arg_31_1)
	if arg_31_0:IsLayerBonusGet(arg_31_1) then
		return 3
	elseif arg_31_1 <= arg_31_0:GetMaxLayer() then
		return 1
	else
		return 2
	end
end

function var_0_0.OnLayerBonusGet(arg_32_0, arg_32_1)
	table.insertto(var_0_1.got_layer_reward_list, arg_32_1)
	manager.notify:Invoke(ABYSS_LAYER_BONUS_GET, arg_32_1)
end

function var_0_0.HaveGetBonusNum(arg_33_0)
	return #var_0_1.got_layer_reward_list
end

function var_0_0.OnResetStage(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	var_0_1.stage_reset_time = var_0_1.stage_reset_time - 1

	arg_34_0:ResetStageInfo(arg_34_1, arg_34_2)
	arg_34_0:RemoveLayerAbove(arg_34_1)
	manager.notify:Invoke(ABYSS_STAGE_RESET_TIME_UPDATE, arg_34_1, arg_34_3)
end

function var_0_0.OnResetLayer(arg_35_0, arg_35_1)
	var_0_1.layer_reset_time = var_0_1.layer_reset_time - 1

	local var_35_0 = AbyssData:GetAbyssCfg(arg_35_1)

	for iter_35_0, iter_35_1 in ipairs(var_35_0.stage_list) do
		arg_35_0:ResetStageInfo(arg_35_1, iter_35_0)
		arg_35_0:ClearTeamCache(iter_35_1[2])
	end

	arg_35_0:RemoveLayerAbove(arg_35_1)
	manager.notify:Invoke(ABYSS_LAYER_RESET_TIME_UPDATE, arg_35_1)
end

function var_0_0.RemoveLayerAbove(arg_36_0, arg_36_1)
	local var_36_0 = AbyssData:GetCurrentIdList()

	for iter_36_0 = #var_36_0, 1, -1 do
		local var_36_1 = var_36_0[iter_36_0]
		local var_36_2 = AbyssCfg[var_36_1].level

		if arg_36_1 < var_36_2 and var_36_2 > var_0_1.last_version_max_unlock_layer then
			var_0_1.layer_info_dic[var_36_2] = nil
		end
	end
end

function var_0_0.ResetStageInfo(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = var_0_1.layer_info_dic[arg_37_1]
	local var_37_1 = AbyssData:GetAbyssCfg(arg_37_1).stage_list[arg_37_2]
	local var_37_2 = var_37_1[2]

	if var_37_1[1] == 3 then
		local var_37_3 = var_37_0.boss_stage_info_dic[var_37_2]

		var_37_3.score = 0
		var_37_3.is_completed = false
		var_37_3.phase = 1
		var_37_3.boss_hp_rate = 1000
	else
		var_37_0.stage_info_dic[var_37_2].is_completed = false
	end
end

function var_0_0.ClearTeamCache(arg_38_0, arg_38_1)
	var_0_2[arg_38_1] = nil
end

function var_0_0.SetCurrentBossPhase(arg_39_0, arg_39_1)
	var_0_3 = arg_39_1
end

function var_0_0.GetCurrentBossPhase(arg_40_0)
	return var_0_3 or 1
end

function var_0_0.GetBossTotalHp(arg_41_0, arg_41_1)
	local var_41_0 = AbyssBossHpCfg[arg_41_1]

	if not var_41_0 then
		return 1
	end

	local var_41_1 = 0

	for iter_41_0, iter_41_1 in ipairs(var_41_0.boss_hp) do
		var_41_1 = var_41_1 + iter_41_1
	end

	return var_41_1
end

function var_0_0.GetPhaseBossHp(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = AbyssBossHpCfg[arg_42_1]

	if not var_42_0 then
		return 1
	end

	return var_42_0.boss_hp[arg_42_2] or 1
end

function var_0_0.ConvertPhaseBossHpToTotal(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = arg_43_0:GetPhaseBossHp(arg_43_1, arg_43_2) * arg_43_3 / 1000

	if arg_43_2 ~= #AbyssBossHpCfg[arg_43_1].boss_hp then
		for iter_43_0 = arg_43_2 + 1, #AbyssBossHpCfg[arg_43_1].boss_hp do
			var_43_0 = var_43_0 + AbyssBossHpCfg[arg_43_1].boss_hp[iter_43_0]
		end
	end

	return var_43_0
end

function var_0_0.OnReadBackFlag(arg_44_0)
	var_0_1.is_back = false
end

function var_0_0.NeedTipBack(arg_45_0)
	return var_0_1.is_back
end

function var_0_0.GetActivityId(arg_46_0)
	if not var_0_1.activity_id then
		var_0_1.activity_id = AbyssCfg[AbyssCfg.all[1]].activity_id
	end

	return var_0_1.activity_id
end

function var_0_0.GetAbyssCfg(arg_47_0, arg_47_1)
	if not var_0_1.activity_id then
		var_0_1.activity_id = AbyssCfg[AbyssCfg.all[1]].activity_id
	end

	local var_47_0 = AbyssCfg.get_id_list_by_activity_id[var_0_1.activity_id][arg_47_1]

	return AbyssCfg[var_47_0]
end

function var_0_0.GetStageIndex(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0:GetAbyssCfg(arg_48_1).stage_list

	for iter_48_0, iter_48_1 in ipairs(var_48_0) do
		if iter_48_1[2] == arg_48_2 then
			return iter_48_0
		end
	end

	return 1
end

function var_0_0.GetCurrentIdList(arg_49_0)
	if not var_0_1.activity_id then
		var_0_1.activity_id = AbyssCfg[AbyssCfg.all[1]].activity_id
	end

	return AbyssCfg.get_id_list_by_activity_id[var_0_1.activity_id]
end

function var_0_0.HaveUpperLevelChallenging(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in pairs(var_0_1.layer_info_dic) do
		if arg_50_1 < iter_50_0 and AbyssData:GetLayerStatus(iter_50_0) >= 2 then
			return true
		end
	end

	return false
end

return var_0_0
