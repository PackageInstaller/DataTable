local EducateTask = class("EducateTask", import("model.vo.BaseVO"))

EducateTask.SYSTEM_TYPE_MIND = 1
EducateTask.SYSTEM_TYPE_TARGET = 2
EducateTask.STSTEM_TYPE_MAIN = 3
EducateTask.TYPE_PLAN = 1
EducateTask.TYPE_ATTR = 2
EducateTask.TYPE_SITE_COST = 3
EducateTask.TYPE_PURCHASE = 4
EducateTask.TYPE_SITE_ENTER = 5
EducateTask.TYPE_TARGET = 6
EducateTask.TYPE_PERFORM = 7
EducateTask.TYPE_ITEM = 8
EducateTask.TYPE_TASK = 9
EducateTask.TYPE_SCHEDULE = 10
EducateTask.STATUS_UNFINISH = 0
EducateTask.STATUS_FINISH = 1
EducateTask.STATUS_RECEIVE = 2

function EducateTask:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.progress = arg_1_1.progress or 0

	if self.progress < 1 then
		self.status = EducateTask.STATUS_UNFINISH or EducateTask.STATUS_FINISH
	end

	self:initCfgTime()

	return
end

function EducateTask:bindConfigTable()
	return pg.child_task
end

function EducateTask:initCfgTime()
	self.startTime, self.endTime = EducateHelper.CfgTime2Time((self:getConfig("time_limit")))

	return
end

function EducateTask:GetSystemType()
	return self:getConfig("type_1")
end

function EducateTask:GetType()
	return self:getConfig("type_2")
end

function EducateTask:IsMind()
	return self:GetSystemType() == EducateTask.SYSTEM_TYPE_MIND
end

function EducateTask:IsTarget()
	return self:GetSystemType() == EducateTask.SYSTEM_TYPE_TARGET
end

function EducateTask:IsMain()
	return self:GetSystemType() == EducateTask.STSTEM_TYPE_MAIN
end

function EducateTask:NeedAddProgressFromSiteEnter()
	return self:GetType() == EducateTask.TYPE_SITE_ENTER and not self:IsFinish()
end

function EducateTask:NeedAddProgressFromPerform()
	return self:GetType() == EducateTask.TYPE_PERFORM and not self:IsFinish()
end

function EducateTask:InTime(arg_11_1)
	return EducateHelper.InTime(arg_11_1 or getProxy(EducateProxy):GetCurTime(), self.startTime, self.endTime)
end

function EducateTask:GetRemainTime(arg_12_1)
	return EducateHelper.GetDaysBetweenTimes(arg_12_1 or getProxy(EducateProxy):GetCurTime(), self.endTime)
end

function EducateTask:IsFinish()
	return self:GetProgress() >= self:GetFinishNum()
end

function EducateTask:GetProgress()
	return math.min(self.progress, self:GetFinishNum())
end

function EducateTask:GetFinishNum()
	return self:getConfig("arg")
end

function EducateTask:GetTargetProgress()
	return self:getConfig("task_target_progress")
end

function EducateTask:SetRecieve()
	self.isReceive = true
	self.progress = self:GetFinishNum()

	return
end

function EducateTask:IsReceive()
	return self.isReceive
end

function EducateTask:GetTaskStatus()
	if self:IsReceive() then
		return EducateTask.STATUS_RECEIVE
	end

	if self:IsFinish() then
		return EducateTask.STATUS_FINISH
	end

	return EducateTask.STATUS_UNFINISH
end

function EducateTask:updateProgress(arg_20_1)
	self.progress = arg_20_1

	return
end

function EducateTask:GetAwardShow()
	local var_21_0 = self:getConfig("drop_display")

	return {
		type = var_21_0[1],
		id = var_21_0[2],
		number = var_21_0[3]
	}
end

return EducateTask
