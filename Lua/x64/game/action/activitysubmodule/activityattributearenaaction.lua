local var_0_0 = {}

manager.net:Bind(72301, function(arg_1_0)
	local var_1_0 = ActivityAttributeArenaData:GetRound(arg_1_0.activity_id)

	ActivityAttributeArenaData:InitData(arg_1_0)
	var_0_0.CheckRedPoint(arg_1_0.activity_id)
	manager.notify:CallUpdateFunc(ACTIVITY_ATTRIBUTE_ARENA_UPDATE)
end)

function var_0_0.QueryResetScore(arg_2_0, arg_2_1)
	manager.net:SendWithLoadingNew(72302, {
		activity_id = arg_2_0,
		index = arg_2_1
	}, 72303, var_0_0.ResetScoreBack)
end

function var_0_0.ResetScoreBack(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		ActivityAttributeArenaData:ResetData(arg_3_1.activity_id, arg_3_1.index)
		manager.notify:CallUpdateFunc(ACTIVITY_ATTRIBUTE_ARENA_RESET)
		ShowTips("ACTIVITY_ATTRIBUTE_ARENE_RESET_SUCCESS")
	else
		ShowTips(arg_3_0.result)
	end
end

manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
	local var_4_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_ATTRIBUTE_ARENA] or {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		var_0_0.CheckRedPoint(iter_4_1)
	end
end)

function var_0_0.CheckRedPoint(arg_5_0)
	local var_5_0 = ActivityCfg[arg_5_0]
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0.sub_activity_list) do
		if ActivityCfg[iter_5_1].activity_template == ActivityTemplateConst.TASK then
			var_5_1 = iter_5_1

			break
		end
	end

	if var_5_1 == 0 or not ActivityData:GetActivityIsOpen(arg_5_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, arg_5_0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, arg_5_0), 0)

		return
	end

	local var_5_2 = true
	local var_5_3 = false
	local var_5_4 = TaskTools:GetActivityTaskList(var_5_1) or {}

	for iter_5_2, iter_5_3 in pairs(var_5_4) do
		local var_5_5 = AssignmentCfg[iter_5_3.id]
		local var_5_6 = TaskData2:GetTask(iter_5_3.id).progress

		if not TaskData2:GetTaskComplete(iter_5_3.id) then
			var_5_2 = false

			if var_5_6 >= var_5_5.need then
				var_5_3 = true
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, arg_5_0), var_5_3 and 1 or 0)

	if not ActivityAttributeArenaData:GetRead(arg_5_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, arg_5_0), not var_5_2 and 1 or 0)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, arg_5_0), 0)
	end
end

function var_0_0.SetRead(arg_6_0)
	ActivityAttributeArenaData:SetRead(arg_6_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, arg_6_0), 0)
end

return var_0_0
