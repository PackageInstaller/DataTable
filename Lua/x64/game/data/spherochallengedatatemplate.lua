SPHeroChallengeActivityTemplate = class("SPHeroChallengeActivityTemplate")

function SPHeroChallengeActivityTemplate.Ctor(arg_1_0, arg_1_1)
	arg_1_0:InitData(arg_1_1)
end

function SPHeroChallengeActivityTemplate.InitData(arg_2_0, arg_2_1)
	arg_2_0.activityID = arg_2_1.activity_id
	arg_2_0.entrustTime = arg_2_1.entrust_refresh_times or 0
	arg_2_0.entrustFreeTime = math.min(arg_2_0.entrustTime, SPHeroChallengeData.activityCfg[arg_2_0.activityID].freeRefreshEntrustTime)
	arg_2_0.getAwardFlag = arg_2_1.is_got_schedule_reward or false

	arg_2_0:InitCurEntrustList(arg_2_1.begin_entrust_list)
	arg_2_0:InitWaiteEntrustList(arg_2_1.entrust_id_list)
	arg_2_0:InitFinStoryList(arg_2_1.passed_chapter_level_list)
	arg_2_0:InitTrainInfo(arg_2_1.train_list)

	arg_2_0.challengeTimes = arg_2_1.challenge_times
end

function SPHeroChallengeActivityTemplate.GetRemainChallengeTimes(arg_3_0)
	return SPHeroChallengeData.activityCfg[arg_3_0.activityID].maxChallengeTimes - arg_3_0.challengeTimes
end

function SPHeroChallengeActivityTemplate.GetChallengeTimes(arg_4_0)
	return SPHeroChallengeData.activityCfg[arg_4_0.activityID].maxChallengeTimes, arg_4_0.challengeTimes
end

function SPHeroChallengeActivityTemplate.InitTrainInfo(arg_5_0, arg_5_1)
	arg_5_0.trainInfo = {}

	if arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			local var_5_0 = SPHeroChallengeAction:ParseTrainInfo(iter_5_1)

			arg_5_0.trainInfo[var_5_0.type] = var_5_0
		end
	end

	for iter_5_2 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		if not arg_5_0.trainInfo[iter_5_2] then
			arg_5_0.trainInfo[iter_5_2] = SPHeroChallengeAction:ParseTrainInfo(nil, iter_5_2)
		end
	end
end

function SPHeroChallengeActivityTemplate.InitCurScheduleList(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.curScheduleList then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			local var_6_0 = SPHeroChallengeAction:ParseScheduleInfo(iter_6_1)

			if var_6_0 and var_6_0.isFinish and arg_6_0.curScheduleList[var_6_0.index].isFinish ~= var_6_0.isFinish then
				SDKTools.SendMessageToSDK("task_accept", {
					opt = 4,
					type = 2,
					activity_id = arg_6_0.activityID,
					task_id = var_6_0.scheduleID
				})
			end
		end
	end

	if not arg_6_0:CheckCurScheduleStart() then
		arg_6_0.curScheduleList = {}
		arg_6_0.dailyList = {}
	end

	if arg_6_1 then
		for iter_6_2, iter_6_3 in ipairs(arg_6_1) do
			local var_6_1 = SPHeroChallengeAction:ParseScheduleInfo(iter_6_3)

			if var_6_1 then
				arg_6_0.curScheduleList[var_6_1.index] = var_6_1
				arg_6_0.dailyList[var_6_1.index] = var_6_1.scheduleID
			end
		end
	end

	if not arg_6_2 then
		manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CONFIRM)
	end
end

function SPHeroChallengeActivityTemplate.InitCurEntrustList(arg_7_0, arg_7_1)
	arg_7_0.beganEntrustList = {}

	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			local var_7_0 = SPHeroChallengeAction:ParseEntrustInfo(iter_7_1)

			if var_7_0 then
				arg_7_0.beganEntrustList[var_7_0.index] = var_7_0
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.InitWaiteEntrustList(arg_8_0, arg_8_1)
	arg_8_0.waitEntrustList = {}

	if arg_8_1 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			table.insert(arg_8_0.waitEntrustList, iter_8_1)
		end
	end
end

function SPHeroChallengeActivityTemplate.InitFinStoryList(arg_9_0, arg_9_1)
	arg_9_0.storyFinStageList = {}

	if arg_9_1 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			table.insert(arg_9_0.storyFinStageList, iter_9_1)
		end
	end

	if #arg_9_0.storyFinStageList > 0 then
		CommonTools.UniversalSortEx(arg_9_0.storyFinStageList, {
			ascend = true,
			map = function(arg_10_0)
				return arg_10_0
			end
		})
	end
end

function SPHeroChallengeActivityTemplate.Dispose(arg_11_0)
	arg_11_0.activityID = nil
	arg_11_0.entrustFreeTime = nil
	arg_11_0.getAwardFlag = nil
	arg_11_0.storyFinStageList = nil
	arg_11_0.waitEntrustList = nil
	arg_11_0.beganEntrustList = nil
	arg_11_0.curScheduleList = nil
	arg_11_0.trainInfo = nil
end

function SPHeroChallengeActivityTemplate.RefreshDormDailyZero(arg_12_0)
	arg_12_0.entrustFreeTime = 0
	arg_12_0.entrustTime = 0
end

function SPHeroChallengeActivityTemplate.GetRefreshFreeEntrustTime(arg_13_0)
	return GameSetting.activity_hero_challenge_task_free_refresh_num.value[1] - arg_13_0.entrustFreeTime
end

function SPHeroChallengeActivityTemplate.GetRefreshTotalEntrustTime(arg_14_0)
	return GameSetting.activity_hero_challenge_task_refresh_num.value[1] - arg_14_0.entrustTime
end

function SPHeroChallengeActivityTemplate.GetNextStoryStageIDList(arg_15_0)
	local var_15_0 = SpHeroChallengeConst.ScheduleSubType.story
	local var_15_1 = BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[var_15_0][1]

	if arg_15_0.storyFinStageList and #arg_15_0.storyFinStageList > 0 then
		local var_15_2 = arg_15_0.storyFinStageList[#arg_15_0.storyFinStageList]

		var_15_1 = BattleVerthandiExclusiveCfg[var_15_2].next_unlock_id_list[1]

		if not var_15_1 or var_15_1 == "" then
			var_15_1 = var_15_2
		end
	end

	return var_15_1
end

function SPHeroChallengeActivityTemplate.GetBossErosiveness(arg_16_0)
	local var_16_0 = 0

	if arg_16_0.trainInfo then
		for iter_16_0, iter_16_1 in pairs(arg_16_0.trainInfo) do
			var_16_0 = var_16_0 + iter_16_1.value
		end
	end

	return math.ceil(var_16_0 / (3 * GameSetting.activity_hero_challenge_erosion_num.value[1]))
end

function SPHeroChallengeActivityTemplate.GetTrainNumBySchedule(arg_17_0, arg_17_1)
	local var_17_0 = ActivityHeroChallengeScheduleCfg[arg_17_1].server_type

	return arg_17_0:GetTrainNumByType(var_17_0)
end

function SPHeroChallengeActivityTemplate.GetTrainNumByType(arg_18_0, arg_18_1)
	local var_18_0 = ActivityHeroChallengeCfg[arg_18_0.activityID]["affix_group_" .. tostring(arg_18_1 - 1)][3][1]
	local var_18_1 = 0

	if arg_18_0.trainInfo[arg_18_1] then
		var_18_1 = arg_18_0.trainInfo[arg_18_1].value
	end

	return var_18_1 or 0, var_18_0
end

function SPHeroChallengeActivityTemplate.FinishTrainStage(arg_19_0, arg_19_1)
	local var_19_0 = BattleVerthandiExclusiveCfg[arg_19_1]

	if var_19_0 then
		local var_19_1 = var_19_0.sub_type

		if not table.indexof(arg_19_0.trainInfo[var_19_1].passStageList, arg_19_1) then
			table.insert(arg_19_0.trainInfo[var_19_1].passStageList, arg_19_1)
		end
	end
end

function SPHeroChallengeActivityTemplate.GetEntrustEndTime(arg_20_0, arg_20_1)
	if arg_20_0.beganEntrustList and arg_20_0.beganEntrustList[arg_20_1] then
		local var_20_0 = arg_20_0.beganEntrustList[arg_20_1]

		if var_20_0.startTime > 0 then
			local var_20_1 = ActivityHeroChallengeTaskCfg[var_20_0.entrustID]
			local var_20_2 = manager.time:GetServerTime()

			if var_20_2 - var_20_0.startTime >= var_20_1.time * 60 then
				return true, 0
			else
				return false, var_20_1.time * 60 - (var_20_2 - var_20_0.startTime)
			end
		end
	else
		Debug.LogError("未获取到已开始委托数据" .. arg_20_1)
	end
end

function SPHeroChallengeActivityTemplate.ModefyEntrustStartTime(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.index
	local var_21_1 = SPHeroChallengeData.activityCfg[arg_21_0.activityID].acceleratorTime
	local var_21_2 = arg_21_0.beganEntrustList[var_21_0]

	if var_21_2 then
		var_21_2.startTime = var_21_2.startTime - arg_21_1.use_cnt * var_21_1 * 60
	end

	manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
end

function SPHeroChallengeActivityTemplate.GetCanGetRewardEntrustIndexList(arg_22_0)
	local var_22_0 = {}

	if arg_22_0.beganEntrustList then
		for iter_22_0, iter_22_1 in pairs(arg_22_0.beganEntrustList) do
			if arg_22_0:GetEntrustEndTime(iter_22_0) then
				table.insert(var_22_0, iter_22_0)
			end
		end
	end

	return var_22_0
end

function SPHeroChallengeActivityTemplate.GetCurRunEntrustInfo(arg_23_0)
	local var_23_0 = {}

	if arg_23_0.beganEntrustList then
		for iter_23_0, iter_23_1 in pairs(arg_23_0.beganEntrustList) do
			if iter_23_1.start > 0 then
				var_23_0[iter_23_0] = iter_23_1
			end
		end
	end

	return var_23_0
end

function SPHeroChallengeActivityTemplate.StartEntrust(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_0.beganEntrustList then
		arg_24_0.beganEntrustList = {}
	end

	if arg_24_0.waitEntrustList then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0.waitEntrustList) do
			if iter_24_1 == arg_24_2 then
				table.remove(arg_24_0.waitEntrustList, iter_24_0)

				break
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.CancelEntrust(arg_25_0, arg_25_1)
	arg_25_0.beganEntrustList[arg_25_1] = nil
end

function SPHeroChallengeActivityTemplate.GetReceiveEntrustNum(arg_26_0)
	local var_26_0 = 0

	if arg_26_0.beganEntrustList then
		for iter_26_0, iter_26_1 in pairs(arg_26_0.beganEntrustList) do
			var_26_0 = var_26_0 + 1
		end
	end

	return var_26_0
end

function SPHeroChallengeActivityTemplate.GetEntrustInfoByIndex(arg_27_0, arg_27_1)
	if arg_27_0.beganEntrustList then
		return arg_27_0.beganEntrustList[arg_27_1]
	end
end

function SPHeroChallengeActivityTemplate.GetNextExtrustIndex(arg_28_0)
	if arg_28_0.beganEntrustList then
		local var_28_0 = SPHeroChallengeTools:GetMaxTotleEntrustPosNum(arg_28_0.activityID)

		for iter_28_0 = 1, var_28_0 do
			if SPHeroChallengeTools:GetEntrustPosState(arg_28_0.activityID, iter_28_0) == SpHeroChallengeConst.EntrustPosState.empty then
				return iter_28_0
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.GetPrepareEntrustList(arg_29_0)
	local var_29_0 = {}

	if arg_29_0.beganEntrustList then
		local var_29_1 = {}

		for iter_29_0, iter_29_1 in ipairs(arg_29_0.beganEntrustList) do
			if iter_29_1.start == 0 or arg_29_0:GetEntrustEndTime(iter_29_1.index) then
				talbe.insert(var_29_1, iter_29_1.showIndex)
			end
		end
	end

	return var_29_0
end

function SPHeroChallengeActivityTemplate.GetShowIndexEntrustInfo(arg_30_0, arg_30_1)
	if arg_30_0.beganEntrustList then
		for iter_30_0, iter_30_1 in pairs(arg_30_0.beganEntrustList) do
			if iter_30_1.showIndex == arg_30_1 then
				return iter_30_1
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.EntrustFinish(arg_31_0, arg_31_1)
	if arg_31_0.beganEntrustList then
		for iter_31_0, iter_31_1 in pairs(arg_31_0.beganEntrustList) do
			if iter_31_1.showIndex == arg_31_1 then
				local var_31_0 = SPHeroChallengeTools:GetMaxStartEntrustPosNum(arg_31_0.activityID)
				local var_31_1 = arg_31_0:GetShowIndexEntrustInfo(var_31_0 + 1)

				if var_31_1 and var_31_1.startTime == 0 then
					local var_31_2 = var_31_1.showIndex
					local var_31_3 = var_31_1.showIndex

					var_31_1.showIndex = arg_31_1
					var_31_1.startTime = manager.time:GetServerTime()

					for iter_31_2, iter_31_3 in pairs(arg_31_0.beganEntrustList) do
						if iter_31_3.startTime == 0 then
							var_31_3 = math.max(var_31_3, iter_31_3.showIndex)
							iter_31_3.showIndex = iter_31_3.showIndex - 1
						end
					end

					iter_31_1.showIndex = var_31_3
				end

				break
			end
		end

		local var_31_4 = SPHeroChallengeData:GetActivityID()

		SPHeroChallengeRedPointTools:UpdataCanGetEntrustRewardRedPoint(var_31_4)
		manager.notify:Invoke(SP_HERO_CHALLENGE_FIN_ENTRUST)
	end
end

function SPHeroChallengeActivityTemplate.FinishSchedule(arg_32_0, arg_32_1)
	if arg_32_0.curScheduleList and arg_32_0.curScheduleList[arg_32_1] then
		arg_32_0.curScheduleList[arg_32_1].isFinish = true
	end
end

function SPHeroChallengeActivityTemplate.GetStartListScheduleInfoByList(arg_33_0, arg_33_1)
	if arg_33_0.curScheduleList then
		return arg_33_0.curScheduleList[arg_33_1]
	end
end

function SPHeroChallengeActivityTemplate.GetFinScheduleScore(arg_34_0)
	local var_34_0 = 0

	if arg_34_0.curScheduleList then
		for iter_34_0, iter_34_1 in pairs(arg_34_0.curScheduleList) do
			if iter_34_1.isFinish then
				local var_34_1 = ActivityHeroChallengeScheduleCfg[iter_34_1.scheduleID]

				if var_34_1 then
					var_34_0 = var_34_0 + var_34_1.score
				else
					Debug.LogError("未获取日程任务配置" .. iter_34_1.scheduleID)
				end
			end
		end
	end

	return var_34_0
end

function SPHeroChallengeActivityTemplate.CheckCurScheduleFinish(arg_35_0)
	local var_35_0 = true

	if arg_35_0.curScheduleList and next(arg_35_0.curScheduleList) ~= nil then
		for iter_35_0, iter_35_1 in pairs(arg_35_0.curScheduleList) do
			if not iter_35_1.isFinish then
				var_35_0 = false

				break
			end
		end
	else
		var_35_0 = false
	end

	return var_35_0
end

function SPHeroChallengeActivityTemplate.CheckDailyScheduleAwardReceived(arg_36_0)
	return arg_36_0.getAwardFlag
end

function SPHeroChallengeActivityTemplate.CheckCurScheduleStart(arg_37_0)
	if arg_37_0.curScheduleList and next(arg_37_0.curScheduleList) then
		return true
	else
		return false
	end
end

function SPHeroChallengeActivityTemplate.GetStartBattelScheduleByType(arg_38_0, arg_38_1)
	local var_38_0 = 0
	local var_38_1 = 0

	if arg_38_0.curScheduleList then
		for iter_38_0, iter_38_1 in pairs(arg_38_0.curScheduleList) do
			local var_38_2 = iter_38_1.scheduleID

			if ActivityHeroChallengeScheduleCfg[var_38_2].server_type == arg_38_1 then
				var_38_0 = var_38_0 + 1

				if iter_38_1.isFinish then
					var_38_1 = var_38_1 + 1
				end
			end
		end
	end

	return var_38_0, var_38_1
end

function SPHeroChallengeActivityTemplate.GetSaveScheudlList(arg_39_0)
	if arg_39_0.localSaveSchedule then
		arg_39_0.localSaveSchedule = getData("SPHeroChallenge" .. arg_39_0.activityID, "localSchedule") or {}
	end

	return arg_39_0.localSaveSchedule
end

function SPHeroChallengeActivityTemplate.SetSaveScheudlList(arg_40_0)
	if arg_40_0.localSaveSchedule then
		saveData("SPHeroChallenge" .. arg_40_0.activityID, "localSchedule", arg_40_0.localSaveSchedule)
	end

	arg_40_0.localSaveSchedule = nil
end

function SPHeroChallengeActivityTemplate.AddScheduleInDailyList(arg_41_0, arg_41_1)
	if not arg_41_0.dailyList then
		arg_41_0.dailyList = {}
	end

	local var_41_0

	for iter_41_0 = 1, SpHeroChallengeConst.scheduleNum do
		if not arg_41_0.dailyList[iter_41_0] or arg_41_0.dailyList[iter_41_0] == 0 then
			arg_41_0.dailyList[iter_41_0] = arg_41_1
			var_41_0 = iter_41_0

			break
		end
	end

	if var_41_0 then
		manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, var_41_0)
	end
end

function SPHeroChallengeActivityTemplate.RemoveScheduleInDailyList(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_0.dailyList then
		return
	end

	arg_42_0.dailyList[arg_42_2] = 0

	manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, arg_42_2)
end

function SPHeroChallengeActivityTemplate.GetScheduleDailyList(arg_43_0)
	return arg_43_0.dailyList or {}
end

function SPHeroChallengeActivityTemplate.ClearScheduleDailyList(arg_44_0)
	arg_44_0.dailyList = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_0.curScheduleList) do
		local var_44_0 = arg_44_0.curScheduleList[iter_44_0]

		if var_44_0 and var_44_0.isFinish then
			arg_44_0.dailyList[var_44_0.index] = var_44_0.scheduleID
		end
	end
end

function SPHeroChallengeActivityTemplate.InitBossInfo(arg_45_0, arg_45_1)
	if arg_45_1 then
		arg_45_0.bossHadFightDailyList = {}

		local var_45_0 = {}

		for iter_45_0, iter_45_1 in ipairs(arg_45_1.stage_id_list) do
			table.insert(var_45_0, iter_45_1)
		end

		arg_45_0.bossHadFightDailyList.dailyChallenge = var_45_0
		arg_45_0.bossHadFightDailyList.time = arg_45_1.fight_cnt
		arg_45_0.bossStageScore = {}

		for iter_45_2, iter_45_3 in ipairs(arg_45_1.score_info_list) do
			local var_45_1 = SPHeroChallengeAction:ParseScoreInfo(iter_45_3)

			arg_45_0.bossStageScore[var_45_1.stageID] = var_45_1.score
		end

		arg_45_0.bossStart = arg_45_1.is_start
		arg_45_0.equipList = {}

		if arg_45_1.got_award_cfg_list then
			for iter_45_4, iter_45_5 in ipairs(arg_45_1.got_award_cfg_list) do
				table.insert(arg_45_0.equipList, iter_45_5)
			end
		end

		manager.notify:Invoke(SP_HERO_CHALLENGE_UPDATE_BOSS)
	end
end

function SPHeroChallengeActivityTemplate.GetBossScoreInfo(arg_46_0, arg_46_1)
	if arg_46_0.bossStageScore then
		return arg_46_0.bossStageScore[arg_46_1] or 0
	end

	return 0
end

function SPHeroChallengeActivityTemplate.FinishStoryStage(arg_47_0, arg_47_1)
	if not arg_47_0.storyFinStageList then
		arg_47_0.storyFinStageList = {}
	end

	if not table.indexof(arg_47_0.storyFinStageList, arg_47_1) then
		table.insert(arg_47_0.storyFinStageList, arg_47_1)
	end
end

function SPHeroChallengeActivityTemplate.CheckStoryFinState(arg_48_0, arg_48_1)
	if not arg_48_0.storyFinStageList then
		arg_48_0.storyFinStageList = {}
	end

	if not table.indexof(arg_48_0.storyFinStageList, arg_48_1) then
		return false
	else
		return true
	end
end

function SPHeroChallengeActivityTemplate.GetNextStageName(arg_49_0)
	if arg_49_0.storyFinStageList then
		local var_49_0 = #arg_49_0.storyFinStageList
		local var_49_1 = BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.story][1 + var_49_0]

		if var_49_1 then
			return BattleVerthandiExclusiveCfg[var_49_1].name
		end
	end
end

function SPHeroChallengeActivityTemplate.CheckCanGetHeroChipTaskAward(arg_50_0)
	local var_50_0 = SPHeroChallengeData.activityCfg[arg_50_0.activityID].HeroChipTask

	if var_50_0 then
		local var_50_1 = TaskData2:GetTaskComplete(var_50_0)
		local var_50_2 = TaskData2:GetTaskProgress(var_50_0)
		local var_50_3 = AssignmentCfg[var_50_0].need

		if var_50_1 or var_50_2 < var_50_3 then
			return false, var_50_1, var_50_3, var_50_2
		else
			return true, nil, var_50_3, var_50_2
		end
	end
end

function SPHeroChallengeActivityTemplate.CheckHasReceiveHeroAward(arg_51_0)
	local var_51_0 = SPHeroChallengeData.activityCfg[arg_51_0.activityID].HeroChipTask
	local var_51_1 = TaskData2:GetTask(var_51_0)

	return var_51_1 and var_51_1.complete_flag > 0
end

function SPHeroChallengeActivityTemplate.CheckHasReceiveWeaponAward(arg_52_0)
	local var_52_0 = SPHeroChallengeData.activityCfg[arg_52_0.activityID].shopItemID

	return ShopTools.CheckSoldOut(var_52_0)
end
