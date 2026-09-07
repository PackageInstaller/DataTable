local ActivityLevelConst = class("ActivityLevelConst")

function ActivityLevelConst:getExtraChapterSocre(arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_3 or arg_1_3:isEnd() then
		return 0, 0
	end

	local var_1_0 = arg_1_3:getConfig("config_data")

	assert(var_1_0, "miss config >>" .. self)

	local var_1_1 = 0

	if var_1_0 then
		var_1_1 = (var_1_0[2] / math.pow(arg_1_1 + var_1_0[3], var_1_0[4]) - math.pow(arg_1_2, var_1_0[5])) * var_1_0[6]
		var_1_1 = math.max(var_1_1, 1)

		local var_1_3 = math.floor(var_1_1)
	end

	local var_1_4 = math.floor(arg_1_3:getData1() or 0)
end

function ActivityLevelConst:getShipsPower()
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in pairs(self) do
		var_2_0 = var_2_0 + iter_2_1:getShipCombatPower()
	end

	return var_2_0
end

return ActivityLevelConst
