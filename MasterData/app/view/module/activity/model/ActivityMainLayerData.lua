local var_0_0 = g.core.const.ConstMgr.ActivityConst
local ActivityMainLayerData = class("ActivityMainLayerData")

function ActivityMainLayerData:ctor()
	self:initData()
end

function ActivityMainLayerData:initData()
	return
end

function ActivityMainLayerData:getSortedActivityDataList()
	local var_3_0 = self:_getActivityDataList() or {}

	if #var_3_0 > 1 then
		table.sort(var_3_0, self:_getSortRuleGM())
	end

	return var_3_0
end

function ActivityMainLayerData:_getActivityDataList()
	return (g.core.model.User.activityDataManager:getActivityDataListByFilter(function(arg_5_0)
		return arg_5_0:isInActivityMainLayer() and arg_5_0:isShow()
	end))
end

function ActivityMainLayerData:_getSortRule()
	return function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:getActivitySourceType()
		local var_7_1 = arg_7_1:getActivitySourceType()

		if var_7_0 ~= var_7_1 then
			return var_7_0 < var_7_1
		elseif var_7_0 == var_0_0.ACTIVITY_SOURCE_TYPE.CONFIG_TABLE then
			local var_7_2 = arg_7_0:getSortWeight()
			local var_7_3 = arg_7_1:getSortWeight()

			if var_7_2 == var_7_3 then
				return arg_7_0:getActivityId() < arg_7_1:getActivityId()
			else
				return var_7_2 < var_7_3
			end
		else
			local var_7_4 = arg_7_0:getStartTime()
			local var_7_5 = arg_7_1:getStartTime()

			if var_7_4 == var_7_5 then
				return arg_7_0:getActivityId() < arg_7_1:getActivityId()
			else
				return var_7_4 < var_7_5
			end
		end
	end
end

function ActivityMainLayerData:_getSortRuleGM()
	return function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:getActivitySourceType()
		local var_9_1 = arg_9_1:getActivitySourceType()

		if var_9_0 ~= var_9_1 then
			return var_9_1 < var_9_0
		elseif var_9_0 == var_0_0.ACTIVITY_SOURCE_TYPE.CONFIG_TABLE then
			local var_9_2 = arg_9_0:getSortWeight()
			local var_9_3 = arg_9_1:getSortWeight()

			if var_9_2 == var_9_3 then
				return arg_9_0:getActivityId() < arg_9_1:getActivityId()
			else
				return var_9_2 < var_9_3
			end
		else
			local var_9_4 = arg_9_0:getStartTime()
			local var_9_5 = arg_9_1:getStartTime()

			if var_9_4 == var_9_5 then
				return arg_9_0:getActivityId() < arg_9_1:getActivityId()
			else
				return var_9_4 < var_9_5
			end
		end
	end
end

return ActivityMainLayerData
