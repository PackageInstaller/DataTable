local WorldMapTheme = class("WorldMapTheme", import("...BaseEntity"))

WorldMapTheme.Fields = {
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

function WorldMapTheme:Setup(arg_1_1)
	self.assetSea = arg_1_1[1]
	self.angle = arg_1_1[2]
	self.fov = arg_1_1[3]
	self.offsetx = arg_1_1[4]
	self.offsety = arg_1_1[5]
	self.cellSize = Vector2.New(arg_1_1[6], arg_1_1[7])
	self.cellSpace = Vector2.New(arg_1_1[8], arg_1_1[9])
	self.offsetz = arg_1_1[10] or 0
	self.cosAngle = math.cos(self.angle / 180 * math.pi)
	self.sinAngle = math.sin(self.angle / 180 * math.pi)

	return
end

function WorldMapTheme:GetLinePosition(arg_2_1, arg_2_2)
	local var_2_0 = Vector2(arg_2_2 + 0.5, WorldConst.MaxRow * 0.5 - arg_2_1 - 0.5)

	return Vector3(var_2_0.x * (self.cellSize.x + self.cellSpace.x), var_2_0.y * (self.cellSize.y + self.cellSpace.y), 0)
end

function WorldMapTheme:X2Column(arg_3_1)
	return math.round(arg_3_1 / (self.cellSize.x + self.cellSpace.x) - 0.5)
end

function WorldMapTheme:Y2Row(arg_4_1)
	return math.round(WorldConst.MaxRow * 0.5 - 0.5 - arg_4_1 / (self.cellSize.y + self.cellSpace.y))
end

return WorldMapTheme
