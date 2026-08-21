local var_0_0 = class("ChapterTheme")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.assetSea = arg_1_1[1]
	arg_1_0.angle = arg_1_1[2]
	arg_1_0.fov = arg_1_1[3]
	arg_1_0.offsetx = arg_1_1[4]
	arg_1_0.offsety = arg_1_1[5]
	arg_1_0.offsetz = 0
	arg_1_0.cellSize = Vector2.New(arg_1_1[6], arg_1_1[7])
	arg_1_0.cellSpace = Vector2.New(arg_1_1[8], arg_1_1[9])
	arg_1_0.seaBase = arg_1_1[10]

	return
end

function var_0_0.GetLinePosition(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = Vector2(arg_2_2 + 0.5, ChapterConst.MaxRow * 0.5 - arg_2_1 - 0.5)

	return Vector3(var_2_0.x * (arg_2_0.cellSize.x + arg_2_0.cellSpace.x), var_2_0.y * (arg_2_0.cellSize.y + arg_2_0.cellSpace.y), 0)
end

return var_0_0
