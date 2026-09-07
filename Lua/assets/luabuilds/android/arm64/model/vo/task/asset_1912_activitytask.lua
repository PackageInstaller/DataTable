local ActivityTask = class("ActivityTask", import(".Task"))

function ActivityTask:Ctor(arg_1_1, arg_1_2)
	self.actId = arg_1_1
	self.id = arg_1_2.id
	self.configId = self.id
	self.progress = arg_1_2.progress or 0
	self.acceptTime = arg_1_2.accept_time or 0
	self.submitTime = arg_1_2.submit_time or 0
	self._isOver = false

	self:initConfig()

	return
end

function ActivityTask:isFinish()
	return self:getProgress() >= self:getConfig("target_num")
end

function ActivityTask:setOver()
	self._isOver = true
	self.progress = self:getConfig("target_num")

	return
end

function ActivityTask:isOver()
	return self._isOver
end

function ActivityTask:isActivitySubmit()
	if self.type == 16 and self.subType == 1006 then
		return true
	elseif self.type == 6 and self.subType == 1006 then
		return true
	end

	return false
end

function ActivityTask:getProgress()
	local var_6_0

	if self:isActivitySubmit() then
		local var_6_1 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[tonumber(self:getConfig("target_id"))].activity_id)

		if var_6_1 then
			var_6_0 = var_6_1:getVitemNumber((tonumber(self:getConfig("target_id_2"))))
		else
			warning("找不到活动数据中物品得的数量")

			var_6_0 = 0
		end
	elseif self.type == 6 and self.subType == TASK_SUB_TYPE_PT then
		local var_6_2 = getProxy(ActivityProxy):getActivityById((tonumber(self:getConfig("target_id_2"))))

		if var_6_2 then
			var_6_0 = var_6_2.data1 or 0
		else
			warning("找不到活动数据中物品得的数量", self.id)

			var_6_0 = 0
		end
	else
		var_6_0 = self.progress

		if self.progress > self:getConfig("target_num") then
			var_6_0 = self:getConfig("target_num")
		end
	end

	return var_6_0 or 0
end

function ActivityTask:getTarget()
	return self.target
end

function ActivityTask:isReceive()
	return false
end

function ActivityTask:isSubmit()
	if self.subType == 1006 then
		return true
	end

	return false
end

function ActivityTask:getTaskStatus()
	if self.progress >= self:getConfig("target_num") then
		return 1
	end

	return 0
end

function ActivityTask:onAdded()
	return
end

function ActivityTask:updateProgress(arg_12_1)
	self.progress = arg_12_1

	return
end

function ActivityTask:isSelectable()
	return false
end

function ActivityTask:judgeOverflow(arg_14_1, arg_14_2, arg_14_3)
	return false, false
end

function ActivityTask:IsUrTask()
	return false
end

function ActivityTask:GetRealType()
	return 6
end

function ActivityTask:isNew()
	if self:isFinish() or self:isOver() or self:isCircle() then
		return false
	end

	if self.actType == ActivityConst.ACTIVITY_TYPE_TASK_RYZA then
		if self.groupIndex ~= 1 then
			if PlayerPrefs.GetInt("ryza_task_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. self.id) ~= 1 then
				return true
			end
		end

		return false
	end

	return false
end

function ActivityTask:changeNew()
	if self.actType == ActivityConst.ACTIVITY_TYPE_TASK_RYZA and self.groupIndex ~= 1 then
		if PlayerPrefs.GetInt("ryza_task_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. self.id) ~= 1 then
			PlayerPrefs.SetInt("ryza_task_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. self.id, 1)
		end
	end

	return
end

function ActivityTask:ShowOnTaskScene()
	return false
end

function ActivityTask:getConfig(arg_20_1)
	return self.configData[arg_20_1]
end

function ActivityTask:isAvatarTask()
	return false
end

function ActivityTask:initConfig()
	self.actConfig = pg.activity_template[self.actId]
	self.actType = self.actConfig.type
	self.groups = Activity.Create({
		id = self.actId
	}):GetTaskIdsByDay()

	for iter_22_0 = 1, #self.groups do
		if table.contains(self.groups[iter_22_0], self.id) then
			self.groupIndex = iter_22_0
		end
	end

	self.configData = pg.task_data_template[self.id]
	self.target = self.configData.target_num
	self.type = self.configData.type
	self.subType = self.configData.sub_type
	self.targetId1 = self.configData.target_id
	self.targetId2 = self.configData.target_id_2
	self.autoCommit = self.configData.auto_commit == 1

	if self.actType == ActivityConst.ACTIVITY_TYPE_TASK_RYZA then
		-- block empty
	end

	return
end

return ActivityTask
