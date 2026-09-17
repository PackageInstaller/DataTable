local TileSprite = require("view.Sprite.rogue_explore.TileSprite")
local PathGoldTile = class("PathGoldTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)

function PathGoldTile:create(arg_2_1)
	local var_2_0 = PathGoldTile.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:initOther()

	return var_2_0
end

function PathGoldTile:initOther()
	self.isCanTrigger = true
end

function PathGoldTile:checkIsCanTrigger()
	return self.isCanTrigger
end

function PathGoldTile:triggerEvent(arg_5_1)
	self.isCanTrigger = false

	TileSprite.triggerEvent(self, arg_5_1)
end

return PathGoldTile
