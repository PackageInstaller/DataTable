local var_0_0 = {}

function var_0_0.InitCache()
	if var_0_0.selectedActivityId_ then
		var_0_0.selectedActivityId_ = nil
	end

	var_0_0.templateCache_ = nil
	var_0_0.allActivityIds_ = nil
	var_0_0.allRankActivityIds_ = nil
	var_0_0.lastRankActivityIds_ = nil
end

function var_0_0.UpdateActivityCache()
	if var_0_0.templateCache_ then
		return
	end

	var_0_0.templateCache_ = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_0.GetAllActivityIds()) do
		if ActivityData:GetActivityIsOpen(iter_2_1) then
			local var_2_0 = ActivityTools.GetActivityType(iter_2_1)
			local var_2_1 = ActivityCfg[iter_2_1].sub_activity_list[1]

			var_0_0.templateCache_[var_2_0] = {
				activityId = iter_2_1,
				rankActivityId = var_2_1,
				stageActivityId = ActivityCfg[iter_2_1].sub_activity_list[2]
			}
		end
	end

	local var_2_2 = var_0_0.GetAllCoreVerificationChallengeMode()

	var_0_0.GetActivityId()

	for iter_2_2, iter_2_3 in ipairs(var_2_2) do
		if not var_0_0.templateCache_[iter_2_3] then
			for iter_2_4, iter_2_5 in ipairs(ActivityCfg.get_id_list_by_activity_template[iter_2_3]) do
				if ActivityData:GetActivityIsOpen(iter_2_5) then
					var_0_0.templateCache_[iter_2_3] = {
						activityId = iter_2_5,
						rankActivityId = ActivityCfg[iter_2_5].sub_activity_list[1],
						stageActivityId = ActivityCfg[iter_2_5].sub_activity_list[2]
					}

					if not var_0_0.selectedActivityId_ then
						var_0_0.selectedActivityId_ = iter_2_5
					end
				end
			end
		end
	end

	var_0_0.allRankActivityIds_ = {}
	var_0_0.lastRankActivityIds_ = {}

	for iter_2_6, iter_2_7 in pairs(var_0_0.templateCache_) do
		if not table.indexof(var_0_0.allRankActivityIds_, iter_2_7.rankActivityId) and table.indexof(var_0_0.GetAllActivityIds(), iter_2_7.activityId) then
			table.insert(var_0_0.allRankActivityIds_, iter_2_7.rankActivityId)

			for iter_2_8, iter_2_9 in ipairs(ActivityCfg[iter_2_7.rankActivityId].sub_activity_list) do
				if iter_2_9 and ActivityData:GetActivityIsOpen(iter_2_9) and not table.indexof(var_0_0.allRankActivityIds_, iter_2_9) then
					table.insert(var_0_0.allRankActivityIds_, iter_2_9)
					table.insert(var_0_0.lastRankActivityIds_, iter_2_9)
				end
			end
		else
			table.removebyvalue(var_0_0.lastRankActivityIds_, iter_2_7.rankActivityId)
		end
	end

	table.sort(var_0_0.allRankActivityIds_, function(arg_3_0, arg_3_1)
		return arg_3_1 < arg_3_0
	end)

	local var_2_3 = {}

	for iter_2_10, iter_2_11 in pairs(var_0_0.templateCache_) do
		table.insert(var_2_3, string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, iter_2_11.activityId))
	end

	manager.redPoint:addGroup(RedPointConst.CORE_VERIFICATION_REWARD5, var_2_3, true)
end

function var_0_0.GetAllActivityIds()
	if not var_0_0.allActivityIds_ then
		var_0_0.allActivityIds_ = {}

		for iter_4_0, iter_4_1 in ipairs(ActivityCfg[ActivityConst.CORE_VERIFICATION].sub_activity_list) do
			if ActivityData:GetActivityIsOpen(iter_4_1) then
				table.insert(var_0_0.allActivityIds_, iter_4_1)
			end
		end

		table.sort(var_0_0.allActivityIds_, function(arg_5_0, arg_5_1)
			local var_5_0 = ActivityData:GetActivityData(arg_5_0)
			local var_5_1 = ActivityData:GetActivityData(arg_5_1)

			if var_5_0.stopTime ~= var_5_1.stopTime then
				return var_5_0.stopTime < var_5_1.stopTime
			end

			return arg_5_0 < arg_5_1
		end)
	end

	return var_0_0.allActivityIds_
end

function var_0_0.GetAllRankActivityIds()
	var_0_0.UpdateActivityCache()

	return var_0_0.allRankActivityIds_ or {}
end

function var_0_0.IsLastRankActivity(arg_7_0)
	return table.indexof(var_0_0.lastRankActivityIds_, arg_7_0)
end

function var_0_0.GetAllCoreVerificationChallengeMode()
	return {
		ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1,
		ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2,
		ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3,
		ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4
	}
end

function var_0_0.GetModeActivityIdByRankId(arg_9_0)
	local var_9_0 = var_0_0.GetAllCoreVerificationChallengeMode()

	for iter_9_0, iter_9_1 in ipairs(ActivityCfg.get_id_list_by_sub_activity_list[arg_9_0]) do
		local var_9_1 = ActivityTools.GetActivityType(iter_9_1)

		for iter_9_2, iter_9_3 in ipairs(var_9_0) do
			if var_9_1 == iter_9_3 then
				return iter_9_1
			end
		end
	end

	return arg_9_0
end

function var_0_0.GetActivityId()
	if not var_0_0.selectedActivityId_ then
		local var_10_0 = var_0_0.GetAllActivityIds()

		if #var_10_0 == 0 then
			var_10_0 = ActivityCfg[ActivityConst.CORE_VERIFICATION].sub_activity_list
		end

		local var_10_1 = getData("CoreVerification", "click_time") or 0
		local var_10_2 = _G.gameTimer:GetNextDayFreshTime()
		local var_10_3 = getData("CoreVerification", "click_activity_id") or 0

		if var_10_2 > 0 and var_10_2 <= var_10_1 and var_10_3 and ActivityData:GetActivityIsOpen(var_10_3) and table.indexof(var_0_0.GetAllActivityIds(), var_10_3) then
			var_0_0.selectedActivityId_ = var_10_3
		else
			local var_10_4 = 0
			local var_10_5 = 0

			for iter_10_0, iter_10_1 in ipairs(var_10_0) do
				local var_10_6 = var_0_0.GetTaskInfoByType(iter_10_1, 1)
				local var_10_7 = 0

				for iter_10_2, iter_10_3 in ipairs(var_10_6) do
					if var_0_0.GetTaskStateById(iter_10_3, iter_10_1) == 0 then
						var_10_7 = var_10_7 + 1
					end
				end

				if var_10_5 < var_10_7 then
					var_10_5 = var_10_7
					var_10_4 = iter_10_1
				end
			end

			if var_10_4 > 0 then
				var_0_0.selectedActivityId_ = var_10_4
			end
		end

		if not var_0_0.selectedActivityId_ then
			var_0_0.selectedActivityId_ = var_10_0[1]
		end
	end

	return var_0_0.selectedActivityId_
end

function var_0_0.SetSelectedActivityId(arg_11_0)
	var_0_0.selectedActivityId_ = arg_11_0

	saveData("CoreVerification", "click_activity_id", arg_11_0)
end

function var_0_0.GetModeActivityId(arg_12_0)
	var_0_0.UpdateActivityCache()

	return nullable(var_0_0.templateCache_, arg_12_0, "activityId")
end

function var_0_0.GetModeRankActivityId(arg_13_0)
	var_0_0.UpdateActivityCache()

	return nullable(var_0_0.templateCache_, arg_13_0, "rankActivityId")
end

function var_0_0.GetModeStageActivityId(arg_14_0)
	var_0_0.UpdateActivityCache()

	return nullable(var_0_0.templateCache_, arg_14_0, "stageActivityId")
end

function var_0_0.GetModeIndex(arg_15_0)
	arg_15_0 = arg_15_0 or var_0_0.GetActivityId()

	local var_15_0 = ActivityTools.GetActivityType(arg_15_0)
	local var_15_1 = var_0_0.GetAllCoreVerificationChallengeMode()

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if var_15_0 == iter_15_1 then
			return iter_15_0
		end
	end

	return nil
end

function var_0_0.GetBattleStageType(arg_16_0)
	local var_16_0 = var_0_0.GetModeIndex(arg_16_0)

	if var_16_0 == 1 then
		return BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE
	elseif var_16_0 == 2 then
		return BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2
	elseif var_16_0 == 3 then
		return BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3
	elseif var_16_0 == 4 then
		return BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4
	end
end

function var_0_0.GetEnterViewUIName(arg_17_0)
	local var_17_0 = ActivityTools.GetActivityType(arg_17_0)

	if var_17_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1 then
		JumpTools.OpenPageByJump("/coreVerificationEnterStageView", {})
	elseif var_17_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2 then
		JumpTools.OpenPageByJump("/coreVerificationEnterStageViewMode2", {})
	elseif var_17_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3 then
		JumpTools.OpenPageByJump("/coreVerificationEnterStageViewMode3", {})
	elseif var_17_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4 then
		JumpTools.OpenPageByJump("/coreVerificationEnterStageViewMode4", {})
	end
end

function var_0_0.GetDataCls(arg_18_0)
	local var_18_0 = ActivityTools.GetActivityType(arg_18_0)

	if var_18_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1 then
		return CoreVerificationChallengeData
	elseif var_18_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2 then
		return CoreVerificationChallengeMode2Data
	elseif var_18_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3 then
		return CoreVerificationChallengeMode3Data
	elseif var_18_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4 then
		return CoreVerificationChallengeMode4Data
	end
end

function var_0_0.GetActionCls(arg_19_0)
	local var_19_0 = ActivityTools.GetActivityType(arg_19_0)

	if var_19_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1 then
		return CoreVerificationChallengeAction
	elseif var_19_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2 then
		return CoreVerificationChallengeMode2Action
	elseif var_19_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3 then
		return CoreVerificationChallengeMode3Action
	elseif var_19_0 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4 then
		return CoreVerificationChallengeMode4Action
	end
end

function var_0_0.GetBattleClCfg(arg_20_0)
	local var_20_0 = arg_20_0 or var_0_0.GetActivityId()
	local var_20_1 = ActivityTools.GetActivityType(var_20_0)

	if var_20_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1 then
		return BattleCoreVerificationClCfg
	elseif var_20_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2 then
		return BattleCoreVerificationCl2Cfg
	elseif var_20_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3 then
		return BattleCoreVerificationCl3Cfg
	elseif var_20_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4 then
		return BattleCoreVerificationCl4Cfg
	end
end

local function var_0_1(arg_21_0, arg_21_1)
	arg_21_0 = arg_21_0 or var_0_0.GetActivityId()

	local var_21_0 = var_0_0.GetDataCls(arg_21_0)

	if var_21_0 then
		return arg_21_1(var_21_0)
	end
end

local function var_0_2(arg_22_0, arg_22_1)
	arg_22_0 = arg_22_0 or var_0_0.GetActivityId()

	local var_22_0 = var_0_0.GetDataCls(arg_22_0)
	local var_22_1 = nullable(var_22_0, arg_22_1)

	if var_22_0 and var_22_1 then
		return var_22_1(var_22_0)
	end
end

function var_0_0.GetChallengeStage(arg_23_0)
	local var_23_0 = arg_23_0 or var_0_0.GetActivityId()
	local var_23_1 = var_0_0.GetDataCls(var_23_0)

	if var_23_1 then
		return var_23_1:GetChallengeStage()
	end
end

function var_0_0.GetChallengeStageCfg(arg_24_0)
	local var_24_0 = arg_24_0 or var_0_0.GetActivityId()
	local var_24_1 = var_0_0.GetDataCls(var_24_0)

	if var_24_1 then
		return var_24_1:GetChallengeStageCfg()
	end
end

function var_0_0.GetChallengeStageCfgByIndex(arg_25_0)
	local var_25_0 = CoreVerificationClBadgeCfg.get_id_list_by_set_id_sort[arg_25_0][1]
	local var_25_1 = CoreVerificationClBadgeCfg[var_25_0].activity_id
	local var_25_2 = ActivityTools.GetActivityType(var_25_1)

	if var_25_2 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1 then
		return CoreVerificationClMode1Cfg
	elseif var_25_2 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2 then
		return CoreVerificationClMode2Cfg
	elseif var_25_2 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3 then
		return CoreVerificationClMode3Cfg
	elseif var_25_2 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4 then
		return CoreVerificationClMode4Cfg
	end
end

function var_0_0.GetIllustrated()
	local var_26_0 = var_0_0.GetActivityId()

	return CoreVerificationChallengeData:GetIllustrated()
end

function var_0_0.GetMaxIllustrated()
	local var_27_0 = var_0_0.GetActivityId()

	return CoreVerificationChallengeData:GetMaxIllustrated()
end

function var_0_0.GetModeCfg(arg_28_0)
	local var_28_0 = arg_28_0 or var_0_0.GetActivityId()
	local var_28_1 = ActivityTools.GetActivityType(var_28_0)

	if var_28_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1 then
		return CoreVerificationClMode1Cfg
	elseif var_28_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2 then
		return CoreVerificationClMode2Cfg
	elseif var_28_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3 then
		return CoreVerificationClMode3Cfg
	elseif var_28_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4 then
		return CoreVerificationClMode4Cfg
	end
end

function var_0_0.GetModeCfgBySetId(arg_29_0)
	local var_29_0 = CoreVerificationClBadgeCfg.get_id_list_by_set_id[arg_29_0][1]
	local var_29_1 = CoreVerificationClBadgeCfg[var_29_0].activity_id
	local var_29_2 = ActivityTools.GetActivityType(var_29_1)

	if var_29_2 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1 then
		return CoreVerificationClMode1Cfg
	elseif var_29_2 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2 then
		return CoreVerificationClMode2Cfg
	elseif var_29_2 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3 then
		return CoreVerificationClMode3Cfg
	elseif var_29_2 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4 then
		return CoreVerificationClMode4Cfg
	end
end

function var_0_0.GetIllustratedInfoByLevel(arg_30_0, arg_30_1)
	return CoreVerificationChallengeData:GetIllustratedInfoByLevel(arg_30_0, arg_30_1)
end

function var_0_0.GetCommonStage()
	local var_31_0 = var_0_0.GetActivityId()
	local var_31_1 = var_0_0.GetDataCls(var_31_0)

	if var_31_1 then
		return var_31_1:GetCommonStage()
	end
end

function var_0_0.PushStageLockedHero(arg_32_0, arg_32_1)
	local var_32_0 = var_0_0.GetActivityId()
	local var_32_1 = var_0_0.GetDataCls(var_32_0)

	if var_32_1 then
		return var_32_1:PushStageLockedHero(arg_32_0, arg_32_1)
	end
end

function var_0_0.GetStageLockedHero(arg_33_0)
	local var_33_0 = {}

	var_0_0.PushStageLockedHero(arg_33_0, var_33_0)

	return var_33_0
end

function var_0_0.GetActivityRankId(arg_34_0, arg_34_1)
	arg_34_1 = arg_34_1 or var_0_0.GetActivityId()

	return ActivityCfg[arg_34_1].sub_activity_list[1]
end

function var_0_0.GetActivityFirstRankId(arg_35_0, arg_35_1)
	arg_35_1 = arg_35_1 or var_0_0.GetActivityId()

	local var_35_0 = ActivityCfg[arg_35_1].sub_activity_list[1]

	return ActivityCfg[var_35_0].sub_activity_list[1] or 0
end

function var_0_0.GetTaskInfoById(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0 or var_0_0.GetActivityId()
	local var_36_1 = var_0_0.GetDataCls(var_36_0)

	if var_36_1 then
		return var_36_1:GetTaskInfoById(arg_36_1)
	end
end

function var_0_0.GetTaskStateById(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1 or var_0_0.GetActivityId()
	local var_37_1 = var_0_0.GetDataCls(var_37_0)

	if var_37_1 then
		return var_37_1:GetTaskState(arg_37_0)
	end
end

function var_0_0.GetReward(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0 or var_0_0.GetActivityId()
	local var_38_1 = var_0_0.GetActionCls(var_38_0)

	if var_38_1 then
		var_38_1.GetReward(var_38_0, arg_38_1)
	end
end

local function var_0_3(arg_39_0, arg_39_1)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_0:GetAllTaskInfo()) do
		if iter_39_1.reward_type == arg_39_1 then
			table.insert(var_39_0, iter_39_1.taskId)
		end
	end

	return var_39_0
end

function var_0_0.GetTaskInfoByType(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0 or var_0_0.GetActivityId()
	local var_40_1 = var_0_0.GetDataCls(var_40_0)

	if var_40_1 then
		return var_0_3(var_40_1, arg_40_1)
	end
end

function var_0_0.ResetSelectAffix(arg_41_0)
	local var_41_0 = var_0_0.GetActivityId()
	local var_41_1 = ActivityTools.GetActivityType(var_41_0)

	if var_41_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1 then
		CoreVerificationChallengeData:ResetSelectAffix()
	elseif var_41_1 == ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2 then
		CoreVerificationChallengeMode2Data:ResetSelectAffix()
	end
end

function var_0_0.CheckCycleReward()
	local var_42_0 = var_0_0.GetActivityId()
	local var_42_1 = var_0_0.GetDataCls(var_42_0)

	if var_42_1 then
		return var_42_1:IsGetAllTaskReward()
	end
end

function var_0_0.IsJumpAllStage(arg_43_0)
	local var_43_0 = arg_43_0 or var_0_0.GetActivityId()
	local var_43_1 = ActivityTools.GetActivityType(var_43_0)
	local var_43_2 = var_0_0.GetDataCls(var_43_0)

	if var_43_2 then
		return var_43_2:IsJumpAllStage()
	end
end

function var_0_0.GetRankScore(arg_44_0)
	arg_44_0 = arg_44_0 or var_0_0.GetActivityId()

	local var_44_0 = ActivityTools.GetActivityType(arg_44_0)
	local var_44_1 = var_0_0.GetDataCls(arg_44_0)

	if var_44_1 then
		return var_44_1:GetRankScore()
	end
end

function var_0_0.GetBadgeCount()
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in pairs(CoreVerificationClBadgeCfg.get_id_list_by_set_id) do
		local var_45_1 = CoreVerificationClBadgeCfg.get_id_list_by_set_id[iter_45_0][1]
		local var_45_2 = CoreVerificationClBadgeCfg[var_45_1].activity_id
		local var_45_3 = ActivityData:GetActivityData(var_45_2)
		local var_45_4 = manager.time:GetServerTime()

		if not (var_45_3.startTime > manager.time:GetServerTime()) then
			table.insert(var_45_0, iter_45_0)
		end
	end

	table.sort(var_45_0, function(arg_46_0, arg_46_1)
		return arg_46_0 < arg_46_1
	end)

	return var_45_0
end

function var_0_0.ShowTeamFromRankInfo(arg_47_0, arg_47_1)
	arg_47_0 = arg_47_0 or var_0_0.GetActivityId()

	var_0_0.ShowTeamFromRankInfoAndModeIndex(var_0_0.GetModeIndex(arg_47_0), arg_47_1)
end

function var_0_0.ShowTeamFromRankInfoAndModeIndex(arg_48_0, arg_48_1)
	arg_48_0 = arg_48_0 or var_0_0.GetModeIndex()

	if arg_48_0 == 1 or arg_48_0 == 2 or arg_48_0 == 3 then
		JumpTools.OpenPageByJump("coreVerificationChallengeTeamCheckView", {
			data = arg_48_1,
			coreVerificationModeIndex = arg_48_0
		})
	elseif arg_48_0 == 4 then
		JumpTools.OpenPageByJump("coreVerificationChallengeTeamCheckViewMode4", {
			data = arg_48_1,
			coreVerificationModeIndex = arg_48_0
		})
	end
end

function var_0_0.CheckCanStartBattle(arg_49_0)
	if var_0_0.GetModeIndex() == 4 then
		local var_49_0 = {}
		local var_49_1 = CoreVerificationChallengeMode4Data:GetStageDataByStageID(arg_49_0.stageID)
		local var_49_2 = nullable(var_49_1, "teams", arg_49_0.teamIndex, "heroList") or {}
		local var_49_3 = ReserveTools.GetHeroList(arg_49_0)

		for iter_49_0, iter_49_1 in ipairs(var_49_2) do
			print(HeroTools.GetHeroName(iter_49_1))

			var_49_0[iter_49_1] = var_49_0[iter_49_1] or 1
		end

		for iter_49_2, iter_49_3 in ipairs(var_49_3) do
			print(HeroTools.GetHeroName(iter_49_3))

			var_49_0[iter_49_3] = var_49_0[iter_49_3] or 1
		end

		var_49_0[0] = nil

		local var_49_4 = 0

		for iter_49_4, iter_49_5 in pairs(var_49_0) do
			var_49_4 = var_49_4 + 1
		end

		print(var_49_4)

		if var_49_4 > 3 then
			return false, "CORE_VERIFICATION_CL_LOCK_TIPS_4"
		end
	end

	return true, nil
end

return var_0_0
