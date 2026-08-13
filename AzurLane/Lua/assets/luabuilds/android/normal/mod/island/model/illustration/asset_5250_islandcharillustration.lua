class = var_0_10000

local var_0_0 = "IslandCharIllustration"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandIllustration"))

function var_0_1.GetReachPoints(arg_1_0, arg_1_1, arg_1_2)
	underscore = var_1_10003

	local var_1_0 = var_1_10003.reduce(arg_1_0:getConfig("collect_upgrade"), 0, function(arg_2_0, arg_2_1)
		local var_2_0

		if not (arg_1_1 >= arg_2_1[1]) or not arg_2_1[2] then
			var_2_0 = 0
		end

		return arg_2_0 + var_2_0
	end)

	underscore = var_4

	local var_1_1 = var_4.reduce(arg_1_0:getConfig("collect_star"), 0, function(arg_3_0, arg_3_1)
		local var_3_0

		if not (arg_1_2 >= arg_3_1[1]) or not arg_3_1[2] then
			var_3_0 = 0
		end

		return arg_3_0 + var_3_0
	end)

	return arg_1_0.basePoint + var_1_0 + var_1_1
end

function var_0_1.CheckTip(arg_4_0)
	if arg_4_0.status == var_0_1.STATUS.CAN_UNLOCK then
		arg_4_0.isTip = true

		return
	end

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.GetLinkConfigID(var_4_0)

	getProxy = var_4_0
	IslandProxy = var_1_10003

	local var_4_2 = var_4_0(var_1_10003)
	local var_4_3 = var_2.GetIsland(var_4_2)
	local var_4_4 = var_2.GetCharacterAgency(var_4_3)

	if not var_2.GetShipById(var_4_4, var_4_1) then
		arg_4_0.isTip = false

		return
	end

	local var_4_5 = var_2:GetLevel()
	local var_4_6 = var_2:GetBreakLevel()

	arg_4_0.isTip = arg_4_0:GetReachPoints(var_4_5, var_4_6) > arg_4_0:GetPoints()

	return
end

return var_0_1
