local WorldTask = class("WorldTask")

WorldTask.STATE_INACTIVE = 0
WorldTask.STATE_ONGOING = 1
WorldTask.STATE_FINISHED = 2
WorldTask.STATE_RECEIVED = 3

local var_0_1 = pg.world_task_data

function WorldTask:type2BgColor()
	WorldTask.Colors = WorldTask.Colors or {
		"yellow",
		"red",
		"blue",
		"orange",
		"green",
		"yellow"
	}

	return WorldTask.Colors[self + 1]
end

function WorldTask:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = arg_2_1.id
	self.progress = arg_2_1.progress or 0
	self.submiteTime = arg_2_1.submite_time or 0
	self.acceptTime = arg_2_1.accept_time or 0
	self.followingEntrance = arg_2_1.event_map_id or 0

	assert(var_0_1[self.configId], "unfound config......" .. self.configId)

	self.config = var_0_1[self.configId]
	self.new = arg_2_1.new or 0

	local var_2_0 = nowWorld()

	if self.config.complete_condition == WorldConst.TaskTypeSubmitItem then
		self:updateProgress(var_2_0:GetInventoryProxy():GetItemCount(self.config.complete_parameter[1]))
	elseif self.config.complete_condition == WorldConst.TaskTypePressingMap then
		self:updateProgress(var_2_0:GetTargetMapPressingCount(self.config.complete_parameter))
	end

	return
end

function WorldTask:DebugPrint()
	return string.format("任务 [%s] [id: %s] [状态: %s] [进度: %s/%s] [接受时间: %s] [完成时间: %s]", self.config.name, self.id, ({
		"未激活",
		"进行中",
		"已完成未提交",
		"已提交",
		"已过期"
	})[self:getState() + 1], self:getProgress(), self:getMaxProgress(), self.acceptTime, self.submiteTime)
end

function WorldTask:isNew()
	return self.new == 1
end

function WorldTask:getState()
	if self.acceptTime == 0 then
		return WorldTask.STATE_INACTIVE
	elseif self.submiteTime > 0 then
		return WorldTask.STATE_RECEIVED
	elseif self:getProgress() >= self:getMaxProgress() then
		return WorldTask.STATE_FINISHED
	else
		return WorldTask.STATE_ONGOING
	end

	return
end

function WorldTask:getMaxProgress()
	return self.config.complete_parameter_num
end

function WorldTask:updateProgress(arg_7_1)
	self.progress = arg_7_1

	return
end

function WorldTask:getProgress()
	return self.progress
end

function WorldTask:isAlive()
	local var_9_0 = self:getState()

	return var_9_0 == WorldTask.STATE_ONGOING or var_9_0 == WorldTask.STATE_FINISHED
end

function WorldTask:isFinished()
	return self:getState() == WorldTask.STATE_FINISHED
end

function WorldTask:isReceived()
	return self:getState() == WorldTask.STATE_RECEIVED
end

function WorldTask:canSubmit()
	if self:getState() ~= WorldTask.STATE_FINISHED then
		local var_12_1 = i18n("this task is not finish or is finished")

		return
	end

	return true
end

function WorldTask:commited()
	self.submiteTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function WorldTask:GetBgColor()
	return WorldTask.type2BgColor(self.config.type)
end

function WorldTask:GetDisplayDrops()
	local var_15_0 = {}

	_.each(self.config.show, function(arg_16_0)
		table.insert(var_15_0, {
			type = arg_16_0[1],
			id = arg_16_0[2],
			count = arg_16_0[3]
		})

		return
	end)

	return var_15_0
end

function WorldTask:GetFollowingAreaId()
	local var_17_0 = self.config.following_region[1]

	return self.config.following_region[1] and var_17_0 > 0 and var_17_0 or nil
end

local var_0_2 = {
	[0] = true,
	[true] = 6,
	[true] = 7
}

function WorldTask:GetFollowingEntrance()
	if var_0_2[self.config.type] then
		return self.config.following_map[1]
	else
		return (self.followingEntrance > 0 or nil) and (self.followingEntrance or nil)
	end

	return
end

function WorldTask:IsSpecialType()
	return self.config.type == 5
end

function WorldTask:IsTypeCollection()
	return self.config.type == 6
end

function WorldTask:IsLockMap()
	return self.config.target_map_lock == 1
end

function WorldTask:IsAutoSubmit()
	return self.config.auto_complete == 1
end

function WorldTask:canTrigger()
	local var_23_0 = nowWorld()
	local var_23_1 = WorldTask.New({
		id = self
	})
	local var_23_2 = var_23_0:GetTaskProxy()

	if var_23_2:getTaskById(self) then
		local var_23_4 = i18n("world_sametask_tip")

		return
	elseif var_23_0:GetLevel() < var_23_1.config.need_level then
		local var_23_6 = i18n1("舰队总等级需达到（缺gametip）" .. var_23_1.config.need_level)

		return
	elseif var_23_2.taskFinishCount < var_23_1.config.need_task_complete then
		local var_23_8 = i18n1("任务完成数需达到（缺gametip）" .. var_23_1.config.need_task_complete)

		return
	end

	return true
end

WorldTask.taskSortOrder = {
	[WorldTask.STATE_INACTIVE] = 2,
	[WorldTask.STATE_ONGOING] = 1,
	[WorldTask.STATE_FINISHED] = 0,
	[WorldTask.STATE_RECEIVED] = 3
}
WorldTask.sortDic = {
	function(arg_24_0)
		return WorldTask.taskSortOrder[arg_24_0:getState()]
	end,
	function(arg_25_0)
		return arg_25_0.config.type
	end,
	function(arg_26_0)
		return -arg_26_0.config.priority
	end,
	function(arg_27_0)
		return arg_27_0.id
	end
}

return WorldTask
