local LimitChallengeProxy = class("LimitChallengeProxy", import(".NetProxy"))

function LimitChallengeProxy:register()
	self:initData()

	return
end

function LimitChallengeProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_3_0)
			LimitChallengeConst.RequestInfo()

			return
		end
	}
end

function LimitChallengeProxy:initData()
	self.passTimeDict = {}
	self.awardedDict = {}
	self.curMonthPassedIDList = {}

	return
end

function LimitChallengeProxy:setTimeDataFromServer(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self.passTimeDict[iter_5_1.key] = iter_5_1.value
	end

	return
end

function LimitChallengeProxy:setAwardedDataFromServer(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		self.awardedDict[iter_6_1.key] = iter_6_1.value > 0
	end

	return
end

function LimitChallengeProxy:setCurMonthPassedIDList(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(self.curMonthPassedIDList, iter_7_1)
	end

	return
end

function LimitChallengeProxy:setPassTime(arg_8_1, arg_8_2)
	if not self.passTimeDict[arg_8_1] then
		self.passTimeDict[arg_8_1] = arg_8_2
	elseif arg_8_2 < self.passTimeDict[arg_8_1] then
		self.passTimeDict[arg_8_1] = arg_8_2

		self:sendNotification(LimitChallengeConst.UPDATE_PASS_TIME)
	end

	if not table.contains(self.curMonthPassedIDList, arg_8_1) then
		table.insert(self.curMonthPassedIDList, arg_8_1)
	end

	return
end

function LimitChallengeProxy:setAwarded(arg_9_1)
	self.awardedDict[arg_9_1] = true

	return
end

function LimitChallengeProxy:getPassTimeByChallengeID(arg_10_1)
	return self.passTimeDict[arg_10_1]
end

function LimitChallengeProxy:getMissAwardChallengeIDLIst()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(LimitChallengeConst.GetCurMonthConfig().stage) do
		if table.contains(self.curMonthPassedIDList, iter_11_1) and not self:isAwardedByChallengeID(iter_11_1) then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function LimitChallengeProxy:isAwardedByChallengeID(arg_12_1)
	return self.awardedDict[arg_12_1]
end

function LimitChallengeProxy:isLevelUnlock(arg_13_1)
	if arg_13_1 == 1 then
		return true
	end

	if arg_13_1 > 1 then
		return self.awardedDict[LimitChallengeConst.GetChallengeIDByLevel(arg_13_1 - 1)]
	end

	return
end

return LimitChallengeProxy
