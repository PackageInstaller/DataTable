local var_0_0 = {}
local var_0_1 = false

manager.net:Bind(28023, function(arg_1_0)
	if var_0_1 == false then
		var_0_1 = true

		PreviewTaskAction.InitRedPoint()
	end

	PreviewTaskData:TaskModify(arg_1_0.assignment_list)
	PreviewTaskAction.OnTaskChange()
end)
manager.net:Bind(28021, function(arg_2_0)
	PreviewTaskData:TaskModify(arg_2_0.progress_list)
	PreviewTaskAction.OnTaskChange()
end)

function var_0_0.TryToSubmitTask(arg_3_0)
	local var_3_0 = {
		id_list = {
			arg_3_0
		}
	}

	manager.net:SendWithLoadingNew(28024, var_3_0, 28025, function(arg_4_0)
		PreviewTaskAction.OnTryToSubmitTaskList(arg_4_0, var_3_0)
	end)
end

function var_0_0.TryToSubmitTaskList(arg_5_0)
	local var_5_0 = {
		id_list = arg_5_0
	}

	manager.net:SendWithLoadingNew(28024, var_5_0, 28025, function(arg_6_0)
		PreviewTaskAction.OnTryToSubmitTaskList(arg_6_0, var_5_0)
	end)
end

function var_0_0.OnTryToSubmitTaskList(arg_7_0, arg_7_1)
	local var_7_0 = {}

	if not isSuccess(arg_7_0.result) then
		ShowTips(arg_7_0.result)

		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.id_list) do
		PreviewTaskData:TaskSubmit({
			{
				vary = 1,
				id = iter_7_1
			}
		})
	end

	local var_7_1 = mergeReward2(arg_7_0.reward_list or {})

	if #var_7_1 > 0 then
		getReward2(var_7_1)
	end

	PreviewTaskAction.OnTaskChange()
end

function var_0_0.OnTaskChange()
	manager.notify:CallUpdateFunc(PREVIEW_TASK_LIST_CHANGE)
	PreviewTaskAction.RefreshRedPoint()
end

function var_0_0.InitRedPoint()
	local var_9_0 = {}
	local var_9_1 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.PREVIEW_TASK]

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		var_9_0[#var_9_0 + 1] = string.format("%s_%s", RedPointConst.PREVIEW_TASK, iter_9_1)
	end

	manager.redPoint:addGroup(RedPointConst.PREVIEW_TASK, var_9_0)
end

function var_0_0.RefreshRedPoint()
	local var_10_0 = PreviewTaskData:GetActivityIDList()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_1 = 0

		if ActivityData:GetActivityIsOpen(iter_10_0) then
			local var_10_2 = AssignmentCfg.get_id_list_by_activity_id[iter_10_0]

			if var_10_2 ~= nil then
				for iter_10_2, iter_10_3 in ipairs(var_10_2) do
					local var_10_3 = AssignmentCfg[iter_10_3]
					local var_10_4 = PreviewTaskData:GetTaskProgress(iter_10_3)
					local var_10_5 = PreviewTaskData:GetTaskComplete(iter_10_3)

					if var_10_4 >= var_10_3.need and not var_10_5 then
						var_10_1 = 1

						break
					end
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PREVIEW_TASK, iter_10_0), var_10_1)
	end
end

return var_0_0
