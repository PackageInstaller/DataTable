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

function var_0_0.SetData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.info
	local var_2_1 = ActivitySoloChallengeCfg[var_2_0.challenge_id].activity_id

	arg_2_0.completedActivityList_[var_2_1] = {}
	arg_2_0.receivedActivityList_[var_2_1] = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0.is_award_admited) do
		local var_2_2 = SoloChallengeTools.GetDifficultyIndex(iter_2_1)

		arg_2_0:SetReceivedActivityList(var_2_1, var_2_2, false)
	end

	local var_2_3 = false

	for iter_2_2, iter_2_3 in ipairs(var_2_0.is_clear) do
		local var_2_4 = SoloChallengeTools.GetDifficultyIndex(iter_2_3)

		arg_2_0:SetCompletedActivityList(var_2_1, var_2_4, false)

		var_2_3 = true
	end

	if not var_2_3 and not table.keyof(arg_2_0.uncompletedActivityList_, var_2_1) then
		table.insert(arg_2_0.uncompletedActivityList_, var_2_1)
	end

	local var_2_5 = var_2_0.select_difficult or 1
	local var_2_6 = ActivitySoloChallengeCfg[var_2_0.challenge_id].stage_id

	for iter_2_4, iter_2_5 in ipairs(var_2_6) do
		if iter_2_5[1] == var_2_5 then
			arg_2_0:SetSelectedDifficultyIndex(var_2_1, iter_2_4)
		end
	end

	arg_2_0.completedStageList_[var_2_1] = arg_2_0.completedStageList_[var_2_1] or {}

	if var_2_0.solo_info ~= nil then
		local var_2_7 = #ActivitySoloChallengeCfg[var_2_1].stage_id
		local var_2_8 = 1

		for iter_2_6 = 1, var_2_7 do
			arg_2_0.completedStageList_[var_2_1][iter_2_6] = {}

			for iter_2_7 = 1, 3 do
				local var_2_9 = ActivitySoloChallengeCfg[var_2_1].stage_id[iter_2_6][2][iter_2_7]

				if var_2_0.clear_list[var_2_8] == 1 then
					table.insert(arg_2_0.completedStageList_[var_2_1][iter_2_6], var_2_9)
				end

				var_2_8 = var_2_8 + 1
			end
		end
	end

	arg_2_0:RefreshRedPoint(var_2_1)
end

function var_0_0.InitAffixState(arg_3_0, arg_3_1)
	local var_3_0 = ActivitySoloChallengeCfg[arg_3_1]

	arg_3_0.customAffixList_[arg_3_1] = {}
	arg_3_0.affixStateList_[arg_3_1] = {}

	local var_3_1 = var_3_0.stage_id

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		arg_3_0.affixStateList_[arg_3_1][iter_3_0] = {}

		local var_3_2 = iter_3_1[1]
		local var_3_3 = iter_3_1[2]
		local var_3_4 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(var_3_2)

		for iter_3_2, iter_3_3 in ipairs(var_3_3) do
			local var_3_5 = var_3_4:GetAffixList(iter_3_2)

			for iter_3_4, iter_3_5 in ipairs(var_3_5) do
				if iter_3_5 ~= 0 then
					arg_3_0.customAffixList_[arg_3_1] = arg_3_0.customAffixList_[arg_3_1] or {}
					arg_3_0.customAffixList_[arg_3_1][iter_3_3] = arg_3_0.customAffixList_[arg_3_1][iter_3_3] or {}
					arg_3_0.customAffixList_[arg_3_1][iter_3_3][iter_3_4] = iter_3_5
					arg_3_0.affixStateList_[arg_3_1][iter_3_0][iter_3_5] = arg_3_0.affixStateList_[arg_3_1][iter_3_0][iter_3_5] or {}
					arg_3_0.affixStateList_[arg_3_1][iter_3_0][iter_3_5].stageID = iter_3_3
					arg_3_0.affixStateList_[arg_3_1][iter_3_0][iter_3_5].pos = iter_3_4
				end
			end
		end
	end

	arg_3_0.InitedAffixState_[arg_3_1] = true
end

function var_0_0.EquipAffix(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if not arg_4_0.InitedAffixState_[arg_4_1] then
		arg_4_0:InitAffixState(arg_4_1)
	end

	local var_4_0 = arg_4_0:GetSelectedDifficultyIndex(arg_4_1)

	arg_4_0.customAffixList_[arg_4_1] = arg_4_0.customAffixList_[arg_4_1] or {}
	arg_4_0.customAffixList_[arg_4_1][arg_4_2] = arg_4_0.customAffixList_[arg_4_1][arg_4_2] or {}
	arg_4_0.customAffixList_[arg_4_1][arg_4_2][arg_4_3] = arg_4_4
	arg_4_0.affixStateList_[arg_4_1] = arg_4_0.affixStateList_[arg_4_1] or {}
	arg_4_0.affixStateList_[arg_4_1][var_4_0] = arg_4_0.affixStateList_[arg_4_1][var_4_0] or {}
	arg_4_0.affixStateList_[arg_4_1][var_4_0][arg_4_4] = arg_4_0.affixStateList_[arg_4_1][var_4_0][arg_4_4] or {}
	arg_4_0.affixStateList_[arg_4_1][var_4_0][arg_4_4].stageID = arg_4_2
	arg_4_0.affixStateList_[arg_4_1][var_4_0][arg_4_4].pos = arg_4_3
end

function var_0_0.DischargeAffix(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.InitedAffixState_[arg_5_1] then
		arg_5_0:InitAffixState(arg_5_1)
	end

	local var_5_0 = arg_5_0:GetSelectedDifficultyIndex(arg_5_1)

	if arg_5_0.affixStateList_[arg_5_1] and arg_5_0.affixStateList_[arg_5_1][var_5_0] and arg_5_0.affixStateList_[arg_5_1][var_5_0][arg_5_2] then
		local var_5_1 = arg_5_0.affixStateList_[arg_5_1][var_5_0][arg_5_2].stageID
		local var_5_2 = arg_5_0.affixStateList_[arg_5_1][var_5_0][arg_5_2].pos

		arg_5_0.customAffixList_[arg_5_1][var_5_1][var_5_2] = nil
		arg_5_0.affixStateList_[arg_5_1][var_5_0][arg_5_2].stageID = nil
		arg_5_0.affixStateList_[arg_5_1][var_5_0][arg_5_2].pos = nil
		arg_5_0.affixStateList_[arg_5_1][var_5_0][arg_5_2] = nil
	end
end

function var_0_0.GetAffixState(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.InitedAffixState_[arg_6_1] then
		arg_6_0:InitAffixState(arg_6_1)
	end

	local var_6_0 = arg_6_0:GetSelectedDifficultyIndex(arg_6_1)

	if arg_6_0.affixStateList_[arg_6_1] == nil or arg_6_0.affixStateList_[arg_6_1][var_6_0] == nil or arg_6_0.affixStateList_[arg_6_1][var_6_0][arg_6_2] == nil then
		return {
			stageID = -1,
			pos = -1
		}
	end

	return {
		stageID = arg_6_0.affixStateList_[arg_6_1][var_6_0][arg_6_2].stageID,
		pos = arg_6_0.affixStateList_[arg_6_1][var_6_0][arg_6_2].pos
	}
end

function var_0_0.GetAffixCount(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.customAffixList_[arg_7_1] and arg_7_0.customAffixList_[arg_7_1][arg_7_2] then
		local var_7_0 = arg_7_0.customAffixList_[arg_7_1][arg_7_2]

		return table.nums(var_7_0)
	end

	return 0
end

function var_0_0.GetNextEquipPos(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.customAffixList_[arg_8_1] and arg_8_0.customAffixList_[arg_8_1][arg_8_2] then
		for iter_8_0 = 1, arg_8_0:GetMaxAffixCount(arg_8_1) do
			if arg_8_0.customAffixList_[arg_8_1][arg_8_2][iter_8_0] == nil then
				return iter_8_0
			end
		end
	end

	return -1
end

function var_0_0.CanEquipAffix(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0:GetAffixCount(arg_9_1, arg_9_2) < arg_9_0:GetMaxAffixCount(arg_9_1)
end

function var_0_0.GetCustomAffixList(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	if arg_10_0.customAffixList_[arg_10_1] ~= nil then
		for iter_10_0 = 1, arg_10_0:GetMaxAffixCount(arg_10_1) do
			if arg_10_0.customAffixList_[arg_10_1][arg_10_2] and arg_10_0.customAffixList_[arg_10_1][arg_10_2][iter_10_0] then
				var_10_0[iter_10_0] = arg_10_0.customAffixList_[arg_10_1][arg_10_2][iter_10_0]
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

function var_0_0.SaveActivityID(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.stageIDToActivityID_[arg_12_2] == nil then
		arg_12_0.stageIDToActivityID_[arg_12_2] = {}
	end

	arg_12_0.stageIDToActivityID_[arg_12_2].activityID = arg_12_1
end

function var_0_0.GetActivityID(arg_13_0, arg_13_1)
	return arg_13_0.stageIDToActivityID_[arg_13_1].activityID
end

function var_0_0.SaveDifficultyIndex(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.stageIDToActivityID_[arg_14_2] == nil then
		arg_14_0.stageIDToActivityID_[arg_14_2] = {}
	end

	arg_14_0.stageIDToActivityID_[arg_14_2].difficultyIndex = arg_14_1
end

function var_0_0.GetDifficultyIndex(arg_15_0, arg_15_1)
	return arg_15_0.stageIDToActivityID_[arg_15_1].difficultyIndex
end

function var_0_0.GetCompletedStageList(arg_16_0, arg_16_1)
	return arg_16_0.completedStageList_[arg_16_1] or {}
end

function var_0_0.GetCompletedStageCount(arg_17_0, arg_17_1)
	return #arg_17_0:GetCompletedStageList(arg_17_1)
end

function var_0_0.GetCompletedActivityList(arg_18_0)
	return arg_18_0.completedActivityList_
end

function var_0_0.SetCompletedActivityList(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_0.completedActivityList_[arg_19_1] == nil then
		arg_19_0.completedActivityList_[arg_19_1] = {}
	end

	if table.keyof(arg_19_0.completedActivityList_[arg_19_1], arg_19_2) == nil then
		table.insert(arg_19_0.completedActivityList_[arg_19_1], arg_19_2)
	end

	table.removebyvalue(arg_19_0.uncompletedActivityList_, arg_19_1)

	if arg_19_3 ~= false then
		arg_19_0:RefreshRedPoint(arg_19_1)
	end
end

function var_0_0.GetReceivedActivityList(arg_20_0)
	return arg_20_0.receivedActivityList_
end

function var_0_0.SetReceivedActivityList(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_0.receivedActivityList_[arg_21_1] == nil then
		arg_21_0.receivedActivityList_[arg_21_1] = {}
	end

	if table.keyof(arg_21_0.receivedActivityList_[arg_21_1], arg_21_2) == nil then
		table.insert(arg_21_0.receivedActivityList_[arg_21_1], arg_21_2)
	end

	if arg_21_3 ~= false then
		arg_21_0:RefreshRedPoint(arg_21_1)
	end
end

function var_0_0.SetSelectActivityID(arg_22_0, arg_22_1, arg_22_2)
	saveData("SoloChallenge", "selectActivityID_" .. arg_22_1, arg_22_2)

	if table.keyof(arg_22_0.uncompletedActivityList_, arg_22_2) then
		local var_22_0 = ActivitySoloChallengeCfg[arg_22_2].main_activity_id

		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, var_22_0, arg_22_2), 0)
	end
end

function var_0_0.GetSelectActivityID(arg_23_0, arg_23_1)
	return getData("SoloChallenge", "selectActivityID_" .. arg_23_1)
end

function var_0_0.GetActivityTeamData(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:GetSelectedDifficultyIndex(arg_24_1)
	local var_24_1 = table.nums(arg_24_0.completedStageList_[arg_24_1][var_24_0])
	local var_24_2 = {
		before_solo_info = {}
	}
	local var_24_3, var_24_4 = arg_24_0:GetCustomHeroList(arg_24_1, var_24_0)
	local var_24_5 = arg_24_0:GetSelectedDifficultyIndex(arg_24_1)
	local var_24_6 = ActivitySoloChallengeCfg[arg_24_1].stage_id[var_24_5][2]
	local var_24_7 = 0
	local var_24_8 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_6) do
		if var_24_1 < iter_24_0 then
			local var_24_9 = {
				challenge_id = arg_24_1,
				stage_id = iter_24_1
			}

			if var_24_4[iter_24_0] ~= 0 then
				var_24_9.hero_id = var_24_4[iter_24_0]
			else
				var_24_9.hero_id = var_24_3[iter_24_0]
			end

			local var_24_10 = arg_24_0:GetMaxAffixCount(arg_24_1)
			local var_24_11 = arg_24_0:GetCustomAffixList(arg_24_1, iter_24_1)
			local var_24_12 = {}

			for iter_24_2 = 1, var_24_10 do
				if var_24_11[iter_24_2] ~= nil then
					var_24_12[iter_24_2] = var_24_11[iter_24_2]
				else
					var_24_12[iter_24_2] = 0
				end
			end

			var_24_9.artifact = var_24_12
			var_24_2.before_solo_info[#var_24_2.before_solo_info + 1] = var_24_9
		end
	end

	return var_24_2
end

function var_0_0.ResetLockData(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:GetSelectedDifficultyIndex(arg_25_1)

	arg_25_0.completedStageList_[arg_25_1][var_25_0] = {}
end

function var_0_0.RefreshRedPoint(arg_26_0, arg_26_1)
	local var_26_0 = ActivitySoloChallengeCfg[arg_26_1].main_activity_id
	local var_26_1 = arg_26_0.completedActivityList_[arg_26_1]
	local var_26_2 = arg_26_0.receivedActivityList_[arg_26_1]
	local var_26_3

	if #var_26_1 == 0 then
		var_26_3 = 1
	else
		for iter_26_0, iter_26_1 in pairs(var_26_1) do
			var_26_3 = table.keyof(var_26_2, iter_26_1) == nil and 1 or 0

			if var_26_3 == 1 then
				break
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, var_26_0, arg_26_1), var_26_3)
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

function var_0_0.SaveLocalCustomList(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:GetSelectedDifficultyIndex(arg_31_1)
	local var_31_1 = {}
	local var_31_2, var_31_3 = arg_31_0:GetCustomHeroList(arg_31_1, var_31_0)
	local var_31_4 = ActivitySoloChallengeCfg[arg_31_1].stage_id[var_31_0][2]
	local var_31_5 = 0
	local var_31_6 = {}

	for iter_31_0, iter_31_1 in ipairs(var_31_4) do
		local var_31_7 = {}

		if var_31_3[iter_31_0] ~= 0 then
			var_31_7.hero_Id = var_31_3[iter_31_0]
		else
			var_31_7.hero_Id = var_31_2[iter_31_0]
		end

		local var_31_8 = arg_31_0:GetMaxAffixCount(arg_31_1)
		local var_31_9 = arg_31_0:GetCustomAffixList(arg_31_1, iter_31_1)
		local var_31_10 = {}

		for iter_31_2 = 1, var_31_8 do
			if var_31_9[iter_31_2] ~= nil then
				var_31_10[iter_31_2] = var_31_9[iter_31_2]
			else
				var_31_10[iter_31_2] = 0
			end
		end

		var_31_7.artifact = var_31_10

		table.insert(var_31_1, var_31_7)
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
			local var_33_2 = var_0_1[iter_33_0]
			local var_33_3 = 0
			local var_33_4 = 0

			if var_33_2 then
				local var_33_5 = HeroStandardSystemCfg[var_33_2.hero_Id]

				if var_33_5 == nil then
					var_33_3 = var_33_2.hero_Id
				else
					var_33_3 = var_33_5.hero_id
					var_33_4 = var_33_2.hero_Id
				end
			end

			table.insert(var_33_0, var_33_3)
			table.insert(var_33_1, var_33_4)
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
		local var_34_0 = var_0_1[arg_34_1]
		local var_34_1 = {}

		if var_34_0 then
			for iter_34_0, iter_34_1 in ipairs(var_34_0.artifact) do
				if iter_34_1 and iter_34_1 ~= 0 then
					var_34_1[iter_34_0] = iter_34_1
				end
			end
		end

		return var_34_1
	end

	return {}
end

return var_0_0
