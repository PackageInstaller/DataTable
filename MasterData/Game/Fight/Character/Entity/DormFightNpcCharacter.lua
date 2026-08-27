local DormFightCharacterBase = require("Game.Fight.Character.Entity.DormFightCharacterBase")
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightNpcCharacter = class("DormFightNpcCharacter", DormFightCharacterBase)

function DormFightNpcCharacter:FillFeatures()
  self:AddFeature(DormFightConst.FeatureEnum.ModelController)
  self:AddFeature(DormFightConst.FeatureEnum.AnimatorController)
  self:AddFeature(DormFightConst.FeatureEnum.AiController)
  self:AddFeature(DormFightConst.FeatureEnum.VitalityController)
  self:AddFeature(DormFightConst.FeatureEnum.PropertyController)
  self:AddFeature(DormFightConst.FeatureEnum.SceneUiController)
end

function DormFightNpcCharacter:GetCharacterType()
  return DormFightConst.CharacterType.Npc
end

return DormFightNpcCharacter
