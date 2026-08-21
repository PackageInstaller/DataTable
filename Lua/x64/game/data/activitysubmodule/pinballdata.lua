local var_0_0 = singletonClass("PinballData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(PinballPlayerCfg.all) do
		local var_1_0 = PinballPlayerCfg[iter_1_1]

		if var_1_0.type == 1 then
			var_0_1[iter_1_1] = {}
			var_0_1[iter_1_1].level = 1
			var_0_1[iter_1_1].health = var_1_0.base_attributes[1] + var_1_0.growth_attributes[1] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].attack = var_1_0.base_attributes[2] + var_1_0.growth_attributes[2] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].abilityPower = var_1_0.base_attributes[3] + var_1_0.growth_attributes[3] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].maxSkillPoint = var_1_0.base_attributes[4] + var_1_0.growth_attributes[4] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].skillPointRestore = var_1_0.base_attributes[5] + var_1_0.growth_attributes[5] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].startSkillPoint = var_1_0.base_attributes[6] + var_1_0.growth_attributes[6] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].skillList = clone(var_1_0.skill_list)
		end
	end

	arg_1_0.activityID = nil
	arg_1_0.lastEnterLevelCategory = nil
	arg_1_0.roleLevel = 0
	arg_1_0.stageInfo = {}
	arg_1_0.collection = {}
	arg_1_0.extraEquipSkill = {}
	arg_1_0.viewedUnlockedLevel = {}
	arg_1_0.maxChallengeScore = 0
end

function var_0_0.SetRoleLevel(arg_2_0, arg_2_1)
	arg_2_0.roleLevel = arg_2_1

	manager.notify:Invoke("PINBALL_ROLE_LEVEL_CHANGE", arg_2_1)
end

function var_0_0.SetStageCleared(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.stageInfo[arg_3_1] = arg_3_2
end

function var_0_0.GetRoleLevel(arg_4_0, arg_4_1)
	return arg_4_0.roleLevel
end

function var_0_0.GetLastEnterStageCategory(arg_5_0)
	return arg_5_0.lastEnterLevelCategory or PinballData:GetDisplayStageList()[1]
end

function var_0_0.SetLastEnterStageCategory(arg_6_0, arg_6_1)
	arg_6_0.lastEnterLevelCategory = arg_6_1
end

function var_0_0.GetLastPassStage(arg_7_0)
	return arg_7_0.lastPassStage or PinballData:GetDisplayStageList()[1]
end

function var_0_0.SetLastPassStage(arg_8_0, arg_8_1)
	arg_8_0.lastPassStage = arg_8_1
end

function var_0_0.GetStageCategoryActivityList(arg_9_0)
	return ActivityTools.GetAllSubActivityByTemplate(arg_9_0.activityID, 349)
end

function var_0_0.GetStageComplete(arg_10_0, arg_10_1)
	return arg_10_0.stageInfo[arg_10_1] ~= nil
end

function var_0_0.GetDisplayStageList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(PinballStageCfg.get_id_list_by_activity_id[arg_11_0.activityID]) do
		if PinballStageCfg[iter_11_1].barrier_type ~= 3 then
			table.insert(var_11_0, iter_11_1)
		else
			arg_11_0.challengeStageID = iter_11_1
		end
	end

	return var_11_0
end

function var_0_0.GetTargetStageFinishProgress(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetDisplayStageList()

	if var_12_0 then
		local var_12_1 = #var_12_0
		local var_12_2 = table.indexof(var_12_0, arg_12_1)
		local var_12_3 = 100

		return math.floor(var_12_2 / var_12_1 * var_12_3 + 0.5) / var_12_3
	end

	return 0
end

function var_0_0.GetStageFinishProgress(arg_13_0)
	local var_13_0 = arg_13_0:GetDisplayStageList()

	if var_13_0 then
		local var_13_1 = 0
		local var_13_2 = 0

		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			var_13_1 = var_13_1 + 1

			if arg_13_0:GetStageComplete(iter_13_1) then
				var_13_2 = var_13_2 + 1
			end
		end

		local var_13_3 = 100

		return math.floor(var_13_2 / var_13_1 * var_13_3 + 0.5) / var_13_3
	end

	return 0
end

function var_0_0.GetStageUnlocked(arg_14_0, arg_14_1)
	local var_14_0 = true
	local var_14_1
	local var_14_2 = nullable(PinballStageCfg, arg_14_1, "activity_id")
	local var_14_3 = nullable(PinballStageCfg, arg_14_1, "pre_stage") or 0

	if var_14_3 ~= 0 and not arg_14_0:GetStageComplete(var_14_3) then
		var_14_0, var_14_1 = false, var_14_1 or GetTipsF("PINBALL_STAGE_UNLOCK_TIPS", nullable(PinballStageCfg, var_14_3, "name") or "")
	end

	return var_14_0, var_14_1
end

function var_0_0.GetChallengeStageID(arg_15_0)
	return arg_15_0.challengeStageID
end

function var_0_0.GetStageState(arg_16_0, arg_16_1)
	if arg_16_0:GetStageComplete(arg_16_1) then
		return "complete"
	else
		local var_16_0, var_16_1 = arg_16_0:GetStageUnlocked(arg_16_1)

		if var_16_0 then
			return "unlock"
		else
			return "lock", var_16_1
		end
	end
end

function var_0_0.IsBossStage(arg_17_0, arg_17_1)
	local var_17_0 = PinballStageCfg[arg_17_1]

	if not var_17_0 then
		return false, 0
	end

	local var_17_1 = var_17_0.wellen_id

	if var_17_1 and type(var_17_1) == "table" then
		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			if type(iter_17_1) == "table" then
				iter_17_1 = iter_17_1[1]
			end

			local var_17_2 = PinballWaveCfg[iter_17_1]

			if var_17_2 then
				for iter_17_2, iter_17_3 in ipairs(var_17_2.wellen_monster_list) do
					local var_17_3 = PinballPlayerCfg[iter_17_3]

					if var_17_3 then
						if var_17_3.type == 3 then
							return true, var_17_3.type
						elseif var_17_3.type == 4 then
							return true, var_17_3.type
						end
					end
				end
			end
		end
	end

	return false, 0
end

function var_0_0.IsBossWave(arg_18_0, arg_18_1)
	local var_18_0 = PinballWaveCfg[arg_18_1]

	if var_18_0 then
		for iter_18_0, iter_18_1 in ipairs(var_18_0.wellen_monster_list) do
			local var_18_1 = PinballPlayerCfg[iter_18_1]

			if var_18_1 then
				if var_18_1.type == 3 then
					return true, var_18_1.type
				elseif var_18_1.type == 4 then
					return true, var_18_1.type
				end
			end
		end
	end

	return false, 0
end

function var_0_0.GetExraEquipSkill(arg_19_0)
	return arg_19_0.extraEquipSkill
end

function var_0_0.SetUnlockSkillList(arg_20_0, arg_20_1)
	arg_20_0.unlockSkillList = arg_20_1
end

function var_0_0.SetExtraEquipSkill(arg_21_0, arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		table.insert(var_21_0, iter_21_1)
	end

	local var_21_1 = var_0_0:GetPassiveSkillList()

	for iter_21_2, iter_21_3 in ipairs(var_21_1) do
		if not arg_21_0:IsSkillLocked(iter_21_3) and not table.indexof(var_21_0, iter_21_3) then
			table.insert(var_21_0, iter_21_3)
		end
	end

	arg_21_0.extraEquipSkill = var_21_0
end

function var_0_0.GetEquipedActiveSkill(arg_22_0)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.extraEquipSkill) do
		local var_22_1 = PinballSkillCfg[iter_22_1]

		if var_22_1 and var_22_1.skill_type == 1 then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_0.GetPassiveSkillList(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in pairs(PinballSkillCfg.get_id_list_by_skill_group) do
		local var_23_2 = PinballSkillCfg[iter_23_1[1]]

		if var_23_2 and var_23_2.activity_id == arg_23_0.activityID and var_23_2.skill_type == 2 then
			var_23_1[iter_23_0] = iter_23_1[1]
		end
	end

	for iter_23_2, iter_23_3 in ipairs(PinballSkillCfg.get_id_list_by_activity_id_skill_type[arg_23_0.activityID][2]) do
		local var_23_3 = PinballSkillCfg[iter_23_3]

		if not arg_23_0:IsSkillLocked(iter_23_3) then
			var_23_1[var_23_3.skill_group] = iter_23_3
		end
	end

	for iter_23_4, iter_23_5 in pairs(var_23_1) do
		table.insert(var_23_0, iter_23_5)
	end

	return var_23_0
end

function var_0_0.GetEquipedPassiveSkill(arg_24_0)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.extraEquipSkill) do
		local var_24_1 = PinballSkillCfg[iter_24_1]

		if var_24_1 and var_24_1.skill_type == 2 then
			table.insert(var_24_0, var_24_1)
		end
	end

	return var_24_0
end

function var_0_0.GetActivityID(arg_25_0)
	return arg_25_0.activityID
end

function var_0_0.GetRewardActivityID(arg_26_0)
	return nullable(nullable(ActivityCfg, arg_26_0.activityID, "sub_activity_list"), 2)
end

function var_0_0.SetMaxChallengeScore(arg_27_0, arg_27_1)
	arg_27_0.maxChallengeScore = arg_27_1
end

function var_0_0.GetMaxChallengeScore(arg_28_0)
	return arg_28_0.maxChallengeScore or 0
end

function var_0_0.GetMaxLevel(arg_29_0)
	local var_29_0 = 1

	return PinballStageCfg[PinballData:GetDisplayStageList()[#PinballData:GetDisplayStageList()]].lv_up
end

function var_0_0.GetRoleMaxAttributes(arg_30_0, arg_30_1)
	local var_30_0 = {}
	local var_30_1 = PinballPlayerCfg[arg_30_1]

	for iter_30_0, iter_30_1 in ipairs(var_30_1.base_attributes) do
		var_30_0[iter_30_0] = iter_30_1 + var_30_1.growth_attributes[iter_30_0] * (arg_30_0:GetMaxLevel() - 1)
	end

	return var_30_0
end

function var_0_0.GetRoleID(arg_31_0)
	return 40601
end

function var_0_0.HasPassAllStage(arg_32_0)
	local var_32_0 = false
	local var_32_1 = PinballData:GetDisplayStageList()

	if var_32_1 then
		for iter_32_0, iter_32_1 in pairs(var_32_1) do
			if not arg_32_0:GetStageComplete(iter_32_1) and (PinballStageCfg[iter_32_1].barrier_type == 1 or PinballStageCfg[iter_32_1].barrier_type == 2) then
				return false
			end
		end

		var_32_0 = true
	end

	return var_32_0
end

function var_0_0.IsSkillEquiped(arg_33_0, arg_33_1)
	return table.indexof(arg_33_0.extraEquipSkill, arg_33_1) ~= false
end

function var_0_0.IsSkillLocked(arg_34_0, arg_34_1)
	return table.indexof(arg_34_0.unlockSkillList, arg_34_1) == false
end

function var_0_0.IsSkillNew(arg_35_0, arg_35_1)
	local var_35_0 = getData("PinballGame", "newSkillClicked" .. arg_35_1)
	local var_35_1 = arg_35_0:IsSkillLocked(arg_35_1)

	if var_35_0 or var_35_1 then
		return false
	end

	return true
end

function var_0_0.GetSkillUnlockLevel(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(PinballData:GetDisplayStageList()) do
		if PinballStageCfg[iter_36_1].skill_unlock == arg_36_1 then
			return table.indexof(PinballData:GetDisplayStageList(), iter_36_1) + 1
		end
	end

	return 1
end

return var_0_0
