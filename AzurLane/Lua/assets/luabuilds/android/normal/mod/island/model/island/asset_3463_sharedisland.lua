class = var_0_10000

local var_0_0 = "SharedIsland"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseIsland"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1.public_data)
	arg_1_0:HandleAgora()

	pg = var_2
	arg_1_0.mapID = var_2.island_set.initial_visitor_scene.key_value_int

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.SetSpawnPointId

	pg = var_4

	var_1_1(var_1_0, var_4.island_set.initial_visitor_spawn_point.key_value_int)

	return
end

function var_0_1.HandleAgora(arg_2_0)
	local var_2_0 = arg_2_0:GetAgoraAgency()
	local var_2_1 = {}

	ipairs = var_1_10003
	pg = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10003(var_1_10004.island_furniture_template.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.island_furniture_template[iter_2_1]
		table = var_1_10009

		var_1_10009.insert(var_2_1, {
			id = iter_2_1,
			count = var_1_10008.setNum
		})
	end

	local var_2_2 = {
		furniture_list = var_2_1
	}

	var_2_0:InitPrivateData(var_2_2)

	return
end

return var_0_1
