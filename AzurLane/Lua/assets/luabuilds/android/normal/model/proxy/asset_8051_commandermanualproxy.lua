class = var_0_10000

local var_0_0 = "CommanderManualProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.GET_TASK = 1
var_0_1.GET_PT_AWARD = 2
var_0_1.TOP_PAGE_TASK = 100
var_0_1.TOP_PAGE_GUIDE = 200
var_0_1.TOP_PAGE_TECH = 900

function var_0_1.register(arg_1_0)
	arg_1_0:on(22300, function(arg_2_0)
		arg_1_0.commanderManualPages = {}

		local var_2_0 = arg_1_0
		local var_2_1

		if not arg_2_0.finished_task_ids then
			var_2_1 = {}
		end

		var_2_0.topFinishedTaskIds = var_2_1

		local var_2_2 = {}

		ipairs = var_2_1

		for iter_2_0, iter_2_1 in var_2_1(arg_2_0.handbooks) do
			var_2_2[iter_2_1.id] = iter_2_1
		end

		ipairs = var_2
		pg = var_3

		for iter_2_2, iter_2_3 in var_2(var_3.tutorial_handbook_task.all) do
			pg = var_2_10007
			var_2_10007 = var_2_10007.tutorial_handbook_task[iter_2_3]

			local var_2_3

			if var_2_2[iter_2_3] then
				CommanderManualPage = var_9
				var_2_3 = var_9.New(var_2_2[iter_2_3], arg_1_0.topFinishedTaskIds, true)
			else
				CommanderManualPage = var_9
				var_2_3 = var_9.New({
					pt = 0,
					award = 0,
					id = iter_2_3,
					finished_task_ids = {}
				}, arg_1_0.topFinishedTaskIds, false)
			end

			table = var_9

			var_9.insert(arg_1_0.commanderManualPages, var_2_3)
		end

		return
	end)

	return
end

function var_0_1.GetPagesByType(arg_3_0, arg_3_1)
	local var_3_0 = {}

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.commanderManualPages) do
		if iter_3_1:getConfig("type") == arg_3_1 then
			table = var_8

			var_8.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_1.GetPageById(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.commanderManualPages) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_1.AddPagePt(arg_5_0, arg_5_1)
	if arg_5_0:GetPageById(arg_5_1) then
		var_2:AddPt()
	end

	return
end

function var_0_1.AddPageAward(arg_6_0, arg_6_1)
	if arg_6_0:GetPageById(arg_6_1) then
		var_2:AddAward()
	end

	return
end

function var_0_1.TaskAutoSubmitCall(arg_7_0, arg_7_1)
	arg_7_0:UnlockTaskSubmitCall(arg_7_1)
	arg_7_0:ShowTaskSubmitCall(arg_7_1)

	return
end

function var_0_1.UnlockTaskSubmitCall(arg_8_0, arg_8_1)
	local var_8_0 = false

	ipairs = var_1_10003
	pg = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10003(var_1_10004.tutorial_handbook.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.tutorial_handbook[iter_8_1]
		table = var_1_10009

		if var_1_10009.contains(var_1_10008.unlock_param, arg_8_1) then
			table = var_1_10009

			var_1_10009.insert(arg_8_0.topFinishedTaskIds, arg_8_1)

			var_8_0 = true

			break
		end
	end

	ipairs = var_3

	for iter_8_2, iter_8_3 in var_3(arg_8_0.commanderManualPages) do
		table = var_1_10008

		if var_1_10008.contains(iter_8_3.leftUnlockTaskIds, arg_8_1) then
			iter_8_3:AddFinishedTaskId(arg_8_1)

			var_8_0 = true
		end

		ipairs = var_1_10008

		for iter_8_4, iter_8_5 in var_1_10008(iter_8_3.unlockTaskIds) do
			table = var_1_10013

			if var_1_10013.contains(iter_8_5, arg_8_1) then
				iter_8_3:AddFinishedTaskId(arg_8_1)

				var_8_0 = true

				break
			end
		end
	end

	if var_8_0 then
		ipairs = var_3

		for iter_8_6, iter_8_7 in var_3(arg_8_0.commanderManualPages) do
			iter_8_7:ChangeUnlock(arg_8_0.topFinishedTaskIds)
			iter_8_7:GetTasks()
		end
	end

	return
end

function var_0_1.GetPagesTasks(arg_9_0)
	ipairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.commanderManualPages) do
		iter_9_1:GetTasks()
	end

	return
end

function var_0_1.ShowTaskSubmitCall(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.commanderManualPages) do
		table = var_1_10007

		if var_1_10007.contains(iter_10_1.taskIdList, arg_10_1) and not iter_10_1:IsTaskComplete(arg_10_1) then
			iter_10_1:AddFinishedTaskId(arg_10_1)
			iter_10_1:AddPt()

			break
		end
	end

	return
end

function var_0_1.AddPageTaskDone(arg_11_0, arg_11_1)
	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.commanderManualPages) do
		local var_11_0 = 0

		ipairs = var_1_10008

		for iter_11_2, iter_11_3 in var_1_10008(iter_11_1.taskIds) do
			table = var_1_10013

			if var_1_10013.contains(iter_11_3, arg_11_1.id) then
				var_11_0 = iter_11_2

				break
			end
		end

		if var_11_0 ~= 0 then
			local var_11_1 = arg_11_0

			var_1_10008 = arg_11_0.sendNotification
			GAME = var_10

			var_1_10008(var_11_1, var_10.COMMANDER_MANUAL_OP_DONE, {
				operation = var_0_1.GET_TASK,
				pageId = iter_11_1.id,
				index = var_11_0
			})

			break
		end
	end

	return
end

function var_0_1.IsTopUnlock(arg_12_0, arg_12_1)
	pg = var_1_10002

	local var_12_0 = var_1_10002.tutorial_handbook[arg_12_1].unlock_param

	ipairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(var_12_0) do
		table = var_1_10008

		if not var_1_10008.contains(arg_12_0.topFinishedTaskIds, iter_12_1) then
			return false
		end
	end

	return true
end

function var_0_1.GetLockTip(arg_13_0, arg_13_1)
	pg = var_1_10002

	return var_1_10002.tutorial_handbook[arg_13_1].lock_hint
end

function var_0_1.ShouldShowTipByType(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.GetPagesByType(var_14_0, arg_14_1)

	ipairs = var_14_0

	for iter_14_0, iter_14_1 in var_14_0(var_14_1) do
		if iter_14_1:ShouldShowTip() then
			return true
		end
	end

	return false
end

function var_0_1.ShouldShowTaskOrGuideTip(arg_15_0)
	local var_15_0

	if not arg_15_0:ShouldShowTipByType(1) then
		var_15_0 = arg_15_0:ShouldShowTipByType(2)
	end

	return var_15_0
end

function var_0_1.IsTopPageComplete(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.GetPagesByType(var_16_0, arg_16_1)

	ipairs = var_16_0

	for iter_16_0, iter_16_1 in var_16_0(var_16_1) do
		if not iter_16_1:IsComplete() then
			return false
		end
	end

	return true
end

function var_0_1.TaskProgressAdd(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}

	ipairs = var_1_10004
	pg = var_1_10005

	for iter_17_0, iter_17_1 in var_1_10004(var_1_10005.task_data_template.all) do
		pg = var_1_10009
		var_1_10010 = var_1_10009.task_data_template[iter_17_1].type
		Task = var_1_10011

		if var_1_10010 == var_1_10011.TYPE_COMMANDER_MANUAL and var_1_10009.sub_type == arg_17_1 then
			table = var_1_10010

			var_1_10010.insert(var_17_0, iter_17_1)
		end
	end

	ipairs = var_4

	for iter_17_2, iter_17_3 in var_4(var_17_0) do
		getProxy = var_1_10009
		TaskProxy = var_1_10010
		var_1_10010 = var_1_10009(var_1_10010)

		if var_1_10009.getTaskById(var_1_10010, iter_17_3) and var_1_10009:getTaskStatus() == 0 then
			local var_17_1 = arg_17_0

			var_1_10010 = arg_17_0.sendNotification
			GAME = var_1_10012

			var_1_10010(var_17_1, var_1_10012.MINI_GAME_TASK_PROGRESS_UPDATE, {
				taskId = iter_17_3,
				progressAdd = arg_17_2
			})
		end
	end

	return
end

return var_0_1
