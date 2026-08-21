local var_0_0 = class("IslandItemIllustration", import(".IslandIllustration"))

function var_0_0.GetReachPoints(arg_1_0)
	return arg_1_0.basePoint + underscore.reduce(arg_1_0:getConfig("collect_star"), 0, function(arg_2_0, arg_2_1)
		if arg_1_0.historyCount >= arg_2_1[1] then
			local var_2_0 = arg_2_1[2] or 0

			return arg_2_0 + var_2_0
		end
	end)
end

function var_0_0.CheckTip(arg_3_0)
	if arg_3_0.status == var_0_0.STATUS.CAN_UNLOCK then
		arg_3_0.isTip = true

		return
	end

	arg_3_0.isTip = arg_3_0:GetReachPoints() > arg_3_0:GetPoints()

	return
end

function var_0_0.SetHistoryCnt(arg_4_0, arg_4_1)
	arg_4_0.historyCount = arg_4_1

	arg_4_0:CheckTip()

	return
end

function var_0_0.GetHistoryCnt(arg_5_0)
	return arg_5_0.historyCount
end

function var_0_0.AddHistoryCnt(arg_6_0, arg_6_1)
	arg_6_0.historyCount = arg_6_0.historyCount + arg_6_1

	return
end

function var_0_0.GetCurPhase(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs((arg_7_0:getConfig("collect_star"))) do
		if arg_7_0.starPointGotData[iter_7_1[1]] then
			var_7_0 = iter_7_0
		end
	end

	return var_7_0
end

function var_0_0.GetCurTarget(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs((arg_8_0:getConfig("collect_star"))) do
		if not arg_8_0.starPointGotData[iter_8_1[1]] then
			return iter_8_1[1]
		end
	end

	return nil
end

return var_0_0
