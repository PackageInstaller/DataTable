class = var_0_10000

local var_0_0 = var_0_10000("ActivityLevelConst")

function var_0_0.getExtraChapterSocre(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_3 or arg_1_3:isEnd() then
		return 0, 0
	end

	local var_1_0 = arg_1_3:getConfig("config_data")

	assert = var_1_10005

	var_1_10005(var_1_0, "miss config >>" .. arg_1_0)

	local var_1_1 = 0
	local var_1_2 = 0

	if var_1_0 then
		local var_1_3 = var_1_0[2]

		math = var_8

		local var_1_4 = var_1_3 / var_8.pow(arg_1_1 + var_1_0[3], var_1_0[4])

		math = var_8
		var_1_1 = (var_1_4 - var_8.pow(arg_1_2, var_1_0[5])) * var_1_0[6]
		math = var_7
		var_1_1 = var_7.max(var_1_1, 1)
	end

	local var_1_5 = arg_1_3:getData1() or 0

	math = var_7

	local var_1_6 = var_7.floor(var_1_1)

	math = var_8

	local var_1_7 = var_8.floor(var_1_5)
end

function var_0_0.getShipsPower(arg_2_0)
	local var_2_0 = 0

	pairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0) do
		var_2_0 = var_2_0 + iter_2_1:getShipCombatPower()
	end

	return var_2_0
end

return var_0_0
