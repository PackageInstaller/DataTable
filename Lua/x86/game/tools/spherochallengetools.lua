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
	CheckActivityCloseWithTips = function(arg_3_0)
		local var_3_0 = SPHeroChallengeData:GetActivityID()

		if arg_3_0:CheckActivityCanClose(var_3_0) then
			ShowTips("TIME_OVER")
		end

		return arg_3_0:CheckActivityCanClose(var_3_0)
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
	CheckActivityIsOpen = function(arg_5_0, arg_5_1)
		if arg_5_1 then
			local var_5_0 = arg_5_0:GetOpenActivityID()

			return table.indexof(var_5_0, arg_5_1)
		end
	end,
	EnterSystem = function(arg_6_0, arg_6_1)
		if arg_6_0:CheckActivityIsOpen(arg_6_1) then
			if arg_6_0:CheckActivityCanClose(arg_6_1) then
				ShowTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_FINISH")

				return
			end

			local var_6_0 = SPHeroChallengeData.activityCfg[arg_6_1]

			if var_6_0 then
				local var_6_1 = var_6_0.enterView

				SPHeroChallengeData:SetCurActivityID(arg_6_1)
				JumpTools.OpenPageByJump(var_6_1)
			end
		else
			ShowTips("SOLO_NOT_OPEN")
		end
	end,
	JumpSystemByScheduleType = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		if not arg_7_0:CheckActivityCloseWithTips() then
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
	AutoChooseSchedule = function(arg_8_0)
		local var_8_0 = SPHeroChallengeData:GetCurActivityInfo()

		var_8_0:ClearScheduleDailyList()

		local var_8_1 = SPHeroChallengeData:GetActivityID()
		local var_8_2 = arg_8_0:GetCanChooseSchedule(var_8_1)
		local var_8_3 = GameSetting.activity_hero_challenge_schedule_limit.value[1]
		local var_8_4 = {}
		local var_8_5 = {
			0.5,
			0.25,
			0.25
		}

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			if not var_8_4[ActivityHeroChallengeScheduleCfg[iter_8_1].type] then
				var_8_4[ActivityHeroChallengeScheduleCfg[iter_8_1].type] = {}
			end

			table.insert(var_8_4[ActivityHeroChallengeScheduleCfg[iter_8_1].type], iter_8_1)
		end

		for iter_8_2, iter_8_3 in pairs(var_8_4) do
			CommonTools.UniversalSortEx(iter_8_3, {
				ascend = true,
				map = function(arg_9_0)
					return ActivityHeroChallengeScheduleCfg[arg_9_0].priority
				end
			})
		end

		for iter_8_4, iter_8_5 in pairs(var_8_4) do
			local var_8_6 = 0
			local var_8_7 = 0

			for iter_8_6 = iter_8_4, #var_8_5 do
				var_8_7 = var_8_5[iter_8_6] + var_8_7
			end

			local var_8_8 = var_8_5[iter_8_4] / var_8_7
			local var_8_9 = math.ceil(var_8_3 * var_8_8)

			for iter_8_7, iter_8_8 in ipairs(iter_8_5) do
				while true do
					if arg_8_0:CheckScheduleCanAddInlist(iter_8_8, true) then
						var_8_0:AddScheduleInDailyList(iter_8_8)

						var_8_9 = var_8_9 - 1
						var_8_3 = var_8_3 - 1

						if var_8_9 <= 0 then
							break
						end
					else
						break
					end
				end

				if var_8_9 <= 0 then
					break
				end
			end

			if var_8_3 <= 0 then
				break
			end
		end
	end,
	ShowAutoScheduleTips = function(arg_10_0, arg_10_1)
		local var_10_0 = true

		for iter_10_0 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
			local var_10_1, var_10_2 = SPHeroChallengeData:GetCurActivityInfo():GetTrainNumByType(iter_10_0)

			if var_10_1 < var_10_2 then
				var_10_0 = false

				return
			end
		end

		local var_10_3, var_10_4 = arg_10_0:GetScheduleProgress(SpHeroChallengeConst.ScheduleID.Decode)

		if var_10_3 < var_10_4 then
			var_10_0 = false
		end

		local var_10_5 = SPHeroChallengeData:GetCurActivityInfo()

		return var_10_0
	end,
	GetCanChooseSchedule = function(arg_11_0, arg_11_1)
		local var_11_0 = ActivityHeroChallengeScheduleCfg.all
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			if arg_11_0:CheckScheduleCanAddInlist(iter_11_1) then
				table.insert(var_11_1, iter_11_1)
			end
		end

		return var_11_1
	end,
	GetScheduleProgress = function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = SPHeroChallengeData:GetCurActivityInfo()

		if arg_12_1 == SpHeroChallengeConst.ScheduleID.Entrust or arg_12_1 == SpHeroChallengeConst.ScheduleID.Barbecue or arg_12_1 == SpHeroChallengeConst.ScheduleID.Boss then
			return -1, -1
		elseif arg_12_1 == SpHeroChallengeConst.ScheduleID.Awake then
			local var_12_1 = #var_12_0.storyFinStageList
			local var_12_2 = var_12_0.activityID
			local var_12_3 = #ChapterCfg[SPHeroChallengeData.activityCfg[var_12_2].storyChapter].section_id_list
			local var_12_4 = 0

			if arg_12_2 then
				var_12_4 = arg_12_0:GetSameScheduleNum(arg_12_1)
			end

			return var_12_1 + var_12_4, var_12_3
		elseif arg_12_1 == SpHeroChallengeConst.ScheduleID.Endurance or arg_12_1 == SpHeroChallengeConst.ScheduleID.Deter or arg_12_1 == SpHeroChallengeConst.ScheduleID.Explode then
			return -1, -1
		elseif arg_12_1 == SpHeroChallengeConst.ScheduleID.Decode then
			local var_12_5 = #ActivityHeroChallengeColor.all
			local var_12_6 = ColorPuzzleData:GetClearedLevelCount() or 0
			local var_12_7 = 0

			if arg_12_2 then
				var_12_7 = arg_12_0:GetSameScheduleNum(arg_12_1)
			end

			return var_12_6 + var_12_7, var_12_5
		end

		return 0, 100
	end,
	CheckScheduleIsUnlock = function(arg_13_0, arg_13_1)
		local var_13_0 = ActivityHeroChallengeScheduleCfg[arg_13_1]

		if var_13_0 then
			local var_13_1 = true

			for iter_13_0, iter_13_1 in ipairs(var_13_0.pre_condition) do
				if not IsConditionAchieved(iter_13_1) then
					local var_13_2 = false
					local var_13_3 = SPHeroChallengeTools:GetConditionDesc(iter_13_1)

					return var_13_2, var_13_3
				end
			end

			return true
		else
			Debug.LogError("未获取到日程配置" .. arg_13_1)
		end
	end,
	CheckScheduleIsRemove = function(arg_14_0, arg_14_1)
		local var_14_0 = ActivityHeroChallengeScheduleCfg[arg_14_1]

		if var_14_0 then
			local var_14_1 = true

			if var_14_0.remove_condition then
				if not next(var_14_0.remove_condition) then
					var_14_1 = false
				end

				for iter_14_0, iter_14_1 in ipairs(var_14_0.remove_condition) do
					if not IsConditionAchieved(iter_14_1) then
						var_14_1 = false

						local var_14_2 = SPHeroChallengeTools:GetConditionDesc(iter_14_1)

						return var_14_1, var_14_2
					end
				end
			end

			return var_14_1
		else
			Debug.LogError("未获取到日程配置" .. arg_14_1)
		end
	end,
	GetSameScheduleNum = function(arg_15_0, arg_15_1)
		local var_15_0 = SPHeroChallengeData:GetCurActivityInfo():GetScheduleDailyList()
		local var_15_1 = 0

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if iter_15_1 == arg_15_1 then
				var_15_1 = var_15_1 + 1
			end
		end

		return var_15_1
	end,
	CheckFinishForHeroTask = function(arg_16_0, arg_16_1)
		local var_16_0 = false
		local var_16_1 = TaskData2:GetTask(arg_16_1)
		local var_16_2 = AssignmentCfg[arg_16_1] and AssignmentCfg[arg_16_1].need or 0

		if var_16_1 and var_16_2 <= var_16_1.progress then
			var_16_0 = true
		end

		return var_16_0
	end
}

function var_0_0.CheckScheduleCanAddInlist(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = true
	local var_17_1 = ""
	local var_17_2 = "unlock"

	if not arg_17_0:CheckScheduleIsUnlock(arg_17_1) then
		var_17_0 = false

		local var_17_3 = ActivityHeroChallengeScheduleCfg[arg_17_1].pre_condition[1]

		var_17_1 = SPHeroChallengeTools:GetConditionDesc(var_17_3)
		var_17_2 = "lock"
	end

	local var_17_4 = ActivityHeroChallengeScheduleCfg[arg_17_1].activity_id

	if not ActivityData:GetActivityIsOpen(var_17_4) then
		var_17_1 = GetTips("SOLO_NOT_OPEN")
		var_17_2 = "lock"
	end

	if arg_17_1 == SpHeroChallengeConst.ScheduleID.Boss and not SPHeroChallengeData:GetCurActivityInfo().bossStart then
		var_17_0 = false
		var_17_1 = GetTips("SOLO_NOT_OPEN")
		var_17_2 = "lock"
	end

	local var_17_5, var_17_6 = arg_17_0:GetScheduleProgress(arg_17_1, true)

	if var_17_5 >= 0 and var_17_6 <= var_17_5 then
		var_17_0 = false
		var_17_1 = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_FINISH")
		var_17_2 = "finish"
	end

	if arg_17_2 then
		local var_17_7 = var_0_0:CheckFinishForHeroTask(SpHeroChallengeConst.ScheduleID.Awake_hero)
		local var_17_8 = var_0_0:CheckFinishForHeroTask(SpHeroChallengeConst.ScheduleID.Barbecue_hero)
		local var_17_9 = var_0_0:CheckFinishForHeroTask(SpHeroChallengeConst.ScheduleID.Barbecue_hero)

		if var_17_7 and (not var_17_7 or not var_17_8 or not var_17_9) then
			if var_17_8 and arg_17_1 == SpHeroChallengeConst.ScheduleID.Barbecue then
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

	if arg_17_0:CheckScheduleIsRemove(arg_17_1) then
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
	local var_19_0 = SPHeroChallengeData.activityCfg[arg_19_1]

	if var_19_0 then
		if arg_19_0 <= var_19_0.maxEntrusNum then
			if arg_19_0 <= var_0_0:GetCanOperationEntrustNum(arg_19_1) then
				return true
			end
		else
			return var_0_0:CheckEntrustWaitListOpen(arg_19_1, arg_19_0)
		end
	end
end

function var_0_0.GetEntrustPosState(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0:CheckActivityIsOpen(arg_20_1) then
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
	local var_21_0 = SPHeroChallengeData.activityCfg[arg_21_1]
	local var_21_1 = 0

	if var_21_0 then
		local var_21_2 = var_21_0.waitEntrustListOpenCondition

		for iter_21_0 = #var_21_2, 1, -1 do
			if IsConditionAchieved(var_21_2[iter_21_0][2]) then
				var_21_1 = math.max(var_21_1, var_21_2[iter_21_0][1])

				break
			end
		end
	end

	return var_21_1
end

function var_0_0.GetCanOperationEntrustNum(arg_22_0, arg_22_1)
	local var_22_0 = SPHeroChallengeData.activityCfg[arg_22_1]

	if var_22_0 then
		return var_22_0.maxEntrusNum
	else
		Debug.LogError("未获取到对应活动的配置数据" .. arg_22_1)
	end
end

function var_0_0.CheckCanStartEntrust(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = true
	local var_23_1
	local var_23_2 = ActivityHeroChallengeTaskCfg[arg_23_1]

	if var_23_2 then
		if arg_23_0:GetCanStartEntrustNum(arg_23_2) <= 0 then
			var_23_0 = false
			var_23_1 = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_FULL")
		end

		for iter_23_0, iter_23_1 in ipairs(var_23_2.cost) do
			if (ItemTools.getItemNum(iter_23_1[1]) or 0) < iter_23_1[2] then
				var_23_0 = false
				var_23_1 = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_NONE_MATERIAL")

				break
			end
		end

		return var_23_0, var_23_1
	end
end

function var_0_0.GetEntrustLockDesc(arg_24_0, arg_24_1)
	local var_24_0 = SPHeroChallengeData:GetActivityID()
	local var_24_1 = SPHeroChallengeData:GetCurActivityInfo()

	if arg_24_1 > arg_24_0:GetCanOperationEntrustNum(var_24_0) then
		local var_24_2 = GameSetting.activity_hero_challenge_task_condition.value

		for iter_24_0, iter_24_1 in ipairs(var_24_2) do
			if arg_24_1 == iter_24_1[1] then
				if IsConditionAchieved(iter_24_1[2]) then
					return true, arg_24_0:GetConditionDesc(iter_24_1[2])
				else
					return false, arg_24_0:GetConditionDesc(iter_24_1[2])
				end
			end
		end
	end
end

function var_0_0.GetCanStartEntrustNum(arg_25_0)
	local var_25_0 = SPHeroChallengeData:GetActivityID()
	local var_25_1 = SPHeroChallengeData:GetCurActivityInfo()
	local var_25_2 = arg_25_0:GetCanWaitEntrustNum(var_25_0)
	local var_25_3 = arg_25_0:GetCanOperationEntrustNum(var_25_0)
	local var_25_4 = var_25_1:GetReceiveEntrustNum()

	return (math.max(var_25_2 + var_25_3 - var_25_4, 0))
end

function var_0_0.GetAcceleratorNumByIndex(arg_26_0, arg_26_1)
	local var_26_0, var_26_1 = SPHeroChallengeData:GetCurActivityInfo():GetEntrustEndTime(arg_26_1)
	local var_26_2 = 0

	if not var_26_0 then
		var_26_2 = math.ceil(var_26_1 / 3600)
	end

	return var_26_2
end

function var_0_0.CheckEntrustWaitListOpen(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = SPHeroChallengeData.activityCfg[arg_27_1]

	if var_27_0 then
		local var_27_1 = var_27_0.waitEntrustListOpenCondition
		local var_27_2 = var_27_0.maxEntrusNum

		for iter_27_0, iter_27_1 in ipairs(var_27_1) do
			if iter_27_1[1] == arg_27_2 - var_27_2 then
				return IsConditionAchieved(iter_27_1[2])
			end
		end

		return false
	end
end

function var_0_0.GetOpenWaitEntrustListNum(arg_28_0, arg_28_1)
	local var_28_0 = SPHeroChallengeData.activityCfg[arg_28_1]
	local var_28_1 = 0

	if var_28_0 then
		local var_28_2 = var_28_0.waitEntrustListOpenCondition

		for iter_28_0, iter_28_1 in ipairs(var_28_2) do
			if IsConditionAchieved(iter_28_1[2]) then
				var_28_1 = var_28_1 + 1
			end
		end
	end

	return var_28_1
end

function var_0_0.GetMaxStartEntrustPosNum(arg_29_0, arg_29_1)
	local var_29_0 = SPHeroChallengeData.activityCfg[arg_29_1]

	if var_29_0 then
		return var_29_0.maxEntrusNum
	end
end

function var_0_0.GetMaxWaitEntrustPosNum(arg_30_0, arg_30_1)
	local var_30_0 = SPHeroChallengeData.activityCfg[arg_30_1]

	if var_30_0 then
		return #var_30_0.waitEntrustListOpenCondition
	end
end

function var_0_0.GetMaxTotleEntrustPosNum(arg_31_0, arg_31_1)
	if SPHeroChallengeData.activityCfg[arg_31_1] then
		return arg_31_0:GetMaxStartEntrustPosNum(arg_31_1) + arg_31_0:GetMaxWaitEntrustPosNum(arg_31_1)
	end
end

function var_0_0.CheckNeedRefreshEntrust(arg_32_0)
	local var_32_0 = SPHeroChallengeData:GetActivityID()
	local var_32_1 = SPHeroChallengeData:GetActivityData(var_32_0)

	if var_32_1 then
		local var_32_2 = var_32_1:GetCanGetRewardEntrustIndexList()
		local var_32_3 = arg_32_0:GetMaxStartEntrustPosNum(var_32_0)

		for iter_32_0, iter_32_1 in ipairs(var_32_2) do
			if iter_32_1 <= var_32_3 then
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
		local var_34_3 = ActivityHeroChallengeCfg[var_34_0]["affix_group_" .. iter_34_0 - 1]
		local var_34_4 = var_34_1:GetTrainNumByType(iter_34_0)
		local var_34_5 = var_0_2(var_34_4, var_34_3)

		for iter_34_1, iter_34_2 in ipairs(var_34_5) do
			table.insert(var_34_2, iter_34_2)
		end
	end

	return var_34_2
end

function var_0_0.GetUnlockChapterAffix(arg_35_0)
	local var_35_0 = {}
	local var_35_1 = SPHeroChallengeData:GetActivityID()

	for iter_35_0 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		if arg_35_0:CheckBattleRouteIsOpen(iter_35_0) then
			table.insert(var_35_0, ActivityHeroChallengeCfg[var_35_1].affix_unlock[iter_35_0 - 1])
		end
	end

	return var_35_0
end

function var_0_0.CheckStageIsOpen(arg_36_0, arg_36_1)
	local var_36_0 = BattleVerthandiExclusiveCfg[arg_36_1]

	if var_36_0 then
		local var_36_1 = false
		local var_36_2 = ""
		local var_36_3 = var_36_0.sub_type
		local var_36_4 = SpHeroChallengeConst.chapterID[var_36_3]
		local var_36_5 = ChapterCfg[var_36_4].unlock_activity_id

		if var_36_5 > 0 and not ActivityData:GetActivityIsOpen(var_36_5) then
			var_36_1 = true

			local var_36_6 = ActivityData:GetActivityData(var_36_5)
			local var_36_7 = manager.time:GetServerTime()

			if var_36_6 and var_36_7 < var_36_6.startTime then
				var_36_2 = GetTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_36_6.startTime)))
			else
				var_36_2 = GetTips("TIME_OVER")
			end
		end

		for iter_36_0, iter_36_1 in ipairs(BattleVerthandiExclusiveCfg.all) do
			if arg_36_1 == BattleVerthandiExclusiveCfg[iter_36_1].next_unlock_id_list[1] and not arg_36_0:IsClearStage(iter_36_1) then
				var_36_1 = true
				var_36_2 = GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
			end
		end

		if var_36_3 ~= SpHeroChallengeConst.BattleSubType.story then
			local var_36_8 = SpHeroChallengeConst.scheduleIndex[var_36_0.sub_type]
			local var_36_9, var_36_10 = arg_36_0:CheckScheduleIsUnlock(var_36_8)

			if not var_36_9 then
				var_36_1 = true
				var_36_2 = var_36_10
			end
		end

		return var_36_1, var_36_2
	else
		Debug.LogError("未获取到关卡配置信息" .. arg_36_1)
	end
end

function var_0_0.CheckStoryStageCanBattle(arg_37_0, arg_37_1)
	local var_37_0 = BattleVerthandiExclusiveCfg[arg_37_1]

	if var_37_0 then
		local var_37_1 = false
		local var_37_2 = ""

		if var_37_0.sub_type == SpHeroChallengeConst.BattleSubType.story and not arg_37_0:IsClearStage(arg_37_1) then
			local var_37_3, var_37_4 = SPHeroChallengeData:GetCurActivityInfo():GetStartBattelScheduleByType(var_37_0.sub_type)

			if var_37_3 <= var_37_4 then
				var_37_1 = true
				var_37_2 = GetTips("ACTIVITY_HERO_CHALLENGE_TIME_NULL")
			end
		end

		return var_37_1, var_37_2
	end
end

function var_0_0.CheckScheduleNeedCostTime(arg_38_0, arg_38_1)
	local var_38_0 = BattleVerthandiExclusiveCfg[arg_38_1]

	if var_38_0 then
		local var_38_1 = false
		local var_38_2 = ""

		if var_38_0.sub_type == SpHeroChallengeConst.BattleSubType.story then
			return arg_38_0:IsClearStage(arg_38_1)
		else
			return false
		end
	end
end

function var_0_0.IsClearStage(arg_39_0, arg_39_1)
	local var_39_0 = BattleVerthandiExclusiveCfg[arg_39_1]

	if var_39_0 then
		local var_39_1 = SPHeroChallengeData:GetCurActivityInfo()

		if var_39_0.sub_type == SpHeroChallengeConst.ScheduleSubType.story then
			return true
		elseif var_39_0.sub_type == SpHeroChallengeConst.ScheduleSubType.train1 or var_39_0.sub_type == SpHeroChallengeConst.ScheduleSubType.train2 or var_39_0.sub_type == SpHeroChallengeConst.ScheduleSubType.train3 then
			if var_39_1.trainInfo[var_39_0.sub_type] then
				return table.indexof(var_39_1.trainInfo[var_39_0.sub_type].passStageList, arg_39_1)
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
	local var_40_0 = GameSetting.activity_hero_challenge_boss_basescore.value[1]
	local var_40_1 = GameSetting.activity_hero_challenge_boss_timescore.value[1]

	return var_40_0 - math.max(GameSetting.activity_hero_challenge_boss_timescore.value[2] - var_40_1 * arg_40_3, 0)
end

function var_0_0.GetTrainTypeName(arg_41_0, arg_41_1)
	return GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TYPE_" .. arg_41_1)
end

function var_0_0.GetTrainPercentByStage(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = BattleVerthandiExclusiveCfg[arg_42_1].sub_type

	if SPHeroChallengeData:GetCurActivityInfo() then
		local var_42_1 = arg_42_0:GetTrainScoreByStage(arg_42_1, arg_42_2)
		local var_42_2 = 0
		local var_42_3 = GameSetting.activity_hero_challenge_base_num.value[1]

		return var_42_1, math.ceil(var_42_1 / var_42_3 * 100)
	end
end

function var_0_0.GetTrainScoreByStage(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = GameSetting["activity_hero_challenge_train_num_" .. arg_43_2].value
	local var_43_1 = BattleVerthandiExclusiveCfg[arg_43_1].sub_type
	local var_43_2 = SPHeroChallengeData:GetCurActivityInfo()

	if var_43_2 then
		local var_43_3 = var_43_2:GetTrainNumByType(var_43_1)
		local var_43_4 = -1

		for iter_43_0, iter_43_1 in ipairs(var_43_0) do
			if var_43_3 <= iter_43_1[1] then
				var_43_4 = iter_43_1[2]

				break
			end
		end

		if var_43_4 < 0 then
			var_43_4 = var_43_0[#var_43_0][2]
		end

		return var_43_4
	end
end

function var_0_0.GetChapterIsOpen(arg_44_0, arg_44_1)
	local var_44_0 = ChapterCfg[arg_44_1]

	if var_44_0 then
		local var_44_1 = var_44_0.unlock_activity_id

		if var_44_1 and var_44_1 > 0 and not ActivityTools.GetActivityIsOpenWithTip(var_44_1, false) then
			return false, "SOLO_NOT_OPEN"
		end

		local var_44_2 = SPHeroChallengeData:GetActivityID()

		if var_44_2 and var_44_1 == SPHeroChallengeData.activityCfg[var_44_2].bossActivityID and not SPHeroChallengeData:GetCurActivityInfo().bossStart then
			return false, "ACTIVITY_HERO_CHALLENGE_BOSS_OPEN_TIME"
		end

		local var_44_3 = {}
		local var_44_4 = var_44_0.group

		if var_44_4 == SpHeroChallengeConst.ChapterType.story then
			local var_44_5 = SpHeroChallengeConst.ScheduleID.Awake

			var_44_3 = ActivityHeroChallengeScheduleCfg[var_44_5].pre_condition
		elseif var_44_4 == SpHeroChallengeConst.ChapterType.train then
			local var_44_6 = SpHeroChallengeConst.ScheduleID.Endurance

			var_44_3 = ActivityHeroChallengeScheduleCfg[var_44_6].pre_condition
		elseif var_44_4 == SpHeroChallengeConst.ChapterType.boss then
			local var_44_7 = SpHeroChallengeConst.ScheduleID.Boss

			var_44_3 = ActivityHeroChallengeScheduleCfg[var_44_7].pre_condition
		end

		local var_44_8 = true
		local var_44_9 = ""

		for iter_44_0, iter_44_1 in ipairs(var_44_3) do
			if not IsConditionAchieved(iter_44_1) then
				local var_44_10 = false
				local var_44_11 = arg_44_0:GetConditionDesc(iter_44_1)

				return var_44_10, var_44_11
			end
		end

		return true
	else
		Debug.LogError("未获取到章节配置" .. arg_44_1)
	end
end

function var_0_0.CheckBattleRouteIsOpen(arg_45_0, arg_45_1)
	local var_45_0 = ActivityHeroChallengeScheduleCfg.get_id_list_by_server_type[arg_45_1]

	if var_45_0[1] then
		local var_45_1 = var_45_0[1]
		local var_45_2 = ActivityHeroChallengeScheduleCfg[var_45_1].pre_condition
		local var_45_3 = true
		local var_45_4 = ""

		for iter_45_0, iter_45_1 in ipairs(var_45_2) do
			if not IsConditionAchieved(iter_45_1) then
				var_45_3 = false

				local var_45_5 = arg_45_0:GetConditionDesc(iter_45_1)

				return var_45_3, var_45_5
			end
		end

		return var_45_3
	else
		Debug.LogError("未获取到战斗类型对应的日程" .. arg_45_1)
	end
end

function var_0_0.GetStoryOpenStageList(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = SPHeroChallengeData:GetCurActivityInfo().storyFinStageList or {}
	local var_46_1 = ChapterCfg[arg_46_1].section_id_list
	local var_46_2 = {}

	table.insert(var_46_2, var_46_1[1])

	for iter_46_0, iter_46_1 in ipairs(var_46_1) do
		local var_46_3 = arg_46_2[iter_46_1].next_show_id_list

		if var_46_3 == "" then
			var_46_3 = {}
		end

		if table.indexof(var_46_0, iter_46_1) then
			table.insert(var_46_2, iter_46_1)

			for iter_46_2, iter_46_3 in ipairs(var_46_3) do
				if not table.keyof(var_46_2, iter_46_3) then
					table.insert(var_46_2, iter_46_3)
				end
			end
		end
	end

	return var_46_2
end

function var_0_0.GetConditionDesc(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = ConditionCfg[arg_47_1]

	if var_47_0 then
		if var_47_0.type == 11200 or var_47_0.type == 11201 or var_47_0.type == 11202 or var_47_0.type == 11204 or var_47_0.type == 11205 then
			return var_47_0.desc
		elseif var_47_0.type == 11203 then
			local var_47_1 = BattleVerthandiExclusiveCfg[var_47_0.params[1]].name
			local var_47_2 = GetI18NText(var_47_0.desc)

			return (string.format(var_47_2, var_47_0.params[2]))
		elseif var_47_0.type == 11206 then
			local var_47_3 = var_47_0.desc

			return string.format(var_47_3, var_47_0.params[2]), var_47_0.params[1], var_47_0.params[2]
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

	local var_50_0 = GetTips("ACTIVITY_HERO_CHALLENGE_TRAIN_NAME_" .. arg_50_1)
	local var_50_1 = getSpriteViaConfig("ActivityHeroChallengeTrain", "heroChallenge_icon_potential" .. arg_50_1)

	return var_50_0, var_50_1
end

function var_0_0.GetBarbuceGameAwardRefreshTime(arg_51_0)
	local var_51_0 = manager.time:GetNextFreshTime()

	return string.format(GetTips("CANTEEN_TASK_REFRESH_COOLDOWN"), manager.time:GetLostTimeStrWith2Unit(var_51_0))
end

function var_0_0.GetBarbuceStageIDByDiff(arg_52_0, arg_52_1, arg_52_2)
	for iter_52_0, iter_52_1 in ipairs(ActivityHeroChallengeBarbecueCfg.all) do
		local var_52_0 = ActivityHeroChallengeBarbecueCfg[iter_52_1]

		if var_52_0.difficult == arg_52_1 and arg_52_2 == var_52_0.activity_id then
			return iter_52_1
		end
	end
end

function var_0_0.GetBarbecueAwardIndex(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = ActivityHeroChallengeBarbecueCfg[arg_53_1]

	if var_53_0 then
		local var_53_1 = 0

		for iter_53_0, iter_53_1 in ipairs(var_53_0.reward_list_coin) do
			if arg_53_2 <= iter_53_1[2] then
				var_53_1 = iter_53_0
			end
		end

		if var_53_1 == 0 then
			var_53_1 = #var_53_0.reward_list_coin
		end

		return var_53_1
	else
		Debug.LogError("未获取到烤肉关卡配置信息" .. arg_53_1)
	end
end

function var_0_0.CheckBossActivityIsOpen(arg_54_0)
	local var_54_0 = SPHeroChallengeData:GetActivityID()
	local var_54_1 = SPHeroChallengeData.activityCfg[var_54_0].bossActivityID

	if var_54_0 then
		local var_54_2 = SPHeroChallengeData:GetCurActivityInfo()

		if ActivityTools.GetActivityIsOpenWithTip(var_54_1, false) and var_54_2.bossStart then
			return true
		end
	end
end

return var_0_0
