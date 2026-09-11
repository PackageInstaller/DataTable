local var_0_0 = {
	CloseActivity = function(arg_1_0, arg_1_1)
		SPHeroChallengeData:ExitCurSystem()
		SPHeroChallengeData:DisposeActivityInfo(arg_1_1)
	end,
	CheckActivityCanClose = function(arg_2_0, arg_2_1)
		local var_2_0 = true

		for iter_2_0, iter_2_1 in ipairs(GameSetting.activity_hero_challenge_close_condition.value) do
			if not IsConditionAchieved(iter_2_1) then
				var_2_0 = false

				break
			end
		end

		return var_2_0
	end,
	CheckActivityCloseWithTips = function(self)
		local var_3_0 = SPHeroChallengeData:GetActivityID()

		if self:CheckActivityCanClose(var_3_0) then
			ShowTips("TIME_OVER")
		end

		return self:CheckActivityCanClose(var_3_0)
	end,
	GetOpenActivityID = function(arg_4_0)
		local var_4_0 = SPHeroChallengeData:GetTotalInfo()
		local var_4_1 = {}

		if var_4_0 then
			for iter_4_0, iter_4_1 in pairs(var_4_0) do
				table.insert(var_4_1, iter_4_0)
			end
		end

		return var_4_1
	end,
	CheckActivityIsOpen = function(self, arg_5_1)
		if arg_5_1 then
			return table.indexof(self:GetOpenActivityID(), arg_5_1)
		end
	end,
	EnterSystem = function(self, arg_6_1)
		if self:CheckActivityIsOpen(arg_6_1) then
			if self:CheckActivityCanClose(arg_6_1) then
				ShowTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_FINISH")

				return
			end

			if SPHeroChallengeData.activityCfg[arg_6_1] then
				SPHeroChallengeData:SetCurActivityID(arg_6_1)
				JumpTools.OpenPageByJump(SPHeroChallengeData.activityCfg[arg_6_1].enterView)
			end
		else
			ShowTips("SOLO_NOT_OPEN")
		end
	end,
	JumpSystemByScheduleType = function(self, arg_7_1, arg_7_2, arg_7_3)
		if not self:CheckActivityCloseWithTips() then
			if arg_7_1 == SpHeroChallengeConst.ScheduleSubType.story then
				JumpTools.OpenPageByJump("/spHeroChallengeBattleToggleView", {
					groupIndex = 1,
					isDetailJump = arg_7_2
				})
			elseif arg_7_1 == SpHeroChallengeConst.ScheduleSubType.train1 then
				JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
					playAnimation = true,
					trainType = arg_7_1
				})
			elseif arg_7_1 == SpHeroChallengeConst.ScheduleSubType.train2 then
				JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
					playAnimation = true,
					trainType = arg_7_1
				})
			elseif arg_7_1 == SpHeroChallengeConst.ScheduleSubType.train3 then
				JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
					playAnimation = true,
					trainType = arg_7_1
				})
			elseif arg_7_1 == SpHeroChallengeConst.ScheduleSubType.boss then
				JumpTools.OpenPageByJump("/spHeroChallengeBattleToggleView", {
					groupIndex = 3
				})
			elseif arg_7_1 == SpHeroChallengeConst.ScheduleSubType.decode then
				JumpTools.OpenPageByJump("/colorPuzzleSelectLevel", {
					isDetailJump = arg_7_2
				})
			elseif arg_7_1 == SpHeroChallengeConst.ScheduleSubType.barbuce then
				SPHeroChallengeAction:OnEnterBarbuceScene()
				SPHeroChallengeData:SavePageState(arg_7_3)
			elseif arg_7_1 == SpHeroChallengeConst.ScheduleSubType.entrust then
				JumpTools.OpenPageByJump("/spHeroChallengeEntrustView")
			end
		end
	end,
	AutoChooseSchedule = function(self)
		local var_8_0 = SPHeroChallengeData:GetCurActivityInfo()

		var_8_0:ClearScheduleDailyList()

		local var_8_1 = GameSetting.activity_hero_challenge_schedule_limit.value[1]
		local var_8_2 = {}
		local var_8_3 = {
			0.5,
			0.25,
			0.25
		}

		for iter_8_0, iter_8_1 in ipairs((self:GetCanChooseSchedule((SPHeroChallengeData:GetActivityID())))) do
			var_8_2[ActivityHeroChallengeScheduleCfg[iter_8_1].type] = var_8_2[ActivityHeroChallengeScheduleCfg[iter_8_1].type] or {}

			table.insert(var_8_2[ActivityHeroChallengeScheduleCfg[iter_8_1].type], iter_8_1)
		end

		for iter_8_2, iter_8_3 in pairs(var_8_2) do
			CommonTools.UniversalSortEx(iter_8_3, {
				ascend = true,
				map = function(arg_9_0)
					return ActivityHeroChallengeScheduleCfg[arg_9_0].priority
				end
			})
		end

		for iter_8_4, iter_8_5 in pairs(var_8_2) do
			local var_8_5 = 0

			for iter_8_6 = iter_8_4, #var_8_3 do
				var_8_5 = var_8_3[iter_8_6] + var_8_5
			end

			local var_8_6 = math.ceil(var_8_1 * (var_8_3[iter_8_4] / var_8_5))

			for iter_8_7, iter_8_8 in ipairs(iter_8_5) do
				while true do
					if self:CheckScheduleCanAddInlist(iter_8_8, true) then
						var_8_0:AddScheduleInDailyList(iter_8_8)

						var_8_6 = var_8_6 - 1
						var_8_1 = var_8_1 - 1

						if var_8_6 <= 0 then
							break
						end
					else
						break
					end
				end

				if var_8_6 <= 0 then
					break
				end
			end

			if var_8_1 <= 0 then
				break
			end
		end
	end,
	ShowAutoScheduleTips = function(self, arg_10_1)
		local var_10_0 = true

		for iter_10_0 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
			local var_10_1, var_10_2 = SPHeroChallengeData:GetCurActivityInfo():GetTrainNumByType(iter_10_0)

			if var_10_1 < var_10_2 then
				var_10_0 = false

				return
			end
		end

		local var_10_3, var_10_4 = self:GetScheduleProgress(SpHeroChallengeConst.ScheduleID.Decode)

		if var_10_3 < var_10_4 then
			var_10_0 = false
		end

		local var_10_5 = SPHeroChallengeData:GetCurActivityInfo()

		return var_10_0
	end,
	GetCanChooseSchedule = function(self, arg_11_1)
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in ipairs(ActivityHeroChallengeScheduleCfg.all) do
			if self:CheckScheduleCanAddInlist(iter_11_1) then
				table.insert(var_11_0, iter_11_1)
			end
		end

		return var_11_0
	end,
	GetScheduleProgress = function(self, arg_12_1, arg_12_2)
		local var_12_0 = SPHeroChallengeData:GetCurActivityInfo()

		if arg_12_1 == SpHeroChallengeConst.ScheduleID.Entrust or arg_12_1 == SpHeroChallengeConst.ScheduleID.Barbecue or arg_12_1 == SpHeroChallengeConst.ScheduleID.Boss then
			return -1, -1
		elseif arg_12_1 == SpHeroChallengeConst.ScheduleID.Awake then
			return #var_12_0.storyFinStageList + ((arg_12_2 or nil) and self:GetSameScheduleNum(arg_12_1)), #ChapterCfg[SPHeroChallengeData.activityCfg[var_12_0.activityID].storyChapter].section_id_list
		elseif arg_12_1 == SpHeroChallengeConst.ScheduleID.Endurance or arg_12_1 == SpHeroChallengeConst.ScheduleID.Deter or arg_12_1 == SpHeroChallengeConst.ScheduleID.Explode then
			return -1, -1
		elseif arg_12_1 == SpHeroChallengeConst.ScheduleID.Decode then
			return (ColorPuzzleData:GetClearedLevelCount() or 0) + ((arg_12_2 or nil) and self:GetSameScheduleNum(arg_12_1)), #ActivityHeroChallengeColor.all
		end

		return 0, 100
	end,
	CheckScheduleIsUnlock = function(arg_13_0, arg_13_1)
		if ActivityHeroChallengeScheduleCfg[arg_13_1] then
			for iter_13_0, iter_13_1 in ipairs(ActivityHeroChallengeScheduleCfg[arg_13_1].pre_condition) do
				if not IsConditionAchieved(iter_13_1) then
					return false, (SPHeroChallengeTools:GetConditionDesc(iter_13_1))
				end
			end

			return true
		else
			Debug.LogError("未获取到日程配置" .. arg_13_1)
		end
	end,
	CheckScheduleIsRemove = function(arg_14_0, arg_14_1)
		if ActivityHeroChallengeScheduleCfg[arg_14_1] then
			local var_14_0 = true

			if ActivityHeroChallengeScheduleCfg[arg_14_1].remove_condition then
				if not next(ActivityHeroChallengeScheduleCfg[arg_14_1].remove_condition) then
					var_14_0 = false
				end

				for iter_14_0, iter_14_1 in ipairs(ActivityHeroChallengeScheduleCfg[arg_14_1].remove_condition) do
					if not IsConditionAchieved(iter_14_1) then
						var_14_0 = false

						return false, (SPHeroChallengeTools:GetConditionDesc(iter_14_1))
					end
				end
			end

			return var_14_0
		else
			Debug.LogError("未获取到日程配置" .. arg_14_1)
		end
	end,
	GetSameScheduleNum = function(arg_15_0, arg_15_1)
		local var_15_0 = 0

		for iter_15_0, iter_15_1 in ipairs((SPHeroChallengeData:GetCurActivityInfo():GetScheduleDailyList())) do
			if iter_15_1 == arg_15_1 then
				var_15_0 = var_15_0 + 1
			end
		end

		return var_15_0
	end,
	CheckFinishForHeroTask = function(arg_16_0, arg_16_1)
		local var_16_0 = false
		local var_16_1 = TaskData2:GetTask(arg_16_1)

		if AssignmentCfg[arg_16_1] then
			if var_16_1 and (AssignmentCfg[arg_16_1].need or 0) <= var_16_1.progress then
				var_16_0 = true
			end
		end

		return var_16_0
	end
}

function var_0_0:CheckScheduleCanAddInlist(arg_17_1, arg_17_2)
	local var_17_0 = true
	local var_17_1 = ""
	local var_17_2 = "unlock"

	if not self:CheckScheduleIsUnlock(arg_17_1) then
		var_17_0 = false
		var_17_1 = SPHeroChallengeTools:GetConditionDesc(ActivityHeroChallengeScheduleCfg[arg_17_1].pre_condition[1])
		var_17_2 = "lock"
	end

	if not ActivityData:GetActivityIsOpen(ActivityHeroChallengeScheduleCfg[arg_17_1].activity_id) then
		var_17_1 = GetTips("SOLO_NOT_OPEN")
		var_17_2 = "lock"
	end

	if arg_17_1 == SpHeroChallengeConst.ScheduleID.Boss and not SPHeroChallengeData:GetCurActivityInfo().bossStart then
		var_17_0 = false
		var_17_1 = GetTips("SOLO_NOT_OPEN")
		var_17_2 = "lock"
	end

	local var_17_3, var_17_4 = self:GetScheduleProgress(arg_17_1, true)

	if var_17_3 >= 0 and var_17_4 <= var_17_3 then
		var_17_0 = false
		var_17_1 = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_FINISH")
		var_17_2 = "finish"
	end

	if arg_17_2 then
		local var_17_5 = var_0_0:CheckFinishForHeroTask(SpHeroChallengeConst.ScheduleID.Awake_hero)
		local var_17_6 = var_0_0:CheckFinishForHeroTask(SpHeroChallengeConst.ScheduleID.Barbecue_hero)

		if var_17_5 and (not var_17_5 or not var_17_6 or not var_0_0:CheckFinishForHeroTask(SpHeroChallengeConst.ScheduleID.Barbecue_hero)) then
			if var_17_6 and arg_17_1 == SpHeroChallengeConst.ScheduleID.Barbecue then
				var_17_0 = false
				var_17_1 = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_FINISH")
				var_17_2 = "finish"
			end

			if arg_17_1 == SpHeroChallengeConst.ScheduleID.Endurance or arg_17_1 == SpHeroChallengeConst.ScheduleID.Deter or arg_17_1 == SpHeroChallengeConst.ScheduleID.Explode then
				var_17_0 = false
				var_17_1 = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_FINISH")
				var_17_2 = "finish"
			end
		end
	end

	if self:CheckScheduleIsRemove(arg_17_1) then
		var_17_0 = false
		var_17_2 = "finish"
		var_17_1 = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_FINISH")
	end

	return var_17_0, var_17_1, var_17_2
end

function var_0_0.GetNextCanBattleStageID(arg_18_0, arg_18_1)
	if arg_18_1 == SpHeroChallengeConst.ScheduleSubType.story then
		return SPHeroChallengeData:GetCurActivityInfo():GetNextStoryStageIDList()
	elseif arg_18_1 == SpHeroChallengeConst.ScheduleSubType.decode then
		return ColorPuzzleData:GetNextStage()
	end
end

local function var_0_1(arg_19_0, arg_19_1)
	if SPHeroChallengeData.activityCfg[arg_19_1] then
		if arg_19_0 <= SPHeroChallengeData.activityCfg[arg_19_1].maxEntrusNum then
			if arg_19_0 <= var_0_0:GetCanOperationEntrustNum(arg_19_1) then
				return true
			end
		else
			return var_0_0:CheckEntrustWaitListOpen(arg_19_1, arg_19_0)
		end
	end
end

function var_0_0:GetEntrustPosState(arg_20_1, arg_20_2)
	if self:CheckActivityIsOpen(arg_20_1) then
		if not var_0_1(arg_20_2, arg_20_1) then
			return SpHeroChallengeConst.EntrustPosState.lock
		end

		local var_20_0 = SPHeroChallengeData:GetActivityData(arg_20_1)
		local var_20_1 = var_20_0:GetEntrustInfoByIndex(arg_20_2)

		if not var_20_1 or not next(var_20_1) then
			return SpHeroChallengeConst.EntrustPosState.empty
		end

		if var_20_0:GetEntrustEndTime(arg_20_2) then
			return SpHeroChallengeConst.EntrustPosState.fin
		else
			return SpHeroChallengeConst.EntrustPosState.start
		end
	end
end

function var_0_0.GetCanWaitEntrustNum(arg_21_0, arg_21_1)
	local var_21_0 = 0

	if SPHeroChallengeData.activityCfg[arg_21_1] then
		for iter_21_0 = #SPHeroChallengeData.activityCfg[arg_21_1].waitEntrustListOpenCondition, 1, -1 do
			if IsConditionAchieved(SPHeroChallengeData.activityCfg[arg_21_1].waitEntrustListOpenCondition[iter_21_0][2]) then
				var_21_0 = math.max(var_21_0, SPHeroChallengeData.activityCfg[arg_21_1].waitEntrustListOpenCondition[iter_21_0][1])

				break
			end
		end
	end

	return var_21_0
end

function var_0_0.GetCanOperationEntrustNum(arg_22_0, arg_22_1)
	if SPHeroChallengeData.activityCfg[arg_22_1] then
		return SPHeroChallengeData.activityCfg[arg_22_1].maxEntrusNum
	else
		Debug.LogError("未获取到对应活动的配置数据" .. arg_22_1)
	end
end

function var_0_0:CheckCanStartEntrust(arg_23_1, arg_23_2)
	local var_23_0

	if ActivityHeroChallengeTaskCfg[arg_23_1] then
		if self:GetCanStartEntrustNum(arg_23_2) <= 0 then
			local var_23_1 = false

			var_23_0 = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_FULL")
		end

		for iter_23_0, iter_23_1 in ipairs(ActivityHeroChallengeTaskCfg[arg_23_1].cost) do
			if (ItemTools.getItemNum(iter_23_1[1]) or 0) < iter_23_1[2] then
				var_23_1 = false
				var_23_0 = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_NONE_MATERIAL")

				break
			end
		end

		return true, var_23_0
	end
end

function var_0_0:GetEntrustLockDesc(arg_24_1)
	local var_24_0 = SPHeroChallengeData:GetCurActivityInfo()

	if arg_24_1 > self:GetCanOperationEntrustNum((SPHeroChallengeData:GetActivityID())) then
		for iter_24_0, iter_24_1 in ipairs(GameSetting.activity_hero_challenge_task_condition.value) do
			if arg_24_1 == iter_24_1[1] then
				if IsConditionAchieved(iter_24_1[2]) then
					return true, self:GetConditionDesc(iter_24_1[2])
				else
					return false, self:GetConditionDesc(iter_24_1[2])
				end
			end
		end
	end
end

function var_0_0:GetCanStartEntrustNum()
	local var_25_0 = SPHeroChallengeData:GetActivityID()

	return (math.max(self:GetCanWaitEntrustNum(var_25_0) + self:GetCanOperationEntrustNum(var_25_0) - SPHeroChallengeData:GetCurActivityInfo():GetReceiveEntrustNum(), 0))
end

function var_0_0.GetAcceleratorNumByIndex(arg_26_0, arg_26_1)
	local var_26_0, var_26_1 = SPHeroChallengeData:GetCurActivityInfo():GetEntrustEndTime(arg_26_1)

	return (not var_26_0 or nil) and math.ceil(var_26_1 / 3600)
end

function var_0_0.CheckEntrustWaitListOpen(arg_27_0, arg_27_1, arg_27_2)
	if SPHeroChallengeData.activityCfg[arg_27_1] then
		for iter_27_0, iter_27_1 in ipairs(SPHeroChallengeData.activityCfg[arg_27_1].waitEntrustListOpenCondition) do
			if iter_27_1[1] == arg_27_2 - SPHeroChallengeData.activityCfg[arg_27_1].maxEntrusNum then
				return IsConditionAchieved(iter_27_1[2])
			end
		end

		return false
	end
end

function var_0_0.GetOpenWaitEntrustListNum(arg_28_0, arg_28_1)
	local var_28_0 = 0

	if SPHeroChallengeData.activityCfg[arg_28_1] then
		for iter_28_0, iter_28_1 in ipairs(SPHeroChallengeData.activityCfg[arg_28_1].waitEntrustListOpenCondition) do
			if IsConditionAchieved(iter_28_1[2]) then
				var_28_0 = var_28_0 + 1
			end
		end
	end

	return var_28_0
end

function var_0_0.GetMaxStartEntrustPosNum(arg_29_0, arg_29_1)
	if SPHeroChallengeData.activityCfg[arg_29_1] then
		return SPHeroChallengeData.activityCfg[arg_29_1].maxEntrusNum
	end
end

function var_0_0.GetMaxWaitEntrustPosNum(arg_30_0, arg_30_1)
	if SPHeroChallengeData.activityCfg[arg_30_1] then
		return #SPHeroChallengeData.activityCfg[arg_30_1].waitEntrustListOpenCondition
	end
end

function var_0_0:GetMaxTotleEntrustPosNum(arg_31_1)
	if SPHeroChallengeData.activityCfg[arg_31_1] then
		return self:GetMaxStartEntrustPosNum(arg_31_1) + self:GetMaxWaitEntrustPosNum(arg_31_1)
	end
end

function var_0_0:CheckNeedRefreshEntrust()
	local var_32_0 = SPHeroChallengeData:GetActivityID()
	local var_32_1 = SPHeroChallengeData:GetActivityData(var_32_0)

	if var_32_1 then
		local var_32_2 = self:GetMaxStartEntrustPosNum(var_32_0)

		for iter_32_0, iter_32_1 in ipairs((var_32_1:GetCanGetRewardEntrustIndexList())) do
			if iter_32_1 <= var_32_2 then
				return true
			end
		end
	end

	return false
end

local function var_0_2(arg_33_0, arg_33_1)
	local var_33_0 = {}

	if arg_33_0 and arg_33_1 then
		for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
			if arg_33_0 >= iter_33_1[1] then
				table.insert(var_33_0, iter_33_1[2])
			end
		end
	end

	return var_33_0
end

function var_0_0.GetUnlockAffix(arg_34_0)
	local var_34_0 = SPHeroChallengeData:GetActivityID()
	local var_34_1 = SPHeroChallengeData:GetCurActivityInfo()
	local var_34_2 = {}

	for iter_34_0 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		for iter_34_1, iter_34_2 in ipairs((var_0_2(var_34_1:GetTrainNumByType(iter_34_0), ActivityHeroChallengeCfg[var_34_0]["affix_group_" .. iter_34_0 - 1]))) do
			table.insert(var_34_2, iter_34_2)
		end
	end

	return var_34_2
end

function var_0_0:GetUnlockChapterAffix()
	local var_35_0 = {}
	local var_35_1 = SPHeroChallengeData:GetActivityID()

	for iter_35_0 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		if self:CheckBattleRouteIsOpen(iter_35_0) then
			table.insert(var_35_0, ActivityHeroChallengeCfg[var_35_1].affix_unlock[iter_35_0 - 1])
		end
	end

	return var_35_0
end

function var_0_0:CheckStageIsOpen(arg_36_1)
	if BattleVerthandiExclusiveCfg[arg_36_1] then
		local var_36_0 = false
		local var_36_1 = ""

		if ChapterCfg[SpHeroChallengeConst.chapterID[BattleVerthandiExclusiveCfg[arg_36_1].sub_type]].unlock_activity_id > 0 and not ActivityData:GetActivityIsOpen(ChapterCfg[SpHeroChallengeConst.chapterID[BattleVerthandiExclusiveCfg[arg_36_1].sub_type]].unlock_activity_id) then
			var_36_0 = true

			local var_36_2 = ActivityData:GetActivityData(ChapterCfg[SpHeroChallengeConst.chapterID[BattleVerthandiExclusiveCfg[arg_36_1].sub_type]].unlock_activity_id)

			var_36_1 = var_36_2 and manager.time:GetServerTime() < var_36_2.startTime and GetTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_36_2.startTime))) or GetTips("TIME_OVER")
		end

		for iter_36_0, iter_36_1 in ipairs(BattleVerthandiExclusiveCfg.all) do
			if arg_36_1 == BattleVerthandiExclusiveCfg[iter_36_1].next_unlock_id_list[1] and not self:IsClearStage(iter_36_1) then
				var_36_0 = true
				var_36_1 = GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
			end
		end

		if BattleVerthandiExclusiveCfg[arg_36_1].sub_type ~= SpHeroChallengeConst.BattleSubType.story then
			local var_36_3, var_36_4 = self:CheckScheduleIsUnlock(SpHeroChallengeConst.scheduleIndex[BattleVerthandiExclusiveCfg[arg_36_1].sub_type])

			if not var_36_3 then
				var_36_0 = true
				var_36_1 = var_36_4
			end
		end

		return var_36_0, var_36_1
	else
		Debug.LogError("未获取到关卡配置信息" .. arg_36_1)
	end
end

function var_0_0:CheckStoryStageCanBattle(arg_37_1)
	if BattleVerthandiExclusiveCfg[arg_37_1] then
		local var_37_0 = false
		local var_37_1 = ""

		if BattleVerthandiExclusiveCfg[arg_37_1].sub_type == SpHeroChallengeConst.BattleSubType.story and not self:IsClearStage(arg_37_1) then
			local var_37_2, var_37_3 = SPHeroChallengeData:GetCurActivityInfo():GetStartBattelScheduleByType(BattleVerthandiExclusiveCfg[arg_37_1].sub_type)

			if var_37_2 <= var_37_3 then
				var_37_0 = true
				var_37_1 = GetTips("ACTIVITY_HERO_CHALLENGE_TIME_NULL")
			end
		end

		return var_37_0, var_37_1
	end
end

function var_0_0:CheckScheduleNeedCostTime(arg_38_1)
	if BattleVerthandiExclusiveCfg[arg_38_1] then
		if BattleVerthandiExclusiveCfg[arg_38_1].sub_type == SpHeroChallengeConst.BattleSubType.story then
			return self:IsClearStage(arg_38_1)
		else
			return false
		end
	end
end

function var_0_0.IsClearStage(arg_39_0, arg_39_1)
	if BattleVerthandiExclusiveCfg[arg_39_1] then
		local var_39_0 = SPHeroChallengeData:GetCurActivityInfo()

		if BattleVerthandiExclusiveCfg[arg_39_1].sub_type == SpHeroChallengeConst.ScheduleSubType.story then
			return true
		elseif BattleVerthandiExclusiveCfg[arg_39_1].sub_type == SpHeroChallengeConst.ScheduleSubType.train1 or BattleVerthandiExclusiveCfg[arg_39_1].sub_type == SpHeroChallengeConst.ScheduleSubType.train2 or BattleVerthandiExclusiveCfg[arg_39_1].sub_type == SpHeroChallengeConst.ScheduleSubType.train3 then
			if var_39_0.trainInfo[BattleVerthandiExclusiveCfg[arg_39_1].sub_type] then
				return table.indexof(var_39_0.trainInfo[BattleVerthandiExclusiveCfg[arg_39_1].sub_type].passStageList, arg_39_1)
			else
				return false
			end
		end

		return true
	else
		Debug.LogError("未获取到关卡配置信息" .. arg_39_1)
	end
end

function var_0_0.CalStageScore(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	return GameSetting.activity_hero_challenge_boss_basescore.value[1] - math.max(GameSetting.activity_hero_challenge_boss_timescore.value[2] - GameSetting.activity_hero_challenge_boss_timescore.value[1] * arg_40_3, 0)
end

function var_0_0.GetTrainTypeName(arg_41_0, arg_41_1)
	return GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TYPE_" .. arg_41_1)
end

function var_0_0:GetTrainPercentByStage(arg_42_1, arg_42_2)
	if SPHeroChallengeData:GetCurActivityInfo() then
		local var_42_1 = self:GetTrainScoreByStage(arg_42_1, arg_42_2)

		return var_42_1, math.ceil(var_42_1 / GameSetting.activity_hero_challenge_base_num.value[1] * 100)
	end
end

function var_0_0.GetTrainScoreByStage(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = SPHeroChallengeData:GetCurActivityInfo()

	if var_43_0 then
		local var_43_1 = var_43_0:GetTrainNumByType(BattleVerthandiExclusiveCfg[arg_43_1].sub_type)
		local var_43_2 = -1

		for iter_43_0, iter_43_1 in ipairs(GameSetting["activity_hero_challenge_train_num_" .. arg_43_2].value) do
			if var_43_1 <= iter_43_1[1] then
				var_43_2 = iter_43_1[2]

				break
			end
		end

		if var_43_2 < 0 then
			var_43_2 = GameSetting["activity_hero_challenge_train_num_" .. arg_43_2].value[#GameSetting["activity_hero_challenge_train_num_" .. arg_43_2].value][2]
		end

		return var_43_2
	end
end

function var_0_0:GetChapterIsOpen(arg_44_1)
	if ChapterCfg[arg_44_1] then
		if ChapterCfg[arg_44_1].unlock_activity_id and ChapterCfg[arg_44_1].unlock_activity_id > 0 and not ActivityTools.GetActivityIsOpenWithTip(ChapterCfg[arg_44_1].unlock_activity_id, false) then
			return false, "SOLO_NOT_OPEN"
		end

		local var_44_0 = SPHeroChallengeData:GetActivityID()

		if var_44_0 and ChapterCfg[arg_44_1].unlock_activity_id == SPHeroChallengeData.activityCfg[var_44_0].bossActivityID and not SPHeroChallengeData:GetCurActivityInfo().bossStart then
			return false, "ACTIVITY_HERO_CHALLENGE_BOSS_OPEN_TIME"
		end

		local var_44_1 = {}

		if ChapterCfg[arg_44_1].group == SpHeroChallengeConst.ChapterType.story then
			var_44_1 = ActivityHeroChallengeScheduleCfg[SpHeroChallengeConst.ScheduleID.Awake].pre_condition
		elseif ChapterCfg[arg_44_1].group == SpHeroChallengeConst.ChapterType.train then
			var_44_1 = ActivityHeroChallengeScheduleCfg[SpHeroChallengeConst.ScheduleID.Endurance].pre_condition
		elseif ChapterCfg[arg_44_1].group == SpHeroChallengeConst.ChapterType.boss then
			var_44_1 = ActivityHeroChallengeScheduleCfg[SpHeroChallengeConst.ScheduleID.Boss].pre_condition
		end

		for iter_44_0, iter_44_1 in ipairs(var_44_1) do
			if not IsConditionAchieved(iter_44_1) then
				return false, (self:GetConditionDesc(iter_44_1))
			end
		end

		return true
	else
		Debug.LogError("未获取到章节配置" .. arg_44_1)
	end
end

function var_0_0:CheckBattleRouteIsOpen(arg_45_1)
	if ActivityHeroChallengeScheduleCfg.get_id_list_by_server_type[arg_45_1][1] then
		local var_45_0 = true

		for iter_45_0, iter_45_1 in ipairs(ActivityHeroChallengeScheduleCfg[ActivityHeroChallengeScheduleCfg.get_id_list_by_server_type[arg_45_1][1]].pre_condition) do
			if not IsConditionAchieved(iter_45_1) then
				var_45_0 = false

				return false, (self:GetConditionDesc(iter_45_1))
			end
		end

		return var_45_0
	else
		Debug.LogError("未获取到战斗类型对应的日程" .. arg_45_1)
	end
end

function var_0_0.GetStoryOpenStageList(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = SPHeroChallengeData:GetCurActivityInfo().storyFinStageList or {}
	local var_46_1 = ChapterCfg[arg_46_1].section_id_list
	local var_46_2 = {}

	table.insert(var_46_2, ChapterCfg[arg_46_1].section_id_list[1])

	for iter_46_0, iter_46_1 in ipairs(var_46_1) do
		if table.indexof(var_46_0, iter_46_1) then
			table.insert(var_46_2, iter_46_1)

			for iter_46_2, iter_46_3 in ipairs((arg_46_2[iter_46_1].next_show_id_list == "" or nil) and {}) do
				if not table.keyof(var_46_2, iter_46_3) then
					table.insert(var_46_2, iter_46_3)
				end
			end
		end
	end

	return var_46_2
end

function var_0_0.GetConditionDesc(arg_47_0, arg_47_1, arg_47_2)
	if ConditionCfg[arg_47_1] then
		if ConditionCfg[arg_47_1].type == 11200 or ConditionCfg[arg_47_1].type == 11201 or ConditionCfg[arg_47_1].type == 11202 or ConditionCfg[arg_47_1].type == 11204 or ConditionCfg[arg_47_1].type == 11205 then
			return ConditionCfg[arg_47_1].desc
		elseif ConditionCfg[arg_47_1].type == 11203 then
			return (string.format(GetI18NText(ConditionCfg[arg_47_1].desc), ConditionCfg[arg_47_1].params[2]))
		elseif ConditionCfg[arg_47_1].type == 11206 then
			return string.format(ConditionCfg[arg_47_1].desc, ConditionCfg[arg_47_1].params[2]), ConditionCfg[arg_47_1].params[1], ConditionCfg[arg_47_1].params[2]
		end
	end
end

function var_0_0.GetScheduleIcon(arg_48_0, arg_48_1)
	return getSpriteViaConfig("ActivityHeroChallengeScheduleIcon", arg_48_1)
end

function var_0_0.GetScheduleTypeName(arg_49_0, arg_49_1)
	local var_49_0

	if arg_49_1 == 1 then
		var_49_0 = SpHeroChallengeConst.ScheduleTypeName.Battle
	elseif arg_49_1 == 2 then
		var_49_0 = SpHeroChallengeConst.ScheduleTypeName.MiniGame
	elseif arg_49_1 == 3 then
		var_49_0 = SpHeroChallengeConst.ScheduleTypeName.Entrust
	end

	if var_49_0 then
		return GetTips(var_49_0)
	end
end

function var_0_0.GetTrainNameAndIcon(arg_50_0, arg_50_1)
	arg_50_1 = arg_50_1 - 1

	return GetTips("ACTIVITY_HERO_CHALLENGE_TRAIN_NAME_" .. arg_50_1), (getSpriteViaConfig("ActivityHeroChallengeTrain", "heroChallenge_icon_potential" .. arg_50_1))
end

function var_0_0.GetBarbuceGameAwardRefreshTime(arg_51_0)
	return string.format(GetTips("CANTEEN_TASK_REFRESH_COOLDOWN"), manager.time:GetLostTimeStrWith2Unit((manager.time:GetNextFreshTime())))
end

function var_0_0.GetBarbuceStageIDByDiff(arg_52_0, arg_52_1, arg_52_2)
	for iter_52_0, iter_52_1 in ipairs(ActivityHeroChallengeBarbecueCfg.all) do
		if ActivityHeroChallengeBarbecueCfg[iter_52_1].difficult == arg_52_1 and arg_52_2 == ActivityHeroChallengeBarbecueCfg[iter_52_1].activity_id then
			return iter_52_1
		end
	end
end

function var_0_0.GetBarbecueAwardIndex(arg_53_0, arg_53_1, arg_53_2)
	if ActivityHeroChallengeBarbecueCfg[arg_53_1] then
		local var_53_0 = 0

		for iter_53_0, iter_53_1 in ipairs(ActivityHeroChallengeBarbecueCfg[arg_53_1].reward_list_coin) do
			if arg_53_2 <= iter_53_1[2] then
				var_53_0 = iter_53_0
			end
		end

		if var_53_0 == 0 then
			var_53_0 = #ActivityHeroChallengeBarbecueCfg[arg_53_1].reward_list_coin
		end

		return var_53_0
	else
		Debug.LogError("未获取到烤肉关卡配置信息" .. arg_53_1)
	end
end

function var_0_0.CheckBossActivityIsOpen(arg_54_0)
	local var_54_0 = SPHeroChallengeData:GetActivityID()

	if var_54_0 then
		if ActivityTools.GetActivityIsOpenWithTip(SPHeroChallengeData.activityCfg[var_54_0].bossActivityID, false) and SPHeroChallengeData:GetCurActivityInfo().bossStart then
			return true
		end
	end
end

return var_0_0
