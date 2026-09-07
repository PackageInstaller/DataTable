local AnniversaryMediator = class("AnniversaryMediator", import("..base.ContextMediator"))

AnniversaryMediator.ON_SUBMIT_TASK = "AnniversaryMediator:ON_SUBMIT_TASK"
AnniversaryMediator.TO_TASK = "AnniversaryMediator:TO_TASK"

function AnniversaryMediator:register()
	self:bind(AnniversaryMediator.TO_TASK, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(AnniversaryMediator.ON_SUBMIT_TASK, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ANNIVERSARY_TASK_LIST_ID)

	self.viewComponent:setActivity(var_1_0)
	self:acceptTask(var_1_0)
	self.viewComponent:setTaskList((self:getTaskByIds()))

	return
end

function AnniversaryMediator:acceptTask(arg_4_1)
	local var_4_0 = getProxy(TaskProxy)
	local var_4_1 = arg_4_1:getConfig("config_data")
	local var_4_2 = pg.TimeMgr.GetInstance()

	if arg_4_1.data3 == 0 or arg_4_1.data3 < math.clamp(var_4_2:DiffDay(arg_4_1.data1, var_4_2:GetServerTime()) + 1, 1, #var_4_1) and _.all(_.flatten({
		var_4_1[arg_4_1.data3]
	}), function(arg_5_0)
		return var_4_0:getFinishTaskById(arg_5_0) ~= nil
	end) then
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_4_1.id
		})
	end

	return
end

function AnniversaryMediator:getTaskByIds()
	local var_6_0 = {}
	local var_6_1 = getProxy(TaskProxy)

	for iter_6_0, iter_6_1 in pairs((var_6_1:getData())) do
		var_6_0[iter_6_1.id] = iter_6_1
	end

	for iter_6_2, iter_6_3 in pairs(var_6_1.finishData) do
		var_6_0[iter_6_3.id] = iter_6_3
	end

	return var_6_0
end

function AnniversaryMediator:listNotificationInterests()
	return {
		TaskProxy.TASK_ADDED,
		TaskProxy.TASK_UPDATED,
		TaskProxy.TASK_REMOVED,
		TaskProxy.TASK_DELETE,
		GAME.SUBMIT_TASK_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function AnniversaryMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == TaskProxy.TASK_ADDED or var_8_0 == TaskProxy.TASK_UPDATED or var_8_0 == TaskProxy.TASK_REMOVED or var_8_0 == TaskProxy.TASK_DELETE then
		self.viewComponent:setTaskList((self:getTaskByIds()))
	elseif var_8_0 == GAME.SUBMIT_TASK_DONE then
		local var_8_2 = getProxy(ActivityProxy):getActivityById(ActivityConst.ANNIVERSARY_TASK_LIST_ID)

		if self.viewComponent.dateIndex and self.viewComponent.dateIndex == var_8_2.data3 then
			self.viewComponent:updateTaskGroupDesc(var_8_2.data3)
		end

		self.viewComponent:updateBottomTaskGroup(var_8_2.data3)
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1)
		self:acceptTask(var_8_2)
	elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED and var_8_1.id == ActivityConst.ANNIVERSARY_TASK_LIST_ID then
		self.viewComponent:setActivity(var_8_1)
		self.viewComponent:updateTaskGroups()
		self.viewComponent:moveToTaskGroup(self.viewComponent.date, nil, true)
	end

	return
end

return AnniversaryMediator
