class = var_0_10000

local var_0_0 = "WorldMapTheme"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	angle = "number",
	cellSpace = "table",
	sinAngle = "number",
	offsetx = "number",
	assetSea = "string",
	offsetz = "number",
	cosAngle = "number",
	offsety = "number",
	cellSize = "table",
	fov = "number"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.assetSea = arg_1_1[1]
	arg_1_0.angle = arg_1_1[2]
	arg_1_0.fov = arg_1_1[3]
	arg_1_0.offsetx = arg_1_1[4]
	arg_1_0.offsety = arg_1_1[5]
	Vector2 = var_2
	arg_1_0.cellSize = var_2.New(arg_1_1[6], arg_1_1[7])
	Vector2 = var_2
	arg_1_0.cellSpace = var_2.New(arg_1_1[8], arg_1_1[9])

	local var_1_0

	if not arg_1_1[10] then
		var_1_0 = 0
	end

	arg_1_0.offsetz = var_1_0

	local var_1_1 = arg_1_0.angle / 180

	math = var_1_10003

	local var_1_2 = var_1_1 * var_1_10003.pi

	math = var_3
	arg_1_0.cosAngle = var_3.cos(var_1_2)
	math = var_3
	arg_1_0.sinAngle = var_3.sin(var_1_2)

	return
end

function var_0_1.GetLinePosition(arg_2_0, arg_2_1, arg_2_2)
	Vector2 = var_1_10003

	local var_2_0 = arg_2_2 + 0.5

	WorldConst = var_1_10006

	local var_2_1 = var_1_10003(var_2_0, var_1_10006.MaxRow * 0.5 - arg_2_1 - 0.5)

	Vector3 = var_1_10004

	return var_1_10004(var_2_1.x * (arg_2_0.cellSize.x + arg_2_0.cellSpace.x), var_2_1.y * (arg_2_0.cellSize.y + arg_2_0.cellSpace.y), 0)
end

function var_0_1.X2Column(arg_3_0, arg_3_1)
	math = var_1_10002

	return var_1_10002.round(arg_3_1 / (arg_3_0.cellSize.x + arg_3_0.cellSpace.x) - 0.5)
end

function var_0_1.Y2Row(arg_4_0, arg_4_1)
	math = var_1_10002

	local var_4_0 = var_1_10002.round

	WorldConst = var_1_10004

	return var_4_0(var_1_10004.MaxRow * 0.5 - 0.5 - arg_4_1 / (arg_4_0.cellSize.y + arg_4_0.cellSpace.y))
end

return var_0_1
