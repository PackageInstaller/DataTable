local var_0_0 = g.core.config.first_recharge_info
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.common.ServerTime
local FirstRechargeData = class("FirstRechargeData", require("app.core.model.BaseData"))

function FirstRechargeData:ctor()
	self:initData()
end

function FirstRechargeData:initData()
	self._activityId = 1
	self._dayRewardData = {}
	self._info = nil
	self._isRecharged = false
	self._curLoginDay = -1
	self._isGetTimesRechargeAward = false
	self._timesRechargeAward = {}
	self._firstRechargeTime = 0
	self._needDayTimes = 0
	self._totalRechargeNum = 0
	self._secondRechargeNum = 0
	self._firstRegInfoDict = {}
	self._activityFRDict = {}

	self:_initFirstRechargeInfo()
end

function FirstRechargeData:_initFirstRechargeInfo()
	local var_3_0 = g.core.common.ServerTime:getOpenTime()
	local var_3_1 = 0

	for iter_3_0 = 1, var_0_0.getLength() do
		local var_3_2 = var_0_0.get(iter_3_0)

		self._activityFRDict[var_3_2.id] = {}
		self._activityFRDict[var_3_2.id].info = var_3_2
		self._activityFRDict[var_3_2.id].dayReward = {}

		if var_3_2.first_value then
			self._activityFRDict[var_3_2.id].dayReward[0] = {
				canGet = false,
				isGet = false,
				awards = g.core.common.Drops:getGoodsArray(var_3_2.first_value)
			}
		end

		for iter_3_1 = 1, 3 do
			self._activityFRDict[var_3_2.id].dayReward[iter_3_1] = {
				canGet = false,
				isGet = false,
				awards = g.core.common.Drops:getGoodsArray(var_3_2["value_" .. iter_3_1])
			}
		end

		self._activityFRDict[var_3_2.id].timeRechargeAward = {
			type = var_3_2.times_type,
			value = var_3_2.times_value,
			size = var_3_2.value_size
		}
		self._activityFRDict[var_3_2.id].needDayTimes = var_3_2.times
		self._activityFRDict[var_3_2.id].rechargeHasTime = var_3_2.days * 86400

		local var_3_6

		if var_3_2.end_time > 0 then
			local var_3_3 = tonumber(var_3_2.end_time)
			local var_3_5 = var_0_2:getTimeStampByParams({
				year = math.floor(var_3_3 / 10000000000),
				month = math.floor(var_3_3 % 10000000000 / 100000000),
				day = math.floor(var_3_3 % 10000000000 % 100000000 / 1000000)
			})

			if 0 < var_3_0 and var_3_0 < var_3_5 then
				var_3_6 = var_3_5
				var_3_1 = var_3_2.id
			end
		end
	end

	if var_3_1 > 0 then
		self._activityId = var_3_1
	else
		local var_3_7 = var_0_0.match(function(arg_4_0)
			return arg_4_0.end_time == 0
		end)

		self._activityId = var_3_7 and var_3_7[1].id or 1
	end

	self._dayRewardData = self._activityFRDict[self._activityId].dayReward
	self._timesRechargeAward = self._activityFRDict[self._activityId].timeRechargeAward
	self._needDayTimes = self._activityFRDict[self._activityId].needDayTimes
	self._rechargeHasTime = self._activityFRDict[self._activityId].rechargeHasTime
	self._info = self._activityFRDict[self._activityId].info
end

function FirstRechargeData:updateRechargeData(arg_5_1)
	arg_5_1 = arg_5_1.update or arg_5_1

	if arg_5_1.id and arg_5_1.id > 0 then
		self._activityId = arg_5_1.id
	end

	if (arg_5_1.total_login_day or 0) > 0 then
		self._curLoginDay = arg_5_1.total_login_day

		for iter_5_0, iter_5_1 in pairs(self._dayRewardData) do
			iter_5_1.canGet = iter_5_0 <= arg_5_1.total_login_day
		end
	end

	if arg_5_1.days then
		for iter_5_2, iter_5_3 in pairs(arg_5_1.days) do
			self._dayRewardData[iter_5_3].isGet = true
		end
	end

	self._isGetTimesRechargeAward = (arg_5_1.first_award_id or 0) ~= 0
	self._firstRechargeTime = arg_5_1.recharge_time or 0
	self._secondRechargeNum = 0

	for iter_5_4, iter_5_5 in ipairs(arg_5_1.rechargeDayMoneys or {}) do
		if iter_5_5.day > 0 then
			self._secondRechargeNum = self._secondRechargeNum + iter_5_5.money
		end
	end
end

function FirstRechargeData:onGetFirstRechargeAward(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.day or {}) do
		self._dayRewardData[iter_6_1].isGet = true
	end
end

function FirstRechargeData:getFirstRechargeActId()
	return self._activityId
end

function FirstRechargeData:onGetFirstRechargeTimesAward(arg_8_1)
	self._isGetTimesRechargeAward = true
end

function FirstRechargeData:setTotalRechargeNum(arg_9_1)
	self._totalRechargeNum = arg_9_1
	self._isRecharged = arg_9_1 >= self:getInfo().money
end

function FirstRechargeData:getNeedTimes()
	return self._needDayTimes
end

function FirstRechargeData:getActivityTime()
	return self._firstRechargeTime, self._firstRechargeTime + self._rechargeHasTime
end

function FirstRechargeData:isRecharged()
	return self._isRecharged
end

function FirstRechargeData:isGetFirstAward()
	if self:getDayCellData(0) then
		return self:getDayCellData(0).isGet
	else
		return false
	end
end

function FirstRechargeData:isSecondRechargeEnough()
	return self._secondRechargeNum >= self:getInfo().money
end

function FirstRechargeData:getCurDay()
	return self._curLoginDay
end

function FirstRechargeData:hasGanGetAward()
	for iter_16_0, iter_16_1 in pairs(self._dayRewardData) do
		if iter_16_1.canGet and not iter_16_1.isGet then
			return true
		end
	end

	if self:isSecondRechargeEnough() and not self:isGetTimesRechargeAward() then
		return true
	end

	return false
end

function FirstRechargeData:getInfo()
	return self._info
end

function FirstRechargeData:getLookBtnAward()
	local var_18_0 = g.core.config.drop_info.get(self._info.first_value, 1)

	return {
		type = var_18_0["reward_type_" .. self._info.special],
		value = var_18_0["reward_value_" .. self._info.special],
		size = var_18_0["reward_min_" .. self._info.special]
	}
end

function FirstRechargeData:getTimeRechargeAward()
	return self._timesRechargeAward
end

function FirstRechargeData:isGetTimesRechargeAward()
	return self._isGetTimesRechargeAward
end

function FirstRechargeData:getDayCellData(arg_21_1)
	return self._dayRewardData[arg_21_1]
end

function FirstRechargeData:isRewardAllGet()
	if not self._isGetTimesRechargeAward then
		return false
	end

	for iter_22_0, iter_22_1 in pairs(self._dayRewardData) do
		if not iter_22_1.isGet then
			return false
		end
	end

	return true
end

function FirstRechargeData:isShowActivity()
	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_1.FUNCTION_TYPE.NEW_FIRST_RECHARGE) then
		return false
	end

	if self:isRecharged() then
		local var_23_0, var_23_1 = self:getActivityTime()

		if var_23_1 <= g.core.common.ServerTime:getTime() then
			return false
		end

		if self:isRewardAllGet() then
			return false
		end
	end

	return true
end

function FirstRechargeData:getFirstRechargePopResName()
	if self._activityId == 1 then
		return "FirstRechargePop"
	else
		return "FirstRechargePop_" .. self._activityId
	end
end

return FirstRechargeData
