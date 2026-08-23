local SummerThemeTaskRecord = require("app.view.module.summerTheme.model.SummerThemeTaskRecord")
local SummerThemeTaskRecordExtra = require("app.view.module.summerTheme.model.SummerThemeTaskRecordExtra")
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local var_0_4 = g.core.const.ConstMgr.ThemeConst
local SummerThemeTaskData = class("SummerThemeTaskData", require("app.core.model.BaseData"))

function SummerThemeTaskData:ctor()
	SummerThemeTaskData.super.ctor(self)

	self._activeThemeType = nil
	self._activeThemeValue = nil
	self._sourceType = var_0_3.CONFIG_TABLE
	self._activeStartTime = 0
	self._threeActivityId = 0
	self._taskRecordDict = nil
	self._taskTypeArr = nil
	self._taskStatusDict = {}
	self._taskDayDropDict = {}
	self._taskAwardDict = {}
end

function SummerThemeTaskData:configThemeType()
	return self._activeThemeType
end

function SummerThemeTaskData:configThemeVal()
	return self._activeThemeValue
end

function SummerThemeTaskData:getThreeActivityId()
	return self._threeActivityId
end

function SummerThemeTaskData:isThemeStart()
	return self._activeThemeValue ~= nil
end

function SummerThemeTaskData:startByActivityData(arg_6_1)
	self._activeThemeType = arg_6_1:getActivityType()
	self._activeThemeValue = arg_6_1:getConfigActivityValue()
	self._sourceType = arg_6_1:getActivitySourceType()
	self._activeStartTime = arg_6_1:getStartTime()

	local var_6_0 = g.core.config.activity_theme_info.get(self._activeThemeValue)

	self._threeActivityId = var_6_0.three_activity or 0

	self:_initCfgData(var_6_0)
end

function SummerThemeTaskData:refreshRedPointData(arg_7_1)
	self:refreshTaskCrossDay()
	self:onNetHandleTaskGetInfo(arg_7_1)
end

function SummerThemeTaskData:requestTaskDropInfo()
	g.core.network.GameNetProxy:send_C2S_Holiday_Drop_Info({
		sub_activity_id = self._activeThemeValue
	})
end

function SummerThemeTaskData:requestTaskInfo()
	g.core.network.GameNetProxy:send_C2S_ThemeAction_GetInfo({
		act_id = self._activeThemeValue
	})
end

function SummerThemeTaskData:requestTaskAward(arg_10_1)
	g.core.network.GameNetProxy:send_C2S_ThemeAction_GetAwards({
		act_id = arg_10_1
	})
end

function SummerThemeTaskData:onNetHandleTaskGetInfo(arg_11_1)
	if arg_11_1.status then
		for iter_11_0, iter_11_1 in pairs(arg_11_1.status) do
			self._taskStatusDict[iter_11_1.id] = iter_11_1.status
		end
	end

	if arg_11_1.award_list then
		for iter_11_2, iter_11_3 in pairs(arg_11_1.award_list) do
			self._taskAwardDict[iter_11_3] = true
		end
	end
end

function SummerThemeTaskData:onNetHandleTaskUpdateInfo(arg_12_1)
	if not arg_12_1.status then
		return
	end

	self._taskStatusDict[arg_12_1.status.id] = arg_12_1.status.status
end

function SummerThemeTaskData:onNetHandleTaskAward(arg_13_1)
	self._taskAwardDict[arg_13_1.act_id] = arg_13_1.awards or true
end

function SummerThemeTaskData:onNetHandleTaskDropInfo(arg_14_1)
	if not arg_14_1.data then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_1.data) do
		self._taskDayDropDict[iter_14_1.drop_id] = iter_14_1.drop_num
	end
end

function SummerThemeTaskData:getTaskTypeArr()
	return self._taskTypeArr
end

function SummerThemeTaskData:getActivityStarTime()
	return self._activeStartTime
end

function SummerThemeTaskData:getTaskArrByType(arg_17_1)
	return self._taskRecordDict[arg_17_1]
end

function SummerThemeTaskData:getTaskDropNum(arg_18_1)
	return self._taskDayDropDict[arg_18_1] or 0
end

function SummerThemeTaskData:getTaskCurNum(arg_19_1)
	return self._taskStatusDict[arg_19_1] or 0
end

function SummerThemeTaskData:alreadyHaveAward(arg_20_1)
	return self._taskAwardDict[arg_20_1] ~= nil
end

function SummerThemeTaskData:refreshTaskCrossDay()
	if self:isExpired() then
		self:resetExpired()
		self:_resetDailyTaskData()
	end
end

function SummerThemeTaskData:_initCfgData(arg_22_1)
	self._taskRecordDict = {}

	local var_22_0 = arg_22_1.three_activity or 0
	local var_22_1 = g.core.config.activity_theme_task_info

	for iter_22_0 = 1, g.core.config.activity_theme_task_info.getLength() do
		local var_22_2 = var_22_1.indexOf(iter_22_0)

		if (var_22_0 > 0 and var_22_2.three_activity == var_22_0 or arg_22_1.id == var_22_2.activity_id) and (var_22_2.function_id > 0 or nil) and var_0_2:isModuleUnlock(var_22_2.function_id) then
			local var_22_5 = SummerThemeTaskRecord.new(self)

			var_22_5:initWithCfgInfo(var_22_2)
			self:_addTaskRecord(var_22_5)
		end
	end

	for iter_22_1 = 1, g.core.config.extra_drop_info.getLength() do
		local var_22_6 = g.core.config.extra_drop_info.indexOf(iter_22_1)

		if arg_22_1.extra_drop == var_22_6.extra_type then
			local var_22_7 = SummerThemeTaskRecordExtra.new(self)

			var_22_7:initWithCfgInfo(var_22_6)
			self:_addTaskRecord(var_22_7)
		end
	end

	self:_calcTaskTypeArr()
end

function SummerThemeTaskData:_addTaskRecord(arg_23_1)
	local var_23_0 = arg_23_1:getThemeTaskType()
	local var_23_1 = self._taskRecordDict[var_23_0]

	if not self._taskRecordDict[var_23_0] then
		var_23_1 = {}
		self._taskRecordDict[var_23_0] = var_23_1
	end

	table.insert(var_23_1, arg_23_1)
end

function SummerThemeTaskData:_calcTaskTypeArr()
	self._taskTypeArr = {}

	for iter_24_0, iter_24_1 in pairs(self._taskRecordDict) do
		table.insert(self._taskTypeArr, iter_24_0)
	end

	table.sort(self._taskTypeArr, function(arg_25_0, arg_25_1)
		if arg_25_0 == var_0_4.THEME_TASK_TYPE.COMMON then
			arg_25_0 = 10
		end

		if arg_25_1 == var_0_4.THEME_TASK_TYPE.COMMON then
			arg_25_1 = 10
		end

		return arg_25_0 < arg_25_1
	end)
end

function SummerThemeTaskData:_resetDailyTaskData()
	self._taskDayDropDict = {}

	local var_26_0 = self:getTaskArrByType(var_0_4.THEME_TASK_TYPE.DAILY)

	if not var_26_0 then
		return
	end

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		local var_26_1 = iter_26_1:getBaseInfo().id

		self._taskStatusDict[var_26_1] = 0
		self._taskAwardDict[var_26_1] = nil
	end
end

function SummerThemeTaskData:redCheckDayTaskCanGet()
	local var_27_0 = self:getTaskArrByType(var_0_4.THEME_TASK_TYPE.DAILY)

	if not var_27_0 then
		return false
	end

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1:getTaskStatus() == 2 then
			return true
		end
	end

	return false
end

function SummerThemeTaskData:redCheckHonourTaskCanGet()
	local var_28_0 = self:getTaskArrByType(var_0_4.THEME_TASK_TYPE.HONOUR)

	if not var_28_0 then
		return false
	end

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		if iter_28_1:getTaskStatus() == 2 then
			return true
		end
	end

	return false
end

return SummerThemeTaskData
