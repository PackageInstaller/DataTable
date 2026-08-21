require("game.data.MythicDataTemplate")

local var_0_0 = singletonClass("MythicData")
local var_0_1 = false
local var_0_2 = 0
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = 0
local var_0_8 = 1001
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = {}
local var_0_12 = 0
local var_0_13 = {}
local var_0_14 = {}
local var_0_15 = {}
local var_0_16 = false
local var_0_17 = {}
local var_0_18 = 1
local var_0_19 = {}
local var_0_20 = {}
local var_0_21 = 0
local var_0_22 = false
local var_0_23 = 1
local var_0_24 = 0
local var_0_25 = {}
local var_0_26 = 0
local var_0_27 = {}
local var_0_28 = {}
local var_0_29 = {
	CHIP = 2,
	HERO = 1,
	COMBO = 3
}

function var_0_0.Init(arg_1_0)
	var_0_3 = {}
	var_0_4 = {}
	var_0_5 = {}
	var_0_6 = {}
	var_0_9 = {}
	var_0_11 = {}
	var_0_12 = 0
	var_0_13 = {}
	var_0_14 = {}
	var_0_15 = {}
	var_0_16 = false
	var_0_22 = false
	var_0_17 = {}
	var_0_23 = 1
	var_0_18 = 1
	var_0_19 = {}
	var_0_20 = {}
	var_0_21 = 0
	var_0_10 = {}
	arg_1_0.teamData_ = {}
end

function var_0_0.InitMythicData(arg_2_0, arg_2_1)
	var_0_3 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.difficulty_list) do
		local var_2_0 = {}
		local var_2_1 = iter_2_1.difficulty

		var_2_0.difficulty = var_2_1
		var_2_0.main_partition = MythicDifficultyTemplate.New(iter_2_1.main_partition)
		var_2_0.sub_partition_list = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.sub_partition_list) do
			table.insert(var_2_0.sub_partition_list, MythicDifficultyTemplate.New(iter_2_3))
		end

		var_0_3[var_2_1] = var_2_0
	end

	var_0_4 = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.superiority_affix_list) do
		table.insert(var_0_4, {
			iter_2_5.id,
			iter_2_5.level,
			iter_2_5.type
		})
	end

	var_0_5 = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.inferiority_affix_list) do
		table.insert(var_0_5, {
			iter_2_7.id,
			iter_2_7.level,
			iter_2_7.type
		})
	end

	var_0_6 = {}

	for iter_2_8, iter_2_9 in ipairs(arg_2_1.mythic_ultimate_affix_list) do
		table.insert(var_0_6, {
			iter_2_9.id,
			iter_2_9.level,
			iter_2_9.type
		})
	end

	if arg_2_1.next_refresh_timestamp ~= var_0_7 then
		var_0_1 = true
	end

	var_0_7 = arg_2_1.next_refresh_timestamp
	var_0_10 = arg_2_1.recommend_team
end

function var_0_0.InitFinalMythicData(arg_3_0, arg_3_1)
	var_0_9 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.stage_list) do
		var_0_9[iter_3_1.difficulty_id] = {}

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.stage_id) do
			table.insert(var_0_9[iter_3_1.difficulty_id], iter_3_3)
		end
	end
end

function var_0_0.InitFinalMythicUserData(arg_4_0, arg_4_1)
	var_0_17 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.difficulty_id_can_choose) do
		if iter_4_1 > var_0_23 then
			var_0_23 = iter_4_1
		end

		table.insert(var_0_17, iter_4_1)
	end

	var_0_18 = arg_4_1.now_difficulty
	var_0_19 = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.receive_reward) do
		table.insert(var_0_19, iter_4_3)
	end

	var_0_21 = 0
	var_0_20 = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.clear_list) do
		if iter_4_5 > var_0_21 then
			var_0_21 = iter_4_5
		end

		table.insert(var_0_20, iter_4_5)
	end

	var_0_22 = arg_4_1.is_new_difficulty
	var_0_26 = 0
	var_0_27 = {}

	if arg_4_1.challenge_info[1] then
		for iter_4_6, iter_4_7 in ipairs(arg_4_1.challenge_info) do
			var_0_27[iter_4_7.team_id] = {}
			var_0_27[iter_4_7.team_id].team_id = iter_4_7.team_id
			var_0_27[iter_4_7.team_id].clear_state = iter_4_7.clear_state
			var_0_27[iter_4_7.team_id].use_time = iter_4_7.use_time

			if var_0_26 == 0 and iter_4_7.clear_state == 0 then
				var_0_26 = iter_4_7.team_id
			end
		end
	else
		var_0_26 = 1
	end
end

function var_0_0.InitMythicUserPublicData(arg_5_0, arg_5_1)
	var_0_11 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.open_difficulty_list) do
		table.insert(var_0_11, iter_5_1)
	end

	var_0_12 = arg_5_1.difficulty
	var_0_16 = arg_5_1.is_new_difficulty
end

function var_0_0.InitMythicUserData(arg_6_0, arg_6_1)
	var_0_13 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.clear_partition_id_list) do
		table.insert(var_0_13, iter_6_1)
	end

	var_0_14 = {}

	for iter_6_2, iter_6_3 in ipairs(arg_6_1.main_partition_star_list) do
		table.insert(var_0_14, iter_6_3)
	end

	var_0_15 = {}

	for iter_6_4, iter_6_5 in ipairs(arg_6_1.star_reward_provide_list) do
		table.insert(var_0_15, iter_6_5)
	end
end

function var_0_0.GetHeroAffix(arg_7_0)
	local var_7_0 = {}

	if var_0_12 ~= 0 then
		local var_7_1 = MythicNormalCfg[var_0_12] and MythicNormalCfg[var_0_12].sub_partition_list or {}

		for iter_7_0, iter_7_1 in ipairs(var_7_1) do
			if table.indexof(var_0_13, iter_7_1) and var_0_4[iter_7_0] then
				table.insert(var_7_0, var_0_4[iter_7_0])
			end
		end
	end

	return var_7_0
end

function var_0_0.GetAllHeroAffix(arg_8_0)
	return var_0_4
end

function var_0_0.GetHeroAffixWithStatus(arg_9_0)
	local var_9_0 = {}

	if var_0_12 ~= 0 then
		local var_9_1 = MythicNormalCfg[var_0_12] and MythicNormalCfg[var_0_12].sub_partition_list or {}

		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			local var_9_2 = true

			if table.indexof(var_0_13, iter_9_1) and var_0_4[iter_9_0] then
				var_9_2 = false
			end

			local var_9_3 = var_0_4[iter_9_0]

			var_9_3.isLock = var_9_2

			table.insert(var_9_0, var_9_3)
		end
	end

	return var_9_0
end

function var_0_0.GetMonsterAffix(arg_10_0)
	return var_0_5 or {}
end

function var_0_0.GetFinalMonsterAffix(arg_11_0)
	return var_0_6 or {}
end

function var_0_0.GetDifficulty(arg_12_0)
	return var_0_12 or 1
end

function var_0_0.SetDifficulty(arg_13_0, arg_13_1)
	var_0_13 = {}
	var_0_14 = {}
	var_0_15 = {}
	var_0_12 = arg_13_1
end

function var_0_0.GetIsOpenDifficulty(arg_14_0, arg_14_1)
	return table.indexof(var_0_11, arg_14_1)
end

function var_0_0.GetNextRefreshTime(arg_15_0)
	return var_0_7
end

function var_0_0.GetDifficultyData(arg_16_0, arg_16_1)
	return var_0_3[arg_16_1]
end

function var_0_0.GetIsOver(arg_17_0)
	if var_0_12 == 0 then
		return false
	end

	local var_17_0 = var_0_3[var_0_12]
	local var_17_1 = var_17_0 and var_17_0.main_partition.partition or -1

	return not not var_0_3[var_17_1]
end

function var_0_0.GetIsFirstClear(arg_18_0, arg_18_1)
	return not table.indexof(var_0_13, arg_18_1)
end

function var_0_0.UpdatePartitionState(arg_19_0, arg_19_1)
	if not table.indexof(var_0_13, arg_19_1) then
		table.insert(var_0_13, arg_19_1)
	end

	SendMessageManagerToSDK("blackzone_clear", {
		partition = arg_19_1
	})
end

function var_0_0.GetPartitionCount(arg_20_0)
	return #var_0_13
end

function var_0_0.GetStarCount(arg_21_0)
	return #var_0_14
end

function var_0_0.GetStarOpen(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(var_0_14) do
		if iter_22_1 == arg_22_1 then
			return true
		end
	end

	return false
end

function var_0_0.UpdateStarIndex(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(var_0_14) do
		if iter_23_1 == arg_23_1 then
			return
		end
	end

	table.insert(var_0_14, arg_23_1)
end

function var_0_0.GetStarRewardState(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(var_0_15) do
		if iter_24_1 == arg_24_1 then
			return true
		end
	end

	return false
end

function var_0_0.SetStarRewardState(arg_25_0, arg_25_1)
	table.insert(var_0_15, arg_25_1)
end

function var_0_0.GetStarRewardCount(arg_26_0)
	return table.length(var_0_15)
end

function var_0_0.GetAttributeFactor(arg_27_0, arg_27_1)
	local var_27_0 = MythicPartitionCfg[arg_27_1]

	if var_27_0.attribute_factor and var_27_0.attribute_factor[3] then
		local var_27_1 = var_27_0.attribute_factor[1] / 1000
		local var_27_2 = var_27_0.attribute_factor[2] / 1000
		local var_27_3 = var_27_0.attribute_factor[3] / 1000

		return Vector3.New(var_27_1, var_27_2, var_27_3)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_0.GetMonsterLevel(arg_28_0, arg_28_1)
	return MythicPartitionCfg[arg_28_1] and MythicPartitionCfg[arg_28_1].monster_level or 0
end

function var_0_0.SetIsNewDifficulty(arg_29_0, arg_29_1)
	var_0_16 = arg_29_1
end

function var_0_0.GetIsNewDifficulty(arg_30_0)
	return var_0_16
end

function var_0_0.SetIsNew(arg_31_0, arg_31_1)
	var_0_1 = arg_31_1
end

function var_0_0.GetIsNew(arg_32_0)
	return var_0_1
end

function var_0_0.GetMaxDifficulty(arg_33_0)
	local var_33_0 = 1

	for iter_33_0, iter_33_1 in ipairs(var_0_11) do
		if iter_33_1 == var_0_8 then
			if arg_33_0:GetIsOpenDifficulty(var_0_8) then
				var_33_0 = iter_33_1
			end
		elseif var_33_0 < iter_33_1 then
			var_33_0 = iter_33_1
		end
	end

	return var_33_0
end

function var_0_0.IsShowDifficultySelectView(arg_34_0)
	if var_0_12 == 0 then
		return true
	end

	return false
end

function var_0_0.IsShowDifficultySelectView_Guide(arg_35_0)
	if var_0_12 == 0 then
		return true
	end

	return false
end

function var_0_0.GetFinalId(arg_36_0)
	return var_0_8
end

function var_0_0.GetFinalIsReward(arg_37_0)
	return table.length(var_0_19)
end

function var_0_0.GetFinalRewardNotGet(arg_38_0)
	for iter_38_0 = 1, var_0_21 do
		if table.indexof(var_0_19, iter_38_0) == false then
			return true
		end
	end

	return false
end

function var_0_0.GetPassHotLevel(arg_39_0)
	return var_0_21
end

function var_0_0.GetFinalRewardStateByHotLevel(arg_40_0, arg_40_1)
	return table.keyof(var_0_19, arg_40_1)
end

function var_0_0.GetFinalReward(arg_41_0, arg_41_1)
	table.insert(var_0_19, arg_41_1)
end

function var_0_0.GetPassHotLevelStatu(arg_42_0)
	return table.length(var_0_20)
end

function var_0_0.GetHotLevelIsPass(arg_43_0, arg_43_1)
	return table.indexof(var_0_20, arg_43_1)
end

function var_0_0.SetCurHotLevelId(arg_44_0, arg_44_1)
	var_0_18 = arg_44_1
end

function var_0_0.GetCurHotLevelId(arg_45_0)
	return var_0_18
end

function var_0_0.GetCurLevelIdList(arg_46_0)
	return var_0_9[var_0_18]
end

function var_0_0.CheckCanEnterMutiBattle(arg_47_0, arg_47_1)
	for iter_47_0 = 1, arg_47_1 do
		local var_47_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, iter_47_0)
		local var_47_1 = ReserveTools.GetHeroList(var_47_0)

		if #var_47_1 == 0 or var_47_1[1] == 0 then
			return false
		end
	end

	return true
end

function var_0_0.GetLevelIsOpen(arg_48_0, arg_48_1)
	return table.indexof(var_0_17, arg_48_1)
end

function var_0_0.GetAllFinalReward(arg_49_0)
	for iter_49_0 = 1, var_0_21 do
		if table.indexof(var_0_19, iter_49_0) == false then
			table.insert(var_0_19, iter_49_0)
		end
	end
end

function var_0_0.GetRemainTime(arg_50_0)
	local var_50_0 = var_0_2

	for iter_50_0, iter_50_1 in pairs(var_0_27) do
		if iter_50_1.clear_state == 1 then
			var_50_0 = var_50_0 - iter_50_1.use_time
		end
	end

	return var_50_0
end

function var_0_0.SetRemainTime(arg_51_0, arg_51_1)
	var_0_2 = arg_51_1
end

function var_0_0.GetIsNewHotLevel(arg_52_0)
	return var_0_22
end

function var_0_0.SetIsNewHotLevel(arg_53_0, arg_53_1)
	var_0_22 = arg_53_1
end

function var_0_0.SubLevel(arg_54_0, arg_54_1)
	local var_54_0 = var_0_18 + arg_54_1
	local var_54_1 = true

	if arg_54_1 > 0 then
		if var_54_0 > var_0_23 then
			return
		end
	elseif var_54_0 <= 0 then
		return
	end

	MythicAction:SelectLevel(var_54_0)
end

function var_0_0.SetCurHotLevelIdMax(arg_55_0)
	MythicAction:SelectLevel(var_0_23)
end

function var_0_0.GetLevelStatus(arg_56_0)
	if var_0_18 == 1 then
		return "nofront"
	elseif var_0_18 == var_0_23 then
		return "nonext"
	else
		return "mid"
	end
end

function var_0_0.GetLevelMax(arg_57_0)
	return var_0_23
end

function var_0_0.GetIsHaveRewardNotGet(arg_58_0)
	for iter_58_0 = 1, var_0_21 do
		if table.indexof(var_0_19, iter_58_0) == false then
			return true
		end
	end

	return false
end

function var_0_0.SortRewards(arg_59_0)
	local var_59_0 = {}
	local var_59_1 = {}
	local var_59_2 = {}

	for iter_59_0, iter_59_1 in ipairs(MythicFinalCfg.all) do
		if iter_59_1 > var_0_21 then
			table.insert(var_59_2, iter_59_1)
		elseif table.indexof(var_0_19, iter_59_1) then
			table.insert(var_59_1, iter_59_1)
		else
			table.insert(var_59_0, iter_59_1)
		end
	end

	local var_59_3 = 1

	for iter_59_2, iter_59_3 in pairs(var_59_0) do
		var_0_25[var_59_3] = iter_59_3
		var_59_3 = var_59_3 + 1
	end

	for iter_59_4, iter_59_5 in pairs(var_59_2) do
		var_0_25[var_59_3] = iter_59_5
		var_59_3 = var_59_3 + 1
	end

	for iter_59_6, iter_59_7 in pairs(var_59_1) do
		var_0_25[var_59_3] = iter_59_7
		var_59_3 = var_59_3 + 1
	end
end

function var_0_0.GetRealIndex(arg_60_0, arg_60_1)
	return var_0_25[arg_60_1]
end

function var_0_0.SetCurPoint(arg_61_0, arg_61_1)
	var_0_24 = arg_61_1
end

function var_0_0.GetCurPoint(arg_62_0)
	return var_0_24
end

function var_0_0.GetCurBattleIndex(arg_63_0)
	return var_0_26
end

function var_0_0.GetIsBattleIng(arg_64_0)
	if var_0_26 > 1 then
		return true
	else
		return false
	end
end

function var_0_0.InitSeverTeamData(arg_65_0, arg_65_1)
	var_0_28 = {}

	if arg_65_1.teams_info_list[1] and arg_65_1.teams_info_list[1].stage_type == BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL then
		for iter_65_0, iter_65_1 in ipairs(arg_65_1.teams_info_list) do
			for iter_65_2, iter_65_3 in ipairs(iter_65_1.teams) do
				var_0_28[iter_65_3.id] = {}
				var_0_28[iter_65_3.id].heroList = {}

				for iter_65_4, iter_65_5 in ipairs(iter_65_3.hero_list) do
					table.insert(var_0_28[iter_65_3.id].heroList, iter_65_5.hero_id)
				end

				if iter_65_3.ai_chip_list[1] then
					var_0_28[iter_65_3.id].chipManagerID = iter_65_3.ai_chip_list[1]
					var_0_28[iter_65_3.id].chipList = {}

					for iter_65_6, iter_65_7 in ipairs(iter_65_3.ai_chip_list) do
						if iter_65_6 > 1 then
							table.insert(var_0_28[iter_65_3.id].chipList, iter_65_7)
						end
					end
				else
					var_0_28[iter_65_3.id].chipManagerID = 0
				end

				var_0_28[iter_65_3.id].uniqueSkillID = iter_65_3.cooperate_unique_skill_id
			end
		end
	end
end

function var_0_0.TryToSaveCurTeamData(arg_66_0, arg_66_1)
	var_0_28 = {}

	if arg_66_1.teams_info_list and arg_66_1.teams_info_list.stage_type == BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL then
		for iter_66_0, iter_66_1 in ipairs(arg_66_1.teams_info_list.teams) do
			var_0_28[iter_66_1.id] = {}
			var_0_28[iter_66_1.id].heroList = {}

			for iter_66_2, iter_66_3 in ipairs(iter_66_1.hero_list) do
				table.insert(var_0_28[iter_66_1.id].heroList, iter_66_3.hero_id)
			end

			if iter_66_1.ai_chip_list[1] then
				var_0_28[iter_66_1.id].chipManagerID = iter_66_1.ai_chip_list[1]
				var_0_28[iter_66_1.id].chipList = {}

				for iter_66_4, iter_66_5 in ipairs(iter_66_1.ai_chip_list) do
					if iter_66_4 > 1 then
						table.insert(var_0_28[iter_66_1.id].chipList, iter_66_5)
					end
				end
			else
				var_0_28[iter_66_1.id].chipManagerID = 0
			end

			var_0_28[iter_66_1.id].uniqueSkillID = iter_66_1.cooperate_unique_skill_id
		end
	end
end

function var_0_0.GetChipListByTeamID(arg_67_0, arg_67_1)
	return var_0_28[arg_67_1].chipList
end

function var_0_0.ClearBattleData(arg_68_0)
	var_0_26 = 0
	var_0_27 = {}
end

function var_0_0.GetRecommendTeam(arg_69_0)
	return var_0_10 or {}
end

local var_0_30 = {
	ALL = 1,
	GUILD = 2
}
local var_0_31 = var_0_30.ALL

function var_0_0.GetRankTypeConst(arg_70_0)
	return var_0_30
end

function var_0_0.GetCurRankType(arg_71_0)
	return var_0_31
end

function var_0_0.SetCurRankType(arg_72_0, arg_72_1)
	var_0_31 = arg_72_1
end

function var_0_0.GetCurTime(arg_73_0)
	local var_73_0 = MythicFinalCfg[var_0_18].time

	if arg_73_0:GetIsBattleIng() then
		for iter_73_0, iter_73_1 in pairs(var_0_27) do
			if iter_73_1.clear_state == 1 then
				var_73_0 = var_73_0 - iter_73_1.use_time
			end
		end
	end

	return var_73_0
end

function var_0_0.GetBattlingTime(arg_74_0)
	local var_74_0 = MythicFinalCfg[var_0_18].time

	for iter_74_0, iter_74_1 in pairs(var_0_27) do
		if iter_74_1.clear_state == 1 then
			var_74_0 = var_74_0 - iter_74_1.use_time
		end
	end

	return var_74_0
end

function var_0_0.GetBattleRemainTime(arg_75_0, arg_75_1)
	local var_75_0 = MythicFinalCfg[var_0_18].time

	for iter_75_0 = 1, arg_75_1 - 1 do
		var_75_0 = var_75_0 - var_0_27[iter_75_0].use_time
	end

	return var_75_0
end

return var_0_0
