class = var_0_10000

local var_0_0 = "SharedIsland"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseIsland"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1.public_data)
	arg_1_0:HandleAgora()

	pg = var_2
	arg_1_0.mapID = var_2.island_set.initial_visitor_scene.key_value_int

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.SetSpawnPointId

	pg = var_5

	var_1_1(var_1_0, var_5.island_set.initial_visitor_spawn_point.key_value_int)

	return
end

function var_0_1.HandleAgora(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetAgoraAgency(var_2_0)
	local var_2_2 = {}

	ipairs = var_2_0
	pg = var_1_10005

	for iter_2_0, iter_2_1 in var_2_0(var_1_10005.island_furniture_template.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.island_furniture_template[iter_2_1]
		table = var_1_10009

		var_1_10009.insert(var_2_2, {
			id = iter_2_1,
			count = var_1_10008.setNum
		})
	end

	local var_2_3 = {
		furniture_list = var_2_2
	}

	var_2_1:InitPrivateData(var_2_3)

	return
end

return var_0_1
