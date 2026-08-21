local var_0_0 = class("IslandCharIllustration", import(".IslandIllustration"))

function var_0_0.GetReachPoints(arg_1_0, arg_1_1, arg_1_2)
	return arg_1_0.basePoint + underscore.reduce(arg_1_0:getConfig("collect_upgrade"), 0, function(arg_2_0, arg_2_1)
		if arg_1_1 >= arg_2_1[1] then
			local var_2_0 = arg_2_1[2] or 0

			return arg_2_0 + var_2_0
		end
	end) + underscore.reduce(arg_1_0:getConfig("collect_star"), 0, function(arg_3_0, arg_3_1)
		if arg_1_2 >= arg_3_1[1] then
			local var_3_0 = arg_3_1[2] or 0

			return arg_3_0 + var_3_0
		end
	end)
end

function var_0_0.CheckTip(arg_4_0)
	if arg_4_0.status == var_0_0.STATUS.CAN_UNLOCK then
		arg_4_0.isTip = true

		return
	end

	local var_4_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById((arg_4_0:GetLinkConfigID()))
	local var_4_1, var_4_2, var_4_3

	if not var_4_0 then
		arg_4_0.isTip = false

		do return end

		var_4_1 = var_4_0:GetBreakLevel()
		var_4_2 = arg_4_0
		var_4_3 = arg_4_0.GetReachPoints
	end

	arg_4_0.isTip = var_4_3(var_4_2, var_4_0:GetLevel(), var_4_1) > arg_4_0:GetPoints()

	return
end

return var_0_0
