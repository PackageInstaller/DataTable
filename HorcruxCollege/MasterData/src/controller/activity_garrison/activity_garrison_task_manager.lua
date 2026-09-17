local ActivityGarrisonTaskManager = class("ActivityGarrisonTaskManager", (require("controller.base_manager")))

ActivityGarrisonTaskManager.MULTITON_MSG = "ActivityGarrisonTaskManager instancealready constructed!"

function ActivityGarrisonTaskManager:ctor()
	ActivityGarrisonTaskManager.super.ctor(self)

	self._data = {}
end

function ActivityGarrisonTaskManager:requestInfo(arg_2_1, arg_2_2)
	require("controller/activity_manager"):getActivityObj(arg_2_1):getActivityTaskList(nil, function(arg_3_0, arg_3_1)
		if arg_3_0 == 1 then
			self:handlerInfo(arg_2_1, arg_3_1)
		end
	end, false, nil, "garrison")
end

function ActivityGarrisonTaskManager:requestGetReward(arg_4_1, arg_4_2)
	require("controller/activity_manager"):getActivityObj(arg_4_1):getTaskReward(arg_4_2, function(arg_5_0, arg_5_1)
		if arg_5_0 == 1 then
			if self._data[arg_4_1] then
				for iter_5_0, iter_5_1 in pairs(self._data[arg_4_1]) do
					if iter_5_1.taskid == arg_4_2 then
						iter_5_1.status = 1

						break
					end
				end
			end

			global_get(arg_5_1)
			sendNotification("ActivityGarrisonTaskGetReward")
		end
	end)
end

function ActivityGarrisonTaskManager:requestGetAllReward(arg_6_1)
	require("controller/activity_manager"):getActivityObj(arg_6_1):getActivityTaskList(nil, function(arg_7_0, arg_7_1)
		if arg_7_0 == 1 then
			self._data[arg_6_1] = arg_7_1.list

			for iter_7_0, iter_7_1 in pairs(self._data[arg_6_1]) do
				if iter_7_1.percent and iter_7_1.percent == 100 then
					iter_7_1.status = 1
				end
			end

			global_get(arg_7_1)
			sendNotification("ActivityGarrisonTaskGetReward")
		end
	end, true, nil, "garrison")
end

function ActivityGarrisonTaskManager:getTaskInfo(arg_8_1)
	if self._data[arg_8_1] then
		table.sort(self._data[arg_8_1], function(arg_9_0, arg_9_1)
			if arg_9_0.status ~= arg_9_1.status then
				return arg_9_0.status < arg_9_1.status
			elseif arg_9_0.status ~= 0 then
				return arg_9_0.taskid < arg_9_1.taskid
			else
				local var_9_0 = arg_9_0.percent
				local var_9_1 = arg_9_1.percent

				if arg_9_0.percent and var_9_1 and var_9_0 ~= var_9_1 then
					return var_9_1 < var_9_0
				else
					return arg_9_0.taskid < arg_9_1.taskid
				end
			end
		end)

		return self._data[arg_8_1]
	else
		return {}
	end
end

function ActivityGarrisonTaskManager:getTaskProgress(arg_10_1)
	if self._data[arg_10_1] then
		local var_10_0 = 0
		local var_10_1 = 0

		for iter_10_0, iter_10_1 in pairs(self._data[arg_10_1]) do
			var_10_1 = var_10_1 + 1

			if iter_10_1.status ~= 0 then
				var_10_0 = var_10_0 + 1
			end
		end

		return var_10_0, var_10_1
	end

	return 0, 0
end

function ActivityGarrisonTaskManager:handlerInfo(arg_11_1, arg_11_2)
	if arg_11_2.result ~= 1 then
		return
	end

	self._data[arg_11_1] = arg_11_2.list

	self:updateLayer()
end

function ActivityGarrisonTaskManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function ActivityGarrisonTaskManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return ActivityGarrisonTaskManager
