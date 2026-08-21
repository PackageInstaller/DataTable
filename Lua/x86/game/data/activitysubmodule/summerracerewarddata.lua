local var_0_0 = class("SummerRaceRewardData")

function var_0_0.ExportMethod(arg_1_0)
	return {
		"BuildDefaultPendingUnlock",
		"BuildDefaultPendingStageUnlockBanner",
		"BuildFallbackStageUnlockBannerModel",
		"BuildUnlockPopItemFromRewardData",
		"BuildUnlockPopItemListFromRewardList",
		"BuildPendingUnlockModelFromStageReward",
		"BuildPendingStageUnlockBannerModel",
		"ResolveRewardName",
		"BuildRewardEntry",
		"AppendRewardEntry",
		"BuildStageRewardList",
		"BuildChallengeRewardList",
		"GetAssignmentIdListByActivityId",
		"GetTaskProgressValue",
		"IsTaskComplete",
		"IsTaskFinishedOrReceivable",
		"BuildTaskRewardList",
		"BuildPreviewRewardList",
		"BuildRewardPageModelFromCfg",
		"BuildResidentRewardEntryModel",
		"SetRewardPage",
		"GetRewardPageSelection",
		"GetRewardRootActivityId",
		"GetRewardActivityId",
		"ResolveRewardEntryPage",
		"MarkRewardReceived",
		"TryPrepareStageFirstClearUnlock",
		"ConsumePendingUnlockPopModel",
		"ConsumePendingStageUnlockBannerModel",
		"GetRewardPageModel",
		"GetPendingUnlockModel",
		"GetPendingStageUnlockBannerModel",
		"GetUnlockPopViewModel",
		"GetUnlockBannerModel"
	}
end

function var_0_0.BuildDefaultPendingUnlock(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:_GetEquipDefs()
	local var_2_1 = arg_2_1:_GetWeaponDefs()
	local var_2_2 = var_2_0[#var_2_0] or var_2_1[#var_2_1] or {
		itemId = 0,
		itemName = "New Module",
		desc = "Unlocked after reaching a SummerRace milestone."
	}

	return {
		title = "New Module Unlocked",
		shouldOpenPop = false,
		sourceType = SummerRaceConst.SOURCE_TYPE.MODIFY,
		itemId = var_2_2.itemId,
		itemName = var_2_2.itemName,
		itemDesc = var_2_2.desc,
		bannerDesc = var_2_2.itemName .. " is now available in modification."
	}
end

function var_0_0.BuildDefaultPendingStageUnlockBanner(arg_3_0, arg_3_1)
	return {
		shouldOpenPop = false,
		title = "",
		desc = "",
		sourceType = SummerRaceConst.SOURCE_TYPE.REWARD
	}
end

function var_0_0.BuildFallbackStageUnlockBannerModel(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1:NormalizeSourceType(arg_4_2) == SummerRaceConst.SOURCE_TYPE.CHALLENGE then
		return arg_4_1:BuildPendingStageUnlockBannerModel(SummerRaceConst.SOURCE_TYPE.CHALLENGE)
	end

	return arg_4_1:BuildPendingStageUnlockBannerModel(SummerRaceConst.SOURCE_TYPE.REWARD)
end

function var_0_0.BuildUnlockPopItemFromRewardData(arg_5_0, arg_5_1, arg_5_2)
	if type(arg_5_2) ~= "table" then
		return nil
	end

	local var_5_0 = tonumber(arg_5_2.rewardType) or 0
	local var_5_1 = arg_5_2.itemId

	if var_5_0 == 3 then
		local var_5_2 = arg_5_1:FindDefById(arg_5_1:_GetBodyDefs(), var_5_1)

		return {
			isCar = true,
			itemId = var_5_2 and var_5_2.bodyId or var_5_1,
			itemName = tostring(var_5_2 and var_5_2.bodyName or arg_5_2.rewardName or ""),
			iconPath = tostring(var_5_2 and (var_5_2.iconPath or var_5_2.icon) or arg_5_2.iconPath or "")
		}
	end

	local var_5_3

	if var_5_0 == 1 or var_5_0 == 2 then
		var_5_3 = arg_5_1:FindDefById(var_5_0 == 1 and arg_5_1:_GetWeaponDefs() or arg_5_1:_GetEquipDefs(), var_5_1)
	end

	return {
		isCar = false,
		itemId = var_5_3 and var_5_3.itemId or var_5_1,
		itemName = tostring(var_5_3 and var_5_3.itemName or arg_5_2.rewardName or ""),
		iconPath = tostring(var_5_3 and (var_5_3.iconPath or var_5_3.icon) or arg_5_2.iconPath or "")
	}
end

function var_0_0.BuildUnlockPopItemListFromRewardList(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {}

	if type(arg_6_3) ~= "table" then
		return var_6_0
	end

	for iter_6_0 = 1, #arg_6_3 do
		local var_6_1 = arg_6_1:BuildRewardEntry(arg_6_2, "clear", iter_6_0, arg_6_3[iter_6_0], "received", "1/1")
		local var_6_2 = arg_6_1:BuildUnlockPopItemFromRewardData(var_6_1)

		if var_6_2 ~= nil then
			var_6_0[#var_6_0 + 1] = var_6_2
		end
	end

	return var_6_0
end

function var_0_0.BuildPendingUnlockModelFromStageReward(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = type(arg_7_2) == "table" and type(arg_7_2.rewardList) == "table" and arg_7_2.rewardList or nil
	local var_7_1 = var_7_0 and var_7_0[1] or nil
	local var_7_2 = var_7_1 and arg_7_1:BuildRewardEntry(arg_7_2.stageId, "clear", 1, var_7_1, "received", "1/1") or nil

	if var_7_2 == nil then
		return nil
	end

	local var_7_3 = arg_7_1:BuildUnlockPopItemListFromRewardList(arg_7_2.stageId, var_7_0)
	local var_7_4 = var_7_3[1] or arg_7_1:BuildUnlockPopItemFromRewardData(var_7_2)
	local var_7_5 = var_7_2.rewardName
	local var_7_6 = tonumber(var_7_2.rewardType) or 0

	if var_7_6 == 1 or var_7_6 == 2 then
		local var_7_7 = arg_7_1:FindDefById(var_7_6 == 1 and arg_7_1:_GetWeaponDefs() or arg_7_1:_GetEquipDefs(), var_7_2.itemId)

		if var_7_7 then
			var_7_5 = tostring(var_7_7.desc or var_7_2.rewardName) or var_7_5
		end
	elseif var_7_6 == 3 then
		local var_7_8 = arg_7_1:FindDefById(arg_7_1:_GetBodyDefs(), var_7_2.itemId)

		var_7_5 = var_7_8 and tostring(var_7_8.desc or var_7_2.rewardName) or var_7_5
	end

	return {
		shouldOpenPop = true,
		sourceType = SummerRaceConst.SOURCE_TYPE.MODIFY,
		itemId = var_7_4 and var_7_4.itemId or var_7_2.itemId,
		itemName = tostring(var_7_4 and var_7_4.itemName or var_7_2.rewardName or ""),
		itemDesc = tostring(var_7_5 or ""),
		title = arg_7_1:ResolveTipsText("ACTIVITY_TANK_WEAPON_UNLOCK"),
		bannerDesc = tostring(var_7_2.rewardName or ""),
		unlockItemList = var_7_3
	}
end

function var_0_0.BuildPendingStageUnlockBannerModel(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2 == SummerRaceConst.SOURCE_TYPE.CHALLENGE
	local var_8_1 = (tonumber(arg_8_3 and arg_8_3.modeType) or 0) == 3 and "ACTIVITY_TANK_PRACTICE_1V2_UNLOCK" or "ACTIVITY_TANK_PRACTICE_UNLOCK"
	local var_8_2 = var_8_0 and arg_8_1:ResolveTipsText("ACTIVITY_TANK_CHALLAGE_UNLOCK") or arg_8_1:ResolveTipsText(var_8_1)

	return {
		shouldOpenPop = true,
		sourceType = var_8_0 and SummerRaceConst.SOURCE_TYPE.CHALLENGE or SummerRaceConst.SOURCE_TYPE.REWARD,
		title = var_8_2,
		desc = var_8_2
	}
end

function var_0_0.ResolveRewardName(arg_9_0, arg_9_1, arg_9_2)
	if ItemTools and ItemTools.getItemName then
		return tostring(ItemTools.getItemName(arg_9_2))
	end

	if ItemCfg and ItemCfg[arg_9_2] then
		return arg_9_1:ResolveDisplayText(ItemCfg[arg_9_2].name)
	end

	return tostring(arg_9_2)
end

function var_0_0.BuildRewardEntry(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
	if type(arg_10_5) ~= "table" or arg_10_5[1] == nil then
		return nil
	end

	local var_10_0 = tonumber(arg_10_5[1]) or 0
	local var_10_1 = arg_10_5[2] or arg_10_5[1]
	local var_10_2 = tonumber(arg_10_5[3]) or 1
	local var_10_3

	if var_10_0 == 1 then
		var_10_3 = arg_10_1:FindDefById(arg_10_1:_GetWeaponDefs(), var_10_1)
	elseif var_10_0 == 2 then
		var_10_3 = arg_10_1:FindDefById(arg_10_1:_GetEquipDefs(), var_10_1)
	elseif var_10_0 == 3 then
		var_10_3 = arg_10_1:FindDefById(arg_10_1:_GetBodyDefs(), var_10_1)
	end

	return {
		rewardId = string.format("%s_%s_%s", tostring(arg_10_2), arg_10_3, tostring(arg_10_4)),
		itemId = var_10_1,
		rewardType = var_10_0,
		rewardName = var_10_3 and tostring(var_10_3.itemName or var_10_3.bodyName or "") or arg_10_1:ResolveRewardName(var_10_1),
		rewardCount = var_10_2,
		iconPath = var_10_3 and tostring(var_10_3.iconPath or var_10_3.icon or "") or "",
		progressText = arg_10_7 or "0/1",
		state = arg_10_6 or "locked"
	}
end

function var_0_0.AppendRewardEntry(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4 == nil then
		return
	end

	local var_11_0 = string.format("%s|%s", tostring(arg_11_4.rewardType or 0), tostring(arg_11_4.itemId or ""))

	if arg_11_3[var_11_0] == true then
		return
	end

	arg_11_3[var_11_0] = true
	arg_11_2[#arg_11_2 + 1] = arg_11_4
end

function var_0_0.BuildStageRewardList(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = {}
	local var_12_1 = arg_12_2.isCompleted and "received" or arg_12_2.isUnlocked and "canReceive" or "locked"
	local var_12_2 = arg_12_2.isCompleted and "1/1" or "0/1"
	local var_12_3 = arg_12_2.isUnlocked and "canReceive" or "locked"

	for iter_12_0 = 1, #arg_12_2.firstReward do
		local var_12_4 = arg_12_1:BuildRewardEntry(arg_12_2.stageId, "first", iter_12_0, arg_12_2.firstReward[iter_12_0], var_12_1, var_12_2)

		if var_12_4 ~= nil then
			var_12_4.state = arg_12_3[var_12_4.rewardId] or var_12_4.state
			var_12_0[#var_12_0 + 1] = var_12_4
		end
	end

	for iter_12_1 = 1, #arg_12_2.rewardList do
		local var_12_5 = arg_12_1:BuildRewardEntry(arg_12_2.stageId, "clear", iter_12_1, arg_12_2.rewardList[iter_12_1], var_12_3, arg_12_2.isUnlocked and "1/1" or "0/1")

		if var_12_5 ~= nil then
			var_12_5.state = arg_12_3[var_12_5.rewardId] or var_12_5.state
			var_12_0[#var_12_0 + 1] = var_12_5
		end
	end

	for iter_12_2 = 1, #arg_12_2.repetitionReward do
		local var_12_6 = arg_12_1:BuildRewardEntry(arg_12_2.stageId, "repeat", iter_12_2, arg_12_2.repetitionReward[iter_12_2], var_12_3, arg_12_2.isUnlocked and "1/1" or "0/1")

		if var_12_6 ~= nil then
			var_12_6.state = arg_12_3[var_12_6.rewardId] or var_12_6.state
			var_12_0[#var_12_0 + 1] = var_12_6
		end
	end

	return var_12_0
end

function var_0_0.BuildChallengeRewardList(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = arg_13_1:GetTournamentStageMap()

	for iter_13_0, iter_13_1 in ipairs({
		SummerRaceConst.TOURNAMENT_TAB.SURVIVAL,
		SummerRaceConst.TOURNAMENT_TAB.DUEL,
		SummerRaceConst.TOURNAMENT_TAB.NORMAL
	}) do
		local var_13_3 = var_13_2[iter_13_1] or {}

		for iter_13_2 = 1, #var_13_3 do
			local var_13_4 = var_13_3[iter_13_2]

			if var_13_4 ~= nil then
				for iter_13_3 = 1, #(var_13_4.rewardList or {}) do
					local var_13_5 = arg_13_1:BuildRewardEntry(var_13_4.stageId, "challengePreview", iter_13_3, var_13_4.rewardList[iter_13_3], var_13_4.isCompleted and "received" or var_13_4.isUnlocked and "canReceive" or "locked", var_13_4.isCompleted and "1/1" or var_13_4.isUnlocked and "0/1" or "0/1")

					if var_13_4.isCompleted ~= true then
						arg_13_1:AppendRewardEntry(var_13_0, var_13_1, var_13_5)
					end
				end
			end
		end
	end

	if #var_13_0 > 0 then
		return var_13_0
	end

	for iter_13_4, iter_13_5 in ipairs({
		SummerRaceConst.TOURNAMENT_TAB.SURVIVAL,
		SummerRaceConst.TOURNAMENT_TAB.DUEL,
		SummerRaceConst.TOURNAMENT_TAB.NORMAL
	}) do
		local var_13_6 = var_13_2[iter_13_5] or {}

		for iter_13_6 = 1, #var_13_6 do
			local var_13_7 = var_13_6[iter_13_6]

			if var_13_7 ~= nil then
				for iter_13_7 = 1, #(var_13_7.rewardList or {}) do
					arg_13_1:AppendRewardEntry(var_13_0, var_13_1, arg_13_1:BuildRewardEntry(var_13_7.stageId, "challengeHistory", iter_13_7, var_13_7.rewardList[iter_13_7], var_13_7.isCompleted and "received" or var_13_7.isUnlocked and "canReceive" or "locked", var_13_7.isCompleted and "1/1" or var_13_7.isUnlocked and "0/1" or "0/1"))
				end
			end
		end
	end

	return var_13_0
end

function var_0_0.GetAssignmentIdListByActivityId(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 == nil or arg_14_2 == 0 then
		return {}
	end

	local var_14_0 = AssignmentCfg and AssignmentCfg.get_id_list_by_activity_id or nil

	if type(var_14_0) ~= "table" then
		return {}
	end

	return var_14_0[arg_14_2] or {}
end

function var_0_0.GetTaskProgressValue(arg_15_0, arg_15_1, arg_15_2)
	if TaskData2 == nil or TaskData2.GetTaskProgress == nil then
		return 0
	end

	return math.max(0, tonumber(TaskData2:GetTaskProgress(arg_15_2)) or 0)
end

function var_0_0.IsTaskComplete(arg_16_0, arg_16_1, arg_16_2)
	return TaskData2 ~= nil and TaskData2.GetTaskComplete ~= nil and TaskData2:GetTaskComplete(arg_16_2) == true
end

function var_0_0.IsTaskFinishedOrReceivable(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = AssignmentCfg and AssignmentCfg[arg_17_2] or nil

	if arg_17_1:IsTaskComplete(arg_17_2) then
		return true
	end

	return var_17_0 ~= nil and arg_17_1:GetTaskProgressValue(arg_17_2) >= (tonumber(var_17_0.need) or 0)
end

function var_0_0.BuildTaskRewardList(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_1:GetAssignmentIdListByActivityId(arg_18_2)
	local var_18_1 = {}

	for iter_18_0 = 1, #var_18_0 do
		local var_18_2 = AssignmentCfg[var_18_0[iter_18_0]]

		if var_18_2 ~= nil then
			local var_18_3 = arg_18_3[var_18_2.id]
			local var_18_4 = type(var_18_2.reward) == "table" and var_18_2.reward[1] or nil
			local var_18_5 = var_18_4 and var_18_4[1] or 0
			local var_18_6 = var_18_4 and (tonumber(var_18_4[2]) or 0) or 0
			local var_18_7 = tonumber(var_18_2.need) or 0
			local var_18_8 = math.min(arg_18_1:GetTaskProgressValue(var_18_2.id), var_18_7)
			local var_18_9 = "locked"

			if var_18_3 == "received" or arg_18_1:IsTaskComplete(var_18_2.id) then
				var_18_9 = "received"
				var_18_8 = var_18_7
			elseif var_18_7 <= var_18_8 then
				var_18_9 = "canReceive"
			elseif type(var_18_3) == "string" then
				var_18_9 = var_18_3
			end

			var_18_1[#var_18_1 + 1] = {
				rewardId = var_18_2.id,
				rewardName = var_18_5 ~= 0 and arg_18_1:ResolveRewardName(var_18_5) or arg_18_1:ResolveDisplayText(var_18_2.name),
				rewardCount = var_18_6,
				progressText = string.format("%d/%d", var_18_8, var_18_7),
				state = var_18_9,
				taskName = arg_18_1:ResolveDisplayText(var_18_2.name),
				taskDesc = arg_18_1:ResolveDisplayText(var_18_2.desc),
				activityId = arg_18_2
			}
		end
	end

	return var_18_1
end

function var_0_0.BuildPreviewRewardList(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = ActivityCfg and ActivityCfg[SummerRaceConst.ACTIVITY_ID.MAIN] or nil
	local var_19_1 = {}

	if var_19_0 ~= nil then
		if arg_19_2 == SummerRaceConst.REWARD_PAGE.RESIDENT then
			var_19_1 = var_19_0.reward_show_permanent or {}
		else
			var_19_1 = var_19_0.reward_show or {}
		end
	end

	local var_19_2 = {}

	for iter_19_0 = 1, #var_19_1 do
		local var_19_3 = tonumber(var_19_1[iter_19_0]) or 0
		local var_19_4 = string.format("%s_preview_%s", arg_19_2, tostring(var_19_3))

		var_19_2[#var_19_2 + 1] = {
			rewardCount = 1,
			progressText = "0/1",
			rewardId = var_19_4,
			rewardName = arg_19_1:ResolveRewardName(var_19_3),
			state = arg_19_4[var_19_4] or iter_19_0 == 1 and "canReceive" or "locked"
		}
	end

	if #var_19_2 == 0 then
		local var_19_5 = (SummerRaceConst.REWARD_DEFS[arg_19_2] or {})[arg_19_3] or {}

		for iter_19_1 = 1, #var_19_5 do
			local var_19_6 = arg_19_1:CloneTable(var_19_5[iter_19_1])

			var_19_6.state = arg_19_4[var_19_6.rewardId] or var_19_6.state
			var_19_2[#var_19_2 + 1] = var_19_6
		end
	end

	return var_19_2
end

function var_0_0.BuildRewardPageModelFromCfg(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = arg_20_1:ResolveRewardActivityId(arg_20_2, arg_20_3)
	local var_20_1 = var_20_0 ~= 0 and LimitTimeTaskCfg and LimitTimeTaskCfg[var_20_0] or nil
	local var_20_2 = {}

	if var_20_1 ~= nil then
		var_20_2 = arg_20_1:BuildTaskRewardList(var_20_0, arg_20_4)
	end

	if #var_20_2 == 0 then
		var_20_2 = arg_20_1:BuildPreviewRewardList(arg_20_2, arg_20_3, arg_20_4)
	end

	local var_20_3 = 0

	for iter_20_0 = 1, #var_20_2 do
		if var_20_2[iter_20_0].state == "canReceive" then
			var_20_3 = var_20_3 + 1
		end
	end

	return {
		pageType = arg_20_2,
		subType = arg_20_3,
		activityId = var_20_0,
		rootActivityId = arg_20_1:GetSummerRaceTaskRootActivityId(),
		rewardList = var_20_2,
		progressText = string.format("%d / %d rewards ready", var_20_3, #var_20_2),
		emptyState = #var_20_2 == 0
	}
end

function var_0_0.BuildResidentRewardEntryModel(arg_21_0, arg_21_1)
	local var_21_0 = ActivityConst.ACTIVITY_SUMMER_RACE_MAIN
	local var_21_1 = arg_21_1:GetAssignmentIdListByActivityId(var_21_0)
	local var_21_2 = 0
	local var_21_3 = #var_21_1

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		if arg_21_1:IsTaskFinishedOrReceivable(iter_21_1) then
			var_21_2 = var_21_2 + 1
		end
	end

	return {
		activityId = var_21_0,
		completedCount = var_21_2,
		totalCount = var_21_3,
		progressText = string.format("<size=48>%d</size>/%d", math.max(0, var_21_2), math.max(0, var_21_3))
	}
end

function var_0_0.SetRewardPage(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_1:NormalizeRewardPageType(arg_22_2)
	local var_22_1 = arg_22_1.outGameState_.rewardSubType

	if var_22_0 == SummerRaceConst.REWARD_PAGE.LIMITED or arg_22_3 ~= nil then
		var_22_1 = arg_22_1:NormalizeRewardSubType(arg_22_3 or var_22_1)
	end

	arg_22_1.outGameState_.rewardPageType = var_22_0
	arg_22_1.outGameState_.rewardSubType = var_22_1

	if not arg_22_4 then
		arg_22_1:NotifyOutGameUpdated("rewardPage")
	end

	return arg_22_1.outGameState_.rewardPageType, arg_22_1.outGameState_.rewardSubType
end

function var_0_0.GetRewardPageSelection(arg_23_0, arg_23_1)
	return arg_23_1.outGameState_.rewardPageType, arg_23_1.outGameState_.rewardSubType
end

function var_0_0.GetRewardRootActivityId(arg_24_0, arg_24_1)
	return arg_24_1:GetSummerRaceTaskRootActivityId()
end

function var_0_0.GetRewardActivityId(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_2 ~= nil and arg_25_1:NormalizeRewardPageType(arg_25_2) or arg_25_3 ~= nil and SummerRaceConst.REWARD_PAGE.LIMITED or arg_25_1.outGameState_.rewardPageType
	local var_25_1 = arg_25_1:NormalizeRewardSubType(arg_25_3 or arg_25_1.outGameState_.rewardSubType)

	return arg_25_1:ResolveRewardActivityId(var_25_0, var_25_1)
end

function var_0_0.ResolveRewardEntryPage(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_2 == SummerRaceConst.REWARD_PAGE.RESIDENT then
		return SummerRaceConst.REWARD_PAGE.RESIDENT, arg_26_3 ~= nil and arg_26_1:NormalizeRewardSubType(arg_26_3) or nil
	end

	if arg_26_2 == SummerRaceConst.REWARD_PAGE.LIMITED or arg_26_3 ~= nil then
		if arg_26_3 ~= nil then
			return SummerRaceConst.REWARD_PAGE.LIMITED, arg_26_1:NormalizeRewardSubType(arg_26_3)
		end

		local var_26_0 = arg_26_1.outGameState_.rewardStateMap

		for iter_26_0 = 1, #SummerRaceConst.LIMITED_ENTRY_SUBTYPE_PRIORITY do
			local var_26_1 = SummerRaceConst.LIMITED_ENTRY_SUBTYPE_PRIORITY[iter_26_0]
			local var_26_2 = arg_26_1:BuildRewardPageModelFromCfg(SummerRaceConst.REWARD_PAGE.LIMITED, var_26_1, var_26_0).rewardList or {}

			for iter_26_1 = 1, #var_26_2 do
				if var_26_2[iter_26_1].state == "canReceive" then
					return SummerRaceConst.REWARD_PAGE.LIMITED, var_26_1
				end
			end
		end

		local var_26_3 = arg_26_1:NormalizeRewardSubType(arg_26_1.outGameState_.rewardSubType)

		if arg_26_1:BuildRewardPageModelFromCfg(SummerRaceConst.REWARD_PAGE.LIMITED, var_26_3, var_26_0).emptyState ~= true then
			return SummerRaceConst.REWARD_PAGE.LIMITED, var_26_3
		end

		return SummerRaceConst.REWARD_PAGE.LIMITED, SummerRaceConst.REWARD_SUBTYPE.DAILY
	end

	local var_26_4 = arg_26_1.outGameState_.rewardStateMap

	for iter_26_2 = 1, #SummerRaceConst.REWARD_ENTRY_PRIORITY do
		local var_26_5 = SummerRaceConst.REWARD_ENTRY_PRIORITY[iter_26_2]
		local var_26_6 = arg_26_1:BuildRewardPageModelFromCfg(var_26_5[1], var_26_5[2], var_26_4).rewardList or {}

		for iter_26_3 = 1, #var_26_6 do
			if var_26_6[iter_26_3].state == "canReceive" then
				return var_26_5[1], var_26_5[2]
			end
		end
	end

	local var_26_7, var_26_8 = arg_26_1:GetRewardPageSelection()

	if arg_26_1:BuildRewardPageModelFromCfg(var_26_7, var_26_8, var_26_4).emptyState ~= true then
		return var_26_7, var_26_8
	end

	return SummerRaceConst.REWARD_PAGE.LIMITED, SummerRaceConst.REWARD_SUBTYPE.DAILY
end

function var_0_0.MarkRewardReceived(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_2 and arg_27_2 ~= "" then
		arg_27_1.outGameState_.rewardStateMap[arg_27_2] = "received"
		arg_27_1.outGameState_.selectedRewardId = arg_27_2
	end

	if not arg_27_3 then
		arg_27_1:NotifyOutGameUpdated("rewardReceive")
	end
end

function var_0_0.TryPrepareStageFirstClearUnlock(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = tonumber(arg_28_2) or arg_28_2

	if var_28_0 == nil or var_28_0 == "" or var_28_0 == 0 then
		return false
	end

	local var_28_1 = arg_28_1:FindStageInfoById(var_28_0)
	local var_28_2 = arg_28_1:FindRuntimeStageInfoById(var_28_0)

	if var_28_1 == nil or type(var_28_1.rewardList) ~= "table" or #var_28_1.rewardList <= 0 then
		return false
	end

	if arg_28_4 == true then
		return false
	end

	if arg_28_4 ~= false and var_28_2 ~= nil and var_28_2.isCompleted == true then
		return false
	end

	local var_28_3 = arg_28_1:BuildPendingUnlockModelFromStageReward(var_28_1)

	if var_28_3 == nil then
		return false
	end

	arg_28_1:SetPendingUnlockModel(var_28_3, arg_28_3)

	return true
end

function var_0_0.ConsumePendingUnlockPopModel(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1:CloneTable(arg_29_1.outGameState_.pendingUnlockModel)

	if type(var_29_0) ~= "table" or var_29_0.shouldOpenPop ~= true then
		return nil
	end

	arg_29_1.outGameState_.pendingUnlockModel.shouldOpenPop = false

	return var_29_0
end

function var_0_0.ConsumePendingStageUnlockBannerModel(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1.outGameState_.pendingStageUnlockBannerQueue
	local var_30_1

	if type(var_30_0) == "table" and #var_30_0 > 0 then
		var_30_1 = table.remove(var_30_0, 1)
		arg_30_1.outGameState_.pendingStageUnlockBannerModel = var_30_0[1] ~= nil and arg_30_1:CloneTable(var_30_0[1]) or arg_30_1:BuildDefaultPendingStageUnlockBanner()
	else
		var_30_1 = arg_30_1:CloneTable(arg_30_1.outGameState_.pendingStageUnlockBannerModel)
	end

	if type(var_30_1) ~= "table" or var_30_1.shouldOpenPop ~= true then
		return nil
	end

	if type(var_30_0) ~= "table" or #var_30_0 == 0 then
		arg_30_1.outGameState_.pendingStageUnlockBannerModel.shouldOpenPop = false
	end

	return var_30_1
end

function var_0_0.GetRewardPageModel(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_2 ~= nil or arg_31_3 ~= nil then
		arg_31_1:SetRewardPage(arg_31_2 or arg_31_1.outGameState_.rewardPageType, arg_31_3 or arg_31_1.outGameState_.rewardSubType, true)
	end

	return arg_31_1:BuildRewardPageModelFromCfg(arg_31_1.outGameState_.rewardPageType, arg_31_1.outGameState_.rewardSubType, arg_31_1.outGameState_.rewardStateMap)
end

function var_0_0.GetPendingUnlockModel(arg_32_0, arg_32_1)
	return arg_32_1:CloneTable(arg_32_1.outGameState_.pendingUnlockModel)
end

function var_0_0.GetPendingStageUnlockBannerModel(arg_33_0, arg_33_1)
	return arg_33_1:CloneTable(arg_33_1.outGameState_.pendingStageUnlockBannerModel)
end

function var_0_0.GetUnlockPopViewModel(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:GetPendingUnlockModel()
	local var_34_1 = arg_34_1:CloneTable(var_34_0.unlockItemList)

	if type(var_34_1) ~= "table" or #var_34_1 == 0 then
		local var_34_2 = var_34_0.itemId
		local var_34_3 = arg_34_1:GetOptionDefById(var_34_2)
		local var_34_4

		if var_34_3 ~= nil then
			var_34_4 = {
				isCar = false,
				itemId = var_34_3.itemId,
				itemName = tostring(var_34_3.itemName or var_34_0.itemName or ""),
				iconPath = tostring(var_34_3.iconPath or var_34_3.icon or "")
			}
		else
			local var_34_5 = arg_34_1:GetBodyDefs()
			local var_34_6

			for iter_34_0 = 1, #var_34_5 do
				if tostring(var_34_5[iter_34_0].bodyId or "") == tostring(var_34_2 or "") then
					var_34_6 = var_34_5[iter_34_0]

					break
				end
			end

			var_34_4 = {
				itemId = var_34_6 and var_34_6.bodyId or var_34_2,
				itemName = tostring(var_34_6 and var_34_6.bodyName or var_34_0.itemName or ""),
				iconPath = tostring(var_34_6 and (var_34_6.iconPath or var_34_6.icon) or ""),
				isCar = var_34_6 ~= nil
			}
		end

		var_34_1 = {
			var_34_4
		}
	end

	return {
		unlockItemList = var_34_1
	}
end

function var_0_0.GetUnlockBannerModel(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1:GetPendingStageUnlockBannerModel()
	local var_35_1 = arg_35_1:NormalizeSourceType(arg_35_2 or var_35_0.sourceType)
	local var_35_2 = var_35_0.title
	local var_35_3 = var_35_0.desc

	if var_35_2 == nil or var_35_2 == "" then
		local var_35_4 = arg_35_1:BuildFallbackStageUnlockBannerModel(var_35_1)

		var_35_2 = var_35_4.title
		var_35_3 = var_35_4.desc
		var_35_1 = var_35_4.sourceType
	end

	return {
		sourceType = var_35_1,
		title = var_35_2,
		desc = var_35_3
	}
end

return var_0_0
