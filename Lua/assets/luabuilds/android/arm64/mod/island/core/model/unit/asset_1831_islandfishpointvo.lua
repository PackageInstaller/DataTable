local IslandFishPointVO = class("IslandFishPointVO", import(".IslandUnitVO"))

function IslandFishPointVO:Ctor(arg_1_1, arg_1_2)
	IslandFishPointVO.super.Ctor(self, {
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

return IslandFishPointVO
