local TotalTaskProxy = class("TotalTaskProxy", import(".NetProxy"))

TotalTaskProxy.act_task_onece_type = {
	6,
	26
}
TotalTaskProxy.avatar_task_type = {
	ActivityConst.ACTIVITY_TYPE_PT_OTHER
}
TotalTaskProxy.activity_task_type = {
	ActivityConst.ACTIVITY_TYPE_TASK_RYZA,
	ActivityConst.ACTIVITY_TYPE_HOTSPRING_2,
	ActivityConst.ACTIVITY_TYPE_NOT_TRACEABLE
}
TotalTaskProxy.normal_task_type = {
	ActivityConst.ACTIVITY_TYPE_TASKS,
	ActivityConst.ACTIVITY_TYPE_PT_CRUSING,
	ActivityConst.ACTIVITY_TYPE_PT_HEI5,
	ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB
}

function TotalTaskProxy:register()
	self.avatarFrames = {}
	self.actTasks = {}

	self:on(20201, function(arg_2_0)
		getProxy(AvatarFrameProxy):clearData()
		getProxy(ActivityTaskProxy):clearData()

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.info) do
			if table.contains(TotalTaskProxy.avatar_task_type, pg.activity_template[iter_2_1.act_id].type) then
				getProxy(AvatarFrameProxy):initListData(iter_2_1.act_id, iter_2_1.tasks, iter_2_1.finish_ids)
			elseif table.contains(TotalTaskProxy.activity_task_type, pg.activity_template[iter_2_1.act_id].type) then
				getProxy(ActivityTaskProxy):initActList(iter_2_1.act_id, iter_2_1.tasks, iter_2_1.finish_ids)
			elseif table.contains(TotalTaskProxy.normal_task_type, pg.activity_template[iter_2_1.act_id].type) then
				getProxy(TaskProxy):initActData(iter_2_1.act_id, iter_2_1.tasks, iter_2_1.finish_ids)
			end
		end

		return
	end)
	self:on(20202, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.info) do
			local var_3_0 = iter_3_1.act_id

			if table.contains(TotalTaskProxy.avatar_task_type, pg.activity_template[iter_3_1.act_id].type) then
				getProxy(AvatarFrameProxy):update(var_3_0, iter_3_1.tasks)
			elseif table.contains(TotalTaskProxy.activity_task_type, pg.activity_template[iter_3_1.act_id].type) then
				getProxy(ActivityTaskProxy):updateActList(var_3_0, iter_3_1.tasks)
			elseif table.contains(TotalTaskProxy.normal_task_type, pg.activity_template[iter_3_1.act_id].type) then
				getProxy(TaskProxy):updateActProgress(var_3_0, iter_3_1.tasks)
			end

			self:sendNotification(ActivityProxy.ACTIVITY_UPDATED, getProxy(ActivityProxy):getActivityById(var_3_0):clone())
		end

		self.facade:sendNotification(GAME.TOTAL_TASK_UPDATED)

		return
	end)
	self:on(20203, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.info) do
			local var_4_0 = iter_4_1.act_id

			if table.contains(TotalTaskProxy.avatar_task_type, pg.activity_template[iter_4_1.act_id].type) then
				getProxy(AvatarFrameProxy):addData(var_4_0, iter_4_1.tasks)
			elseif table.contains(TotalTaskProxy.activity_task_type, pg.activity_template[iter_4_1.act_id].type) then
				getProxy(ActivityTaskProxy):addActList(var_4_0, iter_4_1.tasks)
			elseif table.contains(TotalTaskProxy.normal_task_type, pg.activity_template[iter_4_1.act_id].type) then
				getProxy(TaskProxy):addActData(var_4_0, iter_4_1.tasks)
			end

			self:sendNotification(ActivityProxy.ACTIVITY_UPDATED, getProxy(ActivityProxy):getActivityById(var_4_0):clone())
		end

		self.facade:sendNotification(GAME.TOTAL_TASK_UPDATED)

		return
	end)
	self:on(20204, function(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.info) do
			local var_5_0 = iter_5_1.act_id

			if table.contains(TotalTaskProxy.avatar_task_type, pg.activity_template[iter_5_1.act_id].type) then
				getProxy(AvatarFrameProxy):removeData(var_5_0, iter_5_1.tasks)
			elseif table.contains(TotalTaskProxy.activity_task_type, pg.activity_template[iter_5_1.act_id].type) then
				getProxy(ActivityTaskProxy):removeActList(var_5_0, iter_5_1.tasks)
			elseif table.contains(TotalTaskProxy.normal_task_type, pg.activity_template[iter_5_1.act_id].type) then
				getProxy(TaskProxy):removeActData(var_5_0, iter_5_1.tasks)
			end

			self:sendNotification(ActivityProxy.ACTIVITY_UPDATED, getProxy(ActivityProxy):getActivityById(var_5_0):clone())
		end

		self.facade:sendNotification(GAME.TOTAL_TASK_UPDATED)

		return
	end)

	return
end

function TotalTaskProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_7_0)
			self:clearTimeOut()

			return
		end
	}
end

function TotalTaskProxy:clearTimeOut()
	getProxy(AvatarFrameProxy):clearTimeOut()
	getProxy(TaskProxy):clearTimeOut()

	return
end

return TotalTaskProxy
