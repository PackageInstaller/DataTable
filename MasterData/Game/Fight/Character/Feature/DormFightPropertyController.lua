local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightHelper = require("Game.Fight.DormFightHelper")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightPropertyController = class("DormFightPropertyController", DormFightCharacterFeatureBase)

function DormFightPropertyController:ctor()
end

function DormFightPropertyController:OnInit()
end

function DormFightPropertyController:GetProperty(propertyType)
  return DormFightHelper.GetPropertyValue(propertyType)
end

return DormFightPropertyController
