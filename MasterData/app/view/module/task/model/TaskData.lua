local var_0_0 = g.core.const.ConstMgr.TaskConst
local var_0_1 = "reward_type_"
local var_0_2 = "reward_value_"
local var_0_3 = "reward_size_"
local TaskData = class("TaskData")
local var_0_5 = g.core.config.action_task_info

function TaskData:ctor()
	self:initData()
end

function TaskData:initData()
	self._taskMap = {}
	self._taskCfgMap = {}
end

function TaskData:onS2CFlushRedPoint(arg_3_1)
	if not arg_3_1.module_task_hints then
		return
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.module_task_hints) do
		self:onS2CGetModuleTaskInfo(iter_3_1)
	end
end

function TaskData:onS2CGetModuleTaskInfo(arg_4_1)
	local var_4_0 = arg_4_1.common_awards or {}
	local var_4_1 = arg_4_1.daily_awards or {}
	local var_4_2 = arg_4_1.weekly_awards or {}
	local var_4_3 = {}

	table.insertto(var_4_3, var_4_0, 0)
	table.insertto(var_4_3, var_4_1, 0)
	table.insertto(var_4_3, var_4_2, 0)

	self._taskMap[arg_4_1.module_id] = {
		commonTasks = self:_taskArr2Dict(arg_4_1.common_tasks),
		dailyTasks = self:_taskArr2Dict(arg_4_1.daily_tasks),
		weekTasks = self:_taskArr2Dict(arg_4_1.weekly_tasks),
		commonAwards = self:_awardArr2Dict(var_4_0),
		dailyAwards = self:_awardArr2Dict(var_4_1),
		weeklyAwards = self:_awardArr2Dict(var_4_2),
		receiveIdList = self:_awardArr2Dict(var_4_3)
	}
end

function TaskData:onS2CGetModuleTaskAward(arg_5_1)
	local var_5_0 = var_0_5.get(arg_5_1)

	self._taskMap[var_5_0.module].receiveIdList[arg_5_1] = true

	local var_5_1, var_5_2 = self:getTaskDictAwardDict(var_5_0.module, var_5_0.reset_time)

	var_5_2[arg_5_1] = true
end

function TaskData:onS2CGetModuleOneKeyTaskAward(arg_6_1)
	return
end

function TaskData:getTaskInfoByModuleId(arg_7_1)
	local var_7_0 = self._taskMap[arg_7_1]

	if not self._taskMap[arg_7_1] then
		var_7_0 = {
			commonTasks = {},
			dailyTasks = {},
			weekTasks = {},
			commonAwards = {},
			dailyAwards = {},
			weeklyAwards = {},
			receiveIdList = {}
		}
		self._taskMap[arg_7_1] = var_7_0
	end

	return var_7_0
end

function TaskData:getTaskCfgArrByModuleId(arg_8_1)
	self._taskCfgMap[arg_8_1] = self._taskCfgMap[arg_8_1] or var_0_5.match(function(arg_9_0)
		return arg_9_0.module == arg_8_1
	end)

	return self._taskCfgMap[arg_8_1]
end

function TaskData:_taskArr2Dict(arg_10_1)
	arg_10_1 = arg_10_1 or {}

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		var_10_0[iter_10_1.type] = iter_10_1.value
	end

	return var_10_0
end

function TaskData:_awardArr2Dict(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		var_11_0[iter_11_1] = true
	end

	return var_11_0
end

function TaskData:getTaskState(arg_12_1)
	local var_12_0, var_12_1 = self:getTaskDictAwardDict(arg_12_1.module, arg_12_1.reset_time)

	if var_12_1[arg_12_1.id] then
		return var_0_0.TASK_STATE.ACCEPTED
	elseif (var_12_0[arg_12_1.require_type] or 0) >= arg_12_1.require_value then
		return var_0_0.TASK_STATE.CAN_ACCEPT
	else
		return var_0_0.TASK_STATE.UNFINISHED
	end
end

function TaskData:getTaskDictAwardDict(arg_13_1, arg_13_2)
	local var_13_0 = self:getTaskInfoByModuleId(arg_13_1)

	if arg_13_2 == var_0_0.RESET_TYPE.EVERY_DAY then
		return var_13_0.dailyTasks, var_13_0.dailyAwards
	elseif arg_13_2 == var_0_0.RESET_TYPE.EVERY_WEEK then
		return var_13_0.weekTasks, var_13_0.weeklyAwards
	elseif arg_13_2 == var_0_0.RESET_TYPE.LIFETIME then
		return var_13_0.commonTasks, var_13_0.commonAwards
	else
		return {}, {}
	end
end

function TaskData:getAwardTVSInfoArr(arg_14_1)
	local var_14_0 = {}

	if not arg_14_1 then
		return var_14_0
	end

	local var_14_1 = 1

	while var_0_5.hasKey(var_0_1 .. 1) do
		if arg_14_1[var_0_1 .. 1] > 0 then
			table.insert(var_14_0, {
				type = arg_14_1[var_0_1 .. 1],
				value = arg_14_1[var_0_2 .. var_14_1],
				size = arg_14_1[var_0_3 .. var_14_1]
			})
		end

		var_14_1 = var_14_1 + 1
	end

	return var_14_0
end

function TaskData:getTaskCurValue(arg_15_1)
	if not arg_15_1 then
		return 0
	end

	if self:getTaskState(arg_15_1) == var_0_0.TASK_STATE.ACCEPTED then
		return arg_15_1.require_value
	else
		return self:getTaskDictAwardDict(arg_15_1.module, arg_15_1.reset_time)[arg_15_1.require_type] or 0
	end
end

return TaskData
