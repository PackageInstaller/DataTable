local var_0_0 = g.core.config.login_reward_info
local SevenDaysSignInConst = require("app.view.module.sevenDaysSignIn.const.SevenDaysSignInConst")
local var_0_2 = SevenDaysSignInConst.RECEIVE_STATE
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_4 = g.core.common.ModuleUnlock
local var_0_5 = g.core.common.ServerTime
local SevenDaysSignInData = class("SevenDaysSignInData")

function SevenDaysSignInData:ctor()
	self:initData()
end

function SevenDaysSignInData:initData()
	self._finishDict = {}
	self._autoPopNext = false
	self._days = 1
	self._updateInfoTime = 0
end

function SevenDaysSignInData:onRcvLoginRewardInfo(arg_3_1)
	self._updateInfoTime = var_0_5:getTime()
	self._days = require("app.core.utils.KsMath"):mathClampRange(1, (var_0_0.getLength()))

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.ids or {}) do
		self:_setFinished(iter_3_1)
	end
end

function SevenDaysSignInData:onRcvLoginRewardAward(arg_4_1)
	self:_setFinished(arg_4_1.id)

	if var_0_0.get(arg_4_1.id).day % SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS == 0 then
		g.core.model.User.homeData:setNeedUpdateBanner(true)
	end
end

function SevenDaysSignInData:getState(arg_5_1)
	if arg_5_1 > self._days then
		return var_0_2.NOT_RECEIVED
	elseif self:isFinished(self:getInfoWithDay(arg_5_1).id) then
		return var_0_2.RECEIVED
	else
		return var_0_2.CAN_RECEIVE
	end
end

function SevenDaysSignInData:isExpired()
	for iter_6_0, iter_6_1 in var_0_0.ipairs() do
		if not self:isFinished(iter_6_1.id) then
			return false
		end
	end

	return true
end

function SevenDaysSignInData:isExpiredWithPhase(arg_7_1)
	local var_7_0 = self:phaseDayToDay(arg_7_1, SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS)

	if var_7_0 <= var_0_0.getLength() then
		for iter_7_0 = self:phaseDayToDay(arg_7_1, 1), var_7_0 do
			if not self:isFinished(self:getInfoWithDay(iter_7_0).id) then
				return false
			end
		end
	end

	return true
end

function SevenDaysSignInData:isNeedUpdateInfo()
	if self:isExpired() then
		return false
	else
		return var_0_5:isBeforeToday(self._updateInfoTime)
	end
end

function SevenDaysSignInData:isThereRewardToGet()
	for iter_9_0, iter_9_1 in var_0_0.ipairs() do
		if self:getState(iter_9_1.day) == var_0_2.CAN_RECEIVE then
			return true
		end
	end

	return false
end

function SevenDaysSignInData:setAutoNextEnable(arg_10_1)
	self._autoPopNext = arg_10_1
end

function SevenDaysSignInData:isAutoNextPop()
	return self._autoPopNext
end

function SevenDaysSignInData:isThereRewardToGetWithPhase(arg_12_1)
	local var_12_0 = self:phaseDayToDay(arg_12_1, SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS)

	if var_12_0 <= var_0_0.getLength() then
		for iter_12_0 = self:phaseDayToDay(arg_12_1, 1), var_12_0 do
			if self:getState(iter_12_0) == var_0_2.CAN_RECEIVE then
				return true
			end
		end
	end

	return false
end

function SevenDaysSignInData:getCanRcvAwardDayArrWithPhase(arg_13_1)
	local var_13_0 = {}

	for iter_13_0 = self:phaseDayToDay(arg_13_1, 1), math.min(self:phaseDayToDay(arg_13_1, SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS), var_0_0.getLength()) do
		if self:getState(iter_13_0) == var_0_2.CAN_RECEIVE then
			table.insert(var_13_0, iter_13_0)
		end
	end

	return var_13_0
end

function SevenDaysSignInData:getInfoWithDay(arg_14_1)
	return var_0_0.get(arg_14_1)
end

function SevenDaysSignInData:is7DaysSignInAutoPop()
	if var_0_4:isModuleUnlock(var_0_3.SEVEN_DAYS_SIGN_IN) or var_0_4:isModuleUnlock(var_0_3.SEVEN_DAYS_SIGN_IN_2) then
		return self:isThereRewardToGet() or self:isAutoNextPop()
	end
end

function SevenDaysSignInData:isShow7DaysSignIn(arg_16_1)
	if var_0_4:isModuleUnlock(arg_16_1) then
		local var_16_0 = self:getPhaseWithFuncId(arg_16_1)

		if var_16_0 == self:getPhase() then
			return not self:isExpiredWithPhase(var_16_0)
		end
	end
end

function SevenDaysSignInData:getPhaseWithFuncId(arg_17_1)
	if arg_17_1 == var_0_3.SEVEN_DAYS_SIGN_IN_2 then
		return 2
	else
		return 1
	end
end

function SevenDaysSignInData:getPhase()
	local var_18_0 = var_0_0.getLength()

	for iter_18_0, iter_18_1 in var_0_0.ipairs() do
		if not self:isFinished(iter_18_1.id) then
			var_18_0 = iter_18_1.day

			break
		end
	end

	return math.ceil(var_18_0 / SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS)
end

function SevenDaysSignInData:getTodayBigAwardSerialNum(arg_19_1)
	local var_19_0 = self:phaseDayToDay(arg_19_1, 1)
	local var_19_1 = 0

	for iter_19_0 = var_19_0, require("app.core.utils.KsMath").mathClampRange(self._days, var_19_0, (self:phaseDayToDay(arg_19_1, SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS))) do
		local var_19_2 = self:getInfoWithDay(iter_19_0)
		local var_19_3

		if var_19_2.days_reward ~= -1 then
			var_19_1 = var_19_1 + 1
			var_19_3 = var_19_2.days_reward
		end
	end

	return var_19_1
end

function SevenDaysSignInData:getTodayBigAwardDayInfo(arg_20_1)
	return self:getInfoWithDay(self:getInfoWithDay((require("app.core.utils.KsMath").mathClampRange(self._days, self:phaseDayToDay(arg_20_1, 1), (self:phaseDayToDay(arg_20_1, SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS))))).days_reward)
end

function SevenDaysSignInData:isFinished(arg_21_1)
	return self._finishDict[arg_21_1] == 1
end

function SevenDaysSignInData:_setFinished(arg_22_1)
	if arg_22_1 then
		self._finishDict[arg_22_1] = 1
	end
end

function SevenDaysSignInData:phaseDayToDay(arg_23_1, arg_23_2)
	return SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS * (arg_23_1 - 1) + arg_23_2
end

function SevenDaysSignInData:dayToPhaseDay(arg_24_1)
	if arg_24_1 % SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS == 0 then
		return SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS
	else
		return arg_24_1 % SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS
	end
end

function SevenDaysSignInData:isTomorrowCanGetAward(arg_25_1)
	return (self:getPhase() ~= 1 and arg_25_1 > 1 or nil) and self:getState(arg_25_1) == var_0_2.NOT_RECEIVED and self:getState(arg_25_1 - 1) ~= var_0_2.NOT_RECEIVED
end

function SevenDaysSignInData:isEnterSevenDayView()
	local var_26_1 = g.core.common.Storage:load("sevenDayEnter.json", true)

	return (var_26_1 or nil) and var_26_1[self:getPhase()]
end

function SevenDaysSignInData:enterSevenDayView()
	local var_27_0 = g.core.common.Storage:load("sevenDayEnter.json", true) or {}

	var_27_0[self:getPhase()] = true

	g.core.common.Storage:save("sevenDayEnter.json", var_27_0, true)
end

return SevenDaysSignInData
