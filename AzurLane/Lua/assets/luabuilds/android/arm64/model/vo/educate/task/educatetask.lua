local var_0_0 = class("EducateTask", import("model.vo.BaseVO"))

var_0_0.SYSTEM_TYPE_MIND = 1
var_0_0.SYSTEM_TYPE_TARGET = 2
var_0_0.STSTEM_TYPE_MAIN = 3
var_0_0.TYPE_PLAN = 1
var_0_0.TYPE_ATTR = 2
var_0_0.TYPE_SITE_COST = 3
var_0_0.TYPE_PURCHASE = 4
var_0_0.TYPE_SITE_ENTER = 5
var_0_0.TYPE_TARGET = 6
var_0_0.TYPE_PERFORM = 7
var_0_0.TYPE_ITEM = 8
var_0_0.TYPE_TASK = 9
var_0_0.TYPE_SCHEDULE = 10
var_0_0.STATUS_UNFINISH = 0
var_0_0.STATUS_FINISH = 1
var_0_0.STATUS_RECEIVE = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.progress = arg_1_1.progress or 0

	if arg_1_0.progress < 1 then
		arg_1_0.status = var_0_0.STATUS_UNFINISH or var_0_0.STATUS_FINISH

		arg_1_0:initCfgTime()

		return
	end
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.child_task
end

function var_0_0.initCfgTime(arg_3_0)
	arg_3_0.startTime, arg_3_0.endTime = EducateHelper.CfgTime2Time((arg_3_0:getConfig("time_limit")))

	return
end

function var_0_0.GetSystemType(arg_4_0)
	return arg_4_0:getConfig("type_1")
end

function var_0_0.GetType(arg_5_0)
	return arg_5_0:getConfig("type_2")
end

function var_0_0.IsMind(arg_6_0)
	return arg_6_0:GetSystemType() == var_0_0.SYSTEM_TYPE_MIND
end

function var_0_0.IsTarget(arg_7_0)
	return arg_7_0:GetSystemType() == var_0_0.SYSTEM_TYPE_TARGET
end

function var_0_0.IsMain(arg_8_0)
	return arg_8_0:GetSystemType() == var_0_0.STSTEM_TYPE_MAIN
end

function var_0_0.NeedAddProgressFromSiteEnter(arg_9_0)
	return arg_9_0:GetType() == var_0_0.TYPE_SITE_ENTER and not arg_9_0:IsFinish()
end

function var_0_0.NeedAddProgressFromPerform(arg_10_0)
	return arg_10_0:GetType() == var_0_0.TYPE_PERFORM and not arg_10_0:IsFinish()
end

function var_0_0.InTime(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 or getProxy(EducateProxy):GetCurTime()

	return EducateHelper.InTime(var_11_0, arg_11_0.startTime, arg_11_0.endTime)
end

function var_0_0.GetRemainTime(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 or getProxy(EducateProxy):GetCurTime()

	return EducateHelper.GetDaysBetweenTimes(var_12_0, arg_12_0.endTime)
end

function var_0_0.IsFinish(arg_13_0)
	return arg_13_0:GetProgress() >= arg_13_0:GetFinishNum()
end

function var_0_0.GetProgress(arg_14_0)
	return math.min(arg_14_0.progress, arg_14_0:GetFinishNum())
end

function var_0_0.GetFinishNum(arg_15_0)
	return arg_15_0:getConfig("arg")
end

function var_0_0.GetTargetProgress(arg_16_0)
	return arg_16_0:getConfig("task_target_progress")
end

function var_0_0.SetRecieve(arg_17_0)
	arg_17_0.isReceive = true
	arg_17_0.progress = arg_17_0:GetFinishNum()

	return
end

function var_0_0.IsReceive(arg_18_0)
	return arg_18_0.isReceive
end

function var_0_0.GetTaskStatus(arg_19_0)
	if arg_19_0:IsReceive() then
		return var_0_0.STATUS_RECEIVE
	end

	if arg_19_0:IsFinish() then
		return var_0_0.STATUS_FINISH
	end

	return var_0_0.STATUS_UNFINISH
end

function var_0_0.updateProgress(arg_20_0, arg_20_1)
	arg_20_0.progress = arg_20_1

	return
end

function var_0_0.GetAwardShow(arg_21_0)
	local var_21_0 = arg_21_0:getConfig("drop_display")

	return {
		type = var_21_0[1],
		id = var_21_0[2],
		number = var_21_0[3]
	}
end

return var_0_0
