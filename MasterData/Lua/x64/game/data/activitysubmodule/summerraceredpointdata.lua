local SummerRaceRedPointData = class("SummerRaceRedPointData")
local var_0_1 = {
	OPTION = "option",
	BODY = "body"
}

function SummerRaceRedPointData:ExportMethod()
	return {
		"BuildMainRedPointKey",
		"BuildResidentEntryRedPointKey",
		"BuildLimitTaskRedPointKey",
		"BuildLimitTaskTabRedPointKey",
		"BuildActivityTaskRedPointKey",
		"BuildNormalTaskRedPointKey",
		"BuildChampionshipRedPointKey",
		"BuildChallengeRedPointKey",
		"BuildModifyRedPointKey",
		"BuildBodyNewRedPointKey",
		"BuildOptionNewRedPointKey",
		"IsBodyNewRedPointRead",
		"IsOptionNewRedPointRead",
		"MarkBodyNewRedPointRead",
		"MarkOptionNewRedPointRead",
		"IsChampionshipEntryClickedToday",
		"MarkChampionshipEntryClickedToday",
		"HasUnreadChampionshipStage",
		"HasChallengeEntryRedPoint",
		"HasUnreadBodyNewRedPoint",
		"HasUnreadOptionNewRedPoint",
		"HasModifyEntryRedPoint",
		"HasReceivableReward",
		"HasReceivableTaskByActivityId",
		"HasReceivableRewardByActivityId",
		"HasReceivablePointRewardByActivityId",
		"HasReceivableResidentReward",
		"MarkChampionshipEntryClicked",
		"EnsureFrameworkRedPoints",
		"RefreshFrameworkRedPoints"
	}
end

function SummerRaceRedPointData:BuildMainRedPointKey(arg_2_1)
	return string.format("%s_%s_inner", RedPointConst.SUMMER_RACE_ACTIVITY_MAIN, SummerRaceConst.ACTIVITY_ID.MAIN)
end

function SummerRaceRedPointData:BuildResidentEntryRedPointKey(arg_3_1)
	return string.format("%s%s", ActivityTools.GetRedPointKey(SummerRaceConst.ACTIVITY_ID.RESIDENT), SummerRaceConst.ACTIVITY_ID.RESIDENT)
end

function SummerRaceRedPointData:BuildLimitTaskRedPointKey(arg_4_1)
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_LIMIT_TASK, SummerRaceConst.ACTIVITY_ID.MAIN)
end

function SummerRaceRedPointData:BuildLimitTaskTabRedPointKey(arg_5_1, arg_5_2)
	return string.format("%s%s", RedPointConst.SUMMER_RACE_LIMIT_TASK_TAG, tostring(arg_5_2 or 0))
end

function SummerRaceRedPointData:BuildActivityTaskRedPointKey(arg_6_1, arg_6_2)
	return string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_6_2)
end

function SummerRaceRedPointData:BuildNormalTaskRedPointKey(arg_7_1)
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_NORMAL_TASK, SummerRaceConst.ACTIVITY_ID.MAIN)
end

function SummerRaceRedPointData:BuildChampionshipRedPointKey(arg_8_1)
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_CHAMPIONSHIP, SummerRaceConst.ACTIVITY_ID.MAIN)
end

function SummerRaceRedPointData:BuildChallengeRedPointKey(arg_9_1)
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_CHALLENGE, SummerRaceConst.ACTIVITY_ID.MAIN)
end

function SummerRaceRedPointData:BuildModifyRedPointKey(arg_10_1)
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_MODIFY, SummerRaceConst.ACTIVITY_ID.MAIN)
end

function SummerRaceRedPointData:BuildBodyNewRedPointKey(arg_11_1, arg_11_2)
	return string.format("%s_%s_%s", RedPointConst.SUMMER_RACE_BODY_NEW, SummerRaceConst.ACTIVITY_ID.MAIN, tostring(arg_11_2 or 0))
end

function SummerRaceRedPointData:BuildOptionNewRedPointKey(arg_12_1, arg_12_2)
	return string.format("%s_%s_%s", RedPointConst.SUMMER_RACE_OPTION_NEW, SummerRaceConst.ACTIVITY_ID.MAIN, tostring(arg_12_2 or 0))
end

function SummerRaceRedPointData:BuildModifyItemNewRedPointKey(arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 == var_0_1.BODY then
		return self:BuildBodyNewRedPointKey(arg_13_1, arg_13_3)
	end

	return self:BuildOptionNewRedPointKey(arg_13_1, arg_13_3)
end

function SummerRaceRedPointData:IsModifyItemNewRedPointRead(arg_14_1, arg_14_2, arg_14_3)
	return RedPointData:GetJsonCacheRedPoint(self:BuildModifyItemNewRedPointKey(arg_14_1, arg_14_2, arg_14_3)) == 0
end

function SummerRaceRedPointData:ShouldShowModifyItemNewRedPoint(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_2 == nil or arg_15_2.isUnlocked ~= true or arg_15_2.isDefaultUnlocked == true then
		return false
	end

	return self:IsModifyItemNewRedPointRead(arg_15_1, arg_15_3, (arg_15_3 == var_0_1.BODY or nil) and (arg_15_2.bodyId or arg_15_2.itemId)) ~= true
end

function SummerRaceRedPointData:MarkModifyItemNewRedPointRead(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = self:BuildModifyItemNewRedPointKey(arg_16_1, arg_16_2, arg_16_3)

	RedPointData:SetJsonCacheRedPoint(var_16_0)
	manager.redPoint:setTip(var_16_0, 0)

	if not arg_16_4 then
		arg_16_1:NotifyOutGameUpdated("modifyItemNewRedPoint")
	end
end

function SummerRaceRedPointData:IsBodyNewRedPointRead(arg_17_1, arg_17_2)
	return self:IsModifyItemNewRedPointRead(arg_17_1, var_0_1.BODY, arg_17_2)
end

function SummerRaceRedPointData:IsOptionNewRedPointRead(arg_18_1, arg_18_2)
	return self:IsModifyItemNewRedPointRead(arg_18_1, var_0_1.OPTION, arg_18_2)
end

function SummerRaceRedPointData:MarkBodyNewRedPointRead(arg_19_1, arg_19_2, arg_19_3)
	self:MarkModifyItemNewRedPointRead(arg_19_1, var_0_1.BODY, arg_19_2, arg_19_3)
end

function SummerRaceRedPointData:MarkOptionNewRedPointRead(arg_20_1, arg_20_2, arg_20_3)
	self:MarkModifyItemNewRedPointRead(arg_20_1, var_0_1.OPTION, arg_20_2, arg_20_3)
end

function SummerRaceRedPointData:IsChampionshipEntryClickedToday(arg_21_1)
	local var_21_0 = getData(SummerRaceConst.CHAMPIONSHIP_CLICK_NAMESPACE, SummerRaceConst.CHAMPIONSHIP_ENTRY_CLICK_KEY) or 0

	return tonumber(var_21_0) ~= nil and manager.time:GetTodayFreshTime() <= tonumber(var_21_0)
end

function SummerRaceRedPointData:MarkChampionshipEntryClickedToday(arg_22_1)
	saveData(SummerRaceConst.CHAMPIONSHIP_CLICK_NAMESPACE, SummerRaceConst.CHAMPIONSHIP_ENTRY_CLICK_KEY, manager.time:GetServerTime())

	return true
end

function SummerRaceRedPointData:HasUnreadChampionshipStage(arg_23_1, arg_23_2)
	local var_23_0 = type(arg_23_2) == "table" and arg_23_2 or arg_23_1:GetTournamentStageMap()

	if self:IsChampionshipEntryClickedToday(arg_23_1) == true then
		return false
	end

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		for iter_23_2 = 1, #iter_23_1 do
			if iter_23_1[iter_23_2].isUnlocked == true and iter_23_1[iter_23_2].isCompleted ~= true then
				return true
			end
		end
	end

	return false
end

function SummerRaceRedPointData:HasChallengeEntryRedPoint(arg_24_1)
	if arg_24_1:GetChallengeUnlockState().isUnlocked ~= true then
		return false
	end

	return arg_24_1:HasChallengeRecord() ~= true
end

function SummerRaceRedPointData:HasUnreadBodyNewRedPoint(arg_25_1)
	return self:HasUnreadModifyItemNewRedPoint(arg_25_1, arg_25_1:GetBodyDefs(), var_0_1.BODY)
end

function SummerRaceRedPointData:HasUnreadOptionNewRedPoint(arg_26_1)
	return self:HasUnreadModifyItemNewRedPoint(arg_26_1, arg_26_1:GetCombinedOptionDefs(), var_0_1.OPTION)
end

function SummerRaceRedPointData:HasUnreadModifyItemNewRedPoint(arg_27_1, arg_27_2, arg_27_3)
	for iter_27_0 = 1, #arg_27_2 do
		if self:ShouldShowModifyItemNewRedPoint(arg_27_1, arg_27_2[iter_27_0], arg_27_3) then
			return true
		end
	end

	return false
end

function SummerRaceRedPointData:HasModifyEntryRedPoint(arg_28_1)
	return self:HasUnreadBodyNewRedPoint(arg_28_1) or self:HasUnreadOptionNewRedPoint(arg_28_1)
end

function SummerRaceRedPointData:BuildModifyNewRedPointKeys(arg_29_1)
	local var_29_0 = {}
	local var_29_1 = arg_29_1:GetBodyDefs()
	local var_29_2 = arg_29_1:GetCombinedOptionDefs()

	for iter_29_0 = 1, #var_29_1 do
		var_29_0[#var_29_0 + 1] = self:BuildModifyItemNewRedPointKey(arg_29_1, var_0_1.BODY, var_29_1[iter_29_0].bodyId)
	end

	for iter_29_1 = 1, #var_29_2 do
		var_29_0[#var_29_0 + 1] = self:BuildModifyItemNewRedPointKey(arg_29_1, var_0_1.OPTION, var_29_2[iter_29_1].itemId)
	end

	return var_29_0
end

function SummerRaceRedPointData:RefreshModifyNewRedPoints(arg_30_1)
	local function var_30_0(arg_31_0, arg_31_1)
		for iter_31_0 = 1, #arg_31_0 do
			local var_31_0 = arg_31_0[iter_31_0]

			if arg_31_1 == var_0_1.BODY then
				local var_31_2

				if not var_31_0.bodyId then
					var_31_2 = self:BuildModifyItemNewRedPointKey(arg_30_1, arg_31_1, var_31_0.itemId)
				end
			end

			manager.redPoint:setTip(var_31_2, self:ShouldShowModifyItemNewRedPoint(arg_30_1, var_31_0, arg_31_1) and 1 or 0)
		end
	end

	var_30_0(arg_30_1:GetBodyDefs(), var_0_1.BODY)
	var_30_0(arg_30_1:GetCombinedOptionDefs(), var_0_1.OPTION)
end

function SummerRaceRedPointData:HasReceivableReward(arg_32_1, arg_32_2)
	for iter_32_0 = 1, #arg_32_2 do
		local var_32_0 = arg_32_2[iter_32_0].rewardList or {}

		for iter_32_1 = 1, #var_32_0 do
			if var_32_0[iter_32_1].state == "canReceive" then
				return true
			end
		end
	end

	return false
end

function SummerRaceRedPointData:HasReceivableTaskByActivityId(arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1:GetAssignmentIdListByActivityId(arg_33_2)

	for iter_33_0 = 1, #var_33_0 do
		local var_33_1 = var_33_0[iter_33_0]

		if AssignmentCfg[var_33_0[iter_33_0]] ~= nil then
			local var_33_2 = math.max(0, tonumber(AssignmentCfg[var_33_0[iter_33_0]].need) or 0)
			local var_33_3 = tonumber(TaskData2 and TaskData2.GetTaskProgress and TaskData2:GetTaskProgress(var_33_1))

			var_33_3 = var_33_3 or 0

			local var_33_4 = math.max(0, var_33_3)

			if (TaskData2 and TaskData2.GetTaskComplete and TaskData2:GetTaskComplete(var_33_1) == true or false) ~= true then
				if var_33_2 > 0 and var_33_2 <= var_33_4 then
					return true
				end

				if var_33_2 <= 0 and var_33_4 > 0 then
					return true
				end
			end
		end
	end

	return false
end

function SummerRaceRedPointData:HasReceivableRewardByActivityId(arg_34_1, arg_34_2)
	return self:HasReceivableTaskByActivityId(arg_34_1, arg_34_2)
end

function SummerRaceRedPointData:HasReceivablePointRewardByActivityId(arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1:GetAssignmentIdListByActivityId(arg_35_2)

	if #var_35_0 == 0 then
		return false
	end

	local var_35_1 = tonumber(TaskData2 and TaskData2.GetTaskProgress and TaskData2:GetTaskProgress(var_35_0[#var_35_0]))

	var_35_1 = var_35_1 or 0

	local var_35_2 = math.max(0, var_35_1)

	for iter_35_0 = 1, #var_35_0 do
		if AssignmentCfg[var_35_0[iter_35_0]] ~= nil and TaskData2:GetTaskComplete(var_35_0[iter_35_0]) ~= true then
			if var_35_2 >= (tonumber(AssignmentCfg[var_35_0[iter_35_0]].need) or 0) then
				return true
			end
		end
	end

	return false
end

function SummerRaceRedPointData:HasReceivableResidentReward(arg_36_1)
	return self:HasReceivableTaskByActivityId(arg_36_1, ActivityConst.ACTIVITY_SUMMER_RACE_MAIN)
end

function SummerRaceRedPointData:MarkChampionshipEntryClicked(arg_37_1, arg_37_2)
	if self:MarkChampionshipEntryClickedToday(arg_37_1) ~= true then
		return false
	end

	if not arg_37_2 then
		arg_37_1:NotifyOutGameUpdated("championshipEntryClick")
	end

	return true
end

function SummerRaceRedPointData:EnsureFrameworkRedPoints(arg_38_1)
	if not manager or not manager.redPoint or not manager.redPoint.addGroup then
		return
	end

	if arg_38_1.frameworkRedPointReady_ == true then
		return
	end

	manager.redPoint:addGroup(self:BuildResidentEntryRedPointKey(arg_38_1), {
		self:BuildMainRedPointKey(arg_38_1)
	})
	manager.redPoint:addGroup(self:BuildMainRedPointKey(arg_38_1), {
		self:BuildChampionshipRedPointKey(arg_38_1),
		self:BuildChallengeRedPointKey(arg_38_1),
		self:BuildLimitTaskRedPointKey(arg_38_1),
		self:BuildNormalTaskRedPointKey(arg_38_1)
	})
	manager.redPoint:addGroup(self:BuildModifyRedPointKey(arg_38_1), self:BuildModifyNewRedPointKeys(arg_38_1), true)

	local var_38_0 = arg_38_1:GetRewardRootActivityId()
	local var_38_1 = {
		self:BuildActivityTaskRedPointKey(arg_38_1, var_38_0)
	}
	local var_38_2

	if ActivityCfg[var_38_0] then
		var_38_2 = ActivityCfg[var_38_0].sub_activity_list or {}
	end

	for iter_38_0 = 1, #var_38_2 do
		local var_38_3 = self:BuildActivityTaskRedPointKey(arg_38_1, var_38_2[iter_38_0])

		var_38_1[#var_38_1 + 1] = var_38_3

		manager.redPoint:addGroup(self:BuildLimitTaskTabRedPointKey(arg_38_1, var_38_2[iter_38_0]), {
			var_38_3
		}, true)
	end

	manager.redPoint:addGroup(self:BuildLimitTaskRedPointKey(arg_38_1), var_38_1, true)
	manager.redPoint:addGroup(self:BuildNormalTaskRedPointKey(arg_38_1), {
		self:BuildActivityTaskRedPointKey(arg_38_1, ActivityConst.ACTIVITY_SUMMER_RACE_MAIN)
	}, true)

	arg_38_1.frameworkRedPointReady_ = true

	self:RefreshFrameworkRedPoints(arg_38_1)
end

function SummerRaceRedPointData:RefreshFrameworkRedPoints(arg_39_1)
	if not manager or not manager.redPoint or not manager.redPoint.setTip then
		return
	end

	local var_39_0 = {
		arg_39_1:BuildRewardPageModelFromCfg(SummerRaceConst.REWARD_PAGE.LIMITED, SummerRaceConst.REWARD_SUBTYPE.DAILY, arg_39_1.outGameState_.rewardStateMap),
		arg_39_1:BuildRewardPageModelFromCfg(SummerRaceConst.REWARD_PAGE.LIMITED, SummerRaceConst.REWARD_SUBTYPE.STAGE, arg_39_1.outGameState_.rewardStateMap),
		arg_39_1:BuildRewardPageModelFromCfg(SummerRaceConst.REWARD_PAGE.LIMITED, SummerRaceConst.REWARD_SUBTYPE.ACHIEVEMENT, arg_39_1.outGameState_.rewardStateMap)
	}
	local var_39_1 = self:HasUnreadChampionshipStage(arg_39_1, arg_39_1:GetTournamentStageMap())
	local var_39_2 = self:HasChallengeEntryRedPoint(arg_39_1)
	local var_39_3 = arg_39_1:GetRewardRootActivityId()
	local var_39_4

	if ActivityCfg[var_39_3] then
		var_39_4 = ActivityCfg[var_39_3].sub_activity_list or {}
	end

	local var_39_5 = self:HasReceivableReward(arg_39_1, var_39_0) or self:HasReceivablePointRewardByActivityId(arg_39_1, var_39_3)

	for iter_39_0 = 1, #var_39_4 do
		local var_39_6 = var_39_4[iter_39_0]
		local var_39_7 = self:HasReceivableRewardByActivityId(arg_39_1, var_39_4[iter_39_0])

		if var_39_7 then
			var_39_5 = true
		end

		manager.redPoint:setTip(self:BuildActivityTaskRedPointKey(arg_39_1, var_39_6), var_39_7 and 1 or 0)
		manager.redPoint:setTip(self:BuildLimitTaskTabRedPointKey(arg_39_1, var_39_6), 0)
	end

	manager.redPoint:setTip(self:BuildChampionshipRedPointKey(arg_39_1), var_39_1 and 1 or 0)
	manager.redPoint:setTip(self:BuildChallengeRedPointKey(arg_39_1), var_39_2 and 1 or 0)
	self:RefreshModifyNewRedPoints(arg_39_1)
	manager.redPoint:setTip(self:BuildActivityTaskRedPointKey(arg_39_1, var_39_3), var_39_5 and 1 or 0)
	manager.redPoint:setTip(self:BuildLimitTaskRedPointKey(arg_39_1), 0)
	manager.redPoint:setTip(self:BuildActivityTaskRedPointKey(arg_39_1, ActivityConst.ACTIVITY_SUMMER_RACE_MAIN), self:HasReceivableResidentReward(arg_39_1) and 1 or 0)
	manager.redPoint:setTip(self:BuildNormalTaskRedPointKey(arg_39_1), 0)
end

return SummerRaceRedPointData
