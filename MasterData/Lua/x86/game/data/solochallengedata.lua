local var_0_0 = singletonClass("SoloChallengeData")
local var_0_1

function var_0_0.Init(arg_1_0)
	arg_1_0.customAffixList_ = {}
	arg_1_0.completedActivityList_ = {}
	arg_1_0.receivedActivityList_ = {}
	arg_1_0.uncompletedActivityList_ = {}
	arg_1_0.affixStateList_ = {}
	arg_1_0.stageIDToActivityID_ = {}
	arg_1_0.completedStageList_ = {}
	arg_1_0.lastTeamDataList_ = {}
	arg_1_0.InitedAffixState_ = {}
	var_0_1 = nil
end

function var_0_0:SetData(arg_2_1)
	local var_2_0 = ActivitySoloChallengeCfg[arg_2_1.info.challenge_id].activity_id

	self.completedActivityList_[ActivitySoloChallengeCfg[arg_2_1.info.challenge_id].activity_id] = {}
	self.receivedActivityList_[var_2_0] = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.info.is_award_admited) do
		self:SetReceivedActivityList(var_2_0, SoloChallengeTools.GetDifficultyIndex(iter_2_1), false)
	end

	local var_2_1 = false

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.info.is_clear) do
		self:SetCompletedActivityList(var_2_0, SoloChallengeTools.GetDifficultyIndex(iter_2_3), false)

		var_2_1 = true
	end

	if not var_2_1 and not table.keyof(self.uncompletedActivityList_, var_2_0) then
		table.insert(self.uncompletedActivityList_, var_2_0)
	end

	local var_2_2 = arg_2_1.info.select_difficult or 1

	for iter_2_4, iter_2_5 in ipairs(ActivitySoloChallengeCfg[arg_2_1.info.challenge_id].stage_id) do
		if iter_2_5[1] == var_2_2 then
			self:SetSelectedDifficultyIndex(var_2_0, iter_2_4)
		end
	end

	self.completedStageList_[var_2_0] = self.completedStageList_[var_2_0] or {}

	if arg_2_1.info.solo_info ~= nil then
		local var_2_3 = 1

		for iter_2_6 = 1, #ActivitySoloChallengeCfg[var_2_0].stage_id do
			self.completedStageList_[var_2_0][iter_2_6] = {}

			for iter_2_7 = 1, 3 do
				if arg_2_1.info.clear_list[var_2_3] == 1 then
					table.insert(self.completedStageList_[var_2_0][iter_2_6], ActivitySoloChallengeCfg[var_2_0].stage_id[iter_2_6][2][iter_2_7])
				end

				var_2_3 = var_2_3 + 1
			end
		end
	end

	self:RefreshRedPoint(var_2_0)
end

function var_0_0:InitAffixState(arg_3_1)
	self.customAffixList_[arg_3_1] = {}
	self.affixStateList_[arg_3_1] = {}

	for iter_3_0, iter_3_1 in ipairs(ActivitySoloChallengeCfg[arg_3_1].stage_id) do
		self.affixStateList_[arg_3_1][iter_3_0] = {}

		local var_3_0 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(iter_3_1[1])

		for iter_3_2, iter_3_3 in ipairs(iter_3_1[2]) do
			for iter_3_4, iter_3_5 in ipairs((var_3_0:GetAffixList(iter_3_2))) do
				if iter_3_5 ~= 0 then
					self.customAffixList_[arg_3_1] = self.customAffixList_[arg_3_1] or {}
					self.customAffixList_[arg_3_1][iter_3_3] = self.customAffixList_[arg_3_1][iter_3_3] or {}
					self.customAffixList_[arg_3_1][iter_3_3][iter_3_4] = iter_3_5
					self.affixStateList_[arg_3_1][iter_3_0][iter_3_5] = self.affixStateList_[arg_3_1][iter_3_0][iter_3_5] or {}
					self.affixStateList_[arg_3_1][iter_3_0][iter_3_5].stageID = iter_3_3
					self.affixStateList_[arg_3_1][iter_3_0][iter_3_5].pos = iter_3_4
				end
			end
		end
	end

	self.InitedAffixState_[arg_3_1] = true
end

function var_0_0:EquipAffix(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if not self.InitedAffixState_[arg_4_1] then
		self:InitAffixState(arg_4_1)
	end

	local var_4_0 = self:GetSelectedDifficultyIndex(arg_4_1)

	self.customAffixList_[arg_4_1] = self.customAffixList_[arg_4_1] or {}
	self.customAffixList_[arg_4_1][arg_4_2] = self.customAffixList_[arg_4_1][arg_4_2] or {}
	self.customAffixList_[arg_4_1][arg_4_2][arg_4_3] = arg_4_4
	self.affixStateList_[arg_4_1] = self.affixStateList_[arg_4_1] or {}
	self.affixStateList_[arg_4_1][var_4_0] = self.affixStateList_[arg_4_1][var_4_0] or {}
	self.affixStateList_[arg_4_1][var_4_0][arg_4_4] = self.affixStateList_[arg_4_1][var_4_0][arg_4_4] or {}
	self.affixStateList_[arg_4_1][var_4_0][arg_4_4].stageID = arg_4_2
	self.affixStateList_[arg_4_1][var_4_0][arg_4_4].pos = arg_4_3
end

function var_0_0:DischargeAffix(arg_5_1, arg_5_2)
	if not self.InitedAffixState_[arg_5_1] then
		self:InitAffixState(arg_5_1)
	end

	local var_5_0 = self:GetSelectedDifficultyIndex(arg_5_1)

	if self.affixStateList_[arg_5_1] and self.affixStateList_[arg_5_1][var_5_0] and self.affixStateList_[arg_5_1][var_5_0][arg_5_2] then
		self.customAffixList_[arg_5_1][self.affixStateList_[arg_5_1][var_5_0][arg_5_2].stageID][self.affixStateList_[arg_5_1][var_5_0][arg_5_2].pos] = nil
		self.affixStateList_[arg_5_1][var_5_0][arg_5_2].stageID = nil
		self.affixStateList_[arg_5_1][var_5_0][arg_5_2].pos = nil
		self.affixStateList_[arg_5_1][var_5_0][arg_5_2] = nil
	end
end

function var_0_0:GetAffixState(arg_6_1, arg_6_2)
	if not self.InitedAffixState_[arg_6_1] then
		self:InitAffixState(arg_6_1)
	end

	local var_6_0 = self:GetSelectedDifficultyIndex(arg_6_1)

	if self.affixStateList_[arg_6_1] == nil or self.affixStateList_[arg_6_1][var_6_0] == nil or self.affixStateList_[arg_6_1][var_6_0][arg_6_2] == nil then
		return {
			stageID = -1,
			pos = -1
		}
	end

	return {
		stageID = self.affixStateList_[arg_6_1][var_6_0][arg_6_2].stageID,
		pos = self.affixStateList_[arg_6_1][var_6_0][arg_6_2].pos
	}
end

function var_0_0:GetAffixCount(arg_7_1, arg_7_2)
	if self.customAffixList_[arg_7_1] and self.customAffixList_[arg_7_1][arg_7_2] then
		return table.nums(self.customAffixList_[arg_7_1][arg_7_2])
	end

	return 0
end

function var_0_0:GetNextEquipPos(arg_8_1, arg_8_2)
	if self.customAffixList_[arg_8_1] and self.customAffixList_[arg_8_1][arg_8_2] then
		for iter_8_0 = 1, self:GetMaxAffixCount(arg_8_1) do
			if self.customAffixList_[arg_8_1][arg_8_2][iter_8_0] == nil then
				return iter_8_0
			end
		end
	end

	return -1
end

function var_0_0:CanEquipAffix(arg_9_1, arg_9_2)
	return self:GetAffixCount(arg_9_1, arg_9_2) < self:GetMaxAffixCount(arg_9_1)
end

function var_0_0:GetCustomAffixList(arg_10_1, arg_10_2)
	local var_10_0 = {}

	if self.customAffixList_[arg_10_1] ~= nil then
		for iter_10_0 = 1, self:GetMaxAffixCount(arg_10_1) do
			if self.customAffixList_[arg_10_1][arg_10_2] and self.customAffixList_[arg_10_1][arg_10_2][iter_10_0] then
				var_10_0[iter_10_0] = self.customAffixList_[arg_10_1][arg_10_2][iter_10_0]
			end
		end
	end

	return var_10_0
end

function var_0_0.GetMaxAffixCount(arg_11_0, arg_11_1)
	local var_11_0 = 2

	var_11_0 = ActivitySoloChallengeCfg[arg_11_1] ~= nil and ActivitySoloChallengeCfg[arg_11_1].max_affix_count or var_11_0

	return var_11_0
end

function var_0_0:SaveActivityID(arg_12_1, arg_12_2)
	if self.stageIDToActivityID_[arg_12_2] == nil then
		self.stageIDToActivityID_[arg_12_2] = {}
	end

	self.stageIDToActivityID_[arg_12_2].activityID = arg_12_1
end

function var_0_0:GetActivityID(arg_13_1)
	return self.stageIDToActivityID_[arg_13_1].activityID
end

function var_0_0:SaveDifficultyIndex(arg_14_1, arg_14_2)
	if self.stageIDToActivityID_[arg_14_2] == nil then
		self.stageIDToActivityID_[arg_14_2] = {}
	end

	self.stageIDToActivityID_[arg_14_2].difficultyIndex = arg_14_1
end

function var_0_0:GetDifficultyIndex(arg_15_1)
	return self.stageIDToActivityID_[arg_15_1].difficultyIndex
end

function var_0_0:GetCompletedStageList(arg_16_1)
	return self.completedStageList_[arg_16_1] or {}
end

function var_0_0:GetCompletedStageCount(arg_17_1)
	return #self:GetCompletedStageList(arg_17_1)
end

function var_0_0:GetCompletedActivityList()
	return self.completedActivityList_
end

function var_0_0:SetCompletedActivityList(arg_19_1, arg_19_2, arg_19_3)
	if self.completedActivityList_[arg_19_1] == nil then
		self.completedActivityList_[arg_19_1] = {}
	end

	if table.keyof(self.completedActivityList_[arg_19_1], arg_19_2) == nil then
		table.insert(self.completedActivityList_[arg_19_1], arg_19_2)
	end

	table.removebyvalue(self.uncompletedActivityList_, arg_19_1)

	if arg_19_3 ~= false then
		self:RefreshRedPoint(arg_19_1)
	end
end

function var_0_0:GetReceivedActivityList()
	return self.receivedActivityList_
end

function var_0_0:SetReceivedActivityList(arg_21_1, arg_21_2, arg_21_3)
	if self.receivedActivityList_[arg_21_1] == nil then
		self.receivedActivityList_[arg_21_1] = {}
	end

	if table.keyof(self.receivedActivityList_[arg_21_1], arg_21_2) == nil then
		table.insert(self.receivedActivityList_[arg_21_1], arg_21_2)
	end

	if arg_21_3 ~= false then
		self:RefreshRedPoint(arg_21_1)
	end
end

function var_0_0:SetSelectActivityID(arg_22_1, arg_22_2)
	saveData("SoloChallenge", "selectActivityID_" .. arg_22_1, arg_22_2)

	if table.keyof(self.uncompletedActivityList_, arg_22_2) then
		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, ActivitySoloChallengeCfg[arg_22_2].main_activity_id, arg_22_2), 0)
	end
end

function var_0_0.GetSelectActivityID(arg_23_0, arg_23_1)
	return getData("SoloChallenge", "selectActivityID_" .. arg_23_1)
end

function var_0_0:GetActivityTeamData(arg_24_1)
	local var_24_0 = self:GetSelectedDifficultyIndex(arg_24_1)
	local var_24_1 = table.nums(self.completedStageList_[arg_24_1][var_24_0])
	local var_24_2 = {
		before_solo_info = {}
	}
	local var_24_3, var_24_4 = self:GetCustomHeroList(arg_24_1, var_24_0)

	for iter_24_0, iter_24_1 in ipairs(ActivitySoloChallengeCfg[arg_24_1].stage_id[self:GetSelectedDifficultyIndex(arg_24_1)][2]) do
		if var_24_1 < iter_24_0 then
			local var_24_7 = {
				challenge_id = arg_24_1,
				stage_id = iter_24_1
			}

			if var_24_4[iter_24_0] ~= 0 then
				var_24_7.hero_id = var_24_4[iter_24_0]
			end

			local var_24_8
			local var_24_9

			do
				var_24_7.hero_id = var_24_3[iter_24_0]
				var_24_8 = self:GetCustomAffixList(arg_24_1, iter_24_1)
				var_24_9 = {}
			end

			for iter_24_2 = 1, self:GetMaxAffixCount(arg_24_1) do
				var_24_9[iter_24_2] = var_24_8[iter_24_2] ~= nil and var_24_8[iter_24_2] or 0
			end

			var_24_7.artifact = var_24_9
			var_24_2.before_solo_info[#var_24_2.before_solo_info + 1] = var_24_7
		end
	end

	return var_24_2
end

function var_0_0:ResetLockData(arg_25_1)
	self.completedStageList_[arg_25_1][self:GetSelectedDifficultyIndex(arg_25_1)] = {}
end

function var_0_0:RefreshRedPoint(arg_26_1)
	local var_26_0 = ActivitySoloChallengeCfg[arg_26_1].main_activity_id
	local var_26_1

	if #self.completedActivityList_[arg_26_1] == 0 then
		var_26_1 = 1
	else
		for iter_26_0, iter_26_1 in pairs(self.completedActivityList_[arg_26_1]) do
			var_26_1 = table.keyof(self.receivedActivityList_[arg_26_1], iter_26_1) == nil and 1 or 0

			if var_26_1 == 1 then
				break
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, var_26_0, arg_26_1), var_26_1)
end

function var_0_0.SetSelectedDifficultyIndex(arg_27_0, arg_27_1, arg_27_2)
	saveData("SoloChallenge", "selectDifficultyIndex_" .. arg_27_1, arg_27_2)
end

function var_0_0.GetSelectedDifficultyIndex(arg_28_0, arg_28_1)
	return getData("SoloChallenge", "selectDifficultyIndex_" .. arg_28_1)
end

function var_0_0.SetContentPosX(arg_29_0, arg_29_1, arg_29_2)
	saveData("SoloChallenge", "contentPosX" .. arg_29_1, arg_29_2)
end

function var_0_0.GetContentPosX(arg_30_0, arg_30_1)
	return getData("SoloChallenge", "contentPosX" .. arg_30_1)
end

function var_0_0:SaveLocalCustomList(arg_31_1)
	local var_31_0 = self:GetSelectedDifficultyIndex(arg_31_1)
	local var_31_1 = {}
	local var_31_2, var_31_3 = self:GetCustomHeroList(arg_31_1, var_31_0)

	for iter_31_0, iter_31_1 in ipairs(ActivitySoloChallengeCfg[arg_31_1].stage_id[var_31_0][2]) do
		local var_31_6 = {}

		if var_31_3[iter_31_0] ~= 0 then
			var_31_6.hero_Id = var_31_3[iter_31_0]
		end

		local var_31_8
		local var_31_7

		do
			var_31_6.hero_Id = var_31_2[iter_31_0]
			var_31_7 = self:GetCustomAffixList(arg_31_1, iter_31_1)
			var_31_8 = {}
		end

		for iter_31_2 = 1, self:GetMaxAffixCount(arg_31_1) do
			var_31_8[iter_31_2] = var_31_7[iter_31_2] ~= nil and var_31_7[iter_31_2] or 0
		end

		var_31_6.artifact = var_31_8

		table.insert(var_31_1, var_31_6)
	end

	var_0_1 = var_31_1

	saveData("SoloChallenge", "CustomList", var_31_1)
end

function var_0_0.GetLocalCustom(arg_32_0)
	if var_0_1 == nil then
		var_0_1 = getData("SoloChallenge", "CustomList")
	end

	return var_0_1
end

function var_0_0.GetLocalCustomHeroList(arg_33_0)
	if var_0_1 == nil then
		var_0_1 = getData("SoloChallenge", "CustomList")
	end

	if var_0_1 then
		local var_33_0 = {}
		local var_33_1 = {}

		for iter_33_0 = 1, 3 do
			local var_33_2 = 0
			local var_33_3 = 0

			if var_0_1[iter_33_0] then
				if HeroStandardSystemCfg[var_0_1[iter_33_0].hero_Id] == nil then
					var_33_2 = var_0_1[iter_33_0].hero_Id
				else
					var_33_2 = HeroStandardSystemCfg[var_0_1[iter_33_0].hero_Id].hero_id
					var_33_3 = var_0_1[iter_33_0].hero_Id
				end
			end

			table.insert(var_33_0, var_33_2)
			table.insert(var_33_1, var_33_3)
		end

		return var_33_0, var_33_1
	end

	return {}
end

function var_0_0.GetLocalCustomAffix(arg_34_0, arg_34_1)
	if var_0_1 == nil then
		var_0_1 = getData("SoloChallenge", "CustomList")
	end

	if var_0_1 then
		local var_34_0 = {}

		if var_0_1[arg_34_1] then
			for iter_34_0, iter_34_1 in ipairs(var_0_1[arg_34_1].artifact) do
				if iter_34_1 and iter_34_1 ~= 0 then
					var_34_0[iter_34_0] = iter_34_1
				end
			end
		end

		return var_34_0
	end

	return {}
end

return var_0_0
