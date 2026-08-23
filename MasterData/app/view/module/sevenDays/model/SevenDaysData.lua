local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.SevenDaysConst
local var_0_2 = g.core.common.ServerTime
local SevenDaysTaskStruct = import(".SevenDaysTaskStruct")
local SevenDaysIntegralAwardStruct = import(".SevenDaysIntegralAwardStruct")
local var_0_5 = g.core.model.User.activityDataManager
local SevenDaysData = class("SevenDaysData")

function SevenDaysData:ctor()
	self:initData()
end

function SevenDaysData:initData()
	self._phase_2_open = false
	self._taskStructMap = {}
	self._taskStructArr2Dict = {}
	self._integralAwardStructDict = {}

	self:_initData()
end

function SevenDaysData:onS2CNewSevenDaysInfo(arg_3_1)
	if arg_3_1.score_ids then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.score_ids) do
			self:getIntegralAwardStruct(iter_3_1):setReceived(true)
		end
	end

	if arg_3_1.tasks then
		for iter_3_2, iter_3_3 in ipairs(arg_3_1.tasks) do
			local var_3_0 = self:getTaskStruct(iter_3_3.id)

			var_3_0:setProgress(iter_3_3.value)
			var_3_0:setReceived(iter_3_3.awarded)
		end

		self:_sortTaskStructArr2Dict()
	end
end

function SevenDaysData:onS2CNewSevenDaysAward(arg_4_1)
	self:getTaskStruct(arg_4_1.id):setReceived(true)
	self:_sortTaskStructArr2Dict()
end

function SevenDaysData:onS2cNewSevenDaysScoreAward(arg_5_1)
	self:getIntegralAwardStruct(arg_5_1.id):setReceived(true)
end

function SevenDaysData:onS2CActionStatusFlush(arg_6_1, arg_6_2)
	if not arg_6_2.status then
		return
	end

	local var_6_0 = arg_6_2.status.id

	for iter_6_0, iter_6_1 in pairs(self._taskStructArr2Dict[arg_6_1] or {}) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			if iter_6_3:getInfo().target == var_6_0 then
				iter_6_3:setProgress(arg_6_2.status.status)
			end
		end
	end

	self:_sortTaskStructArr2Dict()
end

function SevenDaysData:onS2CFlushRedPoint(arg_7_1)
	if arg_7_1 then
		self._phase_2_open = arg_7_1.fourteen_days_is_open == 1
	end
end

function SevenDaysData:_initData()
	for iter_8_0, iter_8_1 in g.core.config.sevendays_task_info.ipairs() do
		local var_8_0 = SevenDaysTaskStruct.new(iter_8_1)

		self._taskStructMap[iter_8_1.id] = var_8_0
		self._taskStructArr2Dict[iter_8_1.type] = self._taskStructArr2Dict[iter_8_1.type] or {}

		if self._taskStructArr2Dict[iter_8_1.type][iter_8_1.reset] then
			table.insert(self._taskStructArr2Dict[iter_8_1.type][iter_8_1.reset], var_8_0)
		else
			self._taskStructArr2Dict[iter_8_1.type][iter_8_1.reset] = {
				var_8_0
			}
		end
	end

	self:_sortTaskStructArr2Dict()

	for iter_8_2, iter_8_3 in g.core.config.sevendays_points_reward_info.ipairs() do
		self._integralAwardStructDict[iter_8_3.id] = SevenDaysIntegralAwardStruct.new(iter_8_3)
	end
end

function SevenDaysData:_sortTaskStructArr2Dict()
	local function var_9_0(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:getReceiveState()
		local var_10_1 = arg_10_1:getReceiveState()

		if var_10_0 == var_10_1 then
			return arg_10_0:getInfo().id < arg_10_1:getInfo().id
		else
			return var_10_0 < var_10_1
		end
	end

	for iter_9_0, iter_9_1 in pairs(self._taskStructArr2Dict) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			if #iter_9_3 > 1 then
				table.sort(iter_9_3, var_9_0)
			end
		end
	end
end

function SevenDaysData:getActValueByFunId(arg_11_1)
	if arg_11_1 == var_0_0.FUNCTION_TYPE.SEVEN_DAYS_ACTIVITY_2 then
		return var_0_1.ACT_VALUE.PHASE_2
	elseif arg_11_1 == var_0_0.FUNCTION_TYPE.SEVEN_DAYS_ACTIVITY then
		return var_0_1.ACT_VALUE.PHASE_1
	else
		g.core.log:info("-------        Invalid funcId = ", arg_11_1, ", return ACT_VALUE.PHASE_1  --------------")

		return var_0_1.ACT_VALUE.PHASE_1
	end
end

function SevenDaysData:getTaskStructArr(arg_12_1, arg_12_2)
	return self._taskStructArr2Dict[arg_12_1][arg_12_2] or {}
end

function SevenDaysData:getTaskStruct(arg_13_1)
	return self._taskStructMap[arg_13_1]
end

function SevenDaysData:getIntegralAwardStructArr(arg_14_1, arg_14_2)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(self._integralAwardStructDict) do
		local var_14_1 = iter_14_1:getInfo()

		if arg_14_1 == var_14_1.type and arg_14_2 == var_14_1.prize_type then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function SevenDaysData:getIntegralAwardStruct(arg_15_1)
	return self._integralAwardStructDict[arg_15_1]
end

function SevenDaysData:getIntegralAllCanGetAwardId(arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self._integralAwardStructDict) do
		local var_16_1 = iter_16_1:getInfo()

		if var_16_1.type == arg_16_1 and iter_16_1:getReceiveState() == var_0_1.RECEIVE_STATE.CAN_RECEIVE then
			table.insert(var_16_0, var_16_1.id)
		end
	end

	return var_16_0
end

function SevenDaysData:getDayTabDayArr(arg_17_1)
	local var_17_1 = table.keys(self._taskStructArr2Dict[arg_17_1] or {})

	if #var_17_1 > 1 then
		table.sort(var_17_1, function(arg_18_0, arg_18_1)
			return arg_18_0 < arg_18_1
		end)
	end

	return var_17_1
end

function SevenDaysData:getDayTabState(arg_19_1, arg_19_2)
	if arg_19_2 > var_0_2:getCreateRoleDays() then
		return var_0_1.DAY_TAB_STATE.LOCKED
	elseif self:_isDayTasksCompleted(arg_19_1, arg_19_2) then
		return var_0_1.DAY_TAB_STATE.COMPLETED
	else
		return var_0_1.DAY_TAB_STATE.UNLOCKED
	end
end

function SevenDaysData:getDayTabAllCanGetAwardId(arg_20_1, arg_20_2)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs((self:getTaskStructArr(arg_20_1, arg_20_2))) do
		if iter_20_1:getReceiveState() == var_0_1.RECEIVE_STATE.CAN_RECEIVE then
			table.insert(var_20_0, iter_20_1:getInfo().id)
		end
	end

	return var_20_0
end

function SevenDaysData:_isDayTasksCompleted(arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in ipairs((self:getTaskStructArr(arg_21_1, arg_21_2))) do
		if iter_21_1:getReceiveState() ~= var_0_1.RECEIVE_STATE.RECEIVED then
			return false
		end
	end

	return true
end

function SevenDaysData:isExistAwardWithDay(arg_22_1, arg_22_2)
	if self:getDayTabState(arg_22_1, arg_22_2) ~= var_0_1.DAY_TAB_STATE.UNLOCKED then
		return false
	end

	for iter_22_0, iter_22_1 in ipairs((self:getTaskStructArr(arg_22_1, arg_22_2))) do
		if iter_22_1:getReceiveState() == var_0_1.RECEIVE_STATE.CAN_RECEIVE then
			return true
		end
	end

	return false
end

function SevenDaysData:getActivityData(arg_23_1)
	return var_0_5:getConfigTableActivityData(var_0_0.ActivityConst.ACTIVITY_TYPE.SEVEN_DAYS, arg_23_1)
end

function SevenDaysData:isShow7DaysActivity(arg_24_1)
	return self:isShowWithActValue((self:getActValueByFunId(arg_24_1)))
end

function SevenDaysData:isShowWithActValue(arg_25_1)
	if arg_25_1 == var_0_1.ACT_VALUE.PHASE_2 then
		if not self._phase_2_open then
			return false
		end
	elseif self:_isCollectedAllAward(arg_25_1) then
		return false
	end

	local var_25_0 = self:getActivityData(arg_25_1)

	return var_25_0 and var_25_0:isShow()
end

function SevenDaysData:isExistAwardWithCustomData(arg_26_1)
	local var_26_0 = arg_26_1.actValue or self:getActValueByFunId(arg_26_1.functionId)

	if not self:isShowWithActValue(var_26_0) then
		return false
	elseif arg_26_1.day then
		return self:isExistAwardWithDay(var_26_0, arg_26_1.day)
	else
		for iter_26_0, iter_26_1 in pairs(self._taskStructArr2Dict[var_26_0] or {}) do
			if self:getDayTabState(var_26_0, iter_26_0) == var_0_1.DAY_TAB_STATE.UNLOCKED then
				for iter_26_2, iter_26_3 in ipairs(iter_26_1) do
					if iter_26_3:getReceiveState() == var_0_1.RECEIVE_STATE.CAN_RECEIVE then
						return true
					end
				end
			end
		end

		return false
	end
end

function SevenDaysData:isExistIntegralAwardWithCustomData(arg_27_1)
	local var_27_0 = arg_27_1.actValue or self:getActValueByFunId(arg_27_1.functionId)

	if not self:isShowWithActValue(var_27_0) then
		return false
	elseif arg_27_1.id then
		local var_27_1 = self:getIntegralAwardStruct(arg_27_1.id)

		if var_27_1 then
			return var_27_1:getReceiveState() == var_0_1.RECEIVE_STATE.CAN_RECEIVE
		end
	else
		for iter_27_0, iter_27_1 in pairs(self._integralAwardStructDict) do
			if var_27_0 == iter_27_1:getInfo().type and iter_27_1:getReceiveState() == var_0_1.RECEIVE_STATE.CAN_RECEIVE then
				return true
			end
		end
	end
end

function SevenDaysData:isSavedUnlockedDay(arg_28_1)
	return self:_getJsonDict()[tostring(arg_28_1)] == var_0_1.DAY_TAB_STATE.UNLOCKED
end

function SevenDaysData:saveUnlockedDay(arg_29_1)
	if not self:isSavedUnlockedDay(arg_29_1) then
		local var_29_0 = self:_getJsonDict()

		var_29_0[tostring(arg_29_1)] = var_0_1.DAY_TAB_STATE.UNLOCKED

		g.core.common.Storage:save(var_0_1.JSON_NAME, var_29_0)
	end
end

function SevenDaysData:saveAllUnlockedDays()
	for iter_30_0 = 1, math.min(var_0_2:getCreateRoleDays(), var_0_1.DAY_TAB_NUM * 2) do
		self:saveUnlockedDay(iter_30_0)
	end
end

function SevenDaysData:isNewUnlockedDay(arg_31_1)
	local var_31_0 = arg_31_1.actValue or self:getActValueByFunId(arg_31_1.functionId)

	if not self:isShowWithActValue(var_31_0) then
		return false
	end

	if self:getDayTabState(var_31_0, arg_31_1.day) == var_0_1.DAY_TAB_STATE.UNLOCKED and not self:isSavedUnlockedDay(arg_31_1.day) then
		return true
	end
end

function SevenDaysData:_isCollectedAllAward(arg_32_1)
	for iter_32_0, iter_32_1 in pairs(self._taskStructArr2Dict[arg_32_1] or {}) do
		for iter_32_2, iter_32_3 in ipairs(iter_32_1) do
			if iter_32_3:getReceiveState() ~= var_0_1.RECEIVE_STATE.RECEIVED then
				return false
			end
		end
	end

	for iter_32_4, iter_32_5 in pairs(self._integralAwardStructDict) do
		if arg_32_1 == iter_32_5:getInfo().type and iter_32_5:getReceiveState() ~= var_0_1.RECEIVE_STATE.RECEIVED then
			return false
		end
	end

	return true
end

function SevenDaysData:_getJsonDict()
	return g.core.common.Storage:load(var_0_1.JSON_NAME) or {}
end

return SevenDaysData
