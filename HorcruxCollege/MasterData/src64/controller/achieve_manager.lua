local var_0_0 = {}
local network = require("network.network")
local task_manager = require("controller.task_manager")
local achieve_task_index_data = require("data.achieve_task_index_data")
local task_data = require("data.task_data")
local var_0_5 = {
	GROWTH = 11,
	RESOURCES = 9,
	ITEM = 7,
	ROLE = 6,
	CHALLENGE = 10,
	MOVE = 8
}

function var_0_0.get_achieve_class_data(arg_1_0)
	return var_0_5
end

function var_0_0.get_task_info(arg_2_0, arg_2_1)
	network:rpc("get_task_info", nil, function(arg_3_0)
		task_manager:generate_task_params(arg_3_0.taskinfo)
		task_manager:generate_task_info()
		arg_2_0:generate_task_info()

		if arg_2_1 then
			arg_2_1()
		end
	end)
end

function var_0_0:generate_task_info()
	self.achieves = {}
	self.achievefinished = {}
	self.achieve_type_len = {}

	for iter_4_0, iter_4_1 in pairs(var_0_5) do
		self.achieves[iter_4_1] = {}
		self.achievefinished[iter_4_1] = {}
		self.achieve_type_len[iter_4_1] = 0
	end

	for iter_4_2, iter_4_3 in pairs(achieve_task_index_data) do
		if iter_4_3.valid and task_manager:check_task_time(iter_4_3) then
			local var_4_0 = iter_4_3.child_type

			if not iter_4_3.child_type then
				hx_print("taskid " .. iter_4_3.taskid .. " index :" .. iter_4_2 .. " child_type is nil")
			end

			if task_manager:is_task_finished(task_manager.taskinfo[TASK_TYPE_ACHIEVE], iter_4_3.id) then
				table.insert(self.achievefinished[var_4_0], iter_4_3.taskid)
			elseif task_manager:can_task_triggered(iter_4_3.taskid) then
				table.insert(self.achieves[var_4_0], task_manager:cal_task_stat(iter_4_3.taskid))
			end

			self.achieve_type_len[var_4_0] = self.achieve_type_len[var_4_0] + 1
		end
	end

	for iter_4_4, iter_4_5 in pairs(var_0_5) do
		table.sort(self.achieves[iter_4_5], function(arg_5_0, arg_5_1)
			if arg_5_0.percent >= 100 and arg_5_1.percent >= 100 or arg_5_0.percent < 100 and arg_5_1.percent < 100 then
				return arg_5_0.order < arg_5_1.order
			else
				return arg_5_0.percent >= 100 and arg_5_1.percent < 100
			end
		end)
	end
end

function var_0_0:isHaveReward(arg_6_1)
	if not self.achieves then
		return false
	end

	if next(self.achieves) == nil then
		return false
	end

	for iter_6_0, iter_6_1 in pairs(self.achieves[arg_6_1]) do
		if iter_6_1.percent >= 100 then
			return true
		end
	end

	return false
end

function var_0_0:getTaskListLen(arg_7_1)
	print(arg_7_1)

	return #self.achieves[arg_7_1] + #self.achievefinished[arg_7_1]
end

function var_0_0:getTaskFinishLen(arg_8_1)
	return #self.achievefinished[arg_8_1]
end

function var_0_0:getTaskListMaxLen(arg_9_1)
	return self.achieve_type_len[arg_9_1]
end

function var_0_0:dequeueTaskInfo(arg_10_1, arg_10_2)
	if arg_10_2 <= #self.achieves[arg_10_1] then
		return self.achieves[arg_10_1][arg_10_2]
	else
		return self.achievefinished[arg_10_1][arg_10_2 - #self.achieves[arg_10_1]]
	end
end

function var_0_0.getTaskReward(arg_11_0, arg_11_1, arg_11_2)
	network:rpc("get_task_reward", {
		taskid = arg_11_1
	}, function(arg_12_0)
		if arg_12_0.result == 1 then
			task_manager:switch_to_finished(arg_11_1)
			arg_11_0:updateOnFinishTask(arg_11_1)
			AnalyticManager.taskSuccess(arg_12_0.gold, arg_12_0.diamond)

			if task_data[arg_11_1].task_type == 2 then
				AnalyticManager.gain_daily_task_reward({
					taskid = arg_11_1,
					class = playerModel.class,
					level = playerModel.grade,
					role_num = playerModel:getHavedServantNum()
				})
			end

			AnalyticManager.completeTask({
				tasktype = task_data[arg_11_1].task_type,
				taskid = arg_11_1
			})
			AnalyticManager.onTaskFinish(arg_11_1)

			if arg_11_2 then
				arg_11_2(1, arg_12_0)
			end
		elseif arg_11_2 then
			arg_11_2(0)
		end
	end)
end

function var_0_0.getTaskRewardOneKey(arg_13_0, arg_13_1, arg_13_2)
	network:rpc("get_task_reward_onekey", {
		tasktype = TASK_TYPE_ACHIEVE,
		childtype = arg_13_1
	}, function(arg_14_0)
		print(dump(arg_14_0))

		if arg_14_0.result == 1 then
			for iter_14_0, iter_14_1 in pairs(arg_14_0.finish_ids) do
				task_manager:switch_to_finished(iter_14_1)
				arg_13_0:updateOnFinishTask(iter_14_1)
				AnalyticManager.taskSuccess(arg_14_0.gold, arg_14_0.diamond)

				if task_data[iter_14_1].task_type == 2 then
					AnalyticManager.gain_daily_task_reward({
						taskid = iter_14_1,
						class = playerModel.class,
						level = playerModel.grade,
						role_num = playerModel:getHavedServantNum()
					})
				end

				AnalyticManager.completeTask({
					tasktype = task_data[iter_14_1].task_type,
					taskid = iter_14_1
				})
			end

			if arg_13_2 then
				arg_13_2(1, arg_14_0)
			end
		elseif arg_14_0.result == 2 then
			global_ShowBlockWords(TASK_REWARD_ONEKEY_WARN)

			if arg_13_2 then
				arg_13_2(2)
			end
		elseif arg_13_2 then
			arg_13_2(0)
		end
	end)
end

function var_0_0:updateOnFinishTask(arg_15_1)
	local var_15_0 = task_data[arg_15_1]
	local var_15_1 = achieve_task_index_data[task_data[arg_15_1].index]

	for iter_15_0, iter_15_1 in ipairs(task_manager.tasks[task_data[arg_15_1].task_type]) do
		if iter_15_1.taskid == arg_15_1 then
			table.remove(task_manager.tasks[task_data[arg_15_1].task_type], iter_15_0)

			break
		end
	end

	for iter_15_2, iter_15_3 in ipairs(self.achieves[achieve_task_index_data[task_data[arg_15_1].index].child_type]) do
		if iter_15_3.taskid == arg_15_1 then
			table.remove(self.achieves[achieve_task_index_data[task_data[arg_15_1].index].child_type], iter_15_2)

			break
		end
	end

	table.insert(task_manager.taskfinised[task_data[arg_15_1].task_type], arg_15_1)
	table.insert(self.achievefinished[achieve_task_index_data[task_data[arg_15_1].index].child_type], arg_15_1)

	local var_15_2, var_15_3 = task_manager:trigger_continue_task(task_data[arg_15_1].continue_task)

	if var_15_2 then
		local function var_15_4(arg_16_0)
			local var_16_0 = task_manager.tasks[var_15_0.task_type]
			local var_16_1 = 1
			local var_16_2 = arg_16_0.order
			local var_16_3 = arg_16_0.percent

			while var_16_1 <= #task_manager.tasks[var_15_0.task_type] do
				local var_16_4 = math.floor(var_16_1 + (#task_manager.tasks[var_15_0.task_type] - var_16_1) / 2)

				if var_16_0[var_16_4 - 1] then
					local var_16_5 = var_16_0[var_16_4 - 1].percent or var_16_0[1].percent

					if var_16_0[var_16_4] then
						local var_16_6 = var_16_0[var_16_4].percent or var_16_0[#var_16_0].percent

						if var_16_3 == var_16_5 and var_16_3 == var_16_6 then
							var_16_5 = var_16_0[var_16_4 - 1] and var_16_0[var_16_4 - 1].order or var_16_0[1].order
							var_16_6 = var_16_0[var_16_4] and var_16_0[var_16_4].order or var_16_0[#var_16_0].order

							local var_16_7

							if var_16_5 <= var_16_2 and var_16_2 <= var_16_6 then
								return var_16_4
							elseif var_16_2 < var_16_5 then
								var_16_7 = var_16_4 - 1
							else
								var_16_1 = var_16_4 + 1
							end
						elseif var_16_3 <= var_16_5 and var_16_6 <= var_16_3 then
							return var_16_4
						elseif var_16_5 < var_16_3 then
							var_16_7 = var_16_4 - 1
						end
					end
				end

				var_16_1 = var_16_4 + 1
			end

			if var_16_1 <= 1 then
				return 1
			end

			return #var_16_0 + 1
		end

		local function var_15_5(arg_17_0)
			local var_17_0 = self.achieves[var_15_1.child_type]
			local var_17_1 = 1
			local var_17_2 = arg_17_0.order
			local var_17_3 = arg_17_0.percent

			while var_17_1 <= #self.achieves[var_15_1.child_type] do
				local var_17_4 = math.floor(var_17_1 + (#self.achieves[var_15_1.child_type] - var_17_1) / 2)

				if var_17_0[var_17_4 - 1] then
					local var_17_5 = var_17_0[var_17_4 - 1].percent or var_17_0[1].percent

					if var_17_0[var_17_4] then
						local var_17_6 = var_17_0[var_17_4].percent or var_17_0[#var_17_0].percent

						if var_17_3 == var_17_5 and var_17_3 == var_17_6 then
							var_17_5 = var_17_0[var_17_4 - 1] and var_17_0[var_17_4 - 1].order or var_17_0[1].order
							var_17_6 = var_17_0[var_17_4] and var_17_0[var_17_4].order or var_17_0[#var_17_0].order

							local var_17_7

							if var_17_5 <= var_17_2 and var_17_2 <= var_17_6 then
								return var_17_4
							elseif var_17_2 < var_17_5 then
								var_17_7 = var_17_4 - 1
							else
								var_17_1 = var_17_4 + 1
							end
						elseif var_17_3 <= var_17_5 and var_17_6 <= var_17_3 then
							return var_17_4
						elseif var_17_5 < var_17_3 then
							var_17_7 = var_17_4 - 1
						end
					end
				end

				var_17_1 = var_17_4 + 1
			end

			if var_17_1 <= 1 then
				return 1
			end

			return #var_17_0 + 1
		end

		for iter_15_4, iter_15_5 in ipairs(var_15_3) do
			local var_15_6 = var_15_4(iter_15_5)

			table.insert(task_manager.tasks[task_data[arg_15_1].task_type], var_15_6, iter_15_5)

			local var_15_7 = var_15_5(iter_15_5)

			table.insert(self.achieves[achieve_task_index_data[task_data[arg_15_1].index].child_type], var_15_6, iter_15_5)
		end
	end
end

return var_0_0
