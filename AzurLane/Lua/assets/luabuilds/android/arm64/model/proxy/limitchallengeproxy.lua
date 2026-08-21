local var_0_0 = class("LimitChallengeProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0:initData()

	return
end

function var_0_0.timeCall(arg_2_0)
	return {
		[ProxyRegister.DayCall] = function(arg_3_0)
			LimitChallengeConst.RequestInfo()

			return
		end
	}
end

function var_0_0.initData(arg_4_0)
	arg_4_0.passTimeDict = {}
	arg_4_0.awardedDict = {}
	arg_4_0.curMonthPassedIDList = {}

	return
end

function var_0_0.setTimeDataFromServer(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0.passTimeDict[iter_5_1.key] = iter_5_1.value
	end

	return
end

function var_0_0.setAwardedDataFromServer(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0.awardedDict[iter_6_1.key] = iter_6_1.value > 0
	end

	return
end

function var_0_0.setCurMonthPassedIDList(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(arg_7_0.curMonthPassedIDList, iter_7_1)
	end

	return
end

function var_0_0.setPassTime(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.passTimeDict[arg_8_1] then
		arg_8_0.passTimeDict[arg_8_1] = arg_8_2
	elseif arg_8_2 < arg_8_0.passTimeDict[arg_8_1] then
		arg_8_0.passTimeDict[arg_8_1] = arg_8_2

		arg_8_0:sendNotification(LimitChallengeConst.UPDATE_PASS_TIME)
	end

	if not table.contains(arg_8_0.curMonthPassedIDList, arg_8_1) then
		table.insert(arg_8_0.curMonthPassedIDList, arg_8_1)
	end

	return
end

function var_0_0.setAwarded(arg_9_0, arg_9_1)
	arg_9_0.awardedDict[arg_9_1] = true

	return
end

function var_0_0.getPassTimeByChallengeID(arg_10_0, arg_10_1)
	return arg_10_0.passTimeDict[arg_10_1]
end

function var_0_0.getMissAwardChallengeIDLIst(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(LimitChallengeConst.GetCurMonthConfig().stage) do
		local var_11_0 = arg_11_0:isAwardedByChallengeID(iter_11_1)

		if table.contains(arg_11_0.curMonthPassedIDList, iter_11_1) and not var_11_0 then
			table.insert({}, iter_11_1)
		end
	end

	return {}
end

function var_0_0.isAwardedByChallengeID(arg_12_0, arg_12_1)
	return arg_12_0.awardedDict[arg_12_1]
end

function var_0_0.isLevelUnlock(arg_13_0, arg_13_1)
	if arg_13_1 == 1 then
		return true
	end

	if arg_13_1 > 1 then
		return arg_13_0.awardedDict[LimitChallengeConst.GetChallengeIDByLevel(arg_13_1 - 1)]
	end

	return
end

return var_0_0
