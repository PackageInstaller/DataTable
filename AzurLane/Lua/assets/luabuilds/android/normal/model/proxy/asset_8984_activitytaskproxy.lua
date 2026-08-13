class = var_0_10000

local var_0_0 = "ActivityTaskProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.actTasks = {}
	arg_1_0.autoSubmitTasks = {}

	return
end

function var_0_1.clearData(arg_2_0)
	arg_2_0.actTasks = {}
	arg_2_0.autoSubmitTasks = {}

	return
end

function var_0_1.initActList(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_2 then
		return {}
	end

	local var_3_0 = {}
	local var_3_1 = {}

	ipairs = var_1_10006

	for iter_3_0, iter_3_1 in var_1_10006(arg_3_2) do
		local var_3_2 = arg_3_0
		local var_3_3 = arg_3_0.createTask(var_3_2, arg_3_1, iter_3_1)

		table = var_3_2

		var_3_2.insert(var_3_0, var_3_3)
	end

	if arg_3_3 and #arg_3_3 > 0 then
		ipairs = var_6

		for iter_3_2, iter_3_3 in var_6(arg_3_3) do
			local var_3_4 = arg_3_0
			local var_3_5 = arg_3_0.createTask(var_3_4, arg_3_1, {
				id = iter_3_3
			})

			table = var_3_4

			var_3_4.insert(var_3_1, var_3_5)
		end
	end

	table = var_6

	var_6.insert(arg_3_0.actTasks, {
		actId = arg_3_1,
		tasks = var_3_0,
		finish_tasks = var_3_1
	})
	arg_3_0:checkAutoSubmit()

	return
end

function var_0_1.finishActTask(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	local var_4_0 = var_1_10003.task_data_template[arg_4_2].type

	table = var_1_10005

	local var_4_1 = var_1_10005.contains

	TotalTaskProxy = var_1_10006

	if not var_4_1(var_1_10006.act_task_onece_type, var_4_0) then
		return
	end

	for iter_4_0 = 1, #arg_4_0.actTasks do
		if arg_4_0.actTasks[iter_4_0].actId == arg_4_1 then
			local var_4_2 = true

			ipairs = var_1_10010

			for iter_4_1, iter_4_2 in var_1_10010(arg_4_0.actTasks[iter_4_0].finish_tasks) do
				if iter_4_2.id == arg_4_2 then
					var_4_2 = false

					break
				end
			end

			if var_4_2 then
				table = var_1_10010

				var_1_10010.insert(arg_4_0.actTasks[iter_4_0].finish_tasks, arg_4_0:createTask(arg_4_1, {
					id = arg_4_2
				}))
			end
		end
	end

	return
end

function var_0_1.updateActList(arg_5_0, arg_5_1, arg_5_2)
	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_2) do
		for iter_5_2 = 1, #arg_5_0.actTasks do
			if arg_5_0.actTasks[iter_5_2].actId == arg_5_1 then
				ipairs = var_12

				for iter_5_3, iter_5_4 in var_12(arg_5_0.actTasks[iter_5_2].tasks) do
					if iter_5_4.id == iter_5_1.id then
						iter_5_4:updateProgress(iter_5_1.progress)
					end
				end
			end
		end
	end

	arg_5_0:checkAutoSubmit()

	return
end

function var_0_1.updateProgressBySubType(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	for iter_6_0 = 1, #arg_6_0.actTasks do
		if arg_6_0.actTasks[iter_6_0].actId == arg_6_1 then
			ipairs = var_8

			for iter_6_1, iter_6_2 in var_8(arg_6_0.actTasks[iter_6_0].tasks) do
				if iter_6_2:getConfig("sub_type") == arg_6_2 then
					iter_6_2:updateProgress(arg_6_3)
				end
			end
		end
	end

	arg_6_0:checkAutoSubmit()

	return
end

function var_0_1.addActList(arg_7_0, arg_7_1, arg_7_2)
	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_2) do
		for iter_7_2 = 1, #arg_7_0.actTasks do
			if arg_7_0.actTasks[iter_7_2].actId == arg_7_1 then
				for iter_7_3 = #arg_7_0.actTasks[iter_7_2].tasks, 1, -1 do
					if var_12[iter_7_3].id == iter_7_1.id then
						table = var_17

						var_17.remove(var_12, iter_7_3)
					end
				end

				local var_7_0 = arg_7_0
				local var_7_1 = arg_7_0.createTask(var_7_0, arg_7_1, iter_7_1)

				table = var_7_0

				var_7_0.insert(var_12, var_7_1)
			end
		end
	end

	arg_7_0:checkAutoSubmit()

	return
end

function var_0_1.checkAutoSubmit(arg_8_0)
	if not arg_8_0.actTasks or #arg_8_0.actTasks == 0 then
		return
	end

	for iter_8_0 = 1, #arg_8_0.actTasks do
		local var_8_0 = arg_8_0.actTasks[iter_8_0].actId
		local var_8_1 = arg_8_0.actTasks[iter_8_0].tasks
		local var_8_2 = {}

		ipairs = var_1_10008

		for iter_8_1, iter_8_2 in var_1_10008(var_8_1) do
			if iter_8_2.autoCommit and iter_8_2:isFinish() then
				table = var_13

				if not var_13.contains(arg_8_0.autoSubmitTasks, iter_8_2.id) then
					table = var_13

					var_13.insert(var_8_2, iter_8_2.id)

					table = var_13

					var_13.insert(arg_8_0.autoSubmitTasks, iter_8_2.id)
				else
					warning = var_13

					var_13("task_id" .. iter_8_2.id .. "已经存在于提交列表中，无需重复提交")
				end
			end
		end

		if #var_8_2 > 0 then
			local var_8_3 = arg_8_0

			var_1_10008 = arg_8_0.sendNotification
			GAME = var_10

			var_1_10008(var_8_3, var_10.SUBMIT_ACTIVITY_TASK, {
				act_id = var_8_0,
				task_ids = var_8_2
			})
		end
	end

	return
end

function var_0_1.removeActList(arg_9_0, arg_9_1, arg_9_2)
	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_2) do
		for iter_9_2 = 1, #arg_9_0.actTasks do
			if arg_9_0.actTasks[iter_9_2].actId == arg_9_1 then
				for iter_9_3 = #arg_9_0.actTasks[iter_9_2].tasks, 1, -1 do
					if var_12[iter_9_3].id == iter_9_1.id then
						local var_9_0 = var_12[iter_9_3]

						if var_17.isCircle(var_9_0) then
							local var_9_1 = var_12[iter_9_3]

							var_17.updateProgress(var_9_1, 0)
						else
							table = var_17

							local var_9_2 = var_17.remove(var_12, iter_9_3)

							arg_9_0:finishActTask(arg_9_1, var_9_2.id)
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.getTaskById(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.actTasks) do
		if iter_10_1.actId == arg_10_1 then
			Clone = var_7

			return var_7(iter_10_1.tasks)
		end
	end

	return {}
end

function var_0_1.getFinishTaskById(arg_11_0, arg_11_1)
	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.actTasks) do
		if iter_11_1.actId == arg_11_1 then
			Clone = var_7

			local var_11_0 = var_7(iter_11_1.finish_tasks)

			_ = var_8

			var_8.each(var_11_0, function(arg_12_0)
				arg_12_0:setOver()

				return
			end)

			return var_11_0
		end
	end

	return {}
end

function var_0_1.getFinishTasksByActId(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_13_0 = var_1_10002(var_1_10003)

	if not var_2.getActivityById(var_13_0, arg_13_1) then
		return {}
	end

	local var_13_1 = var_2
	local var_13_2 = var_2.GetFinishedTaskIds(var_13_1)

	_ = var_13_1

	return var_13_1.map(var_13_2, function(arg_14_0)
		ActivityTask = var_2_10001

		local var_14_0 = var_2_10001.New(arg_13_1, {
			id = arg_14_0
		})

		var_1.setOver(var_14_0)

		return var_1
	end)
end

function var_0_1.checkTasksFinish(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	ipairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(arg_15_0:getFinishTasksByActId(arg_15_1)) do
		var_15_0[iter_15_1.id] = true
	end

	underscore = var_4

	return var_4.all(arg_15_2, function(arg_16_0)
		return var_15_0[arg_16_0.id]
	end)
end

function var_0_1.getTaskVOsByActId(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.getTaskById(var_17_0, arg_17_1)

	table = var_17_0

	var_17_0.insertto(var_17_1, arg_17_0:getFinishTasksByActId(arg_17_1))

	return var_17_1
end

function var_0_1.getActTaskTip(arg_18_0, arg_18_1)
	local var_18_0 = {}

	ipairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(arg_18_0.actTasks) do
		if iter_18_1.actId == arg_18_1 then
			var_18_0 = iter_18_1.tasks
		end
	end

	local var_18_1 = 0

	ipairs = var_4

	for iter_18_2, iter_18_3 in var_4(var_18_0) do
		if not iter_18_3:isCircle() and not iter_18_3:isOver() and iter_18_3:isFinish() and not iter_18_3.autoCommit then
			var_18_1 = var_18_1 + 1
		end
	end

	return var_18_1 > 0
end

function var_0_1.getTaskVo(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getTaskById(arg_19_1)

	for iter_19_0 = 1, #var_19_0 do
		if var_19_0[iter_19_0].id == arg_19_2 then
			Clone = var_8

			return var_8(var_19_0[iter_19_0])
		end
	end

	return nil
end

function var_0_1.createTask(arg_20_0, arg_20_1, arg_20_2)
	ActivityTask = var_1_10003

	return (var_1_10003.New(arg_20_1, arg_20_2))
end

function var_0_1.getFinishTasks(arg_21_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_21_0 = var_1_10001(var_1_10002)
	local var_21_1 = var_1.GetTaskActivities(var_21_0)
	local var_21_2 = {}

	_ = var_1_10003

	local var_21_3 = var_1_10003.each

	_ = var_1_10004

	var_21_3(var_1_10004.map(var_21_1, function(arg_22_0)
		local var_22_0 = arg_21_0

		return var_1.getFinishTasksByActId(var_22_0, arg_22_0.id)
	end), function(arg_23_0)
		table = var_2_10001

		var_2_10001.insertto(var_21_2, arg_23_0)

		return
	end)

	return var_21_2
end

function var_0_1.GetActivityTasks(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getTaskById(arg_24_1)
	local var_24_1 = arg_24_0:getFinishTaskById(arg_24_1)
	local var_24_2 = {}

	_ = var_5

	var_5.each(var_24_0, function(arg_25_0)
		var_24_2[arg_25_0.id] = arg_25_0

		return
	end)

	_ = var_5

	var_5.each(var_24_1, function(arg_26_0)
		var_24_2[arg_26_0.id] = arg_26_0

		return
	end)

	return var_24_2
end

return var_0_1
