local var_0_0 = g.core.const.ConstMgr.ActivityConst
local ThemeEntranceActivityData = class("ThemeEntranceActivityData")

function ThemeEntranceActivityData:ctor(arg_1_1, arg_1_2)
	self._themeValue = arg_1_1
	self._activityDataArr = arg_1_2 or {}

	table.sort(self._activityDataArr, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_0:getStartTime() or 0
		local var_2_1 = arg_2_1:getStartTime() or 0

		if var_2_0 ~= var_2_1 then
			return var_2_0 < var_2_1
		end

		return arg_2_0:getConfigActivityValue() < arg_2_1:getConfigActivityValue()
	end)

	self._mergeStartTime = 0
	self._mergeFinishTime = 0
	self._mergeExpireTime = 0
	self._openActivityData = nil

	self:_refreshMergeInfo()
end

function ThemeEntranceActivityData:_refreshMergeInfo()
	for iter_3_0, iter_3_1 in ipairs(self._activityDataArr) do
		local var_3_0 = iter_3_1:getStartTime() or 0
		local var_3_1 = iter_3_1:getFinishTime() or 0
		local var_3_2 = iter_3_1:getExpireTime() or 0

		self._mergeStartTime = self._mergeStartTime == 0 and var_3_0 or math.min(self._mergeStartTime, var_3_0)
		self._mergeFinishTime = math.max(self._mergeFinishTime, var_3_1)
		self._mergeExpireTime = math.max(self._mergeExpireTime, var_3_2)

		if not self._openActivityData and iter_3_1:getActivityState() == var_0_0.ACTIVITY_STATE.START then
			self._openActivityData = iter_3_1
		end
	end

	if not self._openActivityData then
		for iter_3_2, iter_3_3 in ipairs(self._activityDataArr) do
			if iter_3_3:getActivityState() == var_0_0.ACTIVITY_STATE.END then
				self._openActivityData = iter_3_3

				break
			end
		end
	end

	self._openActivityData = self._openActivityData or self._activityDataArr[1]
end

function ThemeEntranceActivityData:getConfigActivityValue()
	return self._themeValue
end

function ThemeEntranceActivityData:getActivityState()
	local var_5_0 = g.core.common.ServerTime:getTime()

	if var_5_0 < self._mergeFinishTime then
		return var_0_0.ACTIVITY_STATE.START
	elseif var_5_0 < self._mergeExpireTime then
		return var_0_0.ACTIVITY_STATE.END
	end

	return var_0_0.ACTIVITY_STATE.EXPIRE
end

function ThemeEntranceActivityData:getFinishTime()
	return self._mergeFinishTime
end

function ThemeEntranceActivityData:getExpireTime()
	return self._mergeExpireTime
end

function ThemeEntranceActivityData:getStartTime()
	return self._mergeStartTime
end

function ThemeEntranceActivityData:getActivityDataList()
	return self._activityDataArr
end

function ThemeEntranceActivityData:getActivityThemeValueList()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self._activityDataArr) do
		table.insert(var_10_0, iter_10_1:getConfigActivityValue())
	end

	return var_10_0
end

function ThemeEntranceActivityData:getOpenActivityData()
	return self._openActivityData
end

function ThemeEntranceActivityData:isMergedGiftOpen()
	for iter_12_0, iter_12_1 in ipairs(self._activityDataArr) do
		if iter_12_1:getActivityState() == var_0_0.ACTIVITY_STATE.START then
			return true
		end
	end

	return false
end

function ThemeEntranceActivityData:isMergedTaskOpen()
	for iter_13_0, iter_13_1 in ipairs(self._activityDataArr) do
		if iter_13_1:getActivityState() == var_0_0.ACTIVITY_STATE.START then
			return true
		end
	end

	return false
end

function ThemeEntranceActivityData:isMergedBossEntryOpen()
	for iter_14_0, iter_14_1 in ipairs(self._activityDataArr) do
		if iter_14_1:getActivityState() == var_0_0.ACTIVITY_STATE.START then
			return true
		end
	end

	return false
end

function ThemeEntranceActivityData:isMergedShopOpen()
	for iter_15_0, iter_15_1 in ipairs(self._activityDataArr) do
		local var_15_0 = iter_15_1:getActivityState()

		if var_15_0 == var_0_0.ACTIVITY_STATE.START or var_15_0 == var_0_0.ACTIVITY_STATE.END or var_15_0 == var_0_0.ACTIVITY_STATE.EXPIRE then
			return true
		end
	end

	return false
end

return ThemeEntranceActivityData
