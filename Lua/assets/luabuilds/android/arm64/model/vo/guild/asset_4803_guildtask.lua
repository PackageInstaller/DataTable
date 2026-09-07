local GuildTask = class("GuildTask", import("..BaseVO"))

GuildTask.STATE_EMPTY = 0
GuildTask.STATE_ONGOING = 2
GuildTask.STATE_FINISHED = 3
GuildTask.PRIVATE_TASK_TYPE_EVENT = {
	400
}
GuildTask.PRIVATE_TASK_TYPE_BATTLE = {
	20,
	11
}

function GuildTask:Ctor(arg_1_1)
	self.id = arg_1_1.id or 0
	self.configId = self.id
	self.progress = arg_1_1.progress or 0

	local var_1_0 = arg_1_1.monday_0clock or 0

	self.endTime = 0

	if var_1_0 > 0 then
		self.endTime = var_1_0 + 0
	end

	return
end

function GuildTask:bindConfigTable()
	return pg.guild_mission_template
end

function GuildTask:GetLivenessAddition()
	return self:getConfig("guild_active")
end

function GuildTask:isExpire()
	return self.endTime > 0 and self:isEnd()
end

function GuildTask:getProgress()
	return self.progress
end

function GuildTask:updateProgress(arg_6_1)
	self.progress = arg_6_1

	return
end

function GuildTask:isEnd()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.endTime
end

function GuildTask:getState()
	if self.id == 0 or self:isEnd() then
		return GuildTask.STATE_EMPTY
	elseif self:isFinished() then
		return GuildTask.STATE_FINISHED
	else
		return GuildTask.STATE_ONGOING
	end

	return
end

function GuildTask:GetPresonTaskId()
	return self:getConfig("task_id")
end

function GuildTask:GetPrivateTaskName()
	return pg.task_data_template[self:GetPresonTaskId()].desc
end

function GuildTask:IsSamePrivateTask(arg_11_1)
	return arg_11_1 and arg_11_1.id == self:GetPresonTaskId()
end

function GuildTask:isFinished()
	return self.progress >= self:getMaxProgress()
end

function GuildTask:getMaxProgress()
	return self:getConfig("max_num")
end

function GuildTask:isRemind(arg_14_1)
	return self:getConfig("warning_time")[arg_14_1] >= pg.TimeMgr.GetInstance():GetServerWeek()
end

function GuildTask:GetScale()
	return self:getConfig("task_scale")
end

function GuildTask:GetDesc()
	return self:getConfig("name")
end

function GuildTask:GetPrivateAward()
	return self:getConfig("award_display")
end

function GuildTask:GetCaptailAward()
	return self:getConfig("award_capital_display") * self:getMaxProgress()
end

function GuildTask:GetCurrCaptailAward()
	return self.progress * self:getConfig("award_capital_display")
end

function GuildTask:PrivateBeFinished()
	if GuildTask.STATE_ONGOING == self:getState() then
		local var_20_0 = self:GetPresonTaskId()
		local var_20_1 = getProxy(TaskProxy)
		local var_20_2 = var_20_1:getTaskById(var_20_0) or var_20_1:getFinishTaskById(var_20_0)

		return var_20_2 and var_20_2:isFinish() and not var_20_2:isReceive()
	end

	return false
end

function GuildTask:SamePrivateTaskType(arg_21_1)
	local var_21_0 = pg.task_data_template[self:GetPresonTaskId()].sub_type

	return _.any(arg_21_1, function(arg_22_0)
		return arg_22_0 == var_21_0
	end)
end

return GuildTask
