SPHeroChallengeActivityTemplate = class("SPHeroChallengeActivityTemplate")

function SPHeroChallengeActivityTemplate:Ctor(arg_1_1)
	self:InitData(arg_1_1)
end

function SPHeroChallengeActivityTemplate:InitData(arg_2_1)
	self.activityID = arg_2_1.activity_id
	self.entrustTime = arg_2_1.entrust_refresh_times or 0
	self.entrustFreeTime = math.min(self.entrustTime, SPHeroChallengeData.activityCfg[self.activityID].freeRefreshEntrustTime)
	self.getAwardFlag = arg_2_1.is_got_schedule_reward or false

	self:InitCurEntrustList(arg_2_1.begin_entrust_list)
	self:InitWaiteEntrustList(arg_2_1.entrust_id_list)
	self:InitFinStoryList(arg_2_1.passed_chapter_level_list)
	self:InitTrainInfo(arg_2_1.train_list)

	self.challengeTimes = arg_2_1.challenge_times
end

function SPHeroChallengeActivityTemplate:GetRemainChallengeTimes()
	return SPHeroChallengeData.activityCfg[self.activityID].maxChallengeTimes - self.challengeTimes
end

function SPHeroChallengeActivityTemplate:GetChallengeTimes()
	return SPHeroChallengeData.activityCfg[self.activityID].maxChallengeTimes, self.challengeTimes
end

function SPHeroChallengeActivityTemplate:InitTrainInfo(arg_5_1)
	self.trainInfo = {}

	if arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			local var_5_0 = SPHeroChallengeAction:ParseTrainInfo(iter_5_1)

			self.trainInfo[var_5_0.type] = var_5_0
		end
	end

	for iter_5_2 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		self.trainInfo[iter_5_2] = self.trainInfo[iter_5_2] or SPHeroChallengeAction:ParseTrainInfo(nil, iter_5_2)
	end
end

function SPHeroChallengeActivityTemplate:InitCurScheduleList(arg_6_1, arg_6_2)
	if self.curScheduleList then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			local var_6_0 = SPHeroChallengeAction:ParseScheduleInfo(iter_6_1)

			if var_6_0 and var_6_0.isFinish and self.curScheduleList[var_6_0.index].isFinish ~= var_6_0.isFinish then
				SDKTools.SendMessageToSDK("task_accept", {
					opt = 4,
					type = 2,
					activity_id = self.activityID,
					task_id = var_6_0.scheduleID
				})
			end
		end
	end

	if not self:CheckCurScheduleStart() then
		self.curScheduleList = {}
		self.dailyList = {}
	end

	if arg_6_1 then
		for iter_6_2, iter_6_3 in ipairs(arg_6_1) do
			local var_6_1 = SPHeroChallengeAction:ParseScheduleInfo(iter_6_3)

			if var_6_1 then
				self.curScheduleList[var_6_1.index] = var_6_1
				self.dailyList[var_6_1.index] = var_6_1.scheduleID
			end
		end
	end

	if not arg_6_2 then
		manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CONFIRM)
	end
end

function SPHeroChallengeActivityTemplate:InitCurEntrustList(arg_7_1)
	self.beganEntrustList = {}

	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			local var_7_0 = SPHeroChallengeAction:ParseEntrustInfo(iter_7_1)

			if var_7_0 then
				self.beganEntrustList[var_7_0.index] = var_7_0
			end
		end
	end
end

function SPHeroChallengeActivityTemplate:InitWaiteEntrustList(arg_8_1)
	self.waitEntrustList = {}

	if arg_8_1 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			table.insert(self.waitEntrustList, iter_8_1)
		end
	end
end

function SPHeroChallengeActivityTemplate:InitFinStoryList(arg_9_1)
	self.storyFinStageList = {}

	if arg_9_1 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			table.insert(self.storyFinStageList, iter_9_1)
		end
	end

	if #self.storyFinStageList > 0 then
		CommonTools.UniversalSortEx(self.storyFinStageList, {
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

function SPHeroChallengeActivityTemplate:GetRefreshFreeEntrustTime()
	return GameSetting.activity_hero_challenge_task_free_refresh_num.value[1] - self.entrustFreeTime
end

function SPHeroChallengeActivityTemplate:GetRefreshTotalEntrustTime()
	return GameSetting.activity_hero_challenge_task_refresh_num.value[1] - self.entrustTime
end

function SPHeroChallengeActivityTemplate:GetNextStoryStageIDList()
	local var_15_0 = BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.ScheduleSubType.story][1]

	if self.storyFinStageList and #self.storyFinStageList > 0 then
		var_15_0 = BattleVerthandiExclusiveCfg[self.storyFinStageList[#self.storyFinStageList]].next_unlock_id_list[1]

		if not BattleVerthandiExclusiveCfg[self.storyFinStageList[#self.storyFinStageList]].next_unlock_id_list[1] or var_15_0 == "" then
			var_15_0 = self.storyFinStageList[#self.storyFinStageList]
		end
	end

	return var_15_0
end

function SPHeroChallengeActivityTemplate:GetBossErosiveness()
	local var_16_0 = 0

	if self.trainInfo then
		for iter_16_0, iter_16_1 in pairs(self.trainInfo) do
			var_16_0 = var_16_0 + iter_16_1.value
		end
	end

	return math.ceil(var_16_0 / (3 * GameSetting.activity_hero_challenge_erosion_num.value[1]))
end

function SPHeroChallengeActivityTemplate:GetTrainNumBySchedule(arg_17_1)
	return self:GetTrainNumByType(ActivityHeroChallengeScheduleCfg[arg_17_1].server_type)
end

function SPHeroChallengeActivityTemplate:GetTrainNumByType(arg_18_1)
	return (self.trainInfo[arg_18_1] or nil) and self.trainInfo[arg_18_1].value or 0, ActivityHeroChallengeCfg[self.activityID]["affix_group_" .. tostring(arg_18_1 - 1)][3][1]
end

function SPHeroChallengeActivityTemplate:FinishTrainStage(arg_19_1)
	if BattleVerthandiExclusiveCfg[arg_19_1] then
		if not table.indexof(self.trainInfo[BattleVerthandiExclusiveCfg[arg_19_1].sub_type].passStageList, arg_19_1) then
			table.insert(self.trainInfo[BattleVerthandiExclusiveCfg[arg_19_1].sub_type].passStageList, arg_19_1)
		end
	end
end

function SPHeroChallengeActivityTemplate:GetEntrustEndTime(arg_20_1)
	if self.beganEntrustList and self.beganEntrustList[arg_20_1] then
		if self.beganEntrustList[arg_20_1].startTime > 0 then
			local var_20_0 = manager.time:GetServerTime()

			if var_20_0 - self.beganEntrustList[arg_20_1].startTime >= ActivityHeroChallengeTaskCfg[self.beganEntrustList[arg_20_1].entrustID].time * 60 then
				return true, 0
			else
				return false, ActivityHeroChallengeTaskCfg[self.beganEntrustList[arg_20_1].entrustID].time * 60 - (var_20_0 - self.beganEntrustList[arg_20_1].startTime)
			end
		end
	else
		Debug.LogError("未获取到已开始委托数据" .. arg_20_1)
	end
end

function SPHeroChallengeActivityTemplate:ModefyEntrustStartTime(arg_21_1)
	if self.beganEntrustList[arg_21_1.index] then
		self.beganEntrustList[arg_21_1.index].startTime = self.beganEntrustList[arg_21_1.index].startTime - arg_21_1.use_cnt * SPHeroChallengeData.activityCfg[self.activityID].acceleratorTime * 60
	end

	manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
end

function SPHeroChallengeActivityTemplate:GetCanGetRewardEntrustIndexList()
	local var_22_0 = {}

	if self.beganEntrustList then
		for iter_22_0, iter_22_1 in pairs(self.beganEntrustList) do
			if self:GetEntrustEndTime(iter_22_0) then
				table.insert(var_22_0, iter_22_0)
			end
		end
	end

	return var_22_0
end

function SPHeroChallengeActivityTemplate:GetCurRunEntrustInfo()
	local var_23_0 = {}

	if self.beganEntrustList then
		for iter_23_0, iter_23_1 in pairs(self.beganEntrustList) do
			if iter_23_1.start > 0 then
				var_23_0[iter_23_0] = iter_23_1
			end
		end
	end

	return var_23_0
end

function SPHeroChallengeActivityTemplate:StartEntrust(arg_24_1, arg_24_2)
	self.beganEntrustList = self.beganEntrustList or {}

	if self.waitEntrustList then
		for iter_24_0, iter_24_1 in ipairs(self.waitEntrustList) do
			if iter_24_1 == arg_24_2 then
				table.remove(self.waitEntrustList, iter_24_0)

				break
			end
		end
	end
end

function SPHeroChallengeActivityTemplate:CancelEntrust(arg_25_1)
	self.beganEntrustList[arg_25_1] = nil
end

function SPHeroChallengeActivityTemplate:GetReceiveEntrustNum()
	local var_26_0 = 0

	if self.beganEntrustList then
		for iter_26_0, iter_26_1 in pairs(self.beganEntrustList) do
			var_26_0 = var_26_0 + 1
		end
	end

	return var_26_0
end

function SPHeroChallengeActivityTemplate:GetEntrustInfoByIndex(arg_27_1)
	if self.beganEntrustList then
		return self.beganEntrustList[arg_27_1]
	end
end

function SPHeroChallengeActivityTemplate:GetNextExtrustIndex()
	if self.beganEntrustList then
		for iter_28_0 = 1, SPHeroChallengeTools:GetMaxTotleEntrustPosNum(self.activityID) do
			if SPHeroChallengeTools:GetEntrustPosState(self.activityID, iter_28_0) == SpHeroChallengeConst.EntrustPosState.empty then
				return iter_28_0
			end
		end
	end
end

function SPHeroChallengeActivityTemplate:GetPrepareEntrustList()
	if self.beganEntrustList then
		local var_29_0 = {}

		for iter_29_0, iter_29_1 in ipairs(self.beganEntrustList) do
			if iter_29_1.start == 0 or self:GetEntrustEndTime(iter_29_1.index) then
				talbe.insert(var_29_0, iter_29_1.showIndex)
			end
		end
	end

	return {}
end

function SPHeroChallengeActivityTemplate:GetShowIndexEntrustInfo(arg_30_1)
	if self.beganEntrustList then
		for iter_30_0, iter_30_1 in pairs(self.beganEntrustList) do
			if iter_30_1.showIndex == arg_30_1 then
				return iter_30_1
			end
		end
	end
end

function SPHeroChallengeActivityTemplate:EntrustFinish(arg_31_1)
	if self.beganEntrustList then
		for iter_31_0, iter_31_1 in pairs(self.beganEntrustList) do
			if iter_31_1.showIndex == arg_31_1 then
				local var_31_0 = self:GetShowIndexEntrustInfo(SPHeroChallengeTools:GetMaxStartEntrustPosNum(self.activityID) + 1)

				if var_31_0 and var_31_0.startTime == 0 then
					local var_31_2 = var_31_0.showIndex

					var_31_0.showIndex = arg_31_1
					var_31_0.startTime = manager.time:GetServerTime()

					for iter_31_2, iter_31_3 in pairs(self.beganEntrustList) do
						if iter_31_3.startTime == 0 then
							var_31_2 = math.max(var_31_2, iter_31_3.showIndex)
							iter_31_3.showIndex = iter_31_3.showIndex - 1
						end
					end

					iter_31_1.showIndex = var_31_2
				end

				break
			end
		end

		SPHeroChallengeRedPointTools:UpdataCanGetEntrustRewardRedPoint((SPHeroChallengeData:GetActivityID()))
		manager.notify:Invoke(SP_HERO_CHALLENGE_FIN_ENTRUST)
	end
end

function SPHeroChallengeActivityTemplate:FinishSchedule(arg_32_1)
	if self.curScheduleList and self.curScheduleList[arg_32_1] then
		self.curScheduleList[arg_32_1].isFinish = true
	end
end

function SPHeroChallengeActivityTemplate:GetStartListScheduleInfoByList(arg_33_1)
	if self.curScheduleList then
		return self.curScheduleList[arg_33_1]
	end
end

function SPHeroChallengeActivityTemplate:GetFinScheduleScore()
	local var_34_0 = 0

	if self.curScheduleList then
		for iter_34_0, iter_34_1 in pairs(self.curScheduleList) do
			if iter_34_1.isFinish then
				if ActivityHeroChallengeScheduleCfg[iter_34_1.scheduleID] then
					var_34_0 = var_34_0 + ActivityHeroChallengeScheduleCfg[iter_34_1.scheduleID].score
				else
					Debug.LogError("未获取日程任务配置" .. iter_34_1.scheduleID)
				end
			end
		end
	end

	return var_34_0
end

function SPHeroChallengeActivityTemplate:CheckCurScheduleFinish()
	local var_35_0 = true

	if self.curScheduleList and next(self.curScheduleList) ~= nil then
		for iter_35_0, iter_35_1 in pairs(self.curScheduleList) do
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

function SPHeroChallengeActivityTemplate:CheckDailyScheduleAwardReceived()
	return self.getAwardFlag
end

function SPHeroChallengeActivityTemplate:CheckCurScheduleStart()
	if self.curScheduleList and next(self.curScheduleList) then
		return true
	else
		return false
	end
end

function SPHeroChallengeActivityTemplate:GetStartBattelScheduleByType(arg_38_1)
	local var_38_0 = 0
	local var_38_1 = 0

	if self.curScheduleList then
		for iter_38_0, iter_38_1 in pairs(self.curScheduleList) do
			if ActivityHeroChallengeScheduleCfg[iter_38_1.scheduleID].server_type == arg_38_1 then
				var_38_0 = var_38_0 + 1

				if iter_38_1.isFinish then
					var_38_1 = var_38_1 + 1
				end
			end
		end
	end

	return var_38_0, var_38_1
end

function SPHeroChallengeActivityTemplate:GetSaveScheudlList()
	if self.localSaveSchedule then
		self.localSaveSchedule = getData("SPHeroChallenge" .. self.activityID, "localSchedule") or {}
	end

	return self.localSaveSchedule
end

function SPHeroChallengeActivityTemplate:SetSaveScheudlList()
	if self.localSaveSchedule then
		saveData("SPHeroChallenge" .. self.activityID, "localSchedule", self.localSaveSchedule)
	end

	self.localSaveSchedule = nil
end

function SPHeroChallengeActivityTemplate:AddScheduleInDailyList(arg_41_1)
	self.dailyList = self.dailyList or {}

	local var_41_0

	for iter_41_0 = 1, SpHeroChallengeConst.scheduleNum do
		if not self.dailyList[iter_41_0] or self.dailyList[iter_41_0] == 0 then
			self.dailyList[iter_41_0] = arg_41_1
			var_41_0 = iter_41_0

			break
		end
	end

	if var_41_0 then
		manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, var_41_0)
	end
end

function SPHeroChallengeActivityTemplate:RemoveScheduleInDailyList(arg_42_1, arg_42_2)
	if not self.dailyList then
		return
	end

	self.dailyList[arg_42_2] = 0

	manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, arg_42_2)
end

function SPHeroChallengeActivityTemplate:GetScheduleDailyList()
	return self.dailyList or {}
end

function SPHeroChallengeActivityTemplate:ClearScheduleDailyList()
	self.dailyList = {}

	for iter_44_0, iter_44_1 in ipairs(self.curScheduleList) do
		if self.curScheduleList[iter_44_0] and self.curScheduleList[iter_44_0].isFinish then
			self.dailyList[self.curScheduleList[iter_44_0].index] = self.curScheduleList[iter_44_0].scheduleID
		end
	end
end

function SPHeroChallengeActivityTemplate:InitBossInfo(arg_45_1)
	if arg_45_1 then
		self.bossHadFightDailyList = {}

		local var_45_0 = {}

		for iter_45_0, iter_45_1 in ipairs(arg_45_1.stage_id_list) do
			table.insert(var_45_0, iter_45_1)
		end

		self.bossHadFightDailyList.dailyChallenge = var_45_0
		self.bossHadFightDailyList.time = arg_45_1.fight_cnt
		self.bossStageScore = {}

		for iter_45_2, iter_45_3 in ipairs(arg_45_1.score_info_list) do
			local var_45_1 = SPHeroChallengeAction:ParseScoreInfo(iter_45_3)

			self.bossStageScore[var_45_1.stageID] = var_45_1.score
		end

		self.bossStart = arg_45_1.is_start
		self.equipList = {}

		if arg_45_1.got_award_cfg_list then
			for iter_45_4, iter_45_5 in ipairs(arg_45_1.got_award_cfg_list) do
				table.insert(self.equipList, iter_45_5)
			end
		end

		manager.notify:Invoke(SP_HERO_CHALLENGE_UPDATE_BOSS)
	end
end

function SPHeroChallengeActivityTemplate:GetBossScoreInfo(arg_46_1)
	if self.bossStageScore then
		return self.bossStageScore[arg_46_1] or 0
	end

	return 0
end

function SPHeroChallengeActivityTemplate:FinishStoryStage(arg_47_1)
	self.storyFinStageList = self.storyFinStageList or {}

	if not table.indexof(self.storyFinStageList, arg_47_1) then
		table.insert(self.storyFinStageList, arg_47_1)
	end
end

function SPHeroChallengeActivityTemplate:CheckStoryFinState(arg_48_1)
	self.storyFinStageList = self.storyFinStageList or {}

	if not table.indexof(self.storyFinStageList, arg_48_1) then
		return false
	else
		return true
	end
end

function SPHeroChallengeActivityTemplate:GetNextStageName()
	if self.storyFinStageList then
		if BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.story][1 + #self.storyFinStageList] then
			return BattleVerthandiExclusiveCfg[BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.story][1 + #self.storyFinStageList]].name
		end
	end
end

function SPHeroChallengeActivityTemplate:CheckCanGetHeroChipTaskAward()
	if SPHeroChallengeData.activityCfg[self.activityID].HeroChipTask then
		local var_50_0 = TaskData2:GetTaskComplete(SPHeroChallengeData.activityCfg[self.activityID].HeroChipTask)
		local var_50_1 = TaskData2:GetTaskProgress(SPHeroChallengeData.activityCfg[self.activityID].HeroChipTask)

		if var_50_0 or var_50_1 < AssignmentCfg[SPHeroChallengeData.activityCfg[self.activityID].HeroChipTask].need then
			return false, var_50_0, AssignmentCfg[SPHeroChallengeData.activityCfg[self.activityID].HeroChipTask].need, var_50_1
		else
			return true, nil, AssignmentCfg[SPHeroChallengeData.activityCfg[self.activityID].HeroChipTask].need, var_50_1
		end
	end
end

function SPHeroChallengeActivityTemplate:CheckHasReceiveHeroAward()
	local var_51_0 = TaskData2:GetTask(SPHeroChallengeData.activityCfg[self.activityID].HeroChipTask)

	return var_51_0 and var_51_0.complete_flag > 0
end

function SPHeroChallengeActivityTemplate:CheckHasReceiveWeaponAward()
	return ShopTools.CheckSoldOut(SPHeroChallengeData.activityCfg[self.activityID].shopItemID)
end
