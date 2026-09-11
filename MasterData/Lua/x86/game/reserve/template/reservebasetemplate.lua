local ReserveBaseTemplate = class("ReserveBaseTemplate")

function ReserveBaseTemplate:Ctor(arg_1_1)
	self.team_type = arg_1_1 or ReserveConst.RESERVE_TYPE.DEFAULT
	self.cont_teams = {}
	self.cont_dic = {}
end

function ReserveBaseTemplate:UpdateServerData(arg_2_1)
	self.team_type = arg_2_1.team_type

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.cont_teams) do
		self:GetContDataTemplateById(iter_2_1.cont_id):UpdateServerData(iter_2_1)
	end
end

function ReserveBaseTemplate:GetTeamType()
	return self.team_type
end

function ReserveBaseTemplate:SetHeroList(arg_4_1, arg_4_2, arg_4_3)
	self:GetContDataTemplateById(arg_4_1.contID):SetHeroList(arg_4_2, arg_4_3, arg_4_1.teamIndex)
end

function ReserveBaseTemplate:GetHeroList(arg_5_1)
	local var_5_0 = {
		isInVaild = false,
		resultHeroList = {
			0,
			0,
			0
		},
		lockStateList = {
			false,
			false,
			false
		},
		lockHeroList = {},
		resultTrialList = {
			0,
			0,
			0
		}
	}

	if arg_5_1.reserveType ~= ReserveConst.RESERVE_TYPE.NOT_NEED_RESERVE then
		self:FormatHeroList(arg_5_1, var_5_0, (self:GetContDataTemplateById(arg_5_1.contID):GetHeroList(arg_5_1.teamIndex)))

		if arg_5_1.needDefaultTeam and self:IsEmptyTeam(var_5_0) then
			self:FillDefaultTeam(arg_5_1, var_5_0)
		end
	end

	self:FilterInvalidTeamData(arg_5_1, var_5_0)
	self:GetLockHero(arg_5_1, var_5_0)
	self:FilterLockHero(arg_5_1, var_5_0)
	self:ReorderHeroList(arg_5_1, var_5_0)

	return var_5_0.resultHeroList, var_5_0.lockStateList, var_5_0.lockHeroList, var_5_0.resultTrialList, var_5_0.isInVaild
end

function ReserveBaseTemplate:FormatHeroList(arg_6_1, arg_6_2, arg_6_3)
	for iter_6_0, iter_6_1 in ipairs(arg_6_3) do
		arg_6_2.resultHeroList[iter_6_0] = iter_6_1:GetHeroID()
		arg_6_2.resultTrialList[iter_6_0] = iter_6_1:GetTrialID()
	end
end

function ReserveBaseTemplate:IsEmptyTeam(arg_7_1)
	return SectionSelectHeroTools.IsEmptyTeam(arg_7_1.resultHeroList)
end

function ReserveBaseTemplate:ResetHeroInTeamAtPos(arg_8_1, arg_8_2)
	arg_8_1.resultTrialList[arg_8_2] = 0
	arg_8_1.resultHeroList[arg_8_2] = 0
	arg_8_1.isInVaild = true
end

function ReserveBaseTemplate:IsTrialHeroAvailable(arg_9_1, arg_9_2)
	return table.keyof(self:GetTrialHeroList(arg_9_1), arg_9_2)
end

function ReserveBaseTemplate:FilterInvalidTeamData(arg_10_1, arg_10_2)
	local var_10_0, var_10_1 = SectionSelectHeroTools.GetRestrictHeroList(arg_10_1.stageType, arg_10_1.stageID)
	local var_10_2, var_10_3 = SectionSelectHeroTools.GetRestrictHeroPosDic(arg_10_1.stageType, arg_10_1.stageID)
	local var_10_4 = self:GetContDataTemplateById(arg_10_1.contID):GetHeroList(arg_10_1.teamIndex)

	for iter_10_0, iter_10_1 in ipairs(arg_10_2.resultTrialList) do
		if iter_10_1 ~= 0 then
			if var_10_0[iter_10_0][1] ~= nil then
				if var_10_1[iter_10_0] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID and (not var_10_3[iter_10_1] or var_10_3[iter_10_1] ~= iter_10_0) then
					self:ResetHeroInTeamAtPos(arg_10_2, iter_10_0)
				end
			elseif not self:IsTrialHeroAvailable(arg_10_1, iter_10_1) then
				self:ResetHeroInTeamAtPos(arg_10_2, iter_10_0)
			end
		end
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_2.resultHeroList) do
		if iter_10_3 ~= 0 and HeroTools.NeedToHideHero(var_10_4[iter_10_2].hero_id, var_10_4[iter_10_2].hero_type) then
			self:ResetHeroInTeamAtPos(arg_10_2, iter_10_2)
		end
	end
end

function ReserveBaseTemplate:GetLockHero(arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_4, var_11_5 = SectionSelectHeroTools.GetRestrictHeroList(arg_11_1.stageType, arg_11_1.stageID)
	local var_11_6

	if arg_11_1.stageType and arg_11_1.stageID and arg_11_1.stageID ~= 0 then
		local var_11_7 = BattleStageTools.GetStageCfg(arg_11_1.stageType, arg_11_1.stageID)

		var_11_6 = var_11_7.auto_next_stage_group and var_11_7.auto_next_stage_group > 0
	end

	local var_11_8 = SectionSelectHeroTools.GetRestrictHeroPosDic(arg_11_1.stageType, arg_11_1.stageID)

	for iter_11_0 = 1, 3 do
		if var_11_4[iter_11_0][1] then
			if var_11_4[iter_11_0][1] ~= 0 then
				if not var_11_6 and var_11_5[iter_11_0] and var_11_5[iter_11_0] == ReserveConst.CAN_SWITCH_RESTRICT_HERO then
					if arg_11_2.resultHeroList[iter_11_0] == 0 or not var_11_8[arg_11_2.resultHeroList[iter_11_0]] or var_11_8[arg_11_2.resultHeroList[iter_11_0]] ~= iter_11_0 then
						var_11_0[iter_11_0] = var_11_4[iter_11_0][1]
						var_11_1[iter_11_0] = var_11_4[iter_11_0][2]
					else
						var_11_0[iter_11_0] = arg_11_2.resultHeroList[iter_11_0]
						var_11_1[iter_11_0] = arg_11_2.resultTrialList[iter_11_0]
					end
				else
					var_11_0[iter_11_0] = var_11_4[iter_11_0][1]
					var_11_1[iter_11_0] = var_11_4[iter_11_0][2]
					arg_11_2.lockStateList[iter_11_0] = true
				end
			else
				var_11_0[iter_11_0] = 0
				var_11_1[iter_11_0] = 0
				arg_11_2.lockStateList[iter_11_0] = true
			end
		elseif var_11_8[arg_11_2.resultHeroList[iter_11_0]] and var_11_8[arg_11_2.resultHeroList[iter_11_0]] ~= iter_11_0 then
			var_11_0[iter_11_0] = 0
			var_11_1[iter_11_0] = 0
		else
			var_11_0[iter_11_0] = arg_11_2.resultHeroList[iter_11_0]
			var_11_1[iter_11_0] = arg_11_2.resultTrialList[iter_11_0]
		end
	end

	arg_11_2.resultHeroList = var_11_0
	arg_11_2.resultTrialList = var_11_1
end

function ReserveBaseTemplate:FilterLockHero(arg_12_1, arg_12_2)
	arg_12_1.filterLockHeroList = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_2.resultTrialList) do
		if iter_12_1 ~= 0 and table.keyof(arg_12_2.lockHeroList, iter_12_1) then
			table.insert(arg_12_1.filterLockHeroList, iter_12_1)

			arg_12_2.resultTrialList[iter_12_0] = 0
			arg_12_2.resultHeroList[iter_12_0] = 0
			arg_12_2.isInVaild = true
		end
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_2.resultHeroList) do
		if iter_12_3 ~= 0 and table.keyof(arg_12_2.lockHeroList, iter_12_3) then
			table.insert(arg_12_1.filterLockHeroList, iter_12_3)

			arg_12_2.resultHeroList[iter_12_2] = 0
			arg_12_2.isInVaild = true
		end
	end
end

function ReserveBaseTemplate:ReorderHeroList(arg_13_1, arg_13_2)
	if arg_13_2.isInVaild then
		local var_13_0, var_13_1 = SectionSelectHeroTools.GetRestrictHeroList(arg_13_1.stageType, arg_13_1.stageID)

		SectionSelectHeroTools.ReorderHeroTeam(arg_13_2.resultHeroList, arg_13_2.resultTrialList, var_13_1)
	end
end

function ReserveBaseTemplate:GetTrialHeroList(arg_14_1)
	return GetTrialHeroList(arg_14_1.stageType, arg_14_1.stageID, (arg_14_1.customData and arg_14_1.customData.activityID or nil) and arg_14_1.customData.activityID)
end

function ReserveBaseTemplate:FillDefaultTeam(arg_15_1, arg_15_2)
	local var_15_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.DEFAULT)

	self:GetDefaultTeam(arg_15_1, arg_15_2)

	local var_15_1 = ReserveTools.GetMimirID(var_15_0)
	local var_15_2 = ReserveTools.GetMimirChipList(var_15_0)

	if arg_15_1.reserveType == ReserveConst.RESERVE_TYPE.BOSS_CHALLENGE then
		if table.keyof(ChipData:GetUnlockChipManagerIDList(), var_15_1) then
			if type(var_15_2) == "table" and #var_15_2 > 0 then
				local var_15_3 = {}

				for iter_15_0, iter_15_1 in ipairs(var_15_2) do
					if ChipData:GetIsUnlockChip(iter_15_1) then
						table.insert(var_15_3, iter_15_1)
					end
				end

				var_15_2 = var_15_3
			end
		else
			var_15_1 = 0
			var_15_2 = {}
		end
	end

	ReserveTools.SetHeroList(arg_15_1, arg_15_2.resultHeroList, arg_15_2.resultTrialList)
	ReserveTools.SetComboSkillID(arg_15_1, (ReserveTools.GetComboSkillID(var_15_0)))
	ReserveTools.SetMimirID(arg_15_1, var_15_1)
	ReserveTools.SetMimirChipList(arg_15_1, var_15_2)
end

function ReserveBaseTemplate:GetDefaultTeam(arg_16_1, arg_16_2)
	arg_16_2.resultHeroList, arg_16_2.lockStateList, arg_16_2.lockHeroList, arg_16_2.resultTrialList, arg_16_2.isInVaild = ReserveTools.GetHeroList(ReserveParams.New(ReserveConst.RESERVE_TYPE.DEFAULT))
end

function ReserveBaseTemplate:GetAddedHeroIDList(arg_17_1)
	return self:GetContDataTemplateById(arg_17_1.contID):GetAddedHeroIDList(arg_17_1.teamIndex)
end

function ReserveBaseTemplate:GetComboSkillID(arg_18_1)
	local var_18_0 = self:GetConfigComboSkillID(arg_18_1)

	if var_18_0 then
		return var_18_0
	end

	return self:GetValidComboSkillID(arg_18_1)
end

function ReserveBaseTemplate:GetRawComboSkillID(arg_19_1)
	return self:GetContDataTemplateById(arg_19_1.contID):GetComboSkillID(arg_19_1.teamIndex)
end

function ReserveBaseTemplate:SetComboSkillID(arg_20_1, arg_20_2)
	self:GetContDataTemplateById(arg_20_1.contID):SetComboSkillID(arg_20_2, arg_20_1.teamIndex)
end

function ReserveBaseTemplate:GetValidComboSkillID(arg_21_1, arg_21_2)
	local var_21_0 = ReserveTools.GetRawComboSkillID(arg_21_1)
	local var_21_1 = arg_21_2 or ReserveTools.GetHeroList(arg_21_1)

	if not self:IsValidComboSKillID(var_21_0, var_21_1) then
		return ComboSkillTools.GetRecommendSkillID(var_21_1, true)
	end

	return var_21_0
end

function ReserveBaseTemplate:IsValidComboSKillID(arg_22_1, arg_22_2)
	if arg_22_1 ~= 0 and not ComboSkillTools.IsAllMatch(arg_22_1, arg_22_2 or {}) then
		return false
	end

	return true
end

function ReserveBaseTemplate:GetConfigComboSkillID(arg_23_1)
	if arg_23_1.stageID and arg_23_1.stageID ~= 0 then
		local var_23_0 = BattleStageTools.GetStageCfg(arg_23_1.stageType, arg_23_1.stageID)

		if var_23_0 and var_23_0.combo_skill_id and var_23_0.combo_skill_id ~= 0 then
			return var_23_0.combo_skill_id
		end

		if SectionSelectHeroTools.IsAllPosFullLock(arg_23_1.stageType, arg_23_1.stageID) then
			return ReserveConst.DEFAULT_COMBO_SKILL_ID
		end
	end

	return nil
end

function ReserveBaseTemplate:GetMimirData(arg_24_1)
	return self:GetMimirID(arg_24_1), (self:GetMimirChipList(arg_24_1))
end

function ReserveBaseTemplate:GetMimirID(arg_25_1)
	return self:GetContDataTemplateById(arg_25_1.contID):GetMimirID(arg_25_1.teamIndex)
end

function ReserveBaseTemplate:SetMimirID(arg_26_1, arg_26_2)
	self:GetContDataTemplateById(arg_26_1.contID):SetMimirID(arg_26_2, arg_26_1.teamIndex)
end

function ReserveBaseTemplate:GetMimirChipList(arg_27_1)
	return self:GetContDataTemplateById(arg_27_1.contID):GetMimirChipList(arg_27_1.teamIndex)
end

function ReserveBaseTemplate:SetMimirChipList(arg_28_1, arg_28_2)
	return self:GetContDataTemplateById(arg_28_1.contID):SetMimirChipList(arg_28_2, arg_28_1.teamIndex)
end

function ReserveBaseTemplate:ResetMimirChipList(arg_29_1)
	self:GetContDataTemplateById(arg_29_1.contID):ResetMimirChipList(arg_29_1.teamIndex)
end

function ReserveBaseTemplate:GetCharChipBaseID(arg_30_1)
	return self:GetContDataTemplateById(arg_30_1.contID):GetCharChipBaseID(arg_30_1.teamIndex)
end

function ReserveBaseTemplate:SetCharChipBaseID(arg_31_1, arg_31_2)
	return self:GetContDataTemplateById(arg_31_1.contID):SetCharChipBaseID(arg_31_2, arg_31_1.teamIndex)
end

function ReserveBaseTemplate:GetCharChipExtraIDList(arg_32_1, arg_32_2)
	return nil
end

function ReserveBaseTemplate:GetContDataTemplateById(arg_33_1)
	arg_33_1 = arg_33_1 or ReserveConst.DETAULT_CONT_ID

	if not self.cont_dic[arg_33_1] then
		self.cont_dic[arg_33_1] = self:GetContDataTemplateClass().New(self:GetTeamType(), arg_33_1)
		self.cont_teams[#self.cont_teams + 1] = self.cont_dic[arg_33_1]
	end

	return self.cont_dic[arg_33_1]
end

function ReserveBaseTemplate:GetSingleTeamData(arg_34_1)
	return (self:GetContDataTemplateById(arg_34_1.contID or ReserveTools.GetContID(arg_34_1.stageType, arg_34_1.stageID)):GetSingleTeamData(arg_34_1.teamIndex or self:GetTeamIndex(arg_34_1)))
end

function ReserveBaseTemplate:CopyContData(arg_35_1, arg_35_2)
	local var_35_0 = arg_35_2:Clone()

	var_35_0:SetContID(arg_35_1)

	for iter_35_0, iter_35_1 in ipairs(self.cont_teams) do
		if iter_35_1:GetContID() == arg_35_1 then
			self.cont_teams[iter_35_0] = var_35_0

			break
		end
	end

	self.cont_dic[arg_35_1] = var_35_0
end

function ReserveBaseTemplate:CleanCacheData()
	for iter_36_0, iter_36_1 in ipairs(self.cont_teams) do
		iter_36_1:CleanCacheData()
	end
end

function ReserveBaseTemplate:GetTeamIndex(arg_37_1)
	return ReserveConst.DEFAULT_TEAM_INDEX
end

function ReserveBaseTemplate:GetContDataTemplateClass()
	return ReserveTools.GetContDataClass(self:GetTeamType())
end

function ReserveBaseTemplate:Clone()
	return deepClone(self)
end

return ReserveBaseTemplate
