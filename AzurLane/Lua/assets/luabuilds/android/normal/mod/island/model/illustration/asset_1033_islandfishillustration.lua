class = var_0_10000

local var_0_0 = "IslandFishIllustration"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandIllustration"))

var_0_1.MIN_CUP_KEY = 1
var_0_1.MAX_CUP_KEY = 2

function var_0_1.InitConfigData(arg_1_0)
	local var_1_0 = 0

	arg_1_0.maxCupPoint = 0
	arg_1_0.minCupPoint = var_1_0
	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(arg_1_0:getConfig("collect_star")) do
		switch = var_1_10006

		var_1_10006(iter_1_1[1], {
			[var_0_1.MIN_CUP_KEY] = function()
				arg_1_0.minCupPoint = iter_1_1[2]

				return
			end,
			[var_0_1.MAX_CUP_KEY] = function()
				arg_1_0.maxCupPoint = iter_1_1[2]

				return
			end
		})
	end

	return
end

function var_0_1.GetReachPoints(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0

	if arg_4_1 then
		var_4_0 = var_4_0 + arg_4_0.minCupPoint
	end

	if arg_4_2 then
		var_4_0 = var_4_0 + arg_4_0.maxCupPoint
	end

	return arg_4_0.basePoint + var_4_0
end

function var_0_1.CheckTip(arg_5_0)
	if arg_5_0.status == var_0_1.STATUS.CAN_UNLOCK then
		arg_5_0.isTip = true

		return
	end

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.GetLinkConfigID(var_5_0)

	getProxy = var_5_0
	IslandProxy = var_1_10003

	local var_5_2 = var_5_0(var_1_10003)
	local var_5_3 = var_2.GetIsland(var_5_2)
	local var_5_4 = var_2.GetFishingAgency(var_5_3)

	if not var_2.GetFish(var_5_4, var_5_1) then
		arg_5_0.isTip = false

		return
	end

	arg_5_0.isTip = arg_5_0:GetReachPoints(var_2:ReachMinCup(), var_2:ReachMaxCup()) > arg_5_0:GetPoints()

	return
end

function var_0_1.IsGotMinCup(arg_6_0)
	return arg_6_0.starPointGotData[var_0_1.MIN_CUP_KEY]
end

function var_0_1.IsGotMaxCup(arg_7_0)
	return arg_7_0.starPointGotData[var_0_1.MAX_CUP_KEY]
end

return var_0_1
