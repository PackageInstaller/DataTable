local var_0_0 = class("TaskProxy", import(".NetProxy"))

var_0_0.TASK_ADDED = "task added"
var_0_0.TASK_UPDATED = "task updated"
var_0_0.TASK_REMOVED = "task removed"
var_0_0.TASK_DELETE = "task deleted"
var_0_0.TASK_PROGRESS_UPDATE = "task TASK_PROGRESS_UPDATE"
var_0_0.WEEK_TASK_UPDATED = "week task updated"
var_0_0.WEEK_TASKS_ADDED = "week tasks added"
var_0_0.WEEK_TASKS_DELETED = "week task deleted"
var_0_0.WEEK_TASK_RESET = "week task refresh"
mingshiTriggerId = 1
mingshiActivityId = 21
changdaoActivityId = 10006
changdaoTaskStartId = 5031

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.finishData = {}
	arg_1_0.tmpInfo = {}

	arg_1_0:on(20001, function(arg_2_0)
		arg_1_0:initTaskInfo(arg_2_0.info)
		getProxy(TechnologyProxy):updateBlueprintStates()

		return
	end)
	arg_1_0:on(20002, function(arg_3_0)
		arg_1_0:updateProgress(arg_3_0.info)

		return
	end)
	arg_1_0:on(20003, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.info) do
			arg_1_0:addTask((Task.New(iter_4_1)))
		end

		return
	end)
	arg_1_0:on(20004, function(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.id_list) do
			arg_1_0:deleteTaskById(iter_5_1)
		end

		return
	end)
	arg_1_0:on(20015, function(arg_6_0)
		pg.proxyRegister.dayProto = true

		return
	end)

	arg_1_0.taskTriggers = {}
	arg_1_0.weekTaskProgressInfo = WeekTaskProgress.New()

	arg_1_0:on(20101, function(arg_7_0)
		arg_1_0.weekTaskProgressInfo:Init(arg_7_0.info)
		arg_1_0:sendNotification(var_0_0.WEEK_TASK_RESET)

		return
	end)
	arg_1_0:on(20102, function(arg_8_0)
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.task) do
			print("update sub task ", iter_8_1)

			local var_8_0 = WeekPtTask.New(iter_8_1)

			arg_1_0.weekTaskProgressInfo:UpdateSubTask(var_8_0)
			arg_1_0:sendNotification(var_0_0.WEEK_TASK_UPDATED, {
				id = var_8_0.id
			})
		end

		return
	end)
	arg_1_0:on(20103, function(arg_9_0)
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.id) do
			arg_1_0.weekTaskProgressInfo:AddSubTask((WeekPtTask.New({
				progress = 0,
				id = iter_9_1
			})))
		end

		arg_1_0:sendNotification(var_0_0.WEEK_TASKS_ADDED)

		return
	end)
	arg_1_0:on(20104, function(arg_10_0)
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.id) do
			print("remove sub task ", iter_10_1)
			arg_1_0.weekTaskProgressInfo:RemoveSubTask(iter_10_1)
		end

		arg_1_0:sendNotification(var_0_0.WEEK_TASKS_DELETED)

		return
	end)
	arg_1_0:on(20105, function(arg_11_0)
		arg_1_0.weekTaskProgressInfo:UpdateProgress(arg_11_0.pt)

		return
	end)

	arg_1_0.submittingTask = {}

	return
end

function var_0_0.timeCall(arg_12_0)
	return {
		[ProxyRegister.DayCall] = function(arg_13_0)
			arg_12_0:sendNotification(GAME.ACCEPT_ACTIVITY_TASK)
			arg_12_0:sendNotification(GAME.ZERO_HOUR_OP_DONE)

			return
		end
	}
end

function var_0_0.initTaskInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_0 = Task.New(iter_14_1)

		if var_14_0:getConfigTable() ~= nil then
			var_14_0:display("loaded")

			if var_14_0:getTaskStatus() ~= 2 then
				arg_14_0.data[var_14_0.id] = var_14_0
			else
				arg_14_0.finishData[var_14_0.id] = var_14_0
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

				arg_14_0.finishData[var_14_1.id] = var_14_1

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

function var_0_0.updateProgress(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if arg_15_0.data[iter_15_1.id] ~= nil then
			local var_15_0 = arg_15_0.data[iter_15_1.id]:isFinish()

			arg_15_0.data[iter_15_1.id].progress = iter_15_1.progress

			arg_15_0:updateTask(arg_15_0.data[iter_15_1.id])

			if not var_15_0 then
				arg_15_0:sendNotification(var_0_0.TASK_PROGRESS_UPDATE, arg_15_0.data[iter_15_1.id]:clone())
			end
		end
	end

	return
end

function var_0_0.initActData(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0:initTaskInfo(arg_16_2, arg_16_1, arg_16_3)

	return
end

function var_0_0.updateActProgress(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:updateProgress(arg_17_2)

	return
end

function var_0_0.addActData(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		local var_18_0 = Task.New(iter_18_1)

		var_18_0:setActId(arg_18_1)
		arg_18_0:addTask(var_18_0)
	end

	return
end

function var_0_0.removeActData(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(arg_19_2) do
		arg_19_0:deleteTaskById(iter_19_1.id)
	end

	return
end

function var_0_0.clearTimeOut(arg_20_0)
	if not arg_20_0.datas or #arg_20_0.datas == 0 then
		return
	end

	for iter_20_0 = #arg_20_0.datas, 1, -1 do
		if arg_20_0.datas[iter_20_0]:isActivityTask() then
			local var_20_1 = getProxy(ActivityProxy):getActivityById((arg_20_0.datas[iter_20_0]:getActId()))

			if not var_20_1 or var_20_1:isEnd() then
				table.insert({}, arg_20_0.datas[iter_20_0])
			end
		end
	end

	for iter_20_1 = 1, #{} do
		arg_20_0:deleteTask(({})[iter_20_1])
	end

	return
end

function var_0_0.GetWeekTaskProgressInfo(arg_21_0)
	return arg_21_0.weekTaskProgressInfo
end

function var_0_0.getTasksForBluePrint(arg_22_0)
	local var_22_0 = arg_22_0.data or {}

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		({})[iter_22_1.id] = iter_22_1
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0.finishData) do
		({})[iter_22_3.id] = iter_22_3
	end

	return {}
end

function var_0_0.addTmpTask(arg_23_0, arg_23_1)
	arg_23_0.tmpInfo[arg_23_1.id] = arg_23_1

	return
end

function var_0_0.checkTmpTask(arg_24_0, arg_24_1)
	if arg_24_0.tmpInfo[arg_24_1] then
		arg_24_0:addTask(arg_24_0.tmpInfo[arg_24_1])

		arg_24_0.tmpInfo[arg_24_1] = nil
	end

	return
end

function var_0_0.addTask(arg_25_0, arg_25_1)
	assert(isa(arg_25_1, Task), "should be an instance of Task")

	if arg_25_0.data[arg_25_1.id] then
		arg_25_0:addTmpTask(arg_25_1)

		return
	end

	if arg_25_1:getConfigTable() == nil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("task_notfound_error") .. tostring(arg_25_1.id))
		Debugger.LogWarning("Missing Task Config, id :" .. tostring(arg_25_1.id))

		return
	end

	arg_25_0.data[arg_25_1.id] = arg_25_1:clone()

	arg_25_0.data[arg_25_1.id]:display("added")
	arg_25_0.data[arg_25_1.id]:onAdded()
	arg_25_0.facade:sendNotification(var_0_0.TASK_ADDED, arg_25_1:clone())
	arg_25_0:checkAutoSubmitTask(arg_25_0.data[arg_25_1.id])

	return
end

function var_0_0.updateTask(arg_26_0, arg_26_1)
	assert(isa(arg_26_1, Task), "should be an instance of Task")

	local var_26_0 = arg_26_0.data[arg_26_1.id]

	assert(arg_26_0.data[arg_26_1.id] ~= nil, "task should exist")

	arg_26_0.data[arg_26_1.id] = arg_26_1:clone()
	arg_26_0.data[arg_26_1.id].acceptTime = var_26_0.acceptTime

	arg_26_0.data[arg_26_1.id]:display("updated")
	arg_26_0.facade:sendNotification(var_0_0.TASK_UPDATED, arg_26_1:clone())
	arg_26_0:checkAutoSubmitTask(arg_26_0.data[arg_26_1.id])

	return
end

function var_0_0.getTasks(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.data) do
		table.insert({}, iter_27_1)
	end

	return Clone({})
end

function var_0_0.getTaskById(arg_28_0, arg_28_1)
	if arg_28_0.data[arg_28_1] then
		return arg_28_0.data[arg_28_1]:clone()
	end

	return
end

function var_0_0.getFinishTaskById(arg_29_0, arg_29_1)
	if arg_29_0.finishData[arg_29_1] then
		return arg_29_0.finishData[arg_29_1]:clone()
	end

	return
end

function var_0_0.removeFinishTaskById(arg_30_0, arg_30_1)
	if arg_30_0.finishData[arg_30_1] then
		arg_30_0.finishData[arg_30_1] = nil
	end

	return
end

function var_0_0.getTaskVO(arg_31_0, arg_31_1)
	return arg_31_0:getTaskById(arg_31_1) or arg_31_0:getFinishTaskById(arg_31_1)
end

function var_0_0.getCanReceiveCount(arg_32_0)
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs(arg_32_0.data) do
		if iter_32_1:ShowOnTaskScene() and iter_32_1:isFinish() and iter_32_1:isReceive() == false then
			var_32_0 = var_32_0 + 1

			for iter_32_2, iter_32_3 in ipairs((iter_32_1:getConfig("award_display"))) do
				local var_32_1, var_32_2, var_32_3 = unpack(iter_32_3)

				if not LOCK_UR_SHIP and var_32_1 == DROP_TYPE_VITEM and Item.getConfigData(var_32_2).virtual_type == 20 then
					if not LOCK_UR_SHIP then
						local var_32_4 = getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]) or 0

						if not LOCK_UR_SHIP then
							local var_32_5 = pg.gameset.urpt_chapter_max.description[2] or 0

							if var_32_4 + var_32_3 - var_32_5 > 0 then
								var_32_0 = var_32_0 - 1
							end
						end
					end
				end
			end
		end
	end

	local var_32_6 = arg_32_0:GetWeekTaskProgressInfo()

	if var_32_6:CanUpgrade() then
		var_32_0 = var_32_0 + 1
	end

	return var_32_0 + var_32_6:GetCanSubmitSubTaskCnt()
end

function var_0_0.getNotFinishCount(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1 or 3
	local var_33_1 = 0

	for iter_33_0, iter_33_1 in pairs(arg_33_0.data) do
		if iter_33_1:GetRealType() == var_33_0 and iter_33_1:isFinish() == false then
			var_33_1 = var_33_1 + 1
		end
	end

	return var_33_1
end

function var_0_0.removeTask(arg_34_0, arg_34_1)
	assert(isa(arg_34_1, Task), "should be an instance of Task")
	arg_34_0:removeTaskById(arg_34_1.id)

	return
end

function var_0_0.removeTaskById(arg_35_0, arg_35_1)
	if arg_35_0.data[arg_35_1] == nil then
		return
	end

	if arg_35_0.data[arg_35_1]:isCircle() then
		return
	end

	arg_35_0.finishData[arg_35_1] = arg_35_0.data[arg_35_1]:clone()
	arg_35_0.finishData[arg_35_1].submitTime = pg.TimeMgr.GetInstance():GetServerTime()
	arg_35_0.data[arg_35_1] = nil

	arg_35_0:sendNotification(var_0_0.TASK_REMOVED, arg_35_0.data[arg_35_1])
	arg_35_0:checkTmpTask(arg_35_1)

	return
end

function var_0_0.deleteTask(arg_36_0, arg_36_1)
	assert(isa(arg_36_1, Task), "should be an instance of Task")
	arg_36_0:deleteTaskById(arg_36_1.id)

	return
end

function var_0_0.deleteTaskById(arg_37_0, arg_37_1)
	if arg_37_0.submittingTask[arg_37_1] then
		print("正在提交的任务不予删除，id:" .. arg_37_1)

		return
	end

	local var_37_0 = arg_37_0.data[arg_37_1] or arg_37_0.finishData[arg_37_1]

	arg_37_0.data[arg_37_1] = nil
	arg_37_0.finishData[arg_37_1] = nil

	if tobool(var_37_0) then
		arg_37_0:sendNotification(var_0_0.TASK_DELETE, var_37_0)
	end

	return
end

function var_0_0.getmingshiTaskID(arg_38_0, arg_38_1)
	if arg_38_1 >= pg.task_data_trigger[mingshiTriggerId].count then
		if pg.task_data_trigger[mingshiTriggerId].task_id and not arg_38_0:getTaskVO(pg.task_data_trigger[mingshiTriggerId].task_id) then
			return pg.task_data_trigger[mingshiTriggerId].task_id
		end
	end

	return 0
end

function var_0_0.dealMingshiTouchFlag(arg_39_0, arg_39_1)
	local var_39_0 = getProxy(ActivityProxy):getActivityById(mingshiActivityId)

	if not var_39_0 or var_39_0:isEnd() then
		return
	end

	local var_39_1 = var_39_0:getConfig("config_id")

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		hideNo = true,
		content = i18n("mingshi_task_tip_" .. arg_39_1)
	})

	local var_39_2 = arg_39_0:getTaskById(var_39_0:getConfig("config_data")[1])

	if var_39_2 and var_39_2:getTaskStatus() < 1 then
		arg_39_0.mingshiTouchList = arg_39_0.mingshiTouchList or {}

		for iter_39_0, iter_39_1 in pairs(arg_39_0.mingshiTouchList) do
			if iter_39_1 == arg_39_1 then
				return
			end
		end

		for iter_39_2, iter_39_3 in pairs(var_39_0.data1_list) do
			if iter_39_3 == arg_39_1 then
				return
			end
		end

		table.insert(arg_39_0.mingshiTouchList, arg_39_1)
		arg_39_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = mingshiActivityId,
			arg1 = arg_39_1
		})
	end

	return
end

function var_0_0.mingshiTouchFlagEnabled(arg_40_0)
	local var_40_0 = getProxy(ActivityProxy):getActivityById(mingshiActivityId)

	if not var_40_0 or var_40_0:isEnd() then
		return
	end

	local var_40_1 = tonumber(var_40_0:getConfig("config_id"))
	local var_40_2 = arg_40_0:getTaskById((tonumber(var_40_0:getConfig("config_data")[1])))

	if var_40_2 and var_40_2:getTaskStatus() < 1 then
		return true
	end

	if arg_40_0:getTaskVO(var_40_1) then
		return false
	end

	return true
end

function var_0_0.getAcademyTask(arg_41_0, arg_41_1)
	local var_41_0 = _.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST), function(arg_42_0)
		local var_42_0 = arg_42_0:getTaskShip()

		return var_42_0 and var_42_0.groupId == arg_41_1
	end)

	if var_41_0 and not var_41_0:isEnd() then
		return getActivityTask(var_41_0, true)
	end

	return
end

function var_0_0.isFinishPrevTasks(arg_43_0, arg_43_1)
	local var_43_0 = Task.New({
		id = arg_43_1
	}):getConfig("open_need")

	if var_43_0 and type(var_43_0) == "table" and #var_43_0 > 0 then
		return _.all(var_43_0, function(arg_44_0)
			local var_44_0 = arg_43_0:getTaskById(arg_44_0) or arg_43_0:getFinishTaskById(arg_44_0)

			return var_44_0 and var_44_0:isReceive()
		end)
	end

	return true
end

function var_0_0.isReceiveTasks(arg_45_0, arg_45_1)
	return _.all(arg_45_1, function(arg_46_0)
		local var_46_0 = arg_45_0:getFinishTaskById(arg_46_0)

		return var_46_0 and var_46_0:isReceive()
	end)
end

function var_0_0.pushAutoSubmitTask(arg_47_0)
	for iter_47_0, iter_47_1 in pairs(arg_47_0.data) do
		arg_47_0:checkAutoSubmitTask(iter_47_1)
	end

	return
end

function var_0_0.checkAutoSubmitTask(arg_48_0, arg_48_1)
	if arg_48_1:getConfig("auto_commit") == 1 and arg_48_1:isFinish() and not arg_48_1:getAutoSubmit() then
		arg_48_1:setAutoSubmit(true)
		arg_48_0:sendNotification(GAME.SUBMIT_TASK, arg_48_1.id, function(arg_49_0)
			if arg_49_0 and arg_48_1:IsCommanderManualType() then
				getProxy(CommanderManualProxy):TaskAutoSubmitCall(arg_48_1.id)
			end

			return
		end)
	end

	return
end

function var_0_0.addSubmittingTask(arg_50_0, arg_50_1)
	arg_50_0.submittingTask[arg_50_1] = true

	return
end

function var_0_0.removeSubmittingTask(arg_51_0, arg_51_1)
	arg_51_0.submittingTask[arg_51_1] = nil

	return
end

function var_0_0.isSubmitting(arg_52_0, arg_52_1)
	return arg_52_0.submittingTask[arg_52_1]
end

function var_0_0.triggerClientTasks(arg_53_0)
	for iter_53_0, iter_53_1 in pairs(arg_53_0.data) do
		if iter_53_1:isClientTrigger() then
			table.insert({}, iter_53_1)
		end
	end

	return {}
end

function var_0_0.GetBackYardInterActionTaskList(arg_54_0)
	for iter_54_0, iter_54_1 in pairs(arg_54_0.data) do
		if iter_54_1:IsBackYardInterActionType() then
			table.insert({}, iter_54_1)
		end
	end

	return {}
end

function var_0_0.GetFlagShipInterActionTaskList(arg_55_0)
	for iter_55_0, iter_55_1 in pairs(arg_55_0.data) do
		if iter_55_1:IsFlagShipInterActionType() then
			table.insert({}, iter_55_1)
		end
	end

	return {}
end

return var_0_0
