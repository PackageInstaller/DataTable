local MapRole = import(".MapRole")
local MapItem = import(".MapItem")
local MapConst = import("..MapConst")
local MapVisualEmptySpace = import(".MapVisualEmptySpace")
local MapVisualImage = import(".MapVisualImage")
local MapVisualEffect = import(".MapVisualEffect")
local MapVisualKnight = import(".MapVisualKnight")

return {
	createEntity = function(self)
		return self.type == MapConst.RESTYPE.KNIGHT and MapRole.new(self) or MapItem.new(self, "bio")
	end,
	createVisual = function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		return arg_2_0 == MapConst.RESTYPE.IMAGE and MapVisualImage.new(arg_2_1, "bio", arg_2_2, arg_2_3) or arg_2_0 == MapConst.RESTYPE.SPINE and MapVisualEffect.new(arg_2_1) or arg_2_0 == MapConst.RESTYPE.EMPTY_SPACE and MapVisualEmptySpace.new() or MapVisualKnight.new(arg_2_1)
	end,
	createRecord = function()
		return {
			bindID = 0,
			offy = 0,
			offx = 0,
			scale = 1,
			flip = false
		}
	end,
	copyRecord = function(self)
		return {
			resID = self.resID,
			type = self.type,
			flip = self.flip,
			scale = self.scale,
			offx = self.offx,
			offy = self.offy,
			bindID = self.bindID,
			isMain = self.isMain,
			dName = self.dName,
			bParam = self.bParam
		}
	end
}
