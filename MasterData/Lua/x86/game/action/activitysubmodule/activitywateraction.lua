local var_0_0 = {}

function var_0_0.Init(arg_1_0)
	var_0_0.activityId_ = arg_1_0

	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_1_0), arg_1_0), {
		RedPointConst.ACTIVITY_WATER_ENTER_GROUP
	})
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_WATER_ENTER_GROUP, {
		RedPointConst.ACTIVITY_WATER_ASSIGNMENT,
		RedPointConst.ACTIVITY_WATER_MULTIPLE_OPEN
	})
	var_0_0.UpdateRedPoint()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_0.UpdateAssignmentRedPoint()
	end)
end

function var_0_0.UpdateRedPoint()
	var_0_0.UpdateAssignmentRedPoint()
	var_0_0.UpdateCooperationRedPoint()
end

function var_0_0.UpdateCooperationRedPoint()
	if not ActivitySummerWaterData:GetActivityID() then
		return
	end

	local var_4_0 = false
	local var_4_1 = manager.time:GetServerHour()

	if var_4_1 >= GameSetting.activity_water_online_open.value[1] and var_4_1 < GameSetting.activity_water_online_open.value[2] then
		local var_4_2 = getData("Activity_Water", "time")

		if not var_4_2 or not manager.time:IsToday(var_4_2) then
			var_4_0 = true
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_WATER_MULTIPLE_OPEN, var_4_0 and 1 or 0)
end

function var_0_0.UpdateAssignmentRedPoint()
	local var_5_0

	if not ActivitySummerWaterData:GetActivityID() then
		do return end

		var_5_0 = false
	end

	local var_5_1 = AssignmentCfg.get_id_list_by_activity_id[ActivitySummerWaterData:GetActivityID()]

	challengeID = ActivitySummerWaterData:GetChallengeTaskID()

	if challengeID ~= 0 then
		for iter_5_0, iter_5_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[challengeID]) do
			table.insert(var_5_1, iter_5_1)
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_1) do
		if TaskData2:GetTask(iter_5_3) then
			local var_5_2 = TaskData2:GetTask(iter_5_3).progress

			if var_5_2 > AssignmentCfg[iter_5_3].need then
				var_5_2 = AssignmentCfg[iter_5_3].need
			end

			if TaskData2:GetTaskComplete(iter_5_3) then
				-- block empty
			elseif var_5_2 >= AssignmentCfg[iter_5_3].need then
				var_5_0 = true

				break
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_WATER_ASSIGNMENT, var_5_0 and 1 or 0)
end

function var_0_0.UpdateNewScheduleRedPoint()
	if not var_0_0.activityId_ then
		return
	end

	if not ActivityData:GetActivityIsOpen(var_0_0.activityId_) then
		return
	end

	local var_6_1 = #ActivityWaterData:GetHistoryList(var_0_0.activityId_) > 0 and ActivityWaterData:IsFirstEnter(var_0_0.activityId_)

	if var_6_1 then
		CustomLog.Log(debug.traceback(string.format("needRedPoint = true")))
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_WATER_NEW_SCHEDULE, var_6_1 and 1 or 0)
end

manager.net:Bind(68011, function(arg_7_0)
	ActivitySummerWaterData:InitFromServerData(arg_7_0)

	var_0_0.activityId_ = arg_7_0.activity_id

	var_0_0.UpdateRedPoint()
end)
manager.net:Bind(68013, function(arg_8_0)
	ActivitySummerWaterData:OnChallengeSuccess(arg_8_0.main_activity_id, arg_8_0.settle_player_list)
end)
manager.net:Bind(68015, function(arg_9_0)
	manager.notify:CallUpdateFunc(XH3RD_WATER_RESULT, arg_9_0.main_activity_id)
end)
manager.net:Bind(68017, function(arg_10_0)
	ActivitySummerWaterData:OnStageRefresh(arg_10_0.activity_id, arg_10_0.open_stage_id, arg_10_0.open_online_stage_id, arg_10_0.gain_num, arg_10_0.online_gain_num)
end)

return var_0_0
