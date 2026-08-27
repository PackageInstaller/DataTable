local DormFightCharacterBase = require("Game.Fight.Character.Entity.DormFightCharacterBase")
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightPlayerCharacter = class("DormFightPlayerCharacter", DormFightCharacterBase)

function DormFightPlayerCharacter:FillFeatures()
  self:AddFeature(DormFightConst.FeatureEnum.ModelController)
  self:AddFeature(DormFightConst.FeatureEnum.AnimatorController)
  self:AddFeature(DormFightConst.FeatureEnum.InputController)
  self:AddFeature(DormFightConst.FeatureEnum.VitalityController)
  self:AddFeature(DormFightConst.FeatureEnum.PropertyController)
  self:AddFeature(DormFightConst.FeatureEnum.SceneUiController)
end

function DormFightPlayerCharacter:GetCharacterType()
  return DormFightConst.CharacterType.Player
end

return DormFightPlayerCharacter
