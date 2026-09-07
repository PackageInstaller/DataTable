local AvatarFrameProxy = class("AvatarFrameProxy", import(".NetProxy"))

AvatarFrameProxy.FRAME_TASK_UPDATED = "frame task updated"
AvatarFrameProxy.FRAME_TASK_TIME_OUT = "frame task time out"

function AvatarFrameProxy:register()
	self.avatarFrames = {}

	return
end

function AvatarFrameProxy:clearData()
	self.avatarFrames = {}

	return
end

function AvatarFrameProxy:initListData(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		table.insert(var_3_0, (self:createAvatarFrameTask(arg_3_1, iter_3_1)))
	end

	if arg_3_3 and #arg_3_3 then
		for iter_3_2, iter_3_3 in ipairs(arg_3_3) do
			local var_3_2 = self:createAvatarFrameTask(arg_3_1, {
				id = iter_3_3
			})

			var_3_2:setTaskFinish()
			table.insert(var_3_1, var_3_2)
		end
	end

	table.insert(self.avatarFrames, {
		actId = arg_3_1,
		tasks = var_3_0,
		finish_tasks = var_3_1
	})

	return
end

function AvatarFrameProxy:update(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		self:updateAvatarTask(arg_4_1, iter_4_1)
	end

	self.facade:sendNotification(AvatarFrameProxy.FRAME_TASK_UPDATED)

	return
end

function AvatarFrameProxy:addData(arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		self:addAvatarTask(arg_5_1, (self:createAvatarFrameTask(arg_5_1, iter_5_1)))
	end

	self.facade:sendNotification(AvatarFrameProxy.FRAME_TASK_UPDATED)

	return
end

function AvatarFrameProxy:removeData(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		self:removeAvatarTask(arg_6_1, iter_6_1.id)
	end

	self.facade:sendNotification(AvatarFrameProxy.FRAME_TASK_UPDATED)

	return
end

function AvatarFrameProxy:createAvatarFrameTask(arg_7_1, arg_7_2)
	return (AvatarFrameTask.New(arg_7_1, pg.activity_template[arg_7_1].config_id, arg_7_2))
end

function AvatarFrameProxy:updateAvatarTask(arg_8_1, arg_8_2)
	for iter_8_0 = 1, #self.avatarFrames do
		if self.avatarFrames[iter_8_0].actId == arg_8_1 then
			for iter_8_1 = #self.avatarFrames[iter_8_0].tasks, 1, -1 do
				if self.avatarFrames[iter_8_0].tasks[iter_8_1].id == arg_8_2.id then
					self.avatarFrames[iter_8_0].tasks[iter_8_1]:updateProgress(arg_8_2.progress)
				end
			end
		end
	end

	return
end

function AvatarFrameProxy:addAvatarTask(arg_9_1, arg_9_2)
	for iter_9_0 = 1, #self.avatarFrames do
		if self.avatarFrames[iter_9_0].actId == arg_9_1 then
			for iter_9_1 = #self.avatarFrames[iter_9_0].tasks, 1, -1 do
				if self.avatarFrames[iter_9_0].tasks[iter_9_1].id == arg_9_2.id then
					table.remove(self.avatarFrames[iter_9_0].tasks, iter_9_1)
				end
			end

			table.insert(self.avatarFrames[iter_9_0].tasks, arg_9_2)
		end
	end

	return
end

function AvatarFrameProxy:removeAvatarTask(arg_10_1, arg_10_2)
	for iter_10_0 = 1, #self.avatarFrames do
		if self.avatarFrames[iter_10_0].actId == arg_10_1 then
			for iter_10_1 = #self.avatarFrames[iter_10_0].tasks, 1, -1 do
				if self.avatarFrames[iter_10_0].tasks[iter_10_1].id == arg_10_2 then
					table.remove(self.avatarFrames[iter_10_0].tasks, iter_10_1)
				end
			end
		end
	end

	return
end

function AvatarFrameProxy:getAvatarFrameById(arg_11_1)
	for iter_11_0 = 1, #self.avatarFrames do
		if self.avatarFrames[iter_11_0].actId == arg_11_1 then
			return Clone(self.avatarFrames[iter_11_0])
		end
	end

	return nil
end

function AvatarFrameProxy:getAllAvatarFrame()
	return Clone(self.avatarFrames)
end

function AvatarFrameProxy:getCanReceiveCount()
	local var_13_0 = 0

	for iter_13_0 = 1, #self.avatarFrames do
		for iter_13_1, iter_13_2 in ipairs(self.avatarFrames[iter_13_0].tasks) do
			if iter_13_2:getTaskStatus() == 1 then
				var_13_0 = var_13_0 + 1
			end
		end
	end

	return var_13_0
end

function AvatarFrameProxy:clearTimeOut()
	if not self.avatarFrames or #self.avatarFrames == 0 then
		return
	end

	local var_14_0 = false

	for iter_14_0 = #self.avatarFrames, 1, -1 do
		local var_14_1 = getProxy(ActivityProxy):getActivityById(self.avatarFrames[iter_14_0].actId)

		if not var_14_1 or var_14_1:isEnd() then
			table.remove(self.avatarFrames, iter_14_0)

			var_14_0 = true
		end
	end

	if var_14_0 then
		self.facade:sendNotification(AvatarFrameProxy.FRAME_TASK_UPDATED)
		self.facade:sendNotification(AvatarFrameProxy.FRAME_TASK_TIME_OUT)
	end

	return
end

return AvatarFrameProxy
