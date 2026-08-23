local ActivityTaskData = class("ActivityTaskData")
local var_0_2 = g.core.config.activity_task_info
local var_0_3 = g.core.const.ConstMgr.ActivityConst
local var_0_4 = g.core.const.ConstMgr.FUNCTION_TYPE

function ActivityTaskData:ctor()
	self:initData()
end

function ActivityTaskData:initData()
	self._activityConditionInfoMap = {}
	self._conditioDataListMap = {}
	self._conditionInfoListMap = {}
	self._activity_condition_id = 1
end

function ActivityTaskData:_initBase()
	self._activityConditionInfoMap = g.core.model.User.activityOpenData:getConditionMap()

	for iter_3_0, iter_3_1 in pairs(self._activityConditionInfoMap) do
		self._conditioDataListMap[iter_3_0] = {
			progress = 0,
			finished = {}
		}
	end

	for iter_3_2 = 1, var_0_2.getLength() do
		local var_3_0 = var_0_2.indexOf(iter_3_2)

		self._conditionInfoListMap[var_3_0.activity_id] = self._conditionInfoListMap[var_3_0.activity_id] or {}

		local var_3_1 = {}

		for iter_3_3, iter_3_4, iter_3_5 in var_3_0.gmatch({
			"reward_type_%d+",
			"reward_value_%d+",
			"reward_size_%d+"
		}) do
			table.insert(var_3_1, {
				type = iter_3_5[1],
				value = iter_3_5[2],
				size = iter_3_5[3]
			})
		end

		table.insert(self._conditionInfoListMap[var_3_0.activity_id], {
			state = 1,
			info = var_3_0:toObject(),
			award = var_3_1
		})
	end
end

function ActivityTaskData:updateConditionGetInfo(arg_4_1)
	if arg_4_1 then
		if self._conditioDataListMap[arg_4_1.activity_value] then
			self._conditioDataListMap[arg_4_1.activity_value].progress = arg_4_1.value
			self._conditioDataListMap[arg_4_1.activity_value].finished = {}

			if arg_4_1.finish_awards then
				for iter_4_0 = 1, #arg_4_1.finish_awards do
					self._conditioDataListMap[arg_4_1.activity_value].finished[arg_4_1.finish_awards[iter_4_0]] = true
				end
			end

			self:_calConditionState(arg_4_1.activity_value)
		end
	end
end

function ActivityTaskData:updateConditionTaskAward(arg_5_1)
	if arg_5_1 then
		if self._conditioDataListMap[arg_5_1.activity_id] then
			self._conditioDataListMap[arg_5_1.activity_id].finished[arg_5_1.id] = true
		end

		self:_calConditionState(arg_5_1.activity_value)
	end
end

function ActivityTaskData:updateConditionSyncTask(arg_6_1)
	if arg_6_1 then
		if self._conditioDataListMap[arg_6_1.activity_value] then
			self._conditioDataListMap[arg_6_1.activity_value].progress = arg_6_1.value
			self._conditioDataListMap[arg_6_1.activity_value].finished = {}

			if arg_6_1.finish_awards then
				for iter_6_0 = 1, #arg_6_1.finish_awards do
					self._conditioDataListMap[arg_6_1.activity_value].finished[arg_6_1.finish_awards[iter_6_0]] = true
				end
			end

			self:_calConditionState(arg_6_1.activity_value)
		end
	end
end

function ActivityTaskData:_calConditionState(arg_7_1)
	local var_7_0 = g.core.model.User.activityOpenData:getTimeById(var_0_4.CONDITION_ACT_START + arg_7_1, var_0_3.TIME_KEY.END) < g.core.common.ServerTime:getTime()
	local var_7_1 = self._conditionInfoListMap[arg_7_1]

	for iter_7_0, iter_7_1 in ipairs(self._conditionInfoListMap[arg_7_1]) do
		local var_7_2 = 1

		if self._conditioDataListMap[arg_7_1].finished[iter_7_1.info.id] then
			var_7_2 = 2
		elseif self._conditioDataListMap[arg_7_1].progress >= iter_7_1.info.num then
			var_7_2 = 0
		elseif var_7_0 then
			var_7_2 = 3
		end

		iter_7_1.state = var_7_2
	end

	table.sort(var_7_1, function(arg_8_0, arg_8_1)
		if arg_8_0.state ~= arg_8_1.state then
			return arg_8_0.state < arg_8_1.state
		end

		return arg_8_0.info.num < arg_8_1.info.num
	end)
end

function ActivityTaskData:getConditionInfo(arg_9_1)
	return self._conditionInfoListMap[arg_9_1]
end

function ActivityTaskData:getConditionData(arg_10_1)
	return self._conditioDataListMap[arg_10_1]
end

function ActivityTaskData:getHasRecruitRebate()
	for iter_11_0, iter_11_1 in pairs(self._activityConditionInfoMap) do
		if iter_11_1.show == var_0_3.SHOW_TYPE.RECRUIT_REBATE and g.core.model.User.activityOpenData:isProcess(var_0_4.CONDITION_ACT_START + iter_11_1.activity_value) then
			return true, iter_11_1.activity_value
		end
	end

	return false
end

function ActivityTaskData:getConditionInfoByValue(arg_12_1)
	return self._activityConditionInfoMap[arg_12_1]
end

function ActivityTaskData:getCurConditionId()
	return self._activity_condition_id
end

function ActivityTaskData:setCurConditionId(arg_14_1)
	self._activity_condition_id = arg_14_1
end

return ActivityTaskData
