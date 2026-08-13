class = var_0_10000

local var_0_0 = "EducateTask"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.SYSTEM_TYPE_MIND = 1
var_0_1.SYSTEM_TYPE_TARGET = 2
var_0_1.STSTEM_TYPE_MAIN = 3
var_0_1.TYPE_PLAN = 1
var_0_1.TYPE_ATTR = 2
var_0_1.TYPE_SITE_COST = 3
var_0_1.TYPE_PURCHASE = 4
var_0_1.TYPE_SITE_ENTER = 5
var_0_1.TYPE_TARGET = 6
var_0_1.TYPE_PERFORM = 7
var_0_1.TYPE_ITEM = 8
var_0_1.TYPE_TASK = 9
var_0_1.TYPE_SCHEDULE = 10
var_0_1.STATUS_UNFINISH = 0
var_0_1.STATUS_FINISH = 1
var_0_1.STATUS_RECEIVE = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.progress then
		var_1_0 = 0
	end

	arg_1_0.progress = var_1_0

	local var_1_1

	if not (arg_1_0.progress < 1) or not var_0_1.STATUS_UNFINISH then
		var_1_1 = var_0_1.STATUS_FINISH
	end

	arg_1_0.status = var_1_1

	arg_1_0:initCfgTime()

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.child_task
end

function var_0_1.initCfgTime(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("time_limit")

	EducateHelper = var_1_10002
	arg_3_0.startTime, arg_3_0.endTime = var_1_10002.CfgTime2Time(var_3_0)

	return
end

function var_0_1.GetSystemType(arg_4_0)
	return arg_4_0:getConfig("type_1")
end

function var_0_1.GetType(arg_5_0)
	return arg_5_0:getConfig("type_2")
end

function var_0_1.IsMind(arg_6_0)
	return arg_6_0:GetSystemType() == var_0_1.SYSTEM_TYPE_MIND
end

function var_0_1.IsTarget(arg_7_0)
	return arg_7_0:GetSystemType() == var_0_1.SYSTEM_TYPE_TARGET
end

function var_0_1.IsMain(arg_8_0)
	return arg_8_0:GetSystemType() == var_0_1.STSTEM_TYPE_MAIN
end

function var_0_1.NeedAddProgressFromSiteEnter(arg_9_0)
	return arg_9_0:GetType() == var_0_1.TYPE_SITE_ENTER and not arg_9_0:IsFinish()
end

function var_0_1.NeedAddProgressFromPerform(arg_10_0)
	return arg_10_0:GetType() == var_0_1.TYPE_PERFORM and not arg_10_0:IsFinish()
end

function var_0_1.InTime(arg_11_0, arg_11_1)
	local var_11_1

	if not arg_11_1 then
		::label_11_0::

		getProxy = var_11_1
		EducateProxy = var_1_10004

		local var_11_0 = var_11_1(var_1_10004)

		var_11_1 = var_11_1.GetCurTime(var_11_0)
	end

	EducateHelper = var_1_10003

	return var_1_10003.InTime(var_11_1, arg_11_0.startTime, arg_11_0.endTime)
end

function var_0_1.GetRemainTime(arg_12_0, arg_12_1)
	local var_12_1

	if not arg_12_1 then
		::label_12_0::

		getProxy = var_12_1
		EducateProxy = var_1_10004

		local var_12_0 = var_12_1(var_1_10004)

		var_12_1 = var_12_1.GetCurTime(var_12_0)
	end

	EducateHelper = var_1_10003

	return var_1_10003.GetDaysBetweenTimes(var_12_1, arg_12_0.endTime)
end

function var_0_1.IsFinish(arg_13_0)
	return arg_13_0:GetProgress() >= arg_13_0:GetFinishNum()
end

function var_0_1.GetProgress(arg_14_0)
	math = var_1_10001

	return var_1_10001.min(arg_14_0.progress, arg_14_0:GetFinishNum())
end

function var_0_1.GetFinishNum(arg_15_0)
	return arg_15_0:getConfig("arg")
end

function var_0_1.GetTargetProgress(arg_16_0)
	return arg_16_0:getConfig("task_target_progress")
end

function var_0_1.SetRecieve(arg_17_0)
	arg_17_0.isReceive = true
	arg_17_0.progress = arg_17_0:GetFinishNum()

	return
end

function var_0_1.IsReceive(arg_18_0)
	return arg_18_0.isReceive
end

function var_0_1.GetTaskStatus(arg_19_0)
	if arg_19_0:IsReceive() then
		return var_0_1.STATUS_RECEIVE
	end

	if arg_19_0:IsFinish() then
		return var_0_1.STATUS_FINISH
	end

	return var_0_1.STATUS_UNFINISH
end

function var_0_1.updateProgress(arg_20_0, arg_20_1)
	arg_20_0.progress = arg_20_1

	return
end

function var_0_1.GetAwardShow(arg_21_0)
	local var_21_0 = arg_21_0:getConfig("drop_display")

	return {
		type = var_21_0[1],
		id = var_21_0[2],
		number = var_21_0[3]
	}
end

return var_0_1
