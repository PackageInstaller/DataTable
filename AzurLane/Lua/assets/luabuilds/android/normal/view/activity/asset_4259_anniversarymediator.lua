class = var_0_10000

local var_0_0 = "AnniversaryMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_SUBMIT_TASK = "AnniversaryMediator:ON_SUBMIT_TASK"
var_0_1.TO_TASK = "AnniversaryMediator:TO_TASK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.TO_TASK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_SUBMIT_TASK, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.SUBMIT_TASK, arg_3_1)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityById

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.ANNIVERSARY_TASK_LIST_ID)
	local var_1_4 = arg_1_0.viewComponent

	var_3.setActivity(var_1_4, var_1_3)
	arg_1_0:acceptTask(var_1_3)

	local var_1_5 = arg_1_0:getTaskByIds()
	local var_1_6 = arg_1_0.viewComponent

	var_4.setTaskList(var_1_6, var_1_5)

	return
end

function var_0_1.acceptTask(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getConfig(var_4_1, "config_data")

	pg = var_4_1

	local var_4_3 = var_4_1.TimeMgr.GetInstance()
	local var_4_4 = var_4.DiffDay(var_4_3, arg_4_1.data1, var_4:GetServerTime()) + 1

	math = var_4_3

	local var_4_5 = var_4_3.clamp(var_4_4, 1, #var_4_2)

	if arg_4_1.data3 ~= 0 then
		if var_6 < var_4_5 then
			_ = var_7

			local var_4_6 = var_7.all

			_ = var_8

			if var_4_6(var_8.flatten({
				var_4_2[var_6]
			}), function(arg_5_0)
				local var_5_0 = var_4_0

				return var_1.getFinishTaskById(var_5_0, arg_5_0) ~= nil
			end) then
				local var_4_7 = arg_4_0
				local var_4_8 = arg_4_0.sendNotification

				GAME = var_9

				var_4_8(var_4_7, var_9.ACTIVITY_OPERATION, {
					cmd = 1,
					activity_id = arg_4_1.id
				})
			end
		end

		return
	end
end

function var_0_1.getTaskByIds(arg_6_0)
	local var_6_0 = {}

	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_6_1 = var_1_10002(var_1_10003)
	local var_6_2 = var_2.getData(var_6_1)

	pairs = var_6_1

	for iter_6_0, iter_6_1 in var_6_1(var_6_2) do
		var_6_0[iter_6_1.id] = iter_6_1
	end

	local var_6_3 = var_2.finishData

	pairs = var_5

	for iter_6_2, iter_6_3 in var_5(var_6_3) do
		var_6_0[iter_6_3.id] = iter_6_3
	end

	return var_6_0
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	TaskProxy = var_1_10002
	var_7_0[1] = var_1_10002.TASK_ADDED
	TaskProxy = var_2
	var_7_0[2] = var_2.TASK_UPDATED
	TaskProxy = var_2
	var_7_0[3] = var_2.TASK_REMOVED
	TaskProxy = var_2
	var_7_0[4] = var_2.TASK_DELETE
	GAME = var_2
	var_7_0[5] = var_2.SUBMIT_TASK_DONE
	ActivityProxy = var_2
	var_7_0[6] = var_2.ACTIVITY_UPDATED

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	TaskProxy = var_8_1

	if var_8_0 ~= var_8_1.TASK_ADDED then
		TaskProxy = var_8_3

		if var_8_0 ~= var_8_3.TASK_UPDATED then
			TaskProxy = var_8_3

			if var_8_0 ~= var_8_3.TASK_REMOVED then
				TaskProxy = var_8_3

				local var_8_3

				if var_8_0 == var_8_3.TASK_DELETE then
					var_1_10005 = arg_8_0
					var_8_3 = arg_8_0.getTaskByIds(var_1_10005)

					local var_8_4 = arg_8_0.viewComponent

					var_1_10005.setTaskList(var_8_4, var_8_3)
				else
					GAME = var_8_3

					if var_8_0 == var_8_3.SUBMIT_TASK_DONE then
						getProxy = var_4
						ActivityProxy = var_1_10005

						local var_8_5 = var_4(var_1_10005)

						var_1_10005 = var_4.getActivityById
						ActivityConst = var_1_10007
						var_1_10005 = var_1_10005(var_8_5, var_1_10007.ANNIVERSARY_TASK_LIST_ID)

						if arg_8_0.viewComponent.dateIndex and arg_8_0.viewComponent.dateIndex == var_1_10005.data3 then
							local var_8_6 = arg_8_0.viewComponent

							var_6.updateTaskGroupDesc(var_8_6, var_1_10005.data3)
						end

						local var_8_7 = arg_8_0.viewComponent

						var_6.updateBottomTaskGroup(var_8_7, var_1_10005.data3)

						local var_8_8 = arg_8_0.viewComponent
						local var_8_9 = var_6.emit

						BaseUI = var_8

						var_8_9(var_8_8, var_8.ON_ACHIEVE, var_8_2)
						arg_8_0:acceptTask(var_1_10005)
					else
						ActivityProxy = var_4

						if var_8_0 == var_4.ACTIVITY_UPDATED then
							local var_8_10 = var_8_2.id

							ActivityConst = var_1_10005

							if var_8_10 == var_1_10005.ANNIVERSARY_TASK_LIST_ID then
								local var_8_11 = arg_8_0.viewComponent

								var_4.setActivity(var_8_11, var_8_2)

								local var_8_12 = arg_8_0.viewComponent

								var_4.updateTaskGroups(var_8_12)

								local var_8_13 = arg_8_0.viewComponent

								var_4.moveToTaskGroup(var_8_13, arg_8_0.viewComponent.date, nil, true)
							end
						end
					end
				end

				return
			end
		end
	end
end

return var_0_1
