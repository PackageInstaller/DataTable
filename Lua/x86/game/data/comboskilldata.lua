local var_0_0 = singletonClass("ComboSkillData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	arg_1_0.comboSkill_ = {}
	arg_1_0.needRefresh_ = false
	arg_1_0.needRefreshBoss_ = {}
	var_0_1 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.cooperate_unique_skill_list) do
		arg_2_0.comboSkill_[iter_2_1.type] = arg_2_0.comboSkill_[iter_2_1.type] or {}

		local var_2_0 = iter_2_1.difficulty

		if var_2_0 == nil then
			var_2_0 = 1
		end

		arg_2_0.comboSkill_[iter_2_1.type][var_2_0] = iter_2_1.cooperate_unique_skill_id
	end
end

function var_0_0.GetComboSkillID(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 == nil then
		arg_3_3 = 1
	end

	local var_3_0 = GetHeroTeamActivityID(arg_3_1, arg_3_2)

	if arg_3_1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or arg_3_1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
		local var_3_1 = getData("BossChallenge", "boss_combo_skill_" .. arg_3_3)

		if var_3_1 then
			return var_3_1
		end
	end

	if arg_3_0.comboSkill_[var_3_0] and arg_3_0.comboSkill_[var_3_0][arg_3_3] then
		return arg_3_0.comboSkill_[var_3_0][arg_3_3]
	else
		return 0
	end
end

function var_0_0.SetComboSkillID(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.comboSkill_[arg_4_1] == nil then
		arg_4_0.comboSkill_[arg_4_1] = {}
	end

	arg_4_0.comboSkill_[arg_4_1][arg_4_2] = arg_4_3

	if arg_4_1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or arg_4_1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
		saveData("BossChallenge", "boss_combo_skill_" .. arg_4_2, arg_4_3)
	end
end

function var_0_0.SetNeedRefresh(arg_5_0, arg_5_1)
	arg_5_0.needRefresh_ = arg_5_1
end

function var_0_0.GetNeedRefresh(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0.needRefresh_
end

function var_0_0.SetBossChallengeNeedRefresh(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.needRefreshBoss_[arg_7_1] = arg_7_2
end

function var_0_0.GetBossChallengeNeedRefresh(arg_8_0, arg_8_1)
	return arg_8_0.needRefreshBoss_[arg_8_1]
end

function var_0_0.SetMatrixNeedRefresh(arg_9_0, arg_9_1)
	arg_9_0.matrixNeedRefresh_ = arg_9_1
end

function var_0_0.GetMatrixNeedRefresh(arg_10_0)
	return arg_10_0.matrixNeedRefresh_
end

function var_0_0.GetComboSkill(arg_11_0)
	return arg_11_0.comboSkill_
end

function var_0_0.InitLevelData(arg_12_0, arg_12_1)
	var_0_1 = {}

	local var_12_0 = arg_12_1.info.skill_list

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = {}

		for iter_12_2, iter_12_3 in ipairs(iter_12_1.progress_list) do
			table.insert(var_12_1, {
				condition_id = iter_12_3.id,
				times = iter_12_3.times
			})
		end

		var_0_1[iter_12_1.id] = {
			level = iter_12_1.level,
			progress_list = var_12_1
		}
	end
end

function var_0_0.UpdateLevelData(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.skill
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0.progress_list) do
		table.insert(var_13_1, {
			condition_id = iter_13_1.id,
			times = iter_13_1.times
		})
	end

	var_0_1[var_13_0.id] = {
		level = var_13_0.level,
		progress_list = var_13_1
	}
end

function var_0_0.UpgradeComboSkillLevel(arg_14_0, arg_14_1)
	if var_0_1[arg_14_1] then
		var_0_1[arg_14_1].level = arg_14_0:GetCurComboSkillLevel(arg_14_1) + 1
	else
		var_0_1[arg_14_1] = {
			level = 1,
			progress_list = {}
		}
	end
end

function var_0_0.GetCurComboSkillLevel(arg_15_0, arg_15_1)
	local var_15_0 = var_0_1[arg_15_1]

	if var_15_0 then
		return var_15_0.level
	else
		return 1
	end
end

function var_0_0.GetComboSkillUpConditionProcess(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = var_0_1[arg_16_1]

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0.progress_list) do
			if arg_16_2 == iter_16_1.condition_id then
				return iter_16_1.times
			end
		end
	end

	return 0
end

return var_0_0
