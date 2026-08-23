local var_0_0 = g.core.config.level_up_info
local ActivityLevelUpData = class("ActivityLevelUpData")

function ActivityLevelUpData:ctor(arg_1_1)
	self:initData()
end

function ActivityLevelUpData:initData()
	self._levelUpActivityData = {}
	self._receiveLevelUpInfo = false

	self:_initLevelUpActivityData()
end

function ActivityLevelUpData:_initLevelUpActivityData()
	self._levelUpActivityData = {}

	for iter_3_0 = 1, var_0_0.getLength() do
		table.insert(self._levelUpActivityData, {
			isFinish = false,
			info = var_0_0.indexOf(iter_3_0)
		})
	end
end

function ActivityLevelUpData:updateLevelUpActivity(arg_4_1)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.award or {}) do
		var_4_1[iter_4_1] = true
	end

	for iter_4_2, iter_4_3 in ipairs(self._levelUpActivityData) do
		iter_4_3.isFinish = not not var_4_1[iter_4_3.info.id]
	end

	self._receiveLevelUpInfo = true
end

function ActivityLevelUpData:updateLevelUpAward(arg_5_1)
	if arg_5_1.id then
		for iter_5_0, iter_5_1 in ipairs(self._levelUpActivityData) do
			if iter_5_1.info.id == arg_5_1.id then
				iter_5_1.isFinish = true

				return
			end
		end
	end
end

function ActivityLevelUpData:getValidLevelUpTaskList()
	local var_6_0 = {}
	local var_6_1 = g.core.model.User:getLevel()

	for iter_6_0, iter_6_1 in ipairs(self._levelUpActivityData) do
		if var_6_1 >= iter_6_1.info.show_level then
			table.insert(var_6_0, iter_6_1)
		end
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		if arg_7_0.isFinish ~= arg_7_1.isFinish then
			return arg_7_1.isFinish
		end

		return arg_7_0.info.level < arg_7_1.info.level
	end)

	return var_6_0
end

function ActivityLevelUpData:getNextLevelUpTaskData()
	local var_8_0
	local var_8_1
	local var_8_2 = g.core.model.User:getLevel()

	for iter_8_0, iter_8_1 in ipairs(self._levelUpActivityData) do
		if var_8_2 < iter_8_1.info.level then
			if not var_8_0 then
				var_8_0 = iter_8_1
			elseif iter_8_1.info.level < var_8_0.info.level then
				var_8_0 = iter_8_1
			end
		end

		if not var_8_1 then
			var_8_1 = iter_8_1
		elseif iter_8_1.info.level > var_8_1.info.level then
			var_8_1 = iter_8_1
		end
	end

	var_8_0 = var_8_0 or var_8_1

	return var_8_0
end

function ActivityLevelUpData:isHasAwardCanGet()
	local var_9_0 = g.core.model.User:getLevel()

	for iter_9_0, iter_9_1 in ipairs((self:getValidLevelUpTaskList())) do
		if not iter_9_1.isFinish and var_9_0 >= iter_9_1.info.level then
			return true
		end
	end

	return false
end

function ActivityLevelUpData:isReceiveLevelUpInfo()
	return self._receiveLevelUpInfo
end

function ActivityLevelUpData:getLevelUpActivityData()
	return self._levelUpActivityData
end

function ActivityLevelUpData:isExistUnfinishedTask()
	for iter_12_0, iter_12_1 in pairs(self._levelUpActivityData) do
		if not iter_12_1.isFinish then
			return true
		end
	end
end

return ActivityLevelUpData
