local DormFightConst = require("Game.Fight.DormFightConst")
local FeatureFactory = {}

function FeatureFactory.CreateFeature(featureType)
  local res
  if featureType == DormFightConst.FeatureEnum.ModelController then
    res = require("Game.Fight.Character.Feature.DormFightModelController").New()
  elseif featureType == DormFightConst.FeatureEnum.PropertyController then
    res = require("Game.Fight.Character.Feature.DormFightPropertyController").New()
  elseif featureType == DormFightConst.FeatureEnum.AnimatorController then
    res = require("Game.Fight.Character.Feature.DormFightAnimatorController").New()
  elseif featureType == DormFightConst.FeatureEnum.VitalityController then
    res = require("Game.Fight.Character.Feature.DormFightVitalityController").New()
  elseif featureType == DormFightConst.FeatureEnum.InputController then
    res = require("Game.Fight.Character.Feature.DormFightInputController").New()
  elseif featureType == DormFightConst.FeatureEnum.AiController then
    res = require("Game.Fight.Character.Feature.DormFightAiController").New()
  elseif featureType == DormFightConst.FeatureEnum.SceneUiController then
    res = require("Game.Fight.Character.Feature.DormFightUiController").New()
  end
  return res
end

return FeatureFactory
