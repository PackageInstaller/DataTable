local MapVisualEmptySpace = require("app.core.ksmap.entity.MapVisualEmptySpace")
local StormMapItem = require("app.view.module.storm.base.StormMapItem")
local MapConst = require("app.core.ksmap.MapConst")
local MapVisualImage = require("app.core.ksmap.entity.MapVisualImage")
local MapVisualEffect = require("app.core.ksmap.entity.MapVisualEffect")
local StormMainRole = require("app.view.module.storm.base.StormMainRole")
local StormRoleVirtual = require("app.view.module.storm.base.StormRoleVirtual")
local TeamBattleEntityFactory = class("TeamBattleEntityFactory", (require("app.core.ksmap.entity.EntityFactory")))

function TeamBattleEntityFactory:createEntity()
	return self.type == MapConst.RESTYPE.KNIGHT and StormMainRole.new(self) or StormMapItem.new(self, "bio")
end

function TeamBattleEntityFactory:createVisual(arg_2_1, arg_2_2, arg_2_3)
	return self == MapConst.RESTYPE.IMAGE and MapVisualImage.new(arg_2_1, "bio", arg_2_2, arg_2_3) or self == MapConst.RESTYPE.SPINE and MapVisualEffect.new(arg_2_1) or self == MapConst.RESTYPE.EMPTY_SPACE and MapVisualEmptySpace.new() or StormRoleVirtual.new(arg_2_1)
end

return TeamBattleEntityFactory
