class = var_0_10000

local var_0_0 = "LimitChallengeProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0:initData()

	return
end

function var_0_1.timeCall(arg_2_0)
	local var_2_0 = {}

	ProxyRegister = var_1_10002
	var_2_0[var_1_10002.DayCall] = function(arg_3_0)
		LimitChallengeConst = var_2_10001

		var_2_10001.RequestInfo()

		return
	end

	return var_2_0
end

function var_0_1.initData(arg_4_0)
	arg_4_0.passTimeDict = {}
	arg_4_0.awardedDict = {}
	arg_4_0.curMonthPassedIDList = {}

	return
end

function var_0_1.setTimeDataFromServer(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_1) do
		local var_5_0 = iter_5_1.key
		local var_5_1 = iter_5_1.value

		arg_5_0.passTimeDict[var_5_0] = var_5_1
	end

	return
end

function var_0_1.setAwardedDataFromServer(arg_6_0, arg_6_1)
	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_1) do
		local var_6_0 = iter_6_1.key
		local var_6_1 = iter_6_1.value > 0

		arg_6_0.awardedDict[var_6_0] = var_6_1
	end

	return
end

function var_0_1.setCurMonthPassedIDList(arg_7_0, arg_7_1)
	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_1) do
		table = var_1_10007

		var_1_10007.insert(arg_7_0.curMonthPassedIDList, iter_7_1)
	end

	return
end

function var_0_1.setPassTime(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.passTimeDict[arg_8_1] then
		var_1_10004 = arg_8_0.passTimeDict
		var_1_10004[arg_8_1] = arg_8_2
	elseif arg_8_2 < var_3 then
		var_1_10004 = arg_8_0.passTimeDict
		var_1_10004[arg_8_1] = arg_8_2

		local var_8_0 = arg_8_0

		var_1_10004 = arg_8_0.sendNotification
		LimitChallengeConst = var_1_10006

		var_1_10004(var_8_0, var_1_10006.UPDATE_PASS_TIME)
	end

	table = var_1_10004

	if not var_1_10004.contains(arg_8_0.curMonthPassedIDList, arg_8_1) then
		table = var_4

		var_4.insert(arg_8_0.curMonthPassedIDList, arg_8_1)
	end

	return
end

function var_0_1.setAwarded(arg_9_0, arg_9_1)
	arg_9_0.awardedDict[arg_9_1] = true

	return
end

function var_0_1.getPassTimeByChallengeID(arg_10_0, arg_10_1)
	return arg_10_0.passTimeDict[arg_10_1]
end

function var_0_1.getMissAwardChallengeIDLIst(arg_11_0)
	local var_11_0 = {}

	LimitChallengeConst = var_1_10002

	local var_11_1 = var_1_10002.GetCurMonthConfig().stage

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(var_11_1) do
		table = var_1_10009
		var_1_10009 = var_1_10009.contains(arg_11_0.curMonthPassedIDList, iter_11_1)

		local var_11_2 = arg_11_0
		local var_11_3 = arg_11_0.isAwardedByChallengeID(var_11_2, iter_11_1)

		if var_1_10009 and not var_11_3 then
			table = var_11_2

			var_11_2.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_1.isAwardedByChallengeID(arg_12_0, arg_12_1)
	return arg_12_0.awardedDict[arg_12_1]
end

function var_0_1.isLevelUnlock(arg_13_0, arg_13_1)
	if arg_13_1 == 1 then
		return true
	end

	if 1 < arg_13_1 then
		LimitChallengeConst = var_2

		local var_13_0 = var_2.GetChallengeIDByLevel(arg_13_1 - 1)

		return arg_13_0.awardedDict[var_13_0]
	end

	return
end

return var_0_1
