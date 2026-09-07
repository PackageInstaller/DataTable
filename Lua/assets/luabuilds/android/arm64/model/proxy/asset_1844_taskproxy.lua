local TaskProxy = class("TaskProxy", import(".NetProxy"))

TaskProxy.TASK_ADDED = "task added"
TaskProxy.TASK_UPDATED = "task updated"
TaskProxy.TASK_REMOVED = "task removed"
TaskProxy.TASK_DELETE = "task deleted"
TaskProxy.TASK_PROGRESS_UPDATE = "task TASK_PROGRESS_UPDATE"
TaskProxy.WEEK_TASK_UPDATED = "week task updated"
TaskProxy.WEEK_TASKS_ADDED = "week tasks added"
TaskProxy.WEEK_TASKS_DELETED = "week task deleted"
TaskProxy.WEEK_TASK_RESET = "week task refresh"
mingshiTriggerId = 1
mingshiActivityId = 21
changdaoActivityId = 10006
changdaoTaskStartId = 5031

function TaskProxy:register()
	self.data = {}
	self.finishData = {}
	self.tmpInfo = {}

	self:on(20001, function(arg_2_0)
		self:initTaskInfo(arg_2_0.info)
		getProxy(TechnologyProxy):updateBlueprintStates()

		return
	end)
	self:on(20002, function(arg_3_0)
		self:updateProgress(arg_3_0.info)

		return
	end)
	self:on(20003, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.info) do
			self:addTask((Task.New(iter_4_1)))
		end

		return
	end)
	self:on(20004, function(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.id_list) do
			self:deleteTaskById(iter_5_1)
		end

		return
	end)
	self:on(20015, function(arg_6_0)
		pg.proxyRegister.dayProto = true

		return
	end)

	self.taskTriggers = {}
	self.weekTaskProgressInfo = WeekTaskProgress.New()

	self:on(20101, function(arg_7_0)
		self.weekTaskProgressInfo:Init(arg_7_0.info)
		self:sendNotification(TaskProxy.WEEK_TASK_RESET)

		return
	end)
	self:on(20102, function(arg_8_0)
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.task) do
			print("update sub task ", iter_8_1)

			local var_8_0 = WeekPtTask.New(iter_8_1)

			self.weekTaskProgressInfo:UpdateSubTask(var_8_0)
			self:sendNotification(TaskProxy.WEEK_TASK_UPDATED, {
				id = var_8_0.id
			})
		end

		return
	end)
	self:on(20103, function(arg_9_0)
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.id) do
			self.weekTaskProgressInfo:AddSubTask((WeekPtTask.New({
				progress = 0,
				id = iter_9_1
			})))
		end

		self:sendNotification(TaskProxy.WEEK_TASKS_ADDED)

		return
	end)
	self:on(20104, function(arg_10_0)
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.id) do
			print("remove sub task ", iter_10_1)
			self.weekTaskProgressInfo:RemoveSubTask(iter_10_1)
		end

		self:sendNotification(TaskProxy.WEEK_TASKS_DELETED)

		return
	end)
	self:on(20105, function(arg_11_0)
		self.weekTaskProgressInfo:UpdateProgress(arg_11_0.pt)

		return
	end)

	self.submittingTask = {}

	return
end

function TaskProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_13_0)
			self:sendNotification(GAME.ACCEPT_ACTIVITY_TASK)
			self:sendNotification(GAME.ZERO_HOUR_OP_DONE)

			return
		end
	}
end

function TaskProxy:initTaskInfo(arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_0 = Task.New(iter_14_1)

		if var_14_0:getConfigTable() ~= nil then
			var_14_0:display("loaded")

			if var_14_0:getTaskStatus() ~= 2 then
				self.data[var_14_0.id] = var_14_0
			else
				self.finishData[var_14_0.id] = var_14_0
			end

			var_14_0:setActId(arg_14_2)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("task_notfound_error") .. tostring(iter_14_1.id))
			Debugger.LogWarning("Missing Task Config, id :" .. tostring(iter_14_1.id))
		end
	end

	if arg_14_3 and #arg_14_3 > 0 then
		for iter_14_2, iter_14_3 in ipairs(arg_14_3) do
			local var_14_1 = Task.New({
				id = iter_14_3
			})

			if var_14_1:getConfigTable() ~= nil then
				var_14_1:display("loaded")

				self.finishData[var_14_1.id] = var_14_1

				var_14_1:setActId(arg_14_2)
				var_14_1:setTaskFinish()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("task_notfound_error") .. tostring(iter_14_3.id))
				Debugger.LogWarning("Missing Task Config, id :" .. tostring(iter_14_3.id))
			end
		end
	end

	return
end

function TaskProxy:updateProgress(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if self.data[iter_15_1.id] ~= nil then
			local var_15_0 = self.data[iter_15_1.id]:isFinish()

			self.data[iter_15_1.id].progress = iter_15_1.progress

			self:updateTask(self.data[iter_15_1.id])

			if not var_15_0 then
				self:sendNotification(TaskProxy.TASK_PROGRESS_UPDATE, self.data[iter_15_1.id]:clone())
			end
		end
	end

	return
end

function TaskProxy:initActData(arg_16_1, arg_16_2, arg_16_3)
	self:initTaskInfo(arg_16_2, arg_16_1, arg_16_3)

	return
end

function TaskProxy:updateActProgress(arg_17_1, arg_17_2)
	self:updateProgress(arg_17_2)

	return
end

function TaskProxy:addActData(arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		local var_18_0 = Task.New(iter_18_1)

		var_18_0:setActId(arg_18_1)
		self:addTask(var_18_0)
	end

	return
end

function TaskProxy:removeActData(arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(arg_19_2) do
		self:deleteTaskById(iter_19_1.id)
	end

	return
end

function TaskProxy:clearTimeOut()
	if not self.datas or #self.datas == 0 then
		return
	end

	local var_20_1 = {}

	for iter_20_0 = #self.datas, 1, -1 do
		if self.datas[iter_20_0]:isActivityTask() then
			local var_20_2 = getProxy(ActivityProxy):getActivityById((self.datas[iter_20_0]:getActId()))

			if not var_20_2 or var_20_2:isEnd() then
				table.insert(var_20_1, self.datas[iter_20_0])
			end
		end
	end

	for iter_20_1 = 1, #var_20_1 do
		self:deleteTask(var_20_1[iter_20_1])
	end

	return
end

function TaskProxy:GetWeekTaskProgressInfo()
	return self.weekTaskProgressInfo
end

function TaskProxy:getTasksForBluePrint()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(self.data or {}) do
		var_22_0[iter_22_1.id] = iter_22_1
	end

	for iter_22_2, iter_22_3 in pairs(self.finishData) do
		var_22_0[iter_22_3.id] = iter_22_3
	end

	return var_22_0
end

function TaskProxy:addTmpTask(arg_23_1)
	self.tmpInfo[arg_23_1.id] = arg_23_1

	return
end

function TaskProxy:checkTmpTask(arg_24_1)
	if self.tmpInfo[arg_24_1] then
		self:addTask(self.tmpInfo[arg_24_1])

		self.tmpInfo[arg_24_1] = nil
	end

	return
end

function TaskProxy:addTask(arg_25_1)
	assert(isa(arg_25_1, Task), "should be an instance of Task")

	if self.data[arg_25_1.id] then
		self:addTmpTask(arg_25_1)

		return
	end

	if arg_25_1:getConfigTable() == nil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("task_notfound_error") .. tostring(arg_25_1.id))
		Debugger.LogWarning("Missing Task Config, id :" .. tostring(arg_25_1.id))

		return
	end

	self.data[arg_25_1.id] = arg_25_1:clone()

	self.data[arg_25_1.id]:display("added")
	self.data[arg_25_1.id]:onAdded()
	self.facade:sendNotification(TaskProxy.TASK_ADDED, arg_25_1:clone())
	self:checkAutoSubmitTask(self.data[arg_25_1.id])

	return
end

function TaskProxy:updateTask(arg_26_1)
	assert(isa(arg_26_1, Task), "should be an instance of Task")

	local var_26_0 = self.data[arg_26_1.id]

	assert(self.data[arg_26_1.id] ~= nil, "task should exist")

	self.data[arg_26_1.id] = arg_26_1:clone()
	self.data[arg_26_1.id].acceptTime = var_26_0.acceptTime

	self.data[arg_26_1.id]:display("updated")
	self.facade:sendNotification(TaskProxy.TASK_UPDATED, arg_26_1:clone())
	self:checkAutoSubmitTask(self.data[arg_26_1.id])

	return
end

function TaskProxy:getTasks()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(self.data) do
		table.insert(var_27_0, iter_27_1)
	end

	return Clone(var_27_0)
end

function TaskProxy:getTaskById(arg_28_1)
	if self.data[arg_28_1] then
		return self.data[arg_28_1]:clone()
	end

	return
end

function TaskProxy:getFinishTaskById(arg_29_1)
	if self.finishData[arg_29_1] then
		return self.finishData[arg_29_1]:clone()
	end

	return
end

function TaskProxy:removeFinishTaskById(arg_30_1)
	if self.finishData[arg_30_1] then
		self.finishData[arg_30_1] = nil
	end

	return
end

function TaskProxy:getTaskVO(arg_31_1)
	return self:getTaskById(arg_31_1) or self:getFinishTaskById(arg_31_1)
end

function TaskProxy:getCanReceiveCount()
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs(self.data) do
		if iter_32_1:ShowOnTaskScene() and iter_32_1:isFinish() and iter_32_1:isReceive() == false then
			var_32_0 = var_32_0 + 1

			for iter_32_2, iter_32_3 in ipairs((iter_32_1:getConfig("award_display"))) do
				local var_32_1, var_32_2, var_32_3 = unpack(iter_32_3)

				if not LOCK_UR_SHIP and var_32_1 == DROP_TYPE_VITEM and Item.getConfigData(var_32_2).virtual_type == 20 then
					if not LOCK_UR_SHIP then
						if not LOCK_UR_SHIP then
							if (getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]) or 0) + var_32_3 - (pg.gameset.urpt_chapter_max.description[2] or 0) > 0 then
								var_32_0 = var_32_0 - 1
							end
						end
					end
				end
			end
		end
	end

	local var_32_6 = self:GetWeekTaskProgressInfo()

	if var_32_6:CanUpgrade() then
		var_32_0 = var_32_0 + 1
	end

	return var_32_0 + var_32_6:GetCanSubmitSubTaskCnt()
end

function TaskProxy:getNotFinishCount(arg_33_1)
	local var_33_0 = arg_33_1 or 3
	local var_33_1 = 0

	for iter_33_0, iter_33_1 in pairs(self.data) do
		if iter_33_1:GetRealType() == var_33_0 and iter_33_1:isFinish() == false then
			var_33_1 = var_33_1 + 1
		end
	end

	return var_33_1
end

function TaskProxy:removeTask(arg_34_1)
	assert(isa(arg_34_1, Task), "should be an instance of Task")
	self:removeTaskById(arg_34_1.id)

	return
end

function TaskProxy:removeTaskById(arg_35_1)
	if self.data[arg_35_1] == nil then
		return
	end

	if self.data[arg_35_1]:isCircle() then
		return
	end

	self.finishData[arg_35_1] = self.data[arg_35_1]:clone()
	self.finishData[arg_35_1].submitTime = pg.TimeMgr.GetInstance():GetServerTime()
	self.data[arg_35_1] = nil

	self:sendNotification(TaskProxy.TASK_REMOVED, self.data[arg_35_1])
	self:checkTmpTask(arg_35_1)

	return
end

function TaskProxy:deleteTask(arg_36_1)
	assert(isa(arg_36_1, Task), "should be an instance of Task")
	self:deleteTaskById(arg_36_1.id)

	return
end

function TaskProxy:deleteTaskById(arg_37_1)
	if self.submittingTask[arg_37_1] then
		print("正在提交的任务不予删除，id:" .. arg_37_1)

		return
	end

	local var_37_0 = self.data[arg_37_1] or self.finishData[arg_37_1]

	self.data[arg_37_1] = nil
	self.finishData[arg_37_1] = nil

	if tobool(var_37_0) then
		self:sendNotification(TaskProxy.TASK_DELETE, var_37_0)
	end

	return
end

function TaskProxy:getmingshiTaskID(arg_38_1)
	if arg_38_1 >= pg.task_data_trigger[mingshiTriggerId].count then
		if pg.task_data_trigger[mingshiTriggerId].task_id and not self:getTaskVO(pg.task_data_trigger[mingshiTriggerId].task_id) then
			return pg.task_data_trigger[mingshiTriggerId].task_id
		end
	end

	return 0
end

function TaskProxy:dealMingshiTouchFlag(arg_39_1)
	local var_39_0 = getProxy(ActivityProxy):getActivityById(mingshiActivityId)

	if not var_39_0 or var_39_0:isEnd() then
		return
	end

	local var_39_1 = var_39_0:getConfig("config_id")

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		hideNo = true,
		content = i18n("mingshi_task_tip_" .. arg_39_1)
	})

	local var_39_2 = self:getTaskById(var_39_0:getConfig("config_data")[1])

	if var_39_2 and var_39_2:getTaskStatus() < 1 then
		self.mingshiTouchList = self.mingshiTouchList or {}

		for iter_39_0, iter_39_1 in pairs(self.mingshiTouchList) do
			if iter_39_1 == arg_39_1 then
				return
			end
		end

		for iter_39_2, iter_39_3 in pairs(var_39_0.data1_list) do
			if iter_39_3 == arg_39_1 then
				return
			end
		end

		table.insert(self.mingshiTouchList, arg_39_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = mingshiActivityId,
			arg1 = arg_39_1
		})
	end

	return
end

function TaskProxy:mingshiTouchFlagEnabled()
	local var_40_0 = getProxy(ActivityProxy):getActivityById(mingshiActivityId)

	if not var_40_0 or var_40_0:isEnd() then
		return
	end

	local var_40_1 = tonumber(var_40_0:getConfig("config_id"))
	local var_40_2 = self:getTaskById((tonumber(var_40_0:getConfig("config_data")[1])))

	if var_40_2 and var_40_2:getTaskStatus() < 1 then
		return true
	end

	if self:getTaskVO(var_40_1) then
		return false
	end

	return true
end

function TaskProxy:getAcademyTask(arg_41_1)
	local var_41_0 = _.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST), function(arg_42_0)
		local var_42_0 = arg_42_0:getTaskShip()

		return var_42_0 and var_42_0.groupId == arg_41_1
	end)

	if var_41_0 and not var_41_0:isEnd() then
		return getActivityTask(var_41_0, true)
	end

	return
end

function TaskProxy:isFinishPrevTasks(arg_43_1)
	local var_43_0 = Task.New({
		id = arg_43_1
	}):getConfig("open_need")

	if var_43_0 and type(var_43_0) == "table" and #var_43_0 > 0 then
		return _.all(var_43_0, function(arg_44_0)
			local var_44_0 = self:getTaskById(arg_44_0) or self:getFinishTaskById(arg_44_0)

			return var_44_0 and var_44_0:isReceive()
		end)
	end

	return true
end

function TaskProxy:isReceiveTasks(arg_45_1)
	return _.all(arg_45_1, function(arg_46_0)
		local var_46_0 = self:getFinishTaskById(arg_46_0)

		return var_46_0 and var_46_0:isReceive()
	end)
end

function TaskProxy:pushAutoSubmitTask()
	for iter_47_0, iter_47_1 in pairs(self.data) do
		self:checkAutoSubmitTask(iter_47_1)
	end

	return
end

function TaskProxy:checkAutoSubmitTask(arg_48_1)
	if arg_48_1:getConfig("auto_commit") == 1 and arg_48_1:isFinish() and not arg_48_1:getAutoSubmit() then
		arg_48_1:setAutoSubmit(true)
		self:sendNotification(GAME.SUBMIT_TASK, arg_48_1.id, function(arg_49_0)
			if arg_49_0 and arg_48_1:IsCommanderManualType() then
				getProxy(CommanderManualProxy):TaskAutoSubmitCall(arg_48_1.id)
			end

			return
		end)
	end

	return
end

function TaskProxy:addSubmittingTask(arg_50_1)
	self.submittingTask[arg_50_1] = true

	return
end

function TaskProxy:removeSubmittingTask(arg_51_1)
	self.submittingTask[arg_51_1] = nil

	return
end

function TaskProxy:isSubmitting(arg_52_1)
	return self.submittingTask[arg_52_1]
end

function TaskProxy:triggerClientTasks()
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs(self.data) do
		if iter_53_1:isClientTrigger() then
			table.insert(var_53_0, iter_53_1)
		end
	end

	return var_53_0
end

function TaskProxy:GetBackYardInterActionTaskList()
	local var_54_0 = {}

	for iter_54_0, iter_54_1 in pairs(self.data) do
		if iter_54_1:IsBackYardInterActionType() then
			table.insert(var_54_0, iter_54_1)
		end
	end

	return var_54_0
end

function TaskProxy:GetFlagShipInterActionTaskList()
	local var_55_0 = {}

	for iter_55_0, iter_55_1 in pairs(self.data) do
		if iter_55_1:IsFlagShipInterActionType() then
			table.insert(var_55_0, iter_55_1)
		end
	end

	return var_55_0
end

return TaskProxy
