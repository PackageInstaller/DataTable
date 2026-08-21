module("framework.time.ClockMgr", package.seeall)

local var_0_0 = class("ClockMgr")
local var_0_1 = 0

local function var_0_2()
	var_0_1 = var_0_1 + 1

	return var_0_1
end

local function var_0_3()
	var_0_1 = 0
end

function var_0_0.ctor(arg_3_0)
	arg_3_0._taskList = {}
	arg_3_0._tobeRemoveTaskIdTable = {}
	arg_3_0._tobeRemoveFlag = false
	arg_3_0._clockContext = ClockContext.New()
end

function var_0_0.start(arg_4_0)
	Scheduler.addListener(0, arg_4_0._onFrameEvent, arg_4_0, true)
end

function var_0_0.clear(arg_5_0)
	var_0_3()

	arg_5_0._tobeRemoveFlag = false

	table.clear(arg_5_0._taskList)
	table.clear(arg_5_0._tobeRemoveTaskIdTable)
	Scheduler.removeListener(arg_5_0._onFrameEvent, arg_5_0)
end

function var_0_0.addTask(arg_6_0, arg_6_1)
	local var_6_0 = var_0_2()

	arg_6_1:internal_setupTask(var_6_0)
	table.insert(arg_6_0._taskList, arg_6_1)

	return var_6_0
end

function var_0_0.removeTask(arg_7_0, arg_7_1)
	arg_7_0._tobeRemoveFlag = true
	arg_7_0._tobeRemoveTaskIdTable[arg_7_1] = true
end

function var_0_0.hasTask(arg_8_0, arg_8_1)
	return arg_8_0:_findTask(arg_8_1) and true or false
end

function var_0_0.getClockContext(arg_9_0)
	return arg_9_0._clockContext
end

function var_0_0._onFrameEvent(arg_10_0)
	local var_10_0 = arg_10_0._clockContext

	var_10_0:internal_onBeforeFrame()

	if not var_10_0:isTimeStampChanged() then
		return
	end

	local var_10_1 = arg_10_0._taskList
	local var_10_2 = arg_10_0._tobeRemoveFlag
	local var_10_3 = arg_10_0._tobeRemoveTaskIdTable

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if not (var_10_2 and var_10_3[iter_10_1:getTaskId()]) then
			iter_10_1:onCheck(var_10_0)
		end
	end

	if var_10_2 then
		for iter_10_2 in pairs(var_10_3) do
			arg_10_0:_removeTaskFromList(iter_10_2)

			var_10_3[iter_10_2] = nil
		end

		arg_10_0._tobeRemoveFlag = false
	end

	var_10_0:internal_onAfterFrame()
end

function var_0_0._findTask(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._taskList) do
		if iter_11_1:getTaskId() == arg_11_1 then
			return iter_11_1
		end
	end

	return false
end

function var_0_0._removeTaskFromList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._taskList

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1:getTaskId() == arg_12_1 then
			table.remove(var_12_0, iter_12_0)

			return true
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
