local var_0_0 = singletonClass("AchievementData")

function var_0_0.Init(arg_1_0)
	arg_1_0.achievementData_ = {}

	for iter_1_0, iter_1_1 in ipairs(AchievementCfg.all) do
		arg_1_0.achievementData_[iter_1_1] = {
			process = 0,
			timestamp = 0,
			rewardState = 0,
			id = iter_1_1
		}
	end

	arg_1_0.achievementSortData_ = {}

	for iter_1_2, iter_1_3 in ipairs(AchievementCfg.get_id_list_by_type_id) do
		arg_1_0.achievementSortData_[iter_1_2] = {}

		for iter_1_4, iter_1_5 in ipairs(iter_1_3) do
			if AchievementCfg[iter_1_5].is_hide ~= 1 then
				table.insert(arg_1_0.achievementSortData_[iter_1_2], iter_1_5)
			end
		end
	end

	arg_1_0.needSortFlag_ = {}
	arg_1_0.canReceiveReward_ = {}
	arg_1_0.finishAchievementList_ = {}
	arg_1_0.achievementPoint_ = 0
	arg_1_0.storyReadList_ = {}
	arg_1_0.achievementLevel_ = 0
	arg_1_0.achievementOldLevel_ = 0
	arg_1_0.readyAchievementList_ = {}
	arg_1_0.hadCheckShield_ = {}
	arg_1_0.finishShieldList_ = {}
	arg_1_0.canReceiveShieldList_ = {}
end

function var_0_0.GetFinishAchievementCnt(arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		local var_2_0 = 0

		for iter_2_0, iter_2_1 in pairs(arg_2_0.finishAchievementList_) do
			var_2_0 = var_2_0 + #iter_2_1
		end

		local var_2_1 = 0

		for iter_2_2, iter_2_3 in pairs(arg_2_0.canReceiveShieldList_) do
			var_2_1 = var_2_1 + #iter_2_3
		end

		return var_2_0 - var_2_1
	else
		local var_2_2 = arg_2_0.finishShieldList_[arg_2_1] and #arg_2_0.finishShieldList_[arg_2_1] or 0

		return (arg_2_0.finishAchievementList_[arg_2_1] and #arg_2_0.finishAchievementList_[arg_2_1] or 0) - var_2_2
	end
end

function var_0_0.GetReadyAchievementList(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return arg_3_0.readyAchievementList_
	else
		return arg_3_0.readyAchievementList_[arg_3_1] or {}
	end
end

function var_0_0.UpdateAchievementList(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:UpdateAchievement(iter_4_1, arg_4_2)
	end
end

function var_0_0.UpdateAchievement(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1.id
	local var_5_1 = tonumber(arg_5_1.progress)
	local var_5_2 = AchievementCfg[var_5_0]

	if not var_5_2 then
		return
	end

	local var_5_3 = var_5_2.type_id
	local var_5_4 = 0

	if arg_5_1.complete_flag == 1 then
		var_5_4 = -1
	elseif var_5_1 >= var_5_2.need then
		var_5_4 = 1
	end

	if not arg_5_0.hadCheckShield_[var_5_0] then
		arg_5_0.hadCheckShield_[var_5_0] = true

		local var_5_5 = false
		local var_5_6 = AchievementCfg[var_5_0].system

		if type(var_5_6) == "table" then
			for iter_5_0, iter_5_1 in ipairs(var_5_6) do
				if SystemCfg[iter_5_1].system_hide == 1 then
					var_5_5 = true

					break
				end
			end
		end

		if var_5_5 then
			local var_5_7 = AchievementCfg[var_5_0].type_id

			if var_5_4 == 0 then
				if arg_5_0.achievementSortData_[var_5_7] then
					local var_5_8 = table.indexof(arg_5_0.achievementSortData_[var_5_7], var_5_0)

					if var_5_8 then
						table.remove(arg_5_0.achievementSortData_[var_5_7], var_5_8)
					end
				end
			elseif var_5_4 == -1 then
				if not arg_5_0.finishShieldList_[var_5_7] then
					arg_5_0.finishShieldList_[var_5_7] = {}
				end

				table.insert(arg_5_0.finishShieldList_[var_5_7], var_5_0)
			elseif var_5_4 == 1 then
				if not arg_5_0.canReceiveShieldList_[var_5_7] then
					arg_5_0.canReceiveShieldList_[var_5_7] = {}
				end

				table.insert(arg_5_0.canReceiveShieldList_[var_5_7], var_5_0)
			end
		end
	end

	if var_5_4 == 1 or var_5_4 == -1 then
		if var_5_4 == 1 then
			if arg_5_0.readyAchievementList_[var_5_3] then
				if not table.keyof(arg_5_0.readyAchievementList_[var_5_3], var_5_0) then
					table.insert(arg_5_0.readyAchievementList_[var_5_3], var_5_0)
				end
			else
				arg_5_0.readyAchievementList_[var_5_3] = {
					var_5_0
				}
			end
		end

		if arg_5_0.finishAchievementList_[var_5_3] then
			if not table.keyof(arg_5_0.finishAchievementList_[var_5_3], var_5_0) then
				table.insert(arg_5_0.finishAchievementList_[var_5_3], var_5_0)
			end
		else
			arg_5_0.finishAchievementList_[var_5_3] = {
				var_5_0
			}
		end

		if AchievementCfg[var_5_0].is_hide ~= 0 and not table.keyof(arg_5_0.achievementSortData_[var_5_3], var_5_0) then
			table.insert(arg_5_0.achievementSortData_[var_5_3], var_5_0)
		end
	end

	local var_5_9 = true

	if var_5_4 == 1 and arg_5_0.achievementData_[var_5_0] and arg_5_0.achievementData_[var_5_0].rewardState == var_5_4 then
		var_5_9 = false
	end

	if var_5_9 == true then
		arg_5_0.achievementData_[var_5_0] = {
			id = var_5_0,
			process = var_5_1 > var_5_2.need and var_5_2.need or var_5_1,
			rewardState = var_5_4,
			timestamp = arg_5_1.achieve_time + manager.time:GetDeltaTimeZone()
		}

		if var_5_4 == 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT, var_5_3), 1)

			if not arg_5_0.canReceiveReward_[var_5_3] then
				arg_5_0.canReceiveReward_[var_5_3] = {}
			end

			if not table.keyof(arg_5_0.canReceiveReward_[var_5_3], var_5_0) then
				table.insert(arg_5_0.canReceiveReward_[var_5_3], var_5_0)
			end

			if arg_5_2 == false then
				manager.achievementTips:AddAchievementID(var_5_0)
			end
		end
	end

	arg_5_0.needSortFlag_[var_5_3] = true
end

function var_0_0.GetAchievementIDList(arg_6_0, arg_6_1)
	if arg_6_0.needSortFlag_[arg_6_1] then
		table.sort(arg_6_0.achievementSortData_[arg_6_1], function(arg_7_0, arg_7_1)
			local var_7_0 = arg_6_0.achievementData_[arg_7_0].rewardState
			local var_7_1 = arg_6_0.achievementData_[arg_7_1].rewardState

			if var_7_0 == var_7_1 then
				return arg_7_0 < arg_7_1
			else
				return var_7_1 < var_7_0
			end
		end)

		arg_6_0.needSortFlag_[arg_6_1] = false
	end

	return arg_6_0.achievementSortData_[arg_6_1]
end

function var_0_0.GetAchievementTotalCnt(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0.achievementSortData_) do
		var_8_0 = var_8_0 + #iter_8_1
	end

	local var_8_1 = 0

	for iter_8_2, iter_8_3 in pairs(arg_8_0.canReceiveShieldList_) do
		var_8_1 = var_8_1 + #iter_8_3
	end

	return var_8_0 - var_8_1
end

function var_0_0.GetAchievementCnt(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.finishShieldList_[arg_9_1] and #arg_9_0.finishShieldList_[arg_9_1] or 0

	return #arg_9_0.achievementSortData_[arg_9_1] - var_9_0
end

function var_0_0.GetAchievementData(arg_10_0, arg_10_1)
	if not arg_10_0.achievementData_[arg_10_1] then
		arg_10_0.achievementData_[arg_10_1] = {
			process = 0,
			timestamp = 0,
			rewardState = 0,
			id = arg_10_1
		}
	end

	return arg_10_0.achievementData_[arg_10_1]
end

function var_0_0.ChangedAchievementState(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.achievementData_[arg_11_1].rewardState = arg_11_2

	local var_11_0 = AchievementCfg[arg_11_1].type_id

	arg_11_0.needSortFlag_[var_11_0] = true

	local var_11_1 = table.keyof(arg_11_0.canReceiveReward_[var_11_0], arg_11_1)

	table.remove(arg_11_0.canReceiveReward_[var_11_0], var_11_1)

	local var_11_2 = table.keyof(arg_11_0.readyAchievementList_[var_11_0], arg_11_1)

	table.remove(arg_11_0.readyAchievementList_[var_11_0], var_11_2)

	if table.length(arg_11_0.canReceiveReward_[var_11_0]) <= 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT, var_11_0), 0)
	end
end

function var_0_0.InitAchievementPoint(arg_12_0, arg_12_1)
	arg_12_0.achievementPoint_ = arg_12_1
	arg_12_0.achievementLevel_ = arg_12_0:CalcAchievementLevel(arg_12_1)
	arg_12_0.achievementOldLevel_ = arg_12_0.achievementLevel_

	for iter_12_0 = 1, arg_12_0.achievementLevel_ do
		if not arg_12_0.storyReadList_[iter_12_0] then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, iter_12_0), 1)
		end
	end
end

function var_0_0.SetAchievementPoint(arg_13_0, arg_13_1)
	arg_13_0.achievementPoint_ = arg_13_1
	arg_13_0.achievementLevel_ = arg_13_0:CalcAchievementLevel(arg_13_0.achievementPoint_)

	for iter_13_0 = arg_13_0.achievementOldLevel_, arg_13_0.achievementLevel_ do
		if not arg_13_0.storyReadList_[iter_13_0] then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, iter_13_0), 1)
		end
	end
end

function var_0_0.GetAchievementPoint(arg_14_0)
	return arg_14_0.achievementPoint_
end

function var_0_0.InitAchievementStoryReadList(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		arg_15_0.storyReadList_[iter_15_1] = true

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, iter_15_1), 0)
	end
end

function var_0_0.UpdateStoryRead(arg_16_0, arg_16_1)
	arg_16_0.storyReadList_[arg_16_1] = true

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, arg_16_1), 0)
end

function var_0_0.GetStoryReadFlag(arg_17_0, arg_17_1)
	return arg_17_0.storyReadList_[arg_17_1]
end

function var_0_0.NeedUpgradeLevel(arg_18_0)
	return arg_18_0.achievementOldLevel_ < arg_18_0.achievementLevel_
end

function var_0_0.RefreshOldLevel(arg_19_0)
	arg_19_0.achievementOldLevel_ = arg_19_0.achievementLevel_
end

function var_0_0.GetCurrentPoint(arg_20_0)
	local var_20_0 = arg_20_0.achievementLevel_ + 1

	if var_20_0 > #AchievementStoryCfg.all then
		return arg_20_0.achievementPoint_ - AchievementStoryCfg[arg_20_0.achievementLevel_ - 1].unlock_point
	elseif var_20_0 == 1 then
		return arg_20_0.achievementPoint_
	elseif var_20_0 > 1 then
		return arg_20_0.achievementPoint_ - AchievementStoryCfg[var_20_0 - 1].unlock_point
	end
end

function var_0_0.GetCurrentLevelPoint(arg_21_0)
	local var_21_0 = arg_21_0.achievementLevel_ + 1

	if var_21_0 > #AchievementStoryCfg.all then
		return AchievementStoryCfg[arg_21_0.achievementLevel_].unlock_point - AchievementStoryCfg[arg_21_0.achievementLevel_ - 1].unlock_point
	elseif var_21_0 == 1 then
		return AchievementStoryCfg[var_21_0].unlock_point
	elseif var_21_0 > 1 then
		return AchievementStoryCfg[var_21_0].unlock_point - AchievementStoryCfg[var_21_0 - 1].unlock_point
	end
end

function var_0_0.CalcAchievementLevel(arg_22_0, arg_22_1)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(AchievementStoryCfg.all) do
		if arg_22_1 - AchievementStoryCfg[iter_22_1].unlock_point < 0 then
			return iter_22_1 - 1
		end

		var_22_0 = iter_22_1
	end

	return var_22_0
end

function var_0_0.SetScrollRecord(arg_23_0, arg_23_1)
	arg_23_0.scrollRecord_ = arg_23_1
end

function var_0_0.GetScrollRecord(arg_24_0)
	return arg_24_0.scrollRecord_
end

return var_0_0
