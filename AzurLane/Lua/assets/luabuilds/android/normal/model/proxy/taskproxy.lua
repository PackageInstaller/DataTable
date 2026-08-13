class = var_0_10000

local var_0_0 = "TaskProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.TASK_ADDED = "task added"
var_0_1.TASK_UPDATED = "task updated"
var_0_1.TASK_REMOVED = "task removed"
var_0_1.TASK_DELETE = "task deleted"
var_0_1.TASK_PROGRESS_UPDATE = "task TASK_PROGRESS_UPDATE"
var_0_1.WEEK_TASK_UPDATED = "week task updated"
var_0_1.WEEK_TASKS_ADDED = "week tasks added"
var_0_1.WEEK_TASKS_DELETED = "week task deleted"
var_0_1.WEEK_TASK_RESET = "week task refresh"

local var_0_2 = 1
local var_0_3 = mingshiTriggerId
local var_0_4 = 21
local var_0_5 = mingshiActivityId
local var_0_6 = 10006
local var_0_7 = changdaoActivityId
local var_0_8 = 5031
local var_0_9 = changdaoTaskStartId

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.finishData = {}
	arg_1_0.tmpInfo = {}

	arg_1_0:on(20001, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.initTaskInfo(var_2_0, arg_2_0.info)

		getProxy = var_1
		TechnologyProxy = var_2_0

		local var_2_1 = var_1(var_2_0)

		var_1.updateBlueprintStates(var_2_1)

		return
	end)
	arg_1_0:on(20002, function(arg_3_0)
		local var_3_0 = arg_1_0

		var_1.updateProgress(var_3_0, arg_3_0.info)

		return
	end)
	arg_1_0:on(20003, function(arg_4_0)
		ipairs = var_2_10001

		for iter_4_0, iter_4_1 in var_2_10001(arg_4_0.info) do
			Task = var_2_10006
			var_2_10006 = var_2_10006.New(iter_4_1)

			local var_4_0 = arg_1_0

			var_7.addTask(var_4_0, var_2_10006)
		end

		return
	end)
	arg_1_0:on(20004, function(arg_5_0)
		ipairs = var_2_10001

		for iter_5_0, iter_5_1 in var_2_10001(arg_5_0.id_list) do
			local var_5_0 = arg_1_0

			var_6.deleteTaskById(var_5_0, iter_5_1)
		end

		return
	end)
	arg_1_0:on(20015, function(arg_6_0)
		pg = var_2_10001
		var_2_10001.proxyRegister.dayProto = true

		return
	end)

	arg_1_0.taskTriggers = {}
	WeekTaskProgress = var_1
	arg_1_0.weekTaskProgressInfo = var_1.New()

	arg_1_0:on(20101, function(arg_7_0)
		local var_7_0 = arg_1_0.weekTaskProgressInfo

		var_1.Init(var_7_0, arg_7_0.info)

		local var_7_1 = arg_1_0

		var_1.sendNotification(var_7_1, var_0_1.WEEK_TASK_RESET)

		return
	end)
	arg_1_0:on(20102, function(arg_8_0)
		ipairs = var_2_10001

		for iter_8_0, iter_8_1 in var_2_10001(arg_8_0.task) do
			print = var_2_10006

			var_2_10006("update sub task ", iter_8_1)

			WeekPtTask = var_2_10006
			var_2_10006 = var_2_10006.New(iter_8_1)

			local var_8_0 = arg_1_0.weekTaskProgressInfo

			var_7.UpdateSubTask(var_8_0, var_2_10006)

			local var_8_1 = arg_1_0

			var_7.sendNotification(var_8_1, var_0_1.WEEK_TASK_UPDATED, {
				id = var_2_10006.id
			})
		end

		return
	end)
	arg_1_0:on(20103, function(arg_9_0)
		ipairs = var_2_10001

		for iter_9_0, iter_9_1 in var_2_10001(arg_9_0.id) do
			WeekPtTask = var_2_10006
			var_2_10006 = var_2_10006.New({
				progress = 0,
				id = iter_9_1
			})

			local var_9_0 = arg_1_0.weekTaskProgressInfo

			var_7.AddSubTask(var_9_0, var_2_10006)
		end

		local var_9_1 = arg_1_0

		var_1.sendNotification(var_9_1, var_0_1.WEEK_TASKS_ADDED)

		return
	end)
	arg_1_0:on(20104, function(arg_10_0)
		ipairs = var_2_10001

		for iter_10_0, iter_10_1 in var_2_10001(arg_10_0.id) do
			print = var_2_10006

			var_2_10006("remove sub task ", iter_10_1)

			local var_10_0 = arg_1_0.weekTaskProgressInfo

			var_2_10006.RemoveSubTask(var_10_0, iter_10_1)
		end

		local var_10_1 = arg_1_0

		var_1.sendNotification(var_10_1, var_0_1.WEEK_TASKS_DELETED)

		return
	end)
	arg_1_0:on(20105, function(arg_11_0)
		local var_11_0 = arg_11_0.pt
		local var_11_1 = arg_1_0.weekTaskProgressInfo

		var_2.UpdateProgress(var_11_1, var_11_0)

		return
	end)

	arg_1_0.submittingTask = {}

	return
end

function var_0_1.timeCall(arg_12_0)
	local var_12_0 = {}

	ProxyRegister = var_1_10002
	var_12_0[var_1_10002.DayCall] = function(arg_13_0)
		local var_13_0 = arg_12_0
		local var_13_1 = var_1.sendNotification

		GAME = var_2_10003

		var_13_1(var_13_0, var_2_10003.ACCEPT_ACTIVITY_TASK)

		local var_13_2 = arg_12_0
		local var_13_3 = var_1.sendNotification

		GAME = var_3

		var_13_3(var_13_2, var_3.ZERO_HOUR_OP_DONE)

		return
	end

	return var_12_0
end

function var_0_1.initTaskInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	ipairs = var_1_10004

	for iter_14_0, iter_14_1 in var_1_10004(arg_14_1) do
		Task = var_1_10009

		local var_14_0 = var_1_10009.New(iter_14_1)
		local var_14_1

		if var_1_10009.getConfigTable(var_14_0) ~= nil then
			var_1_10009:display("loaded")

			if var_1_10009:getTaskStatus() ~= 2 then
				var_14_1 = arg_14_0.data
				var_14_1[var_1_10009.id] = var_1_10009
			else
				var_14_1 = arg_14_0.finishData
				var_14_1[var_1_10009.id] = var_1_10009
			end

			var_1_10009:setActId(arg_14_2)
		else
			pg = var_14_1

			local var_14_2 = var_14_1.TipsMgr.GetInstance()
			local var_14_3 = var_10.ShowTips

			i18n = var_1_10012
			var_1_10012 = var_1_10012("task_notfound_error")
			tostring = var_13

			var_14_3(var_14_2, var_1_10012 .. var_13(iter_14_1.id))

			Debugger = var_14_3

			local var_14_4 = var_14_3.LogWarning
			local var_14_5 = "Missing Task Config, id :"

			tostring = var_1_10012

			var_14_4(var_14_5 .. var_1_10012(iter_14_1.id))
		end
	end

	if arg_14_3 and #arg_14_3 > 0 then
		ipairs = var_4

		for iter_14_2, iter_14_3 in var_4(arg_14_3) do
			Task = var_1_10009

			local var_14_6 = var_1_10009.New({
				id = iter_14_3
			})
			local var_14_7

			if var_1_10009.getConfigTable(var_14_6) ~= nil then
				var_1_10009:display("loaded")

				var_14_7 = arg_14_0.finishData
				var_14_7[var_1_10009.id] = var_1_10009

				var_1_10009:setActId(arg_14_2)
				var_1_10009:setTaskFinish()
			else
				pg = var_14_7

				local var_14_8 = var_14_7.TipsMgr.GetInstance()
				local var_14_9 = var_10.ShowTips

				i18n = var_1_10012
				var_1_10012 = var_1_10012("task_notfound_error")
				tostring = var_13

				var_14_9(var_14_8, var_1_10012 .. var_13(iter_14_3.id))

				Debugger = var_14_9

				local var_14_10 = var_14_9.LogWarning
				local var_14_11 = "Missing Task Config, id :"

				tostring = var_1_10012

				var_14_10(var_14_11 .. var_1_10012(iter_14_3.id))
			end
		end
	end

	return
end

function var_0_1.updateProgress(arg_15_0, arg_15_1)
	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_1) do
		if arg_15_0.data[iter_15_1.id] ~= nil then
			local var_15_0 = var_7:isFinish()

			var_7.progress = iter_15_1.progress

			arg_15_0:updateTask(var_7)

			if not var_15_0 then
				arg_15_0:sendNotification(var_0_1.TASK_PROGRESS_UPDATE, var_7:clone())
			end
		end
	end

	return
end

function var_0_1.initActData(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0:initTaskInfo(arg_16_2, arg_16_1, arg_16_3)

	return
end

function var_0_1.updateActProgress(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:updateProgress(arg_17_2)

	return
end

function var_0_1.addActData(arg_18_0, arg_18_1, arg_18_2)
	ipairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(arg_18_2) do
		Task = var_1_10008

		local var_18_0 = var_1_10008.New(iter_18_1)

		var_1_10008.setActId(var_18_0, arg_18_1)
		arg_18_0:addTask(var_1_10008)
	end

	return
end

function var_0_1.removeActData(arg_19_0, arg_19_1, arg_19_2)
	ipairs = var_1_10003

	for iter_19_0, iter_19_1 in var_1_10003(arg_19_2) do
		arg_19_0:deleteTaskById(iter_19_1.id)
	end

	return
end

function var_0_1.clearTimeOut(arg_20_0)
	if not arg_20_0.datas or #arg_20_0.datas == 0 then
		return
	end

	local var_20_0 = false
	local var_20_1 = {}

	for iter_20_0 = #arg_20_0.datas, 1, -1 do
		local var_20_2 = arg_20_0.datas[iter_20_0]

		if var_7.isActivityTask(var_20_2) then
			local var_20_3 = var_7
			local var_20_4 = var_7.getActId(var_20_3)

			getProxy = var_20_3
			ActivityProxy = var_1_10010
			var_1_10010 = var_20_3(var_1_10010)

			if not var_9.getActivityById(var_1_10010, var_20_4) or var_9:isEnd() then
				table = var_1_10010

				var_1_10010.insert(var_20_1, var_7)

				local var_20_5 = true
			end
		end
	end

	for iter_20_1 = 1, #var_20_1 do
		arg_20_0:deleteTask(var_20_1[iter_20_1])
	end

	return
end

function var_0_1.GetWeekTaskProgressInfo(arg_21_0)
	return arg_21_0.weekTaskProgressInfo
end

function var_0_1.getTasksForBluePrint(arg_22_0)
	local var_22_0 = {}

	pairs = var_1_10002

	local var_22_1

	if not arg_22_0.data then
		var_22_1 = {}
	end

	for iter_22_0, iter_22_1 in var_1_10002(var_22_1) do
		var_22_0[iter_22_1.id] = iter_22_1
	end

	pairs = var_2

	for iter_22_2, iter_22_3 in var_2(arg_22_0.finishData) do
		var_22_0[iter_22_3.id] = iter_22_3
	end

	return var_22_0
end

function var_0_1.addTmpTask(arg_23_0, arg_23_1)
	arg_23_0.tmpInfo[arg_23_1.id] = arg_23_1

	return
end

function var_0_1.checkTmpTask(arg_24_0, arg_24_1)
	if arg_24_0.tmpInfo[arg_24_1] then
		arg_24_0:addTask(arg_24_0.tmpInfo[arg_24_1])

		arg_24_0.tmpInfo[arg_24_1] = nil
	end

	return
end

function var_0_1.addTask(arg_25_0, arg_25_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_25_0 = arg_25_1

	Task = var_1_10005

	var_1_10002(var_1_10003(var_25_0, var_1_10005), "should be an instance of Task")

	if arg_25_0.data[arg_25_1.id] then
		arg_25_0:addTmpTask(arg_25_1)

		return
	end

	if arg_25_1:getConfigTable() == nil then
		pg = var_2

		local var_25_1 = var_2.TipsMgr.GetInstance()
		local var_25_2 = var_2.ShowTips

		i18n = var_4

		local var_25_3 = var_4("task_notfound_error")

		tostring = var_5

		var_25_2(var_25_1, var_25_3 .. var_5(arg_25_1.id))

		Debugger = var_25_2

		local var_25_4 = var_25_2.LogWarning
		local var_25_5 = "Missing Task Config, id :"

		tostring = var_4

		var_25_4(var_25_5 .. var_4(arg_25_1.id))

		return
	end

	arg_25_0.data[arg_25_1.id] = arg_25_1:clone()

	local var_25_6 = arg_25_0.data[arg_25_1.id]

	var_2.display(var_25_6, "added")

	local var_25_7 = arg_25_0.data[arg_25_1.id]

	var_2.onAdded(var_25_7)

	local var_25_8 = arg_25_0.facade

	var_2.sendNotification(var_25_8, var_0_1.TASK_ADDED, arg_25_1:clone())
	arg_25_0:checkAutoSubmitTask(arg_25_0.data[arg_25_1.id])

	return
end

function var_0_1.updateTask(arg_26_0, arg_26_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_26_0 = arg_26_1

	Task = var_1_10005

	var_1_10002(var_1_10003(var_26_0, var_1_10005), "should be an instance of Task")

	local var_26_1 = arg_26_0.data[arg_26_1.id]

	assert = var_3

	var_3(var_26_1 ~= nil, "task should exist")

	arg_26_0.data[arg_26_1.id] = arg_26_1:clone()
	arg_26_0.data[arg_26_1.id].acceptTime = var_26_1.acceptTime

	local var_26_2 = arg_26_0.data[arg_26_1.id]

	var_3.display(var_26_2, "updated")

	local var_26_3 = arg_26_0.facade

	var_3.sendNotification(var_26_3, var_0_1.TASK_UPDATED, arg_26_1:clone())
	arg_26_0:checkAutoSubmitTask(arg_26_0.data[arg_26_1.id])

	return
end

function var_0_1.getTasks(arg_27_0)
	local var_27_0 = {}

	pairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0.data) do
		table = var_1_10007

		var_1_10007.insert(var_27_0, iter_27_1)
	end

	Clone = var_2

	return var_2(var_27_0)
end

function var_0_1.getTaskById(arg_28_0, arg_28_1)
	if arg_28_0.data[arg_28_1] then
		local var_28_0 = arg_28_0.data[arg_28_1]

		return var_2.clone(var_28_0)
	end

	return
end

function var_0_1.getFinishTaskById(arg_29_0, arg_29_1)
	if arg_29_0.finishData[arg_29_1] then
		local var_29_0 = arg_29_0.finishData[arg_29_1]

		return var_2.clone(var_29_0)
	end

	return
end

function var_0_1.removeFinishTaskById(arg_30_0, arg_30_1)
	if arg_30_0.finishData[arg_30_1] then
		arg_30_0.finishData[arg_30_1] = nil
	end

	return
end

function var_0_1.getTaskVO(arg_31_0, arg_31_1)
	local var_31_0

	if not arg_31_0:getTaskById(arg_31_1) then
		var_31_0 = arg_31_0:getFinishTaskById(arg_31_1)
	end

	return var_31_0
end

function var_0_1.getCanReceiveCount(arg_32_0)
	local var_32_0 = 0

	pairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(arg_32_0.data) do
		if iter_32_1:ShowOnTaskScene() and iter_32_1:isFinish() and iter_32_1:isReceive() == false then
			var_32_0 = var_32_0 + 1

			local var_32_1 = iter_32_1
			local var_32_2 = iter_32_1.getConfig(var_32_1, "award_display")

			ipairs = var_32_1

			for iter_32_2, iter_32_3 in var_32_1(var_32_2) do
				unpack = var_1_10013

				local var_32_3, var_32_4

				var_1_10013, var_32_3, var_32_4 = var_1_10013(iter_32_3)
				LOCK_UR_SHIP = var_1_10016

				if not var_1_10016 then
					DROP_TYPE_VITEM = var_1_10016

					if var_1_10013 == var_1_10016 then
						Item = var_1_10016

						if var_1_10016.getConfigData(var_32_3).virtual_type == 20 then
							pg = var_1_10016
							var_1_10016 = var_1_10016.gameset.urpt_chapter_max.description[1]
							LOCK_UR_SHIP = var_17

							if not var_17 then
								getProxy = var_17
								BagProxy = var_1_10018
								var_1_10018 = var_17(var_1_10018)

								local var_32_5

								if not var_17.GetLimitCntById(var_1_10018, var_1_10016) then
									var_32_5 = 0
								end

								LOCK_UR_SHIP = var_1_10018

								if not var_1_10018 then
									pg = var_1_10018

									if not var_1_10018.gameset.urpt_chapter_max.description[2] then
										var_1_10018 = 0
									end

									if var_32_5 + var_32_4 - var_1_10018 > 0 then
										var_32_0 = var_32_0 - 1
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local var_32_6 = arg_32_0:GetWeekTaskProgressInfo()

	if var_2.CanUpgrade(var_32_6) then
		var_32_0 = var_32_0 + 1
	end

	return var_32_0 + var_2:GetCanSubmitSubTaskCnt()
end

function var_0_1.getNotFinishCount(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1 or 3
	local var_33_1 = 0

	pairs = var_1_10004

	for iter_33_0, iter_33_1 in var_1_10004(arg_33_0.data) do
		if iter_33_1:GetRealType() == var_33_0 and iter_33_1:isFinish() == false then
			var_33_1 = var_33_1 + 1
		end
	end

	return var_33_1
end

function var_0_1.removeTask(arg_34_0, arg_34_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_34_0 = arg_34_1

	Task = var_1_10005

	var_1_10002(var_1_10003(var_34_0, var_1_10005), "should be an instance of Task")
	arg_34_0:removeTaskById(arg_34_1.id)

	return
end

function var_0_1.removeTaskById(arg_35_0, arg_35_1)
	if arg_35_0.data[arg_35_1] == nil then
		return
	end

	if var_2:isCircle() then
		return
	end

	local var_35_0 = arg_35_0.finishData
	local var_35_1 = arg_35_0.data[arg_35_1]

	var_35_0[arg_35_1] = var_4.clone(var_35_1)

	local var_35_2 = arg_35_0.finishData[arg_35_1]

	pg = var_4

	local var_35_3 = var_4.TimeMgr.GetInstance()

	var_35_2.submitTime = var_4.GetServerTime(var_35_3)
	arg_35_0.data[arg_35_1] = nil

	arg_35_0:sendNotification(var_0_1.TASK_REMOVED, var_2)
	arg_35_0:checkTmpTask(arg_35_1)

	return
end

function var_0_1.deleteTask(arg_36_0, arg_36_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_36_0 = arg_36_1

	Task = var_1_10005

	var_1_10002(var_1_10003(var_36_0, var_1_10005), "should be an instance of Task")
	arg_36_0:deleteTaskById(arg_36_1.id)

	return
end

function var_0_1.deleteTaskById(arg_37_0, arg_37_1)
	if arg_37_0.submittingTask[arg_37_1] then
		print = var_2

		var_2("正在提交的任务不予删除，id:" .. arg_37_1)

		return
	end

	local var_37_0

	if not arg_37_0.data[arg_37_1] then
		var_37_0 = arg_37_0.finishData[arg_37_1]
	end

	arg_37_0.data[arg_37_1] = nil

	local var_37_1 = arg_37_0.finishData

	var_37_1[arg_37_1] = nil
	tobool = var_37_1

	if var_37_1(var_37_0) then
		arg_37_0:sendNotification(var_0_1.TASK_DELETE, var_37_0)
	end

	return
end

function var_0_1.getmingshiTaskID(arg_38_0, arg_38_1)
	pg = var_1_10002

	local var_38_0 = var_1_10002.task_data_trigger

	mingshiTriggerId = var_1_10003

	if arg_38_1 >= var_38_0[var_1_10003].count and var_2.task_id and not arg_38_0:getTaskVO(var_4) then
		return var_4
	end

	return 0
end

function var_0_1.dealMingshiTouchFlag(arg_39_0, arg_39_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_39_0 = var_1_10002(var_1_10003)
	local var_39_1 = var_2.getActivityById

	mingshiActivityId = var_1_10004

	if not var_39_1(var_39_0, var_1_10004) or var_2:isEnd() then
		return
	end

	local var_39_2 = var_2:getConfig("config_id")
	local var_39_3 = var_2
	local var_39_4 = var_2.getConfig(var_39_3, "config_data")[1]

	pg = var_39_3

	local var_39_5 = var_39_3.MsgboxMgr.GetInstance()
	local var_39_6 = var_5.ShowMsgBox
	local var_39_7 = {
		hideNo = true
	}

	i18n = var_1_10008
	var_39_7.content = var_1_10008("mingshi_task_tip_" .. arg_39_1)

	var_39_6(var_39_5, var_39_7)

	if arg_39_0:getTaskById(var_39_4) and var_5:getTaskStatus() < 1 then
		if not arg_39_0.mingshiTouchList then
			arg_39_0.mingshiTouchList = {}
		end

		pairs = var_6

		for iter_39_0, iter_39_1 in var_6(arg_39_0.mingshiTouchList) do
			if iter_39_1 == arg_39_1 then
				return
			end
		end

		pairs = var_6

		for iter_39_2, iter_39_3 in var_6(var_2.data1_list) do
			if iter_39_3 == arg_39_1 then
				return
			end
		end

		table = var_6

		var_6.insert(arg_39_0.mingshiTouchList, arg_39_1)

		local var_39_8 = arg_39_0
		local var_39_9 = arg_39_0.sendNotification

		GAME = var_8

		local var_39_10 = var_8.ACTIVITY_OPERATION
		local var_39_11 = {
			cmd = 2
		}

		mingshiActivityId = iter_39_3
		var_39_11.activity_id = iter_39_3
		var_39_11.arg1 = arg_39_1

		var_39_9(var_39_8, var_39_10, var_39_11)
	end

	return
end

function var_0_1.mingshiTouchFlagEnabled(arg_40_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_40_0 = var_1_10001(var_1_10002)
	local var_40_1 = var_1.getActivityById

	mingshiActivityId = var_1_10003

	if not var_40_1(var_40_0, var_1_10003) or var_1:isEnd() then
		return
	end

	tonumber = var_40_0

	local var_40_2 = var_40_0(var_1:getConfig("config_id"))

	tonumber = var_3

	local var_40_3 = var_3(var_1:getConfig("config_data")[1])

	if arg_40_0:getTaskById(var_40_3) and var_4:getTaskStatus() < 1 then
		return true
	end

	if arg_40_0:getTaskVO(var_40_2) then
		return false
	end

	return true
end

function var_0_1.getAcademyTask(arg_41_0, arg_41_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_41_0 = var_1_10002(var_1_10003)
	local var_41_1 = var_2.getActivitiesByType

	ActivityConst = var_1_10005

	local var_41_2 = var_41_1(var_41_0, var_1_10005.ACTIVITY_TYPE_TASK_LIST)

	_ = var_41_0

	if var_41_0.detect(var_41_2, function(arg_42_0)
		return arg_42_0:getTaskShip() and var_1.groupId == arg_41_1
	end) and not var_4:isEnd() then
		getActivityTask = var_5

		return var_5(var_4, true)
	end

	return
end

function var_0_1.isFinishPrevTasks(arg_43_0, arg_43_1)
	Task = var_1_10002

	local var_43_0 = var_1_10002.New({
		id = arg_43_1
	})

	if var_2.getConfig(var_43_0, "open_need") then
		type = var_43_0

		if var_43_0(var_3) == "table" and #var_3 > 0 then
			_ = var_4

			return var_4.all(var_3, function(arg_44_0)
				local var_44_0 = arg_43_0
				local var_44_2

				if not var_1.getTaskById(var_44_0, arg_44_0) then
					local var_44_1 = arg_43_0

					var_44_2 = var_2.getFinishTaskById(var_44_1, arg_44_0)
				end

				return var_44_2 and var_44_2:isReceive()
			end)
		end
	end

	return true
end

function var_0_1.isReceiveTasks(arg_45_0, arg_45_1)
	_ = var_1_10002

	return var_1_10002.all(arg_45_1, function(arg_46_0)
		local var_46_0 = arg_45_0
		local var_46_1

		var_46_1 = var_1.getFinishTaskById(var_46_0, arg_46_0) and var_1:isReceive()

		return var_46_1
	end)
end

function var_0_1.pushAutoSubmitTask(arg_47_0)
	pairs = var_1_10001

	for iter_47_0, iter_47_1 in var_1_10001(arg_47_0.data) do
		arg_47_0:checkAutoSubmitTask(iter_47_1)
	end

	return
end

function var_0_1.checkAutoSubmitTask(arg_48_0, arg_48_1)
	if arg_48_1:getConfig("auto_commit") == 1 and arg_48_1:isFinish() and not arg_48_1:getAutoSubmit() then
		arg_48_1:setAutoSubmit(true)

		local var_48_0 = arg_48_0
		local var_48_1 = arg_48_0.sendNotification

		GAME = var_4

		var_48_1(var_48_0, var_4.SUBMIT_TASK, arg_48_1.id, function(arg_49_0)
			if arg_49_0 then
				local var_49_0 = arg_48_1

				if var_1.IsCommanderManualType(var_49_0) then
					getProxy = var_1
					CommanderManualProxy = var_49_0

					local var_49_1 = var_1(var_49_0)

					var_1.TaskAutoSubmitCall(var_49_1, arg_48_1.id)
				end
			end

			return
		end)
	end

	return
end

function var_0_1.addSubmittingTask(arg_50_0, arg_50_1)
	arg_50_0.submittingTask[arg_50_1] = true

	return
end

function var_0_1.removeSubmittingTask(arg_51_0, arg_51_1)
	arg_51_0.submittingTask[arg_51_1] = nil

	return
end

function var_0_1.isSubmitting(arg_52_0, arg_52_1)
	return arg_52_0.submittingTask[arg_52_1]
end

function var_0_1.triggerClientTasks(arg_53_0)
	local var_53_0 = {}

	pairs = var_1_10002

	for iter_53_0, iter_53_1 in var_1_10002(arg_53_0.data) do
		if iter_53_1:isClientTrigger() then
			table = var_7

			var_7.insert(var_53_0, iter_53_1)
		end
	end

	return var_53_0
end

function var_0_1.GetBackYardInterActionTaskList(arg_54_0)
	local var_54_0 = {}

	pairs = var_1_10002

	for iter_54_0, iter_54_1 in var_1_10002(arg_54_0.data) do
		if iter_54_1:IsBackYardInterActionType() then
			table = var_7

			var_7.insert(var_54_0, iter_54_1)
		end
	end

	return var_54_0
end

function var_0_1.GetFlagShipInterActionTaskList(arg_55_0)
	local var_55_0 = {}

	pairs = var_1_10002

	for iter_55_0, iter_55_1 in var_1_10002(arg_55_0.data) do
		if iter_55_1:IsFlagShipInterActionType() then
			table = var_7

			var_7.insert(var_55_0, iter_55_1)
		end
	end

	return var_55_0
end

return var_0_1
