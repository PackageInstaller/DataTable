local var_0_0 = singletonClass("PinballData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(PinballPlayerCfg.all) do
		if PinballPlayerCfg[iter_1_1].type == 1 then
			var_0_1[iter_1_1] = {}
			var_0_1[iter_1_1].level = 1
			var_0_1[iter_1_1].health = PinballPlayerCfg[iter_1_1].base_attributes[1] + PinballPlayerCfg[iter_1_1].growth_attributes[1] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].attack = PinballPlayerCfg[iter_1_1].base_attributes[2] + PinballPlayerCfg[iter_1_1].growth_attributes[2] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].abilityPower = PinballPlayerCfg[iter_1_1].base_attributes[3] + PinballPlayerCfg[iter_1_1].growth_attributes[3] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].maxSkillPoint = PinballPlayerCfg[iter_1_1].base_attributes[4] + PinballPlayerCfg[iter_1_1].growth_attributes[4] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].skillPointRestore = PinballPlayerCfg[iter_1_1].base_attributes[5] + PinballPlayerCfg[iter_1_1].growth_attributes[5] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].startSkillPoint = PinballPlayerCfg[iter_1_1].base_attributes[6] + PinballPlayerCfg[iter_1_1].growth_attributes[6] * var_0_1[iter_1_1].level
			var_0_1[iter_1_1].skillList = clone(PinballPlayerCfg[iter_1_1].skill_list)
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

function var_0_0:SetStageCleared(arg_3_1, arg_3_2)
	self.stageInfo[arg_3_1] = arg_3_2
end

function var_0_0:GetRoleLevel(arg_4_1)
	return self.roleLevel
end

function var_0_0:GetLastEnterStageCategory()
	return self.lastEnterLevelCategory or PinballData:GetDisplayStageList()[1]
end

function var_0_0.SetLastEnterStageCategory(arg_6_0, arg_6_1)
	arg_6_0.lastEnterLevelCategory = arg_6_1
end

function var_0_0:GetLastPassStage()
	return self.lastPassStage or PinballData:GetDisplayStageList()[1]
end

function var_0_0.SetLastPassStage(arg_8_0, arg_8_1)
	arg_8_0.lastPassStage = arg_8_1
end

function var_0_0:GetStageCategoryActivityList()
	return ActivityTools.GetAllSubActivityByTemplate(self.activityID, 349)
end

function var_0_0:GetStageComplete(arg_10_1)
	return self.stageInfo[arg_10_1] ~= nil
end

function var_0_0:GetDisplayStageList()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(PinballStageCfg.get_id_list_by_activity_id[self.activityID]) do
		if PinballStageCfg[iter_11_1].barrier_type ~= 3 then
			table.insert(var_11_0, iter_11_1)
		else
			self.challengeStageID = iter_11_1
		end
	end

	return var_11_0
end

function var_0_0:GetTargetStageFinishProgress(arg_12_1)
	local var_12_0 = self:GetDisplayStageList()

	if var_12_0 then
		return math.floor(table.indexof(var_12_0, arg_12_1) / #var_12_0 * 100 + 0.5) / 100
	end

	return 0
end

function var_0_0:GetStageFinishProgress()
	local var_13_0 = self:GetDisplayStageList()

	if var_13_0 then
		local var_13_1 = 0
		local var_13_2 = 0

		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			var_13_1 = var_13_1 + 1

			if self:GetStageComplete(iter_13_1) then
				var_13_2 = var_13_2 + 1
			end
		end

		return math.floor(var_13_2 / var_13_1 * 100 + 0.5) / 100
	end

	return 0
end

function var_0_0:GetStageUnlocked(arg_14_1)
	local var_14_0 = true
	local var_14_1
	local var_14_2 = nullable(PinballStageCfg, arg_14_1, "activity_id")
	local var_14_3 = nullable(PinballStageCfg, arg_14_1, "pre_stage") or 0

	if var_14_3 ~= 0 and not self:GetStageComplete(var_14_3) then
		var_14_1 = var_14_1 or GetTipsF("PINBALL_STAGE_UNLOCK_TIPS", nullable(PinballStageCfg, var_14_3, "name") or "")
		var_14_0 = false
	end

	return var_14_0, var_14_1
end

function var_0_0:GetChallengeStageID()
	return self.challengeStageID
end

function var_0_0:GetStageState(arg_16_1)
	if self:GetStageComplete(arg_16_1) then
		return "complete"
	else
		local var_16_0, var_16_1 = self:GetStageUnlocked(arg_16_1)

		if var_16_0 then
			return "unlock"
		else
			return "lock", var_16_1
		end
	end
end

function var_0_0.IsBossStage(arg_17_0, arg_17_1)
	if not PinballStageCfg[arg_17_1] then
		return false, 0
	end

	local var_17_0 = PinballStageCfg[arg_17_1].wellen_id

	if PinballStageCfg[arg_17_1].wellen_id and type(var_17_0) == "table" then
		for iter_17_0, iter_17_1 in pairs(var_17_0) do
			if type(iter_17_1) == "table" then
				iter_17_1 = iter_17_1[1]
			end

			if PinballWaveCfg[iter_17_1] then
				for iter_17_2, iter_17_3 in ipairs(PinballWaveCfg[iter_17_1].wellen_monster_list) do
					if PinballPlayerCfg[iter_17_3] then
						if PinballPlayerCfg[iter_17_3].type == 3 then
							return true, PinballPlayerCfg[iter_17_3].type
						elseif PinballPlayerCfg[iter_17_3].type == 4 then
							return true, PinballPlayerCfg[iter_17_3].type
						end
					end
				end
			end
		end
	end

	return false, 0
end

function var_0_0.IsBossWave(arg_18_0, arg_18_1)
	if PinballWaveCfg[arg_18_1] then
		for iter_18_0, iter_18_1 in ipairs(PinballWaveCfg[arg_18_1].wellen_monster_list) do
			if PinballPlayerCfg[iter_18_1] then
				if PinballPlayerCfg[iter_18_1].type == 3 then
					return true, PinballPlayerCfg[iter_18_1].type
				elseif PinballPlayerCfg[iter_18_1].type == 4 then
					return true, PinballPlayerCfg[iter_18_1].type
				end
			end
		end
	end

	return false, 0
end

function var_0_0:GetExraEquipSkill()
	return self.extraEquipSkill
end

function var_0_0.SetUnlockSkillList(arg_20_0, arg_20_1)
	arg_20_0.unlockSkillList = arg_20_1
end

function var_0_0:SetExtraEquipSkill(arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		table.insert(var_21_0, iter_21_1)
	end

	for iter_21_2, iter_21_3 in ipairs((var_0_0:GetPassiveSkillList())) do
		if not self:IsSkillLocked(iter_21_3) and not table.indexof(var_21_0, iter_21_3) then
			table.insert(var_21_0, iter_21_3)
		end
	end

	self.extraEquipSkill = var_21_0
end

function var_0_0:GetEquipedActiveSkill()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(self.extraEquipSkill) do
		if PinballSkillCfg[iter_22_1] and PinballSkillCfg[iter_22_1].skill_type == 1 then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_0:GetPassiveSkillList()
	local var_23_0 = {}
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in pairs(PinballSkillCfg.get_id_list_by_skill_group) do
		if PinballSkillCfg[iter_23_1[1]] and PinballSkillCfg[iter_23_1[1]].activity_id == self.activityID and PinballSkillCfg[iter_23_1[1]].skill_type == 2 then
			var_23_1[iter_23_0] = iter_23_1[1]
		end
	end

	for iter_23_2, iter_23_3 in ipairs(PinballSkillCfg.get_id_list_by_activity_id_skill_type[self.activityID][2]) do
		if not self:IsSkillLocked(iter_23_3) then
			var_23_1[PinballSkillCfg[iter_23_3].skill_group] = iter_23_3
		end
	end

	for iter_23_4, iter_23_5 in pairs(var_23_1) do
		table.insert(var_23_0, iter_23_5)
	end

	return var_23_0
end

function var_0_0:GetEquipedPassiveSkill()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self.extraEquipSkill) do
		if PinballSkillCfg[iter_24_1] and PinballSkillCfg[iter_24_1].skill_type == 2 then
			table.insert(var_24_0, PinballSkillCfg[iter_24_1])
		end
	end

	return var_24_0
end

function var_0_0:GetActivityID()
	return self.activityID
end

function var_0_0:GetRewardActivityID()
	return nullable(nullable(ActivityCfg, self.activityID, "sub_activity_list"), 2)
end

function var_0_0.SetMaxChallengeScore(arg_27_0, arg_27_1)
	arg_27_0.maxChallengeScore = arg_27_1
end

function var_0_0:GetMaxChallengeScore()
	return self.maxChallengeScore or 0
end

function var_0_0.GetMaxLevel(arg_29_0)
	return PinballStageCfg[PinballData:GetDisplayStageList()[#PinballData:GetDisplayStageList()]].lv_up
end

function var_0_0:GetRoleMaxAttributes(arg_30_1)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(PinballPlayerCfg[arg_30_1].base_attributes) do
		var_30_0[iter_30_0] = iter_30_1 + PinballPlayerCfg[arg_30_1].growth_attributes[iter_30_0] * (self:GetMaxLevel() - 1)
	end

	return var_30_0
end

function var_0_0.GetRoleID(arg_31_0)
	return 40601
end

function var_0_0:HasPassAllStage()
	local var_32_0 = false
	local var_32_1 = PinballData:GetDisplayStageList()

	if var_32_1 then
		for iter_32_0, iter_32_1 in pairs(var_32_1) do
			if not self:GetStageComplete(iter_32_1) and (PinballStageCfg[iter_32_1].barrier_type == 1 or PinballStageCfg[iter_32_1].barrier_type == 2) then
				return false
			end
		end

		var_32_0 = true
	end

	return var_32_0
end

function var_0_0:IsSkillEquiped(arg_33_1)
	return table.indexof(self.extraEquipSkill, arg_33_1) ~= false
end

function var_0_0:IsSkillLocked(arg_34_1)
	return table.indexof(self.unlockSkillList, arg_34_1) == false
end

function var_0_0:IsSkillNew(arg_35_1)
	if getData("PinballGame", "newSkillClicked" .. arg_35_1) or self:IsSkillLocked(arg_35_1) then
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
