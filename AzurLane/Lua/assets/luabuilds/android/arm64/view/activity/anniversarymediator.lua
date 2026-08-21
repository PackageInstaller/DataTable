local var_0_0 = class("AnniversaryMediator", import("..base.ContextMediator"))

var_0_0.ON_SUBMIT_TASK = "AnniversaryMediator:ON_SUBMIT_TASK"
var_0_0.TO_TASK = "AnniversaryMediator:TO_TASK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.TO_TASK, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SUBMIT_TASK, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_3_1)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ANNIVERSARY_TASK_LIST_ID)

	arg_1_0.viewComponent:setActivity(var_1_0)
	arg_1_0:acceptTask(var_1_0)
	arg_1_0.viewComponent:setTaskList((arg_1_0:getTaskByIds()))

	return
end

function var_0_0.acceptTask(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(TaskProxy)
	local var_4_1 = arg_4_1:getConfig("config_data")
	local var_4_2 = pg.TimeMgr.GetInstance()

	if arg_4_1.data3 == 0 or arg_4_1.data3 < math.clamp(var_4_2:DiffDay(arg_4_1.data1, var_4_2:GetServerTime()) + 1, 1, #var_4_1) and _.all(_.flatten({
		var_4_1[arg_4_1.data3]
	}), function(arg_5_0)
		return var_4_0:getFinishTaskById(arg_5_0) ~= nil
	end) then
		arg_4_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_4_1.id
		})
	end

	return
end

function var_0_0.getTaskByIds(arg_6_0)
	local var_6_0 = getProxy(TaskProxy)

	for iter_6_0, iter_6_1 in pairs((var_6_0:getData())) do
		({})[iter_6_1.id] = iter_6_1
	end

	for iter_6_2, iter_6_3 in pairs(var_6_0.finishData) do
		({})[iter_6_3.id] = iter_6_3
	end

	return {}
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		TaskProxy.TASK_ADDED,
		TaskProxy.TASK_UPDATED,
		TaskProxy.TASK_REMOVED,
		TaskProxy.TASK_DELETE,
		GAME.SUBMIT_TASK_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 ~= TaskProxy.TASK_ADDED and var_8_0 ~= TaskProxy.TASK_UPDATED and var_8_0 ~= TaskProxy.TASK_REMOVED then
		if var_8_0 == TaskProxy.TASK_DELETE then
			arg_8_0.viewComponent:setTaskList((arg_8_0:getTaskByIds()))
		elseif var_8_0 == GAME.SUBMIT_TASK_DONE then
			local var_8_2 = getProxy(ActivityProxy):getActivityById(ActivityConst.ANNIVERSARY_TASK_LIST_ID)

			if arg_8_0.viewComponent.dateIndex and arg_8_0.viewComponent.dateIndex == var_8_2.data3 then
				arg_8_0.viewComponent:updateTaskGroupDesc(var_8_2.data3)
			end

			arg_8_0.viewComponent:updateBottomTaskGroup(var_8_2.data3)
			arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1)
			arg_8_0:acceptTask(var_8_2)
		elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED and var_8_1.id == ActivityConst.ANNIVERSARY_TASK_LIST_ID then
			arg_8_0.viewComponent:setActivity(var_8_1)
			arg_8_0.viewComponent:updateTaskGroups()
			arg_8_0.viewComponent:moveToTaskGroup(arg_8_0.viewComponent.date, nil, true)
		end

		return
	end
end

return var_0_0
