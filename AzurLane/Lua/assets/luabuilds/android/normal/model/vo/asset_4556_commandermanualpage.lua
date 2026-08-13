class = var_0_10000

local var_0_0 = "CommanderManualPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_1.id
	arg_1_0.pt = arg_1_1.pt
	arg_1_0.award = arg_1_1.award
	arg_1_0.finishedTaskIds = arg_1_2
	arg_1_0.topFinishedTaskIds = arg_1_2
	arg_1_0.isUnlock = arg_1_3
	arg_1_0.topPage = 0
	arg_1_0.topUnlockTaskIds = {}
	ipairs = var_4
	pg = var_1_10005

	for iter_1_0, iter_1_1 in var_4(var_1_10005.tutorial_handbook.all) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.tutorial_handbook[iter_1_1]
		table = var_1_10010

		if var_1_10010.contains(var_1_10009.tag_list, arg_1_0.id) then
			arg_1_0.topPage = iter_1_1
			arg_1_0.topUnlockTaskIds = var_1_10009.unlock_param

			break
		end
	end

	arg_1_0.leftUnlockTaskIds = arg_1_0:getConfig("unlock")
	arg_1_0.unlockTaskIds = {}
	arg_1_0.taskIds = {}
	arg_1_0.taskIdList = {}
	ipairs = var_4

	for iter_1_2, iter_1_3 in var_4(arg_1_0:getConfig("task_list")) do
		local var_1_0 = iter_1_3[1]
		local var_1_1 = iter_1_3[2]

		table = var_1_10011

		var_1_10011.insert(arg_1_0.unlockTaskIds, var_1_1)

		table = var_1_10011

		var_1_10011.insert(arg_1_0.taskIds, var_1_0)

		table = var_1_10011

		var_1_10011.insertto(arg_1_0.taskIdList, var_1_0)
	end

	Clone = var_4
	arg_1_0.initTaskIdList = var_4(arg_1_0.taskIdList)

	arg_1_0:ChangeUnlock()

	arg_1_0.doingGetTaskIndexes = {}

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.tutorial_handbook_task
end

function var_0_1.AddPt(arg_3_0)
	arg_3_0.isUnlock = true
	arg_3_0.pt = arg_3_0.pt + 1

	return
end

function var_0_1.AddAward(arg_4_0)
	arg_4_0.isUnlock = true
	arg_4_0.award = arg_4_0.award + 1

	return
end

function var_0_1.AddFinishedTaskId(arg_5_0, arg_5_1)
	arg_5_0.isUnlock = true
	table = var_2

	var_2.insert(arg_5_0.finishedTaskIds, arg_5_1)

	return
end

function var_0_1.ChangeUnlock(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.topFinishedTaskIds = arg_6_1
	end

	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.topUnlockTaskIds) do
		table = var_1_10007

		if not var_1_10007.contains(arg_6_0.topFinishedTaskIds, iter_6_1) then
			return
		end
	end

	ipairs = var_2

	for iter_6_2, iter_6_3 in var_2(arg_6_0.leftUnlockTaskIds) do
		table = var_1_10007

		if not var_1_10007.contains(arg_6_0.finishedTaskIds, iter_6_3) then
			return
		end
	end

	arg_6_0.isUnlock = true

	return
end

function var_0_1.GetTasks(arg_7_0)
	if not arg_7_0.isUnlock then
		return
	end

	ipairs = var_1

	for iter_7_0, iter_7_1 in var_1(arg_7_0.unlockTaskIds) do
		local var_7_0 = true

		ipairs = var_1_10007

		for iter_7_2, iter_7_3 in var_1_10007(iter_7_1) do
			table = var_1_10012

			if not var_1_10012.contains(arg_7_0.finishedTaskIds, iter_7_3) then
				var_7_0 = false

				break
			end
		end

		if var_7_0 then
			ipairs = var_1_10007

			for iter_7_4, iter_7_5 in var_1_10007(arg_7_0.taskIds[iter_7_0]) do
				getProxy = var_1_10012
				TaskProxy = var_1_10013
				var_1_10013 = var_1_10012(var_1_10013)

				if not var_1_10012.getTaskById(var_1_10013, iter_7_5) then
					table = var_1_10013

					if not var_1_10013.contains(arg_7_0.finishedTaskIds, iter_7_5) then
						table = var_1_10013

						if not var_1_10013.contains(arg_7_0.doingGetTaskIndexes, iter_7_0) then
							pg = var_1_10013

							local var_7_1 = var_1_10013.m02

							var_1_10013 = var_1_10013.sendNotification
							GAME = var_15

							local var_7_2 = var_15.COMMANDER_MANUAL_OP
							local var_7_3 = {}

							CommanderManualProxy = var_1_10017
							var_7_3.operation = var_1_10017.GET_TASK
							var_7_3.pageId = arg_7_0.id
							var_7_3.index = iter_7_0

							var_1_10013(var_7_1, var_7_2, var_7_3)

							table = var_1_10013

							var_1_10013.insert(arg_7_0.doingGetTaskIndexes, iter_7_0)

							break
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.RemoveDoingGetTaskIndex(arg_8_0, arg_8_1)
	table = var_1_10002

	var_1_10002.remove(arg_8_0.doingGetTaskIndexes, arg_8_1)

	return
end

function var_0_1.IsComplete(arg_9_0)
	ipairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.taskIdList) do
		table = var_1_10006

		if not var_1_10006.contains(arg_9_0.finishedTaskIds, iter_9_1) then
			return false
		end
	end

	if arg_9_0.award < #arg_9_0:getConfig("target") then
		return false
	end

	return true
end

function var_0_1.GetLockTip(arg_10_0)
	if not arg_10_0.leftUnlockTaskIds or #arg_10_0.leftUnlockTaskIds == 0 then
		return ""
	end

	local var_10_0 = arg_10_0.leftUnlockTaskIds[1]

	pg = var_1_10002

	return var_1_10002.task_data_template[var_10_0].desc
end

function var_0_1.GetTaskLockTip(arg_11_0, arg_11_1)
	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.taskIds) do
		table = var_1_10007

		if var_1_10007.contains(iter_11_1, arg_11_1) then
			var_1_10007 = #arg_11_0.unlockTaskIds[iter_11_0]

			if 0 < var_1_10007 then
				var_1_10007 = arg_11_0.unlockTaskIds[iter_11_0][1]
				pg = var_8

				return var_8.task_data_template[var_1_10007].desc
			end
		end
	end

	return ""
end

function var_0_1.IsTaskComplete(arg_12_0, arg_12_1)
	table = var_1_10002

	return var_1_10002.contains(arg_12_0.finishedTaskIds, arg_12_1)
end

function var_0_1.GetCurrentPtTarget(arg_13_0)
	local var_13_0 = arg_13_0:getConfig("target")

	if arg_13_0.award == #var_13_0 then
		return var_13_0[arg_13_0.award]
	else
		return var_13_0[arg_13_0.award + 1]
	end

	return
end

function var_0_1.GetCurrentPtAward(arg_14_0)
	local var_14_0 = arg_14_0:getConfig("drop_client")

	if arg_14_0.award == #var_14_0 then
		return var_14_0[arg_14_0.award]
	else
		return var_14_0[arg_14_0.award + 1]
	end

	return
end

function var_0_1.SortTaskIdList(arg_15_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)

	table = var_1_10002

	local var_15_1 = var_1_10002.sort
	local var_15_2 = arg_15_0.taskIdList

	CompareFuncs = var_1_10004

	var_15_1(var_15_2, var_1_10004({
		function(arg_16_0)
			local var_16_0 = var_15_0

			if var_1.getTaskById(var_16_0, arg_16_0) then
				return 1
			else
				local var_16_1 = arg_15_0

				if var_1.IsTaskComplete(var_16_1, arg_16_0) then
					return 2
				else
					return 3
				end
			end

			return
		end,
		function(arg_17_0)
			local var_17_0 = var_15_0

			if var_1.getTaskById(var_17_0, arg_17_0) then
				return -var_1:getTaskStatus()
			else
				return 0
			end

			return
		end,
		function(arg_18_0)
			table = var_2_10001

			return var_2_10001.indexof(arg_15_0.initTaskIdList, arg_18_0)
		end
	}))

	return
end

function var_0_1.ShouldShowTip(arg_19_0)
	ipairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0.taskIdList) do
		getProxy = var_1_10006
		TaskProxy = var_1_10007
		var_1_10007 = var_1_10006(var_1_10007)

		if var_1_10006.getTaskById(var_1_10007, iter_19_1) and var_1_10006:getTaskStatus() == 1 then
			return true
		end
	end

	if arg_19_0.pt >= arg_19_0:GetCurrentPtTarget() and arg_19_0.award < #arg_19_0:getConfig("target") then
		return true
	end

	return false
end

return var_0_1
