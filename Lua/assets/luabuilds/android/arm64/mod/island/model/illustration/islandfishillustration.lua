local var_0_0 = class("IslandFishIllustration", import(".IslandIllustration"))

var_0_0.MIN_CUP_KEY = 1
var_0_0.MAX_CUP_KEY = 2

function var_0_0.InitConfigData(arg_1_0)
	arg_1_0.minCupPoint, arg_1_0.maxCupPoint = 0, 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:getConfig("collect_star")) do
		switch(iter_1_1[1], {
			[var_0_0.MIN_CUP_KEY] = function()
				arg_1_0.minCupPoint = iter_1_1[2]

				return
			end,
			[var_0_0.MAX_CUP_KEY] = function()
				arg_1_0.maxCupPoint = iter_1_1[2]

				return
			end
		})
	end

	return
end

function var_0_0.GetReachPoints(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0

	if arg_4_1 then
		var_4_0 = var_4_0 + arg_4_0.minCupPoint
	end

	if arg_4_2 then
		var_4_0 = var_4_0 + arg_4_0.maxCupPoint
	end

	return arg_4_0.basePoint + var_4_0
end

function var_0_0.CheckTip(arg_5_0)
	if arg_5_0.status == var_0_0.STATUS.CAN_UNLOCK then
		arg_5_0.isTip = true

		return
	end

	local var_5_0 = getProxy(IslandProxy):GetIsland():GetFishingAgency():GetFish((arg_5_0:GetLinkConfigID()))

	if not var_5_0 then
		arg_5_0.isTip = false

		return
	end

	arg_5_0.isTip = arg_5_0:GetReachPoints(var_5_0:ReachMinCup(), var_5_0:ReachMaxCup()) > arg_5_0:GetPoints()

	return
end

function var_0_0.IsGotMinCup(arg_6_0)
	return arg_6_0.starPointGotData[var_0_0.MIN_CUP_KEY]
end

function var_0_0.IsGotMaxCup(arg_7_0)
	return arg_7_0.starPointGotData[var_0_0.MAX_CUP_KEY]
end

return var_0_0
