local var_0_0 = class("CommanderManualPage", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_1.id
	arg_1_0.pt = arg_1_1.pt
	arg_1_0.award = arg_1_1.award
	arg_1_0.finishedTaskIds = arg_1_2
	arg_1_0.topFinishedTaskIds = arg_1_2
	arg_1_0.isUnlock = arg_1_3
	arg_1_0.topPage = 0
	arg_1_0.topUnlockTaskIds = {}

	for iter_1_0, iter_1_1 in ipairs(pg.tutorial_handbook.all) do
		if table.contains(pg.tutorial_handbook[iter_1_1].tag_list, arg_1_0.id) then
			arg_1_0.topPage = iter_1_1
			arg_1_0.topUnlockTaskIds = pg.tutorial_handbook[iter_1_1].unlock_param

			break
		end
	end

	arg_1_0.leftUnlockTaskIds = arg_1_0:getConfig("unlock")
	arg_1_0.unlockTaskIds = {}
	arg_1_0.taskIds = {}
	arg_1_0.taskIdList = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_0:getConfig("task_list")) do
		table.insert(arg_1_0.unlockTaskIds, iter_1_3[2])
		table.insert(arg_1_0.taskIds, iter_1_3[1])
		table.insertto(arg_1_0.taskIdList, iter_1_3[1])
	end

	arg_1_0.initTaskIdList = Clone(arg_1_0.taskIdList)

	arg_1_0:ChangeUnlock()

	arg_1_0.doingGetTaskIndexes = {}

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.tutorial_handbook_task
end

function var_0_0.AddPt(arg_3_0)
	arg_3_0.isUnlock = true
	arg_3_0.pt = arg_3_0.pt + 1

	return
end

function var_0_0.AddAward(arg_4_0)
	arg_4_0.isUnlock = true
	arg_4_0.award = arg_4_0.award + 1

	return
end

function var_0_0.AddFinishedTaskId(arg_5_0, arg_5_1)
	arg_5_0.isUnlock = true

	table.insert(arg_5_0.finishedTaskIds, arg_5_1)

	return
end

function var_0_0.ChangeUnlock(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.topFinishedTaskIds = arg_6_1
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.topUnlockTaskIds) do
		if not table.contains(arg_6_0.topFinishedTaskIds, iter_6_1) then
			return
		end
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.leftUnlockTaskIds) do
		if not table.contains(arg_6_0.finishedTaskIds, iter_6_3) then
			return
		end
	end

	arg_6_0.isUnlock = true

	return
end

function var_0_0.GetTasks(arg_7_0)
	if not arg_7_0.isUnlock then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.unlockTaskIds) do
		local var_7_0 = true

		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			if not table.contains(arg_7_0.finishedTaskIds, iter_7_3) then
				var_7_0 = false

				break
			end
		end

		if var_7_0 then
			for iter_7_4, iter_7_5 in ipairs(arg_7_0.taskIds[iter_7_0]) do
				local var_7_1 = getProxy(TaskProxy)

				if not var_7_1:getTaskById(iter_7_5) and not table.contains(arg_7_0.finishedTaskIds, iter_7_5) and not table.contains(arg_7_0.doingGetTaskIndexes, iter_7_0) then
					pg.m02:sendNotification(GAME.COMMANDER_MANUAL_OP, {
						operation = CommanderManualProxy.GET_TASK,
						pageId = arg_7_0.id,
						index = iter_7_0
					})
					table.insert(arg_7_0.doingGetTaskIndexes, iter_7_0)

					break
				end
			end
		end
	end

	return
end

function var_0_0.RemoveDoingGetTaskIndex(arg_8_0, arg_8_1)
	table.remove(arg_8_0.doingGetTaskIndexes, arg_8_1)

	return
end

function var_0_0.IsComplete(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.taskIdList) do
		if not table.contains(arg_9_0.finishedTaskIds, iter_9_1) then
			return false
		end
	end

	if arg_9_0.award < #arg_9_0:getConfig("target") then
		return false
	end

	return true
end

function var_0_0.GetLockTip(arg_10_0)
	if not arg_10_0.leftUnlockTaskIds or #arg_10_0.leftUnlockTaskIds == 0 then
		return ""
	end

	return pg.task_data_template[arg_10_0.leftUnlockTaskIds[1]].desc
end

function var_0_0.GetTaskLockTip(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.taskIds) do
		if table.contains(iter_11_1, arg_11_1) and #arg_11_0.unlockTaskIds[iter_11_0] > 0 then
			return pg.task_data_template[arg_11_0.unlockTaskIds[iter_11_0][1]].desc
		end
	end

	return ""
end

function var_0_0.IsTaskComplete(arg_12_0, arg_12_1)
	return table.contains(arg_12_0.finishedTaskIds, arg_12_1)
end

function var_0_0.GetCurrentPtTarget(arg_13_0)
	local var_13_0 = arg_13_0:getConfig("target")

	if arg_13_0.award == #var_13_0 then
		return var_13_0[arg_13_0.award]
	else
		return var_13_0[arg_13_0.award + 1]
	end

	return
end

function var_0_0.GetCurrentPtAward(arg_14_0)
	local var_14_0 = arg_14_0:getConfig("drop_client")

	if arg_14_0.award == #var_14_0 then
		return var_14_0[arg_14_0.award]
	else
		return var_14_0[arg_14_0.award + 1]
	end

	return
end

function var_0_0.SortTaskIdList(arg_15_0)
	local var_15_0 = getProxy(TaskProxy)

	table.sort(arg_15_0.taskIdList, CompareFuncs({
		function(arg_16_0)
			if var_15_0:getTaskById(arg_16_0) then
				return 1
			elseif arg_15_0:IsTaskComplete(arg_16_0) then
				return 2
			else
				return 3
			end

			return
		end,
		function(arg_17_0)
			local var_17_0 = var_15_0:getTaskById(arg_17_0)

			if var_17_0 then
				return -var_17_0:getTaskStatus()
			else
				return 0
			end

			return
		end,
		function(arg_18_0)
			return table.indexof(arg_15_0.initTaskIdList, arg_18_0)
		end
	}))

	return
end

function var_0_0.ShouldShowTip(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.taskIdList) do
		local var_19_0 = getProxy(TaskProxy):getTaskById(iter_19_1)

		if var_19_0 and var_19_0:getTaskStatus() == 1 then
			return true
		end
	end

	if arg_19_0.pt >= arg_19_0:GetCurrentPtTarget() and arg_19_0.award < #arg_19_0:getConfig("target") then
		return true
	end

	return false
end

return var_0_0
