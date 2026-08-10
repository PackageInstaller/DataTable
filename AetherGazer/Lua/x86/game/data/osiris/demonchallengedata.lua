local var_0_0 = singletonClass("DemonChallengeData")

function var_0_0.Init(arg_1_0)
	arg_1_0.levelIdList_ = StageGroupCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON]
	arg_1_0.activityIdList_ = ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON]
	arg_1_0.levelCount_ = #arg_1_0.levelIdList_
	arg_1_0.levelDataList_ = {}
	arg_1_0.receivedList_ = {}
	arg_1_0.completedList_ = {}
	arg_1_0.stageIdToIndex_ = {}
	arg_1_0.selectDifficultyIndexList_ = {}
	arg_1_0.selectedList_ = {}
	arg_1_0.openTimeStamp_ = {}
	arg_1_0.remainTimeStamp_ = 0
	arg_1_0.test = false

	manager.notify:RegistListener(ACTIVITY_UPDATE, handler(arg_1_0, arg_1_0.InitData))
end

function var_0_0.InitData(arg_2_0)
	if arg_2_0.test == true then
		for iter_2_0 = 1, arg_2_0.levelCount_ do
			local var_2_0

			var_2_0 = arg_2_0.openTimeStamp_[iter_2_0] - manager.time:GetServerTime() <= 0
		end
	end

	for iter_2_1 = 1, arg_2_0.levelCount_ do
		if arg_2_0.receivedList_[iter_2_1] == nil then
			arg_2_0.receivedList_[iter_2_1] = {}
			arg_2_0.completedList_[iter_2_1] = {}
		end
	end

	if arg_2_0.test == false then
		arg_2_0:UpdateTimeData()
	end
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_info
	local var_3_1 = var_3_0.activity_id
	local var_3_2 = var_3_0.info

	arg_3_0.levelDataList_[var_3_1] = var_3_0

	local var_3_3 = arg_3_0:GetLevelIndex(var_3_1)

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		local var_3_4 = iter_3_1.difficulty
		local var_3_5 = arg_3_0:GetStageId(var_3_3, var_3_4)

		if iter_3_1.challenge_state == 2 and table.keyof(arg_3_0.receivedList_[var_3_3], var_3_4) == nil then
			table.insert(arg_3_0.receivedList_[var_3_3], var_3_4)
		end

		if (iter_3_1.challenge_state == 1 or iter_3_1.challenge_state == 2) and table.keyof(arg_3_0.completedList_[var_3_3], var_3_4) == nil then
			table.insert(arg_3_0.completedList_[var_3_3], var_3_4)
		end

		arg_3_0.stageIdToIndex_[var_3_5] = {
			var_3_3,
			var_3_4
		}
	end

	arg_3_0:CalcRedPoint()
end

function var_0_0.UpdateTimeData(arg_4_0)
	if arg_4_0.test == true then
		return
	end

	local var_4_0 = ActivityConst.OSIRIS_DEMON
	local var_4_1 = ActivityData:GetActivityData(var_4_0)

	if var_4_1 ~= nil then
		arg_4_0.remainTimeStamp_ = var_4_1.stopTime
	end

	local var_4_2 = ""

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.levelIdList_) do
		local var_4_3 = arg_4_0:GetRedPointConst(iter_4_0)
		local var_4_4 = ActivityConst[var_4_3]
		local var_4_5 = ActivityData:GetActivityData(var_4_4)

		if var_4_5 ~= nil then
			arg_4_0.openTimeStamp_[iter_4_0] = var_4_5.startTime
		end
	end
end

function var_0_0.GetLevelIndex(arg_5_0, arg_5_1)
	local var_5_0 = table.keyof(arg_5_0.activityIdList_, arg_5_1)

	if var_5_0 ~= nil then
		return var_5_0 - 1
	end
end

function var_0_0.GetSubActivityID(arg_6_0, arg_6_1)
	if arg_6_1 + 1 <= #arg_6_0.activityIdList_ then
		return arg_6_0.activityIdList_[arg_6_1 + 1]
	end
end

function var_0_0.GetLevelCount(arg_7_0)
	return arg_7_0.levelCount_
end

function var_0_0.GetCacheSelectLevelIndex(arg_8_0)
	return getData("DemonChallenge", "levelIndex")
end

function var_0_0.GetDemonChallengeCfg(arg_9_0)
	return
end

function var_0_0.SaveSelectLevelIndex(arg_10_0, arg_10_1)
	saveData("DemonChallenge", "levelIndex", arg_10_1)
end

function var_0_0.GetLevelId(arg_11_0, arg_11_1)
	return arg_11_0.levelIdList_[arg_11_1]
end

function var_0_0.GetStageId(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.levelIdList_[arg_12_1]

	return StageGroupCfg[var_12_0].stage_list[arg_12_2]
end

function var_0_0.GetBoosId(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.levelIdList_[arg_13_1]

	return StageGroupCfg[var_13_0].boss_id
end

function var_0_0.SetReceiveList(arg_14_0, arg_14_1, arg_14_2)
	if table.keyof(arg_14_0.receivedList_[arg_14_2], arg_14_1) == nil then
		table.insert(arg_14_0.receivedList_[arg_14_2], arg_14_1)
		arg_14_0:CalcRedPoint()
	end
end

function var_0_0.GetReceiveList(arg_15_0, arg_15_1)
	return arg_15_0.receivedList_[arg_15_1]
end

function var_0_0.GetCompletedList(arg_16_0, arg_16_1)
	return arg_16_0.completedList_[arg_16_1]
end

function var_0_0.IsCompleted(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.completedList_[arg_17_1]

	if var_17_0 == nil then
		print(string.format("**********************self.completedList_[%d] 为空***********************************", arg_17_1))

		return false
	end

	if table.keyof(var_17_0, arg_17_2) then
		return true
	end

	return false
end

function var_0_0.IsCompletedLevel(arg_18_0, arg_18_1)
	if arg_18_0.completedList_[arg_18_1] == nil then
		print(string.format("**********************self.completedList_[%d] 为空***********************************", arg_18_1))

		return false
	end

	return #arg_18_0.completedList_[arg_18_1] > 0
end

function var_0_0.IsOpened(arg_19_0, arg_19_1)
	return arg_19_0.openTimeStamp_[arg_19_1] - manager.time:GetServerTime() <= 0
end

function var_0_0.SetSelectDifficultyIndex(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.selectDifficultyIndexList_[arg_20_1] = arg_20_2
end

function var_0_0.GetSelectDifficultyIndex(arg_21_0, arg_21_1)
	return arg_21_0.selectDifficultyIndexList_[arg_21_1]
end

function var_0_0.GetDifficultyDes(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:GetStageId(arg_22_1, arg_22_2)

	return DemonChallengeCfg[var_22_0].difficulty_desc
end

function var_0_0.GetLevelName(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetStageId(arg_23_1, 1)

	return BattleHeartDemonStageCfg[var_23_0].name
end

function var_0_0.GetDescText(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:GetStageId(arg_24_1, 1)

	return BattleHeartDemonStageCfg[var_24_0].tips
end

function var_0_0.GetLevelOpenTimeByIndex(arg_25_0, arg_25_1)
	return arg_25_0.openTimeStamp_[arg_25_1]
end

function var_0_0.GetRemainTime(arg_26_0)
	return arg_26_0.remainTimeStamp_
end

function var_0_0.GetDropId(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:GetStageId(arg_27_1, arg_27_2)

	return BattleHeartDemonStageCfg[var_27_0].drop_lib_id
end

function var_0_0.GetSortedRewardIndexList(arg_28_0, arg_28_1)
	local var_28_0 = {}
	local var_28_1 = {}
	local var_28_2 = arg_28_0.receivedList_[arg_28_1]
	local var_28_3 = arg_28_0.completedList_[arg_28_1]
	local var_28_4 = arg_28_0:GetLevelId(arg_28_1)
	local var_28_5 = StageGroupCfg[var_28_4].stage_list

	for iter_28_0, iter_28_1 in ipairs(var_28_5) do
		if table.keyof(var_28_3, iter_28_0) == nil then
			table.insert(var_28_1, iter_28_0)
		elseif table.keyof(var_28_2, iter_28_0) == nil then
			table.insert(var_28_0, iter_28_0)
		end
	end

	table.insertto(var_28_0, var_28_1)
	table.insertto(var_28_0, var_28_2)

	return var_28_0
end

function var_0_0.CalcRedPoint(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.completedList_) do
		local var_29_0 = arg_29_0:GetRedPointConst(iter_29_0)
		local var_29_1 = false
		local var_29_2 = arg_29_0:IsCompletedLevel(iter_29_0)
		local var_29_3 = arg_29_0:IsOpened(iter_29_0)

		if var_29_3 and not var_29_2 and arg_29_0.selectedList_[iter_29_0] == nil then
			var_29_1 = true
		elseif var_29_3 and var_29_2 then
			local var_29_4 = arg_29_0.receivedList_[iter_29_0]

			for iter_29_2, iter_29_3 in ipairs(iter_29_1) do
				if table.keyof(var_29_4, iter_29_3) == nil then
					var_29_1 = true

					break
				end
			end
		end

		if var_29_1 then
			manager.redPoint:setTip(RedPointConst[var_29_0], 1)
		else
			manager.redPoint:setTip(RedPointConst[var_29_0], 0)
		end
	end
end

function var_0_0.SaveSelected(arg_30_0, arg_30_1)
	if arg_30_0:IsOpened(arg_30_1) then
		arg_30_0.selectedList_[arg_30_1] = true

		arg_30_0:CalcRedPoint()
	end
end

function var_0_0.IsSelected(arg_31_0, arg_31_1)
	if arg_31_0.selectedList_[arg_31_1] == nil then
		return false
	else
		return true
	end
end

function var_0_0.GetRedPointConst(arg_32_0, arg_32_1)
	return "OSIRIS_DEMON_LEVEL" .. tostring(arg_32_1)
end

function var_0_0.SetAllRedPoint(arg_33_0, arg_33_1)
	local var_33_0 = ""

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.levelIdList_) do
		local var_33_1 = arg_33_0:GetRedPointConst(iter_33_0)

		manager.redPoint:setTip(RedPointConst[var_33_1], arg_33_1)
	end
end

function var_0_0.GetRoleImg(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:GetStageId(arg_34_1, 1)
	local var_34_1 = BattleHeartDemonStageCfg[var_34_0].background_1

	return getSpriteWithoutAtlas("TextureConfig/VersionUI/OsirisUI/" .. var_34_1)
end

function var_0_0.GetAnyOpen(arg_35_0)
	for iter_35_0 = 1, arg_35_0.levelCount_ do
		if arg_35_0:IsOpened(iter_35_0) then
			return iter_35_0
		end
	end

	return -1
end

return var_0_0
