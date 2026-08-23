local MapRole = require("app.core.ksmap.entity.MapRole")
local MapItem = require("app.core.ksmap.entity.MapItem")
local MysterMapConst = import("..MysterMapConst")
local MapVisualEmptySpace = require("app.core.ksmap.entity.MapVisualEmptySpace")
local MapVisualImage = require("app.core.ksmap.entity.MapVisualImage")
local MapVisualEffect = require("app.core.ksmap.entity.MapVisualEffect")
local MysteryRoleVirtual = require("app.view.module.mystery.view.map.Entity.MysteryRoleVirtual")
local EntityFactory = require("app.core.ksmap.entity.EntityFactory")
local ExploreEntityFactory = class("ExploreEntityFactory", EntityFactory)

function EntityFactory:createEntity()
	return self.type == MysterMapConst.RESTYPE.KNIGHT and MapRole.new(self) or MapItem.new(self, "bio")
end

function ExploreEntityFactory:createVisual(arg_2_1, arg_2_2, arg_2_3)
	return self == MysterMapConst.RESTYPE.IMAGE and MapVisualImage.new(arg_2_1, "bio", arg_2_2, arg_2_3) or self == MysterMapConst.RESTYPE.SPINE and MapVisualEffect.new(arg_2_1) or self == MysterMapConst.RESTYPE.EMPTY_SPACE and MapVisualEmptySpace.new() or MysteryRoleVirtual.new(arg_2_1, arg_2_2)
end

return ExploreEntityFactory
