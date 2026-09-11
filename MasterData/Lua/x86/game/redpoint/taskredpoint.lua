return {
	InitRedUpdater = function(self)
		self.redUpdater = self.redUpdater or {
			[TaskConst.TASK_TYPE.ALPHA] = handler(self, self.UpdateNewbieTaskRedPoint),
			[TaskConst.TASK_TYPE.DAILY_OFFER] = handler(self, self.UpdateNewbieDailyTaskRedTip),
			[TaskConst.TASK_TYPE.NOOB] = handler(self, self.UpdateNoobTaskRedPoint),
			[TaskConst.TASK_TYPE.NOOB_ADVANCE] = handler(self, self.UpdateNoobAdvanceTaskRedPoint),
			[TaskConst.TASK_TYPE.NOOB_3_0] = handler(self, self.UpdateNoobTaskRedPoint),
			[TaskConst.TASK_TYPE.NOOB_ADVANCE_3_0_1] = handler(self, self.UpdateNoobAdvanceTaskRedPoint),
			[TaskConst.TASK_TYPE.NOOB_ADVANCE_3_0_2] = handler(self, self.UpdateNoobAdvanceTaskRedPoint),
			[TaskConst.TASK_TYPE.NOOB_ADVANCE_3_0_3] = handler(self, self.UpdateNoobAdvanceTaskRedPoint),
			[TaskConst.TASK_TYPE.DAILY] = handler(self, self.UpdateDailyTaskRedTip),
			[TaskConst.TASK_TYPE.PLOT] = handler(self, self.UpdatePlotTaskRedTip),
			[TaskConst.TASK_TYPE.CLUB_TASK] = handler(self, self.UpdateClubTaskRedTip),
			[TaskConst.TASK_TYPE.WEEK] = handler(self, self.UpdateWeekTaskRedTip),
			[TaskConst.TASK_TYPE.CHAPTER_PLOT_19] = handler(self, self.UpdateChapterPlot19RedTip),
			[TaskConst.TASK_TYPE.IDOL_TRAINEE_DAILY] = handler(self, self.UpdateIdolTraineeDayAndWeekRedTip),
			[TaskConst.TASK_TYPE.IDOL_TRAINEE_WEEKLY] = handler(self, self.UpdateIdolTraineeDayAndWeekRedTip),
			[TaskConst.TASK_TYPE.IDOL_TRAINEE_CHAPTER] = handler(self, self.UpdateIdolTraineeChapterRedTip),
			[TaskConst.TASK_TYPE.SUMMER_CHESS_BOARD_EXPLORE_NOTE] = handler(self, self.UpdateSummerExploreNoteRedTip),
			[TaskConst.TASK_TYPE.POLYHEDRON_RESIDENT_TASK] = handler(self, self.UpdatePolyhedronResidentTaskRedTip),
			[TaskConst.TASK_TYPE.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_TASK] = handler(self, self.UpdateChallengeRogueTeamIllustratedRedTip),
			[TaskConst.TASK_TYPE.CHALLENGE_ROGUE_TEAM_STAGE_TASK] = handler(self, self.UpdateChallengeRogueTeamIllustratedRedTip),
			[TaskConst.TASK_TYPE.CHAPTER_PLOT_23] = handler(self, self.UpdateChapterV2TaskRedTip),
			[TaskConst.TASK_TYPE.CHAPTER_PLOT_24] = handler(self, self.UpdateChapterV2TaskRedTip)
		}
	end,
	StartUpdateRedPointPhase = function(self, arg_2_1)
		self:InitRedUpdater()

		local var_2_0 = {}
		local var_2_1 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			if AssignmentCfg[iter_2_1.id] == nil then
				Debug.LogError("TaskCfg没有对应ID:" .. iter_2_1.id)
			elseif AssignmentCfg[iter_2_1.id].activity_id and AssignmentCfg[iter_2_1.id].activity_id ~= 0 and AssignmentCfg[iter_2_1.id].type ~= TaskConst.TASK_TYPE.SUMMER_CHESS_BOARD_EXPLORE_NOTE and AssignmentCfg[iter_2_1.id].type ~= TaskConst.TASK_TYPE.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_TASK and AssignmentCfg[iter_2_1.id].type ~= TaskConst.TASK_TYPE.CHALLENGE_ROGUE_TEAM_STAGE_TASK then
				var_2_1[AssignmentCfg[iter_2_1.id].activity_id] = var_2_1[AssignmentCfg[iter_2_1.id].activity_id] or {}

				table.insert(var_2_1[AssignmentCfg[iter_2_1.id].activity_id], iter_2_1.id)
			else
				var_2_0[AssignmentCfg[iter_2_1.id].type] = var_2_0[AssignmentCfg[iter_2_1.id].type] or {}

				table.insert(var_2_0[AssignmentCfg[iter_2_1.id].type], iter_2_1.id)
			end
		end

		for iter_2_2, iter_2_3 in pairs(var_2_0) do
			if self.redUpdater[iter_2_2] then
				self.redUpdater[iter_2_2](iter_2_3)
			end
		end

		self:UpdateActivityRed(var_2_1)
		self:UpdatePassportTaskRedTip()
		ActivityAction.UpdateRedPointDLC_5_2(ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC)
	end,
	UpdateActivityRed = function(arg_3_0, arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			local var_3_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_3_0)
			local var_3_1 = 0

			for iter_3_2, iter_3_3 in pairs((TaskData2:GetActivityTaskSortList(iter_3_0))) do
				if iter_3_3.progress >= AssignmentCfg[iter_3_3.id].need and iter_3_3.complete_flag < 1 then
					var_3_1 = 1

					break
				end
			end

			manager.redPoint:setTip(var_3_0, var_3_1)
		end
	end,
	UpdatePassportTaskRedTip = function(arg_4_0)
		if not (PassportData:IsOpen() and PassportData:IsUnlock()) then
			manager.redPoint:setTip(RedPointConst.PASSPORT_TASK_BONUS_7, 0)
			manager.redPoint:setTip(RedPointConst.PASSPORT_TASK_BONUS_8, 0)
			manager.redPoint:setTip(RedPointConst.PASSPORT_TASK_BONUS_9, 0)
		else
			local var_4_0 = PassportData:GetExpWeekly() >= GameSetting.battlepass_exp_limit_weekly.value[1]
			local var_4_1 = PassportData:GetLevel() >= #BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
			local var_4_2 = manager.time:GetServerTime()

			for iter_4_0, iter_4_1 in ipairs({
				TaskConst.TASK_TYPE.PASSPORT_DAILY,
				TaskConst.TASK_TYPE.PASSPORT_WEEKLY
			}) do
				local var_4_3 = 0

				for iter_4_2, iter_4_3 in ipairs((TaskTools:GetFinishTaskIds(iter_4_1))) do
					local var_4_4 = TaskData2:GetTask(iter_4_3).expired_timestamp or 0

					if var_4_4 > 0 and var_4_4 - var_4_2 > 0 or var_4_4 == 0 then
						var_4_3 = var_4_3 + 1
					end
				end

				manager.redPoint:setTip(RedPointConst["PASSPORT_TASK_BONUS_" .. iter_4_1], var_4_3 > 0 and not var_4_0 and not var_4_1 and 1 or 0)
			end

			for iter_4_4, iter_4_5 in ipairs({
				TaskConst.TASK_TYPE.PASSPORT_CHALLENGE
			}) do
				local var_4_5 = 0

				for iter_4_6, iter_4_7 in ipairs((TaskTools:GetFinishTaskIds(iter_4_5))) do
					local var_4_6 = TaskData2:GetTask(iter_4_7).expired_timestamp or 0

					if var_4_6 > 0 and var_4_6 - var_4_2 > 0 or var_4_6 == 0 then
						var_4_5 = var_4_5 + 1
					end
				end

				manager.redPoint:setTip(RedPointConst["PASSPORT_TASK_BONUS_" .. iter_4_5], var_4_5 > 0 and not var_4_1 and 1 or 0)
			end
		end
	end,
	UpdateWeekTaskRedTip = function(arg_5_0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_WEEK) then
			manager.redPoint:setTip(RedPointConst.TASK_WEEK, 0)

			return false
		end

		for iter_5_0, iter_5_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.WEEK))) do
			local var_5_0 = TaskData2:GetTask(iter_5_0)

			if var_5_0.progress >= AssignmentCfg[var_5_0.id].need and var_5_0.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.TASK_WEEK, 1)

				return true
			end
		end

		for iter_5_2 = 1, #ActivityPtCfg[ActivityPtConst.TASK_WEEK_ACTIVITY_PT].target do
			if ActivityPtCfg[ActivityPtConst.TASK_WEEK_ACTIVITY_PT].target[iter_5_2] <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_WEEK_ACTIVITY_PT) and not ActivityPtData:GetDailyGetRewardList()[ActivityPtConst.TASK_WEEK_ACTIVITY_PT][ActivityPtCfg[ActivityPtConst.TASK_WEEK_ACTIVITY_PT].target[iter_5_2]] then
				manager.redPoint:setTip(RedPointConst.TASK_WEEK, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.TASK_WEEK, 0)

		return false
	end,
	UpdateClubTaskRedTip = function(arg_6_0)
		local var_6_0 = GuildData:GetGuildInfo()

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CLUB_TASK) or var_6_0 == nil or var_6_0.id == nil then
			manager.redPoint:setTip(RedPointConst.CLUB_TASK, 0)

			return false
		end

		for iter_6_0, iter_6_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.CLUB_TASK))) do
			local var_6_1 = TaskData2:GetTask(iter_6_0)

			if var_6_1.progress >= AssignmentCfg[var_6_1.id].need and var_6_1.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.CLUB_TASK, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.CLUB_TASK, 0)

		return false
	end,
	UpdatePlotTaskRedTip = function(arg_7_0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_PLOT) then
			manager.redPoint:setTip(RedPointConst.TASK_PLOT, 0)

			return false
		end

		for iter_7_0, iter_7_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.PLOT))) do
			local var_7_0 = TaskData2:GetTask(iter_7_0)

			if var_7_0.progress >= AssignmentCfg[var_7_0.id].need and var_7_0.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.TASK_PLOT, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.TASK_PLOT, 0)

		return false
	end,
	UpdateDailyTaskRedTip = function(arg_8_0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_DAILY) then
			manager.redPoint:setTip(RedPointConst.TASK_DAILY, 0)

			return false
		end

		for iter_8_0, iter_8_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.DAILY))) do
			local var_8_0 = TaskData2:GetTask(iter_8_0)

			if var_8_0 and var_8_0.progress >= AssignmentCfg[var_8_0.id].need and var_8_0.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.TASK_DAILY, 1)

				return true
			end
		end

		for iter_8_2 = 1, #ActivityPtCfg[ActivityPtConst.TASK_DAILY_ACTIVITY_PT].target do
			if ActivityPtCfg[ActivityPtConst.TASK_DAILY_ACTIVITY_PT].target[iter_8_2] <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) and not ActivityPtData:GetDailyGetRewardList()[ActivityPtConst.TASK_DAILY_ACTIVITY_PT][ActivityPtCfg[ActivityPtConst.TASK_DAILY_ACTIVITY_PT].target[iter_8_2]] then
				manager.redPoint:setTip(RedPointConst.TASK_DAILY, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.TASK_DAILY, 0)

		return false
	end,
	UpdateNewbieTaskRedPoint = function(arg_9_0)
		local var_9_0 = TaskData2:GetAssignmentPhase()

		for iter_9_0, iter_9_1 in pairs((TaskTools:GetNewbieTaskSortList(var_9_0))) do
			if iter_9_1.progress >= AssignmentCfg[iter_9_1.id].need and iter_9_1.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

				return
			end
		end

		local var_9_1 = TaskTools:GetNewbiePhaseTask()[var_9_0]

		if var_9_1 then
			if AssignmentCfg[var_9_1.id] and var_9_1.progress >= AssignmentCfg[var_9_1.id].need and var_9_1.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 0)
	end,
	UpdateNewbieDailyTaskRedTip = function(arg_10_0)
		for iter_10_0, iter_10_1 in pairs((TaskData2:GetTypedTaskSortList(TaskConst.TASK_TYPE.DAILY_OFFER))) do
			if iter_10_1.progress >= AssignmentCfg[iter_10_1.id].need and iter_10_1.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 0)
	end,
	UpdateNoobTaskRedPoint = function(self, arg_11_1)
		local var_11_0
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			if AssignmentCfg[iter_11_1] == nil then
				print("TaskCfg没有对应ID:" .. iter_11_1)
			else
				var_11_0 = AssignmentCfg[iter_11_1].type
				var_11_1[AssignmentCfg[iter_11_1].phase] = true
			end
		end

		for iter_11_2, iter_11_3 in pairs(var_11_1) do
			self:UpdateNoobTaskRed(var_11_0, iter_11_2)
		end
	end,
	UpdateNoobTaskRed = function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = ActivityNoobData:GetUnlockPhase()

		for iter_12_0, iter_12_1 in pairs((TaskTools:GetNoobTaskSortList(arg_12_1, arg_12_2))) do
			if var_12_0 >= AssignmentCfg[iter_12_1.id].phase and iter_12_1.progress >= AssignmentCfg[iter_12_1.id].need and iter_12_1.complete_flag < 1 then
				manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_12_2), 1)

				return
			end
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_12_2), 0)
	end,
	UpdateNoobTaskRedFull = function(self, arg_13_1)
		for iter_13_0 = 1, ActivityNoobData:GetUnlockPhase() do
			self:UpdateNoobTaskRed(arg_13_1, iter_13_0)
		end
	end,
	UpdateNoobAdvanceTaskRedPoint = function(self, arg_14_1)
		local var_14_0 = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			if AssignmentCfg[iter_14_1] == nil then
				print("TaskCfg没有对应ID:" .. iter_14_1)
			else
				var_14_0[AssignmentCfg[iter_14_1].type] = var_14_0[AssignmentCfg[iter_14_1].type] or {}
				var_14_0[AssignmentCfg[iter_14_1].type][AssignmentCfg[iter_14_1].phase] = true
			end
		end

		for iter_14_2, iter_14_3 in pairs(var_14_0) do
			if ActivityNewbieTools.IsDataInited() and ActivityNewbieTools.CheckAdvanceTaskTypeOpen(iter_14_2) then
				for iter_14_4, iter_14_5 in pairs(iter_14_3) do
					self:UpdateNoobAdvanceTaskRed(iter_14_2, iter_14_4)
				end
			end
		end
	end,
	UpdateNoobAdvanceTaskRed = function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = ActivityNewbieTools.GetAdvanceTaskCfg(arg_15_1)

		for iter_15_0, iter_15_1 in ipairs(NoobAdvanceTaskPhaseListCfg[NoobVersionCfg[var_15_0.versionID].noob_advance_task_phase[var_15_0.index]].phase_list) do
			for iter_15_2, iter_15_3 in ipairs(iter_15_1[2]) do
				if iter_15_3[1] == arg_15_2 then
					for iter_15_4, iter_15_5 in pairs((TaskTools:GetNoobAdvanceTaskSortList(arg_15_1, arg_15_2))) do
						if AssignmentCfg[iter_15_5.id].need <= iter_15_5.progress and iter_15_5.complete_flag == 0 then
							manager.redPoint:setTip(string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, arg_15_1, iter_15_0, arg_15_2), 1)

							return
						end
					end

					manager.redPoint:setTip(string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, arg_15_1, iter_15_0, arg_15_2), 0)

					return
				end
			end
		end
	end,
	UpdateChapterPlot19RedTip = function(arg_16_0)
		if ChapterTools.IsFinishPreChapter(ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_19].chapter_list[1]) then
			for iter_16_0, iter_16_1 in ipairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19] or {}) do
				if not TaskData2:GetTaskComplete(iter_16_1) and TaskData2:GetTaskProgress(iter_16_1) >= AssignmentCfg[iter_16_1].need then
					manager.redPoint:setTip(RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR, 1)

					return
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR, 0)
	end,
	UpdateIdolTraineeDayAndWeekRedTip = function(arg_17_0)
		for iter_17_0, iter_17_1 in ipairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.IDOL_TRAINEE_DAILY] or {}) do
			if not TaskData2:GetTaskComplete(iter_17_1) and TaskData2:GetTaskProgress(iter_17_1) >= AssignmentCfg[iter_17_1].need then
				manager.redPoint:setTip(RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK, 1)

				return
			end
		end

		for iter_17_2, iter_17_3 in ipairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.IDOL_TRAINEE_WEEKLY] or {}) do
			if not TaskData2:GetTaskComplete(iter_17_3) and TaskData2:GetTaskProgress(iter_17_3) >= AssignmentCfg[iter_17_3].need then
				manager.redPoint:setTip(RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK, 0)
	end,
	UpdateIdolTraineeChapterRedTip = function(arg_18_0)
		for iter_18_0, iter_18_1 in ipairs(IdolTraineeChapterCfg.all) do
			local var_18_1 = false

			for iter_18_2, iter_18_3 in ipairs(IdolTraineeChapterCfg[iter_18_1].section_id_list) do
				if var_18_1 then
					break
				end

				for iter_18_4, iter_18_5 in ipairs(IdolTraineePveBattleCfg[iter_18_3].taskIDList) do
					if var_18_1 then
						break
					end

					if not TaskData2:GetTaskComplete(iter_18_5) and TaskData2:GetTaskProgress(iter_18_5) >= AssignmentCfg[iter_18_5].need then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, iter_18_1), 1)

						var_18_1 = true
					end
				end
			end

			if not var_18_1 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, iter_18_1), 0)
			end
		end
	end,
	UpdateSummerExploreNoteRedTip = function(arg_19_0)
		for iter_19_0, iter_19_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.SUMMER_CHESS_BOARD_EXPLORE_NOTE))) do
			local var_19_1 = AssignmentCfg[iter_19_0]
			local var_19_2 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_REWARD, iter_19_0)
			local var_19_3 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_NEW, iter_19_0)

			if not TaskData2:GetTaskComplete(iter_19_0) and TaskData2:GetTaskProgress(iter_19_0) >= var_19_1.need and #var_19_1.reward > 0 then
				manager.redPoint:setTip(var_19_2, 1)
			else
				manager.redPoint:setTip(var_19_2, 0)
			end

			if iter_19_0 == GameSetting.summer_note_video.value[1] then
				if TaskData2:GetTaskProgress(iter_19_0) >= var_19_1.need and getData("SUMMER_3.5_NOTE", "IS_CLICK") == nil then
					manager.redPoint:setTip(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO, 1)
				else
					manager.redPoint:setTip(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO, 0)
				end
			end

			if not TaskData2:GetTaskComplete(iter_19_0) and TaskData2:GetTaskProgress(iter_19_0) >= var_19_1.need then
				manager.redPoint:setTip(var_19_3, ActivityUnlockStateData:GetUnlockState(ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE][1])[iter_19_0] ~= 1 and 1 or 0)
			else
				manager.redPoint:setTip(var_19_3, 0)
			end
		end
	end,
	UpdatePolyhedronResidentTaskRedTip = function()
		for iter_20_0, iter_20_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.POLYHEDRON_RESIDENT_TASK))) do
			if not TaskData2:GetTaskComplete(iter_20_0) and TaskData2:GetTaskProgress(iter_20_0) >= AssignmentCfg[iter_20_0].need and #AssignmentCfg[iter_20_0].reward > 0 then
				manager.redPoint:setTip(RedPointConst.POLYHEDRON_RESIDENT_TASK, 1)

				return
			end

			manager.redPoint:setTip(RedPointConst.POLYHEDRON_RESIDENT_TASK, 0)
		end
	end,
	UpdateChallengeRogueTeamIllustratedRedTip = function(arg_21_0, arg_21_1)
		local var_21_0

		for iter_21_0, iter_21_1 in pairs(arg_21_1) do
			local var_21_2 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_21_1)
			local var_21_3 = TaskData2:GetTask(iter_21_1)

			if ActivityCfg[AssignmentCfg[iter_21_1].activity_id].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_TASK then
				var_21_0 = AssignmentCfg[iter_21_1].activity_id
			end

			manager.redPoint:setTip(var_21_2, (var_21_3.progress >= AssignmentCfg[var_21_3.id].need and var_21_3.complete_flag < 1 and ActivityCfg[AssignmentCfg[iter_21_1].activity_id].activity_template ~= ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_TASK or nil) and 1)
		end

		if var_21_0 then
			for iter_21_2, iter_21_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[var_21_0]) do
				local var_21_5 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_21_3)
				local var_21_6 = TaskData2:GetTask(iter_21_3)

				manager.redPoint:setTip(var_21_5, (var_21_6 and var_21_6.progress >= AssignmentCfg[var_21_6.id].need and var_21_6.complete_flag < 1 and ActivityCfg[AssignmentCfg[iter_21_3].activity_id].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_TASK and ChallengeRogueTeamData:GetUnCompletedTaskStage(AssignmentCfg[iter_21_3].activity_id) >= AssignmentCfg[iter_21_3].phase or nil) and 1)
			end
		end
	end,
	UpdateChapterV2TaskRedTip = function(arg_22_0, arg_22_1)
		local var_22_3 = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_23] or {}
		local var_22_4 = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_24] or {}
		local var_22_5 = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_25] or {}

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_TASK, 10123), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_TASK, 10124), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_TASK, 10125), 0)

		for iter_22_0, iter_22_1 in ipairs(var_22_3) do
			local var_22_6 = TaskData2:GetTask(iter_22_1)

			if var_22_6 and var_22_6.progress >= AssignmentCfg[var_22_6.id].need and var_22_6.complete_flag < 1 then
				for iter_22_2, iter_22_3 in ipairs(ChapterCfg.get_id_list_by_connect_group[10]) do
					local var_22_7 = table.indexof(ChapterCfg[iter_22_3].section_id_list, AssignmentCfg[iter_22_1].additional_parameter[1])

					if var_22_7 and var_22_7 > 0 then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_TASK, (iter_22_3 == 11123 or nil) and 10123), 1)
					end
				end

				break
			end
		end

		for iter_22_4, iter_22_5 in ipairs(var_22_4) do
			local var_22_9 = TaskData2:GetTask(iter_22_5)

			if var_22_9 and var_22_9.progress >= AssignmentCfg[var_22_9.id].need and var_22_9.complete_flag < 1 then
				for iter_22_6, iter_22_7 in ipairs(ChapterCfg.get_id_list_by_connect_group[10]) do
					local var_22_10 = table.indexof(ChapterCfg[iter_22_7].section_id_list, AssignmentCfg[iter_22_5].additional_parameter[1])

					if var_22_10 and var_22_10 > 0 then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_TASK, iter_22_7), 1)
					end
				end

				break
			end
		end

		for iter_22_8, iter_22_9 in ipairs(var_22_5) do
			local var_22_11 = TaskData2:GetTask(iter_22_9)

			if var_22_11 and var_22_11.progress >= AssignmentCfg[var_22_11.id].need and var_22_11.complete_flag < 1 then
				for iter_22_10, iter_22_11 in ipairs(ChapterCfg.get_id_list_by_connect_group[10]) do
					local var_22_12 = table.indexof(ChapterCfg[iter_22_11].section_id_list, AssignmentCfg[iter_22_9].additional_parameter[1])

					if var_22_12 and var_22_12 > 0 then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_TASK, iter_22_11), 1)
					end
				end

				break
			end
		end
	end
}
