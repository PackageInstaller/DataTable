class = var_0_10000

local var_0_0 = "IslandCardDiyAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.data = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.image_list) do
		local var_1_0 = arg_1_0.data
		local var_1_1 = iter_1_1.id

		IslandCardDiy = var_1_10009
		var_1_0[var_1_1] = var_1_10009.New(iter_1_1)
	end

	pg = var_2

	local var_1_2 = var_2.island_set.island_card_photo_default.key_value_int

	if not arg_1_0.data[var_1_2] then
		local var_1_3 = arg_1_0.data

		IslandCardDiy = var_4
		var_1_3[var_1_2] = var_4.New({
			num = 1,
			id = var_1_2
		})
	end

	return
end

function var_0_1.GetData(arg_2_0)
	return arg_2_0.data
end

function var_0_1.GetIds(arg_3_0)
	underscore = var_1_10001

	return var_1_10001.keys(arg_3_0.data)
end

function var_0_1.GetIdCount(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0.data[arg_4_1] or not arg_4_0.data[arg_4_1].count then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_1.AddCardDiy(arg_5_0, arg_5_1)
	if arg_5_0.data[arg_5_1.id] then
		local var_5_0 = arg_5_0.data[arg_5_1.id]

		var_2.AddCount(var_5_0, arg_5_1.num)
	else
		local var_5_1 = arg_5_0.data
		local var_5_2 = arg_5_1.id

		IslandCardDiy = var_1_10004
		var_5_1[var_5_2] = var_1_10004.New(arg_5_1)
	end

	return
end

return var_0_1
