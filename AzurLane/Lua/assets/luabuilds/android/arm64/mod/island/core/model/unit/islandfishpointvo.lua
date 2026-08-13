class = var_0_10000

local var_0_0 = "IslandFishPointVO"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	local var_1_0 = var_1_10003.island_world_objects[arg_1_2]
	local var_1_1 = var_0_1.super.Ctor
	local var_1_2 = arg_1_0
	local var_1_3 = {
		behaviourTree = "",
		id = arg_1_1,
		name = "fishPoint" .. arg_1_1
	}

	IslandConst = var_8
	var_1_3.type = var_8.UNIT_TYPE_FISH_POINT
	var_1_3.modelId = var_1_0.unitId
	var_1_3.position = var_1_0.param.position
	var_1_3.rotation = var_1_0.param.rotation
	var_1_3.scale = {
		1,
		1,
		1
	}

	var_1_1(var_1_2, var_1_3)

	return
end

return var_0_1
