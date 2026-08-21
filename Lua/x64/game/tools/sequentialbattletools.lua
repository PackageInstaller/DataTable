local var_0_0 = {}

function var_0_0.GetConditionStatus(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		if iter_1_1[1] == 1 then
			table.insert(var_1_0, var_0_0.GetRaceConditionStatus(arg_1_0, iter_1_1[2]))
		elseif iter_1_1[1] == 2 then
			table.insert(var_1_0, var_0_0.GetMechanismConditionStatus(arg_1_0, iter_1_1[2]))
		elseif iter_1_1[1] == 3 then
			table.insert(var_1_0, var_0_0.GetAttackAttributeConditionStatus(arg_1_0, iter_1_1[2]))
		end
	end

	return var_1_0
end

function var_0_0.GetRaceConditionStatus(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		if iter_2_1 ~= 0 and HeroCfg[iter_2_1].race == arg_2_1 then
			var_2_0 = var_2_0 + 1
		end
	end

	return var_2_0
end

function var_0_0.GetMechanismConditionStatus(arg_3_0, arg_3_1)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		if iter_3_1 ~= 0 and table.keyof(HeroCfg[iter_3_1].mechanism_type, arg_3_1) then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0
end

function var_0_0.GetAttackAttributeConditionStatus(arg_4_0, arg_4_1)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		if iter_4_1 ~= 0 and table.keyof(HeroCfg[iter_4_1].ATK_attribute, arg_4_1) then
			var_4_0 = var_4_0 + 1
		end
	end

	return var_4_0
end

function var_0_0.ResetAllEnabledBuff(arg_5_0)
	for iter_5_0 = 1, 4 do
		var_0_0.SaveEnabledBuff(arg_5_0, iter_5_0)
	end
end

function var_0_0.SaveEnabledBuff(arg_6_0, arg_6_1)
	ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE):SaveEnabledBuff(arg_6_0, arg_6_1)
end

function var_0_0.GetEnabledBuff(arg_7_0, arg_7_1)
	return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE):GetContDataTemplateById(arg_7_0):GetAffixList(arg_7_1)
end

function var_0_0.GetRewardPanelList(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(SequentialBattleRewardCfg.get_id_list_by_main_activity_id[arg_8_0]) do
		local var_8_1 = SequentialBattleRewardCfg[iter_8_1].activity_id

		var_8_0[var_8_1] = clone(SequentialBattleRewardCfg.get_id_list_by_activity_id[var_8_1])
	end

	return var_8_0
end

function var_0_0.GetCanReceiveRewardList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = SequentialBattleData:GetReceiveRewardList(arg_9_0)

	for iter_9_0, iter_9_1 in ipairs(SequentialBattleRewardCfg.get_id_list_by_main_activity_id[arg_9_0]) do
		if not table.keyof(var_9_1, iter_9_1) and var_0_0.IsUnlockReward(iter_9_1) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0.GetFinishRewardCnt(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = SequentialBattleData:GetReceiveRewardList(arg_10_0)

	for iter_10_0, iter_10_1 in ipairs(SequentialBattleRewardCfg.get_id_list_by_main_activity_id[arg_10_0]) do
		if table.keyof(var_10_1, iter_10_1) then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

function var_0_0.IsUnlockReward(arg_11_0)
	local var_11_0 = SequentialBattleRewardCfg[arg_11_0]
	local var_11_1 = var_11_0.activity_id

	return table.length(SequentialBattleData:GetFinishStageList(var_11_1)) >= var_11_0.complete_num
end

function var_0_0.CheckHeroTeamList(arg_12_0)
	if var_0_0.HasAllHeroTeam(arg_12_0) then
		return
	end

	local var_12_0 = SequentialBattleChapterCfg[arg_12_0]
	local var_12_1 = var_12_0.main_id
	local var_12_2 = SequentialBattleChapterCfg.get_id_list_by_main_id[var_12_1]
	local var_12_3 = table.keyof(var_12_2, arg_12_0)

	for iter_12_0 = var_12_3 - 1, 1, -1 do
		local var_12_4 = var_12_2[iter_12_0]

		if var_0_0.HasAllHeroTeam(var_12_4) then
			for iter_12_1, iter_12_2 in ipairs(var_12_0.stage_id) do
				var_0_0.ReplayHeroTeam(arg_12_0, var_12_4, iter_12_1, iter_12_2)
			end

			return
		end
	end

	for iter_12_3 = var_12_3 + 1, #var_12_2 do
		local var_12_5 = var_12_2[iter_12_3]

		if var_0_0.HasAllHeroTeam(var_12_5) then
			for iter_12_4, iter_12_5 in ipairs(var_12_0.stage_id) do
				var_0_0.ReplayHeroTeam(arg_12_0, var_12_5, iter_12_4, iter_12_5)
			end

			return
		end
	end
end

function var_0_0.HasAllHeroTeam(arg_13_0)
	local var_13_0 = SequentialBattleChapterCfg[arg_13_0]

	for iter_13_0, iter_13_1 in ipairs(var_13_0.stage_id) do
		if var_0_0.HasHeroTeam(arg_13_0, iter_13_0, iter_13_1) then
			return true
		end
	end

	return false
end

function var_0_0.HasHeroTeam(arg_14_0, arg_14_1, arg_14_2)
	if var_0_0.GetHeroTeam(arg_14_0, arg_14_1, arg_14_2)[1] ~= 0 then
		return true
	end
end

function var_0_0.GetHeroTeam(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_15_0, arg_15_1, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = arg_15_2,
		activityID = arg_15_0
	})

	return ReserveTools.GetHeroList(var_15_0)
end

function var_0_0.ReplayHeroTeam(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_16_1, arg_16_2, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = arg_16_3,
		activityID = arg_16_1
	})
	local var_16_1, var_16_2, var_16_3, var_16_4 = ReserveTools.GetHeroList(var_16_0)
	local var_16_5, var_16_6 = ReserveTools.GetMimirData(var_16_0)
	local var_16_7 = ReserveTools.GetComboSkillID(var_16_0)
	local var_16_8 = ReserveTools.GetCharChipBaseID(var_16_0)
	local var_16_9 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_16_0, arg_16_2, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = arg_16_3,
		activityID = arg_16_0
	})

	ReserveTools.SetTeam(var_16_9, var_16_1, var_16_4 or {}, var_16_7, var_16_5, var_16_6, var_16_8)
end

return var_0_0
