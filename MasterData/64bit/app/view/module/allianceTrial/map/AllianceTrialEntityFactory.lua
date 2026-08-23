local MapRole = require("app.core.ksmap.entity.MapRole")
local MapItem = require("app.core.ksmap.entity.MapItem")
local AllianceTrialMapConst = require("app.view.module.allianceTrial.const.AllianceTrialMapConst")
local MapVisualEmptySpace = require("app.core.ksmap.entity.MapVisualEmptySpace")
local MapVisualImage = require("app.core.ksmap.entity.MapVisualImage")
local MapVisualEffect = require("app.core.ksmap.entity.MapVisualEffect")
local AllianceTrialVisualKnight = require("app.view.module.allianceTrial.map.entity.AllianceTrialVisualKnight")
local ExploreEntityFactory = class("ExploreEntityFactory", (require("app.core.ksmap.entity.EntityFactory")))

function ExploreEntityFactory:createEntity()
	return self.type == AllianceTrialMapConst.RESTYPE.KNIGHT and MapRole.new(self) or MapItem.new(self, "bio")
end

function ExploreEntityFactory:createVisual(arg_2_1, arg_2_2, arg_2_3)
	return self == AllianceTrialMapConst.RESTYPE.IMAGE and MapVisualImage.new(arg_2_1, "bio", arg_2_2, arg_2_3) or self == AllianceTrialMapConst.RESTYPE.SPINE and MapVisualEffect.new(arg_2_1) or self == AllianceTrialMapConst.RESTYPE.EMPTY_SPACE and MapVisualEmptySpace.new() or AllianceTrialVisualKnight.new(arg_2_1, arg_2_2)
end

return ExploreEntityFactory
