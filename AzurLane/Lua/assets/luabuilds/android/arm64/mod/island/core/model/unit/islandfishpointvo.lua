local var_0_0 = class("IslandFishPointVO", import(".IslandUnitVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, {
		behaviourTree = "",
		id = arg_1_1,
		name = "fishPoint" .. arg_1_1,
		type = IslandConst.UNIT_TYPE_FISH_POINT,
		modelId = pg.island_world_objects[arg_1_2].unitId,
		position = pg.island_world_objects[arg_1_2].param.position,
		rotation = pg.island_world_objects[arg_1_2].param.rotation,
		scale = {
			1,
			1,
			1
		}
	})

	return
end

return var_0_0
