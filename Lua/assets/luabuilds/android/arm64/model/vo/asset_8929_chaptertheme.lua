local ChapterTheme = class("ChapterTheme")

function ChapterTheme:Ctor(arg_1_1)
	self.assetSea = arg_1_1[1]
	self.angle = arg_1_1[2]
	self.fov = arg_1_1[3]
	self.offsetx = arg_1_1[4]
	self.offsety = arg_1_1[5]
	self.offsetz = 0
	self.cellSize = Vector2.New(arg_1_1[6], arg_1_1[7])
	self.cellSpace = Vector2.New(arg_1_1[8], arg_1_1[9])
	self.seaBase = arg_1_1[10]

	return
end

function ChapterTheme:GetLinePosition(arg_2_1, arg_2_2)
	local var_2_0 = Vector2(arg_2_2 + 0.5, ChapterConst.MaxRow * 0.5 - arg_2_1 - 0.5)

	return Vector3(var_2_0.x * (self.cellSize.x + self.cellSpace.x), var_2_0.y * (self.cellSize.y + self.cellSpace.y), 0)
end

return ChapterTheme
