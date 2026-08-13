class = var_0_10000

local var_0_0 = "IslandItemIllustration"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandIllustration"))

function var_0_1.GetReachPoints(arg_1_0)
	underscore = var_1_10001

	local var_1_0 = var_1_10001.reduce(arg_1_0:getConfig("collect_star"), 0, function(arg_2_0, arg_2_1)
		local var_2_0

		if not (arg_1_0.historyCount >= arg_2_1[1]) or not arg_2_1[2] then
			var_2_0 = 0
		end

		return arg_2_0 + var_2_0
	end)

	return arg_1_0.basePoint + var_1_0
end

function var_0_1.CheckTip(arg_3_0)
	if arg_3_0.status == var_0_1.STATUS.CAN_UNLOCK then
		arg_3_0.isTip = true

		return
	end

	arg_3_0.isTip = arg_3_0:GetReachPoints() > arg_3_0:GetPoints()

	return
end

function var_0_1.SetHistoryCnt(arg_4_0, arg_4_1)
	arg_4_0.historyCount = arg_4_1

	arg_4_0:CheckTip()

	return
end

function var_0_1.GetHistoryCnt(arg_5_0)
	return arg_5_0.historyCount
end

function var_0_1.AddHistoryCnt(arg_6_0, arg_6_1)
	arg_6_0.historyCount = arg_6_0.historyCount + arg_6_1

	return
end

function var_0_1.GetCurPhase(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.getConfig(var_7_0, "collect_star")
	local var_7_2 = 0

	ipairs = var_7_0

	for iter_7_0, iter_7_1 in var_7_0(var_7_1) do
		if arg_7_0.starPointGotData[iter_7_1[1]] then
			var_7_2 = iter_7_0
		end
	end

	return var_7_2
end

function var_0_1.GetCurTarget(arg_8_0)
	local var_8_0 = arg_8_0:getConfig("collect_star")

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(var_8_0) do
		if not arg_8_0.starPointGotData[iter_8_1[1]] then
			return iter_8_1[1]
		end
	end

	return nil
end

return var_0_1
